CREATE TABLE area (
    course_id BIGINT,
    area TEXT
);


CREATE TABLE comment_instructor (
    instructor_id BIGINT DEFAULT '0' NOT NULL,
    student_id BIGINT DEFAULT '0' NOT NULL,
    score BIGINT,
    comment_text TEXT
);


CREATE TABLE course (
    course_id BIGINT DEFAULT '0' NOT NULL,
    name TEXT,
    department TEXT,
    number TEXT,
    credits TEXT,
    advisory_requirement TEXT,
    enforced_requirement TEXT,
    description TEXT,
    num_semesters BIGINT,
    num_enrolled BIGINT,
    has_discussion TINYINT(1),
    has_lab TINYINT(1),
    has_projects TINYINT(1),
    has_exams TINYINT(1),
    num_reviews BIGINT,
    clarity_score BIGINT,
    easiness_score BIGINT,
    helpfulness_score BIGINT
);


CREATE TABLE course_offering (
    offering_id BIGINT DEFAULT '0' NOT NULL,
    course_id BIGINT,
    semester BIGINT,
    section_number BIGINT,
    start_time time,
    end_time time,
    monday TEXT,
    tuesday TEXT,
    wednesday TEXT,
    thursday TEXT,
    friday TEXT,
    saturday TEXT,
    sunday TEXT,
    has_final_project TINYINT(1),
    has_final_exam TINYINT(1),
    textbook TEXT,
    class_address TEXT,
    allow_audit TEXT DEFAULT 'false'
);


CREATE TABLE course_prerequisite (
    pre_course_id BIGINT NOT NULL,
    course_id BIGINT NOT NULL
);


CREATE TABLE course_tags_count (
    course_id BIGINT DEFAULT '0' NOT NULL,
    clear_grading BIGINT DEFAULT '0',
    pop_quiz BIGINT DEFAULT '0',
    group_projects BIGINT DEFAULT '0',
    inspirational BIGINT DEFAULT '0',
    long_lectures BIGINT DEFAULT '0',
    extra_credit BIGINT DEFAULT '0',
    few_tests BIGINT DEFAULT '0',
    good_feedback BIGINT DEFAULT '0',
    tough_tests BIGINT DEFAULT '0',
    heavy_papers BIGINT DEFAULT '0',
    cares_for_students BIGINT DEFAULT '0',
    heavy_assignments BIGINT DEFAULT '0',
    respected BIGINT DEFAULT '0',
    participation BIGINT DEFAULT '0',
    heavy_reading BIGINT DEFAULT '0',
    tough_grader BIGINT DEFAULT '0',
    hilarious BIGINT DEFAULT '0',
    would_take_again BIGINT DEFAULT '0',
    good_lecture BIGINT DEFAULT '0',
    no_skip BIGINT DEFAULT '0'
);


CREATE TABLE instructor (
    instructor_id BIGINT DEFAULT '0' NOT NULL,
    name TEXT,
    uniqname TEXT
);


CREATE TABLE offering_instructor (
    offering_instructor_id BIGINT DEFAULT '0' NOT NULL,
    offering_id BIGINT,
    instructor_id BIGINT
);


CREATE TABLE program (
    program_id BIGINT NOT NULL,
    name TEXT,
    college TEXT,
    introduction TEXT
);


CREATE TABLE program_course (
    program_id BIGINT DEFAULT '0' NOT NULL,
    course_id BIGINT DEFAULT '0' NOT NULL,
    workload BIGINT,
    category TEXT DEFAULT '' NOT NULL
);


CREATE TABLE program_requirement (
    program_id BIGINT NOT NULL,
    category TEXT NOT NULL,
    min_credit BIGINT,
    additional_req TEXT
);


CREATE TABLE semester (
    semester_id BIGINT NOT NULL,
    semester TEXT,
    year BIGINT
);


CREATE TABLE student (
    student_id BIGINT NOT NULL,
    lastname TEXT,
    firstname TEXT,
    program_id BIGINT,
    declare_major TEXT,
    total_credit BIGINT,
    total_gpa numeric,
    entered_as TEXT DEFAULT 'firstyear',
    admit_term date,
    predicted_graduation_semester date,
    degree TEXT,
    minor TEXT,
    internship TEXT
);


CREATE TABLE student_record (
    student_id BIGINT NOT NULL,
    course_id BIGINT NOT NULL,
    semester BIGINT NOT NULL,
    grade TEXT,
    how TEXT,
    transfer_source TEXT,
    earn_credit TEXT DEFAULT 'y' NOT NULL,
    repeat_term TEXT,
    test_id TEXT,
    offering_id BIGINT
);


INSERT INTO area (course_id, area) VALUES
(1, 'Computer Science'),
(2, 'Mathematics'),
(3, 'Physics'),
(4, 'Computer Science')
;

INSERT INTO comment_instructor (instructor_id, student_id, score, comment_text) VALUES
(1, 1, 5, 'John Smith is a great instructor.'),
(2, 2, 4, 'Jane Doe explains concepts clearly.')
;

INSERT INTO course (course_id, name, department, number, credits, advisory_requirement, enforced_requirement, description, num_semesters, num_enrolled, has_discussion, has_lab, has_projects, has_exams, num_reviews, clarity_score, easiness_score, helpfulness_score) VALUES
(1, 'Introduction to Computer Science', 'Computer Science', 'CS101', '3', NULL, NULL, 'This course introduces the basics of computer science.', 2, 3, true, false, true, false, 10, 5, 3, 4),
(2, 'Advanced Calculus', 'Mathematics', 'MATH201', '4', 'CS101', NULL, 'This course covers advanced topics in calculus.', 1, 5, false, false, true, true, 5, 4, 2, 3),
(3, 'Introduction to Physics', 'Physics', 'PHYS101', '3', NULL, 'MATH201', 'This course provides an introduction to physics principles.', 2, 1, true, true, true, true, 8, 4, 3, 5),
(4, 'Distributed Databases', 'Computer Science', 'CS302', '3', NULL, 'CS101', 'This course provides an introduction to distributed databases.', 2, 3, true, true, false, true, 4, 2, 1, 5)
;

INSERT INTO course_offering (offering_id, course_id, semester, section_number, start_time, end_time, monday, tuesday, wednesday, thursday, friday, saturday, sunday, has_final_project, has_final_exam, textbook, class_address, allow_audit) VALUES
(1, 1, 1, 1, '08:00:00', '10:00:00', 'John Smith', NULL, NULL, 'Jane Doe', NULL, NULL, NULL, true, false, 'Introduction to Computer Science', '123 Main St', 'true'),
(2, 2, 1, 1, '10:00:00', '12:00:00', NULL, NULL, 'Gilbert Strang', NULL, NULL, NULL, NULL, true, true, 'Advanced Calculus', '456 Elm St', 'false'),
(3, 3, 2, 1, '08:00:00', '10:00:00', 'John Smith', NULL, NULL, 'Jane Doe', NULL, NULL, NULL, false, true, 'Introduction to Physics', '789 Oak St', 'true'),
(4, 4, 2, 1, '16:00:00', '18:00:00', NULL, NULL, 'John Smith', 'Brendan Burns', NULL, NULL, NULL, false, true, 'Distributed Systems', '789 Oak St', 'true'),
(5, 1, 3, 1, '08:00:00', '10:00:00', NULL, 'John Smith', 'Jane Doe', NULL, NULL, NULL, NULL, true, false, 'Introduction to Computer Science', '123 Main St', 'true'),
(6, 2, 3, 1, '10:00:00', '12:00:00', 'Gilbert Strang', NULL, NULL, NULL, NULL, NULL, NULL, true, true, 'Advanced Calculus', '456 Elm St', 'false'),
(7, 3, 4, 1, '14:00:00', '16:00:00', NULL, NULL, 'Jane Doe', NULL, 'John Smith', NULL, NULL, false, true, 'Introduction to Physics', '789 Oak St', 'true'),
(8, 4, 4, 1, '16:00:00', '18:00:00', NULL, NULL, 'John Smith', NULL, 'Brendan Burns', NULL, NULL, false, true, 'Distributed Systems', '789 Oak St', 'true')
;

INSERT INTO course_prerequisite (pre_course_id, course_id) VALUES
(1, 2),
(2, 3)
;

INSERT INTO course_tags_count (course_id, clear_grading, pop_quiz, group_projects, inspirational, long_lectures, extra_credit, few_tests, good_feedback, tough_tests, heavy_papers, cares_for_students, heavy_assignments, respected, participation, heavy_reading, tough_grader, hilarious, would_take_again, good_lecture, no_skip) VALUES
(1, 5, 2, 3, 4, 2, 1, 3, 4, 2, 1, 5, 3, 4, 2, 1, 5, 3, 4, 2, NULL),
(2, 4, 1, 2, 3, 1, 2, 2, 3, 1, 2, 4, 2, 3, 1, 2, 4, 2, 3, 1, NULL),
(3, 3, 2, 1, 2, 3, 1, 1, 2, 3, 1, 3, 1, 2, 3, 1, 3, 1, 2, 3, NULL),
(4, 2, 3, 0, 2, 3, 1, 1, 2, 3, 0, 3, 4, 2, 3, 5, 3, 1, 2, 3, NULL)
;


INSERT INTO instructor (instructor_id, name, uniqname) VALUES
(1, 'John Smith', 'jsmith'),
(2, 'Jane Doe', 'jdoe'),
(3, 'Gilbert Strang', 'gstrang'),
(4, 'Brendan Burns', 'bburns')
;

INSERT INTO offering_instructor (offering_instructor_id, offering_id, instructor_id) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 3),
(4, 3, 1),
(5, 3, 2),
(6, 4, 1),
(7, 4, 4),
(8, 5, 1),
(9, 5, 2),
(10, 6, 3),
(11, 7, 2),
(12, 7, 1),
(13, 8, 1),
(14, 8, 4)
;

INSERT INTO program (program_id, name, college, introduction) VALUES
(1, 'Computer Science', 'Engineering', 'This program focuses on computer science principles and applications.'),
(2, 'Mathematics', 'Arts and Sciences', 'This program provides a comprehensive study of mathematical concepts and theories.'),
(3, 'Physics', 'Arts and Sciences', 'This program explores the fundamental principles of physics and their applications.')
;

INSERT INTO program_course (program_id, course_id, workload, category) VALUES
(1, 1, 100, 'Core'),
(1, 4, 80, 'Elective'),
(2, 2, 90, 'Core'),
(3, 3, 70, 'Core')
;

INSERT INTO program_requirement (program_id, category, min_credit, additional_req) VALUES
(1, 'Core', 120, NULL),
(2, 'Core', 90, NULL),
(3, 'Core', 200, NULL)
;

INSERT INTO semester (semester_id, semester, year) VALUES
(1, 'Fall', 2020),
(2, 'Spring', 2021),
(3, 'Summer', 2021),
(4, 'Fall', 2021)
;

INSERT INTO student (student_id, lastname, firstname, program_id, declare_major, total_credit, total_gpa, entered_as, admit_term, predicted_graduation_semester, degree, minor, internship) VALUES
(1, 'Smith', 'John', 1, 'Computer Science', 13, 3.5, 'Freshman','2018-01-01', '2022-05-01', 'Bachelor of Science', NULL, NULL),
(2, 'Doe', 'Jane', 1, 'Computer Science', 7, 3.2, 'Freshman', '2018-01-01', '2022-05-01', 'Bachelor of Science', NULL, NULL),
(3, 'Johnson', 'David', 2, 'Mathematics', 7, 3.6, 'Freshman', '2019-01-01', '2022-05-01', 'Bachelor of Arts', 'Mathematics', NULL),
(4, 'Brown', 'Sarah', 3, 'Physics', 7, 3.8, 'Freshman', CURRENT_DATE - INTERVAL '15 years', CURRENT_DATE - INTERVAL '11 years', 'Bachelor of Science', 'Physics', NULL),
(5, 'Wilson', 'Michael', 1, 'Computer Science', 7, 3.2, 'Freshman', CURRENT_DATE - INTERVAL '13 years', CURRENT_DATE - INTERVAL '9 years', 'Bachelor of Science', NULL, NULL)
;

INSERT INTO student_record (student_id, course_id, semester, grade, how, transfer_source, earn_credit, repeat_term, test_id, offering_id) VALUES
(1, 1, 1, 'A', 'in-person', NULL, 'Yes', NULL, '1', 1),
(1, 2, 1, 'A', 'in-person', NULL, 'Yes', NULL, '1', 2),
(1, 3, 2, 'A', 'in-person', NULL, 'Yes', NULL, '1', 3),
(1, 4, 2, 'A', 'in-person', NULL, 'Yes', NULL, '1', 4),
(2, 2, 1, 'C', 'in-person', NULL, 'Yes', NULL, '1', 2),
(2, 1, 1, 'B', 'online', NULL, 'Yes', NULL, '1', 1),
(3, 2, 1, 'B+', 'in-person', NULL, 'Yes', NULL, '1', 2),
(3, 4, 2, 'B+', 'in-person', NULL, 'Yes', NULL, '1', 4),
(4, 2, 1, 'C', 'in-person', NULL, 'Yes', NULL, '1', 2),
(4, 1, 1, 'B', 'online', NULL, 'Yes', NULL, '1', 1),
(5, 2, 1, 'B+', 'in-person', NULL, 'Yes', NULL, '1', 2),
(5, 4, 2, 'B+', 'in-person', NULL, 'Yes', NULL, '1', 4)
;
