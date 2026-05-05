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

CREATE TABLE COURSE_COMPONENT (
    Component_ID VARCHAR(20) PRIMARY KEY NOT NULL,
    offering_id VARCHAR(20) NOT NULL,
    component_type VARCHAR(20),
    total_sessions INT,
    total_hours INT,
    FOREIGN KEY (offering_id) REFERENCES COURSE_OFFERING(Offering_ID)
);

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