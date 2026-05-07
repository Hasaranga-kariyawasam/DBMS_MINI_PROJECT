CREATE VIEW Final_Marks_Summary AS
SELECT 
    CU.Course_Code,
    CU.Course_Name,
    ST.Reg_No,
    P.F_Name,
    P.L_Name,
    ER.attendance_percentage,
    ER.ca_mark,
    FR.final_mark,
    FR.letter_grade,
    FR.grade_point,
    FR.result_code
FROM FINAL_RESULT FR
JOIN ELIGIBILITY_RECORD ER ON FR.Student_ID = ER.Student_ID AND FR.Offering_ID = ER.Offering_ID
JOIN STUDENT ST ON FR.Student_ID = ST.Student_ID
JOIN PERSON P ON ST.Person_ID = P.Person_ID
JOIN COURSE_OFFERING CO ON FR.Offering_ID = CO.Offering_ID
JOIN COURSE_UNIT CU ON CO.Course_ID = CU.Course_ID;