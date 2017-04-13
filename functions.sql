CREATE OR REPLACE FUNCTION product(a INTEGER, b INTEGER)
  RETURNS INTEGER AS
  $$
  BEGIN
    RETURN a * b;
  END;
  $$ LANGUAGE plpgsql;

SELECT * FROM product(4,5);

-- create fibonacci function recursive
CREATE OR REPLACE FUNCTION fibo(num_terms INTEGER)
  RETURNS INTEGER AS
  $$
  BEGIN
    IF num_terms < 2 THEN
      RETURN num_terms;
    ELSE
      RETURN fibo(num_terms-2) + fibo(num_terms-1);
    END IF;
  END;
  $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION concatenate(a VARCHAR, b VARCHAR)
  RETURNS VARCHAR AS
  $$
  BEGIN
    RETURN CONCAT(INITCAP(a),INITCAP(b));
  END;
  $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION construct(a VARCHAR, b VARCHAR, c VARCHAR DEFAULT 'pas.org')
  RETURNS VARCHAR AS
  $$
  BEGIN
    RETURN CONCAT(LOWER(SUBSTRING (a, 1,1)), LOWER(b), '@', c);
  END;
  $$ LANGUAGE plpgsql;

SELECT * FROM construct ('Annshine', 'Wu');
SELECT * FROM construct('Alex', 'Tai', 'has.org');

CREATE OR REPLACE FUNCTION myMIMO(a INTEGER, b INTEGER, c INTEGER,
    OUT total INTEGER, OUT maxi INTEGER) AS
  $$
  BEGIN
    total := a + b + c;
    maxi := greatest(a, b, c);
  END;
  $$ LANGUAGE plpgsql;

SELECT * FROM myMIMO (2,4,5);

CREATE OR REPLACE FUNCTION getName(firstName VARCHAR, email VARCHAR,
    OUT domain VARCHAR, OUT lastName VARCHAR, OUT firstNameO VARCHAR) AS
  $$
  BEGIN
    domain := substr(email, strpos(email, '@')+1, char_length(email));
    lastName := INITCAP(substr(email, 2, strpos(email, '@')-2));
    firstNameO := INITCAP(firstName);
  END;
  $$ LANGUAGE plpgsql;

SELECT * FROM getName('annshine', construct('annshine', 'wu'));

-- average and total

CREATE OR REPLACE FUNCTION Ave_Total(Variadic inputs NUMERIC [], OUT total INTEGER, OUT average FLOAT) AS
  $$
  DECLARE
    r INTEGER;
  BEGIN
    total := 0;
    average := 0;
    FOR r IN SELECT unnest(inputs)
    LOOP
      RAISE NOTICE' %', r;
      total := total + r;
      average := average + 1;
    END LOOP;
    average := total / average;
  END;
  $$ LANGUAGE plpgsql;

SELECT * FROM Ave_total(12,15,1,7,8,8,8);

CREATE OR REPLACE FUNCTION get_staff(city_pattern VARCHAR) RETURNS TABLE (Name TEXT, Age INT) AS
  $$
  BEGIN
  RETURN QUERY SELECT upper(COMPANY.NAME), COMPANY.AGE
      FROM COMPANY WHERE COMPANY.ADDRESS LIKE city_pattern;
  END;
  $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION loop1(x INTEGER) RETURNS VOID AS
$$
BEGIN
 FOR counter IN 1..x LOOP
   RAISE NOTICE 'Counter value is: %', counter;
 END LOOP;
END;
$$LANGUAGE plpgsql;

SELECT loop1(10);

CREATE OR REPLACE FUNCTION loop2(x INTEGER) RETURNS VOID AS
$$
BEGIN
 FOR counter IN REVERSE x..1 LOOP
   RAISE NOTICE 'Counter value is: %', counter;
 END LOOP;
END;
$$LANGUAGE plpgsql;

SELECT loop2(10);

CREATE OR REPLACE FUNCTION loop3(x INTEGER) RETURNS VOID AS
$$
BEGIN
 FOR counter IN 1..x  LOOP
   IF counter % 2 = 0 THEN
    RAISE NOTICE 'even number: %', counter;
   END IF;
 END LOOP;
END;
$$LANGUAGE plpgsql;
SELECT loop3(10);

-- CREATE FUNCTION namesLoop(n INTEGER DEFAULT 10) RETURNS VOID AS
-- $$
-- DECLARE
--    name TEXT;
-- BEGIN
--    FOR name IN SELECT company.name
--        FROM company
--        ORDER BY company.name
--        LIMIT n
--    LOOP
--      RAISE NOTICE '%', name;
--    END LOOP;
-- END;
-- $$LANGUAGE plpgsql;

CREATE TABLE domain(
  domainId INT PRIMARY KEY,
  sufix VARCHAR(40)
);

CREATE TABLE category(
  categoryId INT PRIMARY KEY,
  name VARCHAR(40),
  domainId INT,
  FOREIGN KEY (domainId) REFERENCES domain(domainId)
);

CREATE TABLE individual(
  id SERIAL PRIMARY KEY,
  firstName VARCHAR(40),
  lastName VARCHAR(40),
  categoryId INT,
  email VARCHAR(40),
  created TIMESTAMP,
  FOREIGN KEY (categoryId) REFERENCES category(categoryId)
);

CREATE TABLE scores(
  scoreId SERIAL PRIMARY KEY,
  studentId INT,
  score INT,
  scoreLetter VARCHAR(40),
  date DATE,
  FOREIGN KEY(studentId) REFERENCES individual(id)
);

CREATE OR REPLACE FUNCTION newEmail(a VARCHAR, b VARCHAR, c VARCHAR)
  RETURNS VARCHAR AS
  $$
  BEGIN
    RETURN CONCAT(LOWER(SUBSTRING (a, 1,1)), LOWER(b), '@', c, '.pas.org');
  END;
  $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION newPerson(first VARCHAR, last VARCHAR, categoryName VARCHAR)
  RETURNS TABLE (
    individualId INT,
    firstname VARCHAR(40),
    lastname VARCHAR(40),
    email VARCHAR(40),
    created TIMESTAMP) AS
  $$
  DECLARE
    category_id INTEGER;
    email VARCHAR;
  BEGIN
    SELECT categoryId INTO category_id FROM category WHERE name = categoryName;
    SELECT * INTO email FROM newEmail(first, last, categoryName);
    INSERT INTO individual (firstName, lastName, categoryId, email, created) VALUES (first, last, category_id, email, CURRENT_TIMESTAMP);
    RETURN QUERY SELECT individual.id, individual.firstName, individual.lastName, individual.email, individual.created FROM individual WHERE individual.firstName = first AND individual.lastName = last;
  END;
  $$ LANGUAGE plpgsql;

INSERT INTO domain (domainId, sufix) VALUES (1, 'student.pas.org');
INSERT INTO domain (domainId, sufix) VALUES (2, 'teacher.pas.org');

INSERT INTO category (categoryId, name, domainId) VALUES (1, 'student', 1);

SELECT * FROM newPerson('Joseph','Tai', 'student');

CREATE OR REPLACE FUNCTION getLetter(grade FLOAT)
  RETURNS VARCHAR AS
  $$
  BEGIN
  IF grade >= 98 THEN
    RETURN 'A+';
  END IF;
  IF grade >= 93 THEN
    RETURN 'A';
  END IF;
  IF grade >= 90 THEN
    RETURN 'A-';
  END IF;
  IF grade >= 88 THEN
    RETURN 'B+';
  END IF;
  IF grade >= 83 THEN
    RETURN 'B';
  END IF;
  IF grade >= 80 THEN
    RETURN 'B-';
  END IF;
  IF grade >= 78 THEN
    RETURN 'C+';
  END IF;
  IF grade >= 73 THEN
    RETURN 'C';
  END IF;
  IF grade >= 70 THEN
    RETURN 'C-';
  END IF;
  IF grade >= 68 THEN
    RETURN 'D+';
  END IF;
  IF grade >= 63 THEN
    RETURN 'D';
  END IF;
  IF grade >= 60 THEN
    RETURN 'D-';
  ELSE
    RETURN 'F';
  END IF;
  END;
  $$ LANGUAGE plpgsql;

SELECT * FROM getLetter(100);
SELECT * FROM getLetter(50);

-- SELECT insertMulGrades(1, ‘9/4/2017’, 80, 70, 81)

CREATE OR REPLACE FUNCTION insertMulGrades(studentId INTEGER, date DATE, Variadic inputs NUMERIC []) RETURNS VOID AS
  $$
  DECLARE
    r INTEGER;
  BEGIN
    FOR r IN SELECT unnest(inputs)
    LOOP
      INSERT INTO scores (studentId, score, scoreLetter, date) VALUES (studentID, r, getLetter(r), date);
    END LOOP;
    RAISE NOTICE 'Operation successful';
  END;
  $$ LANGUAGE plpgsql;

SELECT * FROM individual;

SELECT insertMulGrades(1, '9/4/2017', 80, 70, 81,90);

SELECT * FROM scores;

CREATE OR REPLACE FUNCTION meanValue(id INTEGER, date DATE, VARIADIC inputs NUMERIC[])
  RETURNS INTEGER AS
  $$
  DECLARE
    sum INTEGER; -- sum of all numbers
    cnt INTEGER; -- counter of all numbers
    num INTEGER; -- each number
  BEGIN
    cnt := 0;
    sum := 0;
    FOR num IN SELECT unnest(inputs)
      LOOP
        cnt:= cnt +1;
        sum:= sum + num;
    END LOOP;
    RAISE NOTICE 'The id is %, the date %, average is %', id, date, sum/cnt;
    RETURN sum/cnt;
  END;
  $$ LANGUAGE plpgsql;

SELECT * FROM meanValue (1, '17/04/2017', 50, 20, 50, 80, 40 ,70, 20 ,1);

CREATE OR REPLACE FUNCTION average(idA INTEGER, limited DATE) RETURNS TABLE (name VARCHAR, letterGrade VARCHAR) AS
  $$
  DECLARE
    avg FLOAT;
    first VARCHAR;
    last VARCHAR;
  BEGIN
    avg := (SELECT avg(score) FROM scores WHERE studentId = idA AND date <= limited);
    letterGrade := getLetter(avg);
    SELECT firstName INTO first FROM individual WHERE individual.id = idA;
    SELECT lastName INTO last FROM individual WHERE individual.id = idA;
    name := CONCAT(first, ' ', last);
    RETURN QUERY SELECT name, letterGrade;
  END;
  $$ LANGUAGE plpgsql;

SELECT * FROM average(1, '9/4/2017');

CREATE OR REPLACE FUNCTION curve(VARIADIC inputs NUMERIC[]) RETURNS FLOAT AS
  $$
  DECLARE
    sum FLOAT;
    count INTEGER;
    num INTEGER;
  BEGIN
    count := 0;
    sum := 0;
    FOR num IN SELECT unnest(inputs)
      LOOP
      IF (num >= 60) THEN
        count := count + 1;
        sum := sum + num;
      END IF;
    END LOOP;
    RETURN (85- (sum / count));
  END;
  $$ LANGUAGE plpgsql;

SELECT * FROM curve(50, 50, 50, 75, 90);

