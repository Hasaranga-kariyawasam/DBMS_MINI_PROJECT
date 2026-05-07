CREATE TABLE Person (
    Person_ID     VARCHAR(20) PRIMARY KEY,
    F_Name        VARCHAR(50)  NOT NULL,
    L_Name        VARCHAR(50)  NOT NULL,
    NIC           VARCHAR(20)  NOT NULL UNIQUE,
    Gender        ENUM('Male', 'Female', 'Other') NOT NULL,
    DOB           DATE         NOT NULL,
    Phone_No      VARCHAR(15),
    Address       VARCHAR(255)
);
