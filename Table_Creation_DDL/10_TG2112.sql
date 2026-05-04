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