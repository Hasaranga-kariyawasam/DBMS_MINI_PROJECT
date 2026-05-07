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