CREATE VIEW Batch_Attendance_Summary AS
SELECT 
    ST.Reg_No,
    CU.Course_Code,
    CU.Course_Name,
    COUNT(S.Session_ID) AS Total_Sessions,
    SUM(CASE WHEN A.attendance_status IN ('Present', 'Medical') THEN 1 ELSE 0 END) AS Attended_Sessions,
    ROUND((SUM(CASE WHEN A.attendance_status IN ('Present', 'Medical') THEN 1 ELSE 0 END) / COUNT(S.Session_ID)) * 100, 2) AS Attendance_Percentage,
    CASE 
        WHEN (SUM(CASE WHEN A.attendance_status IN ('Present', 'Medical') THEN 1 ELSE 0 END) / COUNT(S.Session_ID)) * 100 >= 80.00 THEN 'Eligible'
        ELSE 'Not Eligible'
    END AS Eligibility_Status
FROM STUDENT ST
JOIN ATTENDANCE_RECORD A ON ST.Student_ID = A.student_id
JOIN SESSION S ON A.session_id = S.Session_ID
JOIN COURSE_COMPONENT CC ON S.Component_ID = CC.Component_ID
JOIN COURSE_OFFERING CO ON CC.offering_id = CO.Offering_ID
JOIN COURSE_UNIT CU ON CO.Course_ID = CU.Course_ID
GROUP BY ST.Reg_No, CU.Course_Code, CU.Course_Name;


-- SELECT * FROM Batch_Attendance_Summary;