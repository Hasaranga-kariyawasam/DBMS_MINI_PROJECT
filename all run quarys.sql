

USE FOT_Academic_Management_DB;


DESCRIBE PERSON;


-- ============================================================
-- SECTION 2: SELECT * — Table data ඔක්කොම ගනී
-- ============================================================
-- LIMIT 50 දාලා — data ගොඩක් තියෙන tables slow වෙන්න බෑ
-- LIMIT ඉවත් කළොත් full data ගනී


SELECT * FROM PERSON LIMIT 50;
-- මූලික පුද්ගල records — students, staff, admins ඔක්කොම

SELECT * FROM DEPARTMENT LIMIT 50;
-- Faculty departments

SELECT * FROM SEMESTER LIMIT 50;
-- Academic semesters

SELECT * FROM ASSESSMENT_TYPE LIMIT 50;
-- AT_QZ=Quiz, AT_PR=Project, AT_MT=Mid Theory, AT_MP=Mid Practical, AT_FT=Final Theory, AT_FP=Final Practical

SELECT * FROM GRADE_SCALE LIMIT 50;
-- Mark ranges to letter grades (A, B+, B, C+, C, D, E, F)

SELECT * FROM STAFF LIMIT 50;
-- Staff records — Person_ID FK through PERSON table

SELECT * FROM STUDENT LIMIT 50;
-- Student records — Reg_no, Batch, Intake_Year

SELECT * FROM USER_ACCOUNT LIMIT 50;
-- System login accounts

SELECT * FROM COURSE_UNIT LIMIT 50;
-- Course/subject units — credits, type

SELECT * FROM ADMIN LIMIT 50;
-- Admin staff sub-type

SELECT * FROM DEAN LIMIT 50;
-- Dean staff sub-type

SELECT * FROM LECTURER LIMIT 50;
-- Lecturer staff sub-type — Academic_Rank

SELECT * FROM TECHNICAL_OFFICER LIMIT 50;
-- Technical officer sub-type — lab_assigned

SELECT * FROM COURSE_OFFERING LIMIT 50;
-- Course offerings per semester per batch

SELECT * FROM COURSE_COMPONENT LIMIT 50;
-- Lecture / Lab / Tutorial components

SELECT * FROM ENROLLMENT LIMIT 50;
-- Student enrollments

SELECT * FROM SESSION LIMIT 50;
-- Individual class sessions

SELECT * FROM GPA_RECORD LIMIT 50;
-- SGPA / CGPA records — procedure generate කරලා fill කරනවා

SELECT * FROM ASSESSMENT_SCHEME LIMIT 50;
-- Weight percentages per assessment per course

SELECT * FROM ATTENDANCE_RECORD LIMIT 50;
-- Student attendance — Present / Absent / Medical

SELECT * FROM MEDICAL_RECORD LIMIT 50;
-- Medical certificates submitted

SELECT * FROM STUDENT_MARK LIMIT 50;
-- Raw marks entered by staff

SELECT * FROM ELIGIBILITY_RECORD LIMIT 50;
-- Attendance % + CA mark + eligibility — procedure generate කරලා fill කරනවා

SELECT * FROM FINAL_RESULT LIMIT 50;
-- Final marks + letter grades + PASS/FAIL — procedure generate කරලා fill කරනවා


-- ============================================================
-- SECTION 3: VIEW QUERIES — View data ගනී
-- ============================================================


-- --- ATTENDANCE VIEWS ---

-- 1. Batch_Attendance_Summary
-- Batch-wise course attendance % සහ Eligible/Not Eligible status
SELECT * FROM Batch_Attendance_Summary LIMIT 50;

-- 2. Component_Wise_Attendance
-- Lecture / Lab / Tutorial component-wise attendance breakdown
SELECT * FROM Component_Wise_Attendance LIMIT 50;

-- 3. Individual_Attendance_Summary
-- Student name + subject-wise attendance %
SELECT * FROM Individual_Attendance_Summary LIMIT 50;

-- 4. Individual_Subject_Attendance_Detail
-- Session-level raw attendance — date, time, Present/Absent
SELECT * FROM Individual_Subject_Attendance_Detail LIMIT 50;

-- 5. Individual_CA_Marks_Detail
-- CA assessment weighted marks — Final exam marks exclude කරලා
SELECT * FROM Individual_CA_Marks_Detail LIMIT 50;


-- --- MARKS VIEWS ---

-- 6. Batch_CA_Marks_Summary
-- Course-wise batch CA marks + eligibility
SELECT * FROM Batch_CA_Marks_Summary LIMIT 50;

-- 7. Comprehensive_Marks_Breakdown
-- Quiz, Mid, Final marks pivot table — subject-wise breakdown
SELECT * FROM Comprehensive_Marks_Breakdown LIMIT 50;

-- 8. Final_Marks_Summary
-- Final mark + letter grade + PASS/FAIL + attendance %
SELECT * FROM Final_Marks_Summary LIMIT 50;

-- 9. Student_CA_Marks_Summary
-- Student-wise CA marks + eligibility
SELECT * FROM Student_CA_Marks_Summary LIMIT 50;


-- --- ELIGIBILITY & GRADE VIEWS ---

-- 10. Student_Eligibility_Summary
-- Attendance %, CA mark, CA eligibility, Final exam eligibility
SELECT * FROM Student_Eligibility_Summary LIMIT 50;

-- 11. Student_Grades_Summary
-- Final mark, grade, credits — transcript base
SELECT * FROM Student_Grades_Summary LIMIT 50;

-- 12. Detailed_Academic_Transcript
-- Full transcript — semester, subject, grade, SGPA, CGPA
SELECT * FROM Detailed_Academic_Transcript LIMIT 50;

-- 13. Batch_GPA_Summary
-- Batch-wise SGPA/CGPA ranking — CGPA high to low
SELECT * FROM Batch_GPA_Summary LIMIT 50;


-- --- OTHER VIEWS ---

-- 14. Low_Attendance_View
-- Attendance 80% below students — warning list
SELECT * FROM Low_Attendance_View LIMIT 50;

-- 15. Medical_Status_View
-- Medical certificate submissions + approval status
SELECT * FROM Medical_Status_View LIMIT 50;

-- 16. Session_Details_View
-- Session schedule — date, time, course, department
SELECT * FROM Session_Details_View LIMIT 50;

-- 17. Student_Profile_View
-- Student full profile — personal + academic info
SELECT * FROM Student_Profile_View LIMIT 50;

-- 18. Top_Performers_View
-- Final mark 80+ students — top achievers
SELECT * FROM Top_Performers_View LIMIT 50;


-- ============================================================
-- SECTION 4: PROCEDURE CODE
-- ============================================================
-- SHOW CREATE PROCEDURE use කළාම procedure source code ගනී


-- 1. Generate_Dynamic_Eligibility
-- ENROLLMENT loop කරලා attendance % + CA marks calculate කරලා
-- ELIGIBILITY_RECORD fill කරනවා
SHOW CREATE PROCEDURE Generate_Dynamic_Eligibility;

-- 2. Generate_Dynamic_Final_Result
-- Eligibility check කරලා final mark + letter grade + PASS/FAIL
-- FINAL_RESULT fill කරනවා
SHOW CREATE PROCEDURE Generate_Dynamic_Final_Result;

-- 3. Generate_Dynamic_GPA
-- FINAL_RESULT use කරලා SGPA/CGPA calculate කරලා
-- GPA_RECORD fill කරනවා
SHOW CREATE PROCEDURE Generate_Dynamic_GPA;

-- 4. SP_Get_Students_By_Eligibility
-- Course + eligibility filter කරලා student list
-- TRUE = Eligible, FALSE = Not Eligible
SHOW CREATE PROCEDURE SP_Get_Students_By_Eligibility;

-- 5. SP_Get_Student_Final_Marks
-- Student-wise subject final marks + grades
SHOW CREATE PROCEDURE SP_Get_Student_Final_Marks;

-- 6. SP_Get_One_Student_All_Attendance
-- Student-wise all subject attendance details
SHOW CREATE PROCEDURE SP_Get_One_Student_All_Attendance;

-- 7. SP_Get_Student_CA_Course
-- Student + course specific CA marks + eligibility
SHOW CREATE PROCEDURE SP_Get_Student_CA_Course;

-- 8. SP_Get_Batch_CA_Course
-- Course-wise batch CA marks
SHOW CREATE PROCEDURE SP_Get_Batch_CA_Course;

-- 9. SP_Get_Batch_Attendance_Course
-- Course-wise batch attendance summary
SHOW CREATE PROCEDURE SP_Get_Batch_Attendance_Course;

-- 10. SP_Get_Student_Medicals
-- Student medical records + approval status
SHOW CREATE PROCEDURE SP_Get_Student_Medicals;


-- ============================================================
-- BONUS: PROCEDURE CALL EXAMPLES
-- ============================================================
-- මේව demo/present කරනකොට use කරන්න

-- Procedures generate කරන execute order (IMPORTANT!)
CALL Generate_Dynamic_Eligibility();
CALL Generate_Dynamic_Final_Result();
CALL Generate_Dynamic_GPA();

-- Eligible students ගනී (CS1234 course)
CALL SP_Get_Students_By_Eligibility('CS1234', TRUE);

-- Not Eligible students ගනී (CS1234 course)
CALL SP_Get_Students_By_Eligibility('CS1234', FALSE);

-- Student final marks (Reg No change කරන්න)
CALL SP_Get_Student_Final_Marks('ICT/22/001');

-- Student attendance all subjects
CALL SP_Get_One_Student_All_Attendance('ICT/22/001');

-- Student CA marks for specific course
CALL SP_Get_Student_CA_Course('ICT/22/001', 'CS1234');

-- Batch CA marks for a course
CALL SP_Get_Batch_CA_Course('CS1234');

-- Batch attendance for a course
CALL SP_Get_Batch_Attendance_Course('CS1234');

-- Student medical records
CALL SP_Get_Student_Medicals('ICT/22/001');


-- ============================================================
-- END OF FILE
-- ============================================================

-- ============================================================
-- PROCEDURE EFFECTS — Tables වල data වෙනස් වීම බලනවා
-- ============================================================
-- Procedures run කළාම affect වෙන tables 3යි:
--   1. ELIGIBILITY_RECORD
--   2. FINAL_RESULT
--   3. GPA_RECORD
-- ============================================================


-- ============================================================
-- BEFORE — Procedures run කරන්න කලින් counts බලනවා
-- ============================================================

SELECT COUNT(*) AS Before_Eligibility FROM ELIGIBILITY_RECORD;
SELECT COUNT(*) AS Before_FinalResult FROM FINAL_RESULT;
SELECT COUNT(*) AS Before_GPA FROM GPA_RECORD;


-- ============================================================
-- STEP 1 — Generate_Dynamic_Eligibility
-- ============================================================
-- ENROLLMENT table loop කරලා:
--   - attendance % calculate කරනවා
--   - CA marks (Quiz, Mid, Project) sum කරනවා
--   - attendance >= 80% නම් eligibility = TRUE
-- ELIGIBILITY_RECORD table fill කරනවා

CALL Generate_Dynamic_Eligibility();

-- Effect බලනවා
SELECT COUNT(*) AS After_Eligibility FROM ELIGIBILITY_RECORD;

-- Data detail බලනවා
SELECT * FROM ELIGIBILITY_RECORD LIMIT 50;

-- Eligible vs Not Eligible count
SELECT
    ca_eligibility,
    final_exam_eligibility,
    COUNT(*) AS Student_Count
FROM ELIGIBILITY_RECORD
GROUP BY ca_eligibility, final_exam_eligibility;

-- Attendance % range breakdown
SELECT
    CASE
        WHEN attendance_percentage >= 80 THEN '80% සහ ඉහළ (Eligible)'
        WHEN attendance_percentage >= 60 THEN '60% - 79% (At Risk)'
        ELSE '60% යටතේ (Not Eligible)'
    END AS Attendance_Range,
    COUNT(*) AS Count
FROM ELIGIBILITY_RECORD
GROUP BY Attendance_Range;




CALL Generate_Dynamic_Final_Result();

-- Effect බලනවා
SELECT COUNT(*) AS After_FinalResult FROM FINAL_RESULT;

-- Data detail බලනවා
SELECT * FROM FINAL_RESULT LIMIT 50;

-- PASS vs FAIL count
SELECT
    result_code,
    COUNT(*) AS Count
FROM FINAL_RESULT
GROUP BY result_code;

-- Grade distribution
SELECT
    letter_grade,
    COUNT(*) AS Count
FROM FINAL_RESULT
GROUP BY letter_grade
ORDER BY grade_point DESC;

-- Average final mark
SELECT
    ROUND(AVG(final_mark), 2) AS Average_Mark,
    ROUND(MAX(final_mark), 2) AS Highest_Mark,
    ROUND(MIN(final_mark), 2) AS Lowest_Mark
FROM FINAL_RESULT;


CALL Generate_Dynamic_GPA();

-- Effect බලනවා
SELECT COUNT(*) AS After_GPA FROM GPA_RECORD;

-- Data detail බලනවා
SELECT * FROM GPA_RECORD LIMIT 50;

-- GPA range breakdown
SELECT
    CASE
        WHEN cgpa >= 3.70 THEN '3.70+ (First Class)'
        WHEN cgpa >= 3.30 THEN '3.30 - 3.69 (Second Upper)'
        WHEN cgpa >= 3.00 THEN '3.00 - 3.29 (Second Lower)'
        WHEN cgpa >= 2.00 THEN '2.00 - 2.99 (Pass)'
        ELSE '2.00 (Fail)'
    END AS GPA_Class,
    COUNT(*) AS Student_Count
FROM GPA_RECORD
GROUP BY GPA_Class
ORDER BY MIN(cgpa) DESC;


SELECT
    ER.*,
    ST.Reg_no
FROM ELIGIBILITY_RECORD ER
JOIN STUDENT ST ON ER.Student_ID = ST.Student_ID
WHERE ST.Reg_no = 'ICT/22/001';

-- Student final result
SELECT
    FR.*,
    ST.Reg_no
FROM FINAL_RESULT FR
JOIN STUDENT ST ON FR.Student_ID = ST.Student_ID
WHERE ST.Reg_no = 'ICT/22/001';

-- Student GPA
SELECT
    GR.*,
    ST.Reg_no
FROM GPA_RECORD GR
JOIN STUDENT ST ON GR.student_id = ST.Student_ID
WHERE ST.Reg_no = 'ICT/22/001';


-- ============================================================
-- FULL PICTURE — Student කෙනෙකුගේ ඔක්කොම එකම query එකෙන්
-- ============================================================

SELECT
    ST.Reg_no,
    CONCAT(P.F_Name, ' ', P.L_Name) AS Student_Name,
    CU.Course_Code,
    CU.Course_Name,
    ER.attendance_percentage,
    ER.ca_mark,
    ER.final_exam_eligibility,
    FR.final_mark,
    FR.letter_grade,
    FR.grade_point,
    FR.result_code,
    GR.sgpa,
    GR.cgpa
FROM STUDENT ST
JOIN PERSON P ON ST.Person_ID = P.Person_ID
JOIN ELIGIBILITY_RECORD ER ON ST.Student_ID = ER.Student_ID
JOIN FINAL_RESULT FR ON ST.Student_ID = FR.Student_ID
    AND ER.Offering_ID = FR.Offering_ID
JOIN COURSE_OFFERING CO ON FR.Offering_ID = CO.Offering_ID
JOIN COURSE_UNIT CU ON CO.Course_ID = CU.Course_ID
JOIN GPA_RECORD GR ON ST.Student_ID = GR.student_id
    AND CO.Semester_ID = GR.semester_id
WHERE ST.Reg_no = 'ICT/22/001'
ORDER BY CU.Course_Code;


-- ============================================================
-- END OF FILE
-- ============================================================