CREATE VIEW Individual_Subject_Attendance_Detail AS
SELECT 
    ST.Reg_No,
    CU.Course_Code,
    S.session_date,
    S.start_time,
    CC.component_type,
    A.attendance_status,
    A.marked_date
FROM STUDENT ST
JOIN ATTENDANCE_RECORD A ON ST.Student_ID = A.student_id
JOIN SESSION S ON A.session_id = S.Session_ID
JOIN COURSE_COMPONENT CC ON S.Component_ID = CC.Component_ID
JOIN COURSE_OFFERING CO ON CC.offering_id = CO.Offering_ID
JOIN COURSE_UNIT CU ON CO.Course_ID = CU.Course_ID;