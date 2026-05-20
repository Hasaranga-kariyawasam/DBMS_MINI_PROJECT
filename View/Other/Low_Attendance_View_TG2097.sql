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

-- Select * from Low_Attendance_View;