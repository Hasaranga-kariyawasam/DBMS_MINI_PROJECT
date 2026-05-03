CREATE TABLE GPA_RECORD (
    gpa_id VARCHAR(20) PRIMARY KEY NOT NULL,
    student_id VARCHAR(20) NOT NULL,
    semester_id VARCHAR(20) NOT NULL,
    sgpa DECIMAL(4,2),
    cgpa DECIMAL(4,2),
    FOREIGN KEY (student_id) REFERENCES STUDENT(Student_ID),
    FOREIGN KEY (semester_id) REFERENCES SEMESTER(Semester_ID)
);

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