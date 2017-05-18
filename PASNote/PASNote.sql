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
  birthday VARCHAR(40),
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
INSERT INTO course VALUES (5, 'SQL');
INSERT INTO course VALUES (6, 'Python');
INSERT INTO course VALUES (7, 'Pre-Calculus');
INSERT INTO course VALUES (8, 'Calculus');
INSERT INTO course VALUES (9, 'Chemistry');
INSERT INTO course VALUES (10, 'Robotics');
INSERT INTO course VALUES (11, 'Studyhall');

CREATE TABLE IF NOT EXISTS courseList(
  courseID INT,
  studentID INT,
  FOREIGN KEY(courseID) REFERENCES course (courseID),
  FOREIGN KEY(studentID) REFERENCES users(userID)
);

SELECT * FROM users;
SELECT * FROM courseList;
SELECT * FROM profile;

INSERT INTO profile (userID, password, birthday, contactEmail, activity, university, major) VALUES (1, '1234','4/17/2002','a','a','a','a');
INSERT INTO courseList (courseID, studentID) VALUES (1,1);
INSERT INTO courseList (courseID, studentID) VALUES (2,1);
INSERT INTO courseList (courseID, studentID) VALUES (3,1);


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
