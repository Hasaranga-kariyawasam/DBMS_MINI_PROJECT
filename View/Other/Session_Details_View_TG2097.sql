CREATE VIEW Session_Details_View AS
SELECT 
    SE.Session_ID,
    CC.component_type AS Session_Type,
    SE.week_no,
    SE.session_date,
    SE.start_time,
    SE.end_time,
    CU.Course_Code,
    CU.Course_Name,
    CU.Credits,
    CU.Course_Type,
    D.Department_Name
FROM SESSION SE
JOIN COURSE_COMPONENT CC ON SE.Component_ID = CC.Component_ID
JOIN COURSE_OFFERING CO ON CC.offering_id = CO.Offering_ID
JOIN COURSE_UNIT CU ON CO.Course_ID = CU.Course_ID
JOIN DEPARTMENT D ON CU.Department_ID = D.Department_ID;

-- SELECT * FROM Session_Details_View;