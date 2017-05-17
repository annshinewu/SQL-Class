CREATE TABLE IF NOT EXISTS category(
  categoryID INT PRIMARY KEY,
  categoryName VARCHAR(40)
);

CREATE TABLE IF NOT EXISTS users(
  userID SERIAL PRIMARY KEY,
  username VARCHAR(40),
  password VARCHAR(40),
  categoryID INT,
  FOREIGN KEY(categoryID) REFERENCES category(categoryID)
);

CREATE TABLE IF NOT EXISTS profile(
  profileID SERIAL PRIMARY KEY,
  userID INT,
  password VARCHAR(40),
  birthday DATE,
  contactEmail VARCHAR(40),
  activity VARCHAR(40),
  university VARCHAR(40),
  major VARCHAR(40),
  FOREIGN KEY(userID) REFERENCES users(userID)
);

INSERT INTO category (categoryID, categoryName) VALUES (1, 'Student');
INSERT INTO category (categoryID, categoryName) VALUES (2, 'Teacher');
INSERT INTO category (categoryID, categoryName) VALUES (3, 'STUCO');
INSERT INTO category (categoryID, categoryName) VALUES (4, 'Pamela');
INSERT INTO category (categoryID, categoryName) VALUES (5, 'School');

CREATE TABLE IF NOT EXISTS course(
  courseID SERIAL PRIMARY KEY,
  courseName VARCHAR(40)
);

INSERT INTO course VALUES (1, 'American Literature');
INSERT INTO course VALUES (2, 'World Literature');
INSERT INTO course VALUES (3, 'AP Statistics');
INSERT INTO course VALUES (4, 'Physics');

CREATE TABLE IF NOT EXISTS courseList(
  courseID INT,
  studentID INT
);

SELECT * FROM users;

CREATE OR REPLACE FUNCTION registerStudents(Variadic inputs VARCHAR []) RETURNS VOID AS
  $$
  DECLARE
    r TEXT;
    pass INTEGER;
  BEGIN
    FOR r IN SELECT unnest(inputs)
    LOOP
      pass := ROUND(RANDOM()*1000);
      INSERT INTO users (username, password, categoryID) VALUES (r, pass, 1);
    END LOOP;
  END;
  $$ LANGUAGE plpgsql;

SELECT * FROM registerStudents('annshinewu', 'andrewyeh', 'sabrinaho');
