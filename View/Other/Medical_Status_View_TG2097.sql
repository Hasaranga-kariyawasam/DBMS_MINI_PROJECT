CREATE VIEW Medical_Status_View AS
SELECT 
    M.Medical_ID,
    S.Reg_No,
    CONCAT(P.F_Name, ' ', P.L_Name) AS Student_Name,
    M.submitted_date,
    M.reason,
    CU.Course_Code,
    CC.component_type AS Session_Type,
    SE.week_no,
    SE.session_date AS Absent_Date,
    M.approval_status
FROM MEDICAL_RECORD M
JOIN STUDENT S ON M.Student_ID = S.Student_ID
JOIN PERSON P ON S.Person_ID = P.Person_ID
JOIN SESSION SE ON M.Session_ID = SE.Session_ID
JOIN COURSE_COMPONENT CC ON SE.Component_ID = CC.Component_ID
JOIN COURSE_OFFERING CO ON CC.offering_id = CO.Offering_ID
JOIN COURSE_UNIT CU ON CO.Course_ID = CU.Course_ID;

-- SELECT * FROM Medical_Status_View;