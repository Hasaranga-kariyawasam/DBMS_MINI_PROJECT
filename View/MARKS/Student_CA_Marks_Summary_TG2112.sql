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