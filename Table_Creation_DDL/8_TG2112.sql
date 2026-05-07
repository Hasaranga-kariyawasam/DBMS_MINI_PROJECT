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