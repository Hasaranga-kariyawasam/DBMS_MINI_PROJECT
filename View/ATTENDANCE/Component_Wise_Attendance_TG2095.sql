CREATE VIEW Component_Wise_Attendance AS
SELECT 
    ST.Reg_No,
    CU.Course_Code,
    CC.component_type,
    COUNT(S.Session_ID) AS Total_Sessions,
    SUM(CASE WHEN A.attendance_status IN ('Present', 'Medical') THEN 1 ELSE 0 END) AS Attended_Sessions,
    ROUND((SUM(CASE WHEN A.attendance_status IN ('Present', 'Medical') THEN 1 ELSE 0 END) / COUNT(S.Session_ID)) * 100, 2) AS Component_Attendance_Percentage
FROM STUDENT ST
JOIN ATTENDANCE_RECORD A ON ST.Student_ID = A.student_id
JOIN SESSION S ON A.session_id = S.Session_ID
JOIN COURSE_COMPONENT CC ON S.Component_ID = CC.Component_ID
JOIN COURSE_OFFERING CO ON CC.offering_id = CO.Offering_ID
JOIN COURSE_UNIT CU ON CO.Course_ID = CU.Course_ID
GROUP BY ST.Reg_No, CU.Course_Code, CC.component_type;