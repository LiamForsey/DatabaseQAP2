-- Problem One: University Enrollment --

-- Liam Forsey, October 15th, 2024 --

-- Creating The Tables: --


-- Student Table --
CREATE TABLE IF NOT EXISTS students (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    enrollment_date DATE NOT NULL
);

-- Professors Table --
CREATE TABLE IF NOT EXISTS professors (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    department VARCHAR(100) NOT NULL
);

-- Courses Table --
CREATE TABLE IF NOT EXISTS courses (
    id SERIAL PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    course_description TEXT NOT NULL,
    professor_id INTEGER NOT NULL,
    FOREIGN KEY (professor_id) REFERENCES professors(id)
);

-- Enrollments Table --
CREATE TABLE IF NOT EXISTS enrollments (
    student_id INTEGER NOT NULL,
    course_id INTEGER NOT NULL,
    enrollment_date DATE NOT NULL,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);


-- Adding Data To Tables --

-- Insert data into the STUDENTS table
INSERT INTO students (first_name, last_name, email, enrollment_date) VALUES
('Max', 'Powers', 'Max.Powers@universitymail.com', '2024-01-15'),
('Luna', 'Raye', 'Luna.Raye@universitymail.com', '2024-03-22'),
('Leo', 'King', 'Leo.King@universitymail.com', '2024-06-10'),
('Zara', 'Grove', 'Zara.Grove@universitymail.com', '2024-08-05'),
('Eli', 'Starr', 'Eli.Starr@universitymail.com', '2024-09-12');

-- Insert data into the PROFESSORS table
INSERT INTO professors (first_name, last_name, department) VALUES
('Rita', 'Sparks', 'Mathematics'),
('Paul', 'Teller', 'Physics'),
('Nina', 'Grant', 'Biology'),
('Owen', 'Field', 'Literature');

-- Insert data into the COURSES table
INSERT INTO courses (course_name, course_description, professor_id) VALUES
('Calculus I', 'Introduction to differential calculus.', 1),
('Physics Fundamentals', 'Basics of classical physics.', 2),
('Biological Systems', 'Study of living organisms.', 3),
('Literature Analysis', 'Understanding literary texts.', 4);

-- Insert data into the ENROLLMENTS table
INSERT INTO enrollments (student_id, course_id, enrollment_date) VALUES
(1, 1, '2024-01-15'),  -- Max Powers enrolls in Calculus I
(1, 2, '2024-01-15'),  -- Max Powers enrolls in Physics Fundamentals
(2, 1, '2024-03-22'),  -- Luna Raye enrolls in Calculus I
(3, 3, '2024-06-10'),  -- Leo King enrolls in Biological Systems
(4, 2, '2024-08-05');  -- Zara Grove enrolls in Physics Fundamentals



-- QUERY TASKS --


-- 1. Retrieve Full Names of Students Enrolled in "Physics Fundamentals"
SELECT
    s.first_name || ' ' || s.last_name AS full_name
FROM
    students s
JOIN
    enrollments e ON s.id = e.student_id
JOIN
    courses c ON e.course_id = c.id
WHERE
    c.course_name = 'Physics Fundamentals';

-- 2. Retrieve Courses with Professor's Full Names
SELECT
    c.course_name,
    p.first_name || ' ' || p.last_name AS professor_full_name
FROM
    courses c
JOIN
    professors p ON c.professor_id = p.id;

-- 3. Retrieve Courses with Enrolled Students
SELECT DISTINCT
    c.course_name
FROM
    courses c
JOIN
    enrollments e ON c.id = e.course_id;


-- Update a student's email
UPDATE students
SET email = 'Max.Powers@newmail.com'
WHERE id = 1;

-- Verify the update
SELECT * FROM students WHERE id = 1;


-- Delete the enrollment record for Max Powers in Physics Fundamentals
DELETE FROM enrollments
WHERE student_id = 1 AND course_id = 2;

-- Verify the deletion
SELECT
    e.student_id,
    s.first_name || ' ' || s.last_name AS student_name,
    e.course_id,
    c.course_name,
    e.enrollment_date
FROM
    enrollments e
JOIN
    students s ON e.student_id = s.id
JOIN
    courses c ON e.course_id = c.id
WHERE
    e.student_id = 1 AND e.course_id = 2;

-- View all remaining enrollments
SELECT
    e.student_id,
    s.first_name || ' ' || s.last_name AS student_name,
    e.course_id,
    c.course_name,
    e.enrollment_date
FROM
    enrollments e
JOIN
    students s ON e.student_id = s.id
JOIN
    courses c ON e.course_id = c.id
ORDER BY
    e.student_id;