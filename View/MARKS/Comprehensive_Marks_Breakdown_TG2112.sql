CREATE VIEW Comprehensive_Marks_Breakdown AS
SELECT 
    ST.Reg_No,
    CU.Course_Code,
    CU.Course_Name,
    -- Quiz Marks
    MAX(CASE WHEN ATY.Assessment_Type_ID = 'AT_QZ' THEN SM.raw_mark ELSE NULL END) AS Quiz_Mark,
    -- Project Marks
    MAX(CASE WHEN ATY.Assessment_Type_ID = 'AT_PR' THEN SM.raw_mark ELSE NULL END) AS Project_Mark,
    -- Mid Theory Marks
    MAX(CASE WHEN ATY.Assessment_Type_ID = 'AT_MT' THEN SM.raw_mark ELSE NULL END) AS Mid_Theory_Mark,
    -- Mid Practical Marks
    MAX(CASE WHEN ATY.Assessment_Type_ID = 'AT_MP' THEN SM.raw_mark ELSE NULL END) AS Mid_Practical_Mark,
    -- Final Theory Marks
    MAX(CASE WHEN ATY.Assessment_Type_ID = 'AT_FT' THEN SM.raw_mark ELSE NULL END) AS Final_Theory_Mark,
    -- Final Practical Marks
    MAX(CASE WHEN ATY.Assessment_Type_ID = 'AT_FP' THEN SM.raw_mark ELSE NULL END) AS Final_Practical_Mark
FROM STUDENT ST
JOIN STUDENT_MARK SM ON ST.Student_ID = SM.Student_ID
JOIN ASSESSMENT_SCHEME SCH ON SM.Scheme_ID = SCH.Scheme_ID
JOIN ASSESSMENT_TYPE ATY ON SCH.Assessment_Type_ID = ATY.Assessment_Type_ID
JOIN COURSE_OFFERING CO ON SCH.Offering_ID = CO.Offering_ID
JOIN COURSE_UNIT CU ON CO.Course_ID = CU.Course_ID
GROUP BY ST.Reg_No, CU.Course_Code, CU.Course_Name;


-- SELECT * FROM Comprehensive_Marks_Breakdown;