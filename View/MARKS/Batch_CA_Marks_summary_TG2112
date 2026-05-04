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