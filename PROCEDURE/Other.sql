DELIMITER $$

-- =========================================================================
-- STORED PROCEDURES FOR REPORT GENERATION & DATA RETRIEVAL
-- =========================================================================

-- 1. Procedure to get Eligible or Not Eligible students for a specific course
-- (Pass TRUE/1 for Eligible students, FALSE/0 for Not Eligible students)
CREATE PROCEDURE SP_Get_Students_By_Eligibility(
    IN p_Course_Code VARCHAR(10),
    IN p_Is_Eligible BOOLEAN
)
BEGIN
    SELECT Reg_No, F_Name, L_Name, Course_Code, attendance_percentage, ca_mark, 
           CASE WHEN final_exam_eligibility = 1 THEN 'Eligible' ELSE 'Not Eligible' END AS Eligibility
    FROM Student_Eligibility_Summary
    WHERE Course_Code = p_Course_Code AND final_exam_eligibility = p_Is_Eligible;
END$$

-- 2. Procedure to get the final marks and grades of all subjects for a specific student
CREATE PROCEDURE SP_Get_Student_Final_Marks(
    IN p_Reg_No VARCHAR(20)
)
BEGIN
    SELECT Reg_No, Course_Code, Course_Name, final_mark, letter_grade, result_code 
    FROM Final_Marks_Summary 
    WHERE Reg_No = p_Reg_No;
END$$

-- 3. Procedure to get attendance details (percentage & status) of all subjects for a specific student
CREATE PROCEDURE SP_Get_One_Student_All_Attendance(
    IN p_Reg_No VARCHAR(20)
)
BEGIN
    SELECT Reg_No, Course_Code, Course_Name, attendance_percentage, Attendance_Status 
    FROM Student_Eligibility_Summary 
    WHERE Reg_No = p_Reg_No;
END$$

-- 4. Procedure to get CA marks and CA eligibility of a specific student for a specific course
CREATE PROCEDURE SP_Get_Student_CA_Course(
    IN p_Reg_No VARCHAR(20), 
    IN p_Course_Code VARCHAR(10)
)
BEGIN
    SELECT Reg_No, Course_Code, Course_Name, ca_mark, ca_eligibility 
    FROM Student_CA_Marks_Summary 
    WHERE Reg_No = p_Reg_No AND Course_Code = p_Course_Code;
END$$

-- 5. Procedure to get CA marks of the entire batch for a specific course
CREATE PROCEDURE SP_Get_Batch_CA_Course(
    IN p_Course_Code VARCHAR(10)
)
BEGIN
    SELECT Reg_No, F_Name, L_Name, Course_Code, ca_mark, ca_eligibility 
    FROM Batch_CA_Marks_Summary 
    WHERE Course_Code = p_Course_Code;
END$$

-- 6. Procedure to get attendance details of the entire batch for a specific course
CREATE PROCEDURE SP_Get_Batch_Attendance_Course(
    IN p_Course_Code VARCHAR(10)
)
BEGIN
    SELECT Reg_No, Course_Code, Attendance_Percentage, Eligibility_Status 
    FROM Batch_Attendance_Summary 
    WHERE Course_Code = p_Course_Code;
END$$

-- 7. Procedure to get all medical records submitted by a specific student
CREATE PROCEDURE SP_Get_Student_Medicals(
    IN p_Reg_No VARCHAR(20)
)
BEGIN
    SELECT Medical_ID, Reg_No, Student_Name, submitted_date, reason, Course_Code, Absent_Date, approval_status 
    FROM Medical_Status_View 
    WHERE Reg_No = p_Reg_No;
END$$

DELIMITER ;