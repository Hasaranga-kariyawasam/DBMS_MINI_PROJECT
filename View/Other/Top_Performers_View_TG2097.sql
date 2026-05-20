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

-- SELECT * FROM Top_Performers_View;