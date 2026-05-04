CREATE VIEW Individual_CA_Marks_Detail AS
SELECT 
    ST.Reg_No,
    CU.Course_Code,
    ATY.Assessment_Name,
    SM.raw_mark,
    SCH.weight_percentage,
    ROUND((SM.raw_mark * (SCH.weight_percentage / 100)), 2) AS weighted_mark
FROM STUDENT_MARK SM
JOIN ASSESSMENT_SCHEME SCH ON SM.Scheme_ID = SCH.Scheme_ID
JOIN ASSESSMENT_TYPE ATY ON SCH.Assessment_Type_ID = ATY.Assessment_Type_ID
JOIN STUDENT ST ON SM.Student_ID = ST.Student_ID
JOIN COURSE_OFFERING CO ON SCH.Offering_ID = CO.Offering_ID
JOIN COURSE_UNIT CU ON CO.Course_ID = CU.Course_ID
-- 'AT_FT' (Final Theory), 'AT_FP' (Final Practical) අයින් කරලා CA විතරක් ගන්නවා
WHERE ATY.Assessment_Type_ID NOT IN ('AT_FT', 'AT_FP');