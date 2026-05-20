
DROP PROCEDURE IF EXISTS Generate_Dynamic_GPA;

DELIMITER $$

CREATE PROCEDURE Generate_Dynamic_GPA()
BEGIN
   
    DELETE FROM GPA_RECORD;

  
    INSERT INTO GPA_RECORD (gpa_id, student_id, semester_id, sgpa, cgpa)
    SELECT 
        CONCAT('GPA_', CO.Semester_ID, '_', FR.Student_ID) AS gpa_id,
        FR.Student_ID AS student_id,
        CO.Semester_ID AS semester_id,
        
      
        CAST((SUM(CU.Credits * FR.grade_point) / SUM(CU.Credits)) AS DECIMAL(4,2)) AS sgpa,
        CAST((SUM(CU.Credits * FR.grade_point) / SUM(CU.Credits)) AS DECIMAL(4,2)) AS cgpa
        
    FROM FINAL_RESULT FR
    JOIN COURSE_OFFERING CO ON FR.Offering_ID = CO.Offering_ID
    JOIN COURSE_UNIT CU ON CO.Course_ID = CU.Course_ID
    GROUP BY FR.Student_ID, CO.Semester_ID;

END$$

DELIMITER ;



CALL Generate_Dynamic_GPA();


-- SELECT * FROM GPA_RECORD;