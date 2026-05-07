CREATE DATABASE FOT_Academic_Management_DB;
USE FOT_Academic_Management_DB;

-- =========================================================================
-- FOT ACADEMIC MANAGEMENT SYSTEM - FULL TABLE CREATION SCRIPT
-- =========================================================================

-- -------------------------------------------------------------------------
-- STEP 1: BASE TABLES (No Foreign Keys)
-- -------------------------------------------------------------------------

-- Created by: Nirmal (TG2097)
CREATE TABLE PERSON (
    Person_ID     VARCHAR(20) PRIMARY KEY,
    F_Name        VARCHAR(50)  NOT NULL,
    L_Name        VARCHAR(50)  NOT NULL,
    NIC           VARCHAR(20)  NOT NULL UNIQUE,
    Gender        ENUM('Male', 'Female', 'Other') NOT NULL,
    DOB           DATE         NOT NULL,
    Phone_No      VARCHAR(15),
    Address       VARCHAR(255)
);

-- Created by: Samindi (TG2112)
CREATE TABLE DEPARTMENT(
    Department_ID VARCHAR(20) PRIMARY KEY NOT NULL ,
    Department_Name VARCHAR(100) NOT NULL,
    Office_Phone INT(11),
    Email VARCHAR(100),
    Hod_Name VARCHAR(100)
);

-- Created by: Samindi (TG2112)
CREATE TABLE SEMESTER(
    Semester_ID VARCHAR(20) PRIMARY KEY NOT NULL ,
    Academic_Year YEAR,
    Semester_No INT(5),
    Start_Date DATE,
    End_Date DATE
);

-- Created by: Hasaranga (TG2095)
CREATE TABLE ASSESSMENT_TYPE (
    Assessment_Type_ID VARCHAR(20) PRIMARY KEY,
    Assessment_Name VARCHAR(50)
);

-- Created by: Hasaranga (TG2095)
CREATE TABLE GRADE_SCALE (
    Grade_ID VARCHAR(20) PRIMARY KEY,
    min_mark INT,
    max_mark INT,
    grade_point DECIMAL(3,2),
    letter_grade VARCHAR(5)
);

-- -------------------------------------------------------------------------
-- STEP 2: LEVEL 1 DEPENDENCIES
-- -------------------------------------------------------------------------

-- Created by: Nirmal (TG2097)
CREATE TABLE STAFF (
    Staff_ID        VARCHAR(20) NOT NULL,
    Person_ID       VARCHAR(20) NOT NULL,
    staff_no        VARCHAR(20) NOT NULL UNIQUE,
    hire_date       DATE        NOT NULL,
    Department_ID   VARCHAR(20) NOT NULL,
    PRIMARY KEY (Staff_ID),
    FOREIGN KEY (Person_ID)     REFERENCES PERSON(Person_ID),
    FOREIGN KEY (Department_ID) REFERENCES DEPARTMENT(Department_ID)
);

-- Created by: Nirmal (TG2097)
CREATE TABLE STUDENT (
    Student_ID    VARCHAR(20) NOT NULL,
    Person_ID     VARCHAR(20) NOT NULL,
    Reg_no        VARCHAR(20) NOT NULL UNIQUE,
    Department_ID VARCHAR(20) NOT NULL,
    Intake_Year   INT         NOT NULL,
    Batch         VARCHAR(20) NOT NULL,
    Status        VARCHAR(20),
    PRIMARY KEY (Student_ID),
    FOREIGN KEY (Person_ID)     REFERENCES PERSON(Person_ID),
    FOREIGN KEY (Department_ID) REFERENCES DEPARTMENT(Department_ID)
);

-- Created by: Nirmal (TG2097)
CREATE TABLE USER_ACCOUNT (
    Account_ID     VARCHAR(20)  NOT NULL,
    Person_ID      VARCHAR(20)  NOT NULL,
    UserName       VARCHAR(50)  NOT NULL UNIQUE,
    Password       VARCHAR(255) NOT NULL,
    account_status VARCHAR(20)  NOT NULL,
    PRIMARY KEY (Account_ID),
    FOREIGN KEY (Person_ID) REFERENCES PERSON(Person_ID)
);

-- Created by: Samindi  (TG2112)
CREATE TABLE COURSE_UNIT(
    Course_ID VARCHAR(20) PRIMARY KEY NOT NULL,
    Course_Code VARCHAR(10) NOT NULL,
    Course_Name VARCHAR(50) NOT NULL,
    Credits INT,
    Course_Type VARCHAR(20),
    Department_ID VARCHAR(20),
    FOREIGN KEY (Department_ID) REFERENCES DEPARTMENT(Department_ID)
);

-- -------------------------------------------------------------------------
-- STEP 3: STAFF ROLES SUBTYPES
-- -------------------------------------------------------------------------

-- Created by: Nirmal (TG2097)
CREATE TABLE ADMIN (
    Staff_ID    VARCHAR(20) NOT NULL,
    Admin_Level VARCHAR(50) NOT NULL,
    PRIMARY KEY (Staff_ID),
    FOREIGN KEY (Staff_ID) REFERENCES STAFF(Staff_ID)
);

-- Created by: Nirmal (TG2097)
CREATE TABLE DEAN (
    Staff_ID        VARCHAR(20) NOT NULL,
    Appointed_Date  DATE        NOT NULL,
    PRIMARY KEY (Staff_ID),
    FOREIGN KEY (Staff_ID) REFERENCES STAFF(Staff_ID)
);

-- Created by: Nirmal (TG2097)
CREATE TABLE LECTURER (
    Staff_ID      VARCHAR(20) NOT NULL,
    Academic_Rank VARCHAR(50) NOT NULL,
    PRIMARY KEY (Staff_ID),
    FOREIGN KEY (Staff_ID) REFERENCES STAFF(Staff_ID)
);

-- Created by: Nirmal (TG2097)
CREATE TABLE TECHNICAL_OFFICER (
    Staff_ID         VARCHAR(20) NOT NULL,
    Specialization   VARCHAR(100) NOT NULL,
    lab_assigned     VARCHAR(100),
    PRIMARY KEY (Staff_ID),
    FOREIGN KEY (Staff_ID) REFERENCES STAFF(Staff_ID)
);

-- -------------------------------------------------------------------------
-- STEP 4: ACADEMIC OFFERINGS
-- -------------------------------------------------------------------------

-- Created by: Hasaranga (TG2095)
CREATE TABLE COURSE_OFFERING (
    Offering_ID VARCHAR(20) PRIMARY KEY NOT NULL,
    Course_ID VARCHAR(20) NOT NULL,
    Lecturer_ID VARCHAR(20) NOT NULL,
    Semester_ID VARCHAR(20) NOT NULL,
    Batch VARCHAR(10),
    active_status BOOLEAN,
    FOREIGN KEY (Course_ID) REFERENCES COURSE_UNIT(Course_ID),
    FOREIGN KEY (Lecturer_ID) REFERENCES LECTURER(Staff_ID),
    FOREIGN KEY (Semester_ID) REFERENCES SEMESTER(Semester_ID)
);

-- Created by: Hasaranga (TG2095)
CREATE TABLE COURSE_COMPONENT (
    Component_ID VARCHAR(20) PRIMARY KEY NOT NULL,
    offering_id VARCHAR(20) NOT NULL,
    component_type VARCHAR(20),
    total_sessions INT,
    total_hours INT,
    FOREIGN KEY (offering_id) REFERENCES COURSE_OFFERING(Offering_ID)
);

-- Created by: Hasaranga (TG2095)
CREATE TABLE ENROLLMENT (
    Enrollment_ID VARCHAR(20) PRIMARY KEY NOT NULL,
    Student_ID VARCHAR(20) NOT NULL,
    Offering_ID VARCHAR(20) NOT NULL,
    enrollment_date DATE,
    attempt_no INT,
    enrollment_status VARCHAR(20),
    FOREIGN KEY (Student_ID) REFERENCES STUDENT(Student_ID),
    FOREIGN KEY (Offering_ID) REFERENCES COURSE_OFFERING(Offering_ID)
);

-- -------------------------------------------------------------------------
-- STEP 5: SESSIONS & GPA
-- -------------------------------------------------------------------------

-- Created by: Samindi  (TG2112)
CREATE TABLE SESSION (
    Session_ID VARCHAR(20) PRIMARY KEY NOT NULL,
    Component_ID VARCHAR(20) NOT NULL,
    session_date DATE,
    week_no INT,
    start_time TIME,
    end_time TIME,
    duration_hours INT,
    FOREIGN KEY (Component_ID) REFERENCES COURSE_COMPONENT(Component_ID)
);

-- Created by: Hasaranga (TG2095)
CREATE TABLE GPA_RECORD (
    gpa_id VARCHAR(20) PRIMARY KEY NOT NULL,
    student_id VARCHAR(20) NOT NULL,
    semester_id VARCHAR(20) NOT NULL,
    sgpa DECIMAL(4,2),
    cgpa DECIMAL(4,2),
    FOREIGN KEY (student_id) REFERENCES STUDENT(Student_ID),
    FOREIGN KEY (semester_id) REFERENCES SEMESTER(Semester_ID)
);

-- -------------------------------------------------------------------------
-- STEP 6: ASSESSMENT SCHEMES & ATTENDANCE
-- -------------------------------------------------------------------------

-- Created by: Hasaranga (TG2095)
CREATE TABLE ASSESSMENT_SCHEME (
    Scheme_ID VARCHAR(20) PRIMARY KEY NOT NULL,
    Offering_ID VARCHAR(20) NOT NULL,
    Assessment_Type_ID VARCHAR(20) NOT NULL,
    Component_ID VARCHAR(20),
    weight_percentage DECIMAL(5,2),
    assessment_no INT,
    max_marks INT,
    is_mandatory BOOLEAN,
    FOREIGN KEY (Offering_ID) REFERENCES COURSE_OFFERING(Offering_ID),
    FOREIGN KEY (Assessment_Type_ID) REFERENCES ASSESSMENT_TYPE(Assessment_Type_ID),
    FOREIGN KEY (Component_ID) REFERENCES COURSE_COMPONENT(Component_ID)
);

-- Created by: Samindi  (TG2112)
CREATE TABLE ATTENDANCE_RECORD (
    Attendance_ID VARCHAR(20) PRIMARY KEY NOT NULL,
    session_id VARCHAR(20) NOT NULL,
    student_id VARCHAR(20) NOT NULL,
    marked_by VARCHAR(20) NOT NULL,
    attendance_status VARCHAR(20),
    marked_date DATE,
    FOREIGN KEY (session_id) REFERENCES SESSION(Session_ID),
    FOREIGN KEY (student_id) REFERENCES STUDENT(Student_ID),
    FOREIGN KEY (marked_by) REFERENCES STAFF(Staff_ID)
);

-- Created by: Samindi  (TG2112)
CREATE TABLE MEDICAL_RECORD (
    Medical_ID VARCHAR(20) PRIMARY KEY NOT NULL,
    Student_ID VARCHAR(20) NOT NULL,
    Session_ID VARCHAR(20) NOT NULL,
    reason VARCHAR(255),
    issued_by VARCHAR(100),
    submitted_date DATE,
    approval_status VARCHAR(20),
    FOREIGN KEY (Student_ID) REFERENCES STUDENT(Student_ID),
    FOREIGN KEY (Session_ID) REFERENCES SESSION(Session_ID)
);

-- -------------------------------------------------------------------------
-- STEP 7: MARKS & FINAL RESULTS
-- -------------------------------------------------------------------------

-- Created by: Hasaranga (TG2095)
CREATE TABLE STUDENT_MARK (
    Mark_ID VARCHAR(20) PRIMARY KEY NOT NULL,
    Student_ID VARCHAR(20) NOT NULL,
    Scheme_ID VARCHAR(20) NOT NULL,
    entered_by VARCHAR(20) NOT NULL,
    raw_mark DECIMAL(5,2),
    mark_status VARCHAR(20),
    entered_date DATE,
    FOREIGN KEY (Student_ID) REFERENCES STUDENT(Student_ID),
    FOREIGN KEY (Scheme_ID) REFERENCES ASSESSMENT_SCHEME(Scheme_ID),
    FOREIGN KEY (entered_by) REFERENCES STAFF(Staff_ID)
);

-- Created by: Hasaranga (TG2095)
CREATE TABLE ELIGIBILITY_RECORD (
    Eligibility_ID VARCHAR(20) PRIMARY KEY NOT NULL,
    Student_ID VARCHAR(20) NOT NULL,
    Offering_ID VARCHAR(20) NOT NULL,
    attendance_percentage DECIMAL(5,2),
    ca_mark DECIMAL(5,2),
    ca_eligibility BOOLEAN,
    final_exam_eligibility BOOLEAN,
    FOREIGN KEY (Student_ID) REFERENCES STUDENT(Student_ID),
    FOREIGN KEY (Offering_ID) REFERENCES COURSE_OFFERING(Offering_ID)
);

-- Created by: Hasaranga (TG2095)
CREATE TABLE FINAL_RESULT (
    Result_ID VARCHAR(20) PRIMARY KEY NOT NULL,
    Student_ID VARCHAR(20) NOT NULL,
    Offering_ID VARCHAR(20) NOT NULL,
    final_mark DECIMAL(5,2),
    letter_grade VARCHAR(5),
    grade_point DECIMAL(3,2),
    result_code VARCHAR(10),
    released_date DATE,
    FOREIGN KEY (Student_ID) REFERENCES STUDENT(Student_ID),
    FOREIGN KEY (Offering_ID) REFERENCES COURSE_OFFERING(Offering_ID)
);

-- =========================================================================
-- DEPARTMENT TABLE DATA INSERTION
-- =========================================================================

INSERT INTO DEPARTMENT (Department_ID, Department_Name, Office_Phone, Email, Hod_Name) VALUES 
('D01', 'Information and Communication Technology', 0412223334, 'hod_ict@fot.ruh.ac.lk', 'Dr. Dinithi'),
('D02', 'Engineering Technology', 0412223335, 'hod_et@fot.ruh.ac.lk', 'Dr. Kamal Silva'),
('D03', 'Biosystems Technology', 0412223336, 'hod_bst@fot.ruh.ac.lk', 'Dr. Nimal Fernando'),
('D04', 'Multidisciplinary Studies', 0412223337, 'hod_mds@fot.ruh.ac.lk', 'Prof. Subash');


-- =========================================================================
-- USER MANAGEMENT MODULE - FULL DATA INSERTION (40 Users)
-- =========================================================================

-- INSERT INTO PERSON (40 People)
INSERT INTO PERSON (Person_ID, F_Name, L_Name, NIC, Gender, DOB, Phone_No, Address) VALUES

-- Admin (1)
('P01', 'Nalin', 'Bandara', '198011111V', 'Male', '1980-01-10', '0771000001', 'Matara'),

-- Dean (1)
('P02', 'Saman', 'Kumara', '197522222V', 'Male', '1975-05-20', '0772000001', 'Galle'),

-- Lecturers (8)
('P03', 'Amali', 'Perera', '198533331V', 'Female', '1985-02-15', '0773000001', 'Colombo'),
('P04', 'Kasun', 'Kalhara', '198633332V', 'Male', '1986-03-15', '0773000002', 'Matara'),
('P05', 'Ruwan', 'Pathirana', '198733333V', 'Male', '1987-04-15', '0773000003', 'Galle'),
('P06', 'Nuwan', 'Pradeep', '198833334V', 'Male', '1988-05-15', '0773000004', 'Tangalle'),
('P07', 'Sanduni', 'Silva', '198933335V', 'Female', '1989-06-15', '0773000005', 'Colombo'),
('P08', 'Gayan', 'Madushanka', '199033336V', 'Male', '1990-07-15', '0773000006', 'Matara'),
('P09', 'Chathurika', 'Peiris', '199133337V', 'Female', '1991-08-15', '0773000007', 'Galle'),
('P10', 'Nilantha', 'Jayasooriya', '199233338V', 'Male', '1992-09-15', '0773000008', 'Kandy'),


-- Technical Officers (5)
('P11', 'Kamal', 'Hasantha', '199044441V', 'Male', '1990-10-10', '0774000001', 'Galle'),
('P12', 'Sunil', 'Shantha', '199144442V', 'Male', '1991-11-10', '0774000002', 'Matara'),
('P13', 'Nayana', 'Kumari', '199244443V', 'Female', '1992-12-10', '0774000003', 'Tangalle'),
('P14', 'Jagath', 'Kumara', '199344444V', 'Male', '1993-01-10', '0774000004', 'Colombo'),
('P15', 'Sujeewa', 'Priyanthi', '199444445V', 'Female', '1994-02-10', '0774000005', 'Galle'),


-- Proper Students (20) - Including Team Members
('P16', 'Hasaranga', 'Kariyawasam', '200455551V', 'Male', '2004-08-19', '0705000001', 'Colombo'),
('P17', 'Himansana', 'NVS', '200455552V', 'Male', '2004-01-01', '0705000002', 'Galle'),
('P18', 'Nirmal', 'IDNS', '200455553V', 'Male', '2004-02-02', '0705000003', 'Matara'),
('P19', 'Sarathchandra', 'GMS', '200455554V', 'Male', '2004-03-03', '0705000004', 'Tangalle'),
('P20', 'Samindi', 'P', '200455555V', 'Female', '2004-04-04', '0705000005', 'Galle'),
('P21', 'Kalinga', 'Pelpola', '200455556V', 'Male', '2004-05-05', '0705000006', 'Colombo'),
('P22', 'Pavan', 'Epa', '200455557V', 'Male', '2004-06-06', '0705000007', 'Kandy'),
('P23', 'Sandaru', 'Nimsara', '200455558V', 'Male', '2004-07-07', '0705000008', 'Matara'),
('P24', 'Chathura', 'Madushan', '200455559V', 'Male', '2004-08-08', '0705000009', 'Galle'),
('P25', 'Lahiru', 'Sampath', '200455560V', 'Male', '2004-09-09', '0705000010', 'Matara'),
('P26', 'Dilshan', 'Perera', '200455561V', 'Male', '2004-10-10', '0705000011', 'Colombo'),
('P27', 'Kavindi', 'Silva', '200455562V', 'Female', '2004-11-11', '0705000012', 'Galle'),
('P28', 'Tharindu', 'Lakshan', '200455563V', 'Male', '2004-12-12', '0705000013', 'Matara'),
('P29', 'Navod', 'Sathira', '200455564V', 'Male', '2004-01-13', '0705000014', 'Tangalle'),
('P30', 'Rashmi', 'Nimesha', '200455565V', 'Female', '2004-02-14', '0705000015', 'Colombo'),
('P31', 'Sadun', 'Kumara', '200455566V', 'Male', '2004-03-15', '0705000016', 'Galle'),
('P32', 'Oshadi', 'Tharaka', '200455567V', 'Female', '2004-04-16', '0705000017', 'Kandy'),
('P33', 'Kavindu', 'Heshan', '200455568V', 'Male', '2004-05-17', '0705000018', 'Matara'),
('P34', 'Ishan', 'Dananjaya', '200455569V', 'Male', '2004-06-18', '0705000019', 'Colombo'),
('P35', 'Malindu', 'Bandara', '200455570V', 'Male', '2004-07-19', '0705000020', 'Galle'),


-- Repeat Students (5)
('P36', 'Dasun', 'Shanaka', '200366661V', 'Male', '2003-01-01', '0716000001', 'Colombo'),
('P37', 'Kusal', 'Mendis', '200366662V', 'Male', '2003-02-02', '0716000002', 'Galle'),
('P38', 'Pathum', 'Nissanka', '200366663V', 'Male', '2003-03-03', '0716000003', 'Kandy'),
('P39', 'Charith', 'Asalanka', '200366664V', 'Male', '2003-04-04', '0716000004', 'Matara'),
('P40', 'Wanindu', 'Hasaranga', '200366665V', 'Male', '2003-05-05', '0716000005', 'Galle');


-- INSERT INTO USER_ACCOUNT (40 Accounts)

INSERT INTO USER_ACCOUNT (Account_ID, Person_ID, UserName, Password, account_status) VALUES

('U01', 'P01', 'admin_nalin', 'pass123', 'Active'),
('U02', 'P02', 'dean_saman', 'pass123', 'Active'),
('U03', 'P03', 'lec_amali', 'pass123', 'Active'),
('U04', 'P04', 'lec_kasun', 'pass123', 'Active'),
('U05', 'P05', 'lec_ruwan', 'pass123', 'Active'), 
('U06', 'P06', 'lec_nuwan', 'pass123', 'Active'),
('U07', 'P07', 'lec_sanduni', 'pass123', 'Active'),
('U08', 'P08', 'lec_gayan', 'pass123', 'Active'),
('U09', 'P09', 'lec_chathu', 'pass123', 'Active'),
('U10', 'P10', 'lec_nilantha', 'pass123', 'Active'),
('U11', 'P11', 'to_kamal', 'pass123', 'Active'),
('U12', 'P12', 'to_sunil', 'pass123', 'Active'),
('U13', 'P13', 'to_nayana', 'pass123', 'Active'),
('U14', 'P14', 'to_jagath', 'pass123', 'Active'),
('U15', 'P15', 'to_sujeewa', 'pass123', 'Active'),
('U16', 'P16', 'tg2095', 'pass123', 'Active'),
('U17', 'P17', 'tg2096', 'pass123', 'Active'),
('U18', 'P18', 'tg2097', 'pass123', 'Active'),
('U19', 'P19', 'tg2112', 'pass123', 'Active'),
('U20', 'P20', 'tg2113', 'pass123', 'Active'),
('U21', 'P21', 'tg2114', 'pass123', 'Active'),
('U22', 'P22', 'tg2115', 'pass123', 'Active'),
('U23', 'P23', 'tg2116', 'pass123', 'Active'),
('U24', 'P24', 'tg2117', 'pass123', 'Active'),
('U25', 'P25', 'tg2118', 'pass123', 'Active'),
('U26', 'P26', 'tg2119', 'pass123', 'Active'),
('U27', 'P27', 'tg2120', 'pass123', 'Active'),
('U28', 'P28', 'tg2121', 'pass123', 'Active'),
('U29', 'P29', 'tg2122', 'pass123', 'Active'),
('U30', 'P30', 'tg2123', 'pass123', 'Active'),
('U31', 'P31', 'tg2124', 'pass123', 'Active'),
('U32', 'P32', 'tg2125', 'pass123', 'Active'),
('U33', 'P33', 'tg2126', 'pass123', 'Active'),
('U34', 'P34', 'tg2127', 'pass123', 'Active'),
('U35', 'P35', 'tg2128', 'pass123', 'Active'),
('U36', 'P36', 'tg1001', 'pass123', 'Active'),
('U37', 'P37', 'tg1002', 'pass123', 'Active'),
('U38', 'P38', 'tg1003', 'pass123', 'Active'),
('U39', 'P39', 'tg1004', 'pass123', 'Active'),
('U40', 'P40', 'tg1005', 'pass123', 'Active');






-- INSERT INTO STAFF (15 Staff Members)

INSERT INTO STAFF (Staff_ID, Person_ID, staff_no, hire_date, Department_ID) VALUES

-- Admin
('ST01', 'P01', 'EMP001', '2010-01-01', 'D01'), 

-- Dean
('ST02', 'P02', 'EMP002', '2005-01-01', 'D01'), 

-- Lecturers
('ST03', 'P03', 'EMP003', '2015-01-01', 'D01'), 
('ST04', 'P04', 'EMP004', '2016-01-01', 'D01'),
('ST05', 'P05', 'EMP005', '2017-01-01', 'D02'),
('ST06', 'P06', 'EMP006', '2018-01-01', 'D03'),
('ST07', 'P07', 'EMP007', '2019-01-01', 'D01'),
('ST08', 'P08', 'EMP008', '2019-06-01', 'D02'),
('ST09', 'P09', 'EMP009', '2020-01-01', 'D03'),
('ST10', 'P10', 'EMP010', '2020-06-01', 'D01'),

-- TOs
('ST11', 'P11', 'EMP011', '2020-01-01', 'D01'), 
('ST12', 'P12', 'EMP012', '2020-02-01', 'D01'),
('ST13', 'P13', 'EMP013', '2021-01-01', 'D02'),
('ST14', 'P14', 'EMP014', '2021-05-01', 'D03'),
('ST15', 'P15', 'EMP015', '2022-01-01', 'D01');





-- INSERT INTO STAFF ROLES (Admin, Dean, Lecturer, TO)
INSERT INTO ADMIN (Staff_ID, Admin_Level) VALUES 
('ST01', 'Super Admin');

INSERT INTO DEAN (Staff_ID, Appointed_Date) VALUES 
('ST02', '2024-01-01');

INSERT INTO LECTURER (Staff_ID, Academic_Rank) VALUES
('ST03', 'Senior Lecturer'), 
('ST04', 'Lecturer'), 
('ST05', 'Senior Lecturer'), 
('ST06', 'Lecturer'), 
('ST07', 'Lecturer'), 
('ST08', 'Senior Lecturer'),
('ST09', 'Lecturer'), 
('ST10', 'Lecturer');

INSERT INTO TECHNICAL_OFFICER (Staff_ID, Specialization, lab_assigned) VALUES
('ST11', 'Networking', 'Lab A'), 
('ST12', 'Hardware', 'Lab B'), 
('ST13', 'Software', 'Lab C'), 
('ST14', 'Hardware', 'Lab D'), 
('ST15', 'Networking', 'Lab E');



-- INSERT INTO STUDENT (25 Students)

INSERT INTO STUDENT (Student_ID, Person_ID, Reg_no, Department_ID, Intake_Year, Batch, Status) VALUES

-- 20 Proper Students
('S01', 'P16', 'TG/2024/2095', 'D01', 2024, '23/24', 'Proper'),
('S02', 'P17', 'TG/2024/2096', 'D01', 2024, '23/24', 'Proper'),
('S03', 'P18', 'TG/2024/2097', 'D01', 2024, '23/24', 'Proper'),
('S04', 'P19', 'TG/2024/2112', 'D01', 2024, '23/24', 'Proper'),
('S05', 'P20', 'TG/2024/2113', 'D01', 2024, '23/24', 'Proper'),
('S06', 'P21', 'TG/2024/2114', 'D01', 2024, '23/24', 'Proper'),
('S07', 'P22', 'TG/2024/2115', 'D01', 2024, '23/24', 'Proper'),
('S08', 'P23', 'TG/2024/2116', 'D01', 2024, '23/24', 'Proper'),
('S09', 'P24', 'TG/2024/2117', 'D01', 2024, '23/24', 'Proper'),
('S10', 'P25', 'TG/2024/2118', 'D01', 2024, '23/24', 'Proper'),
('S11', 'P26', 'TG/2024/2119', 'D01', 2024, '23/24', 'Proper'),
('S12', 'P27', 'TG/2024/2120', 'D01', 2024, '23/24', 'Proper'),
('S13', 'P28', 'TG/2024/2121', 'D01', 2024, '23/24', 'Proper'),
('S14', 'P29', 'TG/2024/2122', 'D01', 2024, '23/24', 'Proper'),
('S15', 'P30', 'TG/2024/2123', 'D01', 2024, '23/24', 'Proper'),
('S16', 'P31', 'TG/2024/2124', 'D01', 2024, '23/24', 'Proper'),
('S17', 'P32', 'TG/2024/2125', 'D01', 2024, '23/24', 'Proper'),
('S18', 'P33', 'TG/2024/2126', 'D01', 2024, '23/24', 'Proper'),
('S19', 'P34', 'TG/2024/2127', 'D01', 2024, '23/24', 'Proper'),
('S20', 'P35', 'TG/2024/2128', 'D01', 2024, '23/24', 'Proper');




-- INSERT INTO STUDENT (5 Repeat Students)

INSERT INTO STUDENT (Student_ID, Person_ID, Reg_no, Department_ID, Intake_Year, Batch, Status) VALUES
('S21', 'P36', 'TG/2023/1001', 'D01', 2023, '22/23', 'Repeat'),
('S22', 'P37', 'TG/2023/1002', 'D01', 2023, '22/23', 'Repeat'),
('S23', 'P38', 'TG/2023/1003', 'D01', 2023, '22/23', 'Repeat'),
('S24', 'P39', 'TG/2023/1004', 'D01', 2023, '22/23', 'Repeat'),
('S25', 'P40', 'TG/2023/1005', 'D01', 2023, '22/23', 'Repeat');


INSERT INTO COURSE_UNIT (Course_ID, Course_Code, Course_Name, Credits, Course_Type, Department_ID) VALUES

('CU_ENG1212', 'ENG1212', 'English II', 2, 'Theory', 'D01'),
('CU_ICT1212', 'ICT1212', 'Database Management Systems', 2, 'Theory', 'D01'),
('CU_ICT1222', 'ICT1222', 'DBMS Practicum', 2, 'Practical', 'D01'),
('CU_ICT1232', 'ICT1232', 'Web Development', 2, 'Theory', 'D01'),
('CU_ICT1242', 'ICT1242', 'Web Development Practicum', 2, 'Practical', 'D01'),
('CU_ICT1252', 'ICT1252', 'OS Concepts and Application', 2, 'Theory', 'D01'),
('CU_ICT1261', 'ICT1261', 'System Prog. Fundamentals & Linux', 2, 'Both', 'D01'),
('CU_TCS1212', 'TCS1212', 'Fundamentals of Management', 2, 'Theory', 'D01'),
('CU_TMS1233', 'TMS1233', 'Discrete Mathematics', 3, 'Theory', 'D01');

INSERT INTO SEMESTER (Semester_ID, Academic_Year, Semester_No, Start_Date, End_Date) VALUES
('SEM01', 2024, 1, '2026-05-04', '2026-08-20');

INSERT INTO GRADE_SCALE (Grade_ID, min_mark, max_mark, grade_point, letter_grade) VALUES
('G_AP', 85, 100, 4.00, 'A+'),
('G_A',  75,  84, 4.00, 'A'),
('G_AM', 70,  74, 3.70, 'A-'),
('G_BP', 65,  69, 3.30, 'B+'),
('G_B',  60,  64, 3.00, 'B'),
('G_BM', 55,  59, 2.70, 'B-'),
('G_CP', 50,  54, 2.30, 'C+'),
('G_C',  45,  49, 2.00, 'C'),
('G_CM', 40,  44, 1.70, 'C-'),
('G_D',  35,  39, 1.30, 'D'),
('G_E',   0,  34, 0.00, 'E');

INSERT INTO COURSE_OFFERING 
(Offering_ID, Course_ID, Lecturer_ID, Semester_ID, Batch, active_status) 
VALUES
('OFF_MGT', 'CU_TCS1212', 'ST03', 'SEM01', '2022/2023', TRUE),
('OFF_LIN', 'CU_ICT1261', 'ST04', 'SEM01', '2022/2023', TRUE),
('OFF_DBP', 'CU_ICT1222', 'ST05', 'SEM01', '2022/2023', TRUE),
('OFF_WEB', 'CU_ICT1232', 'ST06', 'SEM01', '2022/2023', TRUE),
('OFF_WEP', 'CU_ICT1242', 'ST07', 'SEM01', '2022/2023', TRUE),
('OFF_MAT', 'CU_TMS1233', 'ST08', 'SEM01', '2022/2023', TRUE),
('OFF_ENG', 'CU_ENG1212', 'ST09', 'SEM01', '2022/2023', TRUE),
('OFF_DBS', 'CU_ICT1212', 'ST10', 'SEM01', '2022/2023', TRUE),
('OFF_OSC', 'CU_ICT1252', 'ST09', 'SEM01', '2022/2023', TRUE);

INSERT INTO COURSE_COMPONENT (Component_ID, offering_id, component_type, total_sessions, total_hours) VALUES
('CC_MGT', 'OFF_MGT', 'Theory', 15, 30),
('CC_LIN_T', 'OFF_LIN', 'Theory', 15, 15),
('CC_LIN_P', 'OFF_LIN', 'Practical', 15, 15),
('CC_DBP', 'OFF_DBP', 'Practical', 15, 30),
('CC_WEB_T', 'OFF_WEB', 'Theory', 15, 15),
('CC_WEB_P1', 'OFF_WEP', 'Practical', 15, 30), -- Tuesday Practicum
('CC_WEB_P2', 'OFF_WEP', 'Practical', 15, 45), -- Thursday Practicum
('CC_MAT', 'OFF_MAT', 'Theory', 15, 30),
('CC_ENG', 'OFF_ENG', 'Theory', 15, 30),
('CC_DBS', 'OFF_DBS', 'Theory', 15, 30),
('CC_OSC', 'OFF_OSC', 'Theory', 15, 30);


-- =========================================================================
-- ENROLLMENT DATA FOR ALL 25 STUDENTS ACROSS 9 SUBJECTS (225 Records)
-- =========================================================================

INSERT INTO ENROLLMENT (Enrollment_ID, Student_ID, Offering_ID, enrollment_date, attempt_no, enrollment_status) VALUES

--  Fundamentals of Management (MGT)
('E_MGT_01', 'S01', 'OFF_MGT', '2026-05-01', 1, 'Enrolled'),
('E_MGT_02', 'S02', 'OFF_MGT', '2026-05-01', 1, 'Enrolled'),
('E_MGT_03', 'S03', 'OFF_MGT', '2026-05-01', 1, 'Enrolled'), 
('E_MGT_04', 'S04', 'OFF_MGT', '2026-05-01', 1, 'Enrolled'),
('E_MGT_05', 'S05', 'OFF_MGT', '2026-05-01', 1, 'Enrolled'), 
('E_MGT_06', 'S06', 'OFF_MGT', '2026-05-01', 1, 'Enrolled'),
('E_MGT_07', 'S07', 'OFF_MGT', '2026-05-01', 1, 'Enrolled'), 
('E_MGT_08', 'S08', 'OFF_MGT', '2026-05-01', 1, 'Enrolled'),
('E_MGT_09', 'S09', 'OFF_MGT', '2026-05-01', 1, 'Enrolled'),
('E_MGT_10', 'S10', 'OFF_MGT', '2026-05-01', 1, 'Enrolled'),
('E_MGT_11', 'S11', 'OFF_MGT', '2026-05-01', 1, 'Enrolled'), 
('E_MGT_12', 'S12', 'OFF_MGT', '2026-05-01', 1, 'Enrolled'),
('E_MGT_13', 'S13', 'OFF_MGT', '2026-05-01', 1, 'Enrolled'), 
('E_MGT_14', 'S14', 'OFF_MGT', '2026-05-01', 1, 'Enrolled'),
('E_MGT_15', 'S15', 'OFF_MGT', '2026-05-01', 1, 'Enrolled'), 
('E_MGT_16', 'S16', 'OFF_MGT', '2026-05-01', 1, 'Enrolled'),
('E_MGT_17', 'S17', 'OFF_MGT', '2026-05-01', 1, 'Enrolled'), 
('E_MGT_18', 'S18', 'OFF_MGT', '2026-05-01', 1, 'Enrolled'),
('E_MGT_19', 'S19', 'OFF_MGT', '2026-05-01', 1, 'Enrolled'), 
('E_MGT_20', 'S20', 'OFF_MGT', '2026-05-01', 1, 'Enrolled'),
('E_MGT_21', 'S21', 'OFF_MGT', '2026-05-01', 1, 'Enrolled'), 
('E_MGT_22', 'S22', 'OFF_MGT', '2026-05-01', 1, 'Enrolled'),
('E_MGT_23', 'S23', 'OFF_MGT', '2026-05-01', 1, 'Enrolled'), 
('E_MGT_24', 'S24', 'OFF_MGT', '2026-05-01', 1, 'Enrolled'),
('E_MGT_25', 'S25', 'OFF_MGT', '2026-05-01', 1, 'Enrolled'),

--  System Prog. Fundamentals & Linux (LIN)
('E_LIN_01', 'S01', 'OFF_LIN', '2026-05-01', 1, 'Enrolled'), 
('E_LIN_02', 'S02', 'OFF_LIN', '2026-05-01', 1, 'Enrolled'),
('E_LIN_03', 'S03', 'OFF_LIN', '2026-05-01', 1, 'Enrolled'), 
('E_LIN_04', 'S04', 'OFF_LIN', '2026-05-01', 1, 'Enrolled'),
('E_LIN_05', 'S05', 'OFF_LIN', '2026-05-01', 1, 'Enrolled'), 
('E_LIN_06', 'S06', 'OFF_LIN', '2026-05-01', 1, 'Enrolled'),
('E_LIN_07', 'S07', 'OFF_LIN', '2026-05-01', 1, 'Enrolled'), 
('E_LIN_08', 'S08', 'OFF_LIN', '2026-05-01', 1, 'Enrolled'),
('E_LIN_09', 'S09', 'OFF_LIN', '2026-05-01', 1, 'Enrolled'), 
('E_LIN_10', 'S10', 'OFF_LIN', '2026-05-01', 1, 'Enrolled'),
('E_LIN_11', 'S11', 'OFF_LIN', '2026-05-01', 1, 'Enrolled'), 
('E_LIN_12', 'S12', 'OFF_LIN', '2026-05-01', 1, 'Enrolled'),
('E_LIN_13', 'S13', 'OFF_LIN', '2026-05-01', 1, 'Enrolled'), 
('E_LIN_14', 'S14', 'OFF_LIN', '2026-05-01', 1, 'Enrolled'),
('E_LIN_15', 'S15', 'OFF_LIN', '2026-05-01', 1, 'Enrolled'), 
('E_LIN_16', 'S16', 'OFF_LIN', '2026-05-01', 1, 'Enrolled'),
('E_LIN_17', 'S17', 'OFF_LIN', '2026-05-01', 1, 'Enrolled'), 
('E_LIN_18', 'S18', 'OFF_LIN', '2026-05-01', 1, 'Enrolled'),
('E_LIN_19', 'S19', 'OFF_LIN', '2026-05-01', 1, 'Enrolled'), 
('E_LIN_20', 'S20', 'OFF_LIN', '2026-05-01', 1, 'Enrolled'),
('E_LIN_21', 'S21', 'OFF_LIN', '2026-05-01', 1, 'Enrolled'), 
('E_LIN_22', 'S22', 'OFF_LIN', '2026-05-01', 1, 'Enrolled'),
('E_LIN_23', 'S23', 'OFF_LIN', '2026-05-01', 1, 'Enrolled'), 
('E_LIN_24', 'S24', 'OFF_LIN', '2026-05-01', 1, 'Enrolled'),
('E_LIN_25', 'S25', 'OFF_LIN', '2026-05-01', 1, 'Enrolled'),

--  DBMS Practicum (DBP)
('E_DBP_01', 'S01', 'OFF_DBP', '2026-05-01', 1, 'Enrolled'), 
('E_DBP_02', 'S02', 'OFF_DBP', '2026-05-01', 1, 'Enrolled'),
('E_DBP_03', 'S03', 'OFF_DBP', '2026-05-01', 1, 'Enrolled'), 
('E_DBP_04', 'S04', 'OFF_DBP', '2026-05-01', 1, 'Enrolled'),
('E_DBP_05', 'S05', 'OFF_DBP', '2026-05-01', 1, 'Enrolled'), 
('E_DBP_06', 'S06', 'OFF_DBP', '2026-05-01', 1, 'Enrolled'),
('E_DBP_07', 'S07', 'OFF_DBP', '2026-05-01', 1, 'Enrolled'), 
('E_DBP_08', 'S08', 'OFF_DBP', '2026-05-01', 1, 'Enrolled'),
('E_DBP_09', 'S09', 'OFF_DBP', '2026-05-01', 1, 'Enrolled'), 
('E_DBP_10', 'S10', 'OFF_DBP', '2026-05-01', 1, 'Enrolled'),
('E_DBP_11', 'S11', 'OFF_DBP', '2026-05-01', 1, 'Enrolled'), 
('E_DBP_12', 'S12', 'OFF_DBP', '2026-05-01', 1, 'Enrolled'),
('E_DBP_13', 'S13', 'OFF_DBP', '2026-05-01', 1, 'Enrolled'), 
('E_DBP_14', 'S14', 'OFF_DBP', '2026-05-01', 1, 'Enrolled'),
('E_DBP_15', 'S15', 'OFF_DBP', '2026-05-01', 1, 'Enrolled'), 
('E_DBP_16', 'S16', 'OFF_DBP', '2026-05-01', 1, 'Enrolled'),
('E_DBP_17', 'S17', 'OFF_DBP', '2026-05-01', 1, 'Enrolled'), 
('E_DBP_18', 'S18', 'OFF_DBP', '2026-05-01', 1, 'Enrolled'),
('E_DBP_19', 'S19', 'OFF_DBP', '2026-05-01', 1, 'Enrolled'), 
('E_DBP_20', 'S20', 'OFF_DBP', '2026-05-01', 1, 'Enrolled'),
('E_DBP_21', 'S21', 'OFF_DBP', '2026-05-01', 1, 'Enrolled'), 
('E_DBP_22', 'S22', 'OFF_DBP', '2026-05-01', 1, 'Enrolled'),
('E_DBP_23', 'S23', 'OFF_DBP', '2026-05-01', 1, 'Enrolled'), 
('E_DBP_24', 'S24', 'OFF_DBP', '2026-05-01', 1, 'Enrolled'),
('E_DBP_25', 'S25', 'OFF_DBP', '2026-05-01', 1, 'Enrolled'),

-- Web Development Theory (WEBT)
('E_WBT_01', 'S01', 'OFF_WEB', '2026-05-01', 1, 'Enrolled'), 
('E_WBT_02', 'S02', 'OFF_WEB', '2026-05-01', 1, 'Enrolled'),
('E_WBT_03', 'S03', 'OFF_WEB', '2026-05-01', 1, 'Enrolled'), 
('E_WBT_04', 'S04', 'OFF_WEB', '2026-05-01', 1, 'Enrolled'),
('E_WBT_05', 'S05', 'OFF_WEB', '2026-05-01', 1, 'Enrolled'), 
('E_WBT_06', 'S06', 'OFF_WEB', '2026-05-01', 1, 'Enrolled'),
('E_WBT_07', 'S07', 'OFF_WEB', '2026-05-01', 1, 'Enrolled'), 
('E_WBT_08', 'S08', 'OFF_WEB', '2026-05-01', 1, 'Enrolled'),
('E_WBT_09', 'S09', 'OFF_WEB', '2026-05-01', 1, 'Enrolled'), 
('E_WBT_10', 'S10', 'OFF_WEB', '2026-05-01', 1, 'Enrolled'),
('E_WBT_11', 'S11', 'OFF_WEB', '2026-05-01', 1, 'Enrolled'), 
('E_WBT_12', 'S12', 'OFF_WEB', '2026-05-01', 1, 'Enrolled'),
('E_WBT_13', 'S13', 'OFF_WEB', '2026-05-01', 1, 'Enrolled'), 
('E_WBT_14', 'S14', 'OFF_WEB', '2026-05-01', 1, 'Enrolled'),
('E_WBT_15', 'S15', 'OFF_WEB', '2026-05-01', 1, 'Enrolled'), 
('E_WBT_16', 'S16', 'OFF_WEB', '2026-05-01', 1, 'Enrolled'),
('E_WBT_17', 'S17', 'OFF_WEB', '2026-05-01', 1, 'Enrolled'), 
('E_WBT_18', 'S18', 'OFF_WEB', '2026-05-01', 1, 'Enrolled'),
('E_WBT_19', 'S19', 'OFF_WEB', '2026-05-01', 1, 'Enrolled'), 
('E_WBT_20', 'S20', 'OFF_WEB', '2026-05-01', 1, 'Enrolled'),
('E_WBT_21', 'S21', 'OFF_WEB', '2026-05-01', 1, 'Enrolled'), 
('E_WBT_22', 'S22', 'OFF_WEB', '2026-05-01', 1, 'Enrolled'),
('E_WBT_23', 'S23', 'OFF_WEB', '2026-05-01', 1, 'Enrolled'),
('E_WBT_24', 'S24', 'OFF_WEB', '2026-05-01', 1, 'Enrolled'),
('E_WBT_25', 'S25', 'OFF_WEB', '2026-05-01', 1, 'Enrolled'),

-- Web Development Practicum (WEBP)
('E_WBP_01', 'S01', 'OFF_WEP', '2026-05-01', 1, 'Enrolled'), 
('E_WBP_02', 'S02', 'OFF_WEP', '2026-05-01', 1, 'Enrolled'),
('E_WBP_03', 'S03', 'OFF_WEP', '2026-05-01', 1, 'Enrolled'), 
('E_WBP_04', 'S04', 'OFF_WEP', '2026-05-01', 1, 'Enrolled'),
('E_WBP_05', 'S05', 'OFF_WEP', '2026-05-01', 1, 'Enrolled'), 
('E_WBP_06', 'S06', 'OFF_WEP', '2026-05-01', 1, 'Enrolled'),
('E_WBP_07', 'S07', 'OFF_WEP', '2026-05-01', 1, 'Enrolled'), 
('E_WBP_08', 'S08', 'OFF_WEP', '2026-05-01', 1, 'Enrolled'),
('E_WBP_09', 'S09', 'OFF_WEP', '2026-05-01', 1, 'Enrolled'), 
('E_WBP_10', 'S10', 'OFF_WEP', '2026-05-01', 1, 'Enrolled'),
('E_WBP_11', 'S11', 'OFF_WEP', '2026-05-01', 1, 'Enrolled'), 
('E_WBP_12', 'S12', 'OFF_WEP', '2026-05-01', 1, 'Enrolled'),
('E_WBP_13', 'S13', 'OFF_WEP', '2026-05-01', 1, 'Enrolled'), 
('E_WBP_14', 'S14', 'OFF_WEP', '2026-05-01', 1, 'Enrolled'),
('E_WBP_15', 'S15', 'OFF_WEP', '2026-05-01', 1, 'Enrolled'), 
('E_WBP_16', 'S16', 'OFF_WEP', '2026-05-01', 1, 'Enrolled'),
('E_WBP_17', 'S17', 'OFF_WEP', '2026-05-01', 1, 'Enrolled'), 
('E_WBP_18', 'S18', 'OFF_WEP', '2026-05-01', 1, 'Enrolled'),
('E_WBP_19', 'S19', 'OFF_WEP', '2026-05-01', 1, 'Enrolled'), 
('E_WBP_20', 'S20', 'OFF_WEP', '2026-05-01', 1, 'Enrolled'),
('E_WBP_21', 'S21', 'OFF_WEP', '2026-05-01', 1, 'Enrolled'), 
('E_WBP_22', 'S22', 'OFF_WEP', '2026-05-01', 1, 'Enrolled'),
('E_WBP_23', 'S23', 'OFF_WEP', '2026-05-01', 1, 'Enrolled'), 
('E_WBP_24', 'S24', 'OFF_WEP', '2026-05-01', 1, 'Enrolled'),
('E_WBP_25', 'S25', 'OFF_WEP', '2026-05-01', 1, 'Enrolled'),

--  Discrete Mathematics (MAT)
('E_MAT_01', 'S01', 'OFF_MAT', '2026-05-01', 1, 'Enrolled'), 
('E_MAT_02', 'S02', 'OFF_MAT', '2026-05-01', 1, 'Enrolled'),
('E_MAT_03', 'S03', 'OFF_MAT', '2026-05-01', 1, 'Enrolled'), 
('E_MAT_04', 'S04', 'OFF_MAT', '2026-05-01', 1, 'Enrolled'),
('E_MAT_05', 'S05', 'OFF_MAT', '2026-05-01', 1, 'Enrolled'), 
('E_MAT_06', 'S06', 'OFF_MAT', '2026-05-01', 1, 'Enrolled'),
('E_MAT_07', 'S07', 'OFF_MAT', '2026-05-01', 1, 'Enrolled'), 
('E_MAT_08', 'S08', 'OFF_MAT', '2026-05-01', 1, 'Enrolled'),
('E_MAT_09', 'S09', 'OFF_MAT', '2026-05-01', 1, 'Enrolled'), 
('E_MAT_10', 'S10', 'OFF_MAT', '2026-05-01', 1, 'Enrolled'),
('E_MAT_11', 'S11', 'OFF_MAT', '2026-05-01', 1, 'Enrolled'),
('E_MAT_12', 'S12', 'OFF_MAT', '2026-05-01', 1, 'Enrolled'),
('E_MAT_13', 'S13', 'OFF_MAT', '2026-05-01', 1, 'Enrolled'), 
('E_MAT_14', 'S14', 'OFF_MAT', '2026-05-01', 1, 'Enrolled'),
('E_MAT_15', 'S15', 'OFF_MAT', '2026-05-01', 1, 'Enrolled'), 
('E_MAT_16', 'S16', 'OFF_MAT', '2026-05-01', 1, 'Enrolled'),
('E_MAT_17', 'S17', 'OFF_MAT', '2026-05-01', 1, 'Enrolled'), 
('E_MAT_18', 'S18', 'OFF_MAT', '2026-05-01', 1, 'Enrolled'),
('E_MAT_19', 'S19', 'OFF_MAT', '2026-05-01', 1, 'Enrolled'), 
('E_MAT_20', 'S20', 'OFF_MAT', '2026-05-01', 1, 'Enrolled'),
('E_MAT_21', 'S21', 'OFF_MAT', '2026-05-01', 1, 'Enrolled'), 
('E_MAT_22', 'S22', 'OFF_MAT', '2026-05-01', 1, 'Enrolled'),
('E_MAT_23', 'S23', 'OFF_MAT', '2026-05-01', 1, 'Enrolled'), 
('E_MAT_24', 'S24', 'OFF_MAT', '2026-05-01', 1, 'Enrolled'),
('E_MAT_25', 'S25', 'OFF_MAT', '2026-05-01', 1, 'Enrolled'),

--  English II (ENG)
('E_ENG_01', 'S01', 'OFF_ENG', '2026-05-01', 1, 'Enrolled'), 
('E_ENG_02', 'S02', 'OFF_ENG', '2026-05-01', 1, 'Enrolled'),
('E_ENG_03', 'S03', 'OFF_ENG', '2026-05-01', 1, 'Enrolled'), 
('E_ENG_04', 'S04', 'OFF_ENG', '2026-05-01', 1, 'Enrolled'),
('E_ENG_05', 'S05', 'OFF_ENG', '2026-05-01', 1, 'Enrolled'), 
('E_ENG_06', 'S06', 'OFF_ENG', '2026-05-01', 1, 'Enrolled'),
('E_ENG_07', 'S07', 'OFF_ENG', '2026-05-01', 1, 'Enrolled'), 
('E_ENG_08', 'S08', 'OFF_ENG', '2026-05-01', 1, 'Enrolled'),
('E_ENG_09', 'S09', 'OFF_ENG', '2026-05-01', 1, 'Enrolled'), 
('E_ENG_10', 'S10', 'OFF_ENG', '2026-05-01', 1, 'Enrolled'),
('E_ENG_11', 'S11', 'OFF_ENG', '2026-05-01', 1, 'Enrolled'), 
('E_ENG_12', 'S12', 'OFF_ENG', '2026-05-01', 1, 'Enrolled'),
('E_ENG_13', 'S13', 'OFF_ENG', '2026-05-01', 1, 'Enrolled'), 
('E_ENG_14', 'S14', 'OFF_ENG', '2026-05-01', 1, 'Enrolled'),
('E_ENG_15', 'S15', 'OFF_ENG', '2026-05-01', 1, 'Enrolled'), 
('E_ENG_16', 'S16', 'OFF_ENG', '2026-05-01', 1, 'Enrolled'),
('E_ENG_17', 'S17', 'OFF_ENG', '2026-05-01', 1, 'Enrolled'), 
('E_ENG_18', 'S18', 'OFF_ENG', '2026-05-01', 1, 'Enrolled'),
('E_ENG_19', 'S19', 'OFF_ENG', '2026-05-01', 1, 'Enrolled'), 
('E_ENG_20', 'S20', 'OFF_ENG', '2026-05-01', 1, 'Enrolled'),
('E_ENG_21', 'S21', 'OFF_ENG', '2026-05-01', 1, 'Enrolled'), 
('E_ENG_22', 'S22', 'OFF_ENG', '2026-05-01', 1, 'Enrolled'),
('E_ENG_23', 'S23', 'OFF_ENG', '2026-05-01', 1, 'Enrolled'), 
('E_ENG_24', 'S24', 'OFF_ENG', '2026-05-01', 1, 'Enrolled'),
('E_ENG_25', 'S25', 'OFF_ENG', '2026-05-01', 1, 'Enrolled'),

--  Database Management Systems (DBS)
('E_DBS_01', 'S01', 'OFF_DBS', '2026-05-01', 1, 'Enrolled'), 
('E_DBS_02', 'S02', 'OFF_DBS', '2026-05-01', 1, 'Enrolled'),
('E_DBS_03', 'S03', 'OFF_DBS', '2026-05-01', 1, 'Enrolled'), 
('E_DBS_04', 'S04', 'OFF_DBS', '2026-05-01', 1, 'Enrolled'),
('E_DBS_05', 'S05', 'OFF_DBS', '2026-05-01', 1, 'Enrolled'), 
('E_DBS_06', 'S06', 'OFF_DBS', '2026-05-01', 1, 'Enrolled'),
('E_DBS_07', 'S07', 'OFF_DBS', '2026-05-01', 1, 'Enrolled'), 
('E_DBS_08', 'S08', 'OFF_DBS', '2026-05-01', 1, 'Enrolled'),
('E_DBS_09', 'S09', 'OFF_DBS', '2026-05-01', 1, 'Enrolled'), 
('E_DBS_10', 'S10', 'OFF_DBS', '2026-05-01', 1, 'Enrolled'),
('E_DBS_11', 'S11', 'OFF_DBS', '2026-05-01', 1, 'Enrolled'), 
('E_DBS_12', 'S12', 'OFF_DBS', '2026-05-01', 1, 'Enrolled'),
('E_DBS_13', 'S13', 'OFF_DBS', '2026-05-01', 1, 'Enrolled'), 
('E_DBS_14', 'S14', 'OFF_DBS', '2026-05-01', 1, 'Enrolled'),
('E_DBS_15', 'S15', 'OFF_DBS', '2026-05-01', 1, 'Enrolled'), 
('E_DBS_16', 'S16', 'OFF_DBS', '2026-05-01', 1, 'Enrolled'),
('E_DBS_17', 'S17', 'OFF_DBS', '2026-05-01', 1, 'Enrolled'), 
('E_DBS_18', 'S18', 'OFF_DBS', '2026-05-01', 1, 'Enrolled'),
('E_DBS_19', 'S19', 'OFF_DBS', '2026-05-01', 1, 'Enrolled'), 
('E_DBS_20', 'S20', 'OFF_DBS', '2026-05-01', 1, 'Enrolled'),
('E_DBS_21', 'S21', 'OFF_DBS', '2026-05-01', 1, 'Enrolled'), 
('E_DBS_22', 'S22', 'OFF_DBS', '2026-05-01', 1, 'Enrolled'),
('E_DBS_23', 'S23', 'OFF_DBS', '2026-05-01', 1, 'Enrolled'), 
('E_DBS_24', 'S24', 'OFF_DBS', '2026-05-01', 1, 'Enrolled'),
('E_DBS_25', 'S25', 'OFF_DBS', '2026-05-01', 1, 'Enrolled'),

-- OS Concepts and Application (OSC)
('E_OSC_01', 'S01', 'OFF_OSC', '2026-05-01', 1, 'Enrolled'), 
('E_OSC_02', 'S02', 'OFF_OSC', '2026-05-01', 1, 'Enrolled'),
('E_OSC_03', 'S03', 'OFF_OSC', '2026-05-01', 1, 'Enrolled'), 
('E_OSC_04', 'S04', 'OFF_OSC', '2026-05-01', 1, 'Enrolled'),
('E_OSC_05', 'S05', 'OFF_OSC', '2026-05-01', 1, 'Enrolled'), 
('E_OSC_06', 'S06', 'OFF_OSC', '2026-05-01', 1, 'Enrolled'),
('E_OSC_07', 'S07', 'OFF_OSC', '2026-05-01', 1, 'Enrolled'), 
('E_OSC_08', 'S08', 'OFF_OSC', '2026-05-01', 1, 'Enrolled'),
('E_OSC_09', 'S09', 'OFF_OSC', '2026-05-01', 1, 'Enrolled'), 
('E_OSC_10', 'S10', 'OFF_OSC', '2026-05-01', 1, 'Enrolled'),
('E_OSC_11', 'S11', 'OFF_OSC', '2026-05-01', 1, 'Enrolled'), 
('E_OSC_12', 'S12', 'OFF_OSC', '2026-05-01', 1, 'Enrolled'),
('E_OSC_13', 'S13', 'OFF_OSC', '2026-05-01', 1, 'Enrolled'), 
('E_OSC_14', 'S14', 'OFF_OSC', '2026-05-01', 1, 'Enrolled'),
('E_OSC_15', 'S15', 'OFF_OSC', '2026-05-01', 1, 'Enrolled'), 
('E_OSC_16', 'S16', 'OFF_OSC', '2026-05-01', 1, 'Enrolled'),
('E_OSC_17', 'S17', 'OFF_OSC', '2026-05-01', 1, 'Enrolled'), 
('E_OSC_18', 'S18', 'OFF_OSC', '2026-05-01', 1, 'Enrolled'),
('E_OSC_19', 'S19', 'OFF_OSC', '2026-05-01', 1, 'Enrolled'), 
('E_OSC_20', 'S20', 'OFF_OSC', '2026-05-01', 1, 'Enrolled'),
('E_OSC_21', 'S21', 'OFF_OSC', '2026-05-01', 1, 'Enrolled'), 
('E_OSC_22', 'S22', 'OFF_OSC', '2026-05-01', 1, 'Enrolled'),
('E_OSC_23', 'S23', 'OFF_OSC', '2026-05-01', 1, 'Enrolled'), 
('E_OSC_24', 'S24', 'OFF_OSC', '2026-05-01', 1, 'Enrolled'),
('E_OSC_25', 'S25', 'OFF_OSC', '2026-05-01', 1, 'Enrolled');


INSERT INTO SESSION (Session_ID, Component_ID, session_date, week_no, start_time, end_time, duration_hours) VALUES

-- ================= WEEK 01 (May 04 - May 08) =================
('W01_MGT', 'CC_MGT', '2026-05-04', 1, '09:00:00', '11:00:00', 2),
('W01_LIN', 'CC_LIN_T', '2026-05-04', 1, '13:00:00', '15:00:00', 2),
('W01_DBP', 'CC_DBP', '2026-05-05', 1, '09:00:00', '12:00:00', 3),
('W01_WEBT', 'CC_WEB_T', '2026-05-05', 1, '13:00:00', '14:00:00', 1),
('W01_WEBP1', 'CC_WEB_P1', '2026-05-05', 1, '14:00:00', '16:00:00', 2),
('W01_MAT', 'CC_MAT', '2026-05-06', 1, '09:00:00', '12:00:00', 3),
('W01_ENG', 'CC_ENG', '2026-05-07', 1, '09:00:00', '10:00:00', 1),
('W01_DBS', 'CC_DBS', '2026-05-07', 1, '10:00:00', '12:00:00', 2),
('W01_WEBP2', 'CC_WEB_P2', '2026-05-07', 1, '13:00:00', '16:00:00', 3),
('W01_OSC', 'CC_OSC', '2026-05-08', 1, '08:00:00', '10:00:00', 2),

-- ================= WEEK 02 (May 11 - May 15) =================
('W02_MGT', 'CC_MGT', '2026-05-11', 2, '09:00:00', '11:00:00', 2),
('W02_LIN', 'CC_LIN_T', '2026-05-11', 2, '13:00:00', '15:00:00', 2),
('W02_DBP', 'CC_DBP', '2026-05-12', 2, '09:00:00', '12:00:00', 3),
('W02_WEBT', 'CC_WEB_T', '2026-05-12', 2, '13:00:00', '14:00:00', 1),
('W02_WEBP1', 'CC_WEB_P1', '2026-05-12', 2, '14:00:00', '16:00:00', 2),
('W02_MAT', 'CC_MAT', '2026-05-13', 2, '09:00:00', '12:00:00', 3),
('W02_ENG', 'CC_ENG', '2026-05-14', 2, '09:00:00', '10:00:00', 1),
('W02_DBS', 'CC_DBS', '2026-05-14', 2, '10:00:00', '12:00:00', 2),
('W02_WEBP2', 'CC_WEB_P2', '2026-05-14', 2, '13:00:00', '16:00:00', 3),
('W02_OSC', 'CC_OSC', '2026-05-15', 2, '08:00:00', '10:00:00', 2),

-- ================= WEEK 03 (May 18 - May 22) =================
('W03_MGT', 'CC_MGT', '2026-05-18', 3, '09:00:00', '11:00:00', 2),
('W03_LIN', 'CC_LIN_T', '2026-05-18', 3, '13:00:00', '15:00:00', 2),
('W03_DBP', 'CC_DBP', '2026-05-19', 3, '09:00:00', '12:00:00', 3),
('W03_WEBT', 'CC_WEB_T', '2026-05-19', 3, '13:00:00', '14:00:00', 1),
('W03_WEBP1', 'CC_WEB_P1', '2026-05-19', 3, '14:00:00', '16:00:00', 2),
('W03_MAT', 'CC_MAT', '2026-05-20', 3, '09:00:00', '12:00:00', 3),
('W03_ENG', 'CC_ENG', '2026-05-21', 3, '09:00:00', '10:00:00', 1),
('W03_DBS', 'CC_DBS', '2026-05-21', 3, '10:00:00', '12:00:00', 2),
('W03_WEBP2', 'CC_WEB_P2', '2026-05-21', 3, '13:00:00', '16:00:00', 3),
('W03_OSC', 'CC_OSC', '2026-05-22', 3, '08:00:00', '10:00:00', 2),

-- ================= WEEK 04 (May 25 - May 29) =================
('W04_MGT', 'CC_MGT', '2026-05-25', 4, '09:00:00', '11:00:00', 2),
('W04_LIN', 'CC_LIN_T', '2026-05-25', 4, '13:00:00', '15:00:00', 2),
('W04_DBP', 'CC_DBP', '2026-05-26', 4, '09:00:00', '12:00:00', 3),
('W04_WEBT', 'CC_WEB_T', '2026-05-26', 4, '13:00:00', '14:00:00', 1),
('W04_WEBP1', 'CC_WEB_P1', '2026-05-26', 4, '14:00:00', '16:00:00', 2),
('W04_MAT', 'CC_MAT', '2026-05-27', 4, '09:00:00', '12:00:00', 3),
('W04_ENG', 'CC_ENG', '2026-05-28', 4, '09:00:00', '10:00:00', 1),
('W04_DBS', 'CC_DBS', '2026-05-28', 4, '10:00:00', '12:00:00', 2),
('W04_WEBP2', 'CC_WEB_P2', '2026-05-28', 4, '13:00:00', '16:00:00', 3),
('W04_OSC', 'CC_OSC', '2026-05-29', 4, '08:00:00', '10:00:00', 2),

-- ================= WEEK 05 (Jun 01 - Jun 05) =================
('W05_MGT', 'CC_MGT', '2026-06-01', 5, '09:00:00', '11:00:00', 2),
('W05_LIN', 'CC_LIN_T', '2026-06-01', 5, '13:00:00', '15:00:00', 2),
('W05_DBP', 'CC_DBP', '2026-06-02', 5, '09:00:00', '12:00:00', 3),
('W05_WEBT', 'CC_WEB_T', '2026-06-02', 5, '13:00:00', '14:00:00', 1),
('W05_WEBP1', 'CC_WEB_P1', '2026-06-02', 5, '14:00:00', '16:00:00', 2),
('W05_MAT', 'CC_MAT', '2026-06-03', 5, '09:00:00', '12:00:00', 3),
('W05_ENG', 'CC_ENG', '2026-06-04', 5, '09:00:00', '10:00:00', 1),
('W05_DBS', 'CC_DBS', '2026-06-04', 5, '10:00:00', '12:00:00', 2),
('W05_WEBP2', 'CC_WEB_P2', '2026-06-04', 5, '13:00:00', '16:00:00', 3),
('W05_OSC', 'CC_OSC', '2026-06-05', 5, '08:00:00', '10:00:00', 2),

-- ================= WEEK 06 (Jun 08 - Jun 12) =================
('W06_MGT', 'CC_MGT', '2026-06-08', 6, '09:00:00', '11:00:00', 2),
('W06_LIN', 'CC_LIN_T', '2026-06-08', 6, '13:00:00', '15:00:00', 2),
('W06_DBP', 'CC_DBP', '2026-06-09', 6, '09:00:00', '12:00:00', 3),
('W06_WEBT', 'CC_WEB_T', '2026-06-09', 6, '13:00:00', '14:00:00', 1),
('W06_WEBP1', 'CC_WEB_P1', '2026-06-09', 6, '14:00:00', '16:00:00', 2),
('W06_MAT', 'CC_MAT', '2026-06-10', 6, '09:00:00', '12:00:00', 3),
('W06_ENG', 'CC_ENG', '2026-06-11', 6, '09:00:00', '10:00:00', 1),
('W06_DBS', 'CC_DBS', '2026-06-11', 6, '10:00:00', '12:00:00', 2),
('W06_WEBP2', 'CC_WEB_P2', '2026-06-11', 6, '13:00:00', '16:00:00', 3),
('W06_OSC', 'CC_OSC', '2026-06-12', 6, '08:00:00', '10:00:00', 2),

-- ================= WEEK 07 (Jun 15 - Jun 19) =================
('W07_MGT', 'CC_MGT', '2026-06-15', 7, '09:00:00', '11:00:00', 2),
('W07_LIN', 'CC_LIN_T', '2026-06-15', 7, '13:00:00', '15:00:00', 2),
('W07_DBP', 'CC_DBP', '2026-06-16', 7, '09:00:00', '12:00:00', 3),
('W07_WEBT', 'CC_WEB_T', '2026-06-16', 7, '13:00:00', '14:00:00', 1),
('W07_WEBP1', 'CC_WEB_P1', '2026-06-16', 7, '14:00:00', '16:00:00', 2),
('W07_MAT', 'CC_MAT', '2026-06-17', 7, '09:00:00', '12:00:00', 3),
('W07_ENG', 'CC_ENG', '2026-06-18', 7, '09:00:00', '10:00:00', 1),
('W07_DBS', 'CC_DBS', '2026-06-18', 7, '10:00:00', '12:00:00', 2),
('W07_WEBP2', 'CC_WEB_P2', '2026-06-18', 7, '13:00:00', '16:00:00', 3),
('W07_OSC', 'CC_OSC', '2026-06-19', 7, '08:00:00', '10:00:00', 2),

-- ================= WEEK 08 (Jun 22 - Jun 26) =================
('W08_MGT', 'CC_MGT', '2026-06-22', 8, '09:00:00', '11:00:00', 2),
('W08_LIN', 'CC_LIN_T', '2026-06-22', 8, '13:00:00', '15:00:00', 2),
('W08_DBP', 'CC_DBP', '2026-06-23', 8, '09:00:00', '12:00:00', 3),
('W08_WEBT', 'CC_WEB_T', '2026-06-23', 8, '13:00:00', '14:00:00', 1),
('W08_WEBP1', 'CC_WEB_P1', '2026-06-23', 8, '14:00:00', '16:00:00', 2),
('W08_MAT', 'CC_MAT', '2026-06-24', 8, '09:00:00', '12:00:00', 3),
('W08_ENG', 'CC_ENG', '2026-06-25', 8, '09:00:00', '10:00:00', 1),
('W08_DBS', 'CC_DBS', '2026-06-25', 8, '10:00:00', '12:00:00', 2),
('W08_WEBP2', 'CC_WEB_P2', '2026-06-25', 8, '13:00:00', '16:00:00', 3),
('W08_OSC', 'CC_OSC', '2026-06-26', 8, '08:00:00', '10:00:00', 2),

-- ================= WEEK 09 (Jun 29 - Jul 03) =================
('W09_MGT', 'CC_MGT', '2026-06-29', 9, '09:00:00', '11:00:00', 2),
('W09_LIN', 'CC_LIN_T', '2026-06-29', 9, '13:00:00', '15:00:00', 2),
('W09_DBP', 'CC_DBP', '2026-06-30', 9, '09:00:00', '12:00:00', 3),
('W09_WEBT', 'CC_WEB_T', '2026-06-30', 9, '13:00:00', '14:00:00', 1),
('W09_WEBP1', 'CC_WEB_P1', '2026-06-30', 9, '14:00:00', '16:00:00', 2),
('W09_MAT', 'CC_MAT', '2026-07-01', 9, '09:00:00', '12:00:00', 3),
('W09_ENG', 'CC_ENG', '2026-07-02', 9, '09:00:00', '10:00:00', 1),
('W09_DBS', 'CC_DBS', '2026-07-02', 9, '10:00:00', '12:00:00', 2),
('W09_WEBP2', 'CC_WEB_P2', '2026-07-02', 9, '13:00:00', '16:00:00', 3),
('W09_OSC', 'CC_OSC', '2026-07-03', 9, '08:00:00', '10:00:00', 2),

-- ================= WEEK 10 (Jul 06 - Jul 10) =================
('W10_MGT', 'CC_MGT', '2026-07-06', 10, '09:00:00', '11:00:00', 2),
('W10_LIN', 'CC_LIN_T', '2026-07-06', 10, '13:00:00', '15:00:00', 2),
('W10_DBP', 'CC_DBP', '2026-07-07', 10, '09:00:00', '12:00:00', 3),
('W10_WEBT', 'CC_WEB_T', '2026-07-07', 10, '13:00:00', '14:00:00', 1),
('W10_WEBP1', 'CC_WEB_P1', '2026-07-07', 10, '14:00:00', '16:00:00', 2),
('W10_MAT', 'CC_MAT', '2026-07-08', 10, '09:00:00', '12:00:00', 3),
('W10_ENG', 'CC_ENG', '2026-07-09', 10, '09:00:00', '10:00:00', 1),
('W10_DBS', 'CC_DBS', '2026-07-09', 10, '10:00:00', '12:00:00', 2),
('W10_WEBP2', 'CC_WEB_P2', '2026-07-09', 10, '13:00:00', '16:00:00', 3),
('W10_OSC', 'CC_OSC', '2026-07-10', 10, '08:00:00', '10:00:00', 2),

-- ================= WEEK 11 (Jul 13 - Jul 17) =================
('W11_MGT', 'CC_MGT', '2026-07-13', 11, '09:00:00', '11:00:00', 2),
('W11_LIN', 'CC_LIN_T', '2026-07-13', 11, '13:00:00', '15:00:00', 2),
('W11_DBP', 'CC_DBP', '2026-07-14', 11, '09:00:00', '12:00:00', 3),
('W11_WEBT', 'CC_WEB_T', '2026-07-14', 11, '13:00:00', '14:00:00', 1),
('W11_WEBP1', 'CC_WEB_P1', '2026-07-14', 11, '14:00:00', '16:00:00', 2),
('W11_MAT', 'CC_MAT', '2026-07-15', 11, '09:00:00', '12:00:00', 3),
('W11_ENG', 'CC_ENG', '2026-07-16', 11, '09:00:00', '10:00:00', 1),
('W11_DBS', 'CC_DBS', '2026-07-16', 11, '10:00:00', '12:00:00', 2),
('W11_WEBP2', 'CC_WEB_P2', '2026-07-16', 11, '13:00:00', '16:00:00', 3),
('W11_OSC', 'CC_OSC', '2026-07-17', 11, '08:00:00', '10:00:00', 2),

-- ================= WEEK 12 (Jul 20 - Jul 24) =================
('W12_MGT', 'CC_MGT', '2026-07-20', 12, '09:00:00', '11:00:00', 2),
('W12_LIN', 'CC_LIN_T', '2026-07-20', 12, '13:00:00', '15:00:00', 2),
('W12_DBP', 'CC_DBP', '2026-07-21', 12, '09:00:00', '12:00:00', 3),
('W12_WEBT', 'CC_WEB_T', '2026-07-21', 12, '13:00:00', '14:00:00', 1),
('W12_WEBP1', 'CC_WEB_P1', '2026-07-21', 12, '14:00:00', '16:00:00', 2),
('W12_MAT', 'CC_MAT', '2026-07-22', 12, '09:00:00', '12:00:00', 3),
('W12_ENG', 'CC_ENG', '2026-07-23', 12, '09:00:00', '10:00:00', 1),
('W12_DBS', 'CC_DBS', '2026-07-23', 12, '10:00:00', '12:00:00', 2),
('W12_WEBP2', 'CC_WEB_P2', '2026-07-23', 12, '13:00:00', '16:00:00', 3),
('W12_OSC', 'CC_OSC', '2026-07-24', 12, '08:00:00', '10:00:00', 2),

-- ================= WEEK 13 (Jul 27 - Jul 31) =================
('W13_MGT', 'CC_MGT', '2026-07-27', 13, '09:00:00', '11:00:00', 2),
('W13_LIN', 'CC_LIN_T', '2026-07-27', 13, '13:00:00', '15:00:00', 2),
('W13_DBP', 'CC_DBP', '2026-07-28', 13, '09:00:00', '12:00:00', 3),
('W13_WEBT', 'CC_WEB_T', '2026-07-28', 13, '13:00:00', '14:00:00', 1),
('W13_WEBP1', 'CC_WEB_P1', '2026-07-28', 13, '14:00:00', '16:00:00', 2),
('W13_MAT', 'CC_MAT', '2026-07-29', 13, '09:00:00', '12:00:00', 3),
('W13_ENG', 'CC_ENG', '2026-07-30', 13, '09:00:00', '10:00:00', 1),
('W13_DBS', 'CC_DBS', '2026-07-30', 13, '10:00:00', '12:00:00', 2),
('W13_WEBP2', 'CC_WEB_P2', '2026-07-30', 13, '13:00:00', '16:00:00', 3),
('W13_OSC', 'CC_OSC', '2026-07-31', 13, '08:00:00', '10:00:00', 2),

-- ================= WEEK 14 (Aug 03 - Aug 07) =================
('W14_MGT', 'CC_MGT', '2026-08-03', 14, '09:00:00', '11:00:00', 2),
('W14_LIN', 'CC_LIN_T', '2026-08-03', 14, '13:00:00', '15:00:00', 2),
('W14_DBP', 'CC_DBP', '2026-08-04', 14, '09:00:00', '12:00:00', 3),
('W14_WEBT', 'CC_WEB_T', '2026-08-04', 14, '13:00:00', '14:00:00', 1),
('W14_WEBP1', 'CC_WEB_P1', '2026-08-04', 14, '14:00:00', '16:00:00', 2),
('W14_MAT', 'CC_MAT', '2026-08-05', 14, '09:00:00', '12:00:00', 3),
('W14_ENG', 'CC_ENG', '2026-08-06', 14, '09:00:00', '10:00:00', 1),
('W14_DBS', 'CC_DBS', '2026-08-06', 14, '10:00:00', '12:00:00', 2),
('W14_WEBP2', 'CC_WEB_P2', '2026-08-06', 14, '13:00:00', '16:00:00', 3),
('W14_OSC', 'CC_OSC', '2026-08-07', 14, '08:00:00', '10:00:00', 2),

-- ================= WEEK 15 (Aug 10 - Aug 14) =================
('W15_MGT', 'CC_MGT', '2026-08-10', 15, '09:00:00', '11:00:00', 2),
('W15_LIN', 'CC_LIN_T', '2026-08-10', 15, '13:00:00', '15:00:00', 2),
('W15_DBP', 'CC_DBP', '2026-08-11', 15, '09:00:00', '12:00:00', 3),
('W15_WEBT', 'CC_WEB_T', '2026-08-11', 15, '13:00:00', '14:00:00', 1),
('W15_WEBP1', 'CC_WEB_P1', '2026-08-11', 15, '14:00:00', '16:00:00', 2),
('W15_MAT', 'CC_MAT', '2026-08-12', 15, '09:00:00', '12:00:00', 3),
('W15_ENG', 'CC_ENG', '2026-08-13', 15, '09:00:00', '10:00:00', 1),
('W15_DBS', 'CC_DBS', '2026-08-13', 15, '10:00:00', '12:00:00', 2),
('W15_WEBP2', 'CC_WEB_P2', '2026-08-13', 15, '13:00:00', '16:00:00', 3),
('W15_OSC', 'CC_OSC', '2026-08-14', 15, '08:00:00', '10:00:00', 2);

-- =========================================================================
-- MASSIVE ATTENDANCE RECORDS (WEEK 1 TO WEEK 5) - FOR 10 STUDENTS
-- =========================================================================

INSERT INTO ATTENDANCE_RECORD (Attendance_ID, session_id, student_id, marked_by, attendance_status, marked_date) VALUES

-- ================= WEEK 01 =================

('A_W01_MGT_01','W01_MGT','S01','ST03','Present','2026-05-04'),
('A_W01_MGT_02','W01_MGT','S02','ST03','Present','2026-05-04'),
('A_W01_MGT_03','W01_MGT','S03','ST03','Present','2026-05-04'),
('A_W01_MGT_04','W01_MGT','S04','ST03','Present','2026-05-04'),
('A_W01_MGT_05','W01_MGT','S05','ST03','Present','2026-05-04'),
('A_W01_MGT_06','W01_MGT','S06','ST03','Present','2026-05-04'),
('A_W01_MGT_07','W01_MGT','S07','ST03','Present','2026-05-04'),
('A_W01_MGT_08','W01_MGT','S08','ST03','Present','2026-05-04'),
('A_W01_MGT_09','W01_MGT','S09','ST03','Present','2026-05-04'),
('A_W01_MGT_10','W01_MGT','S10','ST03','Present','2026-05-04'),
('A_W01_MGT_11','W01_MGT','S11','ST03','Present','2026-05-04'),

('A_W01_LIN_01','W01_LIN','S01','ST04','Present','2026-05-04'),
('A_W01_LIN_02','W01_LIN','S02','ST04','Present','2026-05-04'),
('A_W01_LIN_03','W01_LIN','S03','ST04','Absent','2026-05-04'),
('A_W01_LIN_04','W01_LIN','S04','ST04','Present','2026-05-04'),
('A_W01_LIN_05','W01_LIN','S05','ST04','Present','2026-05-04'),
('A_W01_LIN_06','W01_LIN','S06','ST04','Present','2026-05-04'),
('A_W01_LIN_07','W01_LIN','S07','ST04','Present','2026-05-04'),
('A_W01_LIN_08','W01_LIN','S08','ST04','Present','2026-05-04'),
('A_W01_LIN_09','W01_LIN','S09','ST04','Present','2026-05-04'),
('A_W01_LIN_10','W01_LIN','S10','ST04','Present','2026-05-04'),

('A_W01_DBP_01','W01_DBP','S01','ST05','Present','2026-05-05'),
('A_W01_DBP_02','W01_DBP','S02','ST05','Present','2026-05-05'),
('A_W01_DBP_03','W01_DBP','S03','ST05','Present','2026-05-05'),
('A_W01_DBP_04','W01_DBP','S04','ST05','Present','2026-05-05'),
('A_W01_DBP_05','W01_DBP','S05','ST05','Present','2026-05-05'),
('A_W01_DBP_06','W01_DBP','S06','ST05','Present','2026-05-05'),
('A_W01_DBP_07','W01_DBP','S07','ST05','Present','2026-05-05'),
('A_W01_DBP_08','W01_DBP','S08','ST05','Present','2026-05-05'),
('A_W01_DBP_09','W01_DBP','S09','ST05','Present','2026-05-05'),
('A_W01_DBP_10','W01_DBP','S10','ST05','Present','2026-05-05'),

('A_W01_WEBT_01','W01_WEBT','S01','ST06','Present','2026-05-05'),
('A_W01_WEBT_02','W01_WEBT','S02','ST06','Present','2026-05-05'),
('A_W01_WEBT_03','W01_WEBT','S03','ST06','Present','2026-05-05'),
('A_W01_WEBT_04','W01_WEBT','S04','ST06','Present','2026-05-05'),
('A_W01_WEBT_05','W01_WEBT','S05','ST06','Present','2026-05-05'),
('A_W01_WEBT_06','W01_WEBT','S06','ST06','Present','2026-05-05'),
('A_W01_WEBT_07','W01_WEBT','S07','ST06','Present','2026-05-05'),
('A_W01_WEBT_08','W01_WEBT','S08','ST06','Present','2026-05-05'),
('A_W01_WEBT_09','W01_WEBT','S09','ST06','Present','2026-05-05'),
('A_W01_WEBT_10','W01_WEBT','S10','ST06','Present','2026-05-05'),

('A_W01_WEBP1_01','W01_WEBP1','S01','ST07','Present','2026-05-05'),
('A_W01_WEBP1_02','W01_WEBP1','S02','ST07','Present','2026-05-05'),
('A_W01_WEBP1_03','W01_WEBP1','S03','ST07','Present','2026-05-05'),
('A_W01_WEBP1_04','W01_WEBP1','S04','ST07','Present','2026-05-05'),
('A_W01_WEBP1_05','W01_WEBP1','S05','ST07','Present','2026-05-05'),
('A_W01_WEBP1_06','W01_WEBP1','S06','ST07','Present','2026-05-05'),
('A_W01_WEBP1_07','W01_WEBP1','S07','ST07','Present','2026-05-05'),
('A_W01_WEBP1_08','W01_WEBP1','S08','ST07','Present','2026-05-05'),
('A_W01_WEBP1_09','W01_WEBP1','S09','ST07','Present','2026-05-05'),
('A_W01_WEBP1_10','W01_WEBP1','S10','ST07','Present','2026-05-05'),

('A_W01_MAT_01','W01_MAT','S01','ST08','Present','2026-05-06'),
('A_W01_MAT_02','W01_MAT','S02','ST08','Present','2026-05-06'),
('A_W01_MAT_03','W01_MAT','S03','ST08','Present','2026-05-06'),
('A_W01_MAT_04','W01_MAT','S04','ST08','Present','2026-05-06'),
('A_W01_MAT_05','W01_MAT','S05','ST08','Present','2026-05-06'),
('A_W01_MAT_06','W01_MAT','S06','ST08','Present','2026-05-06'),
('A_W01_MAT_07','W01_MAT','S07','ST08','Present','2026-05-06'),
('A_W01_MAT_08','W01_MAT','S08','ST08','Present','2026-05-06'),
('A_W01_MAT_09','W01_MAT','S09','ST08','Absent','2026-05-06'),
('A_W01_MAT_10','W01_MAT','S10','ST08','Present','2026-05-06'),

('A_W01_ENG_01','W01_ENG','S01','ST09','Present','2026-05-07'),
('A_W01_ENG_02','W01_ENG','S02','ST09','Present','2026-05-07'),
('A_W01_ENG_03','W01_ENG','S03','ST09','Present','2026-05-07'),
('A_W01_ENG_04','W01_ENG','S04','ST09','Present','2026-05-07'),
('A_W01_ENG_05','W01_ENG','S05','ST09','Present','2026-05-07'),
('A_W01_ENG_06','W01_ENG','S06','ST09','Present','2026-05-07'),
('A_W01_ENG_07','W01_ENG','S07','ST09','Present','2026-05-07'),
('A_W01_ENG_08','W01_ENG','S08','ST09','Present','2026-05-07'),
('A_W01_ENG_09','W01_ENG','S09','ST09','Present','2026-05-07'),
('A_W01_ENG_10','W01_ENG','S10','ST09','Present','2026-05-07'),

('A_W01_DBS_01','W01_DBS','S01','ST10','Present','2026-05-07'),
('A_W01_DBS_02','W01_DBS','S02','ST10','Present','2026-05-07'),
('A_W01_DBS_03','W01_DBS','S03','ST10','Present','2026-05-07'),
('A_W01_DBS_04','W01_DBS','S04','ST10','Medical','2026-05-07'),
('A_W01_DBS_05','W01_DBS','S05','ST10','Present','2026-05-07'),
('A_W01_DBS_06','W01_DBS','S06','ST10','Present','2026-05-07'),
('A_W01_DBS_07','W01_DBS','S07','ST10','Present','2026-05-07'),
('A_W01_DBS_08','W01_DBS','S08','ST10','Present','2026-05-07'),
('A_W01_DBS_09','W01_DBS','S09','ST10','Present','2026-05-07'),
('A_W01_DBS_10','W01_DBS','S10','ST10','Present','2026-05-07'),

('A_W01_WEBP2_01','W01_WEBP2','S01','ST07','Present','2026-05-07'),
('A_W01_WEBP2_02','W01_WEBP2','S02','ST07','Present','2026-05-07'),
('A_W01_WEBP2_03','W01_WEBP2','S03','ST07','Present','2026-05-07'),
('A_W01_WEBP2_04','W01_WEBP2','S04','ST07','Present','2026-05-07'),
('A_W01_WEBP2_05','W01_WEBP2','S05','ST07','Present','2026-05-07'),
('A_W01_WEBP2_06','W01_WEBP2','S06','ST07','Present','2026-05-07'),
('A_W01_WEBP2_07','W01_WEBP2','S07','ST07','Present','2026-05-07'),
('A_W01_WEBP2_08','W01_WEBP2','S08','ST07','Present','2026-05-07'),
('A_W01_WEBP2_09','W01_WEBP2','S09','ST07','Present','2026-05-07'),
('A_W01_WEBP2_10','W01_WEBP2','S10','ST07','Present','2026-05-07'),

('A_W01_OSC_01','W01_OSC','S01','ST03','Present','2026-05-08'),
('A_W01_OSC_02','W01_OSC','S02','ST03','Present','2026-05-08'),
('A_W01_OSC_03','W01_OSC','S03','ST03','Present','2026-05-08'),
('A_W01_OSC_04','W01_OSC','S04','ST03','Present','2026-05-08'),
('A_W01_OSC_05','W01_OSC','S05','ST03','Absent','2026-05-08'),
('A_W01_OSC_06','W01_OSC','S06','ST03','Present','2026-05-08'),
('A_W01_OSC_07','W01_OSC','S07','ST03','Present','2026-05-08'),
('A_W01_OSC_08','W01_OSC','S08','ST03','Present','2026-05-08'),
('A_W01_OSC_09','W01_OSC','S09','ST03','Present','2026-05-08'),
('A_W01_OSC_10','W01_OSC','S10','ST03','Present','2026-05-08'),

-- ================= WEEK 02 =================

('A_W02_MGT_01','W02_MGT','S01','ST03','Present','2026-05-11'),
('A_W02_MGT_02','W02_MGT','S02','ST03','Present','2026-05-11'),
('A_W02_MGT_03','W02_MGT','S03','ST03','Present','2026-05-11'),
('A_W02_MGT_04','W02_MGT','S04','ST03','Present','2026-05-11'),
('A_W02_MGT_05','W02_MGT','S05','ST03','Present','2026-05-11'),
('A_W02_MGT_06','W02_MGT','S06','ST03','Present','2026-05-11'),
('A_W02_MGT_07','W02_MGT','S07','ST03','Present','2026-05-11'),
('A_W02_MGT_08','W02_MGT','S08','ST03','Present','2026-05-11'),
('A_W02_MGT_09','W02_MGT','S09','ST03','Present','2026-05-11'),
('A_W02_MGT_10','W02_MGT','S10','ST03','Present','2026-05-11'),

('A_W02_LIN_01','W02_LIN','S01','ST04','Present','2026-05-11'),
('A_W02_LIN_02','W02_LIN','S02','ST04','Present','2026-05-11'),
('A_W02_LIN_03','W02_LIN','S03','ST04','Present','2026-05-11'),
('A_W02_LIN_04','W02_LIN','S04','ST04','Medical','2026-05-11'),
('A_W02_LIN_05','W02_LIN','S05','ST04','Present','2026-05-11'),
('A_W02_LIN_06','W02_LIN','S06','ST04','Present','2026-05-11'),
('A_W02_LIN_07','W02_LIN','S07','ST04','Present','2026-05-11'),
('A_W02_LIN_08','W02_LIN','S08','ST04','Present','2026-05-11'),
('A_W02_LIN_09','W02_LIN','S09','ST04','Present','2026-05-11'),
('A_W02_LIN_10','W02_LIN','S10','ST04','Present','2026-05-11'),

('A_W02_DBP_01','W02_DBP','S01','ST05','Present','2026-05-12'),
('A_W02_DBP_02','W02_DBP','S02','ST05','Present','2026-05-12'),
('A_W02_DBP_03','W02_DBP','S03','ST05','Present','2026-05-12'),
('A_W02_DBP_04','W02_DBP','S04','ST05','Present','2026-05-12'),
('A_W02_DBP_05','W02_DBP','S05','ST05','Present','2026-05-12'),
('A_W02_DBP_06','W02_DBP','S06','ST05','Present','2026-05-12'),
('A_W02_DBP_07','W02_DBP','S07','ST05','Present','2026-05-12'),
('A_W02_DBP_08','W02_DBP','S08','ST05','Present','2026-05-12'),
('A_W02_DBP_09','W02_DBP','S09','ST05','Present','2026-05-12'),
('A_W02_DBP_10','W02_DBP','S10','ST05','Present','2026-05-12'),

('A_W02_WEBT_01','W02_WEBT','S01','ST06','Present','2026-05-12'),
('A_W02_WEBT_02','W02_WEBT','S02','ST06','Present','2026-05-12'),
('A_W02_WEBT_03','W02_WEBT','S03','ST06','Present','2026-05-12'),
('A_W02_WEBT_04','W02_WEBT','S04','ST06','Present','2026-05-12'),
('A_W02_WEBT_05','W02_WEBT','S05','ST06','Present','2026-05-12'),
('A_W02_WEBT_06','W02_WEBT','S06','ST06','Present','2026-05-12'),
('A_W02_WEBT_07','W02_WEBT','S07','ST06','Present','2026-05-12'),
('A_W02_WEBT_08','W02_WEBT','S08','ST06','Present','2026-05-12'),
('A_W02_WEBT_09','W02_WEBT','S09','ST06','Present','2026-05-12'),
('A_W02_WEBT_10','W02_WEBT','S10','ST06','Present','2026-05-12'),

('A_W02_WEBP1_01','W02_WEBP1','S01','ST07','Present','2026-05-12'),
('A_W02_WEBP1_02','W02_WEBP1','S02','ST07','Present','2026-05-12'),
('A_W02_WEBP1_03','W02_WEBP1','S03','ST07','Present','2026-05-12'),
('A_W02_WEBP1_04','W02_WEBP1','S04','ST07','Present','2026-05-12'),
('A_W02_WEBP1_05','W02_WEBP1','S05','ST07','Present','2026-05-12'),
('A_W02_WEBP1_06','W02_WEBP1','S06','ST07','Present','2026-05-12'),
('A_W02_WEBP1_07','W02_WEBP1','S07','ST07','Present','2026-05-12'),
('A_W02_WEBP1_08','W02_WEBP1','S08','ST07','Present','2026-05-12'),
('A_W02_WEBP1_09','W02_WEBP1','S09','ST07','Present','2026-05-12'),
('A_W02_WEBP1_10','W02_WEBP1','S10','ST07','Present','2026-05-12'),

('A_W02_MAT_01','W02_MAT','S01','ST08','Present','2026-05-13'),
('A_W02_MAT_02','W02_MAT','S02','ST08','Present','2026-05-13'),
('A_W02_MAT_03','W02_MAT','S03','ST08','Present','2026-05-13'),
('A_W02_MAT_04','W02_MAT','S04','ST08','Present','2026-05-13'),
('A_W02_MAT_05','W02_MAT','S05','ST08','Present','2026-05-13'),
('A_W02_MAT_06','W02_MAT','S06','ST08','Present','2026-05-13'),
('A_W02_MAT_07','W02_MAT','S07','ST08','Present','2026-05-13'),
('A_W02_MAT_08','W02_MAT','S08','ST08','Present','2026-05-13'),
('A_W02_MAT_09','W02_MAT','S09','ST08','Present','2026-05-13'),
('A_W02_MAT_10','W02_MAT','S10','ST08','Present','2026-05-13'),

('A_W02_ENG_01','W02_ENG','S01','ST09','Present','2026-05-14'),
('A_W02_ENG_02','W02_ENG','S02','ST09','Present','2026-05-14'),
('A_W02_ENG_03','W02_ENG','S03','ST09','Present','2026-05-14'),
('A_W02_ENG_04','W02_ENG','S04','ST09','Present','2026-05-14'),
('A_W02_ENG_05','W02_ENG','S05','ST09','Present','2026-05-14'),
('A_W02_ENG_06','W02_ENG','S06','ST09','Absent','2026-05-14'),
('A_W02_ENG_07','W02_ENG','S07','ST09','Present','2026-05-14'),
('A_W02_ENG_08','W02_ENG','S08','ST09','Present','2026-05-14'),
('A_W02_ENG_09','W02_ENG','S09','ST09','Present','2026-05-14'),
('A_W02_ENG_10','W02_ENG','S10','ST09','Present','2026-05-14'),

('A_W02_DBS_01','W02_DBS','S01','ST10','Present','2026-05-14'),
('A_W02_DBS_02','W02_DBS','S02','ST10','Present','2026-05-14'),
('A_W02_DBS_03','W02_DBS','S03','ST10','Present','2026-05-14'),
('A_W02_DBS_04','W02_DBS','S04','ST10','Present','2026-05-14'),
('A_W02_DBS_05','W02_DBS','S05','ST10','Present','2026-05-14'),
('A_W02_DBS_06','W02_DBS','S06','ST10','Present','2026-05-14'),
('A_W02_DBS_07','W02_DBS','S07','ST10','Present','2026-05-14'),
('A_W02_DBS_08','W02_DBS','S08','ST10','Present','2026-05-14'),
('A_W02_DBS_09','W02_DBS','S09','ST10','Present','2026-05-14'),
('A_W02_DBS_10','W02_DBS','S10','ST10','Present','2026-05-14'),

('A_W02_WEBP2_01','W02_WEBP2','S01','ST07','Present','2026-05-14'),
('A_W02_WEBP2_02','W02_WEBP2','S02','ST07','Present','2026-05-14'),
('A_W02_WEBP2_03','W02_WEBP2','S03','ST07','Present','2026-05-14'),
('A_W02_WEBP2_04','W02_WEBP2','S04','ST07','Present','2026-05-14'),
('A_W02_WEBP2_05','W02_WEBP2','S05','ST07','Present','2026-05-14'),
('A_W02_WEBP2_06','W02_WEBP2','S06','ST07','Present','2026-05-14'),
('A_W02_WEBP2_07','W02_WEBP2','S07','ST07','Present','2026-05-14'),
('A_W02_WEBP2_08','W02_WEBP2','S08','ST07','Present','2026-05-14'),
('A_W02_WEBP2_09','W02_WEBP2','S09','ST07','Present','2026-05-14'),
('A_W02_WEBP2_10','W02_WEBP2','S10','ST07','Present','2026-05-14'),

('A_W02_OSC_01','W02_OSC','S01','ST03','Present','2026-05-15'),
('A_W02_OSC_02','W02_OSC','S02','ST03','Present','2026-05-15'),
('A_W02_OSC_03','W02_OSC','S03','ST03','Present','2026-05-15'),
('A_W02_OSC_04','W02_OSC','S04','ST03','Present','2026-05-15'),
('A_W02_OSC_05','W02_OSC','S05','ST03','Present','2026-05-15'),
('A_W02_OSC_06','W02_OSC','S06','ST03','Present','2026-05-15'),
('A_W02_OSC_07','W02_OSC','S07','ST03','Present','2026-05-15'),
('A_W02_OSC_08','W02_OSC','S08','ST03','Present','2026-05-15'),
('A_W02_OSC_09','W02_OSC','S09','ST03','Present','2026-05-15'),
('A_W02_OSC_10','W02_OSC','S10','ST03','Present','2026-05-15'),

-- ================= WEEK 03 =================

('A_W03_MGT_01','W03_MGT','S01','ST03','Present','2026-05-18'),
('A_W03_MGT_02','W03_MGT','S02','ST03','Present','2026-05-18'),
('A_W03_MGT_03','W03_MGT','S03','ST03','Present','2026-05-18'),
('A_W03_MGT_04','W03_MGT','S04','ST03','Present','2026-05-18'),
('A_W03_MGT_05','W03_MGT','S05','ST03','Present','2026-05-18'),
('A_W03_MGT_06','W03_MGT','S06','ST03','Present','2026-05-18'),
('A_W03_MGT_07','W03_MGT','S07','ST03','Present','2026-05-18'),
('A_W03_MGT_08','W03_MGT','S08','ST03','Present','2026-05-18'),
('A_W03_MGT_09','W03_MGT','S09','ST03','Present','2026-05-18'),
('A_W03_MGT_10','W03_MGT','S10','ST03','Present','2026-05-18'),

('A_W03_LIN_01','W03_LIN','S01','ST04','Present','2026-05-18'),
('A_W03_LIN_02','W03_LIN','S02','ST04','Present','2026-05-18'),
('A_W03_LIN_03','W03_LIN','S03','ST04','Present','2026-05-18'),
('A_W03_LIN_04','W03_LIN','S04','ST04','Present','2026-05-18'),
('A_W03_LIN_05','W03_LIN','S05','ST04','Present','2026-05-18'),
('A_W03_LIN_06','W03_LIN','S06','ST04','Present','2026-05-18'),
('A_W03_LIN_07','W03_LIN','S07','ST04','Present','2026-05-18'),
('A_W03_LIN_08','W03_LIN','S08','ST04','Present','2026-05-18'),
('A_W03_LIN_09','W03_LIN','S09','ST04','Present','2026-05-18'),
('A_W03_LIN_10','W03_LIN','S10','ST04','Present','2026-05-18'),

('A_W03_DBP_01','W03_DBP','S01','ST05','Present','2026-05-19'),
('A_W03_DBP_02','W03_DBP','S02','ST05','Present','2026-05-19'),
('A_W03_DBP_03','W03_DBP','S03','ST05','Present','2026-05-19'),
('A_W03_DBP_04','W03_DBP','S04','ST05','Present','2026-05-19'),
('A_W03_DBP_05','W03_DBP','S05','ST05','Present','2026-05-19'),
('A_W03_DBP_06','W03_DBP','S06','ST05','Present','2026-05-19'),
('A_W03_DBP_07','W03_DBP','S07','ST05','Present','2026-05-19'),
('A_W03_DBP_08','W03_DBP','S08','ST05','Present','2026-05-19'),
('A_W03_DBP_09','W03_DBP','S09','ST05','Present','2026-05-19'),
('A_W03_DBP_10','W03_DBP','S10','ST05','Present','2026-05-19'),

('A_W03_WEBT_01','W03_WEBT','S01','ST06','Present','2026-05-19'),
('A_W03_WEBT_02','W03_WEBT','S02','ST06','Present','2026-05-19'),
('A_W03_WEBT_03','W03_WEBT','S03','ST06','Present','2026-05-19'),
('A_W03_WEBT_04','W03_WEBT','S04','ST06','Present','2026-05-19'),
('A_W03_WEBT_05','W03_WEBT','S05','ST06','Present','2026-05-19'),
('A_W03_WEBT_06','W03_WEBT','S06','ST06','Present','2026-05-19'),
('A_W03_WEBT_07','W03_WEBT','S07','ST06','Present','2026-05-19'),
('A_W03_WEBT_08','W03_WEBT','S08','ST06','Present','2026-05-19'),
('A_W03_WEBT_09','W03_WEBT','S09','ST06','Present','2026-05-19'),
('A_W03_WEBT_10','W03_WEBT','S10','ST06','Present','2026-05-19'),

('A_W03_WEBP1_01','W03_WEBP1','S01','ST07','Present','2026-05-19'),
('A_W03_WEBP1_02','W03_WEBP1','S02','ST07','Present','2026-05-19'),
('A_W03_WEBP1_03','W03_WEBP1','S03','ST07','Present','2026-05-19'),
('A_W03_WEBP1_04','W03_WEBP1','S04','ST07','Present','2026-05-19'),
('A_W03_WEBP1_05','W03_WEBP1','S05','ST07','Present','2026-05-19'),
('A_W03_WEBP1_06','W03_WEBP1','S06','ST07','Present','2026-05-19'),
('A_W03_WEBP1_07','W03_WEBP1','S07','ST07','Present','2026-05-19'),
('A_W03_WEBP1_08','W03_WEBP1','S08','ST07','Present','2026-05-19'),
('A_W03_WEBP1_09','W03_WEBP1','S09','ST07','Present','2026-05-19'),
('A_W03_WEBP1_10','W03_WEBP1','S10','ST07','Present','2026-05-19'),

('A_W03_MAT_01','W03_MAT','S01','ST08','Present','2026-05-20'),
('A_W03_MAT_02','W03_MAT','S02','ST08','Present','2026-05-20'),
('A_W03_MAT_03','W03_MAT','S03','ST08','Present','2026-05-20'),
('A_W03_MAT_04','W03_MAT','S04','ST08','Present','2026-05-20'),
('A_W03_MAT_05','W03_MAT','S05','ST08','Present','2026-05-20'),
('A_W03_MAT_06','W03_MAT','S06','ST08','Present','2026-05-20'),
('A_W03_MAT_07','W03_MAT','S07','ST08','Medical','2026-05-20'),
('A_W03_MAT_08','W03_MAT','S08','ST08','Present','2026-05-20'),
('A_W03_MAT_09','W03_MAT','S09','ST08','Present','2026-05-20'),
('A_W03_MAT_10','W03_MAT','S10','ST08','Present','2026-05-20'),

('A_W03_ENG_01','W03_ENG','S01','ST09','Present','2026-05-21'),
('A_W03_ENG_02','W03_ENG','S02','ST09','Present','2026-05-21'),
('A_W03_ENG_03','W03_ENG','S03','ST09','Present','2026-05-21'),
('A_W03_ENG_04','W03_ENG','S04','ST09','Present','2026-05-21'),
('A_W03_ENG_05','W03_ENG','S05','ST09','Present','2026-05-21'),
('A_W03_ENG_06','W03_ENG','S06','ST09','Present','2026-05-21'),
('A_W03_ENG_07','W03_ENG','S07','ST09','Present','2026-05-21'),
('A_W03_ENG_08','W03_ENG','S08','ST09','Present','2026-05-21'),
('A_W03_ENG_09','W03_ENG','S09','ST09','Present','2026-05-21'),
('A_W03_ENG_10','W03_ENG','S10','ST09','Present','2026-05-21'),

('A_W03_DBS_01','W03_DBS','S01','ST10','Present','2026-05-21'),
('A_W03_DBS_02','W03_DBS','S02','ST10','Present','2026-05-21'),
('A_W03_DBS_03','W03_DBS','S03','ST10','Present','2026-05-21'),
('A_W03_DBS_04','W03_DBS','S04','ST10','Present','2026-05-21'),
('A_W03_DBS_05','W03_DBS','S05','ST10','Present','2026-05-21'),
('A_W03_DBS_06','W03_DBS','S06','ST10','Present','2026-05-21'),
('A_W03_DBS_07','W03_DBS','S07','ST10','Present','2026-05-21'),
('A_W03_DBS_08','W03_DBS','S08','ST10','Present','2026-05-21'),
('A_W03_DBS_09','W03_DBS','S09','ST10','Present','2026-05-21'),
('A_W03_DBS_10','W03_DBS','S10','ST10','Present','2026-05-21'),

('A_W03_WEBP2_01','W03_WEBP2','S01','ST07','Present','2026-05-21'),
('A_W03_WEBP2_02','W03_WEBP2','S02','ST07','Present','2026-05-21'),
('A_W03_WEBP2_03','W03_WEBP2','S03','ST07','Present','2026-05-21'),
('A_W03_WEBP2_04','W03_WEBP2','S04','ST07','Present','2026-05-21'),
('A_W03_WEBP2_05','W03_WEBP2','S05','ST07','Present','2026-05-21'),
('A_W03_WEBP2_06','W03_WEBP2','S06','ST07','Present','2026-05-21'),
('A_W03_WEBP2_07','W03_WEBP2','S07','ST07','Present','2026-05-21'),
('A_W03_WEBP2_08','W03_WEBP2','S08','ST07','Present','2026-05-21'),
('A_W03_WEBP2_09','W03_WEBP2','S09','ST07','Present','2026-05-21'),
('A_W03_WEBP2_10','W03_WEBP2','S10','ST07','Present','2026-05-21'),

('A_W03_OSC_01','W03_OSC','S01','ST03','Present','2026-05-22'),
('A_W03_OSC_02','W03_OSC','S02','ST03','Present','2026-05-22'),
('A_W03_OSC_03','W03_OSC','S03','ST03','Present','2026-05-22'),
('A_W03_OSC_04','W03_OSC','S04','ST03','Present','2026-05-22'),
('A_W03_OSC_05','W03_OSC','S05','ST03','Present','2026-05-22'),
('A_W03_OSC_06','W03_OSC','S06','ST03','Present','2026-05-22'),
('A_W03_OSC_07','W03_OSC','S07','ST03','Present','2026-05-22'),
('A_W03_OSC_08','W03_OSC','S08','ST03','Present','2026-05-22'),
('A_W03_OSC_09','W03_OSC','S09','ST03','Absent','2026-05-22'),
('A_W03_OSC_10','W03_OSC','S10','ST03','Present','2026-05-22'),

-- ================= WEEK 04 =================

('A_W04_MGT_01','W04_MGT','S01','ST03','Present','2026-05-25'),
('A_W04_MGT_02','W04_MGT','S02','ST03','Present','2026-05-25'),
('A_W04_MGT_03','W04_MGT','S03','ST03','Present','2026-05-25'),
('A_W04_MGT_04','W04_MGT','S04','ST03','Present','2026-05-25'),
('A_W04_MGT_05','W04_MGT','S05','ST03','Present','2026-05-25'),
('A_W04_MGT_06','W04_MGT','S06','ST03','Present','2026-05-25'),
('A_W04_MGT_07','W04_MGT','S07','ST03','Present','2026-05-25'),
('A_W04_MGT_08','W04_MGT','S08','ST03','Present','2026-05-25'),
('A_W04_MGT_09','W04_MGT','S09','ST03','Present','2026-05-25'),
('A_W04_MGT_10','W04_MGT','S10','ST03','Present','2026-05-25'),

('A_W04_LIN_01','W04_LIN','S01','ST04','Present','2026-05-25'),
('A_W04_LIN_02','W04_LIN','S02','ST04','Present','2026-05-25'),
('A_W04_LIN_03','W04_LIN','S03','ST04','Present','2026-05-25'),
('A_W04_LIN_04','W04_LIN','S04','ST04','Present','2026-05-25'),
('A_W04_LIN_05','W04_LIN','S05','ST04','Present','2026-05-25'),
('A_W04_LIN_07','W04_LIN','S07','ST04','Present','2026-05-25'),
('A_W04_LIN_08','W04_LIN','S08','ST04','Present','2026-05-25'),
('A_W04_LIN_09','W04_LIN','S09','ST04','Present','2026-05-25'),
('A_W04_LIN_10','W04_LIN','S10','ST04','Present','2026-05-25'),

('A_W04_DBP_01','W04_DBP','S01','ST05','Present','2026-05-26'),
('A_W04_DBP_02','W04_DBP','S02','ST05','Present','2026-05-26'),
('A_W04_DBP_03','W04_DBP','S03','ST05','Present','2026-05-26'),
('A_W04_DBP_04','W04_DBP','S04','ST05','Present','2026-05-26'),
('A_W04_DBP_05','W04_DBP','S05','ST05','Present','2026-05-26'),
('A_W04_DBP_06','W04_DBP','S06','ST05','Present','2026-05-26'),
('A_W04_DBP_07','W04_DBP','S07','ST05','Present','2026-05-26'),
('A_W04_DBP_08','W04_DBP','S08','ST05','Present','2026-05-26'),
('A_W04_DBP_09','W04_DBP','S09','ST05','Present','2026-05-26'),
('A_W04_DBP_10','W04_DBP','S10','ST05','Present','2026-05-26'),

('A_W04_WEBT_01','W04_WEBT','S01','ST06','Present','2026-05-26'),
('A_W04_WEBT_02','W04_WEBT','S02','ST06','Present','2026-05-26'),
('A_W04_WEBT_03','W04_WEBT','S03','ST06','Present','2026-05-26'),
('A_W04_WEBT_04','W04_WEBT','S04','ST06','Present','2026-05-26'),
('A_W04_WEBT_05','W04_WEBT','S05','ST06','Present','2026-05-26'),
('A_W04_WEBT_06','W04_WEBT','S06','ST06','Present','2026-05-26'),
('A_W04_WEBT_07','W04_WEBT','S07','ST06','Present','2026-05-26'),
('A_W04_WEBT_08','W04_WEBT','S08','ST06','Present','2026-05-26'),
('A_W04_WEBT_09','W04_WEBT','S09','ST06','Present','2026-05-26'),
('A_W04_WEBT_10','W04_WEBT','S10','ST06','Present','2026-05-26'),

('A_W04_WEBP1_01','W04_WEBP1','S01','ST07','Present','2026-05-26'),
('A_W04_WEBP1_02','W04_WEBP1','S02','ST07','Present','2026-05-26'),
('A_W04_WEBP1_03','W04_WEBP1','S03','ST07','Present','2026-05-26'),
('A_W04_WEBP1_04','W04_WEBP1','S04','ST07','Present','2026-05-26'),
('A_W04_WEBP1_05','W04_WEBP1','S05','ST07','Present','2026-05-26'),
('A_W04_WEBP1_06','W04_WEBP1','S06','ST07','Present','2026-05-26'),
('A_W04_WEBP1_07','W04_WEBP1','S07','ST07','Present','2026-05-26'),
('A_W04_WEBP1_08','W04_WEBP1','S08','ST07','Present','2026-05-26'),
('A_W04_WEBP1_09','W04_WEBP1','S09','ST07','Present','2026-05-26'),
('A_W04_WEBP1_10','W04_WEBP1','S10','ST07','Present','2026-05-26'),

('A_W04_MAT_01','W04_MAT','S01','ST08','Present','2026-05-27'),
('A_W04_MAT_02','W04_MAT','S02','ST08','Present','2026-05-27'),
('A_W04_MAT_03','W04_MAT','S03','ST08','Present','2026-05-27'),
('A_W04_MAT_04','W04_MAT','S04','ST08','Present','2026-05-27'),
('A_W04_MAT_05','W04_MAT','S05','ST08','Present','2026-05-27'),
('A_W04_MAT_06','W04_MAT','S06','ST08','Present','2026-05-27'),
('A_W04_MAT_07','W04_MAT','S07','ST08','Present','2026-05-27'),
('A_W04_MAT_08','W04_MAT','S08','ST08','Present','2026-05-27'),
('A_W04_MAT_09','W04_MAT','S09','ST08','Present','2026-05-27'),
('A_W04_MAT_10','W04_MAT','S10','ST08','Present','2026-05-27'),

('A_W04_ENG_01','W04_ENG','S01','ST09','Present','2026-05-28'),
('A_W04_ENG_02','W04_ENG','S02','ST09','Present','2026-05-28'),
('A_W04_ENG_03','W04_ENG','S03','ST09','Present','2026-05-28'),
('A_W04_ENG_04','W04_ENG','S04','ST09','Present','2026-05-28'),
('A_W04_ENG_05','W04_ENG','S05','ST09','Present','2026-05-28'),
('A_W04_ENG_06','W04_ENG','S06','ST09','Present','2026-05-28'),
('A_W04_ENG_07','W04_ENG','S07','ST09','Present','2026-05-28'),
('A_W04_ENG_08','W04_ENG','S08','ST09','Present','2026-05-28'),
('A_W04_ENG_09','W04_ENG','S09','ST09','Present','2026-05-28'),
('A_W04_ENG_10','W04_ENG','S10','ST09','Present','2026-05-28'),

('A_W04_DBS_01','W04_DBS','S01','ST10','Present','2026-05-28'),
('A_W04_DBS_02','W04_DBS','S02','ST10','Present','2026-05-28'),
('A_W04_DBS_03','W04_DBS','S03','ST10','Present','2026-05-28'),
('A_W04_DBS_04','W04_DBS','S04','ST10','Present','2026-05-28'),
('A_W04_DBS_05','W04_DBS','S05','ST10','Present','2026-05-28'),
('A_W04_DBS_06','W04_DBS','S06','ST10','Present','2026-05-28'),
('A_W04_DBS_07','W04_DBS','S07','ST10','Present','2026-05-28'),
('A_W04_DBS_08','W04_DBS','S08','ST10','Present','2026-05-28'),
('A_W04_DBS_09','W04_DBS','S09','ST10','Present','2026-05-28'),
('A_W04_DBS_10','W04_DBS','S10','ST10','Present','2026-05-28'),

('A_W04_WEBP2_01','W04_WEBP2','S01','ST07','Present','2026-05-28'),
('A_W04_WEBP2_02','W04_WEBP2','S02','ST07','Present','2026-05-28'),
('A_W04_WEBP2_03','W04_WEBP2','S03','ST07','Present','2026-05-28'),
('A_W04_WEBP2_04','W04_WEBP2','S04','ST07','Present','2026-05-28'),
('A_W04_WEBP2_05','W04_WEBP2','S05','ST07','Present','2026-05-28'),
('A_W04_WEBP2_06','W04_WEBP2','S06','ST07','Present','2026-05-28'),
('A_W04_WEBP2_07','W04_WEBP2','S07','ST07','Present','2026-05-28'),
('A_W04_WEBP2_08','W04_WEBP2','S08','ST07','Present','2026-05-28'),
('A_W04_WEBP2_09','W04_WEBP2','S09','ST07','Present','2026-05-28'),
('A_W04_WEBP2_10','W04_WEBP2','S10','ST07','Present','2026-05-28'),

('A_W04_OSC_01','W04_OSC','S01','ST03','Present','2026-05-29'),
('A_W04_OSC_02','W04_OSC','S02','ST03','Present','2026-05-29'),
('A_W04_OSC_03','W04_OSC','S03','ST03','Present','2026-05-29'),
('A_W04_OSC_04','W04_OSC','S04','ST03','Present','2026-05-29'),
('A_W04_OSC_05','W04_OSC','S05','ST03','Present','2026-05-29'),
('A_W04_OSC_06','W04_OSC','S06','ST03','Present','2026-05-29'),
('A_W04_OSC_07','W04_OSC','S07','ST03','Present','2026-05-29'),
('A_W04_OSC_08','W04_OSC','S08','ST03','Present','2026-05-29'),
('A_W04_OSC_09','W04_OSC','S09','ST03','Present','2026-05-29'),
('A_W04_OSC_10','W04_OSC','S10','ST03','Present','2026-05-29'),

-- ================= WEEK 05 =================

('A_W05_MGT_01','W05_MGT','S01','ST03','Present','2026-06-01'),
('A_W05_MGT_02','W05_MGT','S02','ST03','Present','2026-06-01'),
('A_W05_MGT_03','W05_MGT','S03','ST03','Present','2026-06-01'),
('A_W05_MGT_04','W05_MGT','S04','ST03','Present','2026-06-01'),
('A_W05_MGT_05','W05_MGT','S05','ST03','Present','2026-06-01'),
('A_W05_MGT_06','W05_MGT','S06','ST03','Present','2026-06-01'),
('A_W05_MGT_07','W05_MGT','S07','ST03','Present','2026-06-01'),
('A_W05_MGT_08','W05_MGT','S08','ST03','Present','2026-06-01'),
('A_W05_MGT_09','W05_MGT','S09','ST03','Present','2026-06-01'),
('A_W05_MGT_10','W05_MGT','S10','ST03','Present','2026-06-01'),

('A_W05_LIN_01','W05_LIN','S01','ST04','Present','2026-06-01'),
('A_W05_LIN_02','W05_LIN','S02','ST04','Present','2026-06-01'),
('A_W05_LIN_03','W05_LIN','S03','ST04','Present','2026-06-01'),
('A_W05_LIN_04','W05_LIN','S04','ST04','Present','2026-06-01'),
('A_W05_LIN_05','W05_LIN','S05','ST04','Present','2026-06-01'),
('A_W05_LIN_06','W05_LIN','S06','ST04','Present','2026-06-01'),
('A_W05_LIN_07','W05_LIN','S07','ST04','Present','2026-06-01'),
('A_W05_LIN_08','W05_LIN','S08','ST04','Present','2026-06-01'),
('A_W05_LIN_09','W05_LIN','S09','ST04','Present','2026-06-01'),
('A_W05_LIN_10','W05_LIN','S10','ST04','Present','2026-06-01'),

('A_W05_DBP_01','W05_DBP','S01','ST05','Present','2026-06-02'),
('A_W05_DBP_02','W05_DBP','S02','ST05','Present','2026-06-02'),
('A_W05_DBP_03','W05_DBP','S03','ST05','Present','2026-06-02'),
('A_W05_DBP_04','W05_DBP','S04','ST05','Present','2026-06-02'),
('A_W05_DBP_05','W05_DBP','S05','ST05','Present','2026-06-02'),
('A_W05_DBP_06','W05_DBP','S06','ST05','Present','2026-06-02'),
('A_W05_DBP_07','W05_DBP','S07','ST05','Present','2026-06-02'),
('A_W05_DBP_08','W05_DBP','S08','ST05','Present','2026-06-02'),
('A_W05_DBP_09','W05_DBP','S09','ST05','Present','2026-06-02'),
('A_W05_DBP_10','W05_DBP','S10','ST05','Present','2026-06-02'),

('A_W05_WEBT_01','W05_WEBT','S01','ST06','Present','2026-06-02'),
('A_W05_WEBT_02','W05_WEBT','S02','ST06','Present','2026-06-02'),
('A_W05_WEBT_03','W05_WEBT','S03','ST06','Present','2026-06-02'),
('A_W05_WEBT_04','W05_WEBT','S04','ST06','Present','2026-06-02'),
('A_W05_WEBT_05','W05_WEBT','S05','ST06','Present','2026-06-02'),
('A_W05_WEBT_06','W05_WEBT','S06','ST06','Present','2026-06-02'),
('A_W05_WEBT_07','W05_WEBT','S07','ST06','Present','2026-06-02'),
('A_W05_WEBT_08','W05_WEBT','S08','ST06','Present','2026-06-02'),
('A_W05_WEBT_09','W05_WEBT','S09','ST06','Present','2026-06-02'),
('A_W05_WEBT_10','W05_WEBT','S10','ST06','Present','2026-06-02'),

('A_W05_WEBP1_01','W05_WEBP1','S01','ST07','Present','2026-06-02'),
('A_W05_WEBP1_02','W05_WEBP1','S02','ST07','Present','2026-06-02'),
('A_W05_WEBP1_03','W05_WEBP1','S03','ST07','Present','2026-06-02'),
('A_W05_WEBP1_04','W05_WEBP1','S04','ST07','Present','2026-06-02'),
('A_W05_WEBP1_05','W05_WEBP1','S05','ST07','Present','2026-06-02'),
('A_W05_WEBP1_06','W05_WEBP1','S06','ST07','Present','2026-06-02'),
('A_W05_WEBP1_07','W05_WEBP1','S07','ST07','Present','2026-06-02'),
('A_W05_WEBP1_08','W05_WEBP1','S08','ST07','Present','2026-06-02'),
('A_W05_WEBP1_09','W05_WEBP1','S09','ST07','Present','2026-06-02'),
('A_W05_WEBP1_10','W05_WEBP1','S10','ST07','Present','2026-06-02'),

('A_W05_MAT_01','W05_MAT','S01','ST08','Present','2026-06-03'),
('A_W05_MAT_02','W05_MAT','S02','ST08','Present','2026-06-03'),
('A_W05_MAT_03','W05_MAT','S03','ST08','Present','2026-06-03'),
('A_W05_MAT_04','W05_MAT','S04','ST08','Present','2026-06-03'),
('A_W05_MAT_05','W05_MAT','S05','ST08','Present','2026-06-03'),
('A_W05_MAT_06','W05_MAT','S06','ST08','Present','2026-06-03'),
('A_W05_MAT_07','W05_MAT','S07','ST08','Present','2026-06-03'),
('A_W05_MAT_08','W05_MAT','S08','ST08','Present','2026-06-03'),
('A_W05_MAT_09','W05_MAT','S09','ST08','Present','2026-06-03'),
('A_W05_MAT_10','W05_MAT','S10','ST08','Present','2026-06-03'),

('A_W05_ENG_01','W05_ENG','S01','ST09','Present','2026-06-04'),
('A_W05_ENG_02','W05_ENG','S02','ST09','Present','2026-06-04'),
('A_W05_ENG_03','W05_ENG','S03','ST09','Present','2026-06-04'),
('A_W05_ENG_04','W05_ENG','S04','ST09','Present','2026-06-04'),
('A_W05_ENG_05','W05_ENG','S05','ST09','Present','2026-06-04'),
('A_W05_ENG_06','W05_ENG','S06','ST09','Present','2026-06-04'),
('A_W05_ENG_07','W05_ENG','S07','ST09','Present','2026-06-04'),
('A_W05_ENG_08','W05_ENG','S08','ST09','Present','2026-06-04'),
('A_W05_ENG_09','W05_ENG','S09','ST09','Present','2026-06-04'),
('A_W05_ENG_10','W05_ENG','S10','ST09','Present','2026-06-04'),

('A_W05_DBS_01','W05_DBS','S01','ST10','Present','2026-06-04'),
('A_W05_DBS_02','W05_DBS','S02','ST10','Present','2026-06-04'),
('A_W05_DBS_03','W05_DBS','S03','ST10','Present','2026-06-04'),
('A_W05_DBS_04','W05_DBS','S04','ST10','Present','2026-06-04'),
('A_W05_DBS_05','W05_DBS','S05','ST10','Present','2026-06-04'),
('A_W05_DBS_06','W05_DBS','S06','ST10','Present','2026-06-04'),
('A_W05_DBS_07','W05_DBS','S07','ST10','Present','2026-06-04'),
('A_W05_DBS_08','W05_DBS','S08','ST10','Present','2026-06-04'),
('A_W05_DBS_09','W05_DBS','S09','ST10','Present','2026-06-04'),
('A_W05_DBS_10','W05_DBS','S10','ST10','Present','2026-06-04'),

('A_W05_WEBP2_01','W05_WEBP2','S01','ST07','Present','2026-06-04'),
('A_W05_WEBP2_02','W05_WEBP2','S02','ST07','Present','2026-06-04'),
('A_W05_WEBP2_03','W05_WEBP2','S03','ST07','Present','2026-06-04'),
('A_W05_WEBP2_04','W05_WEBP2','S04','ST07','Present','2026-06-04'),
('A_W05_WEBP2_05','W05_WEBP2','S05','ST07','Present','2026-06-04'),
('A_W05_WEBP2_06','W05_WEBP2','S06','ST07','Present','2026-06-04'),
('A_W05_WEBP2_07','W05_WEBP2','S07','ST07','Present','2026-06-04'),
('A_W05_WEBP2_08','W05_WEBP2','S08','ST07','Present','2026-06-04'),
('A_W05_WEBP2_09','W05_WEBP2','S09','ST07','Present','2026-06-04'),
('A_W05_WEBP2_10','W05_WEBP2','S10','ST07','Present','2026-06-04'),

('A_W05_OSC_01','W05_OSC','S01','ST03','Present','2026-06-05'),
('A_W05_OSC_02','W05_OSC','S02','ST03','Present','2026-06-05'),
('A_W05_OSC_03','W05_OSC','S03','ST03','Present','2026-06-05'),
('A_W05_OSC_04','W05_OSC','S04','ST03','Present','2026-06-05'),
('A_W05_OSC_05','W05_OSC','S05','ST03','Present','2026-06-05'),
('A_W05_OSC_06','W05_OSC','S06','ST03','Present','2026-06-05'),
('A_W05_OSC_07','W05_OSC','S07','ST03','Present','2026-06-05'),
('A_W05_OSC_08','W05_OSC','S08','ST03','Present','2026-06-05'),
('A_W05_OSC_09','W05_OSC','S09','ST03','Present','2026-06-05'),
('A_W05_OSC_10','W05_OSC','S10','ST03','Present','2026-06-05');

-- =========================================================================
-- MASSIVE ATTENDANCE RECORDS (WEEK 6 TO WEEK 10) - FOR 10 STUDENTS
-- =========================================================================

INSERT INTO ATTENDANCE_RECORD (Attendance_ID, session_id, student_id, marked_by, attendance_status, marked_date) VALUES

-- ================= WEEK 06 =================

('A_W06_MGT_01','W06_MGT','S01','ST03','Present','2026-06-08'),
('A_W06_MGT_02','W06_MGT','S02','ST03','Present','2026-06-08'),
('A_W06_MGT_03','W06_MGT','S03','ST03','Present','2026-06-08'),
('A_W06_MGT_04','W06_MGT','S04','ST03','Present','2026-06-08'),
('A_W06_MGT_05','W06_MGT','S05','ST03','Present','2026-06-08'),
('A_W06_MGT_06','W06_MGT','S06','ST03','Present','2026-06-08'),
('A_W06_MGT_07','W06_MGT','S07','ST03','Present','2026-06-08'),
('A_W06_MGT_08','W06_MGT','S08','ST03','Present','2026-06-08'),
('A_W06_MGT_09','W06_MGT','S09','ST03','Present','2026-06-08'),
('A_W06_MGT_10','W06_MGT','S10','ST03','Present','2026-06-08'),

('A_W06_LIN_01','W06_LIN','S01','ST04','Present','2026-06-08'),
('A_W06_LIN_02','W06_LIN','S02','ST04','Present','2026-06-08'),
('A_W06_LIN_03','W06_LIN','S03','ST04','Present','2026-06-08'),
('A_W06_LIN_04','W06_LIN','S04','ST04','Present','2026-06-08'),
('A_W06_LIN_05','W06_LIN','S05','ST04','Present','2026-06-08'),
('A_W06_LIN_06','W06_LIN','S06','ST04','Present','2026-06-08'),
('A_W06_LIN_07','W06_LIN','S07','ST04','Present','2026-06-08'),
('A_W06_LIN_08','W06_LIN','S08','ST04','Present','2026-06-08'),
('A_W06_LIN_09','W06_LIN','S09','ST04','Medical','2026-06-08'),
('A_W06_LIN_10','W06_LIN','S10','ST04','Present','2026-06-08'),

('A_W06_DBP_01','W06_DBP','S01','ST05','Present','2026-06-09'),
('A_W06_DBP_02','W06_DBP','S02','ST05','Present','2026-06-09'),
('A_W06_DBP_03','W06_DBP','S03','ST05','Present','2026-06-09'),
('A_W06_DBP_04','W06_DBP','S04','ST05','Present','2026-06-09'),
('A_W06_DBP_05','W06_DBP','S05','ST05','Present','2026-06-09'),
('A_W06_DBP_06','W06_DBP','S06','ST05','Present','2026-06-09'),
('A_W06_DBP_07','W06_DBP','S07','ST05','Present','2026-06-09'),
('A_W06_DBP_08','W06_DBP','S08','ST05','Present','2026-06-09'),
('A_W06_DBP_09','W06_DBP','S09','ST05','Present','2026-06-09'),
('A_W06_DBP_10','W06_DBP','S10','ST05','Present','2026-06-09'),

('A_W06_WEBT_01','W06_WEBT','S01','ST06','Present','2026-06-09'),
('A_W06_WEBT_02','W06_WEBT','S02','ST06','Present','2026-06-09'),
('A_W06_WEBT_03','W06_WEBT','S03','ST06','Present','2026-06-09'),
('A_W06_WEBT_04','W06_WEBT','S04','ST06','Present','2026-06-09'),
('A_W06_WEBT_05','W06_WEBT','S05','ST06','Present','2026-06-09'),
('A_W06_WEBT_06','W06_WEBT','S06','ST06','Present','2026-06-09'),
('A_W06_WEBT_07','W06_WEBT','S07','ST06','Present','2026-06-09'),
('A_W06_WEBT_08','W06_WEBT','S08','ST06','Present','2026-06-09'),
('A_W06_WEBT_09','W06_WEBT','S09','ST06','Present','2026-06-09'),
('A_W06_WEBT_10','W06_WEBT','S10','ST06','Present','2026-06-09'),

('A_W06_WEBP1_01','W06_WEBP1','S01','ST07','Present','2026-06-09'),
('A_W06_WEBP1_02','W06_WEBP1','S02','ST07','Present','2026-06-09'),
('A_W06_WEBP1_03','W06_WEBP1','S03','ST07','Present','2026-06-09'),
('A_W06_WEBP1_04','W06_WEBP1','S04','ST07','Present','2026-06-09'),
('A_W06_WEBP1_05','W06_WEBP1','S05','ST07','Present','2026-06-09'),
('A_W06_WEBP1_06','W06_WEBP1','S06','ST07','Present','2026-06-09'),
('A_W06_WEBP1_07','W06_WEBP1','S07','ST07','Present','2026-06-09'),
('A_W06_WEBP1_08','W06_WEBP1','S08','ST07','Present','2026-06-09'),
('A_W06_WEBP1_09','W06_WEBP1','S09','ST07','Present','2026-06-09'),
('A_W06_WEBP1_10','W06_WEBP1','S10','ST07','Present','2026-06-09'),

('A_W06_MAT_01','W06_MAT','S01','ST08','Present','2026-06-10'),
('A_W06_MAT_02','W06_MAT','S02','ST08','Present','2026-06-10'),
('A_W06_MAT_03','W06_MAT','S03','ST08','Present','2026-06-10'),
('A_W06_MAT_04','W06_MAT','S04','ST08','Present','2026-06-10'),
('A_W06_MAT_05','W06_MAT','S05','ST08','Present','2026-06-10'),
('A_W06_MAT_06','W06_MAT','S06','ST08','Present','2026-06-10'),
('A_W06_MAT_07','W06_MAT','S07','ST08','Present','2026-06-10'),
('A_W06_MAT_08','W06_MAT','S08','ST08','Present','2026-06-10'),
('A_W06_MAT_09','W06_MAT','S09','ST08','Present','2026-06-10'),
('A_W06_MAT_10','W06_MAT','S10','ST08','Present','2026-06-10'),

('A_W06_ENG_01','W06_ENG','S01','ST09','Present','2026-06-11'),
('A_W06_ENG_02','W06_ENG','S02','ST09','Present','2026-06-11'),
('A_W06_ENG_03','W06_ENG','S03','ST09','Present','2026-06-11'),
('A_W06_ENG_04','W06_ENG','S04','ST09','Present','2026-06-11'),
('A_W06_ENG_05','W06_ENG','S05','ST09','Present','2026-06-11'),
('A_W06_ENG_06','W06_ENG','S06','ST09','Present','2026-06-11'),
('A_W06_ENG_07','W06_ENG','S07','ST09','Present','2026-06-11'),
('A_W06_ENG_08','W06_ENG','S08','ST09','Present','2026-06-11'),
('A_W06_ENG_09','W06_ENG','S09','ST09','Present','2026-06-11'),
('A_W06_ENG_10','W06_ENG','S10','ST09','Present','2026-06-11'),

('A_W06_DBS_01','W06_DBS','S01','ST10','Present','2026-06-11'),
('A_W06_DBS_02','W06_DBS','S02','ST10','Present','2026-06-11'),
('A_W06_DBS_03','W06_DBS','S03','ST10','Present','2026-06-11'),
('A_W06_DBS_04','W06_DBS','S04','ST10','Present','2026-06-11'),
('A_W06_DBS_05','W06_DBS','S05','ST10','Present','2026-06-11'),
('A_W06_DBS_06','W06_DBS','S06','ST10','Present','2026-06-11'),
('A_W06_DBS_07','W06_DBS','S07','ST10','Present','2026-06-11'),
('A_W06_DBS_08','W06_DBS','S08','ST10','Present','2026-06-11'),
('A_W06_DBS_09','W06_DBS','S09','ST10','Present','2026-06-11'),
('A_W06_DBS_10','W06_DBS','S10','ST10','Present','2026-06-11'),

('A_W06_WEBP2_01','W06_WEBP2','S01','ST07','Present','2026-06-11'),
('A_W06_WEBP2_02','W06_WEBP2','S02','ST07','Present','2026-06-11'),
('A_W06_WEBP2_03','W06_WEBP2','S03','ST07','Present','2026-06-11'),
('A_W06_WEBP2_04','W06_WEBP2','S04','ST07','Present','2026-06-11'),
('A_W06_WEBP2_05','W06_WEBP2','S05','ST07','Present','2026-06-11'),
('A_W06_WEBP2_06','W06_WEBP2','S06','ST07','Present','2026-06-11'),
('A_W06_WEBP2_07','W06_WEBP2','S07','ST07','Present','2026-06-11'),
('A_W06_WEBP2_08','W06_WEBP2','S08','ST07','Present','2026-06-11'),
('A_W06_WEBP2_09','W06_WEBP2','S09','ST07','Present','2026-06-11'),
('A_W06_WEBP2_10','W06_WEBP2','S10','ST07','Present','2026-06-11'),

('A_W06_OSC_01','W06_OSC','S01','ST03','Present','2026-06-12'),
('A_W06_OSC_02','W06_OSC','S02','ST03','Present','2026-06-12'),
('A_W06_OSC_03','W06_OSC','S03','ST03','Present','2026-06-12'),
('A_W06_OSC_04','W06_OSC','S04','ST03','Present','2026-06-12'),
('A_W06_OSC_05','W06_OSC','S05','ST03','Present','2026-06-12'),
('A_W06_OSC_06','W06_OSC','S06','ST03','Present','2026-06-12'),
('A_W06_OSC_07','W06_OSC','S07','ST03','Present','2026-06-12'),
('A_W06_OSC_08','W06_OSC','S08','ST03','Present','2026-06-12'),
('A_W06_OSC_09','W06_OSC','S09','ST03','Present','2026-06-12'),
('A_W06_OSC_10','W06_OSC','S10','ST03','Present','2026-06-12'),

-- ================= WEEK 07 =================

('A_W07_MGT_01','W07_MGT','S01','ST03','Present','2026-06-15'),
('A_W07_MGT_02','W07_MGT','S02','ST03','Present','2026-06-15'),
('A_W07_MGT_03','W07_MGT','S03','ST03','Present','2026-06-15'),
('A_W07_MGT_04','W07_MGT','S04','ST03','Present','2026-06-15'),
('A_W07_MGT_05','W07_MGT','S05','ST03','Present','2026-06-15'),
('A_W07_MGT_06','W07_MGT','S06','ST03','Present','2026-06-15'),
('A_W07_MGT_07','W07_MGT','S07','ST03','Present','2026-06-15'),
('A_W07_MGT_08','W07_MGT','S08','ST03','Present','2026-06-15'),
('A_W07_MGT_09','W07_MGT','S09','ST03','Present','2026-06-15'),
('A_W07_MGT_10','W07_MGT','S10','ST03','Present','2026-06-15'),

('A_W07_LIN_01','W07_LIN','S01','ST04','Present','2026-06-15'),
('A_W07_LIN_02','W07_LIN','S02','ST04','Present','2026-06-15'),
('A_W07_LIN_03','W07_LIN','S03','ST04','Present','2026-06-15'),
('A_W07_LIN_04','W07_LIN','S04','ST04','Present','2026-06-15'),
('A_W07_LIN_05','W07_LIN','S05','ST04','Present','2026-06-15'),
('A_W07_LIN_06','W07_LIN','S06','ST04','Present','2026-06-15'),
('A_W07_LIN_07','W07_LIN','S07','ST04','Present','2026-06-15'),
('A_W07_LIN_08','W07_LIN','S08','ST04','Present','2026-06-15'),
('A_W07_LIN_09','W07_LIN','S09','ST04','Present','2026-06-15'),
('A_W07_LIN_10','W07_LIN','S10','ST04','Present','2026-06-15'),

('A_W07_DBP_01','W07_DBP','S01','ST05','Present','2026-06-16'),
('A_W07_DBP_02','W07_DBP','S02','ST05','Present','2026-06-16'),
('A_W07_DBP_03','W07_DBP','S03','ST05','Present','2026-06-16'),
('A_W07_DBP_04','W07_DBP','S04','ST05','Present','2026-06-16'),
('A_W07_DBP_05','W07_DBP','S05','ST05','Present','2026-06-16'),
('A_W07_DBP_06','W07_DBP','S06','ST05','Present','2026-06-16'),
('A_W07_DBP_07','W07_DBP','S07','ST05','Present','2026-06-16'),
('A_W07_DBP_08','W07_DBP','S08','ST05','Present','2026-06-16'),
('A_W07_DBP_09','W07_DBP','S09','ST05','Present','2026-06-16'),
('A_W07_DBP_10','W07_DBP','S10','ST05','Present','2026-06-16'),

('A_W07_WEBT_01','W07_WEBT','S01','ST06','Present','2026-06-16'),
('A_W07_WEBT_02','W07_WEBT','S02','ST06','Present','2026-06-16'),
('A_W07_WEBT_03','W07_WEBT','S03','ST06','Present','2026-06-16'),
('A_W07_WEBT_04','W07_WEBT','S04','ST06','Present','2026-06-16'),
('A_W07_WEBT_05','W07_WEBT','S05','ST06','Present','2026-06-16'),
('A_W07_WEBT_06','W07_WEBT','S06','ST06','Present','2026-06-16'),
('A_W07_WEBT_07','W07_WEBT','S07','ST06','Present','2026-06-16'),
('A_W07_WEBT_08','W07_WEBT','S08','ST06','Present','2026-06-16'),
('A_W07_WEBT_09','W07_WEBT','S09','ST06','Present','2026-06-16'),
('A_W07_WEBT_10','W07_WEBT','S10','ST06','Present','2026-06-16'),

('A_W07_WEBP1_01','W07_WEBP1','S01','ST07','Present','2026-06-16'),
('A_W07_WEBP1_02','W07_WEBP1','S02','ST07','Present','2026-06-16'),
('A_W07_WEBP1_03','W07_WEBP1','S03','ST07','Present','2026-06-16'),
('A_W07_WEBP1_04','W07_WEBP1','S04','ST07','Present','2026-06-16'),
('A_W07_WEBP1_05','W07_WEBP1','S05','ST07','Present','2026-06-16'),
('A_W07_WEBP1_06','W07_WEBP1','S06','ST07','Present','2026-06-16'),
('A_W07_WEBP1_07','W07_WEBP1','S07','ST07','Present','2026-06-16'),
('A_W07_WEBP1_08','W07_WEBP1','S08','ST07','Present','2026-06-16'),
('A_W07_WEBP1_09','W07_WEBP1','S09','ST07','Present','2026-06-16'),
('A_W07_WEBP1_10','W07_WEBP1','S10','ST07','Present','2026-06-16'),

('A_W07_MAT_01','W07_MAT','S01','ST08','Present','2026-06-17'),
('A_W07_MAT_02','W07_MAT','S02','ST08','Present','2026-06-17'),
('A_W07_MAT_03','W07_MAT','S03','ST08','Present','2026-06-17'),
('A_W07_MAT_04','W07_MAT','S04','ST08','Present','2026-06-17'),
('A_W07_MAT_05','W07_MAT','S05','ST08','Present','2026-06-17'),
('A_W07_MAT_06','W07_MAT','S06','ST08','Absent','2026-06-17'),
('A_W07_MAT_07','W07_MAT','S07','ST08','Present','2026-06-17'),
('A_W07_MAT_08','W07_MAT','S08','ST08','Present','2026-06-17'),
('A_W07_MAT_09','W07_MAT','S09','ST08','Present','2026-06-17'),
('A_W07_MAT_10','W07_MAT','S10','ST08','Present','2026-06-17'),

('A_W07_ENG_01','W07_ENG','S01','ST09','Present','2026-06-18'),
('A_W07_ENG_02','W07_ENG','S02','ST09','Present','2026-06-18'),
('A_W07_ENG_03','W07_ENG','S03','ST09','Present','2026-06-18'),
('A_W07_ENG_04','W07_ENG','S04','ST09','Present','2026-06-18'),
('A_W07_ENG_05','W07_ENG','S05','ST09','Present','2026-06-18'),
('A_W07_ENG_06','W07_ENG','S06','ST09','Present','2026-06-18'),
('A_W07_ENG_07','W07_ENG','S07','ST09','Present','2026-06-18'),
('A_W07_ENG_08','W07_ENG','S08','ST09','Present','2026-06-18'),
('A_W07_ENG_09','W07_ENG','S09','ST09','Present','2026-06-18'),
('A_W07_ENG_10','W07_ENG','S10','ST09','Present','2026-06-18'),

('A_W07_DBS_01','W07_DBS','S01','ST10','Present','2026-06-18'),
('A_W07_DBS_02','W07_DBS','S02','ST10','Present','2026-06-18'),
('A_W07_DBS_03','W07_DBS','S03','ST10','Present','2026-06-18'),
('A_W07_DBS_04','W07_DBS','S04','ST10','Present','2026-06-18'),
('A_W07_DBS_05','W07_DBS','S05','ST10','Present','2026-06-18'),
('A_W07_DBS_06','W07_DBS','S06','ST10','Present','2026-06-18'),
('A_W07_DBS_07','W07_DBS','S07','ST10','Present','2026-06-18'),
('A_W07_DBS_08','W07_DBS','S08','ST10','Present','2026-06-18'),
('A_W07_DBS_09','W07_DBS','S09','ST10','Present','2026-06-18'),
('A_W07_DBS_10','W07_DBS','S10','ST10','Present','2026-06-18'),

('A_W07_WEBP2_01','W07_WEBP2','S01','ST07','Present','2026-06-18'),
('A_W07_WEBP2_02','W07_WEBP2','S02','ST07','Present','2026-06-18'),
('A_W07_WEBP2_03','W07_WEBP2','S03','ST07','Present','2026-06-18'),
('A_W07_WEBP2_04','W07_WEBP2','S04','ST07','Present','2026-06-18'),
('A_W07_WEBP2_05','W07_WEBP2','S05','ST07','Present','2026-06-18'),
('A_W07_WEBP2_06','W07_WEBP2','S06','ST07','Present','2026-06-18'),
('A_W07_WEBP2_07','W07_WEBP2','S07','ST07','Present','2026-06-18'),
('A_W07_WEBP2_08','W07_WEBP2','S08','ST07','Present','2026-06-18'),
('A_W07_WEBP2_09','W07_WEBP2','S09','ST07','Present','2026-06-18'),
('A_W07_WEBP2_10','W07_WEBP2','S10','ST07','Present','2026-06-18'),

('A_W07_OSC_01','W07_OSC','S01','ST03','Present','2026-06-19'),
('A_W07_OSC_02','W07_OSC','S02','ST03','Present','2026-06-19'),
('A_W07_OSC_03','W07_OSC','S03','ST03','Present','2026-06-19'),
('A_W07_OSC_04','W07_OSC','S04','ST03','Present','2026-06-19'),
('A_W07_OSC_05','W07_OSC','S05','ST03','Present','2026-06-19'),
('A_W07_OSC_06','W07_OSC','S06','ST03','Present','2026-06-19'),
('A_W07_OSC_07','W07_OSC','S07','ST03','Present','2026-06-19'),
('A_W07_OSC_08','W07_OSC','S08','ST03','Present','2026-06-19'),
('A_W07_OSC_09','W07_OSC','S09','ST03','Present','2026-06-19'),
('A_W07_OSC_10','W07_OSC','S10','ST03','Present','2026-06-19'),

-- ================= WEEK 08 =================

('A_W08_MGT_01','W08_MGT','S01','ST03','Present','2026-06-22'),
('A_W08_MGT_02','W08_MGT','S02','ST03','Present','2026-06-22'),
('A_W08_MGT_03','W08_MGT','S03','ST03','Present','2026-06-22'),
('A_W08_MGT_04','W08_MGT','S04','ST03','Present','2026-06-22'),
('A_W08_MGT_05','W08_MGT','S05','ST03','Present','2026-06-22'),
('A_W08_MGT_06','W08_MGT','S06','ST03','Present','2026-06-22'),
('A_W08_MGT_07','W08_MGT','S07','ST03','Present','2026-06-22'),
('A_W08_MGT_08','W08_MGT','S08','ST03','Present','2026-06-22'),
('A_W08_MGT_09','W08_MGT','S09','ST03','Present','2026-06-22'),
('A_W08_MGT_10','W08_MGT','S10','ST03','Present','2026-06-22'),

('A_W08_LIN_01','W08_LIN','S01','ST04','Present','2026-06-22'),
('A_W08_LIN_02','W08_LIN','S02','ST04','Present','2026-06-22'),
('A_W08_LIN_03','W08_LIN','S03','ST04','Present','2026-06-22'),
('A_W08_LIN_04','W08_LIN','S04','ST04','Present','2026-06-22'),
('A_W08_LIN_05','W08_LIN','S05','ST04','Present','2026-06-22'),
('A_W08_LIN_06','W08_LIN','S06','ST04','Present','2026-06-22'),
('A_W08_LIN_07','W08_LIN','S07','ST04','Present','2026-06-22'),
('A_W08_LIN_08','W08_LIN','S08','ST04','Present','2026-06-22'),
('A_W08_LIN_09','W08_LIN','S09','ST04','Present','2026-06-22'),
('A_W08_LIN_10','W08_LIN','S10','ST04','Present','2026-06-22'),

('A_W08_DBP_01','W08_DBP','S01','ST05','Present','2026-06-23'),
('A_W08_DBP_02','W08_DBP','S02','ST05','Present','2026-06-23'),
('A_W08_DBP_03','W08_DBP','S03','ST05','Present','2026-06-23'),
('A_W08_DBP_04','W08_DBP','S04','ST05','Present','2026-06-23'),
('A_W08_DBP_05','W08_DBP','S05','ST05','Present','2026-06-23'),
('A_W08_DBP_06','W08_DBP','S06','ST05','Present','2026-06-23'),
('A_W08_DBP_07','W08_DBP','S07','ST05','Present','2026-06-23'),
('A_W08_DBP_08','W08_DBP','S08','ST05','Present','2026-06-23'),
('A_W08_DBP_09','W08_DBP','S09','ST05','Present','2026-06-23'),
('A_W08_DBP_10','W08_DBP','S10','ST05','Present','2026-06-23'),

('A_W08_WEBT_01','W08_WEBT','S01','ST06','Present','2026-06-23'),
('A_W08_WEBT_02','W08_WEBT','S02','ST06','Present','2026-06-23'),
('A_W08_WEBT_03','W08_WEBT','S03','ST06','Present','2026-06-23'),
('A_W08_WEBT_04','W08_WEBT','S04','ST06','Present','2026-06-23'),
('A_W08_WEBT_05','W08_WEBT','S05','ST06','Present','2026-06-23'),
('A_W08_WEBT_06','W08_WEBT','S06','ST06','Present','2026-06-23'),
('A_W08_WEBT_07','W08_WEBT','S07','ST06','Present','2026-06-23'),
('A_W08_WEBT_08','W08_WEBT','S08','ST06','Present','2026-06-23'),
('A_W08_WEBT_09','W08_WEBT','S09','ST06','Present','2026-06-23'),
('A_W08_WEBT_10','W08_WEBT','S10','ST06','Present','2026-06-23'),

('A_W08_WEBP1_01','W08_WEBP1','S01','ST07','Present','2026-06-23'),
('A_W08_WEBP1_02','W08_WEBP1','S02','ST07','Present','2026-06-23'),
('A_W08_WEBP1_03','W08_WEBP1','S03','ST07','Present','2026-06-23'),
('A_W08_WEBP1_04','W08_WEBP1','S04','ST07','Present','2026-06-23'),
('A_W08_WEBP1_05','W08_WEBP1','S05','ST07','Present','2026-06-23'),
('A_W08_WEBP1_06','W08_WEBP1','S06','ST07','Present','2026-06-23'),
('A_W08_WEBP1_07','W08_WEBP1','S07','ST07','Present','2026-06-23'),
('A_W08_WEBP1_08','W08_WEBP1','S08','ST07','Present','2026-06-23'),
('A_W08_WEBP1_09','W08_WEBP1','S09','ST07','Present','2026-06-23'),
('A_W08_WEBP1_10','W08_WEBP1','S10','ST07','Present','2026-06-23'),

('A_W08_MAT_01','W08_MAT','S01','ST08','Present','2026-06-24'),
('A_W08_MAT_02','W08_MAT','S02','ST08','Present','2026-06-24'),
('A_W08_MAT_03','W08_MAT','S03','ST08','Present','2026-06-24'),
('A_W08_MAT_04','W08_MAT','S04','ST08','Present','2026-06-24'),
('A_W08_MAT_05','W08_MAT','S05','ST08','Present','2026-06-24'),
('A_W08_MAT_06','W08_MAT','S06','ST08','Present','2026-06-24'),
('A_W08_MAT_07','W08_MAT','S07','ST08','Present','2026-06-24'),
('A_W08_MAT_08','W08_MAT','S08','ST08','Present','2026-06-24'),
('A_W08_MAT_09','W08_MAT','S09','ST08','Present','2026-06-24'),
('A_W08_MAT_10','W08_MAT','S10','ST08','Present','2026-06-24'),

('A_W08_ENG_01','W08_ENG','S01','ST09','Present','2026-06-25'),
('A_W08_ENG_02','W08_ENG','S02','ST09','Present','2026-06-25'),
('A_W08_ENG_03','W08_ENG','S03','ST09','Present','2026-06-25'),
('A_W08_ENG_04','W08_ENG','S04','ST09','Present','2026-06-25'),
('A_W08_ENG_05','W08_ENG','S05','ST09','Present','2026-06-25'),
('A_W08_ENG_06','W08_ENG','S06','ST09','Present','2026-06-25'),
('A_W08_ENG_07','W08_ENG','S07','ST09','Present','2026-06-25'),
('A_W08_ENG_08','W08_ENG','S08','ST09','Present','2026-06-25'),
('A_W08_ENG_09','W08_ENG','S09','ST09','Present','2026-06-25'),
('A_W08_ENG_10','W08_ENG','S10','ST09','Present','2026-06-25'),

('A_W08_DBS_01','W08_DBS','S01','ST10','Present','2026-06-25'),
('A_W08_DBS_02','W08_DBS','S02','ST10','Present','2026-06-25')
,('A_W08_DBS_03','W08_DBS','S03','ST10','Present','2026-06-25'),
('A_W08_DBS_04','W08_DBS','S04','ST10','Present','2026-06-25'),
('A_W08_DBS_05','W08_DBS','S05','ST10','Present','2026-06-25'),
('A_W08_DBS_06','W08_DBS','S06','ST10','Present','2026-06-25'),
('A_W08_DBS_07','W08_DBS','S07','ST10','Present','2026-06-25'),
('A_W08_DBS_08','W08_DBS','S08','ST10','Present','2026-06-25'),
('A_W08_DBS_09','W08_DBS','S09','ST10','Present','2026-06-25'),
('A_W08_DBS_10','W08_DBS','S10','ST10','Present','2026-06-25'),

('A_W08_WEBP2_01','W08_WEBP2','S01','ST07','Present','2026-06-25'),
('A_W08_WEBP2_02','W08_WEBP2','S02','ST07','Present','2026-06-25'),
('A_W08_WEBP2_03','W08_WEBP2','S03','ST07','Present','2026-06-25'),
('A_W08_WEBP2_04','W08_WEBP2','S04','ST07','Present','2026-06-25'),
('A_W08_WEBP2_05','W08_WEBP2','S05','ST07','Present','2026-06-25'),
('A_W08_WEBP2_06','W08_WEBP2','S06','ST07','Present','2026-06-25'),
('A_W08_WEBP2_07','W08_WEBP2','S07','ST07','Present','2026-06-25'),
('A_W08_WEBP2_08','W08_WEBP2','S08','ST07','Present','2026-06-25'),
('A_W08_WEBP2_09','W08_WEBP2','S09','ST07','Present','2026-06-25'),
('A_W08_WEBP2_10','W08_WEBP2','S10','ST07','Present','2026-06-25'),

('A_W08_OSC_01','W08_OSC','S01','ST03','Present','2026-06-26'),
('A_W08_OSC_02','W08_OSC','S02','ST03','Present','2026-06-26'),
('A_W08_OSC_03','W08_OSC','S03','ST03','Present','2026-06-26'),
('A_W08_OSC_04','W08_OSC','S04','ST03','Present','2026-06-26'),
('A_W08_OSC_05','W08_OSC','S05','ST03','Present','2026-06-26'),
('A_W08_OSC_06','W08_OSC','S06','ST03','Present','2026-06-26'),
('A_W08_OSC_07','W08_OSC','S07','ST03','Present','2026-06-26'),
('A_W08_OSC_08','W08_OSC','S08','ST03','Present','2026-06-26'),
('A_W08_OSC_09','W08_OSC','S09','ST03','Present','2026-06-26'),
('A_W08_OSC_10','W08_OSC','S10','ST03','Present','2026-06-26'),

-- ================= WEEK 09 =================

('A_W09_MGT_01','W09_MGT','S01','ST03','Present','2026-06-29'),
('A_W09_MGT_02','W09_MGT','S02','ST03','Present','2026-06-29'),
('A_W09_MGT_03','W09_MGT','S03','ST03','Present','2026-06-29'),
('A_W09_MGT_04','W09_MGT','S04','ST03','Present','2026-06-29'),
('A_W09_MGT_05','W09_MGT','S05','ST03','Present','2026-06-29'),
('A_W09_MGT_06','W09_MGT','S06','ST03','Present','2026-06-29'),
('A_W09_MGT_07','W09_MGT','S07','ST03','Present','2026-06-29'),
('A_W09_MGT_08','W09_MGT','S08','ST03','Present','2026-06-29'),
('A_W09_MGT_09','W09_MGT','S09','ST03','Present','2026-06-29'),
('A_W09_MGT_10','W09_MGT','S10','ST03','Present','2026-06-29'),

('A_W09_LIN_01','W09_LIN','S01','ST04','Present','2026-06-29'),
('A_W09_LIN_02','W09_LIN','S02','ST04','Present','2026-06-29'),
('A_W09_LIN_03','W09_LIN','S03','ST04','Present','2026-06-29'),
('A_W09_LIN_04','W09_LIN','S04','ST04','Present','2026-06-29'),
('A_W09_LIN_05','W09_LIN','S05','ST04','Present','2026-06-29'),
('A_W09_LIN_06','W09_LIN','S06','ST04','Present','2026-06-29'),
('A_W09_LIN_07','W09_LIN','S07','ST04','Present','2026-06-29'),
('A_W09_LIN_08','W09_LIN','S08','ST04','Present','2026-06-29'),
('A_W09_LIN_09','W09_LIN','S09','ST04','Present','2026-06-29'),
('A_W09_LIN_10','W09_LIN','S10','ST04','Present','2026-06-29'),

('A_W09_DBP_01','W09_DBP','S01','ST05','Present','2026-06-30'),
('A_W09_DBP_02','W09_DBP','S02','ST05','Present','2026-06-30'),
('A_W09_DBP_03','W09_DBP','S03','ST05','Present','2026-06-30'),
('A_W09_DBP_04','W09_DBP','S04','ST05','Present','2026-06-30'),
('A_W09_DBP_05','W09_DBP','S05','ST05','Present','2026-06-30'),
('A_W09_DBP_06','W09_DBP','S06','ST05','Present','2026-06-30'),
('A_W09_DBP_07','W09_DBP','S07','ST05','Present','2026-06-30'),
('A_W09_DBP_08','W09_DBP','S08','ST05','Present','2026-06-30'),
('A_W09_DBP_09','W09_DBP','S09','ST05','Present','2026-06-30'),
('A_W09_DBP_10','W09_DBP','S10','ST05','Present','2026-06-30'),

('A_W09_WEBT_01','W09_WEBT','S01','ST06','Present','2026-06-30'),
('A_W09_WEBT_02','W09_WEBT','S02','ST06','Present','2026-06-30'),
('A_W09_WEBT_03','W09_WEBT','S03','ST06','Present','2026-06-30'),
('A_W09_WEBT_04','W09_WEBT','S04','ST06','Present','2026-06-30'),
('A_W09_WEBT_05','W09_WEBT','S05','ST06','Present','2026-06-30'),
('A_W09_WEBT_06','W09_WEBT','S06','ST06','Present','2026-06-30'),
('A_W09_WEBT_07','W09_WEBT','S07','ST06','Present','2026-06-30'),
('A_W09_WEBT_08','W09_WEBT','S08','ST06','Present','2026-06-30'),
('A_W09_WEBT_09','W09_WEBT','S09','ST06','Present','2026-06-30'),
('A_W09_WEBT_10','W09_WEBT','S10','ST06','Present','2026-06-30'),

('A_W09_WEBP1_01','W09_WEBP1','S01','ST07','Present','2026-06-30'),
('A_W09_WEBP1_02','W09_WEBP1','S02','ST07','Present','2026-06-30'),
('A_W09_WEBP1_03','W09_WEBP1','S03','ST07','Present','2026-06-30'),
('A_W09_WEBP1_04','W09_WEBP1','S04','ST07','Present','2026-06-30'),
('A_W09_WEBP1_05','W09_WEBP1','S05','ST07','Present','2026-06-30'),
('A_W09_WEBP1_06','W09_WEBP1','S06','ST07','Present','2026-06-30'),
('A_W09_WEBP1_07','W09_WEBP1','S07','ST07','Present','2026-06-30'),
('A_W09_WEBP1_08','W09_WEBP1','S08','ST07','Present','2026-06-30'),
('A_W09_WEBP1_09','W09_WEBP1','S09','ST07','Present','2026-06-30'),
('A_W09_WEBP1_10','W09_WEBP1','S10','ST07','Present','2026-06-30'),

('A_W09_MAT_01','W09_MAT','S01','ST08','Present','2026-07-01'),
('A_W09_MAT_02','W09_MAT','S02','ST08','Present','2026-07-01'),
('A_W09_MAT_03','W09_MAT','S03','ST08','Present','2026-07-01'),
('A_W09_MAT_04','W09_MAT','S04','ST08','Present','2026-07-01'),
('A_W09_MAT_05','W09_MAT','S05','ST08','Present','2026-07-01'),
('A_W09_MAT_06','W09_MAT','S06','ST08','Present','2026-07-01')
,('A_W09_MAT_07','W09_MAT','S07','ST08','Present','2026-07-01'),
('A_W09_MAT_08','W09_MAT','S08','ST08','Present','2026-07-01'),
('A_W09_MAT_09','W09_MAT','S09','ST08','Present','2026-07-01'),
('A_W09_MAT_10','W09_MAT','S10','ST08','Present','2026-07-01'),

('A_W09_ENG_01','W09_ENG','S01','ST09','Present','2026-07-02'),
('A_W09_ENG_02','W09_ENG','S02','ST09','Present','2026-07-02'),
('A_W09_ENG_03','W09_ENG','S03','ST09','Present','2026-07-02'),
('A_W09_ENG_04','W09_ENG','S04','ST09','Present','2026-07-02'),
('A_W09_ENG_05','W09_ENG','S05','ST09','Present','2026-07-02'),
('A_W09_ENG_06','W09_ENG','S06','ST09','Present','2026-07-02'),
('A_W09_ENG_07','W09_ENG','S07','ST09','Present','2026-07-02'),
('A_W09_ENG_08','W09_ENG','S08','ST09','Present','2026-07-02'),
('A_W09_ENG_09','W09_ENG','S09','ST09','Present','2026-07-02'),
('A_W09_ENG_10','W09_ENG','S10','ST09','Present','2026-07-02'),

('A_W09_DBS_01','W09_DBS','S01','ST10','Present','2026-07-02'),
('A_W09_DBS_02','W09_DBS','S02','ST10','Present','2026-07-02'),
('A_W09_DBS_03','W09_DBS','S03','ST10','Present','2026-07-02'),
('A_W09_DBS_04','W09_DBS','S04','ST10','Present','2026-07-02'),
('A_W09_DBS_05','W09_DBS','S05','ST10','Present','2026-07-02'),
('A_W09_DBS_06','W09_DBS','S06','ST10','Present','2026-07-02'),
('A_W09_DBS_07','W09_DBS','S07','ST10','Present','2026-07-02'),
('A_W09_DBS_08','W09_DBS','S08','ST10','Present','2026-07-02'),
('A_W09_DBS_09','W09_DBS','S09','ST10','Present','2026-07-02'),
('A_W09_DBS_10','W09_DBS','S10','ST10','Present','2026-07-02'),

('A_W09_WEBP2_01','W09_WEBP2','S01','ST07','Present','2026-07-02'),
('A_W09_WEBP2_02','W09_WEBP2','S02','ST07','Present','2026-07-02'),
('A_W09_WEBP2_03','W09_WEBP2','S03','ST07','Present','2026-07-02'),
('A_W09_WEBP2_04','W09_WEBP2','S04','ST07','Present','2026-07-02'),
('A_W09_WEBP2_05','W09_WEBP2','S05','ST07','Present','2026-07-02'),
('A_W09_WEBP2_06','W09_WEBP2','S06','ST07','Present','2026-07-02'),
('A_W09_WEBP2_07','W09_WEBP2','S07','ST07','Present','2026-07-02'),
('A_W09_WEBP2_08','W09_WEBP2','S08','ST07','Present','2026-07-02'),
('A_W09_WEBP2_09','W09_WEBP2','S09','ST07','Present','2026-07-02'),
('A_W09_WEBP2_10','W09_WEBP2','S10','ST07','Present','2026-07-02'),

('A_W09_OSC_01','W09_OSC','S01','ST03','Present','2026-07-03'),
('A_W09_OSC_02','W09_OSC','S02','ST03','Present','2026-07-03'),
('A_W09_OSC_03','W09_OSC','S03','ST03','Present','2026-07-03'),
('A_W09_OSC_04','W09_OSC','S04','ST03','Present','2026-07-03'),
('A_W09_OSC_05','W09_OSC','S05','ST03','Present','2026-07-03'),
('A_W09_OSC_06','W09_OSC','S06','ST03','Present','2026-07-03'),
('A_W09_OSC_07','W09_OSC','S07','ST03','Present','2026-07-03'),
('A_W09_OSC_08','W09_OSC','S08','ST03','Present','2026-07-03'),
('A_W09_OSC_09','W09_OSC','S09','ST03','Present','2026-07-03'),
('A_W09_OSC_10','W09_OSC','S10','ST03','Present','2026-07-03'),

-- ================= WEEK 10 =================

('A_W10_MGT_01','W10_MGT','S01','ST03','Present','2026-07-06'),
('A_W10_MGT_02','W10_MGT','S02','ST03','Present','2026-07-06'),
('A_W10_MGT_03','W10_MGT','S03','ST03','Present','2026-07-06'),
('A_W10_MGT_04','W10_MGT','S04','ST03','Present','2026-07-06'),
('A_W10_MGT_05','W10_MGT','S05','ST03','Present','2026-07-06'),
('A_W10_MGT_06','W10_MGT','S06','ST03','Present','2026-07-06'),
('A_W10_MGT_07','W10_MGT','S07','ST03','Present','2026-07-06'),
('A_W10_MGT_08','W10_MGT','S08','ST03','Medical','2026-07-06'),
('A_W10_MGT_09','W10_MGT','S09','ST03','Present','2026-07-06'),
('A_W10_MGT_10','W10_MGT','S10','ST03','Present','2026-07-06'),

('A_W10_LIN_01','W10_LIN','S01','ST04','Present','2026-07-06'),
('A_W10_LIN_02','W10_LIN','S02','ST04','Present','2026-07-06'),
('A_W10_LIN_03','W10_LIN','S03','ST04','Present','2026-07-06'),
('A_W10_LIN_04','W10_LIN','S04','ST04','Present','2026-07-06'),
('A_W10_LIN_05','W10_LIN','S05','ST04','Present','2026-07-06'),
('A_W10_LIN_06','W10_LIN','S06','ST04','Present','2026-07-06'),
('A_W10_LIN_07','W10_LIN','S07','ST04','Present','2026-07-06'),
('A_W10_LIN_08','W10_LIN','S08','ST04','Present','2026-07-06'),
('A_W10_LIN_09','W10_LIN','S09','ST04','Present','2026-07-06'),
('A_W10_LIN_10','W10_LIN','S10','ST04','Present','2026-07-06'),

('A_W10_DBP_01','W10_DBP','S01','ST05','Present','2026-07-07'),
('A_W10_DBP_02','W10_DBP','S02','ST05','Present','2026-07-07'),
('A_W10_DBP_03','W10_DBP','S03','ST05','Present','2026-07-07'),
('A_W10_DBP_04','W10_DBP','S04','ST05','Present','2026-07-07'),
('A_W10_DBP_05','W10_DBP','S05','ST05','Present','2026-07-07'),
('A_W10_DBP_06','W10_DBP','S06','ST05','Present','2026-07-07'),
('A_W10_DBP_07','W10_DBP','S07','ST05','Present','2026-07-07'),
('A_W10_DBP_08','W10_DBP','S08','ST05','Present','2026-07-07'),
('A_W10_DBP_09','W10_DBP','S09','ST05','Present','2026-07-07'),
('A_W10_DBP_10','W10_DBP','S10','ST05','Present','2026-07-07'),

('A_W10_WEBT_01','W10_WEBT','S01','ST06','Present','2026-07-07'),
('A_W10_WEBT_02','W10_WEBT','S02','ST06','Present','2026-07-07'),
('A_W10_WEBT_03','W10_WEBT','S03','ST06','Present','2026-07-07'),
('A_W10_WEBT_04','W10_WEBT','S04','ST06','Present','2026-07-07'),
('A_W10_WEBT_05','W10_WEBT','S05','ST06','Present','2026-07-07'),
('A_W10_WEBT_06','W10_WEBT','S06','ST06','Present','2026-07-07'),
('A_W10_WEBT_07','W10_WEBT','S07','ST06','Present','2026-07-07'),
('A_W10_WEBT_08','W10_WEBT','S08','ST06','Present','2026-07-07'),
('A_W10_WEBT_09','W10_WEBT','S09','ST06','Present','2026-07-07'),
('A_W10_WEBT_10','W10_WEBT','S10','ST06','Present','2026-07-07'),

('A_W10_WEBP1_01','W10_WEBP1','S01','ST07','Present','2026-07-07'),
('A_W10_WEBP1_02','W10_WEBP1','S02','ST07','Present','2026-07-07'),
('A_W10_WEBP1_03','W10_WEBP1','S03','ST07','Present','2026-07-07'),
('A_W10_WEBP1_04','W10_WEBP1','S04','ST07','Present','2026-07-07'),
('A_W10_WEBP1_05','W10_WEBP1','S05','ST07','Present','2026-07-07'),
('A_W10_WEBP1_06','W10_WEBP1','S06','ST07','Present','2026-07-07'),
('A_W10_WEBP1_07','W10_WEBP1','S07','ST07','Present','2026-07-07'),
('A_W10_WEBP1_08','W10_WEBP1','S08','ST07','Present','2026-07-07'),
('A_W10_WEBP1_09','W10_WEBP1','S09','ST07','Present','2026-07-07'),
('A_W10_WEBP1_10','W10_WEBP1','S10','ST07','Present','2026-07-07'),

('A_W10_MAT_01','W10_MAT','S01','ST08','Present','2026-07-08'),
('A_W10_MAT_02','W10_MAT','S02','ST08','Present','2026-07-08'),
('A_W10_MAT_03','W10_MAT','S03','ST08','Present','2026-07-08'),
('A_W10_MAT_04','W10_MAT','S04','ST08','Present','2026-07-08'),
('A_W10_MAT_05','W10_MAT','S05','ST08','Present','2026-07-08'),
('A_W10_MAT_06','W10_MAT','S06','ST08','Present','2026-07-08'),
('A_W10_MAT_07','W10_MAT','S07','ST08','Present','2026-07-08'),
('A_W10_MAT_08','W10_MAT','S08','ST08','Present','2026-07-08'),
('A_W10_MAT_09','W10_MAT','S09','ST08','Present','2026-07-08'),
('A_W10_MAT_10','W10_MAT','S10','ST08','Present','2026-07-08'),

('A_W10_ENG_01','W10_ENG','S01','ST09','Present','2026-07-09'),
('A_W10_ENG_02','W10_ENG','S02','ST09','Present','2026-07-09'),
('A_W10_ENG_03','W10_ENG','S03','ST09','Present','2026-07-09'),
('A_W10_ENG_04','W10_ENG','S04','ST09','Present','2026-07-09'),
('A_W10_ENG_05','W10_ENG','S05','ST09','Present','2026-07-09'),
('A_W10_ENG_06','W10_ENG','S06','ST09','Present','2026-07-09'),
('A_W10_ENG_07','W10_ENG','S07','ST09','Present','2026-07-09'),
('A_W10_ENG_08','W10_ENG','S08','ST09','Present','2026-07-09'),
('A_W10_ENG_09','W10_ENG','S09','ST09','Present','2026-07-09'),
('A_W10_ENG_10','W10_ENG','S10','ST09','Present','2026-07-09'),

('A_W10_DBS_01','W10_DBS','S01','ST10','Present','2026-07-09'),
('A_W10_DBS_02','W10_DBS','S02','ST10','Present','2026-07-09'),
('A_W10_DBS_03','W10_DBS','S03','ST10','Present','2026-07-09'),
('A_W10_DBS_04','W10_DBS','S04','ST10','Present','2026-07-09'),
('A_W10_DBS_05','W10_DBS','S05','ST10','Present','2026-07-09'),
('A_W10_DBS_06','W10_DBS','S06','ST10','Present','2026-07-09'),
('A_W10_DBS_07','W10_DBS','S07','ST10','Present','2026-07-09'),
('A_W10_DBS_08','W10_DBS','S08','ST10','Present','2026-07-09'),
('A_W10_DBS_09','W10_DBS','S09','ST10','Present','2026-07-09'),
('A_W10_DBS_10','W10_DBS','S10','ST10','Present','2026-07-09'),

('A_W10_WEBP2_01','W10_WEBP2','S01','ST07','Present','2026-07-09'),
('A_W10_WEBP2_02','W10_WEBP2','S02','ST07','Present','2026-07-09'),
('A_W10_WEBP2_03','W10_WEBP2','S03','ST07','Present','2026-07-09'),
('A_W10_WEBP2_04','W10_WEBP2','S04','ST07','Present','2026-07-09'),
('A_W10_WEBP2_05','W10_WEBP2','S05','ST07','Present','2026-07-09'),
('A_W10_WEBP2_06','W10_WEBP2','S06','ST07','Present','2026-07-09'),
('A_W10_WEBP2_07','W10_WEBP2','S07','ST07','Present','2026-07-09'),
('A_W10_WEBP2_08','W10_WEBP2','S08','ST07','Present','2026-07-09'),
('A_W10_WEBP2_09','W10_WEBP2','S09','ST07','Present','2026-07-09'),
('A_W10_WEBP2_10','W10_WEBP2','S10','ST07','Present','2026-07-09'),

('A_W10_OSC_01','W10_OSC','S01','ST03','Present','2026-07-10'),
('A_W10_OSC_02','W10_OSC','S02','ST03','Present','2026-07-10'),
('A_W10_OSC_03','W10_OSC','S03','ST03','Present','2026-07-10'),
('A_W10_OSC_04','W10_OSC','S04','ST03','Present','2026-07-10'),
('A_W10_OSC_05','W10_OSC','S05','ST03','Present','2026-07-10'),
('A_W10_OSC_06','W10_OSC','S06','ST03','Present','2026-07-10'),
('A_W10_OSC_07','W10_OSC','S07','ST03','Present','2026-07-10'),
('A_W10_OSC_08','W10_OSC','S08','ST03','Present','2026-07-10'),
('A_W10_OSC_09','W10_OSC','S09','ST03','Present','2026-07-10'),
('A_W10_OSC_10','W10_OSC','S10','ST03','Present','2026-07-10');

INSERT INTO ATTENDANCE_RECORD (Attendance_ID, session_id, student_id, marked_by, attendance_status, marked_date) VALUES

-- ================= WEEK 11 =================

('A_W11_MGT_01','W11_MGT','S01','ST03','Present','2026-07-13'),
('A_W11_MGT_02','W11_MGT','S02','ST03','Present','2026-07-13'),
('A_W11_MGT_03','W11_MGT','S03','ST03','Present','2026-07-13'),
('A_W11_MGT_04','W11_MGT','S04','ST03','Present','2026-07-13'),
('A_W11_MGT_05','W11_MGT','S05','ST03','Present','2026-07-13'),
('A_W11_MGT_06','W11_MGT','S06','ST03','Present','2026-07-13'),
('A_W11_MGT_07','W11_MGT','S07','ST03','Present','2026-07-13'),
('A_W11_MGT_08','W11_MGT','S08','ST03','Present','2026-07-13'),
('A_W11_MGT_09','W11_MGT','S09','ST03','Present','2026-07-13'),
('A_W11_MGT_10','W11_MGT','S10','ST03','Present','2026-07-13'),

('A_W11_LIN_01','W11_LIN','S01','ST04','Present','2026-07-13'),
('A_W11_LIN_02','W11_LIN','S02','ST04','Present','2026-07-13'),
('A_W11_LIN_03','W11_LIN','S03','ST04','Present','2026-07-13'),
('A_W11_LIN_04','W11_LIN','S04','ST04','Present','2026-07-13'),
('A_W11_LIN_05','W11_LIN','S05','ST04','Present','2026-07-13'),
('A_W11_LIN_06','W11_LIN','S06','ST04','Present','2026-07-13'),
('A_W11_LIN_07','W11_LIN','S07','ST04','Absent','2026-07-13'),
('A_W11_LIN_08','W11_LIN','S08','ST04','Present','2026-07-13'),
('A_W11_LIN_09','W11_LIN','S09','ST04','Present','2026-07-13'),
('A_W11_LIN_10','W11_LIN','S10','ST04','Present','2026-07-13'),

('A_W11_DBP_01','W11_DBP','S01','ST05','Present','2026-07-14'),
('A_W11_DBP_02','W11_DBP','S02','ST05','Present','2026-07-14'),
('A_W11_DBP_03','W11_DBP','S03','ST05','Present','2026-07-14'),
('A_W11_DBP_04','W11_DBP','S04','ST05','Present','2026-07-14'),
('A_W11_DBP_05','W11_DBP','S05','ST05','Present','2026-07-14'),
('A_W11_DBP_06','W11_DBP','S06','ST05','Present','2026-07-14'),
('A_W11_DBP_07','W11_DBP','S07','ST05','Present','2026-07-14'),
('A_W11_DBP_08','W11_DBP','S08','ST05','Present','2026-07-14'),
('A_W11_DBP_09','W11_DBP','S09','ST05','Present','2026-07-14'),
('A_W11_DBP_10','W11_DBP','S10','ST05','Present','2026-07-14'),

('A_W11_WEBT_01','W11_WEBT','S01','ST06','Present','2026-07-14'),
('A_W11_WEBT_02','W11_WEBT','S02','ST06','Present','2026-07-14'),
('A_W11_WEBT_03','W11_WEBT','S03','ST06','Present','2026-07-14'),
('A_W11_WEBT_04','W11_WEBT','S04','ST06','Present','2026-07-14'),
('A_W11_WEBT_05','W11_WEBT','S05','ST06','Present','2026-07-14'),
('A_W11_WEBT_06','W11_WEBT','S06','ST06','Present','2026-07-14'),
('A_W11_WEBT_07','W11_WEBT','S07','ST06','Present','2026-07-14'),
('A_W11_WEBT_08','W11_WEBT','S08','ST06','Present','2026-07-14'),
('A_W11_WEBT_09','W11_WEBT','S09','ST06','Present','2026-07-14'),
('A_W11_WEBT_10','W11_WEBT','S10','ST06','Present','2026-07-14'),

('A_W11_WEBP1_01','W11_WEBP1','S01','ST07','Present','2026-07-14'),
('A_W11_WEBP1_02','W11_WEBP1','S02','ST07','Present','2026-07-14'),
('A_W11_WEBP1_03','W11_WEBP1','S03','ST07','Present','2026-07-14'),
('A_W11_WEBP1_04','W11_WEBP1','S04','ST07','Present','2026-07-14'),
('A_W11_WEBP1_05','W11_WEBP1','S05','ST07','Present','2026-07-14'),
('A_W11_WEBP1_06','W11_WEBP1','S06','ST07','Present','2026-07-14'),
('A_W11_WEBP1_07','W11_WEBP1','S07','ST07','Present','2026-07-14'),
('A_W11_WEBP1_08','W11_WEBP1','S08','ST07','Present','2026-07-14'),
('A_W11_WEBP1_09','W11_WEBP1','S09','ST07','Present','2026-07-14'),
('A_W11_WEBP1_10','W11_WEBP1','S10','ST07','Present','2026-07-14'),

('A_W11_MAT_01','W11_MAT','S01','ST08','Present','2026-07-15'),
('A_W11_MAT_02','W11_MAT','S02','ST08','Present','2026-07-15'),
('A_W11_MAT_03','W11_MAT','S03','ST08','Present','2026-07-15'),
('A_W11_MAT_04','W11_MAT','S04','ST08','Present','2026-07-15'),
('A_W11_MAT_05','W11_MAT','S05','ST08','Present','2026-07-15'),
('A_W11_MAT_06','W11_MAT','S06','ST08','Present','2026-07-15'),
('A_W11_MAT_07','W11_MAT','S07','ST08','Present','2026-07-15'),
('A_W11_MAT_08','W11_MAT','S08','ST08','Present','2026-07-15'),
('A_W11_MAT_09','W11_MAT','S09','ST08','Present','2026-07-15'),
('A_W11_MAT_10','W11_MAT','S10','ST08','Present','2026-07-15'),

('A_W11_ENG_01','W11_ENG','S01','ST09','Present','2026-07-16'),
('A_W11_ENG_02','W11_ENG','S02','ST09','Present','2026-07-16'),
('A_W11_ENG_03','W11_ENG','S03','ST09','Present','2026-07-16'),
('A_W11_ENG_04','W11_ENG','S04','ST09','Present','2026-07-16'),
('A_W11_ENG_05','W11_ENG','S05','ST09','Present','2026-07-16'),
('A_W11_ENG_06','W11_ENG','S06','ST09','Present','2026-07-16'),
('A_W11_ENG_07','W11_ENG','S07','ST09','Present','2026-07-16'),
('A_W11_ENG_08','W11_ENG','S08','ST09','Present','2026-07-16'),
('A_W11_ENG_09','W11_ENG','S09','ST09','Present','2026-07-16'),
('A_W11_ENG_10','W11_ENG','S10','ST09','Present','2026-07-16'),

('A_W11_DBS_01','W11_DBS','S01','ST10','Present','2026-07-16'),
('A_W11_DBS_02','W11_DBS','S02','ST10','Present','2026-07-16'),
('A_W11_DBS_03','W11_DBS','S03','ST10','Present','2026-07-16'),
('A_W11_DBS_04','W11_DBS','S04','ST10','Present','2026-07-16'),
('A_W11_DBS_05','W11_DBS','S05','ST10','Present','2026-07-16'),
('A_W11_DBS_06','W11_DBS','S06','ST10','Present','2026-07-16'),
('A_W11_DBS_07','W11_DBS','S07','ST10','Present','2026-07-16'),
('A_W11_DBS_08','W11_DBS','S08','ST10','Present','2026-07-16'),
('A_W11_DBS_09','W11_DBS','S09','ST10','Present','2026-07-16'),
('A_W11_DBS_10','W11_DBS','S10','ST10','Present','2026-07-16'),

('A_W11_WEBP2_01','W11_WEBP2','S01','ST07','Present','2026-07-16'),
('A_W11_WEBP2_02','W11_WEBP2','S02','ST07','Present','2026-07-16'),
('A_W11_WEBP2_03','W11_WEBP2','S03','ST07','Present','2026-07-16'),
('A_W11_WEBP2_04','W11_WEBP2','S04','ST07','Present','2026-07-16'),
('A_W11_WEBP2_05','W11_WEBP2','S05','ST07','Present','2026-07-16'),
('A_W11_WEBP2_06','W11_WEBP2','S06','ST07','Present','2026-07-16'),
('A_W11_WEBP2_07','W11_WEBP2','S07','ST07','Present','2026-07-16'),
('A_W11_WEBP2_08','W11_WEBP2','S08','ST07','Present','2026-07-16'),
('A_W11_WEBP2_09','W11_WEBP2','S09','ST07','Present','2026-07-16'),
('A_W11_WEBP2_10','W11_WEBP2','S10','ST07','Present','2026-07-16'),

('A_W11_OSC_01','W11_OSC','S01','ST03','Present','2026-07-17'),
('A_W11_OSC_02','W11_OSC','S02','ST03','Present','2026-07-17'),
('A_W11_OSC_03','W11_OSC','S03','ST03','Present','2026-07-17'),
('A_W11_OSC_04','W11_OSC','S04','ST03','Present','2026-07-17'),
('A_W11_OSC_05','W11_OSC','S05','ST03','Present','2026-07-17'),
('A_W11_OSC_06','W11_OSC','S06','ST03','Present','2026-07-17'),
('A_W11_OSC_07','W11_OSC','S07','ST03','Present','2026-07-17'),
('A_W11_OSC_08','W11_OSC','S08','ST03','Present','2026-07-17'),
('A_W11_OSC_09','W11_OSC','S09','ST03','Present','2026-07-17'),
('A_W11_OSC_10','W11_OSC','S10','ST03','Present','2026-07-17'),

-- ================= WEEK 12 =================

('A_W12_MGT_01','W12_MGT','S01','ST03','Present','2026-07-20'),
('A_W12_MGT_02','W12_MGT','S02','ST03','Present','2026-07-20'),
('A_W12_MGT_03','W12_MGT','S03','ST03','Present','2026-07-20'),
('A_W12_MGT_04','W12_MGT','S04','ST03','Present','2026-07-20'),
('A_W12_MGT_05','W12_MGT','S05','ST03','Present','2026-07-20'),
('A_W12_MGT_06','W12_MGT','S06','ST03','Present','2026-07-20'),
('A_W12_MGT_07','W12_MGT','S07','ST03','Present','2026-07-20'),
('A_W12_MGT_08','W12_MGT','S08','ST03','Present','2026-07-20'),
('A_W12_MGT_09','W12_MGT','S09','ST03','Present','2026-07-20'),
('A_W12_MGT_10','W12_MGT','S10','ST03','Present','2026-07-20'),

('A_W12_LIN_01','W12_LIN','S01','ST04','Present','2026-07-20'),
('A_W12_LIN_02','W12_LIN','S02','ST04','Present','2026-07-20'),
('A_W12_LIN_03','W12_LIN','S03','ST04','Present','2026-07-20'),
('A_W12_LIN_04','W12_LIN','S04','ST04','Present','2026-07-20'),
('A_W12_LIN_05','W12_LIN','S05','ST04','Present','2026-07-20'),
('A_W12_LIN_06','W12_LIN','S06','ST04','Present','2026-07-20'),
('A_W12_LIN_07','W12_LIN','S07','ST04','Present','2026-07-20'),
('A_W12_LIN_08','W12_LIN','S08','ST04','Present','2026-07-20'),
('A_W12_LIN_09','W12_LIN','S09','ST04','Present','2026-07-20'),
('A_W12_LIN_10','W12_LIN','S10','ST04','Present','2026-07-20'),

('A_W12_DBP_01','W12_DBP','S01','ST05','Present','2026-07-21'),
('A_W12_DBP_02','W12_DBP','S02','ST05','Present','2026-07-21'),
('A_W12_DBP_03','W12_DBP','S03','ST05','Present','2026-07-21'),
('A_W12_DBP_04','W12_DBP','S04','ST05','Present','2026-07-21'),
('A_W12_DBP_05','W12_DBP','S05','ST05','Present','2026-07-21'),
('A_W12_DBP_06','W12_DBP','S06','ST05','Present','2026-07-21'),
('A_W12_DBP_07','W12_DBP','S07','ST05','Present','2026-07-21'),
('A_W12_DBP_08','W12_DBP','S08','ST05','Present','2026-07-21'),
('A_W12_DBP_09','W12_DBP','S09','ST05','Present','2026-07-21'),
('A_W12_DBP_10','W12_DBP','S10','ST05','Present','2026-07-21'),

('A_W12_WEBT_01','W12_WEBT','S01','ST06','Present','2026-07-21'),
('A_W12_WEBT_02','W12_WEBT','S02','ST06','Present','2026-07-21'),
('A_W12_WEBT_03','W12_WEBT','S03','ST06','Present','2026-07-21'),
('A_W12_WEBT_04','W12_WEBT','S04','ST06','Present','2026-07-21'),
('A_W12_WEBT_05','W12_WEBT','S05','ST06','Present','2026-07-21'),
('A_W12_WEBT_06','W12_WEBT','S06','ST06','Present','2026-07-21'),
('A_W12_WEBT_07','W12_WEBT','S07','ST06','Present','2026-07-21'),
('A_W12_WEBT_08','W12_WEBT','S08','ST06','Present','2026-07-21'),
('A_W12_WEBT_09','W12_WEBT','S09','ST06','Present','2026-07-21'),
('A_W12_WEBT_10','W12_WEBT','S10','ST06','Present','2026-07-21'),

('A_W12_WEBP1_01','W12_WEBP1','S01','ST07','Present','2026-07-21'),
('A_W12_WEBP1_02','W12_WEBP1','S02','ST07','Present','2026-07-21'),
('A_W12_WEBP1_03','W12_WEBP1','S03','ST07','Present','2026-07-21'),
('A_W12_WEBP1_04','W12_WEBP1','S04','ST07','Present','2026-07-21'),
('A_W12_WEBP1_05','W12_WEBP1','S05','ST07','Present','2026-07-21'),
('A_W12_WEBP1_06','W12_WEBP1','S06','ST07','Present','2026-07-21'),
('A_W12_WEBP1_07','W12_WEBP1','S07','ST07','Present','2026-07-21'),
('A_W12_WEBP1_08','W12_WEBP1','S08','ST07','Present','2026-07-21'),
('A_W12_WEBP1_09','W12_WEBP1','S09','ST07','Present','2026-07-21'),
('A_W12_WEBP1_10','W12_WEBP1','S10','ST07','Present','2026-07-21'),

('A_W12_MAT_01','W12_MAT','S01','ST08','Present','2026-07-22'),
('A_W12_MAT_02','W12_MAT','S02','ST08','Present','2026-07-22'),
('A_W12_MAT_03','W12_MAT','S03','ST08','Present','2026-07-22'),
('A_W12_MAT_04','W12_MAT','S04','ST08','Present','2026-07-22'),
('A_W12_MAT_05','W12_MAT','S05','ST08','Present','2026-07-22'),
('A_W12_MAT_06','W12_MAT','S06','ST08','Present','2026-07-22'),
('A_W12_MAT_07','W12_MAT','S07','ST08','Present','2026-07-22'),
('A_W12_MAT_08','W12_MAT','S08','ST08','Present','2026-07-22'),
('A_W12_MAT_09','W12_MAT','S09','ST08','Absent','2026-07-22'),
('A_W12_MAT_10','W12_MAT','S10','ST08','Present','2026-07-22'),

('A_W12_ENG_01','W12_ENG','S01','ST09','Present','2026-07-23'),
('A_W12_ENG_02','W12_ENG','S02','ST09','Present','2026-07-23'),
('A_W12_ENG_03','W12_ENG','S03','ST09','Present','2026-07-23'),
('A_W12_ENG_04','W12_ENG','S04','ST09','Present','2026-07-23'),
('A_W12_ENG_05','W12_ENG','S05','ST09','Present','2026-07-23'),
('A_W12_ENG_06','W12_ENG','S06','ST09','Present','2026-07-23'),
('A_W12_ENG_07','W12_ENG','S07','ST09','Present','2026-07-23'),
('A_W12_ENG_08','W12_ENG','S08','ST09','Present','2026-07-23'),
('A_W12_ENG_09','W12_ENG','S09','ST09','Present','2026-07-23'),
('A_W12_ENG_10','W12_ENG','S10','ST09','Present','2026-07-23'),

('A_W12_DBS_01','W12_DBS','S01','ST10','Present','2026-07-23'),
('A_W12_DBS_02','W12_DBS','S02','ST10','Present','2026-07-23'),
('A_W12_DBS_03','W12_DBS','S03','ST10','Present','2026-07-23'),
('A_W12_DBS_04','W12_DBS','S04','ST10','Present','2026-07-23'),
('A_W12_DBS_05','W12_DBS','S05','ST10','Present','2026-07-23'),
('A_W12_DBS_06','W12_DBS','S06','ST10','Present','2026-07-23'),
('A_W12_DBS_07','W12_DBS','S07','ST10','Present','2026-07-23'),
('A_W12_DBS_08','W12_DBS','S08','ST10','Present','2026-07-23'),
('A_W12_DBS_09','W12_DBS','S09','ST10','Present','2026-07-23'),
('A_W12_DBS_10','W12_DBS','S10','ST10','Present','2026-07-23'),

('A_W12_WEBP2_01','W12_WEBP2','S01','ST07','Present','2026-07-23'),
('A_W12_WEBP2_02','W12_WEBP2','S02','ST07','Present','2026-07-23'),
('A_W12_WEBP2_03','W12_WEBP2','S03','ST07','Present','2026-07-23'),
('A_W12_WEBP2_04','W12_WEBP2','S04','ST07','Present','2026-07-23'),
('A_W12_WEBP2_05','W12_WEBP2','S05','ST07','Present','2026-07-23'),
('A_W12_WEBP2_06','W12_WEBP2','S06','ST07','Present','2026-07-23'),
('A_W12_WEBP2_07','W12_WEBP2','S07','ST07','Present','2026-07-23'),
('A_W12_WEBP2_08','W12_WEBP2','S08','ST07','Present','2026-07-23'),
('A_W12_WEBP2_09','W12_WEBP2','S09','ST07','Present','2026-07-23'),
('A_W12_WEBP2_10','W12_WEBP2','S10','ST07','Present','2026-07-23'),

('A_W12_OSC_01','W12_OSC','S01','ST03','Present','2026-07-24'),
('A_W12_OSC_02','W12_OSC','S02','ST03','Present','2026-07-24'),
('A_W12_OSC_03','W12_OSC','S03','ST03','Present','2026-07-24'),
('A_W12_OSC_04','W12_OSC','S04','ST03','Present','2026-07-24'),
('A_W12_OSC_05','W12_OSC','S05','ST03','Present','2026-07-24'),
('A_W12_OSC_06','W12_OSC','S06','ST03','Present','2026-07-24'),
('A_W12_OSC_07','W12_OSC','S07','ST03','Present','2026-07-24'),
('A_W12_OSC_08','W12_OSC','S08','ST03','Present','2026-07-24'),
('A_W12_OSC_09','W12_OSC','S09','ST03','Present','2026-07-24'),
('A_W12_OSC_10','W12_OSC','S10','ST03','Present','2026-07-24'),

-- ================= WEEK 13 =================

('A_W13_MGT_01','W13_MGT','S01','ST03','Present','2026-07-27'),
('A_W13_MGT_02','W13_MGT','S02','ST03','Present','2026-07-27'),
('A_W13_MGT_03','W13_MGT','S03','ST03','Present','2026-07-27'),
('A_W13_MGT_04','W13_MGT','S04','ST03','Present','2026-07-27'),
('A_W13_MGT_05','W13_MGT','S05','ST03','Present','2026-07-27'),
('A_W13_MGT_06','W13_MGT','S06','ST03','Present','2026-07-27'),
('A_W13_MGT_07','W13_MGT','S07','ST03','Present','2026-07-27'),
('A_W13_MGT_08','W13_MGT','S08','ST03','Present','2026-07-27'),
('A_W13_MGT_09','W13_MGT','S09','ST03','Present','2026-07-27'),
('A_W13_MGT_10','W13_MGT','S10','ST03','Present','2026-07-27'),

('A_W13_LIN_01','W13_LIN','S01','ST04','Present','2026-07-27'),
('A_W13_LIN_02','W13_LIN','S02','ST04','Present','2026-07-27'),
('A_W13_LIN_03','W13_LIN','S03','ST04','Present','2026-07-27'),
('A_W13_LIN_04','W13_LIN','S04','ST04','Present','2026-07-27'),
('A_W13_LIN_05','W13_LIN','S05','ST04','Present','2026-07-27'),
('A_W13_LIN_06','W13_LIN','S06','ST04','Present','2026-07-27'),
('A_W13_LIN_07','W13_LIN','S07','ST04','Present','2026-07-27'),
('A_W13_LIN_08','W13_LIN','S08','ST04','Present','2026-07-27'),
('A_W13_LIN_09','W13_LIN','S09','ST04','Present','2026-07-27'),
('A_W13_LIN_10','W13_LIN','S10','ST04','Present','2026-07-27'),

('A_W13_DBP_01','W13_DBP','S01','ST05','Present','2026-07-28'),
('A_W13_DBP_02','W13_DBP','S02','ST05','Present','2026-07-28'),
('A_W13_DBP_03','W13_DBP','S03','ST05','Present','2026-07-28'),
('A_W13_DBP_04','W13_DBP','S04','ST05','Present','2026-07-28'),
('A_W13_DBP_05','W13_DBP','S05','ST05','Present','2026-07-28'),
('A_W13_DBP_06','W13_DBP','S06','ST05','Present','2026-07-28'),
('A_W13_DBP_07','W13_DBP','S07','ST05','Present','2026-07-28'),
('A_W13_DBP_08','W13_DBP','S08','ST05','Present','2026-07-28'),
('A_W13_DBP_09','W13_DBP','S09','ST05','Present','2026-07-28'),
('A_W13_DBP_10','W13_DBP','S10','ST05','Present','2026-07-28'),

('A_W13_WEBT_01','W13_WEBT','S01','ST06','Present','2026-07-28'),
('A_W13_WEBT_02','W13_WEBT','S02','ST06','Present','2026-07-28'),
('A_W13_WEBT_03','W13_WEBT','S03','ST06','Present','2026-07-28'),
('A_W13_WEBT_04','W13_WEBT','S04','ST06','Present','2026-07-28'),
('A_W13_WEBT_05','W13_WEBT','S05','ST06','Present','2026-07-28'),
('A_W13_WEBT_06','W13_WEBT','S06','ST06','Present','2026-07-28'),
('A_W13_WEBT_07','W13_WEBT','S07','ST06','Present','2026-07-28'),
('A_W13_WEBT_08','W13_WEBT','S08','ST06','Present','2026-07-28'),
('A_W13_WEBT_09','W13_WEBT','S09','ST06','Present','2026-07-28'),
('A_W13_WEBT_10','W13_WEBT','S10','ST06','Present','2026-07-28'),

('A_W13_WEBP1_01','W13_WEBP1','S01','ST07','Present','2026-07-28'),
('A_W13_WEBP1_02','W13_WEBP1','S02','ST07','Present','2026-07-28'),
('A_W13_WEBP1_03','W13_WEBP1','S03','ST07','Present','2026-07-28'),
('A_W13_WEBP1_04','W13_WEBP1','S04','ST07','Present','2026-07-28'),
('A_W13_WEBP1_05','W13_WEBP1','S05','ST07','Present','2026-07-28'),
('A_W13_WEBP1_06','W13_WEBP1','S06','ST07','Present','2026-07-28'),
('A_W13_WEBP1_07','W13_WEBP1','S07','ST07','Present','2026-07-28'),
('A_W13_WEBP1_08','W13_WEBP1','S08','ST07','Present','2026-07-28'),
('A_W13_WEBP1_09','W13_WEBP1','S09','ST07','Present','2026-07-28'),
('A_W13_WEBP1_10','W13_WEBP1','S10','ST07','Present','2026-07-28'),

('A_W13_MAT_01','W13_MAT','S01','ST08','Present','2026-07-29'),
('A_W13_MAT_02','W13_MAT','S02','ST08','Present','2026-07-29'),
('A_W13_MAT_03','W13_MAT','S03','ST08','Present','2026-07-29'),
('A_W13_MAT_04','W13_MAT','S04','ST08','Present','2026-07-29'),
('A_W13_MAT_05','W13_MAT','S05','ST08','Present','2026-07-29'),
('A_W13_MAT_06','W13_MAT','S06','ST08','Present','2026-07-29'),
('A_W13_MAT_07','W13_MAT','S07','ST08','Present','2026-07-29'),
('A_W13_MAT_08','W13_MAT','S08','ST08','Present','2026-07-29'),
('A_W13_MAT_09','W13_MAT','S09','ST08','Present','2026-07-29'),
('A_W13_MAT_10','W13_MAT','S10','ST08','Present','2026-07-29'),

('A_W13_ENG_01','W13_ENG','S01','ST09','Present','2026-07-30'),
('A_W13_ENG_02','W13_ENG','S02','ST09','Present','2026-07-30'),
('A_W13_ENG_03','W13_ENG','S03','ST09','Present','2026-07-30'),
('A_W13_ENG_04','W13_ENG','S04','ST09','Present','2026-07-30'),
('A_W13_ENG_05','W13_ENG','S05','ST09','Present','2026-07-30'),
('A_W13_ENG_06','W13_ENG','S06','ST09','Present','2026-07-30'),
('A_W13_ENG_07','W13_ENG','S07','ST09','Present','2026-07-30'),
('A_W13_ENG_08','W13_ENG','S08','ST09','Present','2026-07-30'),
('A_W13_ENG_09','W13_ENG','S09','ST09','Present','2026-07-30'),
('A_W13_ENG_10','W13_ENG','S10','ST09','Present','2026-07-30'),

('A_W13_DBS_01','W13_DBS','S01','ST10','Present','2026-07-30'),
('A_W13_DBS_02','W13_DBS','S02','ST10','Present','2026-07-30'),
('A_W13_DBS_03','W13_DBS','S03','ST10','Present','2026-07-30'),
('A_W13_DBS_04','W13_DBS','S04','ST10','Present','2026-07-30'),
('A_W13_DBS_05','W13_DBS','S05','ST10','Present','2026-07-30'),
('A_W13_DBS_06','W13_DBS','S06','ST10','Present','2026-07-30'),
('A_W13_DBS_07','W13_DBS','S07','ST10','Present','2026-07-30'),
('A_W13_DBS_08','W13_DBS','S08','ST10','Present','2026-07-30'),
('A_W13_DBS_09','W13_DBS','S09','ST10','Present','2026-07-30'),
('A_W13_DBS_10','W13_DBS','S10','ST10','Present','2026-07-30'),

('A_W13_WEBP2_01','W13_WEBP2','S01','ST07','Present','2026-07-30'),
('A_W13_WEBP2_02','W13_WEBP2','S02','ST07','Present','2026-07-30'),
('A_W13_WEBP2_03','W13_WEBP2','S03','ST07','Present','2026-07-30'),
('A_W13_WEBP2_04','W13_WEBP2','S04','ST07','Present','2026-07-30'),
('A_W13_WEBP2_05','W13_WEBP2','S05','ST07','Present','2026-07-30'),
('A_W13_WEBP2_06','W13_WEBP2','S06','ST07','Present','2026-07-30'),
('A_W13_WEBP2_07','W13_WEBP2','S07','ST07','Present','2026-07-30'),
('A_W13_WEBP2_08','W13_WEBP2','S08','ST07','Present','2026-07-30'),
('A_W13_WEBP2_09','W13_WEBP2','S09','ST07','Present','2026-07-30'),
('A_W13_WEBP2_10','W13_WEBP2','S10','ST07','Present','2026-07-30'),

('A_W13_OSC_01','W13_OSC','S01','ST03','Present','2026-07-31'),
('A_W13_OSC_02','W13_OSC','S02','ST03','Present','2026-07-31'),
('A_W13_OSC_03','W13_OSC','S03','ST03','Present','2026-07-31'),
('A_W13_OSC_04','W13_OSC','S04','ST03','Present','2026-07-31'),
('A_W13_OSC_05','W13_OSC','S05','ST03','Present','2026-07-31'),
('A_W13_OSC_06','W13_OSC','S06','ST03','Present','2026-07-31'),
('A_W13_OSC_07','W13_OSC','S07','ST03','Present','2026-07-31'),
('A_W13_OSC_08','W13_OSC','S08','ST03','Present','2026-07-31'),
('A_W13_OSC_09','W13_OSC','S09','ST03','Present','2026-07-31'),
('A_W13_OSC_10','W13_OSC','S10','ST03','Present','2026-07-31'),

-- ================= WEEK 14 =================

('A_W14_MGT_01','W14_MGT','S01','ST03','Present','2026-08-03'),
('A_W14_MGT_02','W14_MGT','S02','ST03','Present','2026-08-03'),
('A_W14_MGT_03','W14_MGT','S03','ST03','Present','2026-08-03'),
('A_W14_MGT_04','W14_MGT','S04','ST03','Present','2026-08-03'),
('A_W14_MGT_05','W14_MGT','S05','ST03','Present','2026-08-03'),
('A_W14_MGT_06','W14_MGT','S06','ST03','Present','2026-08-03'),
('A_W14_MGT_07','W14_MGT','S07','ST03','Present','2026-08-03'),
('A_W14_MGT_08','W14_MGT','S08','ST03','Present','2026-08-03'),
('A_W14_MGT_09','W14_MGT','S09','ST03','Present','2026-08-03'),
('A_W14_MGT_10','W14_MGT','S10','ST03','Present','2026-08-03'),

('A_W14_LIN_01','W14_LIN','S01','ST04','Present','2026-08-03'),
('A_W14_LIN_02','W14_LIN','S02','ST04','Present','2026-08-03'),
('A_W14_LIN_03','W14_LIN','S03','ST04','Present','2026-08-03'),
('A_W14_LIN_04','W14_LIN','S04','ST04','Present','2026-08-03'),
('A_W14_LIN_05','W14_LIN','S05','ST04','Present','2026-08-03'),
('A_W14_LIN_06','W14_LIN','S06','ST04','Present','2026-08-03'),
('A_W14_LIN_07','W14_LIN','S07','ST04','Present','2026-08-03'),
('A_W14_LIN_08','W14_LIN','S08','ST04','Present','2026-08-03'),
('A_W14_LIN_09','W14_LIN','S09','ST04','Present','2026-08-03'),
('A_W14_LIN_10','W14_LIN','S10','ST04','Present','2026-08-03'),

('A_W14_DBP_01','W14_DBP','S01','ST05','Present','2026-08-04'),
('A_W14_DBP_02','W14_DBP','S02','ST05','Present','2026-08-04'),
('A_W14_DBP_03','W14_DBP','S03','ST05','Present','2026-08-04'),
('A_W14_DBP_04','W14_DBP','S04','ST05','Present','2026-08-04'),
('A_W14_DBP_05','W14_DBP','S05','ST05','Present','2026-08-04'),
('A_W14_DBP_06','W14_DBP','S06','ST05','Present','2026-08-04'),
('A_W14_DBP_07','W14_DBP','S07','ST05','Present','2026-08-04'),
('A_W14_DBP_08','W14_DBP','S08','ST05','Present','2026-08-04'),
('A_W14_DBP_09','W14_DBP','S09','ST05','Present','2026-08-04'),
('A_W14_DBP_10','W14_DBP','S10','ST05','Present','2026-08-04'),

('A_W14_WEBT_01','W14_WEBT','S01','ST06','Present','2026-08-04'),
('A_W14_WEBT_02','W14_WEBT','S02','ST06','Present','2026-08-04'),
('A_W14_WEBT_03','W14_WEBT','S03','ST06','Present','2026-08-04'),
('A_W14_WEBT_04','W14_WEBT','S04','ST06','Present','2026-08-04'),
('A_W14_WEBT_05','W14_WEBT','S05','ST06','Present','2026-08-04'),
('A_W14_WEBT_06','W14_WEBT','S06','ST06','Present','2026-08-04'),
('A_W14_WEBT_07','W14_WEBT','S07','ST06','Present','2026-08-04'),
('A_W14_WEBT_08','W14_WEBT','S08','ST06','Present','2026-08-04'),
('A_W14_WEBT_09','W14_WEBT','S09','ST06','Present','2026-08-04'),
('A_W14_WEBT_10','W14_WEBT','S10','ST06','Present','2026-08-04'),

('A_W14_WEBP1_01','W14_WEBP1','S01','ST07','Present','2026-08-04'),
('A_W14_WEBP1_02','W14_WEBP1','S02','ST07','Present','2026-08-04'),
('A_W14_WEBP1_03','W14_WEBP1','S03','ST07','Present','2026-08-04'),
('A_W14_WEBP1_04','W14_WEBP1','S04','ST07','Present','2026-08-04'),
('A_W14_WEBP1_05','W14_WEBP1','S05','ST07','Present','2026-08-04'),
('A_W14_WEBP1_06','W14_WEBP1','S06','ST07','Present','2026-08-04'),
('A_W14_WEBP1_07','W14_WEBP1','S07','ST07','Present','2026-08-04'),
('A_W14_WEBP1_08','W14_WEBP1','S08','ST07','Present','2026-08-04'),
('A_W14_WEBP1_09','W14_WEBP1','S09','ST07','Present','2026-08-04'),
('A_W14_WEBP1_10','W14_WEBP1','S10','ST07','Present','2026-08-04'),

('A_W14_MAT_01','W14_MAT','S01','ST08','Present','2026-08-05'),
('A_W14_MAT_02','W14_MAT','S02','ST08','Present','2026-08-05'),
('A_W14_MAT_03','W14_MAT','S03','ST08','Present','2026-08-05'),
('A_W14_MAT_04','W14_MAT','S04','ST08','Present','2026-08-05'),
('A_W14_MAT_05','W14_MAT','S05','ST08','Present','2026-08-05'),
('A_W14_MAT_06','W14_MAT','S06','ST08','Present','2026-08-05'),
('A_W14_MAT_07','W14_MAT','S07','ST08','Present','2026-08-05'),
('A_W14_MAT_08','W14_MAT','S08','ST08','Present','2026-08-05'),
('A_W14_MAT_09','W14_MAT','S09','ST08','Present','2026-08-05'),
('A_W14_MAT_10','W14_MAT','S10','ST08','Present','2026-08-05'),

('A_W14_ENG_01','W14_ENG','S01','ST09','Present','2026-08-06'),
('A_W14_ENG_02','W14_ENG','S02','ST09','Present','2026-08-06'),
('A_W14_ENG_03','W14_ENG','S03','ST09','Present','2026-08-06'),
('A_W14_ENG_04','W14_ENG','S04','ST09','Present','2026-08-06'),
('A_W14_ENG_05','W14_ENG','S05','ST09','Present','2026-08-06'),
('A_W14_ENG_06','W14_ENG','S06','ST09','Present','2026-08-06'),
('A_W14_ENG_07','W14_ENG','S07','ST09','Present','2026-08-06'),
('A_W14_ENG_08','W14_ENG','S08','ST09','Present','2026-08-06'),
('A_W14_ENG_09','W14_ENG','S09','ST09','Present','2026-08-06'),
('A_W14_ENG_10','W14_ENG','S10','ST09','Present','2026-08-06'),

('A_W14_DBS_01','W14_DBS','S01','ST10','Present','2026-08-06'),
('A_W14_DBS_02','W14_DBS','S02','ST10','Present','2026-08-06'),
('A_W14_DBS_03','W14_DBS','S03','ST10','Present','2026-08-06'),
('A_W14_DBS_04','W14_DBS','S04','ST10','Present','2026-08-06'),
('A_W14_DBS_05','W14_DBS','S05','ST10','Present','2026-08-06'),
('A_W14_DBS_06','W14_DBS','S06','ST10','Present','2026-08-06'),
('A_W14_DBS_07','W14_DBS','S07','ST10','Present','2026-08-06'),
('A_W14_DBS_08','W14_DBS','S08','ST10','Present','2026-08-06'),
('A_W14_DBS_09','W14_DBS','S09','ST10','Present','2026-08-06'),
('A_W14_DBS_10','W14_DBS','S10','ST10','Present','2026-08-06'),

('A_W14_WEBP2_01','W14_WEBP2','S01','ST07','Present','2026-08-06'),
('A_W14_WEBP2_02','W14_WEBP2','S02','ST07','Present','2026-08-06'),
('A_W14_WEBP2_03','W14_WEBP2','S03','ST07','Present','2026-08-06'),
('A_W14_WEBP2_04','W14_WEBP2','S04','ST07','Present','2026-08-06'),
('A_W14_WEBP2_05','W14_WEBP2','S05','ST07','Present','2026-08-06'),
('A_W14_WEBP2_06','W14_WEBP2','S06','ST07','Present','2026-08-06'),
('A_W14_WEBP2_07','W14_WEBP2','S07','ST07','Present','2026-08-06'),
('A_W14_WEBP2_08','W14_WEBP2','S08','ST07','Present','2026-08-06'),
('A_W14_WEBP2_09','W14_WEBP2','S09','ST07','Present','2026-08-06'),
('A_W14_WEBP2_10','W14_WEBP2','S10','ST07','Present','2026-08-06'),

('A_W14_OSC_01','W14_OSC','S01','ST03','Present','2026-08-07'),
('A_W14_OSC_02','W14_OSC','S02','ST03','Present','2026-08-07'),
('A_W14_OSC_03','W14_OSC','S03','ST03','Present','2026-08-07'),
('A_W14_OSC_04','W14_OSC','S04','ST03','Present','2026-08-07'),
('A_W14_OSC_05','W14_OSC','S05','ST03','Present','2026-08-07'),
('A_W14_OSC_06','W14_OSC','S06','ST03','Present','2026-08-07'),
('A_W14_OSC_07','W14_OSC','S07','ST03','Present','2026-08-07'),
('A_W14_OSC_08','W14_OSC','S08','ST03','Present','2026-08-07'),
('A_W14_OSC_09','W14_OSC','S09','ST03','Present','2026-08-07'),
('A_W14_OSC_10','W14_OSC','S10','ST03','Present','2026-08-07'),

-- ================= WEEK 15 =================

('A_W15_MGT_01','W15_MGT','S01','ST03','Present','2026-08-10'),
('A_W15_MGT_02','W15_MGT','S02','ST03','Present','2026-08-10'),
('A_W15_MGT_03','W15_MGT','S03','ST03','Present','2026-08-10'),
('A_W15_MGT_04','W15_MGT','S04','ST03','Present','2026-08-10'),
('A_W15_MGT_05','W15_MGT','S05','ST03','Present','2026-08-10'),
('A_W15_MGT_06','W15_MGT','S06','ST03','Present','2026-08-10'),
('A_W15_MGT_07','W15_MGT','S07','ST03','Present','2026-08-10'),
('A_W15_MGT_08','W15_MGT','S08','ST03','Present','2026-08-10'),
('A_W15_MGT_09','W15_MGT','S09','ST03','Present','2026-08-10'),
('A_W15_MGT_10','W15_MGT','S10','ST03','Present','2026-08-10'),

('A_W15_LIN_01','W15_LIN','S01','ST04','Present','2026-08-10'),
('A_W15_LIN_02','W15_LIN','S02','ST04','Present','2026-08-10'),
('A_W15_LIN_03','W15_LIN','S03','ST04','Present','2026-08-10'),
('A_W15_LIN_04','W15_LIN','S04','ST04','Present','2026-08-10'),
('A_W15_LIN_05','W15_LIN','S05','ST04','Present','2026-08-10'),
('A_W15_LIN_06','W15_LIN','S06','ST04','Present','2026-08-10'),
('A_W15_LIN_07','W15_LIN','S07','ST04','Present','2026-08-10'),
('A_W15_LIN_08','W15_LIN','S08','ST04','Present','2026-08-10'),
('A_W15_LIN_09','W15_LIN','S09','ST04','Present','2026-08-10'),
('A_W15_LIN_10','W15_LIN','S10','ST04','Present','2026-08-10'),

('A_W15_DBP_01','W15_DBP','S01','ST05','Present','2026-08-11'),
('A_W15_DBP_02','W15_DBP','S02','ST05','Present','2026-08-11'),
('A_W15_DBP_03','W15_DBP','S03','ST05','Present','2026-08-11'),
('A_W15_DBP_04','W15_DBP','S04','ST05','Present','2026-08-11'),
('A_W15_DBP_05','W15_DBP','S05','ST05','Present','2026-08-11'),
('A_W15_DBP_06','W15_DBP','S06','ST05','Present','2026-08-11'),
('A_W15_DBP_07','W15_DBP','S07','ST05','Present','2026-08-11'),
('A_W15_DBP_08','W15_DBP','S08','ST05','Present','2026-08-11'),
('A_W15_DBP_09','W15_DBP','S09','ST05','Present','2026-08-11'),
('A_W15_DBP_10','W15_DBP','S10','ST05','Present','2026-08-11'),

('A_W15_WEBT_01','W15_WEBT','S01','ST06','Present','2026-08-11'),
('A_W15_WEBT_02','W15_WEBT','S02','ST06','Present','2026-08-11'),
('A_W15_WEBT_03','W15_WEBT','S03','ST06','Present','2026-08-11'),
('A_W15_WEBT_04','W15_WEBT','S04','ST06','Present','2026-08-11'),
('A_W15_WEBT_05','W15_WEBT','S05','ST06','Present','2026-08-11'),
('A_W15_WEBT_06','W15_WEBT','S06','ST06','Present','2026-08-11'),
('A_W15_WEBT_07','W15_WEBT','S07','ST06','Present','2026-08-11'),
('A_W15_WEBT_08','W15_WEBT','S08','ST06','Present','2026-08-11'),
('A_W15_WEBT_09','W15_WEBT','S09','ST06','Present','2026-08-11'),
('A_W15_WEBT_10','W15_WEBT','S10','ST06','Present','2026-08-11'),

('A_W15_WEBP1_01','W15_WEBP1','S01','ST07','Present','2026-08-11'),
('A_W15_WEBP1_02','W15_WEBP1','S02','ST07','Present','2026-08-11'),
('A_W15_WEBP1_03','W15_WEBP1','S03','ST07','Present','2026-08-11'),
('A_W15_WEBP1_04','W15_WEBP1','S04','ST07','Present','2026-08-11'),
('A_W15_WEBP1_05','W15_WEBP1','S05','ST07','Present','2026-08-11'),
('A_W15_WEBP1_06','W15_WEBP1','S06','ST07','Present','2026-08-11'),
('A_W15_WEBP1_07','W15_WEBP1','S07','ST07','Present','2026-08-11'),
('A_W15_WEBP1_08','W15_WEBP1','S08','ST07','Present','2026-08-11'),
('A_W15_WEBP1_09','W15_WEBP1','S09','ST07','Present','2026-08-11'),
('A_W15_WEBP1_10','W15_WEBP1','S10','ST07','Present','2026-08-11'),

('A_W15_MAT_01','W15_MAT','S01','ST08','Present','2026-08-12'),
('A_W15_MAT_02','W15_MAT','S02','ST08','Present','2026-08-12'),
('A_W15_MAT_03','W15_MAT','S03','ST08','Present','2026-08-12'),
('A_W15_MAT_04','W15_MAT','S04','ST08','Present','2026-08-12'),
('A_W15_MAT_05','W15_MAT','S05','ST08','Present','2026-08-12'),
('A_W15_MAT_06','W15_MAT','S06','ST08','Present','2026-08-12'),
('A_W15_MAT_07','W15_MAT','S07','ST08','Present','2026-08-12'),
('A_W15_MAT_08','W15_MAT','S08','ST08','Present','2026-08-12'),
('A_W15_MAT_09','W15_MAT','S09','ST08','Absent','2026-08-12'),
('A_W15_MAT_10','W15_MAT','S10','ST08','Present','2026-08-12'),

('A_W15_ENG_01','W15_ENG','S01','ST09','Present','2026-08-13'),
('A_W15_ENG_02','W15_ENG','S02','ST09','Present','2026-08-13'),
('A_W15_ENG_03','W15_ENG','S03','ST09','Present','2026-08-13'),
('A_W15_ENG_04','W15_ENG','S04','ST09','Present','2026-08-13'),
('A_W15_ENG_05','W15_ENG','S05','ST09','Present','2026-08-13'),
('A_W15_ENG_06','W15_ENG','S06','ST09','Present','2026-08-13'),
('A_W15_ENG_07','W15_ENG','S07','ST09','Present','2026-08-13'),
('A_W15_ENG_08','W15_ENG','S08','ST09','Present','2026-08-13'),
('A_W15_ENG_09','W15_ENG','S09','ST09','Present','2026-08-13'),
('A_W15_ENG_10','W15_ENG','S10','ST09','Present','2026-08-13'),

('A_W15_DBS_01','W15_DBS','S01','ST10','Present','2026-08-13'),
('A_W15_DBS_02','W15_DBS','S02','ST10','Present','2026-08-13'),
('A_W15_DBS_03','W15_DBS','S03','ST10','Present','2026-08-13'),
('A_W15_DBS_04','W15_DBS','S04','ST10','Present','2026-08-13'),
('A_W15_DBS_05','W15_DBS','S05','ST10','Present','2026-08-13'),
('A_W15_DBS_06','W15_DBS','S06','ST10','Present','2026-08-13'),
('A_W15_DBS_07','W15_DBS','S07','ST10','Present','2026-08-13'),
('A_W15_DBS_08','W15_DBS','S08','ST10','Present','2026-08-13'),
('A_W15_DBS_09','W15_DBS','S09','ST10','Present','2026-08-13'),
('A_W15_DBS_10','W15_DBS','S10','ST10','Present','2026-08-13'),

('A_W15_WEBP2_01','W15_WEBP2','S01','ST07','Present','2026-08-13'),
('A_W15_WEBP2_02','W15_WEBP2','S02','ST07','Present','2026-08-13'),
('A_W15_WEBP2_03','W15_WEBP2','S03','ST07','Present','2026-08-13'),
('A_W15_WEBP2_04','W15_WEBP2','S04','ST07','Present','2026-08-13'),
('A_W15_WEBP2_05','W15_WEBP2','S05','ST07','Present','2026-08-13'),
('A_W15_WEBP2_06','W15_WEBP2','S06','ST07','Present','2026-08-13'),
('A_W15_WEBP2_07','W15_WEBP2','S07','ST07','Present','2026-08-13'),
('A_W15_WEBP2_08','W15_WEBP2','S08','ST07','Present','2026-08-13'),
('A_W15_WEBP2_09','W15_WEBP2','S09','ST07','Present','2026-08-13'),
('A_W15_WEBP2_10','W15_WEBP2','S10','ST07','Present','2026-08-13'),

('A_W15_OSC_01','W15_OSC','S01','ST03','Present','2026-08-14'),
('A_W15_OSC_02','W15_OSC','S02','ST03','Present','2026-08-14'),
('A_W15_OSC_03','W15_OSC','S03','ST03','Present','2026-08-14'),
('A_W15_OSC_04','W15_OSC','S04','ST03','Present','2026-08-14'),
('A_W15_OSC_05','W15_OSC','S05','ST03','Present','2026-08-14'),
('A_W15_OSC_06','W15_OSC','S06','ST03','Present','2026-08-14'),
('A_W15_OSC_07','W15_OSC','S07','ST03','Present','2026-08-14'),
('A_W15_OSC_08','W15_OSC','S08','ST03','Present','2026-08-14'),
('A_W15_OSC_09','W15_OSC','S09','ST03','Present','2026-08-14'),
('A_W15_OSC_10','W15_OSC','S10','ST03','Present','2026-08-14');

INSERT INTO ATTENDANCE_RECORD (Attendance_ID, session_id, student_id, marked_by, attendance_status, marked_date) VALUES

-- ================= WEEK 01 =================

('A_W01_MGT_11','W01_MGT','S11','ST03','Present','2026-05-04'),
('A_W01_MGT_12','W01_MGT','S12','ST03','Medical','2026-05-04'),
('A_W01_MGT_13','W01_MGT','S13','ST03','Absent','2026-05-04'),
('A_W01_MGT_14','W01_MGT','S14','ST03','Present','2026-05-04'),
('A_W01_MGT_15','W01_MGT','S15','ST03','Present','2026-05-04'),
('A_W01_MGT_16','W01_MGT','S16','ST03','Present','2026-05-04'),
('A_W01_MGT_17','W01_MGT','S17','ST03','Absent','2026-05-04'),
('A_W01_MGT_18','W01_MGT','S18','ST03','Present','2026-05-04'),
('A_W01_MGT_19','W01_MGT','S19','ST03','Absent','2026-05-04'),
('A_W01_MGT_20','W01_MGT','S20','ST03','Present','2026-05-04'),
('A_W01_MGT_21','W01_MGT','S21','ST03','Absent','2026-05-04'),
('A_W01_MGT_22','W01_MGT','S22','ST03','Present','2026-05-04'),
('A_W01_MGT_23','W01_MGT','S23','ST03','Present','2026-05-04'),
('A_W01_MGT_24','W01_MGT','S24','ST03','Present','2026-05-04'),
('A_W01_MGT_25','W01_MGT','S25','ST03','Present','2026-05-04'),

('A_W01_LIN_11','W01_LIN','S11','ST04','Present','2026-05-04'),
('A_W01_LIN_12','W01_LIN','S12','ST04','Present','2026-05-04'),
('A_W01_LIN_13','W01_LIN','S13','ST04','Absent','2026-05-04'),
('A_W01_LIN_14','W01_LIN','S14','ST04','Present','2026-05-04'),
('A_W01_LIN_15','W01_LIN','S15','ST04','Present','2026-05-04'),
('A_W01_LIN_16','W01_LIN','S16','ST04','Present','2026-05-04'),
('A_W01_LIN_17','W01_LIN','S17','ST04','Absent','2026-05-04'),
('A_W01_LIN_18','W01_LIN','S18','ST04','Present','2026-05-04'),
('A_W01_LIN_19','W01_LIN','S19','ST04','Absent','2026-05-04'),
('A_W01_LIN_20','W01_LIN','S20','ST04','Present','2026-05-04'),
('A_W01_LIN_21','W01_LIN','S21','ST04','Absent','2026-05-04'),
('A_W01_LIN_22','W01_LIN','S22','ST04','Present','2026-05-04'),
('A_W01_LIN_23','W01_LIN','S23','ST04','Present','2026-05-04'),
('A_W01_LIN_24','W01_LIN','S24','ST04','Absent','2026-05-04'),
('A_W01_LIN_25','W01_LIN','S25','ST04','Present','2026-05-04'),

('A_W01_DBP_11','W01_DBP','S11','ST05','Medical','2026-05-05'),
('A_W01_DBP_12','W01_DBP','S12','ST05','Present','2026-05-05'),
('A_W01_DBP_13','W01_DBP','S13','ST05','Present','2026-05-05'),
('A_W01_DBP_14','W01_DBP','S14','ST05','Present','2026-05-05'),
('A_W01_DBP_15','W01_DBP','S15','ST05','Present','2026-05-05'),
('A_W01_DBP_16','W01_DBP','S16','ST05','Present','2026-05-05'),
('A_W01_DBP_17','W01_DBP','S17','ST05','Present','2026-05-05'),
('A_W01_DBP_18','W01_DBP','S18','ST05','Present','2026-05-05'),
('A_W01_DBP_19','W01_DBP','S19','ST05','Absent','2026-05-05'),
('A_W01_DBP_20','W01_DBP','S20','ST05','Present','2026-05-05'),
('A_W01_DBP_21','W01_DBP','S21','ST05','Absent','2026-05-05'),
('A_W01_DBP_22','W01_DBP','S22','ST05','Present','2026-05-05'),
('A_W01_DBP_23','W01_DBP','S23','ST05','Present','2026-05-05'),
('A_W01_DBP_24','W01_DBP','S24','ST05','Absent','2026-05-05'),
('A_W01_DBP_25','W01_DBP','S25','ST05','Present','2026-05-05'),

('A_W01_WEBT_11','W01_WEBT','S11','ST06','Present','2026-05-05'),
('A_W01_WEBT_12','W01_WEBT','S12','ST06','Present','2026-05-05'),
('A_W01_WEBT_13','W01_WEBT','S13','ST06','Present','2026-05-05'),
('A_W01_WEBT_14','W01_WEBT','S14','ST06','Present','2026-05-05'),
('A_W01_WEBT_15','W01_WEBT','S15','ST06','Present','2026-05-05'),
('A_W01_WEBT_16','W01_WEBT','S16','ST06','Present','2026-05-05'),
('A_W01_WEBT_17','W01_WEBT','S17','ST06','Absent','2026-05-05'),
('A_W01_WEBT_18','W01_WEBT','S18','ST06','Present','2026-05-05'),
('A_W01_WEBT_19','W01_WEBT','S19','ST06','Present','2026-05-05'),
('A_W01_WEBT_20','W01_WEBT','S20','ST06','Present','2026-05-05'),
('A_W01_WEBT_21','W01_WEBT','S21','ST06','Absent','2026-05-05'),
('A_W01_WEBT_22','W01_WEBT','S22','ST06','Present','2026-05-05'),
('A_W01_WEBT_23','W01_WEBT','S23','ST06','Present','2026-05-05'),
('A_W01_WEBT_24','W01_WEBT','S24','ST06','Absent','2026-05-05'),
('A_W01_WEBT_25','W01_WEBT','S25','ST06','Present','2026-05-05'),

('A_W01_WEBP1_11','W01_WEBP1','S11','ST07','Present','2026-05-05'),
('A_W01_WEBP1_12','W01_WEBP1','S12','ST07','Present','2026-05-05'),
('A_W01_WEBP1_13','W01_WEBP1','S13','ST07','Present','2026-05-05'),
('A_W01_WEBP1_14','W01_WEBP1','S14','ST07','Present','2026-05-05'),
('A_W01_WEBP1_15','W01_WEBP1','S15','ST07','Present','2026-05-05'),
('A_W01_WEBP1_16','W01_WEBP1','S16','ST07','Present','2026-05-05'),
('A_W01_WEBP1_17','W01_WEBP1','S17','ST07','Absent','2026-05-05'),
('A_W01_WEBP1_18','W01_WEBP1','S18','ST07','Present','2026-05-05'),
('A_W01_WEBP1_19','W01_WEBP1','S19','ST07','Absent','2026-05-05'),
('A_W01_WEBP1_20','W01_WEBP1','S20','ST07','Present','2026-05-05'),
('A_W01_WEBP1_21','W01_WEBP1','S21','ST07','Present','2026-05-05'),
('A_W01_WEBP1_22','W01_WEBP1','S22','ST07','Present','2026-05-05'),
('A_W01_WEBP1_23','W01_WEBP1','S23','ST07','Present','2026-05-05'),
('A_W01_WEBP1_24','W01_WEBP1','S24','ST07','Present','2026-05-05'),
('A_W01_WEBP1_25','W01_WEBP1','S25','ST07','Present','2026-05-05'),

('A_W01_MAT_11','W01_MAT','S11','ST08','Present','2026-05-06'),
('A_W01_MAT_12','W01_MAT','S12','ST08','Present','2026-05-06'),
('A_W01_MAT_13','W01_MAT','S13','ST08','Absent','2026-05-06'),
('A_W01_MAT_14','W01_MAT','S14','ST08','Present','2026-05-06'),
('A_W01_MAT_15','W01_MAT','S15','ST08','Present','2026-05-06'),
('A_W01_MAT_16','W01_MAT','S16','ST08','Present','2026-05-06'),
('A_W01_MAT_17','W01_MAT','S17','ST08','Absent','2026-05-06'),
('A_W01_MAT_18','W01_MAT','S18','ST08','Present','2026-05-06'),
('A_W01_MAT_19','W01_MAT','S19','ST08','Absent','2026-05-06'),
('A_W01_MAT_20','W01_MAT','S20','ST08','Present','2026-05-06'),
('A_W01_MAT_21','W01_MAT','S21','ST08','Present','2026-05-06'),
('A_W01_MAT_22','W01_MAT','S22','ST08','Present','2026-05-06'),
('A_W01_MAT_23','W01_MAT','S23','ST08','Present','2026-05-06'),
('A_W01_MAT_24','W01_MAT','S24','ST08','Absent','2026-05-06'),
('A_W01_MAT_25','W01_MAT','S25','ST08','Present','2026-05-06'),

('A_W01_ENG_11','W01_ENG','S11','ST09','Present','2026-05-07'),
('A_W01_ENG_12','W01_ENG','S12','ST09','Present','2026-05-07'),
('A_W01_ENG_13','W01_ENG','S13','ST09','Absent','2026-05-07'),
('A_W01_ENG_14','W01_ENG','S14','ST09','Present','2026-05-07'),
('A_W01_ENG_15','W01_ENG','S15','ST09','Present','2026-05-07'),
('A_W01_ENG_16','W01_ENG','S16','ST09','Present','2026-05-07'),
('A_W01_ENG_17','W01_ENG','S17','ST09','Absent','2026-05-07'),
('A_W01_ENG_18','W01_ENG','S18','ST09','Present','2026-05-07'),
('A_W01_ENG_19','W01_ENG','S19','ST09','Present','2026-05-07'),
('A_W01_ENG_20','W01_ENG','S20','ST09','Absent','2026-05-07'),
('A_W01_ENG_21','W01_ENG','S21','ST09','Present','2026-05-07'),
('A_W01_ENG_22','W01_ENG','S22','ST09','Present','2026-05-07'),
('A_W01_ENG_23','W01_ENG','S23','ST09','Present','2026-05-07'),
('A_W01_ENG_24','W01_ENG','S24','ST09','Present','2026-05-07'),
('A_W01_ENG_25','W01_ENG','S25','ST09','Present','2026-05-07'),

('A_W01_DBS_11','W01_DBS','S11','ST10','Present','2026-05-07'),
('A_W01_DBS_12','W01_DBS','S12','ST10','Present','2026-05-07'),
('A_W01_DBS_13','W01_DBS','S13','ST10','Present','2026-05-07'),
('A_W01_DBS_14','W01_DBS','S14','ST10','Present','2026-05-07'),
('A_W01_DBS_15','W01_DBS','S15','ST10','Present','2026-05-07'),
('A_W01_DBS_16','W01_DBS','S16','ST10','Present','2026-05-07'),
('A_W01_DBS_17','W01_DBS','S17','ST10','Absent','2026-05-07'),
('A_W01_DBS_18','W01_DBS','S18','ST10','Present','2026-05-07'),
('A_W01_DBS_19','W01_DBS','S19','ST10','Present','2026-05-07'),
('A_W01_DBS_20','W01_DBS','S20','ST10','Present','2026-05-07'),
('A_W01_DBS_21','W01_DBS','S21','ST10','Present','2026-05-07'),
('A_W01_DBS_22','W01_DBS','S22','ST10','Present','2026-05-07'),
('A_W01_DBS_23','W01_DBS','S23','ST10','Present','2026-05-07'),
('A_W01_DBS_24','W01_DBS','S24','ST10','Present','2026-05-07'),
('A_W01_DBS_25','W01_DBS','S25','ST10','Present','2026-05-07'),

('A_W01_WEBP2_11','W01_WEBP2','S11','ST07','Present','2026-05-07'),
('A_W01_WEBP2_12','W01_WEBP2','S12','ST07','Present','2026-05-07'),
('A_W01_WEBP2_13','W01_WEBP2','S13','ST07','Absent','2026-05-07'),
('A_W01_WEBP2_14','W01_WEBP2','S14','ST07','Present','2026-05-07'),
('A_W01_WEBP2_15','W01_WEBP2','S15','ST07','Medical','2026-05-07'),
('A_W01_WEBP2_16','W01_WEBP2','S16','ST07','Present','2026-05-07'),
('A_W01_WEBP2_17','W01_WEBP2','S17','ST07','Present','2026-05-07'),
('A_W01_WEBP2_18','W01_WEBP2','S18','ST07','Present','2026-05-07'),
('A_W01_WEBP2_19','W01_WEBP2','S19','ST07','Absent','2026-05-07'),
('A_W01_WEBP2_20','W01_WEBP2','S20','ST07','Present','2026-05-07'),
('A_W01_WEBP2_21','W01_WEBP2','S21','ST07','Present','2026-05-07'),
('A_W01_WEBP2_22','W01_WEBP2','S22','ST07','Present','2026-05-07'),
('A_W01_WEBP2_23','W01_WEBP2','S23','ST07','Present','2026-05-07'),
('A_W01_WEBP2_24','W01_WEBP2','S24','ST07','Absent','2026-05-07'),
('A_W01_WEBP2_25','W01_WEBP2','S25','ST07','Present','2026-05-07'),

('A_W01_OSC_11','W01_OSC','S11','ST03','Present','2026-05-08'),
('A_W01_OSC_12','W01_OSC','S12','ST03','Present','2026-05-08'),
('A_W01_OSC_13','W01_OSC','S13','ST03','Absent','2026-05-08'),
('A_W01_OSC_14','W01_OSC','S14','ST03','Present','2026-05-08'),
('A_W01_OSC_15','W01_OSC','S15','ST03','Present','2026-05-08'),
('A_W01_OSC_16','W01_OSC','S16','ST03','Present','2026-05-08'),
('A_W01_OSC_17','W01_OSC','S17','ST03','Absent','2026-05-08'),
('A_W01_OSC_18','W01_OSC','S18','ST03','Present','2026-05-08'),
('A_W01_OSC_19','W01_OSC','S19','ST03','Absent','2026-05-08'),
('A_W01_OSC_20','W01_OSC','S20','ST03','Present','2026-05-08'),
('A_W01_OSC_21','W01_OSC','S21','ST03','Absent','2026-05-08'),
('A_W01_OSC_22','W01_OSC','S22','ST03','Present','2026-05-08'),
('A_W01_OSC_23','W01_OSC','S23','ST03','Present','2026-05-08'),
('A_W01_OSC_24','W01_OSC','S24','ST03','Present','2026-05-08'),
('A_W01_OSC_25','W01_OSC','S25','ST03','Present','2026-05-08'),

-- ================= WEEK 02 =================

('A_W02_MGT_11','W02_MGT','S11','ST03','Present','2026-05-11'),
('A_W02_MGT_12','W02_MGT','S12','ST03','Present','2026-05-11'),
('A_W02_MGT_13','W02_MGT','S13','ST03','Absent','2026-05-11'),
('A_W02_MGT_14','W02_MGT','S14','ST03','Present','2026-05-11'),
('A_W02_MGT_15','W02_MGT','S15','ST03','Present','2026-05-11'),
('A_W02_MGT_16','W02_MGT','S16','ST03','Present','2026-05-11'),
('A_W02_MGT_17','W02_MGT','S17','ST03','Absent','2026-05-11'),
('A_W02_MGT_18','W02_MGT','S18','ST03','Present','2026-05-11'),
('A_W02_MGT_19','W02_MGT','S19','ST03','Present','2026-05-11'),
('A_W02_MGT_20','W02_MGT','S20','ST03','Present','2026-05-11'),
('A_W02_MGT_21','W02_MGT','S21','ST03','Present','2026-05-11'),
('A_W02_MGT_22','W02_MGT','S22','ST03','Present','2026-05-11'),
('A_W02_MGT_23','W02_MGT','S23','ST03','Present','2026-05-11'),
('A_W02_MGT_24','W02_MGT','S24','ST03','Absent','2026-05-11'),
('A_W02_MGT_25','W02_MGT','S25','ST03','Present','2026-05-11'),

('A_W02_LIN_11','W02_LIN','S11','ST04','Present','2026-05-11'),
('A_W02_LIN_12','W02_LIN','S12','ST04','Present','2026-05-11'),
('A_W02_LIN_13','W02_LIN','S13','ST04','Present','2026-05-11'),
('A_W02_LIN_14','W02_LIN','S14','ST04','Present','2026-05-11'),
('A_W02_LIN_15','W02_LIN','S15','ST04','Present','2026-05-11'),
('A_W02_LIN_16','W02_LIN','S16','ST04','Present','2026-05-11'),
('A_W02_LIN_17','W02_LIN','S17','ST04','Present','2026-05-11'),
('A_W02_LIN_18','W02_LIN','S18','ST04','Present','2026-05-11'),
('A_W02_LIN_19','W02_LIN','S19','ST04','Absent','2026-05-11'),
('A_W02_LIN_20','W02_LIN','S20','ST04','Present','2026-05-11'),
('A_W02_LIN_21','W02_LIN','S21','ST04','Absent','2026-05-11'),
('A_W02_LIN_22','W02_LIN','S22','ST04','Present','2026-05-11'),
('A_W02_LIN_23','W02_LIN','S23','ST04','Present','2026-05-11'),
('A_W02_LIN_24','W02_LIN','S24','ST04','Present','2026-05-11'),
('A_W02_LIN_25','W02_LIN','S25','ST04','Present','2026-05-11'),

('A_W02_DBP_11','W02_DBP','S11','ST05','Present','2026-05-12'),
('A_W02_DBP_12','W02_DBP','S12','ST05','Present','2026-05-12'),
('A_W02_DBP_13','W02_DBP','S13','ST05','Absent','2026-05-12'),
('A_W02_DBP_14','W02_DBP','S14','ST05','Present','2026-05-12'),
('A_W02_DBP_15','W02_DBP','S15','ST05','Present','2026-05-12'),
('A_W02_DBP_16','W02_DBP','S16','ST05','Present','2026-05-12'),
('A_W02_DBP_17','W02_DBP','S17','ST05','Absent','2026-05-12'),
('A_W02_DBP_18','W02_DBP','S18','ST05','Present','2026-05-12'),
('A_W02_DBP_19','W02_DBP','S19','ST05','Absent','2026-05-12'),
('A_W02_DBP_20','W02_DBP','S20','ST05','Present','2026-05-12'),
('A_W02_DBP_21','W02_DBP','S21','ST05','Present','2026-05-12'),
('A_W02_DBP_22','W02_DBP','S22','ST05','Present','2026-05-12'),
('A_W02_DBP_23','W02_DBP','S23','ST05','Present','2026-05-12'),
('A_W02_DBP_24','W02_DBP','S24','ST05','Absent','2026-05-12'),
('A_W02_DBP_25','W02_DBP','S25','ST05','Present','2026-05-12'),

('A_W02_WEBT_11','W02_WEBT','S11','ST06','Present','2026-05-12'),
('A_W02_WEBT_12','W02_WEBT','S12','ST06','Present','2026-05-12'),
('A_W02_WEBT_13','W02_WEBT','S13','ST06','Present','2026-05-12'),
('A_W02_WEBT_14','W02_WEBT','S14','ST06','Present','2026-05-12'),
('A_W02_WEBT_15','W02_WEBT','S15','ST06','Present','2026-05-12'),
('A_W02_WEBT_16','W02_WEBT','S16','ST06','Present','2026-05-12'),
('A_W02_WEBT_17','W02_WEBT','S17','ST06','Absent','2026-05-12'),
('A_W02_WEBT_18','W02_WEBT','S18','ST06','Present','2026-05-12'),
('A_W02_WEBT_19','W02_WEBT','S19','ST06','Absent','2026-05-12'),
('A_W02_WEBT_20','W02_WEBT','S20','ST06','Present','2026-05-12'),
('A_W02_WEBT_21','W02_WEBT','S21','ST06','Absent','2026-05-12'),
('A_W02_WEBT_22','W02_WEBT','S22','ST06','Present','2026-05-12'),
('A_W02_WEBT_23','W02_WEBT','S23','ST06','Present','2026-05-12'),
('A_W02_WEBT_24','W02_WEBT','S24','ST06','Present','2026-05-12'),
('A_W02_WEBT_25','W02_WEBT','S25','ST06','Present','2026-05-12'),

('A_W02_WEBP1_11','W02_WEBP1','S11','ST07','Present','2026-05-12'),
('A_W02_WEBP1_12','W02_WEBP1','S12','ST07','Present','2026-05-12'),
('A_W02_WEBP1_13','W02_WEBP1','S13','ST07','Present','2026-05-12'),
('A_W02_WEBP1_14','W02_WEBP1','S14','ST07','Present','2026-05-12'),
('A_W02_WEBP1_15','W02_WEBP1','S15','ST07','Present','2026-05-12'),
('A_W02_WEBP1_16','W02_WEBP1','S16','ST07','Present','2026-05-12'),
('A_W02_WEBP1_17','W02_WEBP1','S17','ST07','Absent','2026-05-12'),
('A_W02_WEBP1_18','W02_WEBP1','S18','ST07','Present','2026-05-12'),
('A_W02_WEBP1_19','W02_WEBP1','S19','ST07','Absent','2026-05-12'),
('A_W02_WEBP1_20','W02_WEBP1','S20','ST07','Present','2026-05-12'),
('A_W02_WEBP1_21','W02_WEBP1','S21','ST07','Present','2026-05-12'),
('A_W02_WEBP1_22','W02_WEBP1','S22','ST07','Present','2026-05-12'),
('A_W02_WEBP1_23','W02_WEBP1','S23','ST07','Present','2026-05-12'),
('A_W02_WEBP1_24','W02_WEBP1','S24','ST07','Absent','2026-05-12'),
('A_W02_WEBP1_25','W02_WEBP1','S25','ST07','Present','2026-05-12'),

('A_W02_MAT_11','W02_MAT','S11','ST08','Present','2026-05-13'),
('A_W02_MAT_12','W02_MAT','S12','ST08','Present','2026-05-13'),
('A_W02_MAT_13','W02_MAT','S13','ST08','Absent','2026-05-13'),
('A_W02_MAT_14','W02_MAT','S14','ST08','Present','2026-05-13'),
('A_W02_MAT_15','W02_MAT','S15','ST08','Present','2026-05-13'),
('A_W02_MAT_16','W02_MAT','S16','ST08','Present','2026-05-13'),
('A_W02_MAT_17','W02_MAT','S17','ST08','Absent','2026-05-13'),
('A_W02_MAT_18','W02_MAT','S18','ST08','Present','2026-05-13'),
('A_W02_MAT_19','W02_MAT','S19','ST08','Present','2026-05-13'),
('A_W02_MAT_20','W02_MAT','S20','ST08','Present','2026-05-13'),
('A_W02_MAT_21','W02_MAT','S21','ST08','Absent','2026-05-13'),
('A_W02_MAT_22','W02_MAT','S22','ST08','Present','2026-05-13'),
('A_W02_MAT_23','W02_MAT','S23','ST08','Present','2026-05-13'),
('A_W02_MAT_24','W02_MAT','S24','ST08','Absent','2026-05-13'),
('A_W02_MAT_25','W02_MAT','S25','ST08','Present','2026-05-13'),

('A_W02_ENG_11','W02_ENG','S11','ST09','Present','2026-05-14'),
('A_W02_ENG_12','W02_ENG','S12','ST09','Present','2026-05-14'),
('A_W02_ENG_13','W02_ENG','S13','ST09','Present','2026-05-14'),
('A_W02_ENG_14','W02_ENG','S14','ST09','Present','2026-05-14'),
('A_W02_ENG_15','W02_ENG','S15','ST09','Present','2026-05-14'),
('A_W02_ENG_16','W02_ENG','S16','ST09','Present','2026-05-14'),
('A_W02_ENG_17','W02_ENG','S17','ST09','Absent','2026-05-14'),
('A_W02_ENG_18','W02_ENG','S18','ST09','Present','2026-05-14'),
('A_W02_ENG_19','W02_ENG','S19','ST09','Present','2026-05-14'),
('A_W02_ENG_20','W02_ENG','S20','ST09','Present','2026-05-14'),
('A_W02_ENG_21','W02_ENG','S21','ST09','Absent','2026-05-14'),
('A_W02_ENG_22','W02_ENG','S22','ST09','Present','2026-05-14'),
('A_W02_ENG_23','W02_ENG','S23','ST09','Present','2026-05-14'),
('A_W02_ENG_24','W02_ENG','S24','ST09','Absent','2026-05-14'),
('A_W02_ENG_25','W02_ENG','S25','ST09','Present','2026-05-14'),

('A_W02_DBS_11','W02_DBS','S11','ST10','Present','2026-05-14'),
('A_W02_DBS_12','W02_DBS','S12','ST10','Present','2026-05-14'),
('A_W02_DBS_13','W02_DBS','S13','ST10','Present','2026-05-14'),
('A_W02_DBS_14','W02_DBS','S14','ST10','Present','2026-05-14'),
('A_W02_DBS_15','W02_DBS','S15','ST10','Present','2026-05-14'),
('A_W02_DBS_16','W02_DBS','S16','ST10','Present','2026-05-14'),
('A_W02_DBS_17','W02_DBS','S17','ST10','Present','2026-05-14'),
('A_W02_DBS_18','W02_DBS','S18','ST10','Present','2026-05-14'),
('A_W02_DBS_19','W02_DBS','S19','ST10','Present','2026-05-14'),
('A_W02_DBS_20','W02_DBS','S20','ST10','Present','2026-05-14'),
('A_W02_DBS_21','W02_DBS','S21','ST10','Present','2026-05-14'),
('A_W02_DBS_22','W02_DBS','S22','ST10','Medical','2026-05-14'),
('A_W02_DBS_23','W02_DBS','S23','ST10','Present','2026-05-14'),
('A_W02_DBS_24','W02_DBS','S24','ST10','Absent','2026-05-14'),
('A_W02_DBS_25','W02_DBS','S25','ST10','Present','2026-05-14'),

('A_W02_WEBP2_11','W02_WEBP2','S11','ST07','Present','2026-05-14'),
('A_W02_WEBP2_12','W02_WEBP2','S12','ST07','Present','2026-05-14'),
('A_W02_WEBP2_13','W02_WEBP2','S13','ST07','Present','2026-05-14'),
('A_W02_WEBP2_14','W02_WEBP2','S14','ST07','Present','2026-05-14'),
('A_W02_WEBP2_15','W02_WEBP2','S15','ST07','Present','2026-05-14'),
('A_W02_WEBP2_16','W02_WEBP2','S16','ST07','Present','2026-05-14'),
('A_W02_WEBP2_17','W02_WEBP2','S17','ST07','Absent','2026-05-14'),
('A_W02_WEBP2_18','W02_WEBP2','S18','ST07','Present','2026-05-14'),
('A_W02_WEBP2_19','W02_WEBP2','S19','ST07','Present','2026-05-14'),
('A_W02_WEBP2_20','W02_WEBP2','S20','ST07','Present','2026-05-14'),
('A_W02_WEBP2_21','W02_WEBP2','S21','ST07','Absent','2026-05-14'),
('A_W02_WEBP2_22','W02_WEBP2','S22','ST07','Present','2026-05-14'),
('A_W02_WEBP2_23','W02_WEBP2','S23','ST07','Present','2026-05-14'),
('A_W02_WEBP2_24','W02_WEBP2','S24','ST07','Present','2026-05-14'),
('A_W02_WEBP2_25','W02_WEBP2','S25','ST07','Present','2026-05-14'),

('A_W02_OSC_11','W02_OSC','S11','ST03','Medical','2026-05-15'),
('A_W02_OSC_12','W02_OSC','S12','ST03','Present','2026-05-15'),
('A_W02_OSC_13','W02_OSC','S13','ST03','Present','2026-05-15'),
('A_W02_OSC_14','W02_OSC','S14','ST03','Present','2026-05-15'),
('A_W02_OSC_15','W02_OSC','S15','ST03','Present','2026-05-15'),
('A_W02_OSC_16','W02_OSC','S16','ST03','Present','2026-05-15'),
('A_W02_OSC_17','W02_OSC','S17','ST03','Absent','2026-05-15'),
('A_W02_OSC_18','W02_OSC','S18','ST03','Absent','2026-05-15'),
('A_W02_OSC_19','W02_OSC','S19','ST03','Present','2026-05-15'),
('A_W02_OSC_20','W02_OSC','S20','ST03','Present','2026-05-15'),
('A_W02_OSC_21','W02_OSC','S21','ST03','Absent','2026-05-15'),
('A_W02_OSC_22','W02_OSC','S22','ST03','Medical','2026-05-15'),
('A_W02_OSC_23','W02_OSC','S23','ST03','Present','2026-05-15'),
('A_W02_OSC_24','W02_OSC','S24','ST03','Absent','2026-05-15'),
('A_W02_OSC_25','W02_OSC','S25','ST03','Present','2026-05-15'),

-- ================= WEEK 03 =================

('A_W03_MGT_11','W03_MGT','S11','ST03','Present','2026-05-18'),
('A_W03_MGT_12','W03_MGT','S12','ST03','Present','2026-05-18'),
('A_W03_MGT_13','W03_MGT','S13','ST03','Present','2026-05-18'),
('A_W03_MGT_14','W03_MGT','S14','ST03','Present','2026-05-18'),
('A_W03_MGT_15','W03_MGT','S15','ST03','Present','2026-05-18'),
('A_W03_MGT_16','W03_MGT','S16','ST03','Present','2026-05-18'),
('A_W03_MGT_17','W03_MGT','S17','ST03','Absent','2026-05-18'),
('A_W03_MGT_18','W03_MGT','S18','ST03','Present','2026-05-18'),
('A_W03_MGT_19','W03_MGT','S19','ST03','Present','2026-05-18'),
('A_W03_MGT_20','W03_MGT','S20','ST03','Present','2026-05-18'),
('A_W03_MGT_21','W03_MGT','S21','ST03','Absent','2026-05-18'),
('A_W03_MGT_22','W03_MGT','S22','ST03','Present','2026-05-18'),
('A_W03_MGT_23','W03_MGT','S23','ST03','Present','2026-05-18'),
('A_W03_MGT_24','W03_MGT','S24','ST03','Present','2026-05-18'),
('A_W03_MGT_25','W03_MGT','S25','ST03','Present','2026-05-18'),

('A_W03_LIN_11','W03_LIN','S11','ST04','Present','2026-05-18'),
('A_W03_LIN_12','W03_LIN','S12','ST04','Present','2026-05-18'),
('A_W03_LIN_13','W03_LIN','S13','ST04','Present','2026-05-18'),
('A_W03_LIN_14','W03_LIN','S14','ST04','Medical','2026-05-18'),
('A_W03_LIN_15','W03_LIN','S15','ST04','Present','2026-05-18'),
('A_W03_LIN_16','W03_LIN','S16','ST04','Present','2026-05-18'),
('A_W03_LIN_17','W03_LIN','S17','ST04','Present','2026-05-18'),
('A_W03_LIN_18','W03_LIN','S18','ST04','Present','2026-05-18'),
('A_W03_LIN_19','W03_LIN','S19','ST04','Absent','2026-05-18'),
('A_W03_LIN_20','W03_LIN','S20','ST04','Present','2026-05-18'),
('A_W03_LIN_21','W03_LIN','S21','ST04','Present','2026-05-18'),
('A_W03_LIN_22','W03_LIN','S22','ST04','Present','2026-05-18'),
('A_W03_LIN_23','W03_LIN','S23','ST04','Medical','2026-05-18'),
('A_W03_LIN_24','W03_LIN','S24','ST04','Absent','2026-05-18'),
('A_W03_LIN_25','W03_LIN','S25','ST04','Present','2026-05-18'),

('A_W03_DBP_11','W03_DBP','S11','ST05','Present','2026-05-19'),
('A_W03_DBP_12','W03_DBP','S12','ST05','Present','2026-05-19'),
('A_W03_DBP_13','W03_DBP','S13','ST05','Present','2026-05-19'),
('A_W03_DBP_14','W03_DBP','S14','ST05','Present','2026-05-19'),
('A_W03_DBP_15','W03_DBP','S15','ST05','Absent','2026-05-19'),
('A_W03_DBP_16','W03_DBP','S16','ST05','Present','2026-05-19'),
('A_W03_DBP_17','W03_DBP','S17','ST05','Absent','2026-05-19'),
('A_W03_DBP_18','W03_DBP','S18','ST05','Present','2026-05-19'),
('A_W03_DBP_19','W03_DBP','S19','ST05','Present','2026-05-19'),
('A_W03_DBP_20','W03_DBP','S20','ST05','Present','2026-05-19'),
('A_W03_DBP_21','W03_DBP','S21','ST05','Absent','2026-05-19'),
('A_W03_DBP_22','W03_DBP','S22','ST05','Present','2026-05-19'),
('A_W03_DBP_23','W03_DBP','S23','ST05','Present','2026-05-19'),
('A_W03_DBP_24','W03_DBP','S24','ST05','Absent','2026-05-19'),
('A_W03_DBP_25','W03_DBP','S25','ST05','Medical','2026-05-19'),

('A_W03_WEBT_11','W03_WEBT','S11','ST06','Present','2026-05-19'),
('A_W03_WEBT_12','W03_WEBT','S12','ST06','Present','2026-05-19'),
('A_W03_WEBT_13','W03_WEBT','S13','ST06','Absent','2026-05-19'),
('A_W03_WEBT_14','W03_WEBT','S14','ST06','Present','2026-05-19'),
('A_W03_WEBT_15','W03_WEBT','S15','ST06','Present','2026-05-19'),
('A_W03_WEBT_16','W03_WEBT','S16','ST06','Present','2026-05-19'),
('A_W03_WEBT_17','W03_WEBT','S17','ST06','Absent','2026-05-19'),
('A_W03_WEBT_18','W03_WEBT','S18','ST06','Present','2026-05-19'),
('A_W03_WEBT_19','W03_WEBT','S19','ST06','Absent','2026-05-19'),
('A_W03_WEBT_20','W03_WEBT','S20','ST06','Present','2026-05-19'),
('A_W03_WEBT_21','W03_WEBT','S21','ST06','Absent','2026-05-19'),
('A_W03_WEBT_22','W03_WEBT','S22','ST06','Present','2026-05-19'),
('A_W03_WEBT_23','W03_WEBT','S23','ST06','Present','2026-05-19'),
('A_W03_WEBT_24','W03_WEBT','S24','ST06','Absent','2026-05-19'),
('A_W03_WEBT_25','W03_WEBT','S25','ST06','Present','2026-05-19'),

('A_W03_WEBP1_11','W03_WEBP1','S11','ST07','Present','2026-05-19'),
('A_W03_WEBP1_12','W03_WEBP1','S12','ST07','Present','2026-05-19'),
('A_W03_WEBP1_13','W03_WEBP1','S13','ST07','Present','2026-05-19'),
('A_W03_WEBP1_14','W03_WEBP1','S14','ST07','Present','2026-05-19'),
('A_W03_WEBP1_15','W03_WEBP1','S15','ST07','Present','2026-05-19'),
('A_W03_WEBP1_16','W03_WEBP1','S16','ST07','Present','2026-05-19'),
('A_W03_WEBP1_17','W03_WEBP1','S17','ST07','Present','2026-05-19'),
('A_W03_WEBP1_18','W03_WEBP1','S18','ST07','Present','2026-05-19'),
('A_W03_WEBP1_19','W03_WEBP1','S19','ST07','Absent','2026-05-19'),
('A_W03_WEBP1_20','W03_WEBP1','S20','ST07','Present','2026-05-19'),
('A_W03_WEBP1_21','W03_WEBP1','S21','ST07','Present','2026-05-19'),
('A_W03_WEBP1_22','W03_WEBP1','S22','ST07','Present','2026-05-19'),
('A_W03_WEBP1_23','W03_WEBP1','S23','ST07','Present','2026-05-19'),
('A_W03_WEBP1_24','W03_WEBP1','S24','ST07','Absent','2026-05-19'),
('A_W03_WEBP1_25','W03_WEBP1','S25','ST07','Present','2026-05-19'),

('A_W03_MAT_11','W03_MAT','S11','ST08','Present','2026-05-20'),
('A_W03_MAT_12','W03_MAT','S12','ST08','Present','2026-05-20'),
('A_W03_MAT_13','W03_MAT','S13','ST08','Absent','2026-05-20'),
('A_W03_MAT_14','W03_MAT','S14','ST08','Present','2026-05-20'),
('A_W03_MAT_15','W03_MAT','S15','ST08','Present','2026-05-20'),
('A_W03_MAT_16','W03_MAT','S16','ST08','Present','2026-05-20'),
('A_W03_MAT_17','W03_MAT','S17','ST08','Present','2026-05-20'),
('A_W03_MAT_18','W03_MAT','S18','ST08','Present','2026-05-20'),
('A_W03_MAT_19','W03_MAT','S19','ST08','Absent','2026-05-20'),
('A_W03_MAT_20','W03_MAT','S20','ST08','Medical','2026-05-20'),
('A_W03_MAT_21','W03_MAT','S21','ST08','Absent','2026-05-20'),
('A_W03_MAT_22','W03_MAT','S22','ST08','Present','2026-05-20'),
('A_W03_MAT_23','W03_MAT','S23','ST08','Present','2026-05-20'),
('A_W03_MAT_24','W03_MAT','S24','ST08','Absent','2026-05-20'),
('A_W03_MAT_25','W03_MAT','S25','ST08','Present','2026-05-20'),

('A_W03_ENG_11','W03_ENG','S11','ST09','Present','2026-05-21'),
('A_W03_ENG_12','W03_ENG','S12','ST09','Present','2026-05-21'),
('A_W03_ENG_13','W03_ENG','S13','ST09','Present','2026-05-21'),
('A_W03_ENG_14','W03_ENG','S14','ST09','Present','2026-05-21'),
('A_W03_ENG_15','W03_ENG','S15','ST09','Present','2026-05-21'),
('A_W03_ENG_16','W03_ENG','S16','ST09','Present','2026-05-21'),
('A_W03_ENG_17','W03_ENG','S17','ST09','Absent','2026-05-21'),
('A_W03_ENG_18','W03_ENG','S18','ST09','Present','2026-05-21'),
('A_W03_ENG_19','W03_ENG','S19','ST09','Present','2026-05-21'),
('A_W03_ENG_20','W03_ENG','S20','ST09','Present','2026-05-21'),
('A_W03_ENG_21','W03_ENG','S21','ST09','Present','2026-05-21'),
('A_W03_ENG_22','W03_ENG','S22','ST09','Present','2026-05-21'),
('A_W03_ENG_23','W03_ENG','S23','ST09','Present','2026-05-21'),
('A_W03_ENG_24','W03_ENG','S24','ST09','Present','2026-05-21'),
('A_W03_ENG_25','W03_ENG','S25','ST09','Present','2026-05-21'),

('A_W03_DBS_11','W03_DBS','S11','ST10','Medical','2026-05-21'),
('A_W03_DBS_12','W03_DBS','S12','ST10','Present','2026-05-21'),
('A_W03_DBS_13','W03_DBS','S13','ST10','Present','2026-05-21'),
('A_W03_DBS_14','W03_DBS','S14','ST10','Present','2026-05-21'),
('A_W03_DBS_15','W03_DBS','S15','ST10','Present','2026-05-21'),
('A_W03_DBS_16','W03_DBS','S16','ST10','Present','2026-05-21'),
('A_W03_DBS_17','W03_DBS','S17','ST10','Present','2026-05-21'),
('A_W03_DBS_18','W03_DBS','S18','ST10','Present','2026-05-21'),
('A_W03_DBS_19','W03_DBS','S19','ST10','Absent','2026-05-21'),
('A_W03_DBS_20','W03_DBS','S20','ST10','Present','2026-05-21'),
('A_W03_DBS_21','W03_DBS','S21','ST10','Present','2026-05-21'),
('A_W03_DBS_22','W03_DBS','S22','ST10','Present','2026-05-21'),
('A_W03_DBS_23','W03_DBS','S23','ST10','Present','2026-05-21'),
('A_W03_DBS_24','W03_DBS','S24','ST10','Present','2026-05-21'),
('A_W03_DBS_25','W03_DBS','S25','ST10','Present','2026-05-21'),

('A_W03_WEBP2_11','W03_WEBP2','S11','ST07','Present','2026-05-21'),
('A_W03_WEBP2_12','W03_WEBP2','S12','ST07','Present','2026-05-21'),
('A_W03_WEBP2_13','W03_WEBP2','S13','ST07','Present','2026-05-21'),
('A_W03_WEBP2_14','W03_WEBP2','S14','ST07','Present','2026-05-21'),
('A_W03_WEBP2_15','W03_WEBP2','S15','ST07','Present','2026-05-21'),
('A_W03_WEBP2_16','W03_WEBP2','S16','ST07','Present','2026-05-21'),
('A_W03_WEBP2_17','W03_WEBP2','S17','ST07','Absent','2026-05-21'),
('A_W03_WEBP2_18','W03_WEBP2','S18','ST07','Present','2026-05-21'),
('A_W03_WEBP2_19','W03_WEBP2','S19','ST07','Absent','2026-05-21'),
('A_W03_WEBP2_20','W03_WEBP2','S20','ST07','Present','2026-05-21'),
('A_W03_WEBP2_21','W03_WEBP2','S21','ST07','Absent','2026-05-21'),
('A_W03_WEBP2_22','W03_WEBP2','S22','ST07','Present','2026-05-21'),
('A_W03_WEBP2_23','W03_WEBP2','S23','ST07','Present','2026-05-21'),
('A_W03_WEBP2_24','W03_WEBP2','S24','ST07','Absent','2026-05-21'),
('A_W03_WEBP2_25','W03_WEBP2','S25','ST07','Present','2026-05-21'),

('A_W03_OSC_11','W03_OSC','S11','ST03','Present','2026-05-22'),
('A_W03_OSC_12','W03_OSC','S12','ST03','Present','2026-05-22'),
('A_W03_OSC_13','W03_OSC','S13','ST03','Present','2026-05-22'),
('A_W03_OSC_14','W03_OSC','S14','ST03','Present','2026-05-22'),
('A_W03_OSC_15','W03_OSC','S15','ST03','Present','2026-05-22'),
('A_W03_OSC_16','W03_OSC','S16','ST03','Present','2026-05-22'),
('A_W03_OSC_17','W03_OSC','S17','ST03','Absent','2026-05-22'),
('A_W03_OSC_18','W03_OSC','S18','ST03','Present','2026-05-22'),
('A_W03_OSC_19','W03_OSC','S19','ST03','Present','2026-05-22'),
('A_W03_OSC_20','W03_OSC','S20','ST03','Present','2026-05-22'),
('A_W03_OSC_21','W03_OSC','S21','ST03','Present','2026-05-22'),
('A_W03_OSC_22','W03_OSC','S22','ST03','Present','2026-05-22'),
('A_W03_OSC_23','W03_OSC','S23','ST03','Present','2026-05-22'),
('A_W03_OSC_24','W03_OSC','S24','ST03','Absent','2026-05-22'),
('A_W03_OSC_25','W03_OSC','S25','ST03','Present','2026-05-22'),

-- ================= WEEK 04 =================

('A_W04_MGT_11','W04_MGT','S11','ST03','Present','2026-05-25'),
('A_W04_MGT_12','W04_MGT','S12','ST03','Present','2026-05-25'),
('A_W04_MGT_13','W04_MGT','S13','ST03','Present','2026-05-25'),
('A_W04_MGT_14','W04_MGT','S14','ST03','Present','2026-05-25'),
('A_W04_MGT_15','W04_MGT','S15','ST03','Present','2026-05-25'),
('A_W04_MGT_16','W04_MGT','S16','ST03','Present','2026-05-25'),
('A_W04_MGT_17','W04_MGT','S17','ST03','Absent','2026-05-25'),
('A_W04_MGT_18','W04_MGT','S18','ST03','Present','2026-05-25'),
('A_W04_MGT_19','W04_MGT','S19','ST03','Absent','2026-05-25'),
('A_W04_MGT_20','W04_MGT','S20','ST03','Present','2026-05-25'),
('A_W04_MGT_21','W04_MGT','S21','ST03','Absent','2026-05-25'),
('A_W04_MGT_22','W04_MGT','S22','ST03','Present','2026-05-25'),
('A_W04_MGT_23','W04_MGT','S23','ST03','Present','2026-05-25'),
('A_W04_MGT_24','W04_MGT','S24','ST03','Absent','2026-05-25'),
('A_W04_MGT_25','W04_MGT','S25','ST03','Present','2026-05-25'),

('A_W04_LIN_11','W04_LIN','S11','ST04','Present','2026-05-25'),
('A_W04_LIN_12','W04_LIN','S12','ST04','Medical','2026-05-25'),
('A_W04_LIN_13','W04_LIN','S13','ST04','Absent','2026-05-25'),
('A_W04_LIN_14','W04_LIN','S14','ST04','Present','2026-05-25'),
('A_W04_LIN_15','W04_LIN','S15','ST04','Present','2026-05-25'),
('A_W04_LIN_16','W04_LIN','S16','ST04','Present','2026-05-25'),
('A_W04_LIN_17','W04_LIN','S17','ST04','Present','2026-05-25'),
('A_W04_LIN_18','W04_LIN','S18','ST04','Present','2026-05-25'),
('A_W04_LIN_19','W04_LIN','S19','ST04','Absent','2026-05-25'),
('A_W04_LIN_20','W04_LIN','S20','ST04','Present','2026-05-25'),
('A_W04_LIN_21','W04_LIN','S21','ST04','Present','2026-05-25'),
('A_W04_LIN_22','W04_LIN','S22','ST04','Present','2026-05-25'),
('A_W04_LIN_23','W04_LIN','S23','ST04','Present','2026-05-25'),
('A_W04_LIN_24','W04_LIN','S24','ST04','Absent','2026-05-25'),
('A_W04_LIN_25','W04_LIN','S25','ST04','Present','2026-05-25'),

('A_W04_DBP_11','W04_DBP','S11','ST05','Present','2026-05-26'),
('A_W04_DBP_12','W04_DBP','S12','ST05','Present','2026-05-26'),
('A_W04_DBP_13','W04_DBP','S13','ST05','Present','2026-05-26'),
('A_W04_DBP_14','W04_DBP','S14','ST05','Present','2026-05-26'),
('A_W04_DBP_15','W04_DBP','S15','ST05','Present','2026-05-26'),
('A_W04_DBP_16','W04_DBP','S16','ST05','Present','2026-05-26'),
('A_W04_DBP_17','W04_DBP','S17','ST05','Present','2026-05-26'),
('A_W04_DBP_18','W04_DBP','S18','ST05','Present','2026-05-26'),
('A_W04_DBP_19','W04_DBP','S19','ST05','Present','2026-05-26'),
('A_W04_DBP_20','W04_DBP','S20','ST05','Present','2026-05-26'),
('A_W04_DBP_21','W04_DBP','S21','ST05','Present','2026-05-26'),
('A_W04_DBP_22','W04_DBP','S22','ST05','Present','2026-05-26'),
('A_W04_DBP_23','W04_DBP','S23','ST05','Present','2026-05-26'),
('A_W04_DBP_24','W04_DBP','S24','ST05','Present','2026-05-26'),
('A_W04_DBP_25','W04_DBP','S25','ST05','Present','2026-05-26'),

('A_W04_WEBT_11','W04_WEBT','S11','ST06','Present','2026-05-26'),
('A_W04_WEBT_12','W04_WEBT','S12','ST06','Present','2026-05-26'),
('A_W04_WEBT_13','W04_WEBT','S13','ST06','Absent','2026-05-26'),
('A_W04_WEBT_14','W04_WEBT','S14','ST06','Present','2026-05-26'),
('A_W04_WEBT_15','W04_WEBT','S15','ST06','Present','2026-05-26'),
('A_W04_WEBT_16','W04_WEBT','S16','ST06','Present','2026-05-26'),
('A_W04_WEBT_17','W04_WEBT','S17','ST06','Present','2026-05-26'),
('A_W04_WEBT_18','W04_WEBT','S18','ST06','Present','2026-05-26'),
('A_W04_WEBT_19','W04_WEBT','S19','ST06','Present','2026-05-26'),
('A_W04_WEBT_20','W04_WEBT','S20','ST06','Present','2026-05-26'),
('A_W04_WEBT_21','W04_WEBT','S21','ST06','Present','2026-05-26'),
('A_W04_WEBT_22','W04_WEBT','S22','ST06','Present','2026-05-26'),
('A_W04_WEBT_23','W04_WEBT','S23','ST06','Present','2026-05-26'),
('A_W04_WEBT_24','W04_WEBT','S24','ST06','Absent','2026-05-26'),
('A_W04_WEBT_25','W04_WEBT','S25','ST06','Present','2026-05-26'),

('A_W04_WEBP1_11','W04_WEBP1','S11','ST07','Present','2026-05-26'),
('A_W04_WEBP1_12','W04_WEBP1','S12','ST07','Absent','2026-05-26'),
('A_W04_WEBP1_13','W04_WEBP1','S13','ST07','Present','2026-05-26'),
('A_W04_WEBP1_14','W04_WEBP1','S14','ST07','Present','2026-05-26'),
('A_W04_WEBP1_15','W04_WEBP1','S15','ST07','Absent','2026-05-26'),
('A_W04_WEBP1_16','W04_WEBP1','S16','ST07','Present','2026-05-26'),
('A_W04_WEBP1_17','W04_WEBP1','S17','ST07','Absent','2026-05-26'),
('A_W04_WEBP1_18','W04_WEBP1','S18','ST07','Present','2026-05-26'),
('A_W04_WEBP1_19','W04_WEBP1','S19','ST07','Present','2026-05-26'),
('A_W04_WEBP1_20','W04_WEBP1','S20','ST07','Present','2026-05-26'),
('A_W04_WEBP1_21','W04_WEBP1','S21','ST07','Absent','2026-05-26'),
('A_W04_WEBP1_22','W04_WEBP1','S22','ST07','Present','2026-05-26'),
('A_W04_WEBP1_23','W04_WEBP1','S23','ST07','Present','2026-05-26'),
('A_W04_WEBP1_24','W04_WEBP1','S24','ST07','Present','2026-05-26'),
('A_W04_WEBP1_25','W04_WEBP1','S25','ST07','Present','2026-05-26'),

('A_W04_MAT_11','W04_MAT','S11','ST08','Present','2026-05-27'),
('A_W04_MAT_12','W04_MAT','S12','ST08','Present','2026-05-27'),
('A_W04_MAT_13','W04_MAT','S13','ST08','Absent','2026-05-27'),
('A_W04_MAT_14','W04_MAT','S14','ST08','Present','2026-05-27'),
('A_W04_MAT_15','W04_MAT','S15','ST08','Present','2026-05-27'),
('A_W04_MAT_16','W04_MAT','S16','ST08','Present','2026-05-27'),
('A_W04_MAT_17','W04_MAT','S17','ST08','Present','2026-05-27'),
('A_W04_MAT_18','W04_MAT','S18','ST08','Present','2026-05-27'),
('A_W04_MAT_19','W04_MAT','S19','ST08','Present','2026-05-27'),
('A_W04_MAT_20','W04_MAT','S20','ST08','Present','2026-05-27'),
('A_W04_MAT_21','W04_MAT','S21','ST08','Absent','2026-05-27'),
('A_W04_MAT_22','W04_MAT','S22','ST08','Present','2026-05-27'),
('A_W04_MAT_23','W04_MAT','S23','ST08','Present','2026-05-27'),
('A_W04_MAT_24','W04_MAT','S24','ST08','Present','2026-05-27'),
('A_W04_MAT_25','W04_MAT','S25','ST08','Present','2026-05-27'),

('A_W04_ENG_11','W04_ENG','S11','ST09','Present','2026-05-28'),
('A_W04_ENG_12','W04_ENG','S12','ST09','Present','2026-05-28'),
('A_W04_ENG_13','W04_ENG','S13','ST09','Present','2026-05-28'),
('A_W04_ENG_14','W04_ENG','S14','ST09','Present','2026-05-28'),
('A_W04_ENG_15','W04_ENG','S15','ST09','Medical','2026-05-28'),
('A_W04_ENG_16','W04_ENG','S16','ST09','Present','2026-05-28'),
('A_W04_ENG_17','W04_ENG','S17','ST09','Absent','2026-05-28'),
('A_W04_ENG_18','W04_ENG','S18','ST09','Present','2026-05-28'),
('A_W04_ENG_19','W04_ENG','S19','ST09','Absent','2026-05-28'),
('A_W04_ENG_20','W04_ENG','S20','ST09','Present','2026-05-28'),
('A_W04_ENG_21','W04_ENG','S21','ST09','Absent','2026-05-28'),
('A_W04_ENG_22','W04_ENG','S22','ST09','Present','2026-05-28'),
('A_W04_ENG_23','W04_ENG','S23','ST09','Present','2026-05-28'),
('A_W04_ENG_24','W04_ENG','S24','ST09','Present','2026-05-28'),
('A_W04_ENG_25','W04_ENG','S25','ST09','Present','2026-05-28'),

('A_W04_DBS_11','W04_DBS','S11','ST10','Present','2026-05-28'),
('A_W04_DBS_12','W04_DBS','S12','ST10','Present','2026-05-28'),
('A_W04_DBS_13','W04_DBS','S13','ST10','Absent','2026-05-28'),
('A_W04_DBS_14','W04_DBS','S14','ST10','Present','2026-05-28'),
('A_W04_DBS_15','W04_DBS','S15','ST10','Present','2026-05-28'),
('A_W04_DBS_16','W04_DBS','S16','ST10','Present','2026-05-28'),
('A_W04_DBS_17','W04_DBS','S17','ST10','Present','2026-05-28'),
('A_W04_DBS_18','W04_DBS','S18','ST10','Present','2026-05-28'),
('A_W04_DBS_19','W04_DBS','S19','ST10','Present','2026-05-28'),
('A_W04_DBS_20','W04_DBS','S20','ST10','Present','2026-05-28'),
('A_W04_DBS_21','W04_DBS','S21','ST10','Absent','2026-05-28'),
('A_W04_DBS_22','W04_DBS','S22','ST10','Present','2026-05-28'),
('A_W04_DBS_23','W04_DBS','S23','ST10','Present','2026-05-28'),
('A_W04_DBS_24','W04_DBS','S24','ST10','Absent','2026-05-28'),
('A_W04_DBS_25','W04_DBS','S25','ST10','Present','2026-05-28'),

('A_W04_WEBP2_11','W04_WEBP2','S11','ST07','Present','2026-05-28'),
('A_W04_WEBP2_12','W04_WEBP2','S12','ST07','Present','2026-05-28'),
('A_W04_WEBP2_13','W04_WEBP2','S13','ST07','Present','2026-05-28'),
('A_W04_WEBP2_14','W04_WEBP2','S14','ST07','Present','2026-05-28'),
('A_W04_WEBP2_15','W04_WEBP2','S15','ST07','Present','2026-05-28'),
('A_W04_WEBP2_16','W04_WEBP2','S16','ST07','Present','2026-05-28'),
('A_W04_WEBP2_17','W04_WEBP2','S17','ST07','Absent','2026-05-28'),
('A_W04_WEBP2_18','W04_WEBP2','S18','ST07','Present','2026-05-28'),
('A_W04_WEBP2_19','W04_WEBP2','S19','ST07','Absent','2026-05-28'),
('A_W04_WEBP2_20','W04_WEBP2','S20','ST07','Present','2026-05-28'),
('A_W04_WEBP2_21','W04_WEBP2','S21','ST07','Absent','2026-05-28'),
('A_W04_WEBP2_22','W04_WEBP2','S22','ST07','Present','2026-05-28'),
('A_W04_WEBP2_23','W04_WEBP2','S23','ST07','Present','2026-05-28'),
('A_W04_WEBP2_24','W04_WEBP2','S24','ST07','Absent','2026-05-28'),
('A_W04_WEBP2_25','W04_WEBP2','S25','ST07','Present','2026-05-28'),

('A_W04_OSC_11','W04_OSC','S11','ST03','Present','2026-05-29'),
('A_W04_OSC_12','W04_OSC','S12','ST03','Present','2026-05-29'),
('A_W04_OSC_13','W04_OSC','S13','ST03','Absent','2026-05-29'),
('A_W04_OSC_14','W04_OSC','S14','ST03','Present','2026-05-29'),
('A_W04_OSC_15','W04_OSC','S15','ST03','Present','2026-05-29'),
('A_W04_OSC_16','W04_OSC','S16','ST03','Present','2026-05-29'),
('A_W04_OSC_17','W04_OSC','S17','ST03','Absent','2026-05-29'),
('A_W04_OSC_18','W04_OSC','S18','ST03','Medical','2026-05-29'),
('A_W04_OSC_19','W04_OSC','S19','ST03','Absent','2026-05-29'),
('A_W04_OSC_20','W04_OSC','S20','ST03','Present','2026-05-29'),
('A_W04_OSC_21','W04_OSC','S21','ST03','Absent','2026-05-29'),
('A_W04_OSC_22','W04_OSC','S22','ST03','Present','2026-05-29'),
('A_W04_OSC_23','W04_OSC','S23','ST03','Present','2026-05-29'),
('A_W04_OSC_24','W04_OSC','S24','ST03','Absent','2026-05-29'),
('A_W04_OSC_25','W04_OSC','S25','ST03','Present','2026-05-29'),

-- ================= WEEK 05 =================

('A_W05_MGT_11','W05_MGT','S11','ST03','Present','2026-06-01'),
('A_W05_MGT_12','W05_MGT','S12','ST03','Present','2026-06-01'),
('A_W05_MGT_13','W05_MGT','S13','ST03','Present','2026-06-01'),
('A_W05_MGT_14','W05_MGT','S14','ST03','Present','2026-06-01'),
('A_W05_MGT_15','W05_MGT','S15','ST03','Present','2026-06-01'),
('A_W05_MGT_16','W05_MGT','S16','ST03','Present','2026-06-01'),
('A_W05_MGT_17','W05_MGT','S17','ST03','Absent','2026-06-01'),
('A_W05_MGT_18','W05_MGT','S18','ST03','Present','2026-06-01'),
('A_W05_MGT_19','W05_MGT','S19','ST03','Absent','2026-06-01'),
('A_W05_MGT_20','W05_MGT','S20','ST03','Present','2026-06-01'),
('A_W05_MGT_21','W05_MGT','S21','ST03','Absent','2026-06-01'),
('A_W05_MGT_22','W05_MGT','S22','ST03','Present','2026-06-01'),
('A_W05_MGT_23','W05_MGT','S23','ST03','Present','2026-06-01'),
('A_W05_MGT_24','W05_MGT','S24','ST03','Present','2026-06-01'),
('A_W05_MGT_25','W05_MGT','S25','ST03','Present','2026-06-01'),

('A_W05_LIN_11','W05_LIN','S11','ST04','Present','2026-06-01'),
('A_W05_LIN_12','W05_LIN','S12','ST04','Present','2026-06-01'),
('A_W05_LIN_13','W05_LIN','S13','ST04','Absent','2026-06-01'),
('A_W05_LIN_14','W05_LIN','S14','ST04','Present','2026-06-01'),
('A_W05_LIN_15','W05_LIN','S15','ST04','Present','2026-06-01'),
('A_W05_LIN_16','W05_LIN','S16','ST04','Present','2026-06-01'),
('A_W05_LIN_17','W05_LIN','S17','ST04','Absent','2026-06-01'),
('A_W05_LIN_18','W05_LIN','S18','ST04','Present','2026-06-01'),
('A_W05_LIN_19','W05_LIN','S19','ST04','Absent','2026-06-01'),
('A_W05_LIN_20','W05_LIN','S20','ST04','Present','2026-06-01'),
('A_W05_LIN_21','W05_LIN','S21','ST04','Absent','2026-06-01'),
('A_W05_LIN_22','W05_LIN','S22','ST04','Present','2026-06-01'),
('A_W05_LIN_23','W05_LIN','S23','ST04','Present','2026-06-01'),
('A_W05_LIN_24','W05_LIN','S24','ST04','Present','2026-06-01'),
('A_W05_LIN_25','W05_LIN','S25','ST04','Present','2026-06-01'),

('A_W05_DBP_11','W05_DBP','S11','ST05','Present','2026-06-02'),
('A_W05_DBP_12','W05_DBP','S12','ST05','Present','2026-06-02'),
('A_W05_DBP_13','W05_DBP','S13','ST05','Absent','2026-06-02'),
('A_W05_DBP_14','W05_DBP','S14','ST05','Present','2026-06-02'),
('A_W05_DBP_15','W05_DBP','S15','ST05','Present','2026-06-02'),
('A_W05_DBP_16','W05_DBP','S16','ST05','Present','2026-06-02'),
('A_W05_DBP_17','W05_DBP','S17','ST05','Present','2026-06-02'),
('A_W05_DBP_18','W05_DBP','S18','ST05','Present','2026-06-02'),
('A_W05_DBP_19','W05_DBP','S19','ST05','Present','2026-06-02'),
('A_W05_DBP_20','W05_DBP','S20','ST05','Present','2026-06-02'),
('A_W05_DBP_21','W05_DBP','S21','ST05','Absent','2026-06-02'),
('A_W05_DBP_22','W05_DBP','S22','ST05','Present','2026-06-02'),
('A_W05_DBP_23','W05_DBP','S23','ST05','Present','2026-06-02'),
('A_W05_DBP_24','W05_DBP','S24','ST05','Absent','2026-06-02'),
('A_W05_DBP_25','W05_DBP','S25','ST05','Present','2026-06-02'),

('A_W05_WEBT_11','W05_WEBT','S11','ST06','Present','2026-06-02'),
('A_W05_WEBT_12','W05_WEBT','S12','ST06','Present','2026-06-02'),
('A_W05_WEBT_13','W05_WEBT','S13','ST06','Absent','2026-06-02'),
('A_W05_WEBT_14','W05_WEBT','S14','ST06','Present','2026-06-02'),
('A_W05_WEBT_15','W05_WEBT','S15','ST06','Present','2026-06-02'),
('A_W05_WEBT_16','W05_WEBT','S16','ST06','Present','2026-06-02'),
('A_W05_WEBT_17','W05_WEBT','S17','ST06','Absent','2026-06-02'),
('A_W05_WEBT_18','W05_WEBT','S18','ST06','Present','2026-06-02'),
('A_W05_WEBT_19','W05_WEBT','S19','ST06','Absent','2026-06-02'),
('A_W05_WEBT_20','W05_WEBT','S20','ST06','Present','2026-06-02'),
('A_W05_WEBT_21','W05_WEBT','S21','ST06','Present','2026-06-02'),
('A_W05_WEBT_22','W05_WEBT','S22','ST06','Present','2026-06-02'),
('A_W05_WEBT_23','W05_WEBT','S23','ST06','Present','2026-06-02'),
('A_W05_WEBT_24','W05_WEBT','S24','ST06','Present','2026-06-02'),
('A_W05_WEBT_25','W05_WEBT','S25','ST06','Present','2026-06-02'),

('A_W05_WEBP1_11','W05_WEBP1','S11','ST07','Present','2026-06-02'),
('A_W05_WEBP1_12','W05_WEBP1','S12','ST07','Present','2026-06-02'),
('A_W05_WEBP1_13','W05_WEBP1','S13','ST07','Absent','2026-06-02'),
('A_W05_WEBP1_14','W05_WEBP1','S14','ST07','Present','2026-06-02'),
('A_W05_WEBP1_15','W05_WEBP1','S15','ST07','Present','2026-06-02'),
('A_W05_WEBP1_16','W05_WEBP1','S16','ST07','Present','2026-06-02'),
('A_W05_WEBP1_17','W05_WEBP1','S17','ST07','Absent','2026-06-02'),
('A_W05_WEBP1_18','W05_WEBP1','S18','ST07','Present','2026-06-02'),
('A_W05_WEBP1_19','W05_WEBP1','S19','ST07','Absent','2026-06-02'),
('A_W05_WEBP1_20','W05_WEBP1','S20','ST07','Present','2026-06-02'),
('A_W05_WEBP1_21','W05_WEBP1','S21','ST07','Absent','2026-06-02'),
('A_W05_WEBP1_22','W05_WEBP1','S22','ST07','Present','2026-06-02'),
('A_W05_WEBP1_23','W05_WEBP1','S23','ST07','Present','2026-06-02'),
('A_W05_WEBP1_24','W05_WEBP1','S24','ST07','Present','2026-06-02'),
('A_W05_WEBP1_25','W05_WEBP1','S25','ST07','Present','2026-06-02'),

('A_W05_MAT_11','W05_MAT','S11','ST08','Present','2026-06-03'),
('A_W05_MAT_12','W05_MAT','S12','ST08','Present','2026-06-03'),
('A_W05_MAT_13','W05_MAT','S13','ST08','Present','2026-06-03'),
('A_W05_MAT_14','W05_MAT','S14','ST08','Present','2026-06-03'),
('A_W05_MAT_15','W05_MAT','S15','ST08','Present','2026-06-03'),
('A_W05_MAT_16','W05_MAT','S16','ST08','Present','2026-06-03'),
('A_W05_MAT_17','W05_MAT','S17','ST08','Present','2026-06-03'),
('A_W05_MAT_18','W05_MAT','S18','ST08','Present','2026-06-03'),
('A_W05_MAT_19','W05_MAT','S19','ST08','Absent','2026-06-03'),
('A_W05_MAT_20','W05_MAT','S20','ST08','Present','2026-06-03'),
('A_W05_MAT_21','W05_MAT','S21','ST08','Present','2026-06-03'),
('A_W05_MAT_22','W05_MAT','S22','ST08','Present','2026-06-03'),
('A_W05_MAT_23','W05_MAT','S23','ST08','Present','2026-06-03'),
('A_W05_MAT_24','W05_MAT','S24','ST08','Absent','2026-06-03'),
('A_W05_MAT_25','W05_MAT','S25','ST08','Present','2026-06-03'),

('A_W05_ENG_11','W05_ENG','S11','ST09','Present','2026-06-04'),
('A_W05_ENG_12','W05_ENG','S12','ST09','Present','2026-06-04'),
('A_W05_ENG_13','W05_ENG','S13','ST09','Absent','2026-06-04'),
('A_W05_ENG_14','W05_ENG','S14','ST09','Present','2026-06-04'),
('A_W05_ENG_15','W05_ENG','S15','ST09','Present','2026-06-04'),
('A_W05_ENG_16','W05_ENG','S16','ST09','Present','2026-06-04'),
('A_W05_ENG_17','W05_ENG','S17','ST09','Present','2026-06-04'),
('A_W05_ENG_18','W05_ENG','S18','ST09','Present','2026-06-04'),
('A_W05_ENG_19','W05_ENG','S19','ST09','Absent','2026-06-04'),
('A_W05_ENG_20','W05_ENG','S20','ST09','Present','2026-06-04'),
('A_W05_ENG_21','W05_ENG','S21','ST09','Absent','2026-06-04'),
('A_W05_ENG_22','W05_ENG','S22','ST09','Present','2026-06-04'),
('A_W05_ENG_23','W05_ENG','S23','ST09','Present','2026-06-04'),
('A_W05_ENG_24','W05_ENG','S24','ST09','Absent','2026-06-04'),
('A_W05_ENG_25','W05_ENG','S25','ST09','Present','2026-06-04'),

('A_W05_DBS_11','W05_DBS','S11','ST10','Present','2026-06-04'),
('A_W05_DBS_12','W05_DBS','S12','ST10','Present','2026-06-04'),
('A_W05_DBS_13','W05_DBS','S13','ST10','Absent','2026-06-04'),
('A_W05_DBS_14','W05_DBS','S14','ST10','Present','2026-06-04'),
('A_W05_DBS_15','W05_DBS','S15','ST10','Present','2026-06-04'),
('A_W05_DBS_16','W05_DBS','S16','ST10','Present','2026-06-04'),
('A_W05_DBS_17','W05_DBS','S17','ST10','Absent','2026-06-04'),
('A_W05_DBS_18','W05_DBS','S18','ST10','Absent','2026-06-04'),
('A_W05_DBS_19','W05_DBS','S19','ST10','Absent','2026-06-04'),
('A_W05_DBS_20','W05_DBS','S20','ST10','Present','2026-06-04'),
('A_W05_DBS_21','W05_DBS','S21','ST10','Present','2026-06-04'),
('A_W05_DBS_22','W05_DBS','S22','ST10','Present','2026-06-04'),
('A_W05_DBS_23','W05_DBS','S23','ST10','Present','2026-06-04'),
('A_W05_DBS_24','W05_DBS','S24','ST10','Present','2026-06-04'),
('A_W05_DBS_25','W05_DBS','S25','ST10','Present','2026-06-04'),

('A_W05_WEBP2_11','W05_WEBP2','S11','ST07','Present','2026-06-04'),
('A_W05_WEBP2_12','W05_WEBP2','S12','ST07','Present','2026-06-04'),
('A_W05_WEBP2_13','W05_WEBP2','S13','ST07','Absent','2026-06-04'),
('A_W05_WEBP2_14','W05_WEBP2','S14','ST07','Present','2026-06-04'),
('A_W05_WEBP2_15','W05_WEBP2','S15','ST07','Present','2026-06-04'),
('A_W05_WEBP2_16','W05_WEBP2','S16','ST07','Present','2026-06-04'),
('A_W05_WEBP2_17','W05_WEBP2','S17','ST07','Present','2026-06-04'),
('A_W05_WEBP2_18','W05_WEBP2','S18','ST07','Present','2026-06-04'),
('A_W05_WEBP2_19','W05_WEBP2','S19','ST07','Present','2026-06-04'),
('A_W05_WEBP2_20','W05_WEBP2','S20','ST07','Present','2026-06-04'),
('A_W05_WEBP2_21','W05_WEBP2','S21','ST07','Absent','2026-06-04'),
('A_W05_WEBP2_22','W05_WEBP2','S22','ST07','Present','2026-06-04'),
('A_W05_WEBP2_23','W05_WEBP2','S23','ST07','Present','2026-06-04'),
('A_W05_WEBP2_24','W05_WEBP2','S24','ST07','Absent','2026-06-04'),
('A_W05_WEBP2_25','W05_WEBP2','S25','ST07','Present','2026-06-04'),

('A_W05_OSC_11','W05_OSC','S11','ST03','Present','2026-06-05'),
('A_W05_OSC_12','W05_OSC','S12','ST03','Present','2026-06-05'),
('A_W05_OSC_13','W05_OSC','S13','ST03','Present','2026-06-05'),
('A_W05_OSC_14','W05_OSC','S14','ST03','Present','2026-06-05'),
('A_W05_OSC_15','W05_OSC','S15','ST03','Present','2026-06-05'),
('A_W05_OSC_16','W05_OSC','S16','ST03','Present','2026-06-05'),
('A_W05_OSC_17','W05_OSC','S17','ST03','Absent','2026-06-05'),
('A_W05_OSC_18','W05_OSC','S18','ST03','Present','2026-06-05'),
('A_W05_OSC_19','W05_OSC','S19','ST03','Present','2026-06-05'),
('A_W05_OSC_20','W05_OSC','S20','ST03','Present','2026-06-05'),
('A_W05_OSC_21','W05_OSC','S21','ST03','Present','2026-06-05'),
('A_W05_OSC_22','W05_OSC','S22','ST03','Present','2026-06-05'),
('A_W05_OSC_23','W05_OSC','S23','ST03','Present','2026-06-05'),
('A_W05_OSC_24','W05_OSC','S24','ST03','Present','2026-06-05'),
('A_W05_OSC_25','W05_OSC','S25','ST03','Present','2026-06-05');

INSERT INTO ATTENDANCE_RECORD (Attendance_ID, session_id, student_id, marked_by, attendance_status, marked_date) VALUES

-- ================= WEEK 06 =================

('A_W06_MGT_11','W06_MGT','S11','ST03','Present','2026-06-08'),
('A_W06_MGT_12','W06_MGT','S12','ST03','Present','2026-06-08'),
('A_W06_MGT_13','W06_MGT','S13','ST03','Present','2026-06-08'),
('A_W06_MGT_14','W06_MGT','S14','ST03','Present','2026-06-08'),
('A_W06_MGT_15','W06_MGT','S15','ST03','Present','2026-06-08'),
('A_W06_MGT_16','W06_MGT','S16','ST03','Present','2026-06-08'),
('A_W06_MGT_17','W06_MGT','S17','ST03','Present','2026-06-08'),
('A_W06_MGT_18','W06_MGT','S18','ST03','Present','2026-06-08'),
('A_W06_MGT_19','W06_MGT','S19','ST03','Absent','2026-06-08'),
('A_W06_MGT_20','W06_MGT','S20','ST03','Present','2026-06-08'),
('A_W06_MGT_21','W06_MGT','S21','ST03','Present','2026-06-08'),
('A_W06_MGT_22','W06_MGT','S22','ST03','Present','2026-06-08'),
('A_W06_MGT_23','W06_MGT','S23','ST03','Present','2026-06-08'),
('A_W06_MGT_24','W06_MGT','S24','ST03','Present','2026-06-08'),
('A_W06_MGT_25','W06_MGT','S25','ST03','Present','2026-06-08'),

('A_W06_LIN_11','W06_LIN','S11','ST04','Present','2026-06-08'),
('A_W06_LIN_12','W06_LIN','S12','ST04','Present','2026-06-08'),
('A_W06_LIN_13','W06_LIN','S13','ST04','Present','2026-06-08'),
('A_W06_LIN_14','W06_LIN','S14','ST04','Present','2026-06-08'),
('A_W06_LIN_15','W06_LIN','S15','ST04','Present','2026-06-08'),
('A_W06_LIN_16','W06_LIN','S16','ST04','Medical','2026-06-08'),
('A_W06_LIN_17','W06_LIN','S17','ST04','Present','2026-06-08'),
('A_W06_LIN_18','W06_LIN','S18','ST04','Present','2026-06-08'),
('A_W06_LIN_19','W06_LIN','S19','ST04','Absent','2026-06-08'),
('A_W06_LIN_20','W06_LIN','S20','ST04','Present','2026-06-08'),
('A_W06_LIN_21','W06_LIN','S21','ST04','Absent','2026-06-08'),
('A_W06_LIN_22','W06_LIN','S22','ST04','Present','2026-06-08'),
('A_W06_LIN_23','W06_LIN','S23','ST04','Present','2026-06-08'),
('A_W06_LIN_24','W06_LIN','S24','ST04','Absent','2026-06-08'),
('A_W06_LIN_25','W06_LIN','S25','ST04','Present','2026-06-08'),

('A_W06_DBP_11','W06_DBP','S11','ST05','Present','2026-06-09'),
('A_W06_DBP_12','W06_DBP','S12','ST05','Present','2026-06-09'),
('A_W06_DBP_13','W06_DBP','S13','ST05','Present','2026-06-09'),
('A_W06_DBP_14','W06_DBP','S14','ST05','Present','2026-06-09'),
('A_W06_DBP_15','W06_DBP','S15','ST05','Present','2026-06-09'),
('A_W06_DBP_16','W06_DBP','S16','ST05','Present','2026-06-09'),
('A_W06_DBP_17','W06_DBP','S17','ST05','Present','2026-06-09'),
('A_W06_DBP_18','W06_DBP','S18','ST05','Present','2026-06-09'),
('A_W06_DBP_19','W06_DBP','S19','ST05','Present','2026-06-09'),
('A_W06_DBP_20','W06_DBP','S20','ST05','Present','2026-06-09'),
('A_W06_DBP_21','W06_DBP','S21','ST05','Present','2026-06-09'),
('A_W06_DBP_22','W06_DBP','S22','ST05','Present','2026-06-09'),
('A_W06_DBP_23','W06_DBP','S23','ST05','Present','2026-06-09'),
('A_W06_DBP_24','W06_DBP','S24','ST05','Absent','2026-06-09'),
('A_W06_DBP_25','W06_DBP','S25','ST05','Present','2026-06-09'),

('A_W06_WEBT_11','W06_WEBT','S11','ST06','Present','2026-06-09'),
('A_W06_WEBT_12','W06_WEBT','S12','ST06','Present','2026-06-09'),
('A_W06_WEBT_13','W06_WEBT','S13','ST06','Absent','2026-06-09'),
('A_W06_WEBT_14','W06_WEBT','S14','ST06','Present','2026-06-09'),
('A_W06_WEBT_15','W06_WEBT','S15','ST06','Present','2026-06-09'),
('A_W06_WEBT_16','W06_WEBT','S16','ST06','Present','2026-06-09'),
('A_W06_WEBT_17','W06_WEBT','S17','ST06','Absent','2026-06-09'),
('A_W06_WEBT_18','W06_WEBT','S18','ST06','Present','2026-06-09'),
('A_W06_WEBT_19','W06_WEBT','S19','ST06','Present','2026-06-09'),
('A_W06_WEBT_20','W06_WEBT','S20','ST06','Present','2026-06-09'),
('A_W06_WEBT_21','W06_WEBT','S21','ST06','Absent','2026-06-09'),
('A_W06_WEBT_22','W06_WEBT','S22','ST06','Present','2026-06-09'),
('A_W06_WEBT_23','W06_WEBT','S23','ST06','Absent','2026-06-09'),
('A_W06_WEBT_24','W06_WEBT','S24','ST06','Absent','2026-06-09'),
('A_W06_WEBT_25','W06_WEBT','S25','ST06','Present','2026-06-09'),

('A_W06_WEBP1_11','W06_WEBP1','S11','ST07','Present','2026-06-09'),
('A_W06_WEBP1_12','W06_WEBP1','S12','ST07','Present','2026-06-09'),
('A_W06_WEBP1_13','W06_WEBP1','S13','ST07','Absent','2026-06-09'),
('A_W06_WEBP1_14','W06_WEBP1','S14','ST07','Present','2026-06-09'),
('A_W06_WEBP1_15','W06_WEBP1','S15','ST07','Present','2026-06-09'),
('A_W06_WEBP1_16','W06_WEBP1','S16','ST07','Present','2026-06-09'),
('A_W06_WEBP1_17','W06_WEBP1','S17','ST07','Absent','2026-06-09'),
('A_W06_WEBP1_18','W06_WEBP1','S18','ST07','Present','2026-06-09'),
('A_W06_WEBP1_19','W06_WEBP1','S19','ST07','Absent','2026-06-09'),
('A_W06_WEBP1_20','W06_WEBP1','S20','ST07','Present','2026-06-09'),
('A_W06_WEBP1_21','W06_WEBP1','S21','ST07','Present','2026-06-09'),
('A_W06_WEBP1_22','W06_WEBP1','S22','ST07','Present','2026-06-09'),
('A_W06_WEBP1_23','W06_WEBP1','S23','ST07','Present','2026-06-09'),
('A_W06_WEBP1_24','W06_WEBP1','S24','ST07','Absent','2026-06-09'),
('A_W06_WEBP1_25','W06_WEBP1','S25','ST07','Present','2026-06-09'),

('A_W06_MAT_11','W06_MAT','S11','ST08','Present','2026-06-10'),
('A_W06_MAT_12','W06_MAT','S12','ST08','Present','2026-06-10'),
('A_W06_MAT_13','W06_MAT','S13','ST08','Absent','2026-06-10'),
('A_W06_MAT_14','W06_MAT','S14','ST08','Present','2026-06-10'),
('A_W06_MAT_15','W06_MAT','S15','ST08','Present','2026-06-10'),
('A_W06_MAT_16','W06_MAT','S16','ST08','Present','2026-06-10'),
('A_W06_MAT_17','W06_MAT','S17','ST08','Absent','2026-06-10'),
('A_W06_MAT_18','W06_MAT','S18','ST08','Present','2026-06-10'),
('A_W06_MAT_19','W06_MAT','S19','ST08','Absent','2026-06-10'),
('A_W06_MAT_20','W06_MAT','S20','ST08','Present','2026-06-10'),
('A_W06_MAT_21','W06_MAT','S21','ST08','Absent','2026-06-10'),
('A_W06_MAT_22','W06_MAT','S22','ST08','Present','2026-06-10'),
('A_W06_MAT_23','W06_MAT','S23','ST08','Present','2026-06-10'),
('A_W06_MAT_24','W06_MAT','S24','ST08','Absent','2026-06-10'),
('A_W06_MAT_25','W06_MAT','S25','ST08','Present','2026-06-10'),

('A_W06_ENG_11','W06_ENG','S11','ST09','Present','2026-06-11'),
('A_W06_ENG_12','W06_ENG','S12','ST09','Present','2026-06-11'),
('A_W06_ENG_13','W06_ENG','S13','ST09','Present','2026-06-11'),
('A_W06_ENG_14','W06_ENG','S14','ST09','Present','2026-06-11'),
('A_W06_ENG_15','W06_ENG','S15','ST09','Present','2026-06-11'),
('A_W06_ENG_16','W06_ENG','S16','ST09','Present','2026-06-11'),
('A_W06_ENG_17','W06_ENG','S17','ST09','Absent','2026-06-11'),
('A_W06_ENG_18','W06_ENG','S18','ST09','Present','2026-06-11'),
('A_W06_ENG_19','W06_ENG','S19','ST09','Absent','2026-06-11'),
('A_W06_ENG_20','W06_ENG','S20','ST09','Present','2026-06-11'),
('A_W06_ENG_21','W06_ENG','S21','ST09','Absent','2026-06-11'),
('A_W06_ENG_22','W06_ENG','S22','ST09','Present','2026-06-11'),
('A_W06_ENG_23','W06_ENG','S23','ST09','Medical','2026-06-11'),
('A_W06_ENG_24','W06_ENG','S24','ST09','Absent','2026-06-11'),
('A_W06_ENG_25','W06_ENG','S25','ST09','Present','2026-06-11'),

('A_W06_DBS_11','W06_DBS','S11','ST10','Present','2026-06-11'),
('A_W06_DBS_12','W06_DBS','S12','ST10','Present','2026-06-11'),
('A_W06_DBS_13','W06_DBS','S13','ST10','Absent','2026-06-11'),
('A_W06_DBS_14','W06_DBS','S14','ST10','Present','2026-06-11'),
('A_W06_DBS_15','W06_DBS','S15','ST10','Present','2026-06-11'),
('A_W06_DBS_16','W06_DBS','S16','ST10','Present','2026-06-11'),
('A_W06_DBS_17','W06_DBS','S17','ST10','Absent','2026-06-11'),
('A_W06_DBS_18','W06_DBS','S18','ST10','Present','2026-06-11'),
('A_W06_DBS_19','W06_DBS','S19','ST10','Absent','2026-06-11'),
('A_W06_DBS_20','W06_DBS','S20','ST10','Present','2026-06-11'),
('A_W06_DBS_21','W06_DBS','S21','ST10','Absent','2026-06-11'),
('A_W06_DBS_22','W06_DBS','S22','ST10','Present','2026-06-11'),
('A_W06_DBS_23','W06_DBS','S23','ST10','Present','2026-06-11'),
('A_W06_DBS_24','W06_DBS','S24','ST10','Absent','2026-06-11'),
('A_W06_DBS_25','W06_DBS','S25','ST10','Present','2026-06-11'),

('A_W06_WEBP2_11','W06_WEBP2','S11','ST07','Present','2026-06-11'),
('A_W06_WEBP2_12','W06_WEBP2','S12','ST07','Present','2026-06-11'),
('A_W06_WEBP2_13','W06_WEBP2','S13','ST07','Absent','2026-06-11'),
('A_W06_WEBP2_14','W06_WEBP2','S14','ST07','Present','2026-06-11'),
('A_W06_WEBP2_15','W06_WEBP2','S15','ST07','Present','2026-06-11'),
('A_W06_WEBP2_16','W06_WEBP2','S16','ST07','Present','2026-06-11'),
('A_W06_WEBP2_17','W06_WEBP2','S17','ST07','Present','2026-06-11'),
('A_W06_WEBP2_18','W06_WEBP2','S18','ST07','Medical','2026-06-11'),
('A_W06_WEBP2_19','W06_WEBP2','S19','ST07','Absent','2026-06-11'),
('A_W06_WEBP2_20','W06_WEBP2','S20','ST07','Present','2026-06-11'),
('A_W06_WEBP2_21','W06_WEBP2','S21','ST07','Absent','2026-06-11'),
('A_W06_WEBP2_22','W06_WEBP2','S22','ST07','Present','2026-06-11'),
('A_W06_WEBP2_23','W06_WEBP2','S23','ST07','Present','2026-06-11'),
('A_W06_WEBP2_24','W06_WEBP2','S24','ST07','Absent','2026-06-11'),
('A_W06_WEBP2_25','W06_WEBP2','S25','ST07','Present','2026-06-11'),

('A_W06_OSC_11','W06_OSC','S11','ST03','Present','2026-06-12'),
('A_W06_OSC_12','W06_OSC','S12','ST03','Present','2026-06-12'),
('A_W06_OSC_13','W06_OSC','S13','ST03','Absent','2026-06-12'),
('A_W06_OSC_14','W06_OSC','S14','ST03','Medical','2026-06-12'),
('A_W06_OSC_15','W06_OSC','S15','ST03','Present','2026-06-12'),
('A_W06_OSC_16','W06_OSC','S16','ST03','Present','2026-06-12'),
('A_W06_OSC_17','W06_OSC','S17','ST03','Absent','2026-06-12'),
('A_W06_OSC_18','W06_OSC','S18','ST03','Present','2026-06-12'),
('A_W06_OSC_19','W06_OSC','S19','ST03','Absent','2026-06-12'),
('A_W06_OSC_20','W06_OSC','S20','ST03','Present','2026-06-12'),
('A_W06_OSC_21','W06_OSC','S21','ST03','Absent','2026-06-12'),
('A_W06_OSC_22','W06_OSC','S22','ST03','Present','2026-06-12'),
('A_W06_OSC_23','W06_OSC','S23','ST03','Present','2026-06-12'),
('A_W06_OSC_24','W06_OSC','S24','ST03','Present','2026-06-12'),
('A_W06_OSC_25','W06_OSC','S25','ST03','Present','2026-06-12'),

-- ================= WEEK 07 =================

('A_W07_MGT_11','W07_MGT','S11','ST03','Present','2026-06-15'),
('A_W07_MGT_12','W07_MGT','S12','ST03','Present','2026-06-15'),
('A_W07_MGT_13','W07_MGT','S13','ST03','Absent','2026-06-15'),
('A_W07_MGT_14','W07_MGT','S14','ST03','Present','2026-06-15'),
('A_W07_MGT_15','W07_MGT','S15','ST03','Present','2026-06-15'),
('A_W07_MGT_16','W07_MGT','S16','ST03','Present','2026-06-15'),
('A_W07_MGT_17','W07_MGT','S17','ST03','Present','2026-06-15'),
('A_W07_MGT_18','W07_MGT','S18','ST03','Present','2026-06-15'),
('A_W07_MGT_19','W07_MGT','S19','ST03','Absent','2026-06-15'),
('A_W07_MGT_20','W07_MGT','S20','ST03','Present','2026-06-15'),
('A_W07_MGT_21','W07_MGT','S21','ST03','Absent','2026-06-15'),
('A_W07_MGT_22','W07_MGT','S22','ST03','Present','2026-06-15'),
('A_W07_MGT_23','W07_MGT','S23','ST03','Present','2026-06-15'),
('A_W07_MGT_24','W07_MGT','S24','ST03','Absent','2026-06-15'),
('A_W07_MGT_25','W07_MGT','S25','ST03','Present','2026-06-15'),

('A_W07_LIN_11','W07_LIN','S11','ST04','Present','2026-06-15'),
('A_W07_LIN_12','W07_LIN','S12','ST04','Present','2026-06-15'),
('A_W07_LIN_13','W07_LIN','S13','ST04','Present','2026-06-15'),
('A_W07_LIN_14','W07_LIN','S14','ST04','Present','2026-06-15'),
('A_W07_LIN_15','W07_LIN','S15','ST04','Present','2026-06-15'),
('A_W07_LIN_16','W07_LIN','S16','ST04','Present','2026-06-15'),
('A_W07_LIN_17','W07_LIN','S17','ST04','Absent','2026-06-15'),
('A_W07_LIN_18','W07_LIN','S18','ST04','Present','2026-06-15'),
('A_W07_LIN_19','W07_LIN','S19','ST04','Present','2026-06-15'),
('A_W07_LIN_20','W07_LIN','S20','ST04','Present','2026-06-15'),
('A_W07_LIN_21','W07_LIN','S21','ST04','Present','2026-06-15'),
('A_W07_LIN_22','W07_LIN','S22','ST04','Present','2026-06-15'),
('A_W07_LIN_23','W07_LIN','S23','ST04','Present','2026-06-15'),
('A_W07_LIN_24','W07_LIN','S24','ST04','Absent','2026-06-15'),
('A_W07_LIN_25','W07_LIN','S25','ST04','Present','2026-06-15'),

('A_W07_DBP_11','W07_DBP','S11','ST05','Present','2026-06-16'),
('A_W07_DBP_12','W07_DBP','S12','ST05','Present','2026-06-16'),
('A_W07_DBP_13','W07_DBP','S13','ST05','Absent','2026-06-16'),
('A_W07_DBP_14','W07_DBP','S14','ST05','Present','2026-06-16'),
('A_W07_DBP_15','W07_DBP','S15','ST05','Present','2026-06-16'),
('A_W07_DBP_16','W07_DBP','S16','ST05','Present','2026-06-16'),
('A_W07_DBP_17','W07_DBP','S17','ST05','Present','2026-06-16'),
('A_W07_DBP_18','W07_DBP','S18','ST05','Present','2026-06-16'),
('A_W07_DBP_19','W07_DBP','S19','ST05','Present','2026-06-16'),
('A_W07_DBP_20','W07_DBP','S20','ST05','Present','2026-06-16'),
('A_W07_DBP_21','W07_DBP','S21','ST05','Present','2026-06-16'),
('A_W07_DBP_22','W07_DBP','S22','ST05','Present','2026-06-16'),
('A_W07_DBP_23','W07_DBP','S23','ST05','Present','2026-06-16'),
('A_W07_DBP_24','W07_DBP','S24','ST05','Present','2026-06-16'),
('A_W07_DBP_25','W07_DBP','S25','ST05','Present','2026-06-16'),

('A_W07_WEBT_11','W07_WEBT','S11','ST06','Present','2026-06-16'),
('A_W07_WEBT_12','W07_WEBT','S12','ST06','Present','2026-06-16'),
('A_W07_WEBT_13','W07_WEBT','S13','ST06','Absent','2026-06-16'),
('A_W07_WEBT_14','W07_WEBT','S14','ST06','Present','2026-06-16'),
('A_W07_WEBT_15','W07_WEBT','S15','ST06','Present','2026-06-16'),
('A_W07_WEBT_16','W07_WEBT','S16','ST06','Present','2026-06-16'),
('A_W07_WEBT_17','W07_WEBT','S17','ST06','Absent','2026-06-16'),
('A_W07_WEBT_18','W07_WEBT','S18','ST06','Present','2026-06-16'),
('A_W07_WEBT_19','W07_WEBT','S19','ST06','Absent','2026-06-16'),
('A_W07_WEBT_20','W07_WEBT','S20','ST06','Medical','2026-06-16'),
('A_W07_WEBT_21','W07_WEBT','S21','ST06','Absent','2026-06-16'),
('A_W07_WEBT_22','W07_WEBT','S22','ST06','Present','2026-06-16'),
('A_W07_WEBT_23','W07_WEBT','S23','ST06','Present','2026-06-16'),
('A_W07_WEBT_24','W07_WEBT','S24','ST06','Absent','2026-06-16'),
('A_W07_WEBT_25','W07_WEBT','S25','ST06','Present','2026-06-16'),

('A_W07_WEBP1_11','W07_WEBP1','S11','ST07','Present','2026-06-16'),
('A_W07_WEBP1_12','W07_WEBP1','S12','ST07','Present','2026-06-16'),
('A_W07_WEBP1_13','W07_WEBP1','S13','ST07','Present','2026-06-16'),
('A_W07_WEBP1_14','W07_WEBP1','S14','ST07','Present','2026-06-16'),
('A_W07_WEBP1_15','W07_WEBP1','S15','ST07','Present','2026-06-16'),
('A_W07_WEBP1_16','W07_WEBP1','S16','ST07','Present','2026-06-16'),
('A_W07_WEBP1_17','W07_WEBP1','S17','ST07','Absent','2026-06-16'),
('A_W07_WEBP1_18','W07_WEBP1','S18','ST07','Present','2026-06-16'),
('A_W07_WEBP1_19','W07_WEBP1','S19','ST07','Absent','2026-06-16'),
('A_W07_WEBP1_20','W07_WEBP1','S20','ST07','Present','2026-06-16'),
('A_W07_WEBP1_21','W07_WEBP1','S21','ST07','Absent','2026-06-16'),
('A_W07_WEBP1_22','W07_WEBP1','S22','ST07','Present','2026-06-16'),
('A_W07_WEBP1_23','W07_WEBP1','S23','ST07','Present','2026-06-16'),
('A_W07_WEBP1_24','W07_WEBP1','S24','ST07','Absent','2026-06-16'),
('A_W07_WEBP1_25','W07_WEBP1','S25','ST07','Present','2026-06-16'),

('A_W07_MAT_11','W07_MAT','S11','ST08','Present','2026-06-17'),
('A_W07_MAT_12','W07_MAT','S12','ST08','Present','2026-06-17'),
('A_W07_MAT_13','W07_MAT','S13','ST08','Absent','2026-06-17'),
('A_W07_MAT_14','W07_MAT','S14','ST08','Present','2026-06-17'),
('A_W07_MAT_15','W07_MAT','S15','ST08','Present','2026-06-17'),
('A_W07_MAT_16','W07_MAT','S16','ST08','Present','2026-06-17'),
('A_W07_MAT_17','W07_MAT','S17','ST08','Absent','2026-06-17'),
('A_W07_MAT_18','W07_MAT','S18','ST08','Present','2026-06-17'),
('A_W07_MAT_19','W07_MAT','S19','ST08','Absent','2026-06-17'),
('A_W07_MAT_20','W07_MAT','S20','ST08','Present','2026-06-17'),
('A_W07_MAT_21','W07_MAT','S21','ST08','Absent','2026-06-17'),
('A_W07_MAT_22','W07_MAT','S22','ST08','Present','2026-06-17'),
('A_W07_MAT_23','W07_MAT','S23','ST08','Present','2026-06-17'),
('A_W07_MAT_24','W07_MAT','S24','ST08','Absent','2026-06-17'),
('A_W07_MAT_25','W07_MAT','S25','ST08','Present','2026-06-17'),

('A_W07_ENG_11','W07_ENG','S11','ST09','Present','2026-06-18'),
('A_W07_ENG_12','W07_ENG','S12','ST09','Present','2026-06-18'),
('A_W07_ENG_13','W07_ENG','S13','ST09','Present','2026-06-18'),
('A_W07_ENG_14','W07_ENG','S14','ST09','Present','2026-06-18'),
('A_W07_ENG_15','W07_ENG','S15','ST09','Present','2026-06-18'),
('A_W07_ENG_16','W07_ENG','S16','ST09','Present','2026-06-18'),
('A_W07_ENG_17','W07_ENG','S17','ST09','Absent','2026-06-18'),
('A_W07_ENG_18','W07_ENG','S18','ST09','Present','2026-06-18'),
('A_W07_ENG_19','W07_ENG','S19','ST09','Present','2026-06-18'),
('A_W07_ENG_20','W07_ENG','S20','ST09','Present','2026-06-18'),
('A_W07_ENG_21','W07_ENG','S21','ST09','Present','2026-06-18'),
('A_W07_ENG_22','W07_ENG','S22','ST09','Present','2026-06-18'),
('A_W07_ENG_23','W07_ENG','S23','ST09','Present','2026-06-18'),
('A_W07_ENG_24','W07_ENG','S24','ST09','Absent','2026-06-18'),
('A_W07_ENG_25','W07_ENG','S25','ST09','Medical','2026-06-18'),

('A_W07_DBS_11','W07_DBS','S11','ST10','Present','2026-06-18'),
('A_W07_DBS_12','W07_DBS','S12','ST10','Present','2026-06-18'),
('A_W07_DBS_13','W07_DBS','S13','ST10','Present','2026-06-18'),
('A_W07_DBS_14','W07_DBS','S14','ST10','Present','2026-06-18'),
('A_W07_DBS_15','W07_DBS','S15','ST10','Present','2026-06-18'),
('A_W07_DBS_16','W07_DBS','S16','ST10','Present','2026-06-18'),
('A_W07_DBS_17','W07_DBS','S17','ST10','Absent','2026-06-18'),
('A_W07_DBS_18','W07_DBS','S18','ST10','Present','2026-06-18'),
('A_W07_DBS_19','W07_DBS','S19','ST10','Absent','2026-06-18'),
('A_W07_DBS_20','W07_DBS','S20','ST10','Present','2026-06-18'),
('A_W07_DBS_21','W07_DBS','S21','ST10','Present','2026-06-18'),
('A_W07_DBS_22','W07_DBS','S22','ST10','Present','2026-06-18'),
('A_W07_DBS_23','W07_DBS','S23','ST10','Present','2026-06-18'),
('A_W07_DBS_24','W07_DBS','S24','ST10','Present','2026-06-18'),
('A_W07_DBS_25','W07_DBS','S25','ST10','Present','2026-06-18'),

('A_W07_WEBP2_11','W07_WEBP2','S11','ST07','Present','2026-06-18'),
('A_W07_WEBP2_12','W07_WEBP2','S12','ST07','Present','2026-06-18'),
('A_W07_WEBP2_13','W07_WEBP2','S13','ST07','Present','2026-06-18'),
('A_W07_WEBP2_14','W07_WEBP2','S14','ST07','Present','2026-06-18'),
('A_W07_WEBP2_15','W07_WEBP2','S15','ST07','Present','2026-06-18'),
('A_W07_WEBP2_16','W07_WEBP2','S16','ST07','Present','2026-06-18'),
('A_W07_WEBP2_17','W07_WEBP2','S17','ST07','Absent','2026-06-18'),
('A_W07_WEBP2_18','W07_WEBP2','S18','ST07','Present','2026-06-18'),
('A_W07_WEBP2_19','W07_WEBP2','S19','ST07','Absent','2026-06-18'),
('A_W07_WEBP2_20','W07_WEBP2','S20','ST07','Present','2026-06-18'),
('A_W07_WEBP2_21','W07_WEBP2','S21','ST07','Present','2026-06-18'),
('A_W07_WEBP2_22','W07_WEBP2','S22','ST07','Present','2026-06-18'),
('A_W07_WEBP2_23','W07_WEBP2','S23','ST07','Present','2026-06-18'),
('A_W07_WEBP2_24','W07_WEBP2','S24','ST07','Absent','2026-06-18'),
('A_W07_WEBP2_25','W07_WEBP2','S25','ST07','Present','2026-06-18'),

('A_W07_OSC_11','W07_OSC','S11','ST03','Present','2026-06-19'),
('A_W07_OSC_12','W07_OSC','S12','ST03','Present','2026-06-19'),
('A_W07_OSC_13','W07_OSC','S13','ST03','Absent','2026-06-19'),
('A_W07_OSC_14','W07_OSC','S14','ST03','Present','2026-06-19'),
('A_W07_OSC_15','W07_OSC','S15','ST03','Present','2026-06-19'),
('A_W07_OSC_16','W07_OSC','S16','ST03','Present','2026-06-19'),
('A_W07_OSC_17','W07_OSC','S17','ST03','Absent','2026-06-19'),
('A_W07_OSC_18','W07_OSC','S18','ST03','Present','2026-06-19'),
('A_W07_OSC_19','W07_OSC','S19','ST03','Present','2026-06-19'),
('A_W07_OSC_20','W07_OSC','S20','ST03','Present','2026-06-19'),
('A_W07_OSC_21','W07_OSC','S21','ST03','Absent','2026-06-19'),
('A_W07_OSC_22','W07_OSC','S22','ST03','Present','2026-06-19'),
('A_W07_OSC_23','W07_OSC','S23','ST03','Present','2026-06-19'),
('A_W07_OSC_24','W07_OSC','S24','ST03','Absent','2026-06-19'),
('A_W07_OSC_25','W07_OSC','S25','ST03','Present','2026-06-19'),

-- ================= WEEK 08 =================

('A_W08_MGT_11','W08_MGT','S11','ST03','Medical','2026-06-22'),
('A_W08_MGT_12','W08_MGT','S12','ST03','Present','2026-06-22'),
('A_W08_MGT_13','W08_MGT','S13','ST03','Present','2026-06-22'),
('A_W08_MGT_14','W08_MGT','S14','ST03','Present','2026-06-22'),
('A_W08_MGT_15','W08_MGT','S15','ST03','Present','2026-06-22'),
('A_W08_MGT_16','W08_MGT','S16','ST03','Present','2026-06-22'),
('A_W08_MGT_17','W08_MGT','S17','ST03','Absent','2026-06-22'),
('A_W08_MGT_18','W08_MGT','S18','ST03','Present','2026-06-22'),
('A_W08_MGT_19','W08_MGT','S19','ST03','Present','2026-06-22'),
('A_W08_MGT_20','W08_MGT','S20','ST03','Present','2026-06-22'),
('A_W08_MGT_21','W08_MGT','S21','ST03','Absent','2026-06-22'),
('A_W08_MGT_22','W08_MGT','S22','ST03','Present','2026-06-22'),
('A_W08_MGT_23','W08_MGT','S23','ST03','Present','2026-06-22'),
('A_W08_MGT_24','W08_MGT','S24','ST03','Present','2026-06-22'),
('A_W08_MGT_25','W08_MGT','S25','ST03','Present','2026-06-22'),

('A_W08_LIN_11','W08_LIN','S11','ST04','Present','2026-06-22'),
('A_W08_LIN_12','W08_LIN','S12','ST04','Present','2026-06-22'),
('A_W08_LIN_13','W08_LIN','S13','ST04','Present','2026-06-22'),
('A_W08_LIN_14','W08_LIN','S14','ST04','Present','2026-06-22'),
('A_W08_LIN_15','W08_LIN','S15','ST04','Present','2026-06-22'),
('A_W08_LIN_16','W08_LIN','S16','ST04','Present','2026-06-22'),
('A_W08_LIN_17','W08_LIN','S17','ST04','Present','2026-06-22'),
('A_W08_LIN_18','W08_LIN','S18','ST04','Present','2026-06-22'),
('A_W08_LIN_19','W08_LIN','S19','ST04','Absent','2026-06-22'),
('A_W08_LIN_20','W08_LIN','S20','ST04','Present','2026-06-22'),
('A_W08_LIN_21','W08_LIN','S21','ST04','Absent','2026-06-22'),
('A_W08_LIN_22','W08_LIN','S22','ST04','Present','2026-06-22'),
('A_W08_LIN_23','W08_LIN','S23','ST04','Present','2026-06-22'),
('A_W08_LIN_24','W08_LIN','S24','ST04','Absent','2026-06-22'),
('A_W08_LIN_25','W08_LIN','S25','ST04','Present','2026-06-22'),

('A_W08_DBP_11','W08_DBP','S11','ST05','Present','2026-06-23'),
('A_W08_DBP_12','W08_DBP','S12','ST05','Present','2026-06-23'),
('A_W08_DBP_13','W08_DBP','S13','ST05','Present','2026-06-23'),
('A_W08_DBP_14','W08_DBP','S14','ST05','Present','2026-06-23'),
('A_W08_DBP_15','W08_DBP','S15','ST05','Present','2026-06-23'),
('A_W08_DBP_16','W08_DBP','S16','ST05','Present','2026-06-23'),
('A_W08_DBP_17','W08_DBP','S17','ST05','Absent','2026-06-23'),
('A_W08_DBP_18','W08_DBP','S18','ST05','Present','2026-06-23'),
('A_W08_DBP_19','W08_DBP','S19','ST05','Absent','2026-06-23'),
('A_W08_DBP_20','W08_DBP','S20','ST05','Present','2026-06-23'),
('A_W08_DBP_21','W08_DBP','S21','ST05','Present','2026-06-23'),
('A_W08_DBP_22','W08_DBP','S22','ST05','Present','2026-06-23'),
('A_W08_DBP_23','W08_DBP','S23','ST05','Present','2026-06-23'),
('A_W08_DBP_24','W08_DBP','S24','ST05','Present','2026-06-23'),
('A_W08_DBP_25','W08_DBP','S25','ST05','Present','2026-06-23'),

('A_W08_WEBT_11','W08_WEBT','S11','ST06','Present','2026-06-23'),
('A_W08_WEBT_12','W08_WEBT','S12','ST06','Present','2026-06-23'),
('A_W08_WEBT_13','W08_WEBT','S13','ST06','Present','2026-06-23'),
('A_W08_WEBT_14','W08_WEBT','S14','ST06','Present','2026-06-23'),
('A_W08_WEBT_15','W08_WEBT','S15','ST06','Present','2026-06-23'),
('A_W08_WEBT_16','W08_WEBT','S16','ST06','Present','2026-06-23'),
('A_W08_WEBT_17','W08_WEBT','S17','ST06','Absent','2026-06-23'),
('A_W08_WEBT_18','W08_WEBT','S18','ST06','Present','2026-06-23'),
('A_W08_WEBT_19','W08_WEBT','S19','ST06','Absent','2026-06-23'),
('A_W08_WEBT_20','W08_WEBT','S20','ST06','Present','2026-06-23'),
('A_W08_WEBT_21','W08_WEBT','S21','ST06','Absent','2026-06-23'),
('A_W08_WEBT_22','W08_WEBT','S22','ST06','Present','2026-06-23'),
('A_W08_WEBT_23','W08_WEBT','S23','ST06','Present','2026-06-23'),
('A_W08_WEBT_24','W08_WEBT','S24','ST06','Absent','2026-06-23'),
('A_W08_WEBT_25','W08_WEBT','S25','ST06','Present','2026-06-23'),

('A_W08_WEBP1_11','W08_WEBP1','S11','ST07','Present','2026-06-23'),
('A_W08_WEBP1_12','W08_WEBP1','S12','ST07','Present','2026-06-23'),
('A_W08_WEBP1_13','W08_WEBP1','S13','ST07','Present','2026-06-23'),
('A_W08_WEBP1_14','W08_WEBP1','S14','ST07','Present','2026-06-23'),
('A_W08_WEBP1_15','W08_WEBP1','S15','ST07','Present','2026-06-23'),
('A_W08_WEBP1_16','W08_WEBP1','S16','ST07','Present','2026-06-23'),
('A_W08_WEBP1_17','W08_WEBP1','S17','ST07','Present','2026-06-23'),
('A_W08_WEBP1_18','W08_WEBP1','S18','ST07','Present','2026-06-23'),
('A_W08_WEBP1_19','W08_WEBP1','S19','ST07','Absent','2026-06-23'),
('A_W08_WEBP1_20','W08_WEBP1','S20','ST07','Absent','2026-06-23'),
('A_W08_WEBP1_21','W08_WEBP1','S21','ST07','Absent','2026-06-23'),
('A_W08_WEBP1_22','W08_WEBP1','S22','ST07','Present','2026-06-23'),
('A_W08_WEBP1_23','W08_WEBP1','S23','ST07','Present','2026-06-23'),
('A_W08_WEBP1_24','W08_WEBP1','S24','ST07','Absent','2026-06-23'),
('A_W08_WEBP1_25','W08_WEBP1','S25','ST07','Present','2026-06-23'),

('A_W08_MAT_11','W08_MAT','S11','ST08','Present','2026-06-24'),
('A_W08_MAT_12','W08_MAT','S12','ST08','Present','2026-06-24'),
('A_W08_MAT_13','W08_MAT','S13','ST08','Absent','2026-06-24'),
('A_W08_MAT_14','W08_MAT','S14','ST08','Medical','2026-06-24'),
('A_W08_MAT_15','W08_MAT','S15','ST08','Present','2026-06-24'),
('A_W08_MAT_16','W08_MAT','S16','ST08','Present','2026-06-24'),
('A_W08_MAT_17','W08_MAT','S17','ST08','Present','2026-06-24'),
('A_W08_MAT_18','W08_MAT','S18','ST08','Present','2026-06-24'),
('A_W08_MAT_19','W08_MAT','S19','ST08','Absent','2026-06-24'),
('A_W08_MAT_20','W08_MAT','S20','ST08','Present','2026-06-24'),
('A_W08_MAT_21','W08_MAT','S21','ST08','Present','2026-06-24'),
('A_W08_MAT_22','W08_MAT','S22','ST08','Present','2026-06-24'),
('A_W08_MAT_23','W08_MAT','S23','ST08','Present','2026-06-24'),
('A_W08_MAT_24','W08_MAT','S24','ST08','Absent','2026-06-24'),
('A_W08_MAT_25','W08_MAT','S25','ST08','Present','2026-06-24'),

('A_W08_ENG_11','W08_ENG','S11','ST09','Present','2026-06-25'),
('A_W08_ENG_12','W08_ENG','S12','ST09','Present','2026-06-25'),
('A_W08_ENG_13','W08_ENG','S13','ST09','Absent','2026-06-25'),
('A_W08_ENG_14','W08_ENG','S14','ST09','Present','2026-06-25'),
('A_W08_ENG_15','W08_ENG','S15','ST09','Present','2026-06-25'),
('A_W08_ENG_16','W08_ENG','S16','ST09','Present','2026-06-25'),
('A_W08_ENG_17','W08_ENG','S17','ST09','Present','2026-06-25'),
('A_W08_ENG_18','W08_ENG','S18','ST09','Present','2026-06-25'),
('A_W08_ENG_19','W08_ENG','S19','ST09','Absent','2026-06-25'),
('A_W08_ENG_20','W08_ENG','S20','ST09','Present','2026-06-25'),
('A_W08_ENG_21','W08_ENG','S21','ST09','Absent','2026-06-25'),
('A_W08_ENG_22','W08_ENG','S22','ST09','Present','2026-06-25'),
('A_W08_ENG_23','W08_ENG','S23','ST09','Present','2026-06-25'),
('A_W08_ENG_24','W08_ENG','S24','ST09','Absent','2026-06-25'),
('A_W08_ENG_25','W08_ENG','S25','ST09','Present','2026-06-25'),

('A_W08_DBS_11','W08_DBS','S11','ST10','Present','2026-06-25'),
('A_W08_DBS_12','W08_DBS','S12','ST10','Present','2026-06-25'),
('A_W08_DBS_13','W08_DBS','S13','ST10','Present','2026-06-25'),
('A_W08_DBS_14','W08_DBS','S14','ST10','Present','2026-06-25'),
('A_W08_DBS_15','W08_DBS','S15','ST10','Present','2026-06-25'),
('A_W08_DBS_16','W08_DBS','S16','ST10','Present','2026-06-25'),
('A_W08_DBS_17','W08_DBS','S17','ST10','Absent','2026-06-25'),
('A_W08_DBS_18','W08_DBS','S18','ST10','Present','2026-06-25'),
('A_W08_DBS_19','W08_DBS','S19','ST10','Absent','2026-06-25'),
('A_W08_DBS_20','W08_DBS','S20','ST10','Present','2026-06-25'),
('A_W08_DBS_21','W08_DBS','S21','ST10','Present','2026-06-25'),
('A_W08_DBS_22','W08_DBS','S22','ST10','Present','2026-06-25'),
('A_W08_DBS_23','W08_DBS','S23','ST10','Present','2026-06-25'),
('A_W08_DBS_24','W08_DBS','S24','ST10','Absent','2026-06-25'),
('A_W08_DBS_25','W08_DBS','S25','ST10','Present','2026-06-25'),

('A_W08_WEBP2_11','W08_WEBP2','S11','ST07','Present','2026-06-25'),
('A_W08_WEBP2_12','W08_WEBP2','S12','ST07','Present','2026-06-25'),
('A_W08_WEBP2_13','W08_WEBP2','S13','ST07','Present','2026-06-25'),
('A_W08_WEBP2_14','W08_WEBP2','S14','ST07','Present','2026-06-25'),
('A_W08_WEBP2_15','W08_WEBP2','S15','ST07','Present','2026-06-25'),
('A_W08_WEBP2_16','W08_WEBP2','S16','ST07','Present','2026-06-25'),
('A_W08_WEBP2_17','W08_WEBP2','S17','ST07','Absent','2026-06-25'),
('A_W08_WEBP2_18','W08_WEBP2','S18','ST07','Present','2026-06-25'),
('A_W08_WEBP2_19','W08_WEBP2','S19','ST07','Absent','2026-06-25'),
('A_W08_WEBP2_20','W08_WEBP2','S20','ST07','Present','2026-06-25'),
('A_W08_WEBP2_21','W08_WEBP2','S21','ST07','Absent','2026-06-25'),
('A_W08_WEBP2_22','W08_WEBP2','S22','ST07','Present','2026-06-25'),
('A_W08_WEBP2_23','W08_WEBP2','S23','ST07','Present','2026-06-25'),
('A_W08_WEBP2_24','W08_WEBP2','S24','ST07','Absent','2026-06-25'),
('A_W08_WEBP2_25','W08_WEBP2','S25','ST07','Present','2026-06-25'),

('A_W08_OSC_11','W08_OSC','S11','ST03','Present','2026-06-26'),
('A_W08_OSC_12','W08_OSC','S12','ST03','Present','2026-06-26'),
('A_W08_OSC_13','W08_OSC','S13','ST03','Present','2026-06-26'),
('A_W08_OSC_14','W08_OSC','S14','ST03','Present','2026-06-26'),
('A_W08_OSC_15','W08_OSC','S15','ST03','Present','2026-06-26'),
('A_W08_OSC_16','W08_OSC','S16','ST03','Present','2026-06-26'),
('A_W08_OSC_17','W08_OSC','S17','ST03','Absent','2026-06-26'),
('A_W08_OSC_18','W08_OSC','S18','ST03','Present','2026-06-26'),
('A_W08_OSC_19','W08_OSC','S19','ST03','Absent','2026-06-26'),
('A_W08_OSC_20','W08_OSC','S20','ST03','Present','2026-06-26'),
('A_W08_OSC_21','W08_OSC','S21','ST03','Absent','2026-06-26'),
('A_W08_OSC_22','W08_OSC','S22','ST03','Present','2026-06-26'),
('A_W08_OSC_23','W08_OSC','S23','ST03','Present','2026-06-26'),
('A_W08_OSC_24','W08_OSC','S24','ST03','Present','2026-06-26'),
('A_W08_OSC_25','W08_OSC','S25','ST03','Present','2026-06-26'),

-- ================= WEEK 09 =================

('A_W09_MGT_11','W09_MGT','S11','ST03','Present','2026-06-29'),
('A_W09_MGT_12','W09_MGT','S12','ST03','Present','2026-06-29'),
('A_W09_MGT_13','W09_MGT','S13','ST03','Absent','2026-06-29'),
('A_W09_MGT_14','W09_MGT','S14','ST03','Present','2026-06-29'),
('A_W09_MGT_15','W09_MGT','S15','ST03','Present','2026-06-29'),
('A_W09_MGT_16','W09_MGT','S16','ST03','Present','2026-06-29'),
('A_W09_MGT_17','W09_MGT','S17','ST03','Absent','2026-06-29'),
('A_W09_MGT_18','W09_MGT','S18','ST03','Present','2026-06-29'),
('A_W09_MGT_19','W09_MGT','S19','ST03','Absent','2026-06-29'),
('A_W09_MGT_20','W09_MGT','S20','ST03','Present','2026-06-29'),
('A_W09_MGT_21','W09_MGT','S21','ST03','Absent','2026-06-29'),
('A_W09_MGT_22','W09_MGT','S22','ST03','Present','2026-06-29'),
('A_W09_MGT_23','W09_MGT','S23','ST03','Present','2026-06-29'),
('A_W09_MGT_24','W09_MGT','S24','ST03','Absent','2026-06-29'),
('A_W09_MGT_25','W09_MGT','S25','ST03','Present','2026-06-29'),

('A_W09_LIN_11','W09_LIN','S11','ST04','Present','2026-06-29'),
('A_W09_LIN_12','W09_LIN','S12','ST04','Present','2026-06-29'),
('A_W09_LIN_13','W09_LIN','S13','ST04','Absent','2026-06-29'),
('A_W09_LIN_14','W09_LIN','S14','ST04','Present','2026-06-29'),
('A_W09_LIN_15','W09_LIN','S15','ST04','Present','2026-06-29'),
('A_W09_LIN_16','W09_LIN','S16','ST04','Present','2026-06-29'),
('A_W09_LIN_17','W09_LIN','S17','ST04','Absent','2026-06-29'),
('A_W09_LIN_18','W09_LIN','S18','ST04','Present','2026-06-29'),
('A_W09_LIN_19','W09_LIN','S19','ST04','Absent','2026-06-29'),
('A_W09_LIN_20','W09_LIN','S20','ST04','Present','2026-06-29'),
('A_W09_LIN_21','W09_LIN','S21','ST04','Present','2026-06-29'),
('A_W09_LIN_22','W09_LIN','S22','ST04','Present','2026-06-29'),
('A_W09_LIN_23','W09_LIN','S23','ST04','Present','2026-06-29'),
('A_W09_LIN_24','W09_LIN','S24','ST04','Present','2026-06-29'),
('A_W09_LIN_25','W09_LIN','S25','ST04','Present','2026-06-29'),

('A_W09_DBP_11','W09_DBP','S11','ST05','Present','2026-06-30'),
('A_W09_DBP_12','W09_DBP','S12','ST05','Present','2026-06-30'),
('A_W09_DBP_13','W09_DBP','S13','ST05','Absent','2026-06-30'),
('A_W09_DBP_14','W09_DBP','S14','ST05','Present','2026-06-30'),
('A_W09_DBP_15','W09_DBP','S15','ST05','Present','2026-06-30'),
('A_W09_DBP_16','W09_DBP','S16','ST05','Present','2026-06-30'),
('A_W09_DBP_17','W09_DBP','S17','ST05','Present','2026-06-30'),
('A_W09_DBP_18','W09_DBP','S18','ST05','Present','2026-06-30'),
('A_W09_DBP_19','W09_DBP','S19','ST05','Present','2026-06-30'),
('A_W09_DBP_20','W09_DBP','S20','ST05','Present','2026-06-30'),
('A_W09_DBP_21','W09_DBP','S21','ST05','Absent','2026-06-30'),
('A_W09_DBP_22','W09_DBP','S22','ST05','Present','2026-06-30'),
('A_W09_DBP_23','W09_DBP','S23','ST05','Present','2026-06-30'),
('A_W09_DBP_24','W09_DBP','S24','ST05','Present','2026-06-30'),
('A_W09_DBP_25','W09_DBP','S25','ST05','Present','2026-06-30'),

('A_W09_WEBT_11','W09_WEBT','S11','ST06','Present','2026-06-30'),
('A_W09_WEBT_12','W09_WEBT','S12','ST06','Present','2026-06-30'),
('A_W09_WEBT_13','W09_WEBT','S13','ST06','Absent','2026-06-30'),
('A_W09_WEBT_14','W09_WEBT','S14','ST06','Present','2026-06-30'),
('A_W09_WEBT_15','W09_WEBT','S15','ST06','Present','2026-06-30'),
('A_W09_WEBT_16','W09_WEBT','S16','ST06','Present','2026-06-30'),
('A_W09_WEBT_17','W09_WEBT','S17','ST06','Absent','2026-06-30'),
('A_W09_WEBT_18','W09_WEBT','S18','ST06','Present','2026-06-30'),
('A_W09_WEBT_19','W09_WEBT','S19','ST06','Absent','2026-06-30'),
('A_W09_WEBT_20','W09_WEBT','S20','ST06','Present','2026-06-30'),
('A_W09_WEBT_21','W09_WEBT','S21','ST06','Absent','2026-06-30'),
('A_W09_WEBT_22','W09_WEBT','S22','ST06','Present','2026-06-30'),
('A_W09_WEBT_23','W09_WEBT','S23','ST06','Present','2026-06-30'),
('A_W09_WEBT_24','W09_WEBT','S24','ST06','Present','2026-06-30'),
('A_W09_WEBT_25','W09_WEBT','S25','ST06','Present','2026-06-30'),

('A_W09_WEBP1_11','W09_WEBP1','S11','ST07','Present','2026-06-30'),
('A_W09_WEBP1_12','W09_WEBP1','S12','ST07','Present','2026-06-30'),
('A_W09_WEBP1_13','W09_WEBP1','S13','ST07','Absent','2026-06-30'),
('A_W09_WEBP1_14','W09_WEBP1','S14','ST07','Present','2026-06-30'),
('A_W09_WEBP1_15','W09_WEBP1','S15','ST07','Present','2026-06-30'),
('A_W09_WEBP1_16','W09_WEBP1','S16','ST07','Present','2026-06-30'),
('A_W09_WEBP1_17','W09_WEBP1','S17','ST07','Absent','2026-06-30'),
('A_W09_WEBP1_18','W09_WEBP1','S18','ST07','Present','2026-06-30'),
('A_W09_WEBP1_19','W09_WEBP1','S19','ST07','Absent','2026-06-30'),
('A_W09_WEBP1_20','W09_WEBP1','S20','ST07','Present','2026-06-30'),
('A_W09_WEBP1_21','W09_WEBP1','S21','ST07','Absent','2026-06-30'),
('A_W09_WEBP1_22','W09_WEBP1','S22','ST07','Present','2026-06-30'),
('A_W09_WEBP1_23','W09_WEBP1','S23','ST07','Present','2026-06-30'),
('A_W09_WEBP1_24','W09_WEBP1','S24','ST07','Absent','2026-06-30'),
('A_W09_WEBP1_25','W09_WEBP1','S25','ST07','Present','2026-06-30'),

('A_W09_MAT_11','W09_MAT','S11','ST08','Present','2026-07-01'),
('A_W09_MAT_12','W09_MAT','S12','ST08','Present','2026-07-01'),
('A_W09_MAT_13','W09_MAT','S13','ST08','Absent','2026-07-01'),
('A_W09_MAT_14','W09_MAT','S14','ST08','Present','2026-07-01'),
('A_W09_MAT_15','W09_MAT','S15','ST08','Present','2026-07-01'),
('A_W09_MAT_16','W09_MAT','S16','ST08','Present','2026-07-01'),
('A_W09_MAT_17','W09_MAT','S17','ST08','Absent','2026-07-01'),
('A_W09_MAT_18','W09_MAT','S18','ST08','Present','2026-07-01'),
('A_W09_MAT_19','W09_MAT','S19','ST08','Absent','2026-07-01'),
('A_W09_MAT_20','W09_MAT','S20','ST08','Present','2026-07-01'),
('A_W09_MAT_21','W09_MAT','S21','ST08','Present','2026-07-01'),
('A_W09_MAT_22','W09_MAT','S22','ST08','Present','2026-07-01'),
('A_W09_MAT_23','W09_MAT','S23','ST08','Present','2026-07-01'),
('A_W09_MAT_24','W09_MAT','S24','ST08','Absent','2026-07-01'),
('A_W09_MAT_25','W09_MAT','S25','ST08','Present','2026-07-01'),

('A_W09_ENG_11','W09_ENG','S11','ST09','Present','2026-07-02'),
('A_W09_ENG_12','W09_ENG','S12','ST09','Present','2026-07-02'),
('A_W09_ENG_13','W09_ENG','S13','ST09','Absent','2026-07-02'),
('A_W09_ENG_14','W09_ENG','S14','ST09','Present','2026-07-02'),
('A_W09_ENG_15','W09_ENG','S15','ST09','Present','2026-07-02'),
('A_W09_ENG_16','W09_ENG','S16','ST09','Present','2026-07-02'),
('A_W09_ENG_17','W09_ENG','S17','ST09','Absent','2026-07-02'),
('A_W09_ENG_18','W09_ENG','S18','ST09','Present','2026-07-02'),
('A_W09_ENG_19','W09_ENG','S19','ST09','Absent','2026-07-02'),
('A_W09_ENG_20','W09_ENG','S20','ST09','Present','2026-07-02'),
('A_W09_ENG_21','W09_ENG','S21','ST09','Absent','2026-07-02'),
('A_W09_ENG_22','W09_ENG','S22','ST09','Present','2026-07-02'),
('A_W09_ENG_23','W09_ENG','S23','ST09','Present','2026-07-02'),
('A_W09_ENG_24','W09_ENG','S24','ST09','Absent','2026-07-02'),
('A_W09_ENG_25','W09_ENG','S25','ST09','Present','2026-07-02'),

('A_W09_DBS_11','W09_DBS','S11','ST10','Present','2026-07-02'),
('A_W09_DBS_12','W09_DBS','S12','ST10','Present','2026-07-02'),
('A_W09_DBS_13','W09_DBS','S13','ST10','Absent','2026-07-02'),
('A_W09_DBS_14','W09_DBS','S14','ST10','Present','2026-07-02'),
('A_W09_DBS_15','W09_DBS','S15','ST10','Present','2026-07-02'),
('A_W09_DBS_16','W09_DBS','S16','ST10','Present','2026-07-02'),
('A_W09_DBS_17','W09_DBS','S17','ST10','Present','2026-07-02'),
('A_W09_DBS_18','W09_DBS','S18','ST10','Present','2026-07-02'),
('A_W09_DBS_19','W09_DBS','S19','ST10','Present','2026-07-02'),
('A_W09_DBS_20','W09_DBS','S20','ST10','Present','2026-07-02'),
('A_W09_DBS_21','W09_DBS','S21','ST10','Absent','2026-07-02'),
('A_W09_DBS_22','W09_DBS','S22','ST10','Present','2026-07-02'),
('A_W09_DBS_23','W09_DBS','S23','ST10','Present','2026-07-02'),
('A_W09_DBS_24','W09_DBS','S24','ST10','Absent','2026-07-02'),
('A_W09_DBS_25','W09_DBS','S25','ST10','Present','2026-07-02'),

('A_W09_WEBP2_11','W09_WEBP2','S11','ST07','Present','2026-07-02'),
('A_W09_WEBP2_12','W09_WEBP2','S12','ST07','Present','2026-07-02'),
('A_W09_WEBP2_13','W09_WEBP2','S13','ST07','Absent','2026-07-02'),
('A_W09_WEBP2_14','W09_WEBP2','S14','ST07','Present','2026-07-02'),
('A_W09_WEBP2_15','W09_WEBP2','S15','ST07','Present','2026-07-02'),
('A_W09_WEBP2_16','W09_WEBP2','S16','ST07','Present','2026-07-02'),
('A_W09_WEBP2_17','W09_WEBP2','S17','ST07','Absent','2026-07-02'),
('A_W09_WEBP2_18','W09_WEBP2','S18','ST07','Present','2026-07-02'),
('A_W09_WEBP2_19','W09_WEBP2','S19','ST07','Absent','2026-07-02'),
('A_W09_WEBP2_20','W09_WEBP2','S20','ST07','Present','2026-07-02'),
('A_W09_WEBP2_21','W09_WEBP2','S21','ST07','Present','2026-07-02'),
('A_W09_WEBP2_22','W09_WEBP2','S22','ST07','Present','2026-07-02'),
('A_W09_WEBP2_23','W09_WEBP2','S23','ST07','Present','2026-07-02'),
('A_W09_WEBP2_24','W09_WEBP2','S24','ST07','Absent','2026-07-02'),
('A_W09_WEBP2_25','W09_WEBP2','S25','ST07','Present','2026-07-02'),

('A_W09_OSC_11','W09_OSC','S11','ST03','Present','2026-07-03'),
('A_W09_OSC_12','W09_OSC','S12','ST03','Present','2026-07-03'),
('A_W09_OSC_13','W09_OSC','S13','ST03','Absent','2026-07-03'),
('A_W09_OSC_14','W09_OSC','S14','ST03','Present','2026-07-03'),
('A_W09_OSC_15','W09_OSC','S15','ST03','Present','2026-07-03'),
('A_W09_OSC_16','W09_OSC','S16','ST03','Present','2026-07-03'),
('A_W09_OSC_17','W09_OSC','S17','ST03','Absent','2026-07-03'),
('A_W09_OSC_18','W09_OSC','S18','ST03','Present','2026-07-03'),
('A_W09_OSC_19','W09_OSC','S19','ST03','Absent','2026-07-03'),
('A_W09_OSC_20','W09_OSC','S20','ST03','Present','2026-07-03'),
('A_W09_OSC_21','W09_OSC','S21','ST03','Absent','2026-07-03'),
('A_W09_OSC_22','W09_OSC','S22','ST03','Present','2026-07-03'),
('A_W09_OSC_23','W09_OSC','S23','ST03','Present','2026-07-03'),
('A_W09_OSC_24','W09_OSC','S24','ST03','Present','2026-07-03'),
('A_W09_OSC_25','W09_OSC','S25','ST03','Present','2026-07-03'),

-- ================= WEEK 10 =================

('A_W10_MGT_11','W10_MGT','S11','ST03','Present','2026-07-06'),
('A_W10_MGT_12','W10_MGT','S12','ST03','Present','2026-07-06'),
('A_W10_MGT_13','W10_MGT','S13','ST03','Present','2026-07-06'),
('A_W10_MGT_14','W10_MGT','S14','ST03','Present','2026-07-06'),
('A_W10_MGT_15','W10_MGT','S15','ST03','Present','2026-07-06'),
('A_W10_MGT_16','W10_MGT','S16','ST03','Present','2026-07-06'),
('A_W10_MGT_17','W10_MGT','S17','ST03','Absent','2026-07-06'),
('A_W10_MGT_18','W10_MGT','S18','ST03','Present','2026-07-06'),
('A_W10_MGT_19','W10_MGT','S19','ST03','Absent','2026-07-06'),
('A_W10_MGT_20','W10_MGT','S20','ST03','Present','2026-07-06'),
('A_W10_MGT_21','W10_MGT','S21','ST03','Absent','2026-07-06'),
('A_W10_MGT_22','W10_MGT','S22','ST03','Present','2026-07-06'),
('A_W10_MGT_23','W10_MGT','S23','ST03','Present','2026-07-06'),
('A_W10_MGT_24','W10_MGT','S24','ST03','Absent','2026-07-06'),
('A_W10_MGT_25','W10_MGT','S25','ST03','Present','2026-07-06'),

('A_W10_LIN_11','W10_LIN','S11','ST04','Present','2026-07-06'),
('A_W10_LIN_12','W10_LIN','S12','ST04','Present','2026-07-06'),
('A_W10_LIN_13','W10_LIN','S13','ST04','Present','2026-07-06'),
('A_W10_LIN_14','W10_LIN','S14','ST04','Present','2026-07-06'),
('A_W10_LIN_15','W10_LIN','S15','ST04','Present','2026-07-06'),
('A_W10_LIN_16','W10_LIN','S16','ST04','Present','2026-07-06'),
('A_W10_LIN_17','W10_LIN','S17','ST04','Present','2026-07-06'),
('A_W10_LIN_18','W10_LIN','S18','ST04','Present','2026-07-06'),
('A_W10_LIN_19','W10_LIN','S19','ST04','Present','2026-07-06'),
('A_W10_LIN_20','W10_LIN','S20','ST04','Present','2026-07-06'),
('A_W10_LIN_21','W10_LIN','S21','ST04','Absent','2026-07-06'),
('A_W10_LIN_22','W10_LIN','S22','ST04','Present','2026-07-06'),
('A_W10_LIN_23','W10_LIN','S23','ST04','Present','2026-07-06'),
('A_W10_LIN_24','W10_LIN','S24','ST04','Absent','2026-07-06'),
('A_W10_LIN_25','W10_LIN','S25','ST04','Present','2026-07-06'),

('A_W10_DBP_11','W10_DBP','S11','ST05','Present','2026-07-07'),
('A_W10_DBP_12','W10_DBP','S12','ST05','Present','2026-07-07'),
('A_W10_DBP_13','W10_DBP','S13','ST05','Present','2026-07-07'),
('A_W10_DBP_14','W10_DBP','S14','ST05','Present','2026-07-07'),
('A_W10_DBP_15','W10_DBP','S15','ST05','Present','2026-07-07'),
('A_W10_DBP_16','W10_DBP','S16','ST05','Present','2026-07-07'),
('A_W10_DBP_17','W10_DBP','S17','ST05','Absent','2026-07-07'),
('A_W10_DBP_18','W10_DBP','S18','ST05','Present','2026-07-07'),
('A_W10_DBP_19','W10_DBP','S19','ST05','Absent','2026-07-07'),
('A_W10_DBP_20','W10_DBP','S20','ST05','Present','2026-07-07'),
('A_W10_DBP_21','W10_DBP','S21','ST05','Absent','2026-07-07'),
('A_W10_DBP_22','W10_DBP','S22','ST05','Present','2026-07-07'),
('A_W10_DBP_23','W10_DBP','S23','ST05','Present','2026-07-07'),
('A_W10_DBP_24','W10_DBP','S24','ST05','Absent','2026-07-07'),
('A_W10_DBP_25','W10_DBP','S25','ST05','Present','2026-07-07'),

('A_W10_WEBT_11','W10_WEBT','S11','ST06','Present','2026-07-07'),
('A_W10_WEBT_12','W10_WEBT','S12','ST06','Present','2026-07-07'),
('A_W10_WEBT_13','W10_WEBT','S13','ST06','Absent','2026-07-07'),
('A_W10_WEBT_14','W10_WEBT','S14','ST06','Present','2026-07-07'),
('A_W10_WEBT_15','W10_WEBT','S15','ST06','Present','2026-07-07'),
('A_W10_WEBT_16','W10_WEBT','S16','ST06','Present','2026-07-07'),
('A_W10_WEBT_17','W10_WEBT','S17','ST06','Present','2026-07-07'),
('A_W10_WEBT_18','W10_WEBT','S18','ST06','Present','2026-07-07'),
('A_W10_WEBT_19','W10_WEBT','S19','ST06','Present','2026-07-07'),
('A_W10_WEBT_20','W10_WEBT','S20','ST06','Present','2026-07-07'),
('A_W10_WEBT_21','W10_WEBT','S21','ST06','Absent','2026-07-07'),
('A_W10_WEBT_22','W10_WEBT','S22','ST06','Present','2026-07-07'),
('A_W10_WEBT_23','W10_WEBT','S23','ST06','Present','2026-07-07'),
('A_W10_WEBT_24','W10_WEBT','S24','ST06','Absent','2026-07-07'),
('A_W10_WEBT_25','W10_WEBT','S25','ST06','Present','2026-07-07'),

('A_W10_WEBP1_11','W10_WEBP1','S11','ST07','Present','2026-07-07'),
('A_W10_WEBP1_12','W10_WEBP1','S12','ST07','Present','2026-07-07'),
('A_W10_WEBP1_13','W10_WEBP1','S13','ST07','Absent','2026-07-07'),
('A_W10_WEBP1_14','W10_WEBP1','S14','ST07','Present','2026-07-07'),
('A_W10_WEBP1_15','W10_WEBP1','S15','ST07','Present','2026-07-07'),
('A_W10_WEBP1_16','W10_WEBP1','S16','ST07','Present','2026-07-07'),
('A_W10_WEBP1_17','W10_WEBP1','S17','ST07','Present','2026-07-07'),
('A_W10_WEBP1_18','W10_WEBP1','S18','ST07','Present','2026-07-07'),
('A_W10_WEBP1_19','W10_WEBP1','S19','ST07','Absent','2026-07-07'),
('A_W10_WEBP1_20','W10_WEBP1','S20','ST07','Present','2026-07-07'),
('A_W10_WEBP1_21','W10_WEBP1','S21','ST07','Present','2026-07-07'),
('A_W10_WEBP1_22','W10_WEBP1','S22','ST07','Present','2026-07-07'),
('A_W10_WEBP1_23','W10_WEBP1','S23','ST07','Present','2026-07-07'),
('A_W10_WEBP1_24','W10_WEBP1','S24','ST07','Absent','2026-07-07'),
('A_W10_WEBP1_25','W10_WEBP1','S25','ST07','Present','2026-07-07'),

('A_W10_MAT_11','W10_MAT','S11','ST08','Present','2026-07-08'),
('A_W10_MAT_12','W10_MAT','S12','ST08','Present','2026-07-08'),
('A_W10_MAT_13','W10_MAT','S13','ST08','Absent','2026-07-08'),
('A_W10_MAT_14','W10_MAT','S14','ST08','Present','2026-07-08'),
('A_W10_MAT_15','W10_MAT','S15','ST08','Present','2026-07-08'),
('A_W10_MAT_16','W10_MAT','S16','ST08','Present','2026-07-08'),
('A_W10_MAT_17','W10_MAT','S17','ST08','Present','2026-07-08'),
('A_W10_MAT_18','W10_MAT','S18','ST08','Present','2026-07-08'),
('A_W10_MAT_19','W10_MAT','S19','ST08','Absent','2026-07-08'),
('A_W10_MAT_20','W10_MAT','S20','ST08','Present','2026-07-08'),
('A_W10_MAT_21','W10_MAT','S21','ST08','Absent','2026-07-08'),
('A_W10_MAT_22','W10_MAT','S22','ST08','Present','2026-07-08'),
('A_W10_MAT_23','W10_MAT','S23','ST08','Present','2026-07-08'),
('A_W10_MAT_24','W10_MAT','S24','ST08','Present','2026-07-08'),
('A_W10_MAT_25','W10_MAT','S25','ST08','Present','2026-07-08'),

('A_W10_ENG_11','W10_ENG','S11','ST09','Present','2026-07-09'),
('A_W10_ENG_12','W10_ENG','S12','ST09','Present','2026-07-09'),
('A_W10_ENG_13','W10_ENG','S13','ST09','Present','2026-07-09'),
('A_W10_ENG_14','W10_ENG','S14','ST09','Present','2026-07-09'),
('A_W10_ENG_15','W10_ENG','S15','ST09','Present','2026-07-09'),
('A_W10_ENG_16','W10_ENG','S16','ST09','Present','2026-07-09'),
('A_W10_ENG_17','W10_ENG','S17','ST09','Absent','2026-07-09'),
('A_W10_ENG_18','W10_ENG','S18','ST09','Present','2026-07-09'),
('A_W10_ENG_19','W10_ENG','S19','ST09','Present','2026-07-09'),
('A_W10_ENG_20','W10_ENG','S20','ST09','Present','2026-07-09'),
('A_W10_ENG_21','W10_ENG','S21','ST09','Absent','2026-07-09'),
('A_W10_ENG_22','W10_ENG','S22','ST09','Present','2026-07-09'),
('A_W10_ENG_23','W10_ENG','S23','ST09','Present','2026-07-09'),
('A_W10_ENG_24','W10_ENG','S24','ST09','Absent','2026-07-09'),
('A_W10_ENG_25','W10_ENG','S25','ST09','Present','2026-07-09'),

('A_W10_DBS_11','W10_DBS','S11','ST10','Present','2026-07-09'),
('A_W10_DBS_12','W10_DBS','S12','ST10','Present','2026-07-09'),
('A_W10_DBS_13','W10_DBS','S13','ST10','Present','2026-07-09'),
('A_W10_DBS_14','W10_DBS','S14','ST10','Present','2026-07-09'),
('A_W10_DBS_15','W10_DBS','S15','ST10','Present','2026-07-09'),
('A_W10_DBS_16','W10_DBS','S16','ST10','Present','2026-07-09'),
('A_W10_DBS_17','W10_DBS','S17','ST10','Absent','2026-07-09'),
('A_W10_DBS_18','W10_DBS','S18','ST10','Present','2026-07-09'),
('A_W10_DBS_19','W10_DBS','S19','ST10','Absent','2026-07-09'),
('A_W10_DBS_20','W10_DBS','S20','ST10','Present','2026-07-09'),
('A_W10_DBS_21','W10_DBS','S21','ST10','Present','2026-07-09'),
('A_W10_DBS_22','W10_DBS','S22','ST10','Present','2026-07-09'),
('A_W10_DBS_23','W10_DBS','S23','ST10','Present','2026-07-09'),
('A_W10_DBS_24','W10_DBS','S24','ST10','Absent','2026-07-09'),
('A_W10_DBS_25','W10_DBS','S25','ST10','Present','2026-07-09'),

('A_W10_WEBP2_11','W10_WEBP2','S11','ST07','Present','2026-07-09'),
('A_W10_WEBP2_12','W10_WEBP2','S12','ST07','Present','2026-07-09'),
('A_W10_WEBP2_13','W10_WEBP2','S13','ST07','Absent','2026-07-09'),
('A_W10_WEBP2_14','W10_WEBP2','S14','ST07','Present','2026-07-09'),
('A_W10_WEBP2_15','W10_WEBP2','S15','ST07','Present','2026-07-09'),
('A_W10_WEBP2_16','W10_WEBP2','S16','ST07','Present','2026-07-09'),
('A_W10_WEBP2_17','W10_WEBP2','S17','ST07','Absent','2026-07-09'),
('A_W10_WEBP2_18','W10_WEBP2','S18','ST07','Present','2026-07-09'),
('A_W10_WEBP2_19','W10_WEBP2','S19','ST07','Absent','2026-07-09'),
('A_W10_WEBP2_20','W10_WEBP2','S20','ST07','Present','2026-07-09'),
('A_W10_WEBP2_21','W10_WEBP2','S21','ST07','Absent','2026-07-09'),
('A_W10_WEBP2_22','W10_WEBP2','S22','ST07','Present','2026-07-09'),
('A_W10_WEBP2_23','W10_WEBP2','S23','ST07','Present','2026-07-09'),
('A_W10_WEBP2_24','W10_WEBP2','S24','ST07','Present','2026-07-09'),
('A_W10_WEBP2_25','W10_WEBP2','S25','ST07','Present','2026-07-09'),

('A_W10_OSC_11','W10_OSC','S11','ST03','Present','2026-07-10'),
('A_W10_OSC_12','W10_OSC','S12','ST03','Present','2026-07-10'),
('A_W10_OSC_13','W10_OSC','S13','ST03','Absent','2026-07-10'),
('A_W10_OSC_14','W10_OSC','S14','ST03','Present','2026-07-10'),
('A_W10_OSC_15','W10_OSC','S15','ST03','Present','2026-07-10'),
('A_W10_OSC_16','W10_OSC','S16','ST03','Present','2026-07-10'),
('A_W10_OSC_17','W10_OSC','S17','ST03','Present','2026-07-10'),
('A_W10_OSC_18','W10_OSC','S18','ST03','Present','2026-07-10'),
('A_W10_OSC_19','W10_OSC','S19','ST03','Absent','2026-07-10'),
('A_W10_OSC_20','W10_OSC','S20','ST03','Present','2026-07-10'),
('A_W10_OSC_21','W10_OSC','S21','ST03','Absent','2026-07-10'),
('A_W10_OSC_22','W10_OSC','S22','ST03','Present','2026-07-10'),
('A_W10_OSC_23','W10_OSC','S23','ST03','Present','2026-07-10'),
('A_W10_OSC_24','W10_OSC','S24','ST03','Absent','2026-07-10'),
('A_W10_OSC_25','W10_OSC','S25','ST03','Present','2026-07-10');

INSERT INTO ATTENDANCE_RECORD (Attendance_ID, session_id, student_id, marked_by, attendance_status, marked_date) VALUES

-- ================= WEEK 11 =================

('A_W11_MGT_11','W11_MGT','S11','ST03','Present','2026-07-13'),
('A_W11_MGT_12','W11_MGT','S12','ST03','Absent','2026-07-13'),
('A_W11_MGT_13','W11_MGT','S13','ST03','Present','2026-07-13'),
('A_W11_MGT_14','W11_MGT','S14','ST03','Present','2026-07-13'),
('A_W11_MGT_15','W11_MGT','S15','ST03','Present','2026-07-13'),
('A_W11_MGT_16','W11_MGT','S16','ST03','Present','2026-07-13'),
('A_W11_MGT_17','W11_MGT','S17','ST03','Present','2026-07-13'),
('A_W11_MGT_18','W11_MGT','S18','ST03','Present','2026-07-13'),
('A_W11_MGT_19','W11_MGT','S19','ST03','Absent','2026-07-13'),
('A_W11_MGT_20','W11_MGT','S20','ST03','Present','2026-07-13'),
('A_W11_MGT_21','W11_MGT','S21','ST03','Absent','2026-07-13'),
('A_W11_MGT_22','W11_MGT','S22','ST03','Present','2026-07-13'),
('A_W11_MGT_23','W11_MGT','S23','ST03','Medical','2026-07-13'),
('A_W11_MGT_24','W11_MGT','S24','ST03','Present','2026-07-13'),
('A_W11_MGT_25','W11_MGT','S25','ST03','Present','2026-07-13'),

('A_W11_LIN_11','W11_LIN','S11','ST04','Present','2026-07-13'),
('A_W11_LIN_12','W11_LIN','S12','ST04','Present','2026-07-13'),
('A_W11_LIN_13','W11_LIN','S13','ST04','Present','2026-07-13'),
('A_W11_LIN_14','W11_LIN','S14','ST04','Present','2026-07-13'),
('A_W11_LIN_15','W11_LIN','S15','ST04','Present','2026-07-13'),
('A_W11_LIN_16','W11_LIN','S16','ST04','Present','2026-07-13'),
('A_W11_LIN_17','W11_LIN','S17','ST04','Absent','2026-07-13'),
('A_W11_LIN_18','W11_LIN','S18','ST04','Present','2026-07-13'),
('A_W11_LIN_19','W11_LIN','S19','ST04','Absent','2026-07-13'),
('A_W11_LIN_20','W11_LIN','S20','ST04','Present','2026-07-13'),
('A_W11_LIN_21','W11_LIN','S21','ST04','Absent','2026-07-13'),
('A_W11_LIN_22','W11_LIN','S22','ST04','Present','2026-07-13'),
('A_W11_LIN_23','W11_LIN','S23','ST04','Present','2026-07-13'),
('A_W11_LIN_24','W11_LIN','S24','ST04','Absent','2026-07-13'),
('A_W11_LIN_25','W11_LIN','S25','ST04','Present','2026-07-13'),

('A_W11_DBP_11','W11_DBP','S11','ST05','Present','2026-07-14'),
('A_W11_DBP_12','W11_DBP','S12','ST05','Present','2026-07-14'),
('A_W11_DBP_13','W11_DBP','S13','ST05','Absent','2026-07-14'),
('A_W11_DBP_14','W11_DBP','S14','ST05','Present','2026-07-14'),
('A_W11_DBP_15','W11_DBP','S15','ST05','Present','2026-07-14'),
('A_W11_DBP_16','W11_DBP','S16','ST05','Present','2026-07-14'),
('A_W11_DBP_17','W11_DBP','S17','ST05','Absent','2026-07-14'),
('A_W11_DBP_18','W11_DBP','S18','ST05','Present','2026-07-14'),
('A_W11_DBP_19','W11_DBP','S19','ST05','Absent','2026-07-14'),
('A_W11_DBP_20','W11_DBP','S20','ST05','Present','2026-07-14'),
('A_W11_DBP_21','W11_DBP','S21','ST05','Present','2026-07-14'),
('A_W11_DBP_22','W11_DBP','S22','ST05','Present','2026-07-14'),
('A_W11_DBP_23','W11_DBP','S23','ST05','Present','2026-07-14'),
('A_W11_DBP_24','W11_DBP','S24','ST05','Absent','2026-07-14'),
('A_W11_DBP_25','W11_DBP','S25','ST05','Present','2026-07-14'),

('A_W11_WEBT_11','W11_WEBT','S11','ST06','Present','2026-07-14'),
('A_W11_WEBT_12','W11_WEBT','S12','ST06','Present','2026-07-14'),
('A_W11_WEBT_13','W11_WEBT','S13','ST06','Present','2026-07-14'),
('A_W11_WEBT_14','W11_WEBT','S14','ST06','Present','2026-07-14'),
('A_W11_WEBT_15','W11_WEBT','S15','ST06','Present','2026-07-14'),
('A_W11_WEBT_16','W11_WEBT','S16','ST06','Present','2026-07-14'),
('A_W11_WEBT_17','W11_WEBT','S17','ST06','Absent','2026-07-14'),
('A_W11_WEBT_18','W11_WEBT','S18','ST06','Present','2026-07-14'),
('A_W11_WEBT_19','W11_WEBT','S19','ST06','Present','2026-07-14'),
('A_W11_WEBT_20','W11_WEBT','S20','ST06','Present','2026-07-14'),
('A_W11_WEBT_21','W11_WEBT','S21','ST06','Absent','2026-07-14'),
('A_W11_WEBT_22','W11_WEBT','S22','ST06','Medical','2026-07-14'),
('A_W11_WEBT_23','W11_WEBT','S23','ST06','Present','2026-07-14'),
('A_W11_WEBT_24','W11_WEBT','S24','ST06','Present','2026-07-14'),
('A_W11_WEBT_25','W11_WEBT','S25','ST06','Present','2026-07-14'),

('A_W11_WEBP1_11','W11_WEBP1','S11','ST07','Present','2026-07-14'),
('A_W11_WEBP1_12','W11_WEBP1','S12','ST07','Present','2026-07-14'),
('A_W11_WEBP1_13','W11_WEBP1','S13','ST07','Absent','2026-07-14'),
('A_W11_WEBP1_14','W11_WEBP1','S14','ST07','Present','2026-07-14'),
('A_W11_WEBP1_15','W11_WEBP1','S15','ST07','Present','2026-07-14'),
('A_W11_WEBP1_16','W11_WEBP1','S16','ST07','Present','2026-07-14'),
('A_W11_WEBP1_17','W11_WEBP1','S17','ST07','Absent','2026-07-14'),
('A_W11_WEBP1_18','W11_WEBP1','S18','ST07','Present','2026-07-14'),
('A_W11_WEBP1_19','W11_WEBP1','S19','ST07','Absent','2026-07-14'),
('A_W11_WEBP1_20','W11_WEBP1','S20','ST07','Present','2026-07-14'),
('A_W11_WEBP1_21','W11_WEBP1','S21','ST07','Present','2026-07-14'),
('A_W11_WEBP1_22','W11_WEBP1','S22','ST07','Present','2026-07-14'),
('A_W11_WEBP1_23','W11_WEBP1','S23','ST07','Present','2026-07-14'),
('A_W11_WEBP1_24','W11_WEBP1','S24','ST07','Absent','2026-07-14'),
('A_W11_WEBP1_25','W11_WEBP1','S25','ST07','Present','2026-07-14'),

('A_W11_MAT_11','W11_MAT','S11','ST08','Present','2026-07-15'),
('A_W11_MAT_12','W11_MAT','S12','ST08','Present','2026-07-15'),
('A_W11_MAT_13','W11_MAT','S13','ST08','Absent','2026-07-15'),
('A_W11_MAT_14','W11_MAT','S14','ST08','Present','2026-07-15'),
('A_W11_MAT_15','W11_MAT','S15','ST08','Present','2026-07-15'),
('A_W11_MAT_16','W11_MAT','S16','ST08','Present','2026-07-15'),
('A_W11_MAT_17','W11_MAT','S17','ST08','Absent','2026-07-15'),
('A_W11_MAT_18','W11_MAT','S18','ST08','Present','2026-07-15'),
('A_W11_MAT_19','W11_MAT','S19','ST08','Present','2026-07-15'),
('A_W11_MAT_20','W11_MAT','S20','ST08','Present','2026-07-15'),
('A_W11_MAT_21','W11_MAT','S21','ST08','Present','2026-07-15'),
('A_W11_MAT_22','W11_MAT','S22','ST08','Present','2026-07-15'),
('A_W11_MAT_23','W11_MAT','S23','ST08','Present','2026-07-15'),
('A_W11_MAT_24','W11_MAT','S24','ST08','Present','2026-07-15'),
('A_W11_MAT_25','W11_MAT','S25','ST08','Present','2026-07-15'),

('A_W11_ENG_11','W11_ENG','S11','ST09','Present','2026-07-16'),
('A_W11_ENG_12','W11_ENG','S12','ST09','Present','2026-07-16'),
('A_W11_ENG_13','W11_ENG','S13','ST09','Absent','2026-07-16'),
('A_W11_ENG_14','W11_ENG','S14','ST09','Present','2026-07-16'),
('A_W11_ENG_15','W11_ENG','S15','ST09','Absent','2026-07-16'),
('A_W11_ENG_16','W11_ENG','S16','ST09','Present','2026-07-16'),
('A_W11_ENG_17','W11_ENG','S17','ST09','Absent','2026-07-16'),
('A_W11_ENG_18','W11_ENG','S18','ST09','Present','2026-07-16'),
('A_W11_ENG_19','W11_ENG','S19','ST09','Absent','2026-07-16'),
('A_W11_ENG_20','W11_ENG','S20','ST09','Present','2026-07-16'),
('A_W11_ENG_21','W11_ENG','S21','ST09','Absent','2026-07-16'),
('A_W11_ENG_22','W11_ENG','S22','ST09','Present','2026-07-16'),
('A_W11_ENG_23','W11_ENG','S23','ST09','Present','2026-07-16'),
('A_W11_ENG_24','W11_ENG','S24','ST09','Absent','2026-07-16'),
('A_W11_ENG_25','W11_ENG','S25','ST09','Present','2026-07-16'),

('A_W11_DBS_11','W11_DBS','S11','ST10','Present','2026-07-16'),
('A_W11_DBS_12','W11_DBS','S12','ST10','Present','2026-07-16'),
('A_W11_DBS_13','W11_DBS','S13','ST10','Present','2026-07-16'),
('A_W11_DBS_14','W11_DBS','S14','ST10','Present','2026-07-16'),
('A_W11_DBS_15','W11_DBS','S15','ST10','Present','2026-07-16'),
('A_W11_DBS_16','W11_DBS','S16','ST10','Present','2026-07-16'),
('A_W11_DBS_17','W11_DBS','S17','ST10','Absent','2026-07-16'),
('A_W11_DBS_18','W11_DBS','S18','ST10','Present','2026-07-16'),
('A_W11_DBS_19','W11_DBS','S19','ST10','Absent','2026-07-16'),
('A_W11_DBS_20','W11_DBS','S20','ST10','Present','2026-07-16'),
('A_W11_DBS_21','W11_DBS','S21','ST10','Absent','2026-07-16'),
('A_W11_DBS_22','W11_DBS','S22','ST10','Present','2026-07-16'),
('A_W11_DBS_23','W11_DBS','S23','ST10','Present','2026-07-16'),
('A_W11_DBS_24','W11_DBS','S24','ST10','Absent','2026-07-16'),
('A_W11_DBS_25','W11_DBS','S25','ST10','Present','2026-07-16'),

('A_W11_WEBP2_11','W11_WEBP2','S11','ST07','Present','2026-07-16'),
('A_W11_WEBP2_12','W11_WEBP2','S12','ST07','Present','2026-07-16'),
('A_W11_WEBP2_13','W11_WEBP2','S13','ST07','Absent','2026-07-16'),
('A_W11_WEBP2_14','W11_WEBP2','S14','ST07','Present','2026-07-16'),
('A_W11_WEBP2_15','W11_WEBP2','S15','ST07','Present','2026-07-16'),
('A_W11_WEBP2_16','W11_WEBP2','S16','ST07','Present','2026-07-16'),
('A_W11_WEBP2_17','W11_WEBP2','S17','ST07','Present','2026-07-16'),
('A_W11_WEBP2_18','W11_WEBP2','S18','ST07','Present','2026-07-16'),
('A_W11_WEBP2_19','W11_WEBP2','S19','ST07','Present','2026-07-16'),
('A_W11_WEBP2_20','W11_WEBP2','S20','ST07','Present','2026-07-16'),
('A_W11_WEBP2_21','W11_WEBP2','S21','ST07','Present','2026-07-16'),
('A_W11_WEBP2_22','W11_WEBP2','S22','ST07','Present','2026-07-16'),
('A_W11_WEBP2_23','W11_WEBP2','S23','ST07','Present','2026-07-16'),
('A_W11_WEBP2_24','W11_WEBP2','S24','ST07','Present','2026-07-16'),
('A_W11_WEBP2_25','W11_WEBP2','S25','ST07','Present','2026-07-16'),

('A_W11_OSC_11','W11_OSC','S11','ST03','Present','2026-07-17'),
('A_W11_OSC_12','W11_OSC','S12','ST03','Present','2026-07-17'),
('A_W11_OSC_13','W11_OSC','S13','ST03','Absent','2026-07-17'),
('A_W11_OSC_14','W11_OSC','S14','ST03','Present','2026-07-17'),
('A_W11_OSC_15','W11_OSC','S15','ST03','Present','2026-07-17'),
('A_W11_OSC_16','W11_OSC','S16','ST03','Present','2026-07-17'),
('A_W11_OSC_17','W11_OSC','S17','ST03','Present','2026-07-17'),
('A_W11_OSC_18','W11_OSC','S18','ST03','Present','2026-07-17'),
('A_W11_OSC_19','W11_OSC','S19','ST03','Absent','2026-07-17'),
('A_W11_OSC_20','W11_OSC','S20','ST03','Present','2026-07-17'),
('A_W11_OSC_21','W11_OSC','S21','ST03','Present','2026-07-17'),
('A_W11_OSC_22','W11_OSC','S22','ST03','Present','2026-07-17'),
('A_W11_OSC_23','W11_OSC','S23','ST03','Present','2026-07-17'),
('A_W11_OSC_24','W11_OSC','S24','ST03','Absent','2026-07-17'),
('A_W11_OSC_25','W11_OSC','S25','ST03','Present','2026-07-17'),

-- ================= WEEK 12 =================

('A_W12_MGT_11','W12_MGT','S11','ST03','Present','2026-07-20'),
('A_W12_MGT_12','W12_MGT','S12','ST03','Present','2026-07-20'),
('A_W12_MGT_13','W12_MGT','S13','ST03','Present','2026-07-20'),
('A_W12_MGT_14','W12_MGT','S14','ST03','Present','2026-07-20'),
('A_W12_MGT_15','W12_MGT','S15','ST03','Present','2026-07-20'),
('A_W12_MGT_16','W12_MGT','S16','ST03','Present','2026-07-20'),
('A_W12_MGT_17','W12_MGT','S17','ST03','Absent','2026-07-20'),
('A_W12_MGT_18','W12_MGT','S18','ST03','Present','2026-07-20'),
('A_W12_MGT_19','W12_MGT','S19','ST03','Present','2026-07-20'),
('A_W12_MGT_20','W12_MGT','S20','ST03','Present','2026-07-20'),
('A_W12_MGT_21','W12_MGT','S21','ST03','Present','2026-07-20'),
('A_W12_MGT_22','W12_MGT','S22','ST03','Present','2026-07-20'),
('A_W12_MGT_23','W12_MGT','S23','ST03','Present','2026-07-20'),
('A_W12_MGT_24','W12_MGT','S24','ST03','Absent','2026-07-20'),
('A_W12_MGT_25','W12_MGT','S25','ST03','Medical','2026-07-20'),

('A_W12_LIN_11','W12_LIN','S11','ST04','Present','2026-07-20'),
('A_W12_LIN_12','W12_LIN','S12','ST04','Present','2026-07-20'),
('A_W12_LIN_13','W12_LIN','S13','ST04','Present','2026-07-20'),
('A_W12_LIN_14','W12_LIN','S14','ST04','Present','2026-07-20'),
('A_W12_LIN_15','W12_LIN','S15','ST04','Present','2026-07-20'),
('A_W12_LIN_16','W12_LIN','S16','ST04','Present','2026-07-20'),
('A_W12_LIN_17','W12_LIN','S17','ST04','Present','2026-07-20'),
('A_W12_LIN_18','W12_LIN','S18','ST04','Present','2026-07-20'),
('A_W12_LIN_19','W12_LIN','S19','ST04','Absent','2026-07-20'),
('A_W12_LIN_20','W12_LIN','S20','ST04','Present','2026-07-20'),
('A_W12_LIN_21','W12_LIN','S21','ST04','Absent','2026-07-20'),
('A_W12_LIN_22','W12_LIN','S22','ST04','Present','2026-07-20'),
('A_W12_LIN_23','W12_LIN','S23','ST04','Present','2026-07-20'),
('A_W12_LIN_24','W12_LIN','S24','ST04','Absent','2026-07-20'),
('A_W12_LIN_25','W12_LIN','S25','ST04','Present','2026-07-20'),

('A_W12_DBP_11','W12_DBP','S11','ST05','Present','2026-07-21'),
('A_W12_DBP_12','W12_DBP','S12','ST05','Present','2026-07-21'),
('A_W12_DBP_13','W12_DBP','S13','ST05','Present','2026-07-21'),
('A_W12_DBP_14','W12_DBP','S14','ST05','Present','2026-07-21'),
('A_W12_DBP_15','W12_DBP','S15','ST05','Present','2026-07-21'),
('A_W12_DBP_16','W12_DBP','S16','ST05','Present','2026-07-21'),
('A_W12_DBP_17','W12_DBP','S17','ST05','Present','2026-07-21'),
('A_W12_DBP_18','W12_DBP','S18','ST05','Present','2026-07-21'),
('A_W12_DBP_19','W12_DBP','S19','ST05','Absent','2026-07-21'),
('A_W12_DBP_20','W12_DBP','S20','ST05','Present','2026-07-21'),
('A_W12_DBP_21','W12_DBP','S21','ST05','Absent','2026-07-21'),
('A_W12_DBP_22','W12_DBP','S22','ST05','Present','2026-07-21'),
('A_W12_DBP_23','W12_DBP','S23','ST05','Present','2026-07-21'),
('A_W12_DBP_24','W12_DBP','S24','ST05','Absent','2026-07-21'),
('A_W12_DBP_25','W12_DBP','S25','ST05','Present','2026-07-21'),

('A_W12_WEBT_11','W12_WEBT','S11','ST06','Present','2026-07-21'),
('A_W12_WEBT_12','W12_WEBT','S12','ST06','Absent','2026-07-21'),
('A_W12_WEBT_13','W12_WEBT','S13','ST06','Absent','2026-07-21'),
('A_W12_WEBT_14','W12_WEBT','S14','ST06','Present','2026-07-21'),
('A_W12_WEBT_15','W12_WEBT','S15','ST06','Present','2026-07-21'),
('A_W12_WEBT_16','W12_WEBT','S16','ST06','Present','2026-07-21'),
('A_W12_WEBT_17','W12_WEBT','S17','ST06','Absent','2026-07-21'),
('A_W12_WEBT_18','W12_WEBT','S18','ST06','Present','2026-07-21'),
('A_W12_WEBT_19','W12_WEBT','S19','ST06','Absent','2026-07-21'),
('A_W12_WEBT_20','W12_WEBT','S20','ST06','Medical','2026-07-21'),
('A_W12_WEBT_21','W12_WEBT','S21','ST06','Present','2026-07-21'),
('A_W12_WEBT_22','W12_WEBT','S22','ST06','Present','2026-07-21'),
('A_W12_WEBT_23','W12_WEBT','S23','ST06','Absent','2026-07-21'),
('A_W12_WEBT_24','W12_WEBT','S24','ST06','Absent','2026-07-21'),
('A_W12_WEBT_25','W12_WEBT','S25','ST06','Present','2026-07-21'),

('A_W12_WEBP1_11','W12_WEBP1','S11','ST07','Present','2026-07-21'),
('A_W12_WEBP1_12','W12_WEBP1','S12','ST07','Present','2026-07-21'),
('A_W12_WEBP1_13','W12_WEBP1','S13','ST07','Present','2026-07-21'),
('A_W12_WEBP1_14','W12_WEBP1','S14','ST07','Present','2026-07-21'),
('A_W12_WEBP1_15','W12_WEBP1','S15','ST07','Present','2026-07-21'),
('A_W12_WEBP1_16','W12_WEBP1','S16','ST07','Present','2026-07-21'),
('A_W12_WEBP1_17','W12_WEBP1','S17','ST07','Present','2026-07-21'),
('A_W12_WEBP1_18','W12_WEBP1','S18','ST07','Present','2026-07-21'),
('A_W12_WEBP1_19','W12_WEBP1','S19','ST07','Present','2026-07-21'),
('A_W12_WEBP1_20','W12_WEBP1','S20','ST07','Present','2026-07-21'),
('A_W12_WEBP1_21','W12_WEBP1','S21','ST07','Present','2026-07-21'),
('A_W12_WEBP1_22','W12_WEBP1','S22','ST07','Present','2026-07-21'),
('A_W12_WEBP1_23','W12_WEBP1','S23','ST07','Medical','2026-07-21'),
('A_W12_WEBP1_24','W12_WEBP1','S24','ST07','Present','2026-07-21'),
('A_W12_WEBP1_25','W12_WEBP1','S25','ST07','Present','2026-07-21'),

('A_W12_MAT_11','W12_MAT','S11','ST08','Present','2026-07-22'),
('A_W12_MAT_12','W12_MAT','S12','ST08','Present','2026-07-22'),
('A_W12_MAT_13','W12_MAT','S13','ST08','Absent','2026-07-22'),
('A_W12_MAT_14','W12_MAT','S14','ST08','Present','2026-07-22'),
('A_W12_MAT_15','W12_MAT','S15','ST08','Present','2026-07-22'),
('A_W12_MAT_16','W12_MAT','S16','ST08','Present','2026-07-22'),
('A_W12_MAT_17','W12_MAT','S17','ST08','Absent','2026-07-22'),
('A_W12_MAT_18','W12_MAT','S18','ST08','Present','2026-07-22'),
('A_W12_MAT_19','W12_MAT','S19','ST08','Present','2026-07-22'),
('A_W12_MAT_20','W12_MAT','S20','ST08','Present','2026-07-22'),
('A_W12_MAT_21','W12_MAT','S21','ST08','Absent','2026-07-22'),
('A_W12_MAT_22','W12_MAT','S22','ST08','Present','2026-07-22'),
('A_W12_MAT_23','W12_MAT','S23','ST08','Present','2026-07-22'),
('A_W12_MAT_24','W12_MAT','S24','ST08','Present','2026-07-22'),
('A_W12_MAT_25','W12_MAT','S25','ST08','Present','2026-07-22'),

('A_W12_ENG_11','W12_ENG','S11','ST09','Present','2026-07-23'),
('A_W12_ENG_12','W12_ENG','S12','ST09','Present','2026-07-23'),
('A_W12_ENG_13','W12_ENG','S13','ST09','Absent','2026-07-23'),
('A_W12_ENG_14','W12_ENG','S14','ST09','Present','2026-07-23'),
('A_W12_ENG_15','W12_ENG','S15','ST09','Medical','2026-07-23'),
('A_W12_ENG_16','W12_ENG','S16','ST09','Present','2026-07-23'),
('A_W12_ENG_17','W12_ENG','S17','ST09','Absent','2026-07-23'),
('A_W12_ENG_18','W12_ENG','S18','ST09','Present','2026-07-23'),
('A_W12_ENG_19','W12_ENG','S19','ST09','Present','2026-07-23'),
('A_W12_ENG_20','W12_ENG','S20','ST09','Present','2026-07-23'),
('A_W12_ENG_21','W12_ENG','S21','ST09','Absent','2026-07-23'),
('A_W12_ENG_22','W12_ENG','S22','ST09','Present','2026-07-23'),
('A_W12_ENG_23','W12_ENG','S23','ST09','Present','2026-07-23'),
('A_W12_ENG_24','W12_ENG','S24','ST09','Present','2026-07-23'),
('A_W12_ENG_25','W12_ENG','S25','ST09','Present','2026-07-23'),

('A_W12_DBS_11','W12_DBS','S11','ST10','Present','2026-07-23'),
('A_W12_DBS_12','W12_DBS','S12','ST10','Medical','2026-07-23'),
('A_W12_DBS_13','W12_DBS','S13','ST10','Absent','2026-07-23'),
('A_W12_DBS_14','W12_DBS','S14','ST10','Present','2026-07-23'),
('A_W12_DBS_15','W12_DBS','S15','ST10','Medical','2026-07-23'),
('A_W12_DBS_16','W12_DBS','S16','ST10','Present','2026-07-23'),
('A_W12_DBS_17','W12_DBS','S17','ST10','Present','2026-07-23'),
('A_W12_DBS_18','W12_DBS','S18','ST10','Present','2026-07-23'),
('A_W12_DBS_19','W12_DBS','S19','ST10','Absent','2026-07-23'),
('A_W12_DBS_20','W12_DBS','S20','ST10','Present','2026-07-23'),
('A_W12_DBS_21','W12_DBS','S21','ST10','Present','2026-07-23'),
('A_W12_DBS_22','W12_DBS','S22','ST10','Present','2026-07-23'),
('A_W12_DBS_23','W12_DBS','S23','ST10','Present','2026-07-23'),
('A_W12_DBS_24','W12_DBS','S24','ST10','Absent','2026-07-23'),
('A_W12_DBS_25','W12_DBS','S25','ST10','Present','2026-07-23'),

('A_W12_WEBP2_11','W12_WEBP2','S11','ST07','Present','2026-07-23'),
('A_W12_WEBP2_12','W12_WEBP2','S12','ST07','Present','2026-07-23'),
('A_W12_WEBP2_13','W12_WEBP2','S13','ST07','Absent','2026-07-23'),
('A_W12_WEBP2_14','W12_WEBP2','S14','ST07','Present','2026-07-23'),
('A_W12_WEBP2_15','W12_WEBP2','S15','ST07','Absent','2026-07-23'),
('A_W12_WEBP2_16','W12_WEBP2','S16','ST07','Present','2026-07-23'),
('A_W12_WEBP2_17','W12_WEBP2','S17','ST07','Present','2026-07-23'),
('A_W12_WEBP2_18','W12_WEBP2','S18','ST07','Present','2026-07-23'),
('A_W12_WEBP2_19','W12_WEBP2','S19','ST07','Present','2026-07-23'),
('A_W12_WEBP2_20','W12_WEBP2','S20','ST07','Present','2026-07-23'),
('A_W12_WEBP2_21','W12_WEBP2','S21','ST07','Present','2026-07-23'),
('A_W12_WEBP2_22','W12_WEBP2','S22','ST07','Present','2026-07-23'),
('A_W12_WEBP2_23','W12_WEBP2','S23','ST07','Present','2026-07-23'),
('A_W12_WEBP2_24','W12_WEBP2','S24','ST07','Present','2026-07-23'),
('A_W12_WEBP2_25','W12_WEBP2','S25','ST07','Present','2026-07-23'),

('A_W12_OSC_11','W12_OSC','S11','ST03','Present','2026-07-24'),
('A_W12_OSC_12','W12_OSC','S12','ST03','Present','2026-07-24'),
('A_W12_OSC_13','W12_OSC','S13','ST03','Absent','2026-07-24'),
('A_W12_OSC_14','W12_OSC','S14','ST03','Present','2026-07-24'),
('A_W12_OSC_15','W12_OSC','S15','ST03','Present','2026-07-24'),
('A_W12_OSC_16','W12_OSC','S16','ST03','Absent','2026-07-24'),
('A_W12_OSC_17','W12_OSC','S17','ST03','Absent','2026-07-24'),
('A_W12_OSC_18','W12_OSC','S18','ST03','Present','2026-07-24'),
('A_W12_OSC_19','W12_OSC','S19','ST03','Absent','2026-07-24'),
('A_W12_OSC_20','W12_OSC','S20','ST03','Present','2026-07-24'),
('A_W12_OSC_21','W12_OSC','S21','ST03','Present','2026-07-24'),
('A_W12_OSC_22','W12_OSC','S22','ST03','Present','2026-07-24'),
('A_W12_OSC_23','W12_OSC','S23','ST03','Present','2026-07-24'),
('A_W12_OSC_24','W12_OSC','S24','ST03','Absent','2026-07-24'),
('A_W12_OSC_25','W12_OSC','S25','ST03','Present','2026-07-24'),

-- ================= WEEK 13 =================

('A_W13_MGT_11','W13_MGT','S11','ST03','Present','2026-07-27'),
('A_W13_MGT_12','W13_MGT','S12','ST03','Present','2026-07-27'),
('A_W13_MGT_13','W13_MGT','S13','ST03','Absent','2026-07-27'),
('A_W13_MGT_14','W13_MGT','S14','ST03','Present','2026-07-27'),
('A_W13_MGT_15','W13_MGT','S15','ST03','Present','2026-07-27'),
('A_W13_MGT_16','W13_MGT','S16','ST03','Present','2026-07-27'),
('A_W13_MGT_17','W13_MGT','S17','ST03','Absent','2026-07-27'),
('A_W13_MGT_18','W13_MGT','S18','ST03','Present','2026-07-27'),
('A_W13_MGT_19','W13_MGT','S19','ST03','Absent','2026-07-27'),
('A_W13_MGT_20','W13_MGT','S20','ST03','Present','2026-07-27'),
('A_W13_MGT_21','W13_MGT','S21','ST03','Absent','2026-07-27'),
('A_W13_MGT_22','W13_MGT','S22','ST03','Present','2026-07-27'),
('A_W13_MGT_23','W13_MGT','S23','ST03','Present','2026-07-27'),
('A_W13_MGT_24','W13_MGT','S24','ST03','Present','2026-07-27'),
('A_W13_MGT_25','W13_MGT','S25','ST03','Present','2026-07-27'),

('A_W13_LIN_11','W13_LIN','S11','ST04','Present','2026-07-27'),
('A_W13_LIN_12','W13_LIN','S12','ST04','Present','2026-07-27'),
('A_W13_LIN_13','W13_LIN','S13','ST04','Absent','2026-07-27'),
('A_W13_LIN_14','W13_LIN','S14','ST04','Present','2026-07-27'),
('A_W13_LIN_15','W13_LIN','S15','ST04','Present','2026-07-27'),
('A_W13_LIN_16','W13_LIN','S16','ST04','Present','2026-07-27'),
('A_W13_LIN_17','W13_LIN','S17','ST04','Absent','2026-07-27'),
('A_W13_LIN_18','W13_LIN','S18','ST04','Present','2026-07-27'),
('A_W13_LIN_19','W13_LIN','S19','ST04','Absent','2026-07-27'),
('A_W13_LIN_20','W13_LIN','S20','ST04','Present','2026-07-27'),
('A_W13_LIN_21','W13_LIN','S21','ST04','Absent','2026-07-27'),
('A_W13_LIN_22','W13_LIN','S22','ST04','Absent','2026-07-27'),
('A_W13_LIN_23','W13_LIN','S23','ST04','Present','2026-07-27'),
('A_W13_LIN_24','W13_LIN','S24','ST04','Absent','2026-07-27'),
('A_W13_LIN_25','W13_LIN','S25','ST04','Present','2026-07-27'),

('A_W13_DBP_11','W13_DBP','S11','ST05','Present','2026-07-28'),
('A_W13_DBP_12','W13_DBP','S12','ST05','Present','2026-07-28'),
('A_W13_DBP_13','W13_DBP','S13','ST05','Absent','2026-07-28'),
('A_W13_DBP_14','W13_DBP','S14','ST05','Present','2026-07-28'),
('A_W13_DBP_15','W13_DBP','S15','ST05','Present','2026-07-28'),
('A_W13_DBP_16','W13_DBP','S16','ST05','Present','2026-07-28'),
('A_W13_DBP_17','W13_DBP','S17','ST05','Absent','2026-07-28'),
('A_W13_DBP_18','W13_DBP','S18','ST05','Absent','2026-07-28'),
('A_W13_DBP_19','W13_DBP','S19','ST05','Absent','2026-07-28'),
('A_W13_DBP_20','W13_DBP','S20','ST05','Absent','2026-07-28'),
('A_W13_DBP_21','W13_DBP','S21','ST05','Present','2026-07-28'),
('A_W13_DBP_22','W13_DBP','S22','ST05','Present','2026-07-28'),
('A_W13_DBP_23','W13_DBP','S23','ST05','Present','2026-07-28'),
('A_W13_DBP_24','W13_DBP','S24','ST05','Absent','2026-07-28'),
('A_W13_DBP_25','W13_DBP','S25','ST05','Present','2026-07-28'),

('A_W13_WEBT_11','W13_WEBT','S11','ST06','Present','2026-07-28'),
('A_W13_WEBT_12','W13_WEBT','S12','ST06','Present','2026-07-28'),
('A_W13_WEBT_13','W13_WEBT','S13','ST06','Present','2026-07-28'),
('A_W13_WEBT_14','W13_WEBT','S14','ST06','Present','2026-07-28'),
('A_W13_WEBT_15','W13_WEBT','S15','ST06','Present','2026-07-28'),
('A_W13_WEBT_16','W13_WEBT','S16','ST06','Present','2026-07-28'),
('A_W13_WEBT_17','W13_WEBT','S17','ST06','Absent','2026-07-28'),
('A_W13_WEBT_18','W13_WEBT','S18','ST06','Present','2026-07-28'),
('A_W13_WEBT_19','W13_WEBT','S19','ST06','Absent','2026-07-28'),
('A_W13_WEBT_20','W13_WEBT','S20','ST06','Present','2026-07-28'),
('A_W13_WEBT_21','W13_WEBT','S21','ST06','Absent','2026-07-28'),
('A_W13_WEBT_22','W13_WEBT','S22','ST06','Present','2026-07-28'),
('A_W13_WEBT_23','W13_WEBT','S23','ST06','Present','2026-07-28'),
('A_W13_WEBT_24','W13_WEBT','S24','ST06','Absent','2026-07-28'),
('A_W13_WEBT_25','W13_WEBT','S25','ST06','Present','2026-07-28'),

('A_W13_WEBP1_11','W13_WEBP1','S11','ST07','Present','2026-07-28'),
('A_W13_WEBP1_12','W13_WEBP1','S12','ST07','Medical','2026-07-28'),
('A_W13_WEBP1_13','W13_WEBP1','S13','ST07','Absent','2026-07-28'),
('A_W13_WEBP1_14','W13_WEBP1','S14','ST07','Present','2026-07-28'),
('A_W13_WEBP1_15','W13_WEBP1','S15','ST07','Present','2026-07-28'),
('A_W13_WEBP1_16','W13_WEBP1','S16','ST07','Present','2026-07-28'),
('A_W13_WEBP1_17','W13_WEBP1','S17','ST07','Present','2026-07-28'),
('A_W13_WEBP1_18','W13_WEBP1','S18','ST07','Present','2026-07-28'),
('A_W13_WEBP1_19','W13_WEBP1','S19','ST07','Absent','2026-07-28'),
('A_W13_WEBP1_20','W13_WEBP1','S20','ST07','Present','2026-07-28'),
('A_W13_WEBP1_21','W13_WEBP1','S21','ST07','Present','2026-07-28'),
('A_W13_WEBP1_22','W13_WEBP1','S22','ST07','Present','2026-07-28'),
('A_W13_WEBP1_23','W13_WEBP1','S23','ST07','Present','2026-07-28'),
('A_W13_WEBP1_24','W13_WEBP1','S24','ST07','Present','2026-07-28'),
('A_W13_WEBP1_25','W13_WEBP1','S25','ST07','Present','2026-07-28'),

('A_W13_MAT_11','W13_MAT','S11','ST08','Present','2026-07-29'),
('A_W13_MAT_12','W13_MAT','S12','ST08','Present','2026-07-29'),
('A_W13_MAT_13','W13_MAT','S13','ST08','Absent','2026-07-29'),
('A_W13_MAT_14','W13_MAT','S14','ST08','Present','2026-07-29'),
('A_W13_MAT_15','W13_MAT','S15','ST08','Present','2026-07-29'),
('A_W13_MAT_16','W13_MAT','S16','ST08','Present','2026-07-29'),
('A_W13_MAT_17','W13_MAT','S17','ST08','Absent','2026-07-29'),
('A_W13_MAT_18','W13_MAT','S18','ST08','Present','2026-07-29'),
('A_W13_MAT_19','W13_MAT','S19','ST08','Absent','2026-07-29'),
('A_W13_MAT_20','W13_MAT','S20','ST08','Present','2026-07-29'),
('A_W13_MAT_21','W13_MAT','S21','ST08','Present','2026-07-29'),
('A_W13_MAT_22','W13_MAT','S22','ST08','Present','2026-07-29'),
('A_W13_MAT_23','W13_MAT','S23','ST08','Present','2026-07-29'),
('A_W13_MAT_24','W13_MAT','S24','ST08','Absent','2026-07-29'),
('A_W13_MAT_25','W13_MAT','S25','ST08','Present','2026-07-29'),

('A_W13_ENG_11','W13_ENG','S11','ST09','Present','2026-07-30'),
('A_W13_ENG_12','W13_ENG','S12','ST09','Present','2026-07-30'),
('A_W13_ENG_13','W13_ENG','S13','ST09','Absent','2026-07-30'),
('A_W13_ENG_14','W13_ENG','S14','ST09','Present','2026-07-30'),
('A_W13_ENG_15','W13_ENG','S15','ST09','Present','2026-07-30'),
('A_W13_ENG_16','W13_ENG','S16','ST09','Absent','2026-07-30'),
('A_W13_ENG_17','W13_ENG','S17','ST09','Absent','2026-07-30'),
('A_W13_ENG_18','W13_ENG','S18','ST09','Present','2026-07-30'),
('A_W13_ENG_19','W13_ENG','S19','ST09','Absent','2026-07-30'),
('A_W13_ENG_20','W13_ENG','S20','ST09','Medical','2026-07-30'),
('A_W13_ENG_21','W13_ENG','S21','ST09','Absent','2026-07-30'),
('A_W13_ENG_22','W13_ENG','S22','ST09','Present','2026-07-30'),
('A_W13_ENG_23','W13_ENG','S23','ST09','Present','2026-07-30'),
('A_W13_ENG_24','W13_ENG','S24','ST09','Absent','2026-07-30'),
('A_W13_ENG_25','W13_ENG','S25','ST09','Present','2026-07-30'),

('A_W13_DBS_11','W13_DBS','S11','ST10','Present','2026-07-30'),
('A_W13_DBS_12','W13_DBS','S12','ST10','Present','2026-07-30'),
('A_W13_DBS_13','W13_DBS','S13','ST10','Present','2026-07-30'),
('A_W13_DBS_14','W13_DBS','S14','ST10','Present','2026-07-30'),
('A_W13_DBS_15','W13_DBS','S15','ST10','Present','2026-07-30'),
('A_W13_DBS_16','W13_DBS','S16','ST10','Present','2026-07-30'),
('A_W13_DBS_17','W13_DBS','S17','ST10','Present','2026-07-30'),
('A_W13_DBS_18','W13_DBS','S18','ST10','Present','2026-07-30'),
('A_W13_DBS_19','W13_DBS','S19','ST10','Absent','2026-07-30'),
('A_W13_DBS_20','W13_DBS','S20','ST10','Absent','2026-07-30'),
('A_W13_DBS_21','W13_DBS','S21','ST10','Absent','2026-07-30'),
('A_W13_DBS_22','W13_DBS','S22','ST10','Present','2026-07-30'),
('A_W13_DBS_23','W13_DBS','S23','ST10','Present','2026-07-30'),
('A_W13_DBS_24','W13_DBS','S24','ST10','Absent','2026-07-30'),
('A_W13_DBS_25','W13_DBS','S25','ST10','Present','2026-07-30'),

('A_W13_WEBP2_11','W13_WEBP2','S11','ST07','Present','2026-07-30'),
('A_W13_WEBP2_12','W13_WEBP2','S12','ST07','Present','2026-07-30'),
('A_W13_WEBP2_13','W13_WEBP2','S13','ST07','Absent','2026-07-30'),
('A_W13_WEBP2_14','W13_WEBP2','S14','ST07','Present','2026-07-30'),
('A_W13_WEBP2_15','W13_WEBP2','S15','ST07','Present','2026-07-30'),
('A_W13_WEBP2_16','W13_WEBP2','S16','ST07','Present','2026-07-30'),
('A_W13_WEBP2_17','W13_WEBP2','S17','ST07','Present','2026-07-30'),
('A_W13_WEBP2_18','W13_WEBP2','S18','ST07','Present','2026-07-30'),
('A_W13_WEBP2_19','W13_WEBP2','S19','ST07','Absent','2026-07-30'),
('A_W13_WEBP2_20','W13_WEBP2','S20','ST07','Present','2026-07-30'),
('A_W13_WEBP2_21','W13_WEBP2','S21','ST07','Present','2026-07-30'),
('A_W13_WEBP2_22','W13_WEBP2','S22','ST07','Present','2026-07-30'),
('A_W13_WEBP2_23','W13_WEBP2','S23','ST07','Present','2026-07-30'),
('A_W13_WEBP2_24','W13_WEBP2','S24','ST07','Present','2026-07-30'),
('A_W13_WEBP2_25','W13_WEBP2','S25','ST07','Present','2026-07-30'),

('A_W13_OSC_11','W13_OSC','S11','ST03','Present','2026-07-31'),
('A_W13_OSC_12','W13_OSC','S12','ST03','Present','2026-07-31'),
('A_W13_OSC_13','W13_OSC','S13','ST03','Absent','2026-07-31'),
('A_W13_OSC_14','W13_OSC','S14','ST03','Present','2026-07-31'),
('A_W13_OSC_15','W13_OSC','S15','ST03','Present','2026-07-31'),
('A_W13_OSC_16','W13_OSC','S16','ST03','Present','2026-07-31'),
('A_W13_OSC_17','W13_OSC','S17','ST03','Absent','2026-07-31'),
('A_W13_OSC_18','W13_OSC','S18','ST03','Present','2026-07-31'),
('A_W13_OSC_19','W13_OSC','S19','ST03','Present','2026-07-31'),
('A_W13_OSC_20','W13_OSC','S20','ST03','Absent','2026-07-31'),
('A_W13_OSC_21','W13_OSC','S21','ST03','Absent','2026-07-31'),
('A_W13_OSC_22','W13_OSC','S22','ST03','Present','2026-07-31'),
('A_W13_OSC_23','W13_OSC','S23','ST03','Present','2026-07-31'),
('A_W13_OSC_24','W13_OSC','S24','ST03','Absent','2026-07-31'),
('A_W13_OSC_25','W13_OSC','S25','ST03','Medical','2026-07-31'),

-- ================= WEEK 14 =================

('A_W14_MGT_11','W14_MGT','S11','ST03','Present','2026-08-03'),
('A_W14_MGT_12','W14_MGT','S12','ST03','Present','2026-08-03'),
('A_W14_MGT_13','W14_MGT','S13','ST03','Present','2026-08-03'),
('A_W14_MGT_14','W14_MGT','S14','ST03','Present','2026-08-03'),
('A_W14_MGT_15','W14_MGT','S15','ST03','Present','2026-08-03'),
('A_W14_MGT_16','W14_MGT','S16','ST03','Present','2026-08-03'),
('A_W14_MGT_17','W14_MGT','S17','ST03','Absent','2026-08-03'),
('A_W14_MGT_18','W14_MGT','S18','ST03','Present','2026-08-03'),
('A_W14_MGT_19','W14_MGT','S19','ST03','Present','2026-08-03'),
('A_W14_MGT_20','W14_MGT','S20','ST03','Present','2026-08-03'),
('A_W14_MGT_21','W14_MGT','S21','ST03','Present','2026-08-03'),
('A_W14_MGT_22','W14_MGT','S22','ST03','Present','2026-08-03'),
('A_W14_MGT_23','W14_MGT','S23','ST03','Present','2026-08-03'),
('A_W14_MGT_24','W14_MGT','S24','ST03','Absent','2026-08-03'),
('A_W14_MGT_25','W14_MGT','S25','ST03','Present','2026-08-03'),

('A_W14_LIN_11','W14_LIN','S11','ST04','Present','2026-08-03'),
('A_W14_LIN_12','W14_LIN','S12','ST04','Present','2026-08-03'),
('A_W14_LIN_13','W14_LIN','S13','ST04','Absent','2026-08-03'),
('A_W14_LIN_14','W14_LIN','S14','ST04','Present','2026-08-03'),
('A_W14_LIN_15','W14_LIN','S15','ST04','Present','2026-08-03'),
('A_W14_LIN_16','W14_LIN','S16','ST04','Present','2026-08-03'),
('A_W14_LIN_17','W14_LIN','S17','ST04','Absent','2026-08-03'),
('A_W14_LIN_18','W14_LIN','S18','ST04','Present','2026-08-03'),
('A_W14_LIN_19','W14_LIN','S19','ST04','Present','2026-08-03'),
('A_W14_LIN_20','W14_LIN','S20','ST04','Present','2026-08-03'),
('A_W14_LIN_21','W14_LIN','S21','ST04','Present','2026-08-03'),
('A_W14_LIN_22','W14_LIN','S22','ST04','Present','2026-08-03'),
('A_W14_LIN_23','W14_LIN','S23','ST04','Present','2026-08-03'),
('A_W14_LIN_24','W14_LIN','S24','ST04','Absent','2026-08-03'),
('A_W14_LIN_25','W14_LIN','S25','ST04','Present','2026-08-03'),

('A_W14_DBP_11','W14_DBP','S11','ST05','Present','2026-08-04'),
('A_W14_DBP_12','W14_DBP','S12','ST05','Present','2026-08-04'),
('A_W14_DBP_13','W14_DBP','S13','ST05','Absent','2026-08-04'),
('A_W14_DBP_14','W14_DBP','S14','ST05','Present','2026-08-04'),
('A_W14_DBP_15','W14_DBP','S15','ST05','Present','2026-08-04'),
('A_W14_DBP_16','W14_DBP','S16','ST05','Present','2026-08-04'),
('A_W14_DBP_17','W14_DBP','S17','ST05','Present','2026-08-04'),
('A_W14_DBP_18','W14_DBP','S18','ST05','Present','2026-08-04'),
('A_W14_DBP_19','W14_DBP','S19','ST05','Absent','2026-08-04'),
('A_W14_DBP_20','W14_DBP','S20','ST05','Present','2026-08-04'),
('A_W14_DBP_21','W14_DBP','S21','ST05','Absent','2026-08-04'),
('A_W14_DBP_22','W14_DBP','S22','ST05','Present','2026-08-04'),
('A_W14_DBP_23','W14_DBP','S23','ST05','Present','2026-08-04'),
('A_W14_DBP_24','W14_DBP','S24','ST05','Absent','2026-08-04'),
('A_W14_DBP_25','W14_DBP','S25','ST05','Present','2026-08-04'),

('A_W14_WEBT_11','W14_WEBT','S11','ST06','Present','2026-08-04'),
('A_W14_WEBT_12','W14_WEBT','S12','ST06','Present','2026-08-04'),
('A_W14_WEBT_13','W14_WEBT','S13','ST06','Present','2026-08-04'),
('A_W14_WEBT_14','W14_WEBT','S14','ST06','Present','2026-08-04'),
('A_W14_WEBT_15','W14_WEBT','S15','ST06','Present','2026-08-04'),
('A_W14_WEBT_16','W14_WEBT','S16','ST06','Present','2026-08-04'),
('A_W14_WEBT_17','W14_WEBT','S17','ST06','Present','2026-08-04'),
('A_W14_WEBT_18','W14_WEBT','S18','ST06','Present','2026-08-04'),
('A_W14_WEBT_19','W14_WEBT','S19','ST06','Absent','2026-08-04'),
('A_W14_WEBT_20','W14_WEBT','S20','ST06','Present','2026-08-04'),
('A_W14_WEBT_21','W14_WEBT','S21','ST06','Present','2026-08-04'),
('A_W14_WEBT_22','W14_WEBT','S22','ST06','Present','2026-08-04'),
('A_W14_WEBT_23','W14_WEBT','S23','ST06','Present','2026-08-04'),
('A_W14_WEBT_24','W14_WEBT','S24','ST06','Present','2026-08-04'),
('A_W14_WEBT_25','W14_WEBT','S25','ST06','Present','2026-08-04'),

('A_W14_WEBP1_11','W14_WEBP1','S11','ST07','Present','2026-08-04'),
('A_W14_WEBP1_12','W14_WEBP1','S12','ST07','Present','2026-08-04'),
('A_W14_WEBP1_13','W14_WEBP1','S13','ST07','Present','2026-08-04'),
('A_W14_WEBP1_14','W14_WEBP1','S14','ST07','Present','2026-08-04'),
('A_W14_WEBP1_15','W14_WEBP1','S15','ST07','Present','2026-08-04'),
('A_W14_WEBP1_16','W14_WEBP1','S16','ST07','Present','2026-08-04'),
('A_W14_WEBP1_17','W14_WEBP1','S17','ST07','Absent','2026-08-04'),
('A_W14_WEBP1_18','W14_WEBP1','S18','ST07','Present','2026-08-04'),
('A_W14_WEBP1_19','W14_WEBP1','S19','ST07','Absent','2026-08-04'),
('A_W14_WEBP1_20','W14_WEBP1','S20','ST07','Present','2026-08-04'),
('A_W14_WEBP1_21','W14_WEBP1','S21','ST07','Present','2026-08-04'),
('A_W14_WEBP1_22','W14_WEBP1','S22','ST07','Present','2026-08-04'),
('A_W14_WEBP1_23','W14_WEBP1','S23','ST07','Present','2026-08-04'),
('A_W14_WEBP1_24','W14_WEBP1','S24','ST07','Absent','2026-08-04'),
('A_W14_WEBP1_25','W14_WEBP1','S25','ST07','Present','2026-08-04'),

('A_W14_MAT_11','W14_MAT','S11','ST08','Present','2026-08-05'),
('A_W14_MAT_12','W14_MAT','S12','ST08','Present','2026-08-05'),
('A_W14_MAT_13','W14_MAT','S13','ST08','Present','2026-08-05'),
('A_W14_MAT_14','W14_MAT','S14','ST08','Present','2026-08-05'),
('A_W14_MAT_15','W14_MAT','S15','ST08','Present','2026-08-05'),
('A_W14_MAT_16','W14_MAT','S16','ST08','Present','2026-08-05'),
('A_W14_MAT_17','W14_MAT','S17','ST08','Present','2026-08-05'),
('A_W14_MAT_18','W14_MAT','S18','ST08','Present','2026-08-05'),
('A_W14_MAT_19','W14_MAT','S19','ST08','Absent','2026-08-05'),
('A_W14_MAT_20','W14_MAT','S20','ST08','Present','2026-08-05'),
('A_W14_MAT_21','W14_MAT','S21','ST08','Absent','2026-08-05'),
('A_W14_MAT_22','W14_MAT','S22','ST08','Present','2026-08-05'),
('A_W14_MAT_23','W14_MAT','S23','ST08','Present','2026-08-05'),
('A_W14_MAT_24','W14_MAT','S24','ST08','Present','2026-08-05'),
('A_W14_MAT_25','W14_MAT','S25','ST08','Present','2026-08-05'),

('A_W14_ENG_11','W14_ENG','S11','ST09','Present','2026-08-06'),
('A_W14_ENG_12','W14_ENG','S12','ST09','Present','2026-08-06'),
('A_W14_ENG_13','W14_ENG','S13','ST09','Present','2026-08-06'),
('A_W14_ENG_14','W14_ENG','S14','ST09','Present','2026-08-06'),
('A_W14_ENG_15','W14_ENG','S15','ST09','Present','2026-08-06'),
('A_W14_ENG_16','W14_ENG','S16','ST09','Present','2026-08-06'),
('A_W14_ENG_17','W14_ENG','S17','ST09','Absent','2026-08-06'),
('A_W14_ENG_18','W14_ENG','S18','ST09','Present','2026-08-06'),
('A_W14_ENG_19','W14_ENG','S19','ST09','Absent','2026-08-06'),
('A_W14_ENG_20','W14_ENG','S20','ST09','Present','2026-08-06'),
('A_W14_ENG_21','W14_ENG','S21','ST09','Absent','2026-08-06'),
('A_W14_ENG_22','W14_ENG','S22','ST09','Present','2026-08-06'),
('A_W14_ENG_23','W14_ENG','S23','ST09','Present','2026-08-06'),
('A_W14_ENG_24','W14_ENG','S24','ST09','Present','2026-08-06'),
('A_W14_ENG_25','W14_ENG','S25','ST09','Present','2026-08-06'),

('A_W14_DBS_11','W14_DBS','S11','ST10','Present','2026-08-06'),
('A_W14_DBS_12','W14_DBS','S12','ST10','Present','2026-08-06'),
('A_W14_DBS_13','W14_DBS','S13','ST10','Absent','2026-08-06'),
('A_W14_DBS_14','W14_DBS','S14','ST10','Present','2026-08-06'),
('A_W14_DBS_15','W14_DBS','S15','ST10','Present','2026-08-06'),
('A_W14_DBS_16','W14_DBS','S16','ST10','Present','2026-08-06'),
('A_W14_DBS_17','W14_DBS','S17','ST10','Absent','2026-08-06'),
('A_W14_DBS_18','W14_DBS','S18','ST10','Absent','2026-08-06'),
('A_W14_DBS_19','W14_DBS','S19','ST10','Absent','2026-08-06'),
('A_W14_DBS_20','W14_DBS','S20','ST10','Present','2026-08-06'),
('A_W14_DBS_21','W14_DBS','S21','ST10','Present','2026-08-06'),
('A_W14_DBS_22','W14_DBS','S22','ST10','Present','2026-08-06'),
('A_W14_DBS_23','W14_DBS','S23','ST10','Present','2026-08-06'),
('A_W14_DBS_24','W14_DBS','S24','ST10','Absent','2026-08-06'),
('A_W14_DBS_25','W14_DBS','S25','ST10','Present','2026-08-06'),

('A_W14_WEBP2_11','W14_WEBP2','S11','ST07','Present','2026-08-06'),
('A_W14_WEBP2_12','W14_WEBP2','S12','ST07','Present','2026-08-06'),
('A_W14_WEBP2_13','W14_WEBP2','S13','ST07','Present','2026-08-06'),
('A_W14_WEBP2_14','W14_WEBP2','S14','ST07','Present','2026-08-06'),
('A_W14_WEBP2_15','W14_WEBP2','S15','ST07','Present','2026-08-06'),
('A_W14_WEBP2_16','W14_WEBP2','S16','ST07','Present','2026-08-06'),
('A_W14_WEBP2_17','W14_WEBP2','S17','ST07','Absent','2026-08-06'),
('A_W14_WEBP2_18','W14_WEBP2','S18','ST07','Present','2026-08-06'),
('A_W14_WEBP2_19','W14_WEBP2','S19','ST07','Present','2026-08-06'),
('A_W14_WEBP2_20','W14_WEBP2','S20','ST07','Present','2026-08-06'),
('A_W14_WEBP2_21','W14_WEBP2','S21','ST07','Present','2026-08-06'),
('A_W14_WEBP2_22','W14_WEBP2','S22','ST07','Present','2026-08-06'),
('A_W14_WEBP2_23','W14_WEBP2','S23','ST07','Present','2026-08-06'),
('A_W14_WEBP2_24','W14_WEBP2','S24','ST07','Present','2026-08-06'),
('A_W14_WEBP2_25','W14_WEBP2','S25','ST07','Present','2026-08-06'),

('A_W14_OSC_11','W14_OSC','S11','ST03','Present','2026-08-07'),
('A_W14_OSC_12','W14_OSC','S12','ST03','Present','2026-08-07'),
('A_W14_OSC_13','W14_OSC','S13','ST03','Present','2026-08-07'),
('A_W14_OSC_14','W14_OSC','S14','ST03','Present','2026-08-07'),
('A_W14_OSC_15','W14_OSC','S15','ST03','Present','2026-08-07'),
('A_W14_OSC_16','W14_OSC','S16','ST03','Present','2026-08-07'),
('A_W14_OSC_17','W14_OSC','S17','ST03','Absent','2026-08-07'),
('A_W14_OSC_18','W14_OSC','S18','ST03','Present','2026-08-07'),
('A_W14_OSC_19','W14_OSC','S19','ST03','Present','2026-08-07'),
('A_W14_OSC_20','W14_OSC','S20','ST03','Present','2026-08-07'),
('A_W14_OSC_21','W14_OSC','S21','ST03','Absent','2026-08-07'),
('A_W14_OSC_22','W14_OSC','S22','ST03','Present','2026-08-07'),
('A_W14_OSC_23','W14_OSC','S23','ST03','Present','2026-08-07'),
('A_W14_OSC_24','W14_OSC','S24','ST03','Absent','2026-08-07'),
('A_W14_OSC_25','W14_OSC','S25','ST03','Present','2026-08-07'),

-- ================= WEEK 15 =================

('A_W15_MGT_11','W15_MGT','S11','ST03','Present','2026-08-10'),
('A_W15_MGT_12','W15_MGT','S12','ST03','Present','2026-08-10'),
('A_W15_MGT_13','W15_MGT','S13','ST03','Absent','2026-08-10'),
('A_W15_MGT_14','W15_MGT','S14','ST03','Present','2026-08-10'),
('A_W15_MGT_15','W15_MGT','S15','ST03','Present','2026-08-10'),
('A_W15_MGT_16','W15_MGT','S16','ST03','Present','2026-08-10'),
('A_W15_MGT_17','W15_MGT','S17','ST03','Present','2026-08-10'),
('A_W15_MGT_18','W15_MGT','S18','ST03','Present','2026-08-10'),
('A_W15_MGT_19','W15_MGT','S19','ST03','Absent','2026-08-10'),
('A_W15_MGT_20','W15_MGT','S20','ST03','Present','2026-08-10'),
('A_W15_MGT_21','W15_MGT','S21','ST03','Present','2026-08-10'),
('A_W15_MGT_22','W15_MGT','S22','ST03','Present','2026-08-10'),
('A_W15_MGT_23','W15_MGT','S23','ST03','Present','2026-08-10'),
('A_W15_MGT_24','W15_MGT','S24','ST03','Absent','2026-08-10'),
('A_W15_MGT_25','W15_MGT','S25','ST03','Present','2026-08-10'),

('A_W15_LIN_11','W15_LIN','S11','ST04','Present','2026-08-10'),
('A_W15_LIN_12','W15_LIN','S12','ST04','Present','2026-08-10'),
('A_W15_LIN_13','W15_LIN','S13','ST04','Present','2026-08-10'),
('A_W15_LIN_14','W15_LIN','S14','ST04','Present','2026-08-10'),
('A_W15_LIN_15','W15_LIN','S15','ST04','Present','2026-08-10'),
('A_W15_LIN_16','W15_LIN','S16','ST04','Present','2026-08-10'),
('A_W15_LIN_17','W15_LIN','S17','ST04','Present','2026-08-10'),
('A_W15_LIN_18','W15_LIN','S18','ST04','Present','2026-08-10'),
('A_W15_LIN_19','W15_LIN','S19','ST04','Absent','2026-08-10'),
('A_W15_LIN_20','W15_LIN','S20','ST04','Present','2026-08-10'),
('A_W15_LIN_21','W15_LIN','S21','ST04','Absent','2026-08-10'),
('A_W15_LIN_22','W15_LIN','S22','ST04','Present','2026-08-10'),
('A_W15_LIN_23','W15_LIN','S23','ST04','Present','2026-08-10'),
('A_W15_LIN_24','W15_LIN','S24','ST04','Present','2026-08-10'),
('A_W15_LIN_25','W15_LIN','S25','ST04','Present','2026-08-10'),

('A_W15_DBP_11','W15_DBP','S11','ST05','Present','2026-08-11'),
('A_W15_DBP_12','W15_DBP','S12','ST05','Absent','2026-08-11'),
('A_W15_DBP_13','W15_DBP','S13','ST05','Absent','2026-08-11'),
('A_W15_DBP_14','W15_DBP','S14','ST05','Present','2026-08-11'),
('A_W15_DBP_15','W15_DBP','S15','ST05','Present','2026-08-11'),
('A_W15_DBP_16','W15_DBP','S16','ST05','Present','2026-08-11'),
('A_W15_DBP_17','W15_DBP','S17','ST05','Absent','2026-08-11'),
('A_W15_DBP_18','W15_DBP','S18','ST05','Present','2026-08-11'),
('A_W15_DBP_19','W15_DBP','S19','ST05','Present','2026-08-11'),
('A_W15_DBP_20','W15_DBP','S20','ST05','Present','2026-08-11'),
('A_W15_DBP_21','W15_DBP','S21','ST05','Present','2026-08-11'),
('A_W15_DBP_22','W15_DBP','S22','ST05','Present','2026-08-11'),
('A_W15_DBP_23','W15_DBP','S23','ST05','Present','2026-08-11'),
('A_W15_DBP_24','W15_DBP','S24','ST05','Absent','2026-08-11'),
('A_W15_DBP_25','W15_DBP','S25','ST05','Present','2026-08-11'),

('A_W15_WEBT_11','W15_WEBT','S11','ST06','Present','2026-08-11'),
('A_W15_WEBT_12','W15_WEBT','S12','ST06','Present','2026-08-11'),
('A_W15_WEBT_13','W15_WEBT','S13','ST06','Absent','2026-08-11'),
('A_W15_WEBT_14','W15_WEBT','S14','ST06','Present','2026-08-11'),
('A_W15_WEBT_15','W15_WEBT','S15','ST06','Present','2026-08-11'),
('A_W15_WEBT_16','W15_WEBT','S16','ST06','Present','2026-08-11'),
('A_W15_WEBT_17','W15_WEBT','S17','ST06','Absent','2026-08-11'),
('A_W15_WEBT_18','W15_WEBT','S18','ST06','Present','2026-08-11'),
('A_W15_WEBT_19','W15_WEBT','S19','ST06','Absent','2026-08-11'),
('A_W15_WEBT_20','W15_WEBT','S20','ST06','Present','2026-08-11'),
('A_W15_WEBT_21','W15_WEBT','S21','ST06','Present','2026-08-11'),
('A_W15_WEBT_22','W15_WEBT','S22','ST06','Present','2026-08-11'),
('A_W15_WEBT_23','W15_WEBT','S23','ST06','Present','2026-08-11'),
('A_W15_WEBT_24','W15_WEBT','S24','ST06','Absent','2026-08-11'),
('A_W15_WEBT_25','W15_WEBT','S25','ST06','Present','2026-08-11'),

('A_W15_WEBP1_11','W15_WEBP1','S11','ST07','Present','2026-08-11'),
('A_W15_WEBP1_12','W15_WEBP1','S12','ST07','Present','2026-08-11'),
('A_W15_WEBP1_13','W15_WEBP1','S13','ST07','Present','2026-08-11'),
('A_W15_WEBP1_14','W15_WEBP1','S14','ST07','Present','2026-08-11'),
('A_W15_WEBP1_15','W15_WEBP1','S15','ST07','Present','2026-08-11'),
('A_W15_WEBP1_16','W15_WEBP1','S16','ST07','Present','2026-08-11'),
('A_W15_WEBP1_17','W15_WEBP1','S17','ST07','Present','2026-08-11'),
('A_W15_WEBP1_18','W15_WEBP1','S18','ST07','Present','2026-08-11'),
('A_W15_WEBP1_19','W15_WEBP1','S19','ST07','Present','2026-08-11'),
('A_W15_WEBP1_20','W15_WEBP1','S20','ST07','Present','2026-08-11'),
('A_W15_WEBP1_21','W15_WEBP1','S21','ST07','Absent','2026-08-11'),
('A_W15_WEBP1_22','W15_WEBP1','S22','ST07','Present','2026-08-11'),
('A_W15_WEBP1_23','W15_WEBP1','S23','ST07','Present','2026-08-11'),
('A_W15_WEBP1_24','W15_WEBP1','S24','ST07','Absent','2026-08-11'),
('A_W15_WEBP1_25','W15_WEBP1','S25','ST07','Present','2026-08-11'),

('A_W15_MAT_11','W15_MAT','S11','ST08','Present','2026-08-12'),
('A_W15_MAT_12','W15_MAT','S12','ST08','Present','2026-08-12'),
('A_W15_MAT_13','W15_MAT','S13','ST08','Absent','2026-08-12'),
('A_W15_MAT_14','W15_MAT','S14','ST08','Present','2026-08-12'),
('A_W15_MAT_15','W15_MAT','S15','ST08','Present','2026-08-12'),
('A_W15_MAT_16','W15_MAT','S16','ST08','Present','2026-08-12'),
('A_W15_MAT_17','W15_MAT','S17','ST08','Absent','2026-08-12'),
('A_W15_MAT_18','W15_MAT','S18','ST08','Present','2026-08-12'),
('A_W15_MAT_19','W15_MAT','S19','ST08','Absent','2026-08-12'),
('A_W15_MAT_20','W15_MAT','S20','ST08','Present','2026-08-12'),
('A_W15_MAT_21','W15_MAT','S21','ST08','Absent','2026-08-12'),
('A_W15_MAT_22','W15_MAT','S22','ST08','Present','2026-08-12'),
('A_W15_MAT_23','W15_MAT','S23','ST08','Present','2026-08-12'),
('A_W15_MAT_24','W15_MAT','S24','ST08','Absent','2026-08-12'),
('A_W15_MAT_25','W15_MAT','S25','ST08','Present','2026-08-12'),

('A_W15_ENG_11','W15_ENG','S11','ST09','Present','2026-08-13'),
('A_W15_ENG_12','W15_ENG','S12','ST09','Present','2026-08-13'),
('A_W15_ENG_13','W15_ENG','S13','ST09','Absent','2026-08-13'),
('A_W15_ENG_14','W15_ENG','S14','ST09','Present','2026-08-13'),
('A_W15_ENG_15','W15_ENG','S15','ST09','Present','2026-08-13'),
('A_W15_ENG_16','W15_ENG','S16','ST09','Present','2026-08-13'),
('A_W15_ENG_17','W15_ENG','S17','ST09','Present','2026-08-13'),
('A_W15_ENG_18','W15_ENG','S18','ST09','Present','2026-08-13'),
('A_W15_ENG_19','W15_ENG','S19','ST09','Present','2026-08-13'),
('A_W15_ENG_20','W15_ENG','S20','ST09','Present','2026-08-13'),
('A_W15_ENG_21','W15_ENG','S21','ST09','Present','2026-08-13'),
('A_W15_ENG_22','W15_ENG','S22','ST09','Present','2026-08-13'),
('A_W15_ENG_23','W15_ENG','S23','ST09','Present','2026-08-13'),
('A_W15_ENG_24','W15_ENG','S24','ST09','Absent','2026-08-13'),
('A_W15_ENG_25','W15_ENG','S25','ST09','Present','2026-08-13'),

('A_W15_DBS_11','W15_DBS','S11','ST10','Present','2026-08-13'),
('A_W15_DBS_12','W15_DBS','S12','ST10','Present','2026-08-13'),
('A_W15_DBS_13','W15_DBS','S13','ST10','Absent','2026-08-13'),
('A_W15_DBS_14','W15_DBS','S14','ST10','Present','2026-08-13'),
('A_W15_DBS_15','W15_DBS','S15','ST10','Present','2026-08-13'),
('A_W15_DBS_16','W15_DBS','S16','ST10','Present','2026-08-13'),
('A_W15_DBS_17','W15_DBS','S17','ST10','Present','2026-08-13'),
('A_W15_DBS_18','W15_DBS','S18','ST10','Present','2026-08-13'),
('A_W15_DBS_19','W15_DBS','S19','ST10','Absent','2026-08-13'),
('A_W15_DBS_20','W15_DBS','S20','ST10','Present','2026-08-13'),
('A_W15_DBS_21','W15_DBS','S21','ST10','Present','2026-08-13'),
('A_W15_DBS_22','W15_DBS','S22','ST10','Present','2026-08-13'),
('A_W15_DBS_23','W15_DBS','S23','ST10','Present','2026-08-13'),
('A_W15_DBS_24','W15_DBS','S24','ST10','Absent','2026-08-13'),
('A_W15_DBS_25','W15_DBS','S25','ST10','Present','2026-08-13'),

('A_W15_WEBP2_11','W15_WEBP2','S11','ST07','Present','2026-08-13'),
('A_W15_WEBP2_12','W15_WEBP2','S12','ST07','Present','2026-08-13'),
('A_W15_WEBP2_13','W15_WEBP2','S13','ST07','Absent','2026-08-13'),
('A_W15_WEBP2_14','W15_WEBP2','S14','ST07','Present','2026-08-13'),
('A_W15_WEBP2_15','W15_WEBP2','S15','ST07','Present','2026-08-13'),
('A_W15_WEBP2_16','W15_WEBP2','S16','ST07','Present','2026-08-13'),
('A_W15_WEBP2_17','W15_WEBP2','S17','ST07','Present','2026-08-13'),
('A_W15_WEBP2_18','W15_WEBP2','S18','ST07','Present','2026-08-13'),
('A_W15_WEBP2_19','W15_WEBP2','S19','ST07','Absent','2026-08-13'),
('A_W15_WEBP2_20','W15_WEBP2','S20','ST07','Present','2026-08-13'),
('A_W15_WEBP2_21','W15_WEBP2','S21','ST07','Absent','2026-08-13'),
('A_W15_WEBP2_22','W15_WEBP2','S22','ST07','Present','2026-08-13'),
('A_W15_WEBP2_23','W15_WEBP2','S23','ST07','Present','2026-08-13'),
('A_W15_WEBP2_24','W15_WEBP2','S24','ST07','Absent','2026-08-13'),
('A_W15_WEBP2_25','W15_WEBP2','S25','ST07','Present','2026-08-13'),

('A_W15_OSC_11','W15_OSC','S11','ST03','Present','2026-08-14'),
('A_W15_OSC_12','W15_OSC','S12','ST03','Present','2026-08-14'),
('A_W15_OSC_13','W15_OSC','S13','ST03','Absent','2026-08-14'),
('A_W15_OSC_14','W15_OSC','S14','ST03','Present','2026-08-14'),
('A_W15_OSC_15','W15_OSC','S15','ST03','Present','2026-08-14'),
('A_W15_OSC_16','W15_OSC','S16','ST03','Present','2026-08-14'),
('A_W15_OSC_17','W15_OSC','S17','ST03','Absent','2026-08-14'),
('A_W15_OSC_18','W15_OSC','S18','ST03','Present','2026-08-14'),
('A_W15_OSC_19','W15_OSC','S19','ST03','Absent','2026-08-14'),
('A_W15_OSC_20','W15_OSC','S20','ST03','Present','2026-08-14'),
('A_W15_OSC_21','W15_OSC','S21','ST03','Absent','2026-08-14'),
('A_W15_OSC_22','W15_OSC','S22','ST03','Present','2026-08-14'),
('A_W15_OSC_23','W15_OSC','S23','ST03','Present','2026-08-14'),
('A_W15_OSC_24','W15_OSC','S24','ST03','Present','2026-08-14'),
('A_W15_OSC_25','W15_OSC','S25','ST03','Present','2026-08-14');



INSERT INTO MEDICAL_RECORD (Medical_ID, Student_ID, Session_ID, reason, issued_by, submitted_date, approval_status) VALUES
('MED_001', 'S04', 'W01_DBS', 'Viral Fever', 'General Hospital Matara', '2026-05-10', 'Approved'),
('MED_002', 'S04', 'W02_LIN', 'Dengue Fever', 'General Hospital Matara', '2026-05-15', 'Approved'),
('MED_003', 'S07', 'W03_MAT', 'Severe Migraine', 'University Medical Center', '2026-05-25', 'Approved'),
('MED_004', 'S09', 'W06_LIN', 'Food Poisoning', 'Dr. Perera (Private Clinic)', '2026-06-10', 'Approved'),
('MED_005', 'S08', 'W10_MGT', 'Sports Injury (Ankle)', 'Sports Medical Unit', '2026-07-08', 'Pending');


INSERT INTO ASSESSMENT_TYPE (Assessment_Type_ID, Assessment_Name) VALUES
('AT_QZ', 'Quiz'),
('AT_PR', 'Project'),
('AT_MT', 'Mid Theory'),
('AT_MP', 'Mid Practical'),
('AT_FT', 'Final Theory'),
('AT_FP', 'Final Practical');


INSERT IGNORE INTO ASSESSMENT_SCHEME 
(Scheme_ID, Offering_ID, Assessment_Type_ID, Component_ID, weight_percentage, assessment_no, max_marks, is_mandatory) 
VALUES
-- MGT (Fundamentals of Management)
('SC_MGT_QZ', 'OFF_MGT', 'AT_QZ', 'CC_MGT', 5.00, 1, 100, TRUE),
('SC_MGT_PR', 'OFF_MGT', 'AT_PR', 'CC_MGT', 10.00, 1, 100, TRUE),
('SC_MGT_MT', 'OFF_MGT', 'AT_MT', 'CC_MGT', 15.00, 1, 100, TRUE),
('SC_MGT_FT', 'OFF_MGT', 'AT_FT', 'CC_MGT', 70.00, 1, 100, TRUE),

-- LIN (System Prog. Fundamentals & Linux)
('SC_LIN_QZ', 'OFF_LIN', 'AT_QZ', 'CC_LIN_T', 5.00, 1, 100, TRUE),
('SC_LIN_PR', 'OFF_LIN', 'AT_PR', 'CC_LIN_T', 10.00, 1, 100, TRUE),
('SC_LIN_MT', 'OFF_LIN', 'AT_MT', 'CC_LIN_T', 15.00, 1, 100, TRUE),
('SC_LIN_FT', 'OFF_LIN', 'AT_FT', 'CC_LIN_T', 70.00, 1, 100, TRUE),

-- DBP (DBMS Practicum)
('SC_DBP_QZ', 'OFF_DBP', 'AT_QZ', 'CC_DBP', 10.00, 1, 100, TRUE),
('SC_DBP_PR', 'OFF_DBP', 'AT_PR', 'CC_DBP', 10.00, 1, 100, TRUE),
('SC_DBP_MT', 'OFF_DBP', 'AT_MT', 'CC_DBP', 20.00, 1, 100, TRUE),
('SC_DBP_MP', 'OFF_DBP', 'AT_MP', 'CC_DBP', 20.00, 1, 100, TRUE),
('SC_DBP_FP', 'OFF_DBP', 'AT_FP', 'CC_DBP', 60.00, 1, 100, TRUE),

-- WEB (Web Development Theory)
('SC_WEB_QZ', 'OFF_WEB', 'AT_QZ', 'CC_WEB_T', 5.00, 1, 100, TRUE),
('SC_WEB_PR', 'OFF_WEB', 'AT_PR', 'CC_WEB_T', 10.00, 1, 100, TRUE),
('SC_WEB_MT', 'OFF_WEB', 'AT_MT', 'CC_WEB_T', 15.00, 1, 100, TRUE),
('SC_WEB_FT', 'OFF_WEB', 'AT_FT', 'CC_WEB_T', 70.00, 1, 100, TRUE),

-- WEP (Web Development Practicum)
('SC_WEP_QZ', 'OFF_WEP', 'AT_QZ', 'CC_WEB_P1', 10.00, 1, 100, TRUE),
('SC_WEP_PR', 'OFF_WEP', 'AT_PR', 'CC_WEB_P1', 10.00, 1, 100, TRUE),
('SC_WEP_MT', 'OFF_WEP', 'AT_MT', 'CC_WEB_P1', 20.00, 1, 100, TRUE),
('SC_WEP_MP', 'OFF_WEP', 'AT_MP', 'CC_WEB_P1', 20.00, 1, 100, TRUE),
('SC_WEP_FP', 'OFF_WEP', 'AT_FP', 'CC_WEB_P1', 60.00, 1, 100, TRUE),

-- MAT (Discrete Mathematics)
('SC_MAT_QZ', 'OFF_MAT', 'AT_QZ', 'CC_MAT', 5.00, 1, 100, TRUE),
('SC_MAT_PR', 'OFF_MAT', 'AT_PR', 'CC_MAT', 10.00, 1, 100, TRUE),
('SC_MAT_MT', 'OFF_MAT', 'AT_MT', 'CC_MAT', 15.00, 1, 100, TRUE),
('SC_MAT_FT', 'OFF_MAT', 'AT_FT', 'CC_MAT', 70.00, 1, 100, TRUE),

-- ENG (English II)
('SC_ENG_QZ', 'OFF_ENG', 'AT_QZ', 'CC_ENG', 5.00, 1, 100, TRUE),
('SC_ENG_PR', 'OFF_ENG', 'AT_PR', 'CC_ENG', 10.00, 1, 100, TRUE),
('SC_ENG_MT', 'OFF_ENG', 'AT_MT', 'CC_ENG', 15.00, 1, 100, TRUE),
('SC_ENG_FT', 'OFF_ENG', 'AT_FT', 'CC_ENG', 70.00, 1, 100, TRUE),

-- DBS (Database Management Systems Theory)
('SC_DBS_QZ', 'OFF_DBS', 'AT_QZ', 'CC_DBS', 5.00, 1, 100, TRUE),
('SC_DBS_PR', 'OFF_DBS', 'AT_PR', 'CC_DBS', 10.00, 1, 100, TRUE),
('SC_DBS_MT', 'OFF_DBS', 'AT_MT', 'CC_DBS', 15.00, 1, 100, TRUE),
('SC_DBS_FT', 'OFF_DBS', 'AT_FT', 'CC_DBS', 70.00, 1, 100, TRUE),

-- OSC (OS Concepts and Application)
('SC_OSC_QZ', 'OFF_OSC', 'AT_QZ', 'CC_OSC', 5.00, 1, 100, TRUE),
('SC_OSC_PR', 'OFF_OSC', 'AT_PR', 'CC_OSC', 10.00, 1, 100, TRUE),
('SC_OSC_MT', 'OFF_OSC', 'AT_MT', 'CC_OSC', 15.00, 1, 100, TRUE),
('SC_OSC_FT', 'OFF_OSC', 'AT_FT', 'CC_OSC', 70.00, 1, 100, TRUE);

INSERT INTO STUDENT_MARK (Mark_ID, Student_ID, Scheme_ID, entered_by, raw_mark, mark_status, entered_date) VALUES

-- -------------------------------------------------------------------------
-- 1. MGT (Fundamentals of Management) - ST03
-- -------------------------------------------------------------------------
-- MGT QUIZ (SC_MGT_QZ)
('M_MGTQ_01','S01','SC_MGT_QZ','ST03',85,'Verified','2026-07-20'),
('M_MGTQ_02','S02','SC_MGT_QZ','ST03',75,'Verified','2026-07-20'),
('M_MGTQ_03','S03','SC_MGT_QZ','ST03',65,'Verified','2026-07-20'),
('M_MGTQ_04','S04','SC_MGT_QZ','ST03',95,'Verified','2026-07-20'),
('M_MGTQ_05','S05','SC_MGT_QZ','ST03',88,'Verified','2026-07-20'),
('M_MGTQ_06','S06','SC_MGT_QZ','ST03',78,'Verified','2026-07-20'),
('M_MGTQ_07','S07','SC_MGT_QZ','ST03',82,'Verified','2026-07-20'),
('M_MGTQ_08','S08','SC_MGT_QZ','ST03',90,'Verified','2026-07-20'),
('M_MGTQ_09','S09','SC_MGT_QZ','ST03',0,'Verified','2026-07-20'),
('M_MGTQ_10','S10','SC_MGT_QZ','ST03',72,'Verified','2026-07-20'),

-- MGT PROJECT (SC_MGT_PR)
('M_MGTP_01','S01','SC_MGT_PR','ST03',88,'Verified','2026-07-22'),
('M_MGTP_02','S02','SC_MGT_PR','ST03',79,'Verified','2026-07-22'),
('M_MGTP_03','S03','SC_MGT_PR','ST03',68,'Verified','2026-07-22'),
('M_MGTP_04','S04','SC_MGT_PR','ST03',92,'Verified','2026-07-22'),
('M_MGTP_05','S05','SC_MGT_PR','ST03',85,'Verified','2026-07-22'),
('M_MGTP_06','S06','SC_MGT_PR','ST03',75,'Verified','2026-07-22'),
('M_MGTP_07','S07','SC_MGT_PR','ST03',84,'Verified','2026-07-22'),
('M_MGTP_08','S08','SC_MGT_PR','ST03',92,'Verified','2026-07-22'),
('M_MGTP_09','S09','SC_MGT_PR','ST03',0,'Verified','2026-07-22'),
('M_MGTP_10','S10','SC_MGT_PR','ST03',74,'Verified','2026-07-22'),

-- MGT MID THEORY (SC_MGT_MT)
('M_MGTM_01','S01','SC_MGT_MT','ST03',80,'Verified','2026-07-25'),
('M_MGTM_02','S02','SC_MGT_MT','ST03',82,'Verified','2026-07-25'),
('M_MGTM_03','S03','SC_MGT_MT','ST03',70,'Verified','2026-07-25'),
('M_MGTM_04','S04','SC_MGT_MT','ST03',90,'Verified','2026-07-25'),
('M_MGTM_05','S05','SC_MGT_MT','ST03',88,'Verified','2026-07-25'),
('M_MGTM_06','S06','SC_MGT_MT','ST03',75,'Verified','2026-07-25'),
('M_MGTM_07','S07','SC_MGT_MT','ST03',80,'Verified','2026-07-25'),
('M_MGTM_08','S08','SC_MGT_MT','ST03',88,'Verified','2026-07-25'),
('M_MGTM_09','S09','SC_MGT_MT','ST03',0,'Verified','2026-07-25'),
('M_MGTM_10','S10','SC_MGT_MT','ST03',75,'Verified','2026-07-25'),

-- MGT FINAL THEORY (SC_MGT_FT)
('M_MGTF_01','S01','SC_MGT_FT','ST03',88,'Verified','2026-08-20'),
('M_MGTF_02','S02','SC_MGT_FT','ST03',85,'Verified','2026-08-20'),
('M_MGTF_03','S03','SC_MGT_FT','ST03',72,'Verified','2026-08-20'),
('M_MGTF_04','S04','SC_MGT_FT','ST03',90,'Verified','2026-08-20'),
('M_MGTF_05','S05','SC_MGT_FT','ST03',92,'Verified','2026-08-20'),
('M_MGTF_06','S06','SC_MGT_FT','ST03',80,'Verified','2026-08-20'),
('M_MGTF_07','S07','SC_MGT_FT','ST03',82,'Verified','2026-08-20'),
('M_MGTF_08','S08','SC_MGT_FT','ST03',90,'Verified','2026-08-20'),
('M_MGTF_09','S09','SC_MGT_FT','ST03',0,'Verified','2026-08-20'),
('M_MGTF_10','S10','SC_MGT_FT','ST03',78,'Verified','2026-08-20'),

-- -------------------------------------------------------------------------
-- 2. LIN (System Prog. Fundamentals & Linux) - ST04
-- -------------------------------------------------------------------------
-- LIN QUIZ (SC_LIN_QZ)
('M_LINQ_01','S01','SC_LIN_QZ','ST04',82,'Verified','2026-07-20'),
('M_LINQ_02','S02','SC_LIN_QZ','ST04',78,'Verified','2026-07-20'),
('M_LINQ_03','S03','SC_LIN_QZ','ST04',68,'Verified','2026-07-20'),
('M_LINQ_04','S04','SC_LIN_QZ','ST04',90,'Verified','2026-07-20'),
('M_LINQ_05','S05','SC_LIN_QZ','ST04',86,'Verified','2026-07-20'),
('M_LINQ_06','S06','SC_LIN_QZ','ST04',75,'Verified','2026-07-20'),
('M_LINQ_07','S07','SC_LIN_QZ','ST04',80,'Verified','2026-07-20'),
('M_LINQ_08','S08','SC_LIN_QZ','ST04',88,'Verified','2026-07-20'),
('M_LINQ_09','S09','SC_LIN_QZ','ST04',0,'Verified','2026-07-20'),
('M_LINQ_10','S10','SC_LIN_QZ','ST04',75,'Verified','2026-07-20'),

-- LIN PROJECT (SC_LIN_PR)
('M_LINP_01','S01','SC_LIN_PR','ST04',85,'Verified','2026-07-22'),
('M_LINP_02','S02','SC_LIN_PR','ST04',80,'Verified','2026-07-22'),
('M_LINP_03','S03','SC_LIN_PR','ST04',72,'Verified','2026-07-22'),
('M_LINP_04','S04','SC_LIN_PR','ST04',92,'Verified','2026-07-22'),
('M_LINP_05','S05','SC_LIN_PR','ST04',88,'Verified','2026-07-22'),
('M_LINP_06','S06','SC_LIN_PR','ST04',78,'Verified','2026-07-22'),
('M_LINP_07','S07','SC_LIN_PR','ST04',84,'Verified','2026-07-22'),
('M_LINP_08','S08','SC_LIN_PR','ST04',90,'Verified','2026-07-22'),
('M_LINP_09','S09','SC_LIN_PR','ST04',0,'Verified','2026-07-22'),
('M_LINP_10','S10','SC_LIN_PR','ST04',76,'Verified','2026-07-22'),

-- LIN MID THEORY (SC_LIN_MT)
('M_LINM_01','S01','SC_LIN_MT','ST04',82,'Verified','2026-07-25'),
('M_LINM_02','S02','SC_LIN_MT','ST04',85,'Verified','2026-07-25'),
('M_LINM_03','S03','SC_LIN_MT','ST04',75,'Verified','2026-07-25'),
('M_LINM_04','S04','SC_LIN_MT','ST04',94,'Verified','2026-07-25'),
('M_LINM_05','S05','SC_LIN_MT','ST04',90,'Verified','2026-07-25'),
('M_LINM_06','S06','SC_LIN_MT','ST04',80,'Verified','2026-07-25'),
('M_LINM_07','S07','SC_LIN_MT','ST04',82,'Verified','2026-07-25'),
('M_LINM_08','S08','SC_LIN_MT','ST04',88,'Verified','2026-07-25'),
('M_LINM_09','S09','SC_LIN_MT','ST04',0,'Verified','2026-07-25'),
('M_LINM_10','S10','SC_LIN_MT','ST04',78,'Verified','2026-07-25'),

-- LIN FINAL THEORY (SC_LIN_FT)
('M_LINF_01','S01','SC_LIN_FT','ST04',85,'Verified','2026-08-20'),
('M_LINF_02','S02','SC_LIN_FT','ST04',80,'Verified','2026-08-20'),
('M_LINF_03','S03','SC_LIN_FT','ST04',75,'Verified','2026-08-20'),
('M_LINF_04','S04','SC_LIN_FT','ST04',90,'Verified','2026-08-20'),
('M_LINF_05','S05','SC_LIN_FT','ST04',92,'Verified','2026-08-20'),
('M_LINF_06','S06','SC_LIN_FT','ST04',78,'Verified','2026-08-20'),
('M_LINF_07','S07','SC_LIN_FT','ST04',85,'Verified','2026-08-20'),
('M_LINF_08','S08','SC_LIN_FT','ST04',92,'Verified','2026-08-20'),
('M_LINF_09','S09','SC_LIN_FT','ST04',0,'Verified','2026-08-20'),
('M_LINF_10','S10','SC_LIN_FT','ST04',80,'Verified','2026-08-20'),

-- -------------------------------------------------------------------------
-- 3. DBP (DBMS Practicum) - ST05 
-- -------------------------------------------------------------------------
-- DBP QUIZ (SC_DBP_QZ)
('M_DBPQ_01','S01','SC_DBP_QZ','ST05',85,'Verified','2026-07-20'),
('M_DBPQ_02','S02','SC_DBP_QZ','ST05',82,'Verified','2026-07-20'),
('M_DBPQ_03','S03','SC_DBP_QZ','ST05',70,'Verified','2026-07-20'),
('M_DBPQ_04','S04','SC_DBP_QZ','ST05',90,'Verified','2026-07-20'),
('M_DBPQ_05','S05','SC_DBP_QZ','ST05',92,'Verified','2026-07-20'),
('M_DBPQ_06','S06','SC_DBP_QZ','ST05',78,'Verified','2026-07-20'),
('M_DBPQ_07','S07','SC_DBP_QZ','ST05',85,'Verified','2026-07-20'),
('M_DBPQ_08','S08','SC_DBP_QZ','ST05',88,'Verified','2026-07-20'),
('M_DBPQ_09','S09','SC_DBP_QZ','ST05',0,'Verified','2026-07-20'),
('M_DBPQ_10','S10','SC_DBP_QZ','ST05',78,'Verified','2026-07-20'),

-- DBP PROJECT (SC_DBP_PR)
('M_DBPP_01','S01','SC_DBP_PR','ST05',88,'Verified','2026-07-22'),
('M_DBPP_02','S02','SC_DBP_PR','ST05',80,'Verified','2026-07-22'),
('M_DBPP_03','S03','SC_DBP_PR','ST05',74,'Verified','2026-07-22'),
('M_DBPP_04','S04','SC_DBP_PR','ST05',92,'Verified','2026-07-22'),
('M_DBPP_05','S05','SC_DBP_PR','ST05',95,'Verified','2026-07-22'),
('M_DBPP_06','S06','SC_DBP_PR','ST05',75,'Verified','2026-07-22'),
('M_DBPP_07','S07','SC_DBP_PR','ST05',86,'Verified','2026-07-22'),
('M_DBPP_08','S08','SC_DBP_PR','ST05',90,'Verified','2026-07-22'),
('M_DBPP_09','S09','SC_DBP_PR','ST05',0,'Verified','2026-07-22'),
('M_DBPP_10','S10','SC_DBP_PR','ST05',80,'Verified','2026-07-22'),

-- DBP MID PRACTICAL (SC_DBP_MP) <-- Updated as requested
('M_DBPM_01','S01','SC_DBP_MP','ST05',85,'Verified','2026-07-25'),
('M_DBPM_02','S02','SC_DBP_MP','ST05',82,'Verified','2026-07-25'),
('M_DBPM_03','S03','SC_DBP_MP','ST05',75,'Verified','2026-07-25'),
('M_DBPM_04','S04','SC_DBP_MP','ST05',94,'Verified','2026-07-25'),
('M_DBPM_05','S05','SC_DBP_MP','ST05',96,'Verified','2026-07-25'),
('M_DBPM_06','S06','SC_DBP_MP','ST05',78,'Verified','2026-07-25'),
('M_DBPM_07','S07','SC_DBP_MP','ST05',88,'Verified','2026-07-25'),
('M_DBPM_08','S08','SC_DBP_MP','ST05',91,'Verified','2026-07-25'),
('M_DBPM_09','S09','SC_DBP_MP','ST05',0,'Verified','2026-07-25'),
('M_DBPM_10','S10','SC_DBP_MP','ST05',80,'Verified','2026-07-25'),

-- DBP FINAL PRACTICAL (SC_DBP_FP)
('M_DBPF_01','S01','SC_DBP_FP','ST05',90,'Verified','2026-08-20'),
('M_DBPF_02','S02','SC_DBP_FP','ST05',86,'Verified','2026-08-20'),
('M_DBPF_03','S03','SC_DBP_FP','ST05',80,'Verified','2026-08-20'),
('M_DBPF_04','S04','SC_DBP_FP','ST05',95,'Verified','2026-08-20'),
('M_DBPF_05','S05','SC_DBP_FP','ST05',98,'Verified','2026-08-20'),
('M_DBPF_06','S06','SC_DBP_FP','ST05',82,'Verified','2026-08-20'),
('M_DBPF_07','S07','SC_DBP_FP','ST05',90,'Verified','2026-08-20'),
('M_DBPF_08','S08','SC_DBP_FP','ST05',94,'Verified','2026-08-20'),
('M_DBPF_09','S09','SC_DBP_FP','ST05',0,'Verified','2026-08-20'),
('M_DBPF_10','S10','SC_DBP_FP','ST05',85,'Verified','2026-08-20'),

-- -------------------------------------------------------------------------
-- 4. WEBT (Web Development Theory) - ST06
-- -------------------------------------------------------------------------
-- WEBT QUIZ (SC_WEB_QZ)
('M_WEBQ_01','S01','SC_WEB_QZ','ST06',86,'Verified','2026-07-20'),
('M_WEBQ_02','S02','SC_WEB_QZ','ST06',80,'Verified','2026-07-20'),
('M_WEBQ_03','S03','SC_WEB_QZ','ST06',72,'Verified','2026-07-20'),
('M_WEBQ_04','S04','SC_WEB_QZ','ST06',92,'Verified','2026-07-20'),
('M_WEBQ_05','S05','SC_WEB_QZ','ST06',90,'Verified','2026-07-20'),
('M_WEBQ_06','S06','SC_WEB_QZ','ST06',76,'Verified','2026-07-20'),
('M_WEBQ_07','S07','SC_WEB_QZ','ST06',82,'Verified','2026-07-20'),
('M_WEBQ_08','S08','SC_WEB_QZ','ST06',90,'Verified','2026-07-20'),
('M_WEBQ_09','S09','SC_WEB_QZ','ST06',0,'Verified','2026-07-20'),
('M_WEBQ_10','S10','SC_WEB_QZ','ST06',78,'Verified','2026-07-20'),

-- WEBT PROJECT (SC_WEB_PR)
('M_WEBP_01','S01','SC_WEB_PR','ST06',88,'Verified','2026-07-22'),
('M_WEBP_02','S02','SC_WEB_PR','ST06',82,'Verified','2026-07-22'),
('M_WEBP_03','S03','SC_WEB_PR','ST06',74,'Verified','2026-07-22'),
('M_WEBP_04','S04','SC_WEB_PR','ST06',94,'Verified','2026-07-22'),
('M_WEBP_05','S05','SC_WEB_PR','ST06',92,'Verified','2026-07-22'),
('M_WEBP_06','S06','SC_WEB_PR','ST06',78,'Verified','2026-07-22'),
('M_WEBP_07','S07','SC_WEB_PR','ST06',84,'Verified','2026-07-22'),
('M_WEBP_08','S08','SC_WEB_PR','ST06',92,'Verified','2026-07-22'),
('M_WEBP_09','S09','SC_WEB_PR','ST06',0,'Verified','2026-07-22'),
('M_WEBP_10','S10','SC_WEB_PR','ST06',80,'Verified','2026-07-22'),

-- WEBT MID THEORY (SC_WEB_MT)
('M_WEBM_01','S01','SC_WEB_MT','ST06',84,'Verified','2026-07-25'),
('M_WEBM_02','S02','SC_WEB_MT','ST06',80,'Verified','2026-07-25'),
('M_WEBM_03','S03','SC_WEB_MT','ST06',72,'Verified','2026-07-25'),
('M_WEBM_04','S04','SC_WEB_MT','ST06',92,'Verified','2026-07-25'),
('M_WEBM_05','S05','SC_WEB_MT','ST06',90,'Verified','2026-07-25'),
('M_WEBM_06','S06','SC_WEB_MT','ST06',76,'Verified','2026-07-25'),
('M_WEBM_07','S07','SC_WEB_MT','ST06',82,'Verified','2026-07-25'),
('M_WEBM_08','S08','SC_WEB_MT','ST06',90,'Verified','2026-07-25'),
('M_WEBM_09','S09','SC_WEB_MT','ST06',0,'Verified','2026-07-25'),
('M_WEBM_10','S10','SC_WEB_MT','ST06',78,'Verified','2026-07-25'),

-- WEBT FINAL THEORY (SC_WEB_FT)
('M_WEBF_01','S01','SC_WEB_FT','ST06',88,'Verified','2026-08-20'),
('M_WEBF_02','S02','SC_WEB_FT','ST06',84,'Verified','2026-08-20'),
('M_WEBF_03','S03','SC_WEB_FT','ST06',75,'Verified','2026-08-20'),
('M_WEBF_04','S04','SC_WEB_FT','ST06',94,'Verified','2026-08-20'),
('M_WEBF_05','S05','SC_WEB_FT','ST06',92,'Verified','2026-08-20'),
('M_WEBF_06','S06','SC_WEB_FT','ST06',78,'Verified','2026-08-20'),
('M_WEBF_07','S07','SC_WEB_FT','ST06',85,'Verified','2026-08-20'),
('M_WEBF_08','S08','SC_WEB_FT','ST06',92,'Verified','2026-08-20'),
('M_WEBF_09','S09','SC_WEB_FT','ST06',0,'Verified','2026-08-20'),
('M_WEBF_10','S10','SC_WEB_FT','ST06',80,'Verified','2026-08-20'),

-- -------------------------------------------------------------------------
-- 5. WEBP (Web Development Practicum) - ST07
-- -------------------------------------------------------------------------
-- WEBP QUIZ (SC_WEP_QZ)
('M_WEPQ_01','S01','SC_WEP_QZ','ST07',85,'Verified','2026-07-20'),
('M_WEPQ_02','S02','SC_WEP_QZ','ST07',75,'Verified','2026-07-20'),
('M_WEPQ_03','S03','SC_WEP_QZ','ST07',65,'Verified','2026-07-20'),
('M_WEPQ_04','S04','SC_WEP_QZ','ST07',95,'Verified','2026-07-20'),
('M_WEPQ_05','S05','SC_WEP_QZ','ST07',88,'Verified','2026-07-20'),
('M_WEPQ_06','S06','SC_WEP_QZ','ST07',78,'Verified','2026-07-20'),
('M_WEPQ_07','S07','SC_WEP_QZ','ST07',82,'Verified','2026-07-20'),
('M_WEPQ_08','S08','SC_WEP_QZ','ST07',90,'Verified','2026-07-20'),
('M_WEPQ_09','S09','SC_WEP_QZ','ST07',0,'Verified','2026-07-20'),
('M_WEPQ_10','S10','SC_WEP_QZ','ST07',72,'Verified','2026-07-20'),

-- WEBP PROJECT (SC_WEP_PR)
('M_WEPP_01','S01','SC_WEP_PR','ST07',88,'Verified','2026-07-22'),
('M_WEPP_02','S02','SC_WEP_PR','ST07',79,'Verified','2026-07-22'),
('M_WEPP_03','S03','SC_WEP_PR','ST07',68,'Verified','2026-07-22'),
('M_WEPP_04','S04','SC_WEP_PR','ST07',92,'Verified','2026-07-22'),
('M_WEPP_05','S05','SC_WEP_PR','ST07',85,'Verified','2026-07-22'),
('M_WEPP_06','S06','SC_WEP_PR','ST07',75,'Verified','2026-07-22'),
('M_WEPP_07','S07','SC_WEP_PR','ST07',84,'Verified','2026-07-22'),
('M_WEPP_08','S08','SC_WEP_PR','ST07',92,'Verified','2026-07-22'),
('M_WEPP_09','S09','SC_WEP_PR','ST07',0,'Verified','2026-07-22'),
('M_WEPP_10','S10','SC_WEP_PR','ST07',74,'Verified','2026-07-22'),

-- WEBP MID PRACTICAL (SC_WEP_MP) <-- Updated as requested
('M_WEPM_01','S01','SC_WEP_MP','ST07',80,'Verified','2026-07-25'),
('M_WEPM_02','S02','SC_WEP_MP','ST07',82,'Verified','2026-07-25'),
('M_WEPM_03','S03','SC_WEP_MP','ST07',70,'Verified','2026-07-25'),
('M_WEPM_04','S04','SC_WEP_MP','ST07',90,'Verified','2026-07-25'),
('M_WEPM_05','S05','SC_WEP_MP','ST07',88,'Verified','2026-07-25'),
('M_WEPM_06','S06','SC_WEP_MP','ST07',75,'Verified','2026-07-25'),
('M_WEPM_07','S07','SC_WEP_MP','ST07',80,'Verified','2026-07-25'),
('M_WEPM_08','S08','SC_WEP_MP','ST07',88,'Verified','2026-07-25'),
('M_WEPM_09','S09','SC_WEP_MP','ST07',0,'Verified','2026-07-25'),
('M_WEPM_10','S10','SC_WEP_MP','ST07',75,'Verified','2026-07-25'),

-- WEBP FINAL PRACTICAL (SC_WEP_FP)
('M_WEPF_01','S01','SC_WEP_FP','ST07',90,'Verified','2026-08-20'),
('M_WEPF_02','S02','SC_WEP_FP','ST07',86,'Verified','2026-08-20'),
('M_WEPF_03','S03','SC_WEP_FP','ST07',80,'Verified','2026-08-20'),
('M_WEPF_04','S04','SC_WEP_FP','ST07',95,'Verified','2026-08-20'),
('M_WEPF_05','S05','SC_WEP_FP','ST07',98,'Verified','2026-08-20'),
('M_WEPF_06','S06','SC_WEP_FP','ST07',82,'Verified','2026-08-20'),
('M_WEPF_07','S07','SC_WEP_FP','ST07',90,'Verified','2026-08-20'),
('M_WEPF_08','S08','SC_WEP_FP','ST07',94,'Verified','2026-08-20'),
('M_WEPF_09','S09','SC_WEP_FP','ST07',0,'Verified','2026-08-20'),
('M_WEPF_10','S10','SC_WEP_FP','ST07',85,'Verified','2026-08-20'),

-- -------------------------------------------------------------------------
-- 6. MAT (Discrete Mathematics) - ST08
-- -------------------------------------------------------------------------
-- MAT QUIZ (SC_MAT_QZ)
('M_MATQ_01','S01','SC_MAT_QZ','ST08',85,'Verified','2026-07-20'),
('M_MATQ_02','S02','SC_MAT_QZ','ST08',75,'Verified','2026-07-20'),
('M_MATQ_03','S03','SC_MAT_QZ','ST08',65,'Verified','2026-07-20'),
('M_MATQ_04','S04','SC_MAT_QZ','ST08',95,'Verified','2026-07-20'),
('M_MATQ_05','S05','SC_MAT_QZ','ST08',88,'Verified','2026-07-20'),
('M_MATQ_06','S06','SC_MAT_QZ','ST08',78,'Verified','2026-07-20'),
('M_MATQ_07','S07','SC_MAT_QZ','ST08',82,'Verified','2026-07-20'),
('M_MATQ_08','S08','SC_MAT_QZ','ST08',90,'Verified','2026-07-20'),
('M_MATQ_09','S09','SC_MAT_QZ','ST08',0,'Verified','2026-07-20'),
('M_MATQ_10','S10','SC_MAT_QZ','ST08',72,'Verified','2026-07-20'),

-- MAT PROJECT (SC_MAT_PR)
('M_MATP_01','S01','SC_MAT_PR','ST08',88,'Verified','2026-07-22'),
('M_MATP_02','S02','SC_MAT_PR','ST08',79,'Verified','2026-07-22'),
('M_MATP_03','S03','SC_MAT_PR','ST08',68,'Verified','2026-07-22'),
('M_MATP_04','S04','SC_MAT_PR','ST08',92,'Verified','2026-07-22'),
('M_MATP_05','S05','SC_MAT_PR','ST08',85,'Verified','2026-07-22'),
('M_MATP_06','S06','SC_MAT_PR','ST08',75,'Verified','2026-07-22'),
('M_MATP_07','S07','SC_MAT_PR','ST08',84,'Verified','2026-07-22'),
('M_MATP_08','S08','SC_MAT_PR','ST08',92,'Verified','2026-07-22'),
('M_MATP_09','S09','SC_MAT_PR','ST08',0,'Verified','2026-07-22'),
('M_MATP_10','S10','SC_MAT_PR','ST08',74,'Verified','2026-07-22'),

-- MAT MID THEORY (SC_MAT_MT)
('M_MATM_01','S01','SC_MAT_MT','ST08',80,'Verified','2026-07-25'),
('M_MATM_02','S02','SC_MAT_MT','ST08',82,'Verified','2026-07-25'),
('M_MATM_03','S03','SC_MAT_MT','ST08',70,'Verified','2026-07-25'),
('M_MATM_04','S04','SC_MAT_MT','ST08',90,'Verified','2026-07-25'),
('M_MATM_05','S05','SC_MAT_MT','ST08',88,'Verified','2026-07-25'),
('M_MATM_06','S06','SC_MAT_MT','ST08',75,'Verified','2026-07-25'),
('M_MATM_07','S07','SC_MAT_MT','ST08',80,'Verified','2026-07-25'),
('M_MATM_08','S08','SC_MAT_MT','ST08',88,'Verified','2026-07-25'),
('M_MATM_09','S09','SC_MAT_MT','ST08',0,'Verified','2026-07-25'),
('M_MATM_10','S10','SC_MAT_MT','ST08',75,'Verified','2026-07-25'),

-- MAT FINAL THEORY (SC_MAT_FT)
('M_MATF_01','S01','SC_MAT_FT','ST08',88,'Verified','2026-08-20'),
('M_MATF_02','S02','SC_MAT_FT','ST08',85,'Verified','2026-08-20'),
('M_MATF_03','S03','SC_MAT_FT','ST08',72,'Verified','2026-08-20'),
('M_MATF_04','S04','SC_MAT_FT','ST08',90,'Verified','2026-08-20'),
('M_MATF_05','S05','SC_MAT_FT','ST08',92,'Verified','2026-08-20'),
('M_MATF_06','S06','SC_MAT_FT','ST08',80,'Verified','2026-08-20'),
('M_MATF_07','S07','SC_MAT_FT','ST08',82,'Verified','2026-08-20'),
('M_MATF_08','S08','SC_MAT_FT','ST08',90,'Verified','2026-08-20'),
('M_MATF_09','S09','SC_MAT_FT','ST08',0,'Verified','2026-08-20'),
('M_MATF_10','S10','SC_MAT_FT','ST08',78,'Verified','2026-08-20'),

-- -------------------------------------------------------------------------
-- 7. ENG (English II) - ST09
-- -------------------------------------------------------------------------
-- ENG QUIZ (SC_ENG_QZ)
('M_ENGQ_01','S01','SC_ENG_QZ','ST09',85,'Verified','2026-07-20'),
('M_ENGQ_02','S02','SC_ENG_QZ','ST09',75,'Verified','2026-07-20'),
('M_ENGQ_03','S03','SC_ENG_QZ','ST09',65,'Verified','2026-07-20'),
('M_ENGQ_04','S04','SC_ENG_QZ','ST09',95,'Verified','2026-07-20'),
('M_ENGQ_05','S05','SC_ENG_QZ','ST09',88,'Verified','2026-07-20'),
('M_ENGQ_06','S06','SC_ENG_QZ','ST09',78,'Verified','2026-07-20'),
('M_ENGQ_07','S07','SC_ENG_QZ','ST09',82,'Verified','2026-07-20'),
('M_ENGQ_08','S08','SC_ENG_QZ','ST09',90,'Verified','2026-07-20'),
('M_ENGQ_09','S09','SC_ENG_QZ','ST09',0,'Verified','2026-07-20'),
('M_ENGQ_10','S10','SC_ENG_QZ','ST09',72,'Verified','2026-07-20'),

-- ENG PROJECT (SC_ENG_PR)
('M_ENGP_01','S01','SC_ENG_PR','ST09',88,'Verified','2026-07-22'),
('M_ENGP_02','S02','SC_ENG_PR','ST09',79,'Verified','2026-07-22'),
('M_ENGP_03','S03','SC_ENG_PR','ST09',68,'Verified','2026-07-22'),
('M_ENGP_04','S04','SC_ENG_PR','ST09',92,'Verified','2026-07-22'),
('M_ENGP_05','S05','SC_ENG_PR','ST09',85,'Verified','2026-07-22'),
('M_ENGP_06','S06','SC_ENG_PR','ST09',75,'Verified','2026-07-22'),
('M_ENGP_07','S07','SC_ENG_PR','ST09',84,'Verified','2026-07-22'),
('M_ENGP_08','S08','SC_ENG_PR','ST09',92,'Verified','2026-07-22'),
('M_ENGP_09','S09','SC_ENG_PR','ST09',0,'Verified','2026-07-22'),
('M_ENGP_10','S10','SC_ENG_PR','ST09',74,'Verified','2026-07-22'),

-- ENG MID THEORY (SC_ENG_MT)
('M_ENGM_01','S01','SC_ENG_MT','ST09',80,'Verified','2026-07-25'),
('M_ENGM_02','S02','SC_ENG_MT','ST09',82,'Verified','2026-07-25'),
('M_ENGM_03','S03','SC_ENG_MT','ST09',70,'Verified','2026-07-25'),
('M_ENGM_04','S04','SC_ENG_MT','ST09',90,'Verified','2026-07-25'),
('M_ENGM_05','S05','SC_ENG_MT','ST09',88,'Verified','2026-07-25'),
('M_ENGM_06','S06','SC_ENG_MT','ST09',75,'Verified','2026-07-25'),
('M_ENGM_07','S07','SC_ENG_MT','ST09',80,'Verified','2026-07-25'),
('M_ENGM_08','S08','SC_ENG_MT','ST09',88,'Verified','2026-07-25'),
('M_ENGM_09','S09','SC_ENG_MT','ST09',0,'Verified','2026-07-25'),
('M_ENGM_10','S10','SC_ENG_MT','ST09',75,'Verified','2026-07-25'),

-- ENG FINAL THEORY (SC_ENG_FT)
('M_ENGF_01','S01','SC_ENG_FT','ST09',88,'Verified','2026-08-20'),
('M_ENGF_02','S02','SC_ENG_FT','ST09',85,'Verified','2026-08-20'),
('M_ENGF_03','S03','SC_ENG_FT','ST09',72,'Verified','2026-08-20'),
('M_ENGF_04','S04','SC_ENG_FT','ST09',90,'Verified','2026-08-20'),
('M_ENGF_05','S05','SC_ENG_FT','ST09',92,'Verified','2026-08-20'),
('M_ENGF_06','S06','SC_ENG_FT','ST09',80,'Verified','2026-08-20'),
('M_ENGF_07','S07','SC_ENG_FT','ST09',82,'Verified','2026-08-20'),
('M_ENGF_08','S08','SC_ENG_FT','ST09',90,'Verified','2026-08-20'),
('M_ENGF_09','S09','SC_ENG_FT','ST09',0,'Verified','2026-08-20'),
('M_ENGF_10','S10','SC_ENG_FT','ST09',78,'Verified','2026-08-20'),

-- -------------------------------------------------------------------------
-- 8. DBS (Database Management Systems) - ST10
-- -------------------------------------------------------------------------
-- DBS QUIZ (SC_DBS_QZ)
('M_DBSQ_01','S01','SC_DBS_QZ','ST10',85,'Verified','2026-07-20'),
('M_DBSQ_02','S02','SC_DBS_QZ','ST10',75,'Verified','2026-07-20'),
('M_DBSQ_03','S03','SC_DBS_QZ','ST10',65,'Verified','2026-07-20'),
('M_DBSQ_04','S04','SC_DBS_QZ','ST10',95,'Verified','2026-07-20'),
('M_DBSQ_05','S05','SC_DBS_QZ','ST10',88,'Verified','2026-07-20'),
('M_DBSQ_06','S06','SC_DBS_QZ','ST10',78,'Verified','2026-07-20'),
('M_DBSQ_07','S07','SC_DBS_QZ','ST10',82,'Verified','2026-07-20'),
('M_DBSQ_08','S08','SC_DBS_QZ','ST10',90,'Verified','2026-07-20'),
('M_DBSQ_09','S09','SC_DBS_QZ','ST10',0,'Verified','2026-07-20'),
('M_DBSQ_10','S10','SC_DBS_QZ','ST10',72,'Verified','2026-07-20'),

-- DBS PROJECT (SC_DBS_PR)
('M_DBSP_01','S01','SC_DBS_PR','ST10',88,'Verified','2026-07-22'),
('M_DBSP_02','S02','SC_DBS_PR','ST10',79,'Verified','2026-07-22'),
('M_DBSP_03','S03','SC_DBS_PR','ST10',68,'Verified','2026-07-22'),
('M_DBSP_04','S04','SC_DBS_PR','ST10',92,'Verified','2026-07-22'),
('M_DBSP_05','S05','SC_DBS_PR','ST10',85,'Verified','2026-07-22'),
('M_DBSP_06','S06','SC_DBS_PR','ST10',75,'Verified','2026-07-22'),
('M_DBSP_07','S07','SC_DBS_PR','ST10',84,'Verified','2026-07-22'),
('M_DBSP_08','S08','SC_DBS_PR','ST10',92,'Verified','2026-07-22'),
('M_DBSP_09','S09','SC_DBS_PR','ST10',0,'Verified','2026-07-22'),
('M_DBSP_10','S10','SC_DBS_PR','ST10',74,'Verified','2026-07-22'),

-- DBS MID THEORY (SC_DBS_MT)
('M_DBSM_01','S01','SC_DBS_MT','ST10',80,'Verified','2026-07-25'),
('M_DBSM_02','S02','SC_DBS_MT','ST10',82,'Verified','2026-07-25'),
('M_DBSM_03','S03','SC_DBS_MT','ST10',70,'Verified','2026-07-25'),
('M_DBSM_04','S04','SC_DBS_MT','ST10',90,'Verified','2026-07-25'),
('M_DBSM_05','S05','SC_DBS_MT','ST10',88,'Verified','2026-07-25'),
('M_DBSM_06','S06','SC_DBS_MT','ST10',75,'Verified','2026-07-25'),
('M_DBSM_07','S07','SC_DBS_MT','ST10',80,'Verified','2026-07-25'),
('M_DBSM_08','S08','SC_DBS_MT','ST10',88,'Verified','2026-07-25'),
('M_DBSM_09','S09','SC_DBS_MT','ST10',0,'Verified','2026-07-25'),
('M_DBSM_10','S10','SC_DBS_MT','ST10',75,'Verified','2026-07-25'),

-- DBS FINAL THEORY (SC_DBS_FT)
('M_DBSF_01','S01','SC_DBS_FT','ST10',88,'Verified','2026-08-20'),
('M_DBSF_02','S02','SC_DBS_FT','ST10',85,'Verified','2026-08-20'),
('M_DBSF_03','S03','SC_DBS_FT','ST10',72,'Verified','2026-08-20'),
('M_DBSF_04','S04','SC_DBS_FT','ST10',90,'Verified','2026-08-20'),
('M_DBSF_05','S05','SC_DBS_FT','ST10',92,'Verified','2026-08-20'),
('M_DBSF_06','S06','SC_DBS_FT','ST10',80,'Verified','2026-08-20'),
('M_DBSF_07','S07','SC_DBS_FT','ST10',82,'Verified','2026-08-20'),
('M_DBSF_08','S08','SC_DBS_FT','ST10',90,'Verified','2026-08-20'),
('M_DBSF_09','S09','SC_DBS_FT','ST10',0,'Verified','2026-08-20'),
('M_DBSF_10','S10','SC_DBS_FT','ST10',78,'Verified','2026-08-20'),

-- -------------------------------------------------------------------------
-- 9. OSC (OS Concepts and Application) - ST03
-- -------------------------------------------------------------------------
-- OSC QUIZ (SC_OSC_QZ)
('M_OSCQ_01','S01','SC_OSC_QZ','ST03',85,'Verified','2026-07-20'),
('M_OSCQ_02','S02','SC_OSC_QZ','ST03',75,'Verified','2026-07-20'),
('M_OSCQ_03','S03','SC_OSC_QZ','ST03',65,'Verified','2026-07-20'),
('M_OSCQ_04','S04','SC_OSC_QZ','ST03',95,'Verified','2026-07-20'),
('M_OSCQ_05','S05','SC_OSC_QZ','ST03',88,'Verified','2026-07-20'),
('M_OSCQ_06','S06','SC_OSC_QZ','ST03',78,'Verified','2026-07-20'),
('M_OSCQ_07','S07','SC_OSC_QZ','ST03',82,'Verified','2026-07-20'),
('M_OSCQ_08','S08','SC_OSC_QZ','ST03',90,'Verified','2026-07-20'),
('M_OSCQ_09','S09','SC_OSC_QZ','ST03',0,'Verified','2026-07-20'),
('M_OSCQ_10','S10','SC_OSC_QZ','ST03',72,'Verified','2026-07-20'),

-- OSC PROJECT (SC_OSC_PR)
('M_OSCP_01','S01','SC_OSC_PR','ST03',88,'Verified','2026-07-22'),
('M_OSCP_02','S02','SC_OSC_PR','ST03',79,'Verified','2026-07-22'),
('M_OSCP_03','S03','SC_OSC_PR','ST03',68,'Verified','2026-07-22'),
('M_OSCP_04','S04','SC_OSC_PR','ST03',92,'Verified','2026-07-22'),
('M_OSCP_05','S05','SC_OSC_PR','ST03',85,'Verified','2026-07-22'),
('M_OSCP_06','S06','SC_OSC_PR','ST03',75,'Verified','2026-07-22'),
('M_OSCP_07','S07','SC_OSC_PR','ST03',84,'Verified','2026-07-22'),
('M_OSCP_08','S08','SC_OSC_PR','ST03',92,'Verified','2026-07-22'),
('M_OSCP_09','S09','SC_OSC_PR','ST03',0,'Verified','2026-07-22'),
('M_OSCP_10','S10','SC_OSC_PR','ST03',74,'Verified','2026-07-22'),

-- OSC MID THEORY (SC_OSC_MT)
('M_OSCM_01','S01','SC_OSC_MT','ST03',80,'Verified','2026-07-25'),
('M_OSCM_02','S02','SC_OSC_MT','ST03',82,'Verified','2026-07-25'),
('M_OSCM_03','S03','SC_OSC_MT','ST03',70,'Verified','2026-07-25'),
('M_OSCM_04','S04','SC_OSC_MT','ST03',90,'Verified','2026-07-25'),
('M_OSCM_05','S05','SC_OSC_MT','ST03',88,'Verified','2026-07-25'),
('M_OSCM_06','S06','SC_OSC_MT','ST03',75,'Verified','2026-07-25'),
('M_OSCM_07','S07','SC_OSC_MT','ST03',80,'Verified','2026-07-25'),
('M_OSCM_08','S08','SC_OSC_MT','ST03',88,'Verified','2026-07-25'),
('M_OSCM_09','S09','SC_OSC_MT','ST03',0,'Verified','2026-07-25'),
('M_OSCM_10','S10','SC_OSC_MT','ST03',75,'Verified','2026-07-25'),

-- OSC FINAL THEORY (SC_OSC_FT)
('M_OSCF_01','S01','SC_OSC_FT','ST03',88,'Verified','2026-08-20'),
('M_OSCF_02','S02','SC_OSC_FT','ST03',85,'Verified','2026-08-20'),
('M_OSCF_03','S03','SC_OSC_FT','ST03',72,'Verified','2026-08-20'),
('M_OSCF_04','S04','SC_OSC_FT','ST03',90,'Verified','2026-08-20'),
('M_OSCF_05','S05','SC_OSC_FT','ST03',92,'Verified','2026-08-20'),
('M_OSCF_06','S06','SC_OSC_FT','ST03',80,'Verified','2026-08-20'),
('M_OSCF_07','S07','SC_OSC_FT','ST03',82,'Verified','2026-08-20'),
('M_OSCF_08','S08','SC_OSC_FT','ST03',90,'Verified','2026-08-20'),
('M_OSCF_09','S09','SC_OSC_FT','ST03',0,'Verified','2026-08-20'),
('M_OSCF_10','S10','SC_OSC_FT','ST03',78,'Verified','2026-08-20');                  


INSERT INTO STUDENT_MARK (Mark_ID, Student_ID, Scheme_ID, entered_by, raw_mark, mark_status, entered_date) VALUES

-- -------------------------------------------------------------------------
-- MGT (Fundamentals of Management) - ST03
-- -------------------------------------------------------------------------
-- MGT QUIZ (SC_MGT_QZ)
('M_MGTQ_11','S11','SC_MGT_QZ','ST03',85,'Verified','2026-07-20'),
('M_MGTQ_12','S12','SC_MGT_QZ','ST03',68,'Verified','2026-07-20'),
('M_MGTQ_13','S13','SC_MGT_QZ','ST03',0,'Verified','2026-07-20'),
('M_MGTQ_14','S14','SC_MGT_QZ','ST03',88,'Verified','2026-07-20'),
('M_MGTQ_15','S15','SC_MGT_QZ','ST03',73,'Verified','2026-07-20'),
('M_MGTQ_16','S16','SC_MGT_QZ','ST03',72,'Verified','2026-07-20'),
('M_MGTQ_17','S17','SC_MGT_QZ','ST03',25,'Verified','2026-07-20'),
('M_MGTQ_18','S18','SC_MGT_QZ','ST03',69,'Verified','2026-07-20'),
('M_MGTQ_19','S19','SC_MGT_QZ','ST03',42,'Verified','2026-07-20'),
('M_MGTQ_20','S20','SC_MGT_QZ','ST03',68,'Verified','2026-07-20'),
('M_MGTQ_21','S21','SC_MGT_QZ','ST03',42,'Verified','2026-07-20'),
('M_MGTQ_22','S22','SC_MGT_QZ','ST03',88,'Verified','2026-07-20'),
('M_MGTQ_23','S23','SC_MGT_QZ','ST03',93,'Verified','2026-07-20'),
('M_MGTQ_24','S24','SC_MGT_QZ','ST03',40,'Verified','2026-07-20'),
('M_MGTQ_25','S25','SC_MGT_QZ','ST03',67,'Verified','2026-07-20'),

-- MGT PROJECT (SC_MGT_PR)
('M_MGTP_11','S11','SC_MGT_PR','ST03',83,'Verified','2026-07-22'),
('M_MGTP_12','S12','SC_MGT_PR','ST03',78,'Verified','2026-07-22'),
('M_MGTP_13','S13','SC_MGT_PR','ST03',0,'Verified','2026-07-22'),
('M_MGTP_14','S14','SC_MGT_PR','ST03',65,'Verified','2026-07-22'),
('M_MGTP_15','S15','SC_MGT_PR','ST03',67,'Verified','2026-07-22'),
('M_MGTP_16','S16','SC_MGT_PR','ST03',71,'Verified','2026-07-22'),
('M_MGTP_17','S17','SC_MGT_PR','ST03',25,'Verified','2026-07-22'),
('M_MGTP_18','S18','SC_MGT_PR','ST03',81,'Verified','2026-07-22'),
('M_MGTP_19','S19','SC_MGT_PR','ST03',40,'Verified','2026-07-22'),
('M_MGTP_20','S20','SC_MGT_PR','ST03',65,'Verified','2026-07-22'),
('M_MGTP_21','S21','SC_MGT_PR','ST03',40,'Verified','2026-07-22'),
('M_MGTP_22','S22','SC_MGT_PR','ST03',71,'Verified','2026-07-22'),
('M_MGTP_23','S23','SC_MGT_PR','ST03',87,'Verified','2026-07-22'),
('M_MGTP_24','S24','SC_MGT_PR','ST03',42,'Verified','2026-07-22'),
('M_MGTP_25','S25','SC_MGT_PR','ST03',87,'Verified','2026-07-22'),

-- MGT MID THEORY (SC_MGT_MT)
('M_MGTM_11','S11','SC_MGT_MT','ST03',82,'Verified','2026-07-25'),
('M_MGTM_12','S12','SC_MGT_MT','ST03',78,'Verified','2026-07-25'),
('M_MGTM_13','S13','SC_MGT_MT','ST03',25,'Verified','2026-07-25'),
('M_MGTM_14','S14','SC_MGT_MT','ST03',79,'Verified','2026-07-25'),
('M_MGTM_15','S15','SC_MGT_MT','ST03',83,'Verified','2026-07-25'),
('M_MGTM_16','S16','SC_MGT_MT','ST03',73,'Verified','2026-07-25'),
('M_MGTM_17','S17','SC_MGT_MT','ST03',0,'Verified','2026-07-25'),
('M_MGTM_18','S18','SC_MGT_MT','ST03',89,'Verified','2026-07-25'),
('M_MGTM_19','S19','SC_MGT_MT','ST03',25,'Verified','2026-07-25'),
('M_MGTM_20','S20','SC_MGT_MT','ST03',87,'Verified','2026-07-25'),
('M_MGTM_21','S21','SC_MGT_MT','ST03',35,'Verified','2026-07-25'),
('M_MGTM_22','S22','SC_MGT_MT','ST03',75,'Verified','2026-07-25'),
('M_MGTM_23','S23','SC_MGT_MT','ST03',73,'Verified','2026-07-25'),
('M_MGTM_24','S24','SC_MGT_MT','ST03',25,'Verified','2026-07-25'),
('M_MGTM_25','S25','SC_MGT_MT','ST03',71,'Verified','2026-07-25'),

-- MGT FINAL THEORY (SC_MGT_FT)
('M_MGTF_11','S11','SC_MGT_FT','ST03',95,'Verified','2026-08-20'),
('M_MGTF_12','S12','SC_MGT_FT','ST03',89,'Verified','2026-08-20'),
('M_MGTF_13','S13','SC_MGT_FT','ST03',30,'Verified','2026-08-20'),
('M_MGTF_14','S14','SC_MGT_FT','ST03',68,'Verified','2026-08-20'),
('M_MGTF_15','S15','SC_MGT_FT','ST03',67,'Verified','2026-08-20'),
('M_MGTF_16','S16','SC_MGT_FT','ST03',77,'Verified','2026-08-20'),
('M_MGTF_17','S17','SC_MGT_FT','ST03',0,'Verified','2026-08-20'),
('M_MGTF_18','S18','SC_MGT_FT','ST03',76,'Verified','2026-08-20'),
('M_MGTF_19','S19','SC_MGT_FT','ST03',30,'Verified','2026-08-20'),
('M_MGTF_20','S20','SC_MGT_FT','ST03',84,'Verified','2026-08-20'),
('M_MGTF_21','S21','SC_MGT_FT','ST03',30,'Verified','2026-08-20'),
('M_MGTF_22','S22','SC_MGT_FT','ST03',90,'Verified','2026-08-20'),
('M_MGTF_23','S23','SC_MGT_FT','ST03',66,'Verified','2026-08-20'),
('M_MGTF_24','S24','SC_MGT_FT','ST03',42,'Verified','2026-08-20'),
('M_MGTF_25','S25','SC_MGT_FT','ST03',79,'Verified','2026-08-20'),

-- -------------------------------------------------------------------------
-- LIN (System Prog. Fundamentals & Linux) - ST04
-- -------------------------------------------------------------------------
-- LIN QUIZ (SC_LIN_QZ)
('M_LINQ_11','S11','SC_LIN_QZ','ST04',82,'Verified','2026-07-20'),
('M_LINQ_12','S12','SC_LIN_QZ','ST04',68,'Verified','2026-07-20'),
('M_LINQ_13','S13','SC_LIN_QZ','ST04',35,'Verified','2026-07-20'),
('M_LINQ_14','S14','SC_LIN_QZ','ST04',67,'Verified','2026-07-20'),
('M_LINQ_15','S15','SC_LIN_QZ','ST04',82,'Verified','2026-07-20'),
('M_LINQ_16','S16','SC_LIN_QZ','ST04',74,'Verified','2026-07-20'),
('M_LINQ_17','S17','SC_LIN_QZ','ST04',42,'Verified','2026-07-20'),
('M_LINQ_18','S18','SC_LIN_QZ','ST04',84,'Verified','2026-07-20'),
('M_LINQ_19','S19','SC_LIN_QZ','ST04',30,'Verified','2026-07-20'),
('M_LINQ_20','S20','SC_LIN_QZ','ST04',83,'Verified','2026-07-20'),
('M_LINQ_21','S21','SC_LIN_QZ','ST04',25,'Verified','2026-07-20'),
('M_LINQ_22','S22','SC_LIN_QZ','ST04',87,'Verified','2026-07-20'),
('M_LINQ_23','S23','SC_LIN_QZ','ST04',67,'Verified','2026-07-20'),
('M_LINQ_24','S24','SC_LIN_QZ','ST04',0,'Verified','2026-07-20'),
('M_LINQ_25','S25','SC_LIN_QZ','ST04',86,'Verified','2026-07-20'),

-- LIN PROJECT (SC_LIN_PR)
('M_LINP_11','S11','SC_LIN_PR','ST04',72,'Verified','2026-07-22'),
('M_LINP_12','S12','SC_LIN_PR','ST04',89,'Verified','2026-07-22'),
('M_LINP_13','S13','SC_LIN_PR','ST04',30,'Verified','2026-07-22'),
('M_LINP_14','S14','SC_LIN_PR','ST04',67,'Verified','2026-07-22'),
('M_LINP_15','S15','SC_LIN_PR','ST04',92,'Verified','2026-07-22'),
('M_LINP_16','S16','SC_LIN_PR','ST04',72,'Verified','2026-07-22'),
('M_LINP_17','S17','SC_LIN_PR','ST04',0,'Verified','2026-07-22'),
('M_LINP_18','S18','SC_LIN_PR','ST04',77,'Verified','2026-07-22'),
('M_LINP_19','S19','SC_LIN_PR','ST04',30,'Verified','2026-07-22'),
('M_LINP_20','S20','SC_LIN_PR','ST04',79,'Verified','2026-07-22'),
('M_LINP_21','S21','SC_LIN_PR','ST04',42,'Verified','2026-07-22'),
('M_LINP_22','S22','SC_LIN_PR','ST04',91,'Verified','2026-07-22'),
('M_LINP_23','S23','SC_LIN_PR','ST04',76,'Verified','2026-07-22'),
('M_LINP_24','S24','SC_LIN_PR','ST04',25,'Verified','2026-07-22'),
('M_LINP_25','S25','SC_LIN_PR','ST04',76,'Verified','2026-07-22'),

-- LIN MID THEORY (SC_LIN_MT)
('M_LINM_11','S11','SC_LIN_MT','ST04',76,'Verified','2026-07-25'),
('M_LINM_12','S12','SC_LIN_MT','ST04',71,'Verified','2026-07-25'),
('M_LINM_13','S13','SC_LIN_MT','ST04',42,'Verified','2026-07-25'),
('M_LINM_14','S14','SC_LIN_MT','ST04',73,'Verified','2026-07-25'),
('M_LINM_15','S15','SC_LIN_MT','ST04',87,'Verified','2026-07-25'),
('M_LINM_16','S16','SC_LIN_MT','ST04',94,'Verified','2026-07-25'),
('M_LINM_17','S17','SC_LIN_MT','ST04',42,'Verified','2026-07-25'),
('M_LINM_18','S18','SC_LIN_MT','ST04',85,'Verified','2026-07-25'),
('M_LINM_19','S19','SC_LIN_MT','ST04',0,'Verified','2026-07-25'),
('M_LINM_20','S20','SC_LIN_MT','ST04',84,'Verified','2026-07-25'),
('M_LINM_21','S21','SC_LIN_MT','ST04',42,'Verified','2026-07-25'),
('M_LINM_22','S22','SC_LIN_MT','ST04',70,'Verified','2026-07-25'),
('M_LINM_23','S23','SC_LIN_MT','ST04',82,'Verified','2026-07-25'),
('M_LINM_24','S24','SC_LIN_MT','ST04',42,'Verified','2026-07-25'),
('M_LINM_25','S25','SC_LIN_MT','ST04',72,'Verified','2026-07-25'),

-- LIN FINAL THEORY (SC_LIN_FT)
('M_LINF_11','S11','SC_LIN_FT','ST04',70,'Verified','2026-08-20'),
('M_LINF_12','S12','SC_LIN_FT','ST04',79,'Verified','2026-08-20'),
('M_LINF_13','S13','SC_LIN_FT','ST04',35,'Verified','2026-08-20'),
('M_LINF_14','S14','SC_LIN_FT','ST04',73,'Verified','2026-08-20'),
('M_LINF_15','S15','SC_LIN_FT','ST04',94,'Verified','2026-08-20'),
('M_LINF_16','S16','SC_LIN_FT','ST04',85,'Verified','2026-08-20'),
('M_LINF_17','S17','SC_LIN_FT','ST04',42,'Verified','2026-08-20'),
('M_LINF_18','S18','SC_LIN_FT','ST04',82,'Verified','2026-08-20'),
('M_LINF_19','S19','SC_LIN_FT','ST04',25,'Verified','2026-08-20'),
('M_LINF_20','S20','SC_LIN_FT','ST04',86,'Verified','2026-08-20'),
('M_LINF_21','S21','SC_LIN_FT','ST04',30,'Verified','2026-08-20'),
('M_LINF_22','S22','SC_LIN_FT','ST04',91,'Verified','2026-08-20'),
('M_LINF_23','S23','SC_LIN_FT','ST04',89,'Verified','2026-08-20'),
('M_LINF_24','S24','SC_LIN_FT','ST04',0,'Verified','2026-08-20'),
('M_LINF_25','S25','SC_LIN_FT','ST04',72,'Verified','2026-08-20'),

-- -------------------------------------------------------------------------
-- DBP (DBMS Practicum) - ST05
-- -------------------------------------------------------------------------
-- DBP QUIZ (SC_DBP_QZ)
('M_DBPQ_11','S11','SC_DBP_QZ','ST05',91,'Verified','2026-07-20'),
('M_DBPQ_12','S12','SC_DBP_QZ','ST05',66,'Verified','2026-07-20'),
('M_DBPQ_13','S13','SC_DBP_QZ','ST05',30,'Verified','2026-07-20'),
('M_DBPQ_14','S14','SC_DBP_QZ','ST05',77,'Verified','2026-07-20'),
('M_DBPQ_15','S15','SC_DBP_QZ','ST05',73,'Verified','2026-07-20'),
('M_DBPQ_16','S16','SC_DBP_QZ','ST05',67,'Verified','2026-07-20'),
('M_DBPQ_17','S17','SC_DBP_QZ','ST05',25,'Verified','2026-07-20'),
('M_DBPQ_18','S18','SC_DBP_QZ','ST05',94,'Verified','2026-07-20'),
('M_DBPQ_19','S19','SC_DBP_QZ','ST05',40,'Verified','2026-07-20'),
('M_DBPQ_20','S20','SC_DBP_QZ','ST05',93,'Verified','2026-07-20'),
('M_DBPQ_21','S21','SC_DBP_QZ','ST05',42,'Verified','2026-07-20'),
('M_DBPQ_22','S22','SC_DBP_QZ','ST05',75,'Verified','2026-07-20'),
('M_DBPQ_23','S23','SC_DBP_QZ','ST05',71,'Verified','2026-07-20'),
('M_DBPQ_24','S24','SC_DBP_QZ','ST05',42,'Verified','2026-07-20'),
('M_DBPQ_25','S25','SC_DBP_QZ','ST05',80,'Verified','2026-07-20'),

-- DBP PROJECT (SC_DBP_PR)
('M_DBPP_11','S11','SC_DBP_PR','ST05',77,'Verified','2026-07-22'),
('M_DBPP_12','S12','SC_DBP_PR','ST05',93,'Verified','2026-07-22'),
('M_DBPP_13','S13','SC_DBP_PR','ST05',42,'Verified','2026-07-22'),
('M_DBPP_14','S14','SC_DBP_PR','ST05',79,'Verified','2026-07-22'),
('M_DBPP_15','S15','SC_DBP_PR','ST05',69,'Verified','2026-07-22'),
('M_DBPP_16','S16','SC_DBP_PR','ST05',73,'Verified','2026-07-22'),
('M_DBPP_17','S17','SC_DBP_PR','ST05',25,'Verified','2026-07-22'),
('M_DBPP_18','S18','SC_DBP_PR','ST05',72,'Verified','2026-07-22'),
('M_DBPP_19','S19','SC_DBP_PR','ST05',42,'Verified','2026-07-22'),
('M_DBPP_20','S20','SC_DBP_PR','ST05',82,'Verified','2026-07-22'),
('M_DBPP_21','S21','SC_DBP_PR','ST05',40,'Verified','2026-07-22'),
('M_DBPP_22','S22','SC_DBP_PR','ST05',73,'Verified','2026-07-22'),
('M_DBPP_23','S23','SC_DBP_PR','ST05',88,'Verified','2026-07-22'),
('M_DBPP_24','S24','SC_DBP_PR','ST05',40,'Verified','2026-07-22'),
('M_DBPP_25','S25','SC_DBP_PR','ST05',78,'Verified','2026-07-22'),

-- DBP MID PRACTICAL (SC_DBP_MP)
('M_DBPM_11','S11','SC_DBP_MP','ST05',93,'Verified','2026-07-25'),
('M_DBPM_12','S12','SC_DBP_MP','ST05',83,'Verified','2026-07-25'),
('M_DBPM_13','S13','SC_DBP_MP','ST05',35,'Verified','2026-07-25'),
('M_DBPM_14','S14','SC_DBP_MP','ST05',76,'Verified','2026-07-25'),
('M_DBPM_15','S15','SC_DBP_MP','ST05',72,'Verified','2026-07-25'),
('M_DBPM_16','S16','SC_DBP_MP','ST05',69,'Verified','2026-07-25'),
('M_DBPM_17','S17','SC_DBP_MP','ST05',40,'Verified','2026-07-25'),
('M_DBPM_18','S18','SC_DBP_MP','ST05',80,'Verified','2026-07-25'),
('M_DBPM_19','S19','SC_DBP_MP','ST05',0,'Verified','2026-07-25'),
('M_DBPM_20','S20','SC_DBP_MP','ST05',89,'Verified','2026-07-25'),
('M_DBPM_21','S21','SC_DBP_MP','ST05',0,'Verified','2026-07-25'),
('M_DBPM_22','S22','SC_DBP_MP','ST05',92,'Verified','2026-07-25'),
('M_DBPM_23','S23','SC_DBP_MP','ST05',68,'Verified','2026-07-25'),
('M_DBPM_24','S24','SC_DBP_MP','ST05',25,'Verified','2026-07-25'),
('M_DBPM_25','S25','SC_DBP_MP','ST05',85,'Verified','2026-07-25'),

-- DBP FINAL PRACTICAL (SC_DBP_FP)
('M_DBPF_11','S11','SC_DBP_FP','ST05',70,'Verified','2026-08-20'),
('M_DBPF_12','S12','SC_DBP_FP','ST05',90,'Verified','2026-08-20'),
('M_DBPF_13','S13','SC_DBP_FP','ST05',42,'Verified','2026-08-20'),
('M_DBPF_14','S14','SC_DBP_FP','ST05',78,'Verified','2026-08-20'),
('M_DBPF_15','S15','SC_DBP_FP','ST05',84,'Verified','2026-08-20'),
('M_DBPF_16','S16','SC_DBP_FP','ST05',67,'Verified','2026-08-20'),
('M_DBPF_17','S17','SC_DBP_FP','ST05',35,'Verified','2026-08-20'),
('M_DBPF_18','S18','SC_DBP_FP','ST05',77,'Verified','2026-08-20'),
('M_DBPF_19','S19','SC_DBP_FP','ST05',40,'Verified','2026-08-20'),
('M_DBPF_20','S20','SC_DBP_FP','ST05',79,'Verified','2026-08-20'),
('M_DBPF_21','S21','SC_DBP_FP','ST05',40,'Verified','2026-08-20'),
('M_DBPF_22','S22','SC_DBP_FP','ST05',73,'Verified','2026-08-20'),
('M_DBPF_23','S23','SC_DBP_FP','ST05',82,'Verified','2026-08-20'),
('M_DBPF_24','S24','SC_DBP_FP','ST05',0,'Verified','2026-08-20'),
('M_DBPF_25','S25','SC_DBP_FP','ST05',86,'Verified','2026-08-20'),

-- -------------------------------------------------------------------------
-- WEB (Web Development) - ST06
-- -------------------------------------------------------------------------
-- WEB QUIZ (SC_WEB_QZ)
('M_WEBQ_11','S11','SC_WEB_QZ','ST06',88,'Verified','2026-07-20'),
('M_WEBQ_12','S12','SC_WEB_QZ','ST06',68,'Verified','2026-07-20'),
('M_WEBQ_13','S13','SC_WEB_QZ','ST06',42,'Verified','2026-07-20'),
('M_WEBQ_14','S14','SC_WEB_QZ','ST06',93,'Verified','2026-07-20'),
('M_WEBQ_15','S15','SC_WEB_QZ','ST06',82,'Verified','2026-07-20'),
('M_WEBQ_16','S16','SC_WEB_QZ','ST06',89,'Verified','2026-07-20'),
('M_WEBQ_17','S17','SC_WEB_QZ','ST06',30,'Verified','2026-07-20'),
('M_WEBQ_18','S18','SC_WEB_QZ','ST06',89,'Verified','2026-07-20'),
('M_WEBQ_19','S19','SC_WEB_QZ','ST06',42,'Verified','2026-07-20'),
('M_WEBQ_20','S20','SC_WEB_QZ','ST06',75,'Verified','2026-07-20'),
('M_WEBQ_21','S21','SC_WEB_QZ','ST06',0,'Verified','2026-07-20'),
('M_WEBQ_22','S22','SC_WEB_QZ','ST06',74,'Verified','2026-07-20'),
('M_WEBQ_23','S23','SC_WEB_QZ','ST06',78,'Verified','2026-07-20'),
('M_WEBQ_24','S24','SC_WEB_QZ','ST06',25,'Verified','2026-07-20'),
('M_WEBQ_25','S25','SC_WEB_QZ','ST06',79,'Verified','2026-07-20'),

-- WEB PROJECT (SC_WEB_PR)
('M_WEBP_11','S11','SC_WEB_PR','ST06',65,'Verified','2026-07-22'),
('M_WEBP_12','S12','SC_WEB_PR','ST06',95,'Verified','2026-07-22'),
('M_WEBP_13','S13','SC_WEB_PR','ST06',42,'Verified','2026-07-22'),
('M_WEBP_14','S14','SC_WEB_PR','ST06',93,'Verified','2026-07-22'),
('M_WEBP_15','S15','SC_WEB_PR','ST06',88,'Verified','2026-07-22'),
('M_WEBP_16','S16','SC_WEB_PR','ST06',73,'Verified','2026-07-22'),
('M_WEBP_17','S17','SC_WEB_PR','ST06',40,'Verified','2026-07-22'),
('M_WEBP_18','S18','SC_WEB_PR','ST06',89,'Verified','2026-07-22'),
('M_WEBP_19','S19','SC_WEB_PR','ST06',25,'Verified','2026-07-22'),
('M_WEBP_20','S20','SC_WEB_PR','ST06',81,'Verified','2026-07-22'),
('M_WEBP_21','S21','SC_WEB_PR','ST06',0,'Verified','2026-07-22'),
('M_WEBP_22','S22','SC_WEB_PR','ST06',92,'Verified','2026-07-22'),
('M_WEBP_23','S23','SC_WEB_PR','ST06',85,'Verified','2026-07-22'),
('M_WEBP_24','S24','SC_WEB_PR','ST06',30,'Verified','2026-07-22'),
('M_WEBP_25','S25','SC_WEB_PR','ST06',91,'Verified','2026-07-22'),

-- WEB MID THEORY (SC_WEB_MT)
('M_WEBM_11','S11','SC_WEB_MT','ST06',85,'Verified','2026-07-25'),
('M_WEBM_12','S12','SC_WEB_MT','ST06',81,'Verified','2026-07-25'),
('M_WEBM_13','S13','SC_WEB_MT','ST06',40,'Verified','2026-07-25'),
('M_WEBM_14','S14','SC_WEB_MT','ST06',71,'Verified','2026-07-25'),
('M_WEBM_15','S15','SC_WEB_MT','ST06',69,'Verified','2026-07-25'),
('M_WEBM_16','S16','SC_WEB_MT','ST06',76,'Verified','2026-07-25'),
('M_WEBM_17','S17','SC_WEB_MT','ST06',25,'Verified','2026-07-25'),
('M_WEBM_18','S18','SC_WEB_MT','ST06',82,'Verified','2026-07-25'),
('M_WEBM_19','S19','SC_WEB_MT','ST06',40,'Verified','2026-07-25'),
('M_WEBM_20','S20','SC_WEB_MT','ST06',94,'Verified','2026-07-25'),
('M_WEBM_21','S21','SC_WEB_MT','ST06',0,'Verified','2026-07-25'),
('M_WEBM_22','S22','SC_WEB_MT','ST06',84,'Verified','2026-07-25'),
('M_WEBM_23','S23','SC_WEB_MT','ST06',75,'Verified','2026-07-25'),
('M_WEBM_24','S24','SC_WEB_MT','ST06',35,'Verified','2026-07-25'),
('M_WEBM_25','S25','SC_WEB_MT','ST06',65,'Verified','2026-07-25'),

-- WEB FINAL THEORY (SC_WEB_FT)
('M_WEBF_11','S11','SC_WEB_FT','ST06',68,'Verified','2026-08-20'),
('M_WEBF_12','S12','SC_WEB_FT','ST06',94,'Verified','2026-08-20'),
('M_WEBF_13','S13','SC_WEB_FT','ST06',30,'Verified','2026-08-20'),
('M_WEBF_14','S14','SC_WEB_FT','ST06',93,'Verified','2026-08-20'),
('M_WEBF_15','S15','SC_WEB_FT','ST06',91,'Verified','2026-08-20'),
('M_WEBF_16','S16','SC_WEB_FT','ST06',90,'Verified','2026-08-20'),
('M_WEBF_17','S17','SC_WEB_FT','ST06',30,'Verified','2026-08-20'),
('M_WEBF_18','S18','SC_WEB_FT','ST06',72,'Verified','2026-08-20'),
('M_WEBF_19','S19','SC_WEB_FT','ST06',0,'Verified','2026-08-20'),
('M_WEBF_20','S20','SC_WEB_FT','ST06',72,'Verified','2026-08-20'),
('M_WEBF_21','S21','SC_WEB_FT','ST06',40,'Verified','2026-08-20'),
('M_WEBF_22','S22','SC_WEB_FT','ST06',95,'Verified','2026-08-20'),
('M_WEBF_23','S23','SC_WEB_FT','ST06',67,'Verified','2026-08-20'),
('M_WEBF_24','S24','SC_WEB_FT','ST06',0,'Verified','2026-08-20'),
('M_WEBF_25','S25','SC_WEB_FT','ST06',88,'Verified','2026-08-20'),

-- -------------------------------------------------------------------------
-- WEP (Web Development Practicum) - ST07
-- -------------------------------------------------------------------------
-- WEP QUIZ (SC_WEP_QZ)
('M_WEPQ_11','S11','SC_WEP_QZ','ST07',80,'Verified','2026-07-20'),
('M_WEPQ_12','S12','SC_WEP_QZ','ST07',91,'Verified','2026-07-20'),
('M_WEPQ_13','S13','SC_WEP_QZ','ST07',0,'Verified','2026-07-20'),
('M_WEPQ_14','S14','SC_WEP_QZ','ST07',89,'Verified','2026-07-20'),
('M_WEPQ_15','S15','SC_WEP_QZ','ST07',82,'Verified','2026-07-20'),
('M_WEPQ_16','S16','SC_WEP_QZ','ST07',89,'Verified','2026-07-20'),
('M_WEPQ_17','S17','SC_WEP_QZ','ST07',25,'Verified','2026-07-20'),
('M_WEPQ_18','S18','SC_WEP_QZ','ST07',69,'Verified','2026-07-20'),
('M_WEPQ_19','S19','SC_WEP_QZ','ST07',42,'Verified','2026-07-20'),
('M_WEPQ_20','S20','SC_WEP_QZ','ST07',80,'Verified','2026-07-20'),
('M_WEPQ_21','S21','SC_WEP_QZ','ST07',40,'Verified','2026-07-20'),
('M_WEPQ_22','S22','SC_WEP_QZ','ST07',70,'Verified','2026-07-20'),
('M_WEPQ_23','S23','SC_WEP_QZ','ST07',73,'Verified','2026-07-20'),
('M_WEPQ_24','S24','SC_WEP_QZ','ST07',40,'Verified','2026-07-20'),
('M_WEPQ_25','S25','SC_WEP_QZ','ST07',92,'Verified','2026-07-20'),

-- WEP PROJECT (SC_WEP_PR)
('M_WEPP_11','S11','SC_WEP_PR','ST07',84,'Verified','2026-07-22'),
('M_WEPP_12','S12','SC_WEP_PR','ST07',78,'Verified','2026-07-22'),
('M_WEPP_13','S13','SC_WEP_PR','ST07',25,'Verified','2026-07-22'),
('M_WEPP_14','S14','SC_WEP_PR','ST07',94,'Verified','2026-07-22'),
('M_WEPP_15','S15','SC_WEP_PR','ST07',82,'Verified','2026-07-22'),
('M_WEPP_16','S16','SC_WEP_PR','ST07',89,'Verified','2026-07-22'),
('M_WEPP_17','S17','SC_WEP_PR','ST07',42,'Verified','2026-07-22'),
('M_WEPP_18','S18','SC_WEP_PR','ST07',87,'Verified','2026-07-22'),
('M_WEPP_19','S19','SC_WEP_PR','ST07',25,'Verified','2026-07-22'),
('M_WEPP_20','S20','SC_WEP_PR','ST07',87,'Verified','2026-07-22'),
('M_WEPP_21','S21','SC_WEP_PR','ST07',30,'Verified','2026-07-22'),
('M_WEPP_22','S22','SC_WEP_PR','ST07',77,'Verified','2026-07-22'),
('M_WEPP_23','S23','SC_WEP_PR','ST07',86,'Verified','2026-07-22'),
('M_WEPP_24','S24','SC_WEP_PR','ST07',42,'Verified','2026-07-22'),
('M_WEPP_25','S25','SC_WEP_PR','ST07',76,'Verified','2026-07-22'),

-- WEP MID PRACTICAL (SC_WEP_MP)
('M_WEPM_11','S11','SC_WEP_MP','ST07',79,'Verified','2026-07-25'),
('M_WEPM_12','S12','SC_WEP_MP','ST07',93,'Verified','2026-07-25'),
('M_WEPM_13','S13','SC_WEP_MP','ST07',40,'Verified','2026-07-25'),
('M_WEPM_14','S14','SC_WEP_MP','ST07',79,'Verified','2026-07-25'),
('M_WEPM_15','S15','SC_WEP_MP','ST07',68,'Verified','2026-07-25'),
('M_WEPM_16','S16','SC_WEP_MP','ST07',72,'Verified','2026-07-25'),
('M_WEPM_17','S17','SC_WEP_MP','ST07',25,'Verified','2026-07-25'),
('M_WEPM_18','S18','SC_WEP_MP','ST07',67,'Verified','2026-07-25'),
('M_WEPM_19','S19','SC_WEP_MP','ST07',30,'Verified','2026-07-25'),
('M_WEPM_20','S20','SC_WEP_MP','ST07',65,'Verified','2026-07-25'),
('M_WEPM_21','S21','SC_WEP_MP','ST07',40,'Verified','2026-07-25'),
('M_WEPM_22','S22','SC_WEP_MP','ST07',82,'Verified','2026-07-25'),
('M_WEPM_23','S23','SC_WEP_MP','ST07',72,'Verified','2026-07-25'),
('M_WEPM_24','S24','SC_WEP_MP','ST07',40,'Verified','2026-07-25'),
('M_WEPM_25','S25','SC_WEP_MP','ST07',72,'Verified','2026-07-25'),

-- WEP FINAL PRACTICAL (SC_WEP_FP)
('M_WEPF_11','S11','SC_WEP_FP','ST07',65,'Verified','2026-08-20'),
('M_WEPF_12','S12','SC_WEP_FP','ST07',67,'Verified','2026-08-20'),
('M_WEPF_13','S13','SC_WEP_FP','ST07',42,'Verified','2026-08-20'),
('M_WEPF_14','S14','SC_WEP_FP','ST07',85,'Verified','2026-08-20'),
('M_WEPF_15','S15','SC_WEP_FP','ST07',66,'Verified','2026-08-20'),
('M_WEPF_16','S16','SC_WEP_FP','ST07',72,'Verified','2026-08-20'),
('M_WEPF_17','S17','SC_WEP_FP','ST07',0,'Verified','2026-08-20'),
('M_WEPF_18','S18','SC_WEP_FP','ST07',93,'Verified','2026-08-20'),
('M_WEPF_19','S19','SC_WEP_FP','ST07',0,'Verified','2026-08-20'),
('M_WEPF_20','S20','SC_WEP_FP','ST07',92,'Verified','2026-08-20'),
('M_WEPF_21','S21','SC_WEP_FP','ST07',30,'Verified','2026-08-20'),
('M_WEPF_22','S22','SC_WEP_FP','ST07',67,'Verified','2026-08-20'),
('M_WEPF_23','S23','SC_WEP_FP','ST07',81,'Verified','2026-08-20'),
('M_WEPF_24','S24','SC_WEP_FP','ST07',25,'Verified','2026-08-20'),
('M_WEPF_25','S25','SC_WEP_FP','ST07',73,'Verified','2026-08-20'),

-- -------------------------------------------------------------------------
-- MAT (Discrete Mathematics) - ST08
-- -------------------------------------------------------------------------
-- MAT QUIZ (SC_MAT_QZ)
('M_MATQ_11','S11','SC_MAT_QZ','ST08',86,'Verified','2026-07-20'),
('M_MATQ_12','S12','SC_MAT_QZ','ST08',80,'Verified','2026-07-20'),
('M_MATQ_13','S13','SC_MAT_QZ','ST08',25,'Verified','2026-07-20'),
('M_MATQ_14','S14','SC_MAT_QZ','ST08',82,'Verified','2026-07-20'),
('M_MATQ_15','S15','SC_MAT_QZ','ST08',69,'Verified','2026-07-20'),
('M_MATQ_16','S16','SC_MAT_QZ','ST08',88,'Verified','2026-07-20'),
('M_MATQ_17','S17','SC_MAT_QZ','ST08',40,'Verified','2026-07-20'),
('M_MATQ_18','S18','SC_MAT_QZ','ST08',83,'Verified','2026-07-20'),
('M_MATQ_19','S19','SC_MAT_QZ','ST08',35,'Verified','2026-07-20'),
('M_MATQ_20','S20','SC_MAT_QZ','ST08',72,'Verified','2026-07-20'),
('M_MATQ_21','S21','SC_MAT_QZ','ST08',35,'Verified','2026-07-20'),
('M_MATQ_22','S22','SC_MAT_QZ','ST08',90,'Verified','2026-07-20'),
('M_MATQ_23','S23','SC_MAT_QZ','ST08',78,'Verified','2026-07-20'),
('M_MATQ_24','S24','SC_MAT_QZ','ST08',25,'Verified','2026-07-20'),
('M_MATQ_25','S25','SC_MAT_QZ','ST08',68,'Verified','2026-07-20'),

-- MAT PROJECT (SC_MAT_PR)
('M_MATP_11','S11','SC_MAT_PR','ST08',68,'Verified','2026-07-22'),
('M_MATP_12','S12','SC_MAT_PR','ST08',86,'Verified','2026-07-22'),
('M_MATP_13','S13','SC_MAT_PR','ST08',35,'Verified','2026-07-22'),
('M_MATP_14','S14','SC_MAT_PR','ST08',76,'Verified','2026-07-22'),
('M_MATP_15','S15','SC_MAT_PR','ST08',78,'Verified','2026-07-22'),
('M_MATP_16','S16','SC_MAT_PR','ST08',78,'Verified','2026-07-22'),
('M_MATP_17','S17','SC_MAT_PR','ST08',35,'Verified','2026-07-22'),
('M_MATP_18','S18','SC_MAT_PR','ST08',92,'Verified','2026-07-22'),
('M_MATP_19','S19','SC_MAT_PR','ST08',42,'Verified','2026-07-22'),
('M_MATP_20','S20','SC_MAT_PR','ST08',66,'Verified','2026-07-22'),
('M_MATP_21','S21','SC_MAT_PR','ST08',42,'Verified','2026-07-22'),
('M_MATP_22','S22','SC_MAT_PR','ST08',85,'Verified','2026-07-22'),
('M_MATP_23','S23','SC_MAT_PR','ST08',85,'Verified','2026-07-22'),
('M_MATP_24','S24','SC_MAT_PR','ST08',0,'Verified','2026-07-22'),
('M_MATP_25','S25','SC_MAT_PR','ST08',66,'Verified','2026-07-22'),

-- MAT MID THEORY (SC_MAT_MT)
('M_MATM_11','S11','SC_MAT_MT','ST08',77,'Verified','2026-07-25'),
('M_MATM_12','S12','SC_MAT_MT','ST08',88,'Verified','2026-07-25'),
('M_MATM_13','S13','SC_MAT_MT','ST08',30,'Verified','2026-07-25'),
('M_MATM_14','S14','SC_MAT_MT','ST08',90,'Verified','2026-07-25'),
('M_MATM_15','S15','SC_MAT_MT','ST08',92,'Verified','2026-07-25'),
('M_MATM_16','S16','SC_MAT_MT','ST08',68,'Verified','2026-07-25'),
('M_MATM_17','S17','SC_MAT_MT','ST08',25,'Verified','2026-07-25'),
('M_MATM_18','S18','SC_MAT_MT','ST08',71,'Verified','2026-07-25'),
('M_MATM_19','S19','SC_MAT_MT','ST08',25,'Verified','2026-07-25'),
('M_MATM_20','S20','SC_MAT_MT','ST08',82,'Verified','2026-07-25'),
('M_MATM_21','S21','SC_MAT_MT','ST08',35,'Verified','2026-07-25'),
('M_MATM_22','S22','SC_MAT_MT','ST08',69,'Verified','2026-07-25'),
('M_MATM_23','S23','SC_MAT_MT','ST08',78,'Verified','2026-07-25'),
('M_MATM_24','S24','SC_MAT_MT','ST08',25,'Verified','2026-07-25'),
('M_MATM_25','S25','SC_MAT_MT','ST08',73,'Verified','2026-07-25'),

-- MAT FINAL THEORY (SC_MAT_FT)
('M_MATF_11','S11','SC_MAT_FT','ST08',79,'Verified','2026-08-20'),
('M_MATF_12','S12','SC_MAT_FT','ST08',72,'Verified','2026-08-20'),
('M_MATF_13','S13','SC_MAT_FT','ST08',0,'Verified','2026-08-20'),
('M_MATF_14','S14','SC_MAT_FT','ST08',79,'Verified','2026-08-20'),
('M_MATF_15','S15','SC_MAT_FT','ST08',90,'Verified','2026-08-20'),
('M_MATF_16','S16','SC_MAT_FT','ST08',92,'Verified','2026-08-20'),
('M_MATF_17','S17','SC_MAT_FT','ST08',40,'Verified','2026-08-20'),
('M_MATF_18','S18','SC_MAT_FT','ST08',68,'Verified','2026-08-20'),
('M_MATF_19','S19','SC_MAT_FT','ST08',0,'Verified','2026-08-20'),
('M_MATF_20','S20','SC_MAT_FT','ST08',85,'Verified','2026-08-20'),
('M_MATF_21','S21','SC_MAT_FT','ST08',40,'Verified','2026-08-20'),
('M_MATF_22','S22','SC_MAT_FT','ST08',91,'Verified','2026-08-20'),
('M_MATF_23','S23','SC_MAT_FT','ST08',65,'Verified','2026-08-20'),
('M_MATF_24','S24','SC_MAT_FT','ST08',0,'Verified','2026-08-20'),
('M_MATF_25','S25','SC_MAT_FT','ST08',94,'Verified','2026-08-20'),

-- -------------------------------------------------------------------------
-- ENG (English II) - ST09
-- -------------------------------------------------------------------------
-- ENG QUIZ (SC_ENG_QZ)
('M_ENGQ_11','S11','SC_ENG_QZ','ST09',89,'Verified','2026-07-20'),
('M_ENGQ_12','S12','SC_ENG_QZ','ST09',92,'Verified','2026-07-20'),
('M_ENGQ_13','S13','SC_ENG_QZ','ST09',25,'Verified','2026-07-20'),
('M_ENGQ_14','S14','SC_ENG_QZ','ST09',70,'Verified','2026-07-20'),
('M_ENGQ_15','S15','SC_ENG_QZ','ST09',78,'Verified','2026-07-20'),
('M_ENGQ_16','S16','SC_ENG_QZ','ST09',80,'Verified','2026-07-20'),
('M_ENGQ_17','S17','SC_ENG_QZ','ST09',35,'Verified','2026-07-20'),
('M_ENGQ_18','S18','SC_ENG_QZ','ST09',71,'Verified','2026-07-20'),
('M_ENGQ_19','S19','SC_ENG_QZ','ST09',35,'Verified','2026-07-20'),
('M_ENGQ_20','S20','SC_ENG_QZ','ST09',93,'Verified','2026-07-20'),
('M_ENGQ_21','S21','SC_ENG_QZ','ST09',0,'Verified','2026-07-20'),
('M_ENGQ_22','S22','SC_ENG_QZ','ST09',70,'Verified','2026-07-20'),
('M_ENGQ_23','S23','SC_ENG_QZ','ST09',77,'Verified','2026-07-20'),
('M_ENGQ_24','S24','SC_ENG_QZ','ST09',0,'Verified','2026-07-20'),
('M_ENGQ_25','S25','SC_ENG_QZ','ST09',77,'Verified','2026-07-20'),

-- ENG PROJECT (SC_ENG_PR)
('M_ENGP_11','S11','SC_ENG_PR','ST09',73,'Verified','2026-07-22'),
('M_ENGP_12','S12','SC_ENG_PR','ST09',94,'Verified','2026-07-22'),
('M_ENGP_13','S13','SC_ENG_PR','ST09',35,'Verified','2026-07-22'),
('M_ENGP_14','S14','SC_ENG_PR','ST09',74,'Verified','2026-07-22'),
('M_ENGP_15','S15','SC_ENG_PR','ST09',78,'Verified','2026-07-22'),
('M_ENGP_16','S16','SC_ENG_PR','ST09',87,'Verified','2026-07-22'),
('M_ENGP_17','S17','SC_ENG_PR','ST09',42,'Verified','2026-07-22'),
('M_ENGP_18','S18','SC_ENG_PR','ST09',90,'Verified','2026-07-22'),
('M_ENGP_19','S19','SC_ENG_PR','ST09',40,'Verified','2026-07-22'),
('M_ENGP_20','S20','SC_ENG_PR','ST09',86,'Verified','2026-07-22'),
('M_ENGP_21','S21','SC_ENG_PR','ST09',42,'Verified','2026-07-22'),
('M_ENGP_22','S22','SC_ENG_PR','ST09',80,'Verified','2026-07-22'),
('M_ENGP_23','S23','SC_ENG_PR','ST09',69,'Verified','2026-07-22'),
('M_ENGP_24','S24','SC_ENG_PR','ST09',25,'Verified','2026-07-22'),
('M_ENGP_25','S25','SC_ENG_PR','ST09',74,'Verified','2026-07-22'),

-- ENG MID THEORY (SC_ENG_MT)
('M_ENGM_11','S11','SC_ENG_MT','ST09',71,'Verified','2026-07-25'),
('M_ENGM_12','S12','SC_ENG_MT','ST09',95,'Verified','2026-07-25'),
('M_ENGM_13','S13','SC_ENG_MT','ST09',0,'Verified','2026-07-25'),
('M_ENGM_14','S14','SC_ENG_MT','ST09',83,'Verified','2026-07-25'),
('M_ENGM_15','S15','SC_ENG_MT','ST09',88,'Verified','2026-07-25'),
('M_ENGM_16','S16','SC_ENG_MT','ST09',82,'Verified','2026-07-25'),
('M_ENGM_17','S17','SC_ENG_MT','ST09',0,'Verified','2026-07-25'),
('M_ENGM_18','S18','SC_ENG_MT','ST09',88,'Verified','2026-07-25'),
('M_ENGM_19','S19','SC_ENG_MT','ST09',30,'Verified','2026-07-25'),
('M_ENGM_20','S20','SC_ENG_MT','ST09',66,'Verified','2026-07-25'),
('M_ENGM_21','S21','SC_ENG_MT','ST09',0,'Verified','2026-07-25'),
('M_ENGM_22','S22','SC_ENG_MT','ST09',83,'Verified','2026-07-25'),
('M_ENGM_23','S23','SC_ENG_MT','ST09',80,'Verified','2026-07-25'),
('M_ENGM_24','S24','SC_ENG_MT','ST09',40,'Verified','2026-07-25'),
('M_ENGM_25','S25','SC_ENG_MT','ST09',94,'Verified','2026-07-25'),

-- ENG FINAL THEORY (SC_ENG_FT)
('M_ENGF_11','S11','SC_ENG_FT','ST09',92,'Verified','2026-08-20'),
('M_ENGF_12','S12','SC_ENG_FT','ST09',81,'Verified','2026-08-20'),
('M_ENGF_13','S13','SC_ENG_FT','ST09',25,'Verified','2026-08-20'),
('M_ENGF_14','S14','SC_ENG_FT','ST09',66,'Verified','2026-08-20'),
('M_ENGF_15','S15','SC_ENG_FT','ST09',95,'Verified','2026-08-20'),
('M_ENGF_16','S16','SC_ENG_FT','ST09',81,'Verified','2026-08-20'),
('M_ENGF_17','S17','SC_ENG_FT','ST09',0,'Verified','2026-08-20'),
('M_ENGF_18','S18','SC_ENG_FT','ST09',92,'Verified','2026-08-20'),
('M_ENGF_19','S19','SC_ENG_FT','ST09',25,'Verified','2026-08-20'),
('M_ENGF_20','S20','SC_ENG_FT','ST09',67,'Verified','2026-08-20'),
('M_ENGF_21','S21','SC_ENG_FT','ST09',40,'Verified','2026-08-20'),
('M_ENGF_22','S22','SC_ENG_FT','ST09',67,'Verified','2026-08-20'),
('M_ENGF_23','S23','SC_ENG_FT','ST09',86,'Verified','2026-08-20'),
('M_ENGF_24','S24','SC_ENG_FT','ST09',25,'Verified','2026-08-20'),
('M_ENGF_25','S25','SC_ENG_FT','ST09',77,'Verified','2026-08-20'),

-- -------------------------------------------------------------------------
-- DBS (Database Management Systems) - ST10
-- -------------------------------------------------------------------------
-- DBS QUIZ (SC_DBS_QZ)
('M_DBSQ_11','S11','SC_DBS_QZ','ST10',68,'Verified','2026-07-20'),
('M_DBSQ_12','S12','SC_DBS_QZ','ST10',95,'Verified','2026-07-20'),
('M_DBSQ_13','S13','SC_DBS_QZ','ST10',40,'Verified','2026-07-20'),
('M_DBSQ_14','S14','SC_DBS_QZ','ST10',72,'Verified','2026-07-20'),
('M_DBSQ_15','S15','SC_DBS_QZ','ST10',83,'Verified','2026-07-20'),
('M_DBSQ_16','S16','SC_DBS_QZ','ST10',84,'Verified','2026-07-20'),
('M_DBSQ_17','S17','SC_DBS_QZ','ST10',0,'Verified','2026-07-20'),
('M_DBSQ_18','S18','SC_DBS_QZ','ST10',84,'Verified','2026-07-20'),
('M_DBSQ_19','S19','SC_DBS_QZ','ST10',0,'Verified','2026-07-20'),
('M_DBSQ_20','S20','SC_DBS_QZ','ST10',78,'Verified','2026-07-20'),
('M_DBSQ_21','S21','SC_DBS_QZ','ST10',42,'Verified','2026-07-20'),
('M_DBSQ_22','S22','SC_DBS_QZ','ST10',83,'Verified','2026-07-20'),
('M_DBSQ_23','S23','SC_DBS_QZ','ST10',83,'Verified','2026-07-20'),
('M_DBSQ_24','S24','SC_DBS_QZ','ST10',40,'Verified','2026-07-20'),
('M_DBSQ_25','S25','SC_DBS_QZ','ST10',75,'Verified','2026-07-20'),

-- DBS PROJECT (SC_DBS_PR)
('M_DBSP_11','S11','SC_DBS_PR','ST10',94,'Verified','2026-07-22'),
('M_DBSP_12','S12','SC_DBS_PR','ST10',73,'Verified','2026-07-22'),
('M_DBSP_13','S13','SC_DBS_PR','ST10',25,'Verified','2026-07-22'),
('M_DBSP_14','S14','SC_DBS_PR','ST10',86,'Verified','2026-07-22'),
('M_DBSP_15','S15','SC_DBS_PR','ST10',87,'Verified','2026-07-22'),
('M_DBSP_16','S16','SC_DBS_PR','ST10',75,'Verified','2026-07-22'),
('M_DBSP_17','S17','SC_DBS_PR','ST10',25,'Verified','2026-07-22'),
('M_DBSP_18','S18','SC_DBS_PR','ST10',73,'Verified','2026-07-22'),
('M_DBSP_19','S19','SC_DBS_PR','ST10',35,'Verified','2026-07-22'),
('M_DBSP_20','S20','SC_DBS_PR','ST10',69,'Verified','2026-07-22'),
('M_DBSP_21','S21','SC_DBS_PR','ST10',42,'Verified','2026-07-22'),
('M_DBSP_22','S22','SC_DBS_PR','ST10',85,'Verified','2026-07-22'),
('M_DBSP_23','S23','SC_DBS_PR','ST10',74,'Verified','2026-07-22'),
('M_DBSP_24','S24','SC_DBS_PR','ST10',35,'Verified','2026-07-22'),
('M_DBSP_25','S25','SC_DBS_PR','ST10',75,'Verified','2026-07-22'),

-- DBS MID THEORY (SC_DBS_MT)
('M_DBSM_11','S11','SC_DBS_MT','ST10',94,'Verified','2026-07-25'),
('M_DBSM_12','S12','SC_DBS_MT','ST10',89,'Verified','2026-07-25'),
('M_DBSM_13','S13','SC_DBS_MT','ST10',0,'Verified','2026-07-25'),
('M_DBSM_14','S14','SC_DBS_MT','ST10',65,'Verified','2026-07-25'),
('M_DBSM_15','S15','SC_DBS_MT','ST10',79,'Verified','2026-07-25'),
('M_DBSM_16','S16','SC_DBS_MT','ST10',84,'Verified','2026-07-25'),
('M_DBSM_17','S17','SC_DBS_MT','ST10',40,'Verified','2026-07-25'),
('M_DBSM_18','S18','SC_DBS_MT','ST10',68,'Verified','2026-07-25'),
('M_DBSM_19','S19','SC_DBS_MT','ST10',0,'Verified','2026-07-25'),
('M_DBSM_20','S20','SC_DBS_MT','ST10',82,'Verified','2026-07-25'),
('M_DBSM_21','S21','SC_DBS_MT','ST10',25,'Verified','2026-07-25'),
('M_DBSM_22','S22','SC_DBS_MT','ST10',81,'Verified','2026-07-25'),
('M_DBSM_23','S23','SC_DBS_MT','ST10',73,'Verified','2026-07-25'),
('M_DBSM_24','S24','SC_DBS_MT','ST10',25,'Verified','2026-07-25'),
('M_DBSM_25','S25','SC_DBS_MT','ST10',94,'Verified','2026-07-25'),

-- DBS FINAL THEORY (SC_DBS_FT)
('M_DBSF_11','S11','SC_DBS_FT','ST10',76,'Verified','2026-08-20'),
('M_DBSF_12','S12','SC_DBS_FT','ST10',93,'Verified','2026-08-20'),
('M_DBSF_13','S13','SC_DBS_FT','ST10',0,'Verified','2026-08-20'),
('M_DBSF_14','S14','SC_DBS_FT','ST10',93,'Verified','2026-08-20'),
('M_DBSF_15','S15','SC_DBS_FT','ST10',72,'Verified','2026-08-20'),
('M_DBSF_16','S16','SC_DBS_FT','ST10',76,'Verified','2026-08-20'),
('M_DBSF_17','S17','SC_DBS_FT','ST10',30,'Verified','2026-08-20'),
('M_DBSF_18','S18','SC_DBS_FT','ST10',70,'Verified','2026-08-20'),
('M_DBSF_19','S19','SC_DBS_FT','ST10',35,'Verified','2026-08-20'),
('M_DBSF_20','S20','SC_DBS_FT','ST10',91,'Verified','2026-08-20'),
('M_DBSF_21','S21','SC_DBS_FT','ST10',40,'Verified','2026-08-20'),
('M_DBSF_22','S22','SC_DBS_FT','ST10',87,'Verified','2026-08-20'),
('M_DBSF_23','S23','SC_DBS_FT','ST10',74,'Verified','2026-08-20'),
('M_DBSF_24','S24','SC_DBS_FT','ST10',40,'Verified','2026-08-20'),
('M_DBSF_25','S25','SC_DBS_FT','ST10',90,'Verified','2026-08-20'),

-- -------------------------------------------------------------------------
-- OSC (OS Concepts and Application) - ST03
-- -------------------------------------------------------------------------
-- OSC QUIZ (SC_OSC_QZ)
('M_OSCQ_11','S11','SC_OSC_QZ','ST03',85,'Verified','2026-07-20'),
('M_OSCQ_12','S12','SC_OSC_QZ','ST03',81,'Verified','2026-07-20'),
('M_OSCQ_13','S13','SC_OSC_QZ','ST03',0,'Verified','2026-07-20'),
('M_OSCQ_14','S14','SC_OSC_QZ','ST03',86,'Verified','2026-07-20'),
('M_OSCQ_15','S15','SC_OSC_QZ','ST03',91,'Verified','2026-07-20'),
('M_OSCQ_16','S16','SC_OSC_QZ','ST03',82,'Verified','2026-07-20'),
('M_OSCQ_17','S17','SC_OSC_QZ','ST03',30,'Verified','2026-07-20'),
('M_OSCQ_18','S18','SC_OSC_QZ','ST03',94,'Verified','2026-07-20'),
('M_OSCQ_19','S19','SC_OSC_QZ','ST03',42,'Verified','2026-07-20'),
('M_OSCQ_20','S20','SC_OSC_QZ','ST03',68,'Verified','2026-07-20'),
('M_OSCQ_21','S21','SC_OSC_QZ','ST03',25,'Verified','2026-07-20'),
('M_OSCQ_22','S22','SC_OSC_QZ','ST03',73,'Verified','2026-07-20'),
('M_OSCQ_23','S23','SC_OSC_QZ','ST03',68,'Verified','2026-07-20'),
('M_OSCQ_24','S24','SC_OSC_QZ','ST03',0,'Verified','2026-07-20'),
('M_OSCQ_25','S25','SC_OSC_QZ','ST03',88,'Verified','2026-07-20'),

-- OSC PROJECT (SC_OSC_PR)
('M_OSCP_11','S11','SC_OSC_PR','ST03',82,'Verified','2026-07-22'),
('M_OSCP_12','S12','SC_OSC_PR','ST03',69,'Verified','2026-07-22'),
('M_OSCP_13','S13','SC_OSC_PR','ST03',30,'Verified','2026-07-22'),
('M_OSCP_14','S14','SC_OSC_PR','ST03',74,'Verified','2026-07-22'),
('M_OSCP_15','S15','SC_OSC_PR','ST03',84,'Verified','2026-07-22'),
('M_OSCP_16','S16','SC_OSC_PR','ST03',71,'Verified','2026-07-22'),
('M_OSCP_17','S17','SC_OSC_PR','ST03',42,'Verified','2026-07-22'),
('M_OSCP_18','S18','SC_OSC_PR','ST03',75,'Verified','2026-07-22'),
('M_OSCP_19','S19','SC_OSC_PR','ST03',25,'Verified','2026-07-22'),
('M_OSCP_20','S20','SC_OSC_PR','ST03',86,'Verified','2026-07-22'),
('M_OSCP_21','S21','SC_OSC_PR','ST03',42,'Verified','2026-07-22'),
('M_OSCP_22','S22','SC_OSC_PR','ST03',92,'Verified','2026-07-22'),
('M_OSCP_23','S23','SC_OSC_PR','ST03',73,'Verified','2026-07-22'),
('M_OSCP_24','S24','SC_OSC_PR','ST03',40,'Verified','2026-07-22'),
('M_OSCP_25','S25','SC_OSC_PR','ST03',80,'Verified','2026-07-22'),

-- OSC MID THEORY (SC_OSC_MT)
('M_OSCM_11','S11','SC_OSC_MT','ST03',73,'Verified','2026-07-25'),
('M_OSCM_12','S12','SC_OSC_MT','ST03',93,'Verified','2026-07-25'),
('M_OSCM_13','S13','SC_OSC_MT','ST03',0,'Verified','2026-07-25'),
('M_OSCM_14','S14','SC_OSC_MT','ST03',67,'Verified','2026-07-25'),
('M_OSCM_15','S15','SC_OSC_MT','ST03',85,'Verified','2026-07-25'),
('M_OSCM_16','S16','SC_OSC_MT','ST03',78,'Verified','2026-07-25'),
('M_OSCM_17','S17','SC_OSC_MT','ST03',30,'Verified','2026-07-25'),
('M_OSCM_18','S18','SC_OSC_MT','ST03',66,'Verified','2026-07-25'),
('M_OSCM_19','S19','SC_OSC_MT','ST03',0,'Verified','2026-07-25'),
('M_OSCM_20','S20','SC_OSC_MT','ST03',75,'Verified','2026-07-25'),
('M_OSCM_21','S21','SC_OSC_MT','ST03',25,'Verified','2026-07-25'),
('M_OSCM_22','S22','SC_OSC_MT','ST03',85,'Verified','2026-07-25'),
('M_OSCM_23','S23','SC_OSC_MT','ST03',73,'Verified','2026-07-25'),
('M_OSCM_24','S24','SC_OSC_MT','ST03',25,'Verified','2026-07-25'),
('M_OSCM_25','S25','SC_OSC_MT','ST03',88,'Verified','2026-07-25'),

-- OSC FINAL THEORY (SC_OSC_FT)
('M_OSCF_11','S11','SC_OSC_FT','ST03',79,'Verified','2026-08-20'),
('M_OSCF_12','S12','SC_OSC_FT','ST03',82,'Verified','2026-08-20'),
('M_OSCF_13','S13','SC_OSC_FT','ST03',42,'Verified','2026-08-20'),
('M_OSCF_14','S14','SC_OSC_FT','ST03',78,'Verified','2026-08-20'),
('M_OSCF_15','S15','SC_OSC_FT','ST03',82,'Verified','2026-08-20'),
('M_OSCF_16','S16','SC_OSC_FT','ST03',65,'Verified','2026-08-20'),
('M_OSCF_17','S17','SC_OSC_FT','ST03',0,'Verified','2026-08-20'),
('M_OSCF_18','S18','SC_OSC_FT','ST03',67,'Verified','2026-08-20'),
('M_OSCF_19','S19','SC_OSC_FT','ST03',42,'Verified','2026-08-20'),
('M_OSCF_20','S20','SC_OSC_FT','ST03',93,'Verified','2026-08-20'),
('M_OSCF_21','S21','SC_OSC_FT','ST03',25,'Verified','2026-08-20'),
('M_OSCF_22','S22','SC_OSC_FT','ST03',82,'Verified','2026-08-20'),
('M_OSCF_23','S23','SC_OSC_FT','ST03',66,'Verified','2026-08-20'),
('M_OSCF_24','S24','SC_OSC_FT','ST03',30,'Verified','2026-08-20'),
('M_OSCF_25','S25','SC_OSC_FT','ST03',83,'Verified','2026-08-20');

CREATE VIEW Batch_Attendance_Summary AS
SELECT 
    ST.Reg_No,
    CU.Course_Code,
    CU.Course_Name,
    COUNT(S.Session_ID) AS Total_Sessions,
    SUM(CASE WHEN A.attendance_status IN ('Present', 'Medical') THEN 1 ELSE 0 END) AS Attended_Sessions,
    ROUND((SUM(CASE WHEN A.attendance_status IN ('Present', 'Medical') THEN 1 ELSE 0 END) / COUNT(S.Session_ID)) * 100, 2) AS Attendance_Percentage,
    CASE 
        WHEN (SUM(CASE WHEN A.attendance_status IN ('Present', 'Medical') THEN 1 ELSE 0 END) / COUNT(S.Session_ID)) * 100 >= 80.00 THEN 'Eligible'
        ELSE 'Not Eligible'
    END AS Eligibility_Status
FROM STUDENT ST
JOIN ATTENDANCE_RECORD A ON ST.Student_ID = A.student_id
JOIN SESSION S ON A.session_id = S.Session_ID
JOIN COURSE_COMPONENT CC ON S.Component_ID = CC.Component_ID
JOIN COURSE_OFFERING CO ON CC.offering_id = CO.Offering_ID
JOIN COURSE_UNIT CU ON CO.Course_ID = CU.Course_ID
GROUP BY ST.Reg_No, CU.Course_Code, CU.Course_Name;

CREATE VIEW Component_Wise_Attendance AS
SELECT 
    ST.Reg_No,
    CU.Course_Code,
    CC.component_type,
    COUNT(S.Session_ID) AS Total_Sessions,
    SUM(CASE WHEN A.attendance_status IN ('Present', 'Medical') THEN 1 ELSE 0 END) AS Attended_Sessions,
    ROUND((SUM(CASE WHEN A.attendance_status IN ('Present', 'Medical') THEN 1 ELSE 0 END) / COUNT(S.Session_ID)) * 100, 2) AS Component_Attendance_Percentage
FROM STUDENT ST
JOIN ATTENDANCE_RECORD A ON ST.Student_ID = A.student_id
JOIN SESSION S ON A.session_id = S.Session_ID
JOIN COURSE_COMPONENT CC ON S.Component_ID = CC.Component_ID
JOIN COURSE_OFFERING CO ON CC.offering_id = CO.Offering_ID
JOIN COURSE_UNIT CU ON CO.Course_ID = CU.Course_ID
GROUP BY ST.Reg_No, CU.Course_Code, CC.component_type;


CREATE VIEW Individual_Attendance_Summary AS
SELECT 
    ST.Reg_No,
    P.F_Name,
    P.L_Name,
    CU.Course_Code,
    ROUND((SUM(CASE WHEN A.attendance_status IN ('Present', 'Medical') THEN 1 ELSE 0 END) / COUNT(S.Session_ID)) * 100, 2) AS Attendance_Percentage
FROM STUDENT ST
JOIN PERSON P ON ST.Person_ID = P.Person_ID
JOIN ATTENDANCE_RECORD A ON ST.Student_ID = A.student_id
JOIN SESSION S ON A.session_id = S.Session_ID
JOIN COURSE_COMPONENT CC ON S.Component_ID = CC.Component_ID
JOIN COURSE_OFFERING CO ON CC.offering_id = CO.Offering_ID
JOIN COURSE_UNIT CU ON CO.Course_ID = CU.Course_ID
GROUP BY ST.Reg_No, P.F_Name, P.L_Name, CU.Course_Code;

CREATE VIEW Individual_CA_Marks_Detail AS
SELECT 
    ST.Reg_No,
    CU.Course_Code,
    ATY.Assessment_Name,
    SM.raw_mark,
    SCH.weight_percentage,
    ROUND((SM.raw_mark * (SCH.weight_percentage / 100)), 2) AS weighted_mark
FROM STUDENT_MARK SM
JOIN ASSESSMENT_SCHEME SCH ON SM.Scheme_ID = SCH.Scheme_ID
JOIN ASSESSMENT_TYPE ATY ON SCH.Assessment_Type_ID = ATY.Assessment_Type_ID
JOIN STUDENT ST ON SM.Student_ID = ST.Student_ID
JOIN COURSE_OFFERING CO ON SCH.Offering_ID = CO.Offering_ID
JOIN COURSE_UNIT CU ON CO.Course_ID = CU.Course_ID
-- 'AT_FT' (Final Theory), 'AT_FP' (Final Practical) අයින් කරලා CA විතරක් ගන්නවා
WHERE ATY.Assessment_Type_ID NOT IN ('AT_FT', 'AT_FP');

CREATE VIEW Individual_Subject_Attendance_Detail AS
SELECT 
    ST.Reg_No,
    CU.Course_Code,
    S.session_date,
    S.start_time,
    CC.component_type,
    A.attendance_status,
    A.marked_date
FROM STUDENT ST
JOIN ATTENDANCE_RECORD A ON ST.Student_ID = A.student_id
JOIN SESSION S ON A.session_id = S.Session_ID
JOIN COURSE_COMPONENT CC ON S.Component_ID = CC.Component_ID
JOIN COURSE_OFFERING CO ON CC.offering_id = CO.Offering_ID
JOIN COURSE_UNIT CU ON CO.Course_ID = CU.Course_ID;

CREATE VIEW Batch_GPA_Summary AS
SELECT 
    ST.Reg_No,
    P.F_Name,
    P.L_Name,
    SEM.Academic_Year,
    SEM.Semester_No,
    GR.sgpa,
    GR.cgpa
FROM GPA_RECORD GR
JOIN STUDENT ST ON GR.student_id = ST.Student_ID
JOIN PERSON P ON ST.Person_ID = P.Person_ID
JOIN SEMESTER SEM ON GR.semester_id = SEM.Semester_ID
ORDER BY GR.cgpa DESC; 


CREATE VIEW Detailed_Academic_Transcript AS
SELECT 
    ST.Reg_No,
    SEM.Academic_Year,
    SEM.Semester_No,
    CU.Course_Code,
    CU.Course_Name,
    CU.Credits,
    FR.letter_grade,
    FR.grade_point,
    GR.sgpa,
    GR.cgpa
FROM FINAL_RESULT FR
JOIN STUDENT ST ON FR.Student_ID = ST.Student_ID
JOIN COURSE_OFFERING CO ON FR.Offering_ID = CO.Offering_ID
JOIN COURSE_UNIT CU ON CO.Course_ID = CU.Course_ID
JOIN SEMESTER SEM ON CO.Semester_ID = SEM.Semester_ID
JOIN GPA_RECORD GR ON ST.Student_ID = GR.student_id AND SEM.Semester_ID = GR.semester_id
ORDER BY ST.Reg_No, CU.Course_Code;


CREATE VIEW Student_Eligibility_Summary AS
SELECT 
    CU.Course_Code,
    CU.Course_Name,
    ST.Reg_No,
    P.F_Name,
    P.L_Name,
    ER.attendance_percentage,
    CASE WHEN ER.attendance_percentage >= 80.00 THEN 'Eligible' ELSE 'Not Eligible' END AS Attendance_Status,
    ER.ca_mark,
    ER.ca_eligibility,
    ER.final_exam_eligibility
FROM ELIGIBILITY_RECORD ER
JOIN STUDENT ST ON ER.Student_ID = ST.Student_ID
JOIN PERSON P ON ST.Person_ID = P.Person_ID
JOIN COURSE_OFFERING CO ON ER.Offering_ID = CO.Offering_ID
JOIN COURSE_UNIT CU ON CO.Course_ID = CU.Course_ID
ORDER BY CU.Course_Code, ST.Reg_No;


CREATE VIEW Student_Grades_Summary AS
SELECT 
    ST.Reg_No,
    CU.Course_Code,
    CU.Course_Name,
    CU.Credits,
    FR.final_mark,
    FR.letter_grade,
    FR.grade_point,
    FR.result_code
FROM FINAL_RESULT FR
JOIN STUDENT ST ON FR.Student_ID = ST.Student_ID
JOIN COURSE_OFFERING CO ON FR.Offering_ID = CO.Offering_ID
JOIN COURSE_UNIT CU ON CO.Course_ID = CU.Course_ID
ORDER BY ST.Reg_No, CU.Course_Code;

CREATE VIEW Batch_CA_Marks_Summary AS
SELECT 
    CU.Course_Code,
    CU.Course_Name,
    ST.Reg_No,
    P.F_Name,
    P.L_Name,
    ER.ca_mark,
    ER.ca_eligibility
FROM ELIGIBILITY_RECORD ER
JOIN STUDENT ST ON ER.Student_ID = ST.Student_ID
JOIN PERSON P ON ST.Person_ID = P.Person_ID
JOIN COURSE_OFFERING CO ON ER.Offering_ID = CO.Offering_ID
JOIN COURSE_UNIT CU ON CO.Course_ID = CU.Course_ID
ORDER BY CU.Course_Code, ST.Reg_No;

CREATE VIEW Comprehensive_Marks_Breakdown AS
SELECT 
    ST.Reg_No,
    CU.Course_Code,
    CU.Course_Name,
    -- Quiz Marks
    MAX(CASE WHEN ATY.Assessment_Type_ID = 'AT_QZ' THEN SM.raw_mark ELSE NULL END) AS Quiz_Mark,
    -- Project Marks
    MAX(CASE WHEN ATY.Assessment_Type_ID = 'AT_PR' THEN SM.raw_mark ELSE NULL END) AS Project_Mark,
    -- Mid Theory Marks
    MAX(CASE WHEN ATY.Assessment_Type_ID = 'AT_MT' THEN SM.raw_mark ELSE NULL END) AS Mid_Theory_Mark,
    -- Mid Practical Marks
    MAX(CASE WHEN ATY.Assessment_Type_ID = 'AT_MP' THEN SM.raw_mark ELSE NULL END) AS Mid_Practical_Mark,
    -- Final Theory Marks
    MAX(CASE WHEN ATY.Assessment_Type_ID = 'AT_FT' THEN SM.raw_mark ELSE NULL END) AS Final_Theory_Mark,
    -- Final Practical Marks
    MAX(CASE WHEN ATY.Assessment_Type_ID = 'AT_FP' THEN SM.raw_mark ELSE NULL END) AS Final_Practical_Mark
FROM STUDENT ST
JOIN STUDENT_MARK SM ON ST.Student_ID = SM.Student_ID
JOIN ASSESSMENT_SCHEME SCH ON SM.Scheme_ID = SCH.Scheme_ID
JOIN ASSESSMENT_TYPE ATY ON SCH.Assessment_Type_ID = ATY.Assessment_Type_ID
JOIN COURSE_OFFERING CO ON SCH.Offering_ID = CO.Offering_ID
JOIN COURSE_UNIT CU ON CO.Course_ID = CU.Course_ID
GROUP BY ST.Reg_No, CU.Course_Code, CU.Course_Name;

CREATE VIEW Final_Marks_Summary AS
SELECT 
    CU.Course_Code,
    CU.Course_Name,
    ST.Reg_No,
    P.F_Name,
    P.L_Name,
    ER.attendance_percentage,
    ER.ca_mark,
    FR.final_mark,
    FR.letter_grade,
    FR.grade_point,
    FR.result_code
FROM FINAL_RESULT FR
JOIN ELIGIBILITY_RECORD ER ON FR.Student_ID = ER.Student_ID AND FR.Offering_ID = ER.Offering_ID
JOIN STUDENT ST ON FR.Student_ID = ST.Student_ID
JOIN PERSON P ON ST.Person_ID = P.Person_ID
JOIN COURSE_OFFERING CO ON FR.Offering_ID = CO.Offering_ID
JOIN COURSE_UNIT CU ON CO.Course_ID = CU.Course_ID;

CREATE VIEW Final_Marks_Summary AS
SELECT 
    CU.Course_Code,
    CU.Course_Name,
    ST.Reg_No,
    P.F_Name,
    P.L_Name,
    ER.attendance_percentage,
    ER.ca_mark,
    FR.final_mark,
    FR.letter_grade,
    FR.grade_point,
    FR.result_code
FROM FINAL_RESULT FR
JOIN ELIGIBILITY_RECORD ER ON FR.Student_ID = ER.Student_ID AND FR.Offering_ID = ER.Offering_ID
JOIN STUDENT ST ON FR.Student_ID = ST.Student_ID
JOIN PERSON P ON ST.Person_ID = P.Person_ID
JOIN COURSE_OFFERING CO ON FR.Offering_ID = CO.Offering_ID
JOIN COURSE_UNIT CU ON CO.Course_ID = CU.Course_ID;

CREATE VIEW Individual_CA_Marks_Detail AS
SELECT 
    ST.Reg_No,
    CU.Course_Code,
    ATY.Assessment_Name,
    SM.raw_mark,
    SCH.weight_percentage,
    ROUND((SM.raw_mark * (SCH.weight_percentage / 100)), 2) AS weighted_mark
FROM STUDENT_MARK SM
JOIN ASSESSMENT_SCHEME SCH ON SM.Scheme_ID = SCH.Scheme_ID
JOIN ASSESSMENT_TYPE ATY ON SCH.Assessment_Type_ID = ATY.Assessment_Type_ID
JOIN STUDENT ST ON SM.Student_ID = ST.Student_ID
JOIN COURSE_OFFERING CO ON SCH.Offering_ID = CO.Offering_ID
JOIN COURSE_UNIT CU ON CO.Course_ID = CU.Course_ID
-- 'AT_FT' (Final Theory), 'AT_FP' (Final Practical) අයින් කරලා CA විතරක් ගන්නවා
WHERE ATY.Assessment_Type_ID NOT IN ('AT_FT', 'AT_FP');

CREATE VIEW Student_CA_Marks_Summary AS
SELECT 
    ST.Reg_No,
    P.F_Name,
    P.L_Name,
    CU.Course_Code,
    CU.Course_Name,
    ER.ca_mark,
    ER.ca_eligibility
FROM STUDENT ST
JOIN PERSON P ON ST.Person_ID = P.Person_ID
JOIN ELIGIBILITY_RECORD ER ON ST.Student_ID = ER.Student_ID
JOIN COURSE_OFFERING CO ON ER.Offering_ID = CO.Offering_ID
JOIN COURSE_UNIT CU ON CO.Course_ID = CU.Course_ID;

CREATE OR REPLACE VIEW Low_Attendance_View AS
SELECT 
    S.Reg_no AS Reg_No,
    CONCAT(P.F_Name, ' ', P.L_Name) AS Student_Name,
    S.Batch,
    CU.Course_Code,
    CU.Course_Name,
    ER.attendance_percentage,
    ER.final_exam_eligibility
FROM ELIGIBILITY_RECORD ER
JOIN STUDENT S ON ER.Student_ID = S.Student_ID
JOIN PERSON P ON S.Person_ID = P.Person_ID
JOIN COURSE_OFFERING CO ON ER.Offering_ID = CO.Offering_ID
JOIN COURSE_UNIT CU ON CO.Course_ID = CU.Course_ID
WHERE ER.attendance_percentage < 80.00
ORDER BY ER.attendance_percentage ASC;


CREATE VIEW Medical_Status_View AS
SELECT 
    M.Medical_ID,
    S.Reg_No,
    CONCAT(P.F_Name, ' ', P.L_Name) AS Student_Name,
    M.submitted_date,
    M.reason,
    CU.Course_Code,
    CC.component_type AS Session_Type,
    SE.week_no,
    SE.session_date AS Absent_Date,
    M.approval_status
FROM MEDICAL_RECORD M
JOIN STUDENT S ON M.Student_ID = S.Student_ID
JOIN PERSON P ON S.Person_ID = P.Person_ID
JOIN SESSION SE ON M.Session_ID = SE.Session_ID
JOIN COURSE_COMPONENT CC ON SE.Component_ID = CC.Component_ID
JOIN COURSE_OFFERING CO ON CC.offering_id = CO.Offering_ID
JOIN COURSE_UNIT CU ON CO.Course_ID = CU.Course_ID;

CREATE VIEW Session_Details_View AS
SELECT 
    SE.Session_ID,
    CC.component_type AS Session_Type,
    SE.week_no,
    SE.session_date,
    SE.start_time,
    SE.end_time,
    CU.Course_Code,
    CU.Course_Name,
    CU.Credits,
    CU.Course_Type,
    D.Department_Name
FROM SESSION SE
JOIN COURSE_COMPONENT CC ON SE.Component_ID = CC.Component_ID
JOIN COURSE_OFFERING CO ON CC.offering_id = CO.Offering_ID
JOIN COURSE_UNIT CU ON CO.Course_ID = CU.Course_ID
JOIN DEPARTMENT D ON CU.Department_ID = D.Department_ID;

CREATE OR REPLACE VIEW Student_Profile_View AS
SELECT 
    S.Reg_no AS Reg_No,
    CONCAT(P.F_Name, ' ', P.L_Name) AS Full_Name,
    P.F_Name,
    P.L_Name,
    P.NIC,
    P.Gender,
    P.DOB,
    P.Phone_No,
    P.Address,
    S.Batch,
    S.Intake_Year AS Academic_Year,
    S.Status AS Student_Status
FROM STUDENT S
JOIN PERSON P ON S.Person_ID = P.Person_ID;

CREATE VIEW Top_Performers_View AS
SELECT 
    S.Reg_No,
    CONCAT(P.F_Name, ' ', P.L_Name) AS Student_Name,
    S.Batch_Year AS Batch,
    CU.Course_Code,
    CU.Course_Name,
    FR.final_mark,
    FR.letter_grade AS Grade
FROM FINAL_RESULT FR
JOIN STUDENT S ON FR.Student_ID = S.Student_ID
JOIN PERSON P ON S.Person_ID = P.Person_ID
JOIN COURSE_OFFERING CO ON FR.Offering_ID = CO.Offering_ID
JOIN COURSE_UNIT CU ON CO.Course_ID = CU.Course_ID
WHERE FR.final_mark >= 80.00
ORDER BY FR.final_mark DESC;


DROP PROCEDURE IF EXISTS Generate_Dynamic_Eligibility;

DELIMITER $$

CREATE PROCEDURE Generate_Dynamic_Eligibility()
BEGIN

    DELETE FROM ELIGIBILITY_RECORD;


    INSERT INTO ELIGIBILITY_RECORD (Eligibility_ID, Student_ID, Offering_ID, attendance_percentage, ca_mark, ca_eligibility, final_exam_eligibility)
    SELECT 

        CONCAT('ELI_', E.Offering_ID, '_', E.Student_ID),
        E.Student_ID,
        E.Offering_ID,
        

        COALESCE((
            SELECT (SUM(CASE WHEN A.attendance_status IN ('Present', 'Medical') THEN 1 ELSE 0 END) / COUNT(*)) * 100
            FROM ATTENDANCE_RECORD A
            JOIN SESSION S ON A.session_id = S.Session_ID
            JOIN COURSE_COMPONENT C ON S.Component_ID = C.Component_ID
            WHERE A.student_id = E.Student_ID AND C.offering_id = E.Offering_ID
        ), 0) AS attendance_percentage,

 
        COALESCE((
            SELECT SUM(SM.raw_mark * (ASCH.weight_percentage / 100))
            FROM STUDENT_MARK SM
            JOIN ASSESSMENT_SCHEME ASCH ON SM.Scheme_ID = ASCH.Scheme_ID
            WHERE SM.Student_ID = E.Student_ID 
              AND ASCH.Offering_ID = E.Offering_ID 
            
              AND ASCH.Assessment_Type_ID IN ('AT_QZ', 'AT_PR', 'AT_MT', 'AT_MP')
        ), 0) AS ca_mark,

       
        FALSE, 
        FALSE
    FROM ENROLLMENT E;

    
    UPDATE ELIGIBILITY_RECORD 
    SET ca_eligibility = IF(attendance_percentage >= 80.00, TRUE, FALSE),
        final_exam_eligibility = IF(attendance_percentage >= 80.00, TRUE, FALSE);

END$$

DELIMITER ;


CALL Generate_Dynamic_Eligibility();

DELIMITER $$

CREATE PROCEDURE Generate_Dynamic_Final_Result()
BEGIN
   
    DELETE FROM FINAL_RESULT;

    
    INSERT INTO FINAL_RESULT (Result_ID, Student_ID, Offering_ID, final_mark, letter_grade, grade_point, result_code, released_date)
    SELECT 
        
        CONCAT('RES_', E.Offering_ID, '_', E.Student_ID) AS Result_ID,
        E.Student_ID,
        E.Offering_ID,
        
        
        CASE 
            WHEN ELI.final_exam_eligibility = FALSE THEN 0.00
            ELSE COALESCE((
                SELECT SUM(SM.raw_mark * (ASCH.weight_percentage / 100))
                FROM STUDENT_MARK SM
                JOIN ASSESSMENT_SCHEME ASCH ON SM.Scheme_ID = ASCH.Scheme_ID
                WHERE SM.Student_ID = E.Student_ID AND ASCH.Offering_ID = E.Offering_ID
            ), 0)
        END AS final_mark,
        
        
        'TBD' AS letter_grade,
        0.00 AS grade_point,
        'TBD' AS result_code,
        CURDATE() AS released_date
        
    FROM ENROLLMENT E
    JOIN ELIGIBILITY_RECORD ELI ON E.Student_ID = ELI.Student_ID AND E.Offering_ID = ELI.Offering_ID;

    
    UPDATE FINAL_RESULT FR
    JOIN GRADE_SCALE GS ON FLOOR(FR.final_mark) BETWEEN GS.min_mark AND GS.max_mark
    SET 
        FR.letter_grade = GS.letter_grade,
        FR.grade_point = GS.grade_point,
       
        FR.result_code = IF(FR.final_mark >= 35.00, 'PASS', 'FAIL');

END$$

DELIMITER ;


CALL Generate_Dynamic_Final_Result();


DROP PROCEDURE IF EXISTS Generate_Dynamic_GPA;

DELIMITER $$

CREATE PROCEDURE Generate_Dynamic_GPA()
BEGIN
   
    DELETE FROM GPA_RECORD;

  
    INSERT INTO GPA_RECORD (gpa_id, student_id, semester_id, sgpa, cgpa)
    SELECT 
        CONCAT('GPA_', CO.Semester_ID, '_', FR.Student_ID) AS gpa_id,
        FR.Student_ID AS student_id,
        CO.Semester_ID AS semester_id,
        
      
        CAST((SUM(CU.Credits * FR.grade_point) / SUM(CU.Credits)) AS DECIMAL(4,2)) AS sgpa,
        CAST((SUM(CU.Credits * FR.grade_point) / SUM(CU.Credits)) AS DECIMAL(4,2)) AS cgpa
        
    FROM FINAL_RESULT FR
    JOIN COURSE_OFFERING CO ON FR.Offering_ID = CO.Offering_ID
    JOIN COURSE_UNIT CU ON CO.Course_ID = CU.Course_ID
    GROUP BY FR.Student_ID, CO.Semester_ID;

END$$

DELIMITER ;


CALL Generate_Dynamic_Eligibility();
CALL Generate_Dynamic_Final_Result();
CALL Generate_Dynamic_GPA();


SELECT * FROM GPA_RECORD;

DELIMITER $$

-- =========================================================================
-- STORED PROCEDURES FOR REPORT GENERATION & DATA RETRIEVAL
-- =========================================================================

-- 1. Procedure to get Eligible or Not Eligible students for a specific course
-- (Pass TRUE/1 for Eligible students, FALSE/0 for Not Eligible students)
CREATE PROCEDURE SP_Get_Students_By_Eligibility(
    IN p_Course_Code VARCHAR(10),
    IN p_Is_Eligible BOOLEAN
)
BEGIN
    SELECT Reg_No, F_Name, L_Name, Course_Code, attendance_percentage, ca_mark, 
           CASE WHEN final_exam_eligibility = 1 THEN 'Eligible' ELSE 'Not Eligible' END AS Eligibility
    FROM Student_Eligibility_Summary
    WHERE Course_Code = p_Course_Code AND final_exam_eligibility = p_Is_Eligible;
END$$

-- 2. Procedure to get the final marks and grades of all subjects for a specific student
CREATE PROCEDURE SP_Get_Student_Final_Marks(
    IN p_Reg_No VARCHAR(20)
)
BEGIN
    SELECT Reg_No, Course_Code, Course_Name, final_mark, letter_grade, result_code 
    FROM Final_Marks_Summary 
    WHERE Reg_No = p_Reg_No;
END$$

-- 3. Procedure to get attendance details (percentage & status) of all subjects for a specific student
CREATE PROCEDURE SP_Get_One_Student_All_Attendance(
    IN p_Reg_No VARCHAR(20)
)
BEGIN
    SELECT Reg_No, Course_Code, Course_Name, attendance_percentage, Attendance_Status 
    FROM Student_Eligibility_Summary 
    WHERE Reg_No = p_Reg_No;
END$$

-- 4. Procedure to get CA marks and CA eligibility of a specific student for a specific course
CREATE PROCEDURE SP_Get_Student_CA_Course(
    IN p_Reg_No VARCHAR(20), 
    IN p_Course_Code VARCHAR(10)
)
BEGIN
    SELECT Reg_No, Course_Code, Course_Name, ca_mark, ca_eligibility 
    FROM Student_CA_Marks_Summary 
    WHERE Reg_No = p_Reg_No AND Course_Code = p_Course_Code;
END$$

-- 5. Procedure to get CA marks of the entire batch for a specific course
CREATE PROCEDURE SP_Get_Batch_CA_Course(
    IN p_Course_Code VARCHAR(10)
)
BEGIN
    SELECT Reg_No, F_Name, L_Name, Course_Code, ca_mark, ca_eligibility 
    FROM Batch_CA_Marks_Summary 
    WHERE Course_Code = p_Course_Code;
END$$

-- 6. Procedure to get attendance details of the entire batch for a specific course
CREATE PROCEDURE SP_Get_Batch_Attendance_Course(
    IN p_Course_Code VARCHAR(10)
)
BEGIN
    SELECT Reg_No, Course_Code, Attendance_Percentage, Eligibility_Status 
    FROM Batch_Attendance_Summary 
    WHERE Course_Code = p_Course_Code;
END$$

-- 7. Procedure to get all medical records submitted by a specific student
CREATE PROCEDURE SP_Get_Student_Medicals(
    IN p_Reg_No VARCHAR(20)
)
BEGIN
    SELECT Medical_ID, Reg_No, Student_Name, submitted_date, reason, Course_Code, Absent_Date, approval_status 
    FROM Medical_Status_View 
    WHERE Reg_No = p_Reg_No;
END$$

DELIMITER ;

-- =========================================================================
-- 1. CREATING MYSQL USERS
-- =========================================================================

-- Admin, Dean, Lecturer, and Technical Officer (TO) Users
CREATE USER IF NOT EXISTS 'admin_nalin'@'localhost' IDENTIFIED BY 'pass123';
CREATE USER IF NOT EXISTS 'dean_saman'@'localhost' IDENTIFIED BY 'pass123';
CREATE USER IF NOT EXISTS 'lec_amali'@'localhost' IDENTIFIED BY 'pass123';
CREATE USER IF NOT EXISTS 'to_kamal'@'localhost' IDENTIFIED BY 'pass123';

-- Student Users (5 Sample Students)
CREATE USER IF NOT EXISTS 'tg2095'@'localhost' IDENTIFIED BY 'pass123';
CREATE USER IF NOT EXISTS 'tg2096'@'localhost' IDENTIFIED BY 'pass123';
CREATE USER IF NOT EXISTS 'tg2097'@'localhost' IDENTIFIED BY 'pass123';
CREATE USER IF NOT EXISTS 'tg2112'@'localhost' IDENTIFIED BY 'pass123';
CREATE USER IF NOT EXISTS 'tg2113'@'localhost' IDENTIFIED BY 'pass123';

-- =========================================================================
-- 2. GRANTING PERMISSIONS FOR STAFF
-- =========================================================================

-- 1. ADMIN - All privileges with Grant Option for all tables in the database
GRANT ALL PRIVILEGES ON *.* TO 'admin_nalin'@'localhost' WITH GRANT OPTION;

-- 2. DEAN - All privileges without Grant Option for all tables in the database
GRANT ALL PRIVILEGES ON FOT_Academic_Management_DB.* TO 'dean_saman'@'localhost';

-- 3. LECTURER - All privileges without Grant Option and User Creation
GRANT ALL PRIVILEGES ON FOT_Academic_Management_DB.* TO 'lec_amali'@'localhost';

-- 4. TECHNICAL OFFICER (TO) - Read, write, and update permissions ONLY for attendance-related tables/views
GRANT SELECT, INSERT, UPDATE ON FOT_Academic_Management_DB.ATTENDANCE_RECORD TO 'to_kamal'@'localhost';
GRANT SELECT, INSERT, UPDATE ON FOT_Academic_Management_DB.SESSION TO 'to_kamal'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Batch_Attendance_Summary TO 'to_kamal'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Individual_Attendance_Summary TO 'to_kamal'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Individual_Subject_Attendance_Detail TO 'to_kamal'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Component_Wise_Attendance TO 'to_kamal'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Low_Attendance_View TO 'to_kamal'@'localhost';

-- =========================================================================
-- 3. GRANTING PERMISSIONS FOR STUDENTS
-- (Read permission for final attendance and final marks/grades views only)
-- =========================================================================

-- Permissions for tg2095
GRANT SELECT ON FOT_Academic_Management_DB.Student_Eligibility_Summary TO 'tg2095'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Final_Marks_Summary TO 'tg2095'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Detailed_Academic_Transcript TO 'tg2095'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Student_Grades_Summary TO 'tg2095'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Student_Profile_View TO 'tg2095'@'localhost';

-- Permissions for tg2096
GRANT SELECT ON FOT_Academic_Management_DB.Student_Eligibility_Summary TO 'tg2096'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Final_Marks_Summary TO 'tg2096'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Detailed_Academic_Transcript TO 'tg2096'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Student_Grades_Summary TO 'tg2096'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Student_Profile_View TO 'tg2096'@'localhost';

-- Permissions for tg2097
GRANT SELECT ON FOT_Academic_Management_DB.Student_Eligibility_Summary TO 'tg2097'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Final_Marks_Summary TO 'tg2097'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Detailed_Academic_Transcript TO 'tg2097'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Student_Grades_Summary TO 'tg2097'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Student_Profile_View TO 'tg2097'@'localhost';

-- Permissions for tg2112
GRANT SELECT ON FOT_Academic_Management_DB.Student_Eligibility_Summary TO 'tg2112'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Final_Marks_Summary TO 'tg2112'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Detailed_Academic_Transcript TO 'tg2112'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Student_Grades_Summary TO 'tg2112'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Student_Profile_View TO 'tg2112'@'localhost';

-- Permissions for tg2113
GRANT SELECT ON FOT_Academic_Management_DB.Student_Eligibility_Summary TO 'tg2113'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Final_Marks_Summary TO 'tg2113'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Detailed_Academic_Transcript TO 'tg2113'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Student_Grades_Summary TO 'tg2113'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Student_Profile_View TO 'tg2113'@'localhost';

-- =========================================================================
-- 4. APPLY AND SAVE CHANGES
-- =========================================================================
FLUSH PRIVILEGES;