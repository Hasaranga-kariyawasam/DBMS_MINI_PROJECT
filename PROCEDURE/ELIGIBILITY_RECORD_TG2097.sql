
DROP PROCEDURE IF EXISTS Generate_Dynamic_Eligibility;

DELIMITER $$

CREATE PROCEDURE Generate_Dynamic_Eligibility()
BEGIN

    DELETE FROM ELIGIBILITY_RECORD;


    INSERT INTO ELIGIBILITY_RECORD (Eligibility_ID, Student_ID, Offering_ID, attendance_percentage, ca_mark, ca_eligibility, final_exam_eligibility)
    SELECT 

        CONCAT('ELI_', E.Offering_ID, '_', E.Student_ID),
        E.Student_ID,
        E.Offering_ID,
        

        COALESCE((
            SELECT (SUM(CASE WHEN A.attendance_status IN ('Present', 'Medical') THEN 1 ELSE 0 END) / COUNT(*)) * 100
            FROM ATTENDANCE_RECORD A
            JOIN SESSION S ON A.session_id = S.Session_ID
            JOIN COURSE_COMPONENT C ON S.Component_ID = C.Component_ID
            WHERE A.student_id = E.Student_ID AND C.offering_id = E.Offering_ID
        ), 0) AS attendance_percentage,

 
        COALESCE((
            SELECT SUM(SM.raw_mark * (ASCH.weight_percentage / 100))
            FROM STUDENT_MARK SM
            JOIN ASSESSMENT_SCHEME ASCH ON SM.Scheme_ID = ASCH.Scheme_ID
            WHERE SM.Student_ID = E.Student_ID 
              AND ASCH.Offering_ID = E.Offering_ID 
            
              AND ASCH.Assessment_Type_ID IN ('AT_QZ', 'AT_PR', 'AT_MT', 'AT_MP')
        ), 0) AS ca_mark,

       
        FALSE, 
        FALSE
    FROM ENROLLMENT E;

    
    UPDATE ELIGIBILITY_RECORD 
    SET ca_eligibility = IF(attendance_percentage >= 80.00, TRUE, FALSE),
        final_exam_eligibility = IF(attendance_percentage >= 80.00, TRUE, FALSE);

END$$

DELIMITER ;


CALL Generate_Dynamic_Eligibility();

-- SELECT * FROM ELIGIBILITY_RECORD;