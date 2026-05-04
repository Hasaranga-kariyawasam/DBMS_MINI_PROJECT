INSERT INTO ASSESSMENT_TYPE (Assessment_Type_ID, Assessment_Name) VALUES
('AT_QZ', 'Quiz'),
('AT_PR', 'Project'),
('AT_MT', 'Mid Theory'),
('AT_MP', 'Mid Practical'),
('AT_FT', 'Final Theory'),
('AT_FP', 'Final Practical');


INSERT INTO ASSESSMENT_SCHEME 
(Scheme_ID, Offering_ID, Assessment_Type_ID, Component_ID, weight_percentage, assessment_no, max_marks, is_mandatory) 
VALUES
('SC_MGT_QZ', 'OFF_MGT', 'AT_QZ', 'CC_MGT', 5.00, 1, 100, TRUE),
('SC_MGT_PR', 'OFF_MGT', 'AT_PR', 'CC_MGT', 10.00, 1, 100, TRUE),
('SC_MGT_MT', 'OFF_MGT', 'AT_MT', 'CC_MGT', 15.00, 1, 100, TRUE),
('SC_MGT_FT', 'OFF_MGT', 'AT_FT', 'CC_MGT', 70.00, 1, 100, TRUE),

('SC_LIN_QZ', 'OFF_LIN', 'AT_QZ', 'CC_LIN_T', 5.00, 1, 100, TRUE),
('SC_LIN_PR', 'OFF_LIN', 'AT_PR', 'CC_LIN_T', 10.00, 1, 100, TRUE),
('SC_LIN_MT', 'OFF_LIN', 'AT_MT', 'CC_LIN_T', 15.00, 1, 100, TRUE),
('SC_LIN_FT', 'OFF_LIN', 'AT_FT', 'CC_LIN_T', 70.00, 1, 100, TRUE),

('SC_DBP_QZ', 'OFF_DBP', 'AT_QZ', 'CC_DBP', 10.00, 1, 100, TRUE),
('SC_DBP_PR', 'OFF_DBP', 'AT_PR', 'CC_DBP', 10.00, 1, 100, TRUE),
('SC_DBP_MT', 'OFF_DBP', 'AT_MT', 'CC_DBP', 20.00, 1, 100, TRUE),
('SC_DBP_MP', 'OFF_DBP', 'AT_MP', 'CC_DBP', 20.00, 1, 100, TRUE),
('SC_DBP_FP', 'OFF_DBP', 'AT_FP', 'CC_DBP', 60.00, 1, 100, TRUE),

('SC_WEB_QZ', 'OFF_WEB', 'AT_QZ', 'CC_WEB_T', 5.00, 1, 100, TRUE),
('SC_WEB_PR', 'OFF_WEB', 'AT_PR', 'CC_WEB_T', 10.00, 1, 100, TRUE),
('SC_WEB_MT', 'OFF_WEB', 'AT_MT', 'CC_WEB_T', 15.00, 1, 100, TRUE),
('SC_WEB_FT', 'OFF_WEB', 'AT_FT', 'CC_WEB_T', 70.00, 1, 100, TRUE),

('SC_WEP_QZ', 'OFF_WEP', 'AT_QZ', 'CC_WEB_P1', 10.00, 1, 100, TRUE),
('SC_WEP_PR', 'OFF_WEP', 'AT_PR', 'CC_WEB_P1', 10.00, 1, 100, TRUE),
('SC_WEP_MT', 'OFF_WEP', 'AT_MT', 'CC_WEB_P1', 20.00, 1, 100, TRUE),
('SC_WEP_MP', 'OFF_WEP', 'AT_MP', 'CC_WEB_P1', 20.00, 1, 100, TRUE),
('SC_WEP_FP', 'OFF_WEP', 'AT_FP', 'CC_WEB_P1', 60.00, 1, 100, TRUE),

('SC_MAT_QZ', 'OFF_MAT', 'AT_QZ', 'CC_MAT', 5.00, 1, 100, TRUE),
('SC_MAT_PR', 'OFF_MAT', 'AT_PR', 'CC_MAT', 10.00, 1, 100, TRUE),
('SC_MAT_MT', 'OFF_MAT', 'AT_MT', 'CC_MAT', 15.00, 1, 100, TRUE),
('SC_MAT_FT', 'OFF_MAT', 'AT_FT', 'CC_MAT', 70.00, 1, 100, TRUE),

('SC_ENG_QZ', 'OFF_ENG', 'AT_QZ', 'CC_ENG', 5.00, 1, 100, TRUE),
('SC_ENG_PR', 'OFF_ENG', 'AT_PR', 'CC_ENG', 10.00, 1, 100, TRUE),
('SC_ENG_MT', 'OFF_ENG', 'AT_MT', 'CC_ENG', 15.00, 1, 100, TRUE),
('SC_ENG_FT', 'OFF_ENG', 'AT_FT', 'CC_ENG', 70.00, 1, 100, TRUE),

('SC_DBS_QZ', 'OFF_DBS', 'AT_QZ', 'CC_DBS', 5.00, 1, 100, TRUE),
('SC_DBS_PR', 'OFF_DBS', 'AT_PR', 'CC_DBS', 10.00, 1, 100, TRUE),
('SC_DBS_MT', 'OFF_DBS', 'AT_MT', 'CC_DBS', 15.00, 1, 100, TRUE),
('SC_DBS_FT', 'OFF_DBS', 'AT_FT', 'CC_DBS', 70.00, 1, 100, TRUE),

('SC_OSC_QZ', 'OFF_OSC', 'AT_QZ', 'CC_OSC', 5.00, 1, 100, TRUE),
('SC_OSC_PR', 'OFF_OSC', 'AT_PR', 'CC_OSC', 10.00, 1, 100, TRUE),
('SC_OSC_MT', 'OFF_OSC', 'AT_MT', 'CC_OSC', 15.00, 1, 100, TRUE),
('SC_OSC_FT', 'OFF_OSC', 'AT_FT', 'CC_OSC', 70.00, 1, 100, TRUE);

INSERT INTO STUDENT_MARK (Mark_ID, Student_ID, Scheme_ID, entered_by, raw_mark, mark_status, entered_date) VALUES

-- -------------------------------------------------------------------------
-- 1. MGT (Fundamentals of Management) - ST03
-- -------------------------------------------------------------------------
-- MGT QUIZ (SC_MGT_QZ)
('M_MGTQ_01','S01','SC_MGT_QZ','ST03',85,'Verified','2026-07-20'),
('M_MGTQ_02','S02','SC_MGT_QZ','ST03',75,'Verified','2026-07-20'),
('M_MGTQ_03','S03','SC_MGT_QZ','ST03',65,'Verified','2026-07-20'),
('M_MGTQ_04','S04','SC_MGT_QZ','ST03',95,'Verified','2026-07-20'),
('M_MGTQ_05','S05','SC_MGT_QZ','ST03',88,'Verified','2026-07-20'),
('M_MGTQ_06','S06','SC_MGT_QZ','ST03',78,'Verified','2026-07-20'),
('M_MGTQ_07','S07','SC_MGT_QZ','ST03',82,'Verified','2026-07-20'),
('M_MGTQ_08','S08','SC_MGT_QZ','ST03',90,'Verified','2026-07-20'),
('M_MGTQ_09','S09','SC_MGT_QZ','ST03',0,'Verified','2026-07-20'),
('M_MGTQ_10','S10','SC_MGT_QZ','ST03',72,'Verified','2026-07-20'),

-- MGT PROJECT (SC_MGT_PR)
('M_MGTP_01','S01','SC_MGT_PR','ST03',88,'Verified','2026-07-22'),
('M_MGTP_02','S02','SC_MGT_PR','ST03',79,'Verified','2026-07-22'),
('M_MGTP_03','S03','SC_MGT_PR','ST03',68,'Verified','2026-07-22'),
('M_MGTP_04','S04','SC_MGT_PR','ST03',92,'Verified','2026-07-22'),
('M_MGTP_05','S05','SC_MGT_PR','ST03',85,'Verified','2026-07-22'),
('M_MGTP_06','S06','SC_MGT_PR','ST03',75,'Verified','2026-07-22'),
('M_MGTP_07','S07','SC_MGT_PR','ST03',84,'Verified','2026-07-22'),
('M_MGTP_08','S08','SC_MGT_PR','ST03',92,'Verified','2026-07-22'),
('M_MGTP_09','S09','SC_MGT_PR','ST03',0,'Verified','2026-07-22'),
('M_MGTP_10','S10','SC_MGT_PR','ST03',74,'Verified','2026-07-22'),

-- MGT MID THEORY (SC_MGT_MT)
('M_MGTM_01','S01','SC_MGT_MT','ST03',80,'Verified','2026-07-25'),
('M_MGTM_02','S02','SC_MGT_MT','ST03',82,'Verified','2026-07-25'),
('M_MGTM_03','S03','SC_MGT_MT','ST03',70,'Verified','2026-07-25'),
('M_MGTM_04','S04','SC_MGT_MT','ST03',90,'Verified','2026-07-25'),
('M_MGTM_05','S05','SC_MGT_MT','ST03',88,'Verified','2026-07-25'),
('M_MGTM_06','S06','SC_MGT_MT','ST03',75,'Verified','2026-07-25'),
('M_MGTM_07','S07','SC_MGT_MT','ST03',80,'Verified','2026-07-25'),
('M_MGTM_08','S08','SC_MGT_MT','ST03',88,'Verified','2026-07-25'),
('M_MGTM_09','S09','SC_MGT_MT','ST03',0,'Verified','2026-07-25'),
('M_MGTM_10','S10','SC_MGT_MT','ST03',75,'Verified','2026-07-25'),

-- MGT FINAL THEORY (SC_MGT_FT)
('M_MGTF_01','S01','SC_MGT_FT','ST03',88,'Verified','2026-08-20'),
('M_MGTF_02','S02','SC_MGT_FT','ST03',85,'Verified','2026-08-20'),
('M_MGTF_03','S03','SC_MGT_FT','ST03',72,'Verified','2026-08-20'),
('M_MGTF_04','S04','SC_MGT_FT','ST03',90,'Verified','2026-08-20'),
('M_MGTF_05','S05','SC_MGT_FT','ST03',92,'Verified','2026-08-20'),
('M_MGTF_06','S06','SC_MGT_FT','ST03',80,'Verified','2026-08-20'),
('M_MGTF_07','S07','SC_MGT_FT','ST03',82,'Verified','2026-08-20'),
('M_MGTF_08','S08','SC_MGT_FT','ST03',90,'Verified','2026-08-20'),
('M_MGTF_09','S09','SC_MGT_FT','ST03',0,'Verified','2026-08-20'),
('M_MGTF_10','S10','SC_MGT_FT','ST03',78,'Verified','2026-08-20'),

-- -------------------------------------------------------------------------
-- 2. LIN (System Prog. Fundamentals & Linux) - ST04
-- -------------------------------------------------------------------------
-- LIN QUIZ (SC_LIN_QZ)
('M_LINQ_01','S01','SC_LIN_QZ','ST04',82,'Verified','2026-07-20'),
('M_LINQ_02','S02','SC_LIN_QZ','ST04',78,'Verified','2026-07-20'),
('M_LINQ_03','S03','SC_LIN_QZ','ST04',68,'Verified','2026-07-20'),
('M_LINQ_04','S04','SC_LIN_QZ','ST04',90,'Verified','2026-07-20'),
('M_LINQ_05','S05','SC_LIN_QZ','ST04',86,'Verified','2026-07-20'),
('M_LINQ_06','S06','SC_LIN_QZ','ST04',75,'Verified','2026-07-20'),
('M_LINQ_07','S07','SC_LIN_QZ','ST04',80,'Verified','2026-07-20'),
('M_LINQ_08','S08','SC_LIN_QZ','ST04',88,'Verified','2026-07-20'),
('M_LINQ_09','S09','SC_LIN_QZ','ST04',0,'Verified','2026-07-20'),
('M_LINQ_10','S10','SC_LIN_QZ','ST04',75,'Verified','2026-07-20'),

-- LIN PROJECT (SC_LIN_PR)
('M_LINP_01','S01','SC_LIN_PR','ST04',85,'Verified','2026-07-22'),
('M_LINP_02','S02','SC_LIN_PR','ST04',80,'Verified','2026-07-22'),
('M_LINP_03','S03','SC_LIN_PR','ST04',72,'Verified','2026-07-22'),
('M_LINP_04','S04','SC_LIN_PR','ST04',92,'Verified','2026-07-22'),
('M_LINP_05','S05','SC_LIN_PR','ST04',88,'Verified','2026-07-22'),
('M_LINP_06','S06','SC_LIN_PR','ST04',78,'Verified','2026-07-22'),
('M_LINP_07','S07','SC_LIN_PR','ST04',84,'Verified','2026-07-22'),
('M_LINP_08','S08','SC_LIN_PR','ST04',90,'Verified','2026-07-22'),
('M_LINP_09','S09','SC_LIN_PR','ST04',0,'Verified','2026-07-22'),
('M_LINP_10','S10','SC_LIN_PR','ST04',76,'Verified','2026-07-22'),

-- LIN MID THEORY (SC_LIN_MT)
('M_LINM_01','S01','SC_LIN_MT','ST04',82,'Verified','2026-07-25'),
('M_LINM_02','S02','SC_LIN_MT','ST04',85,'Verified','2026-07-25'),
('M_LINM_03','S03','SC_LIN_MT','ST04',75,'Verified','2026-07-25'),
('M_LINM_04','S04','SC_LIN_MT','ST04',94,'Verified','2026-07-25'),
('M_LINM_05','S05','SC_LIN_MT','ST04',90,'Verified','2026-07-25'),
('M_LINM_06','S06','SC_LIN_MT','ST04',80,'Verified','2026-07-25'),
('M_LINM_07','S07','SC_LIN_MT','ST04',82,'Verified','2026-07-25'),
('M_LINM_08','S08','SC_LIN_MT','ST04',88,'Verified','2026-07-25'),
('M_LINM_09','S09','SC_LIN_MT','ST04',0,'Verified','2026-07-25'),
('M_LINM_10','S10','SC_LIN_MT','ST04',78,'Verified','2026-07-25'),

-- LIN FINAL THEORY (SC_LIN_FT)
('M_LINF_01','S01','SC_LIN_FT','ST04',85,'Verified','2026-08-20'),
('M_LINF_02','S02','SC_LIN_FT','ST04',80,'Verified','2026-08-20'),
('M_LINF_03','S03','SC_LIN_FT','ST04',75,'Verified','2026-08-20'),
('M_LINF_04','S04','SC_LIN_FT','ST04',90,'Verified','2026-08-20'),
('M_LINF_05','S05','SC_LIN_FT','ST04',92,'Verified','2026-08-20'),
('M_LINF_06','S06','SC_LIN_FT','ST04',78,'Verified','2026-08-20'),
('M_LINF_07','S07','SC_LIN_FT','ST04',85,'Verified','2026-08-20'),
('M_LINF_08','S08','SC_LIN_FT','ST04',92,'Verified','2026-08-20'),
('M_LINF_09','S09','SC_LIN_FT','ST04',0,'Verified','2026-08-20'),
('M_LINF_10','S10','SC_LIN_FT','ST04',80,'Verified','2026-08-20'),

-- -------------------------------------------------------------------------
-- 3. DBP (DBMS Practicum) - ST05 
-- -------------------------------------------------------------------------
-- DBP QUIZ (SC_DBP_QZ)
('M_DBPQ_01','S01','SC_DBP_QZ','ST05',85,'Verified','2026-07-20'),
('M_DBPQ_02','S02','SC_DBP_QZ','ST05',82,'Verified','2026-07-20'),
('M_DBPQ_03','S03','SC_DBP_QZ','ST05',70,'Verified','2026-07-20'),
('M_DBPQ_04','S04','SC_DBP_QZ','ST05',90,'Verified','2026-07-20'),
('M_DBPQ_05','S05','SC_DBP_QZ','ST05',92,'Verified','2026-07-20'),
('M_DBPQ_06','S06','SC_DBP_QZ','ST05',78,'Verified','2026-07-20'),
('M_DBPQ_07','S07','SC_DBP_QZ','ST05',85,'Verified','2026-07-20'),
('M_DBPQ_08','S08','SC_DBP_QZ','ST05',88,'Verified','2026-07-20'),
('M_DBPQ_09','S09','SC_DBP_QZ','ST05',0,'Verified','2026-07-20'),
('M_DBPQ_10','S10','SC_DBP_QZ','ST05',78,'Verified','2026-07-20'),

-- DBP PROJECT (SC_DBP_PR)
('M_DBPP_01','S01','SC_DBP_PR','ST05',88,'Verified','2026-07-22'),
('M_DBPP_02','S02','SC_DBP_PR','ST05',80,'Verified','2026-07-22'),
('M_DBPP_03','S03','SC_DBP_PR','ST05',74,'Verified','2026-07-22'),
('M_DBPP_04','S04','SC_DBP_PR','ST05',92,'Verified','2026-07-22'),
('M_DBPP_05','S05','SC_DBP_PR','ST05',95,'Verified','2026-07-22'),
('M_DBPP_06','S06','SC_DBP_PR','ST05',75,'Verified','2026-07-22'),
('M_DBPP_07','S07','SC_DBP_PR','ST05',86,'Verified','2026-07-22'),
('M_DBPP_08','S08','SC_DBP_PR','ST05',90,'Verified','2026-07-22'),
('M_DBPP_09','S09','SC_DBP_PR','ST05',0,'Verified','2026-07-22'),
('M_DBPP_10','S10','SC_DBP_PR','ST05',80,'Verified','2026-07-22'),

-- DBP MID PRACTICAL (SC_DBP_MP) <-- Updated as requested
('M_DBPM_01','S01','SC_DBP_MP','ST05',85,'Verified','2026-07-25'),
('M_DBPM_02','S02','SC_DBP_MP','ST05',82,'Verified','2026-07-25'),
('M_DBPM_03','S03','SC_DBP_MP','ST05',75,'Verified','2026-07-25'),
('M_DBPM_04','S04','SC_DBP_MP','ST05',94,'Verified','2026-07-25'),
('M_DBPM_05','S05','SC_DBP_MP','ST05',96,'Verified','2026-07-25'),
('M_DBPM_06','S06','SC_DBP_MP','ST05',78,'Verified','2026-07-25'),
('M_DBPM_07','S07','SC_DBP_MP','ST05',88,'Verified','2026-07-25'),
('M_DBPM_08','S08','SC_DBP_MP','ST05',91,'Verified','2026-07-25'),
('M_DBPM_09','S09','SC_DBP_MP','ST05',0,'Verified','2026-07-25'),
('M_DBPM_10','S10','SC_DBP_MP','ST05',80,'Verified','2026-07-25'),

-- DBP FINAL PRACTICAL (SC_DBP_FP)
('M_DBPF_01','S01','SC_DBP_FP','ST05',90,'Verified','2026-08-20'),
('M_DBPF_02','S02','SC_DBP_FP','ST05',86,'Verified','2026-08-20'),
('M_DBPF_03','S03','SC_DBP_FP','ST05',80,'Verified','2026-08-20'),
('M_DBPF_04','S04','SC_DBP_FP','ST05',95,'Verified','2026-08-20'),
('M_DBPF_05','S05','SC_DBP_FP','ST05',98,'Verified','2026-08-20'),
('M_DBPF_06','S06','SC_DBP_FP','ST05',82,'Verified','2026-08-20'),
('M_DBPF_07','S07','SC_DBP_FP','ST05',90,'Verified','2026-08-20'),
('M_DBPF_08','S08','SC_DBP_FP','ST05',94,'Verified','2026-08-20'),
('M_DBPF_09','S09','SC_DBP_FP','ST05',0,'Verified','2026-08-20'),
('M_DBPF_10','S10','SC_DBP_FP','ST05',85,'Verified','2026-08-20'),

-- -------------------------------------------------------------------------
-- 4. WEBT (Web Development Theory) - ST06
-- -------------------------------------------------------------------------
-- WEBT QUIZ (SC_WEB_QZ)
('M_WEBQ_01','S01','SC_WEB_QZ','ST06',86,'Verified','2026-07-20'),
('M_WEBQ_02','S02','SC_WEB_QZ','ST06',80,'Verified','2026-07-20'),
('M_WEBQ_03','S03','SC_WEB_QZ','ST06',72,'Verified','2026-07-20'),
('M_WEBQ_04','S04','SC_WEB_QZ','ST06',92,'Verified','2026-07-20'),
('M_WEBQ_05','S05','SC_WEB_QZ','ST06',90,'Verified','2026-07-20'),
('M_WEBQ_06','S06','SC_WEB_QZ','ST06',76,'Verified','2026-07-20'),
('M_WEBQ_07','S07','SC_WEB_QZ','ST06',82,'Verified','2026-07-20'),
('M_WEBQ_08','S08','SC_WEB_QZ','ST06',90,'Verified','2026-07-20'),
('M_WEBQ_09','S09','SC_WEB_QZ','ST06',0,'Verified','2026-07-20'),
('M_WEBQ_10','S10','SC_WEB_QZ','ST06',78,'Verified','2026-07-20'),

-- WEBT PROJECT (SC_WEB_PR)
('M_WEBP_01','S01','SC_WEB_PR','ST06',88,'Verified','2026-07-22'),
('M_WEBP_02','S02','SC_WEB_PR','ST06',82,'Verified','2026-07-22'),
('M_WEBP_03','S03','SC_WEB_PR','ST06',74,'Verified','2026-07-22'),
('M_WEBP_04','S04','SC_WEB_PR','ST06',94,'Verified','2026-07-22'),
('M_WEBP_05','S05','SC_WEB_PR','ST06',92,'Verified','2026-07-22'),
('M_WEBP_06','S06','SC_WEB_PR','ST06',78,'Verified','2026-07-22'),
('M_WEBP_07','S07','SC_WEB_PR','ST06',84,'Verified','2026-07-22'),
('M_WEBP_08','S08','SC_WEB_PR','ST06',92,'Verified','2026-07-22'),
('M_WEBP_09','S09','SC_WEB_PR','ST06',0,'Verified','2026-07-22'),
('M_WEBP_10','S10','SC_WEB_PR','ST06',80,'Verified','2026-07-22'),

-- WEBT MID THEORY (SC_WEB_MT)
('M_WEBM_01','S01','SC_WEB_MT','ST06',84,'Verified','2026-07-25'),
('M_WEBM_02','S02','SC_WEB_MT','ST06',80,'Verified','2026-07-25'),
('M_WEBM_03','S03','SC_WEB_MT','ST06',72,'Verified','2026-07-25'),
('M_WEBM_04','S04','SC_WEB_MT','ST06',92,'Verified','2026-07-25'),
('M_WEBM_05','S05','SC_WEB_MT','ST06',90,'Verified','2026-07-25'),
('M_WEBM_06','S06','SC_WEB_MT','ST06',76,'Verified','2026-07-25'),
('M_WEBM_07','S07','SC_WEB_MT','ST06',82,'Verified','2026-07-25'),
('M_WEBM_08','S08','SC_WEB_MT','ST06',90,'Verified','2026-07-25'),
('M_WEBM_09','S09','SC_WEB_MT','ST06',0,'Verified','2026-07-25'),
('M_WEBM_10','S10','SC_WEB_MT','ST06',78,'Verified','2026-07-25'),

-- WEBT FINAL THEORY (SC_WEB_FT)
('M_WEBF_01','S01','SC_WEB_FT','ST06',88,'Verified','2026-08-20'),
('M_WEBF_02','S02','SC_WEB_FT','ST06',84,'Verified','2026-08-20'),
('M_WEBF_03','S03','SC_WEB_FT','ST06',75,'Verified','2026-08-20'),
('M_WEBF_04','S04','SC_WEB_FT','ST06',94,'Verified','2026-08-20'),
('M_WEBF_05','S05','SC_WEB_FT','ST06',92,'Verified','2026-08-20'),
('M_WEBF_06','S06','SC_WEB_FT','ST06',78,'Verified','2026-08-20'),
('M_WEBF_07','S07','SC_WEB_FT','ST06',85,'Verified','2026-08-20'),
('M_WEBF_08','S08','SC_WEB_FT','ST06',92,'Verified','2026-08-20'),
('M_WEBF_09','S09','SC_WEB_FT','ST06',0,'Verified','2026-08-20'),
('M_WEBF_10','S10','SC_WEB_FT','ST06',80,'Verified','2026-08-20'),

-- -------------------------------------------------------------------------
-- 5. WEBP (Web Development Practicum) - ST07
-- -------------------------------------------------------------------------
-- WEBP QUIZ (SC_WEP_QZ)
('M_WEPQ_01','S01','SC_WEP_QZ','ST07',85,'Verified','2026-07-20'),
('M_WEPQ_02','S02','SC_WEP_QZ','ST07',75,'Verified','2026-07-20'),
('M_WEPQ_03','S03','SC_WEP_QZ','ST07',65,'Verified','2026-07-20'),
('M_WEPQ_04','S04','SC_WEP_QZ','ST07',95,'Verified','2026-07-20'),
('M_WEPQ_05','S05','SC_WEP_QZ','ST07',88,'Verified','2026-07-20'),
('M_WEPQ_06','S06','SC_WEP_QZ','ST07',78,'Verified','2026-07-20'),
('M_WEPQ_07','S07','SC_WEP_QZ','ST07',82,'Verified','2026-07-20'),
('M_WEPQ_08','S08','SC_WEP_QZ','ST07',90,'Verified','2026-07-20'),
('M_WEPQ_09','S09','SC_WEP_QZ','ST07',0,'Verified','2026-07-20'),
('M_WEPQ_10','S10','SC_WEP_QZ','ST07',72,'Verified','2026-07-20'),

-- WEBP PROJECT (SC_WEP_PR)
('M_WEPP_01','S01','SC_WEP_PR','ST07',88,'Verified','2026-07-22'),
('M_WEPP_02','S02','SC_WEP_PR','ST07',79,'Verified','2026-07-22'),
('M_WEPP_03','S03','SC_WEP_PR','ST07',68,'Verified','2026-07-22'),
('M_WEPP_04','S04','SC_WEP_PR','ST07',92,'Verified','2026-07-22'),
('M_WEPP_05','S05','SC_WEP_PR','ST07',85,'Verified','2026-07-22'),
('M_WEPP_06','S06','SC_WEP_PR','ST07',75,'Verified','2026-07-22'),
('M_WEPP_07','S07','SC_WEP_PR','ST07',84,'Verified','2026-07-22'),
('M_WEPP_08','S08','SC_WEP_PR','ST07',92,'Verified','2026-07-22'),
('M_WEPP_09','S09','SC_WEP_PR','ST07',0,'Verified','2026-07-22'),
('M_WEPP_10','S10','SC_WEP_PR','ST07',74,'Verified','2026-07-22'),

-- WEBP MID PRACTICAL (SC_WEP_MP) <-- Updated as requested
('M_WEPM_01','S01','SC_WEP_MP','ST07',80,'Verified','2026-07-25'),
('M_WEPM_02','S02','SC_WEP_MP','ST07',82,'Verified','2026-07-25'),
('M_WEPM_03','S03','SC_WEP_MP','ST07',70,'Verified','2026-07-25'),
('M_WEPM_04','S04','SC_WEP_MP','ST07',90,'Verified','2026-07-25'),
('M_WEPM_05','S05','SC_WEP_MP','ST07',88,'Verified','2026-07-25'),
('M_WEPM_06','S06','SC_WEP_MP','ST07',75,'Verified','2026-07-25'),
('M_WEPM_07','S07','SC_WEP_MP','ST07',80,'Verified','2026-07-25'),
('M_WEPM_08','S08','SC_WEP_MP','ST07',88,'Verified','2026-07-25'),
('M_WEPM_09','S09','SC_WEP_MP','ST07',0,'Verified','2026-07-25'),
('M_WEPM_10','S10','SC_WEP_MP','ST07',75,'Verified','2026-07-25'),

-- WEBP FINAL PRACTICAL (SC_WEP_FP)
('M_WEPF_01','S01','SC_WEP_FP','ST07',90,'Verified','2026-08-20'),
('M_WEPF_02','S02','SC_WEP_FP','ST07',86,'Verified','2026-08-20'),
('M_WEPF_03','S03','SC_WEP_FP','ST07',80,'Verified','2026-08-20'),
('M_WEPF_04','S04','SC_WEP_FP','ST07',95,'Verified','2026-08-20'),
('M_WEPF_05','S05','SC_WEP_FP','ST07',98,'Verified','2026-08-20'),
('M_WEPF_06','S06','SC_WEP_FP','ST07',82,'Verified','2026-08-20'),
('M_WEPF_07','S07','SC_WEP_FP','ST07',90,'Verified','2026-08-20'),
('M_WEPF_08','S08','SC_WEP_FP','ST07',94,'Verified','2026-08-20'),
('M_WEPF_09','S09','SC_WEP_FP','ST07',0,'Verified','2026-08-20'),
('M_WEPF_10','S10','SC_WEP_FP','ST07',85,'Verified','2026-08-20'),

-- -------------------------------------------------------------------------
-- 6. MAT (Discrete Mathematics) - ST08
-- -------------------------------------------------------------------------
-- MAT QUIZ (SC_MAT_QZ)
('M_MATQ_01','S01','SC_MAT_QZ','ST08',85,'Verified','2026-07-20'),
('M_MATQ_02','S02','SC_MAT_QZ','ST08',75,'Verified','2026-07-20'),
('M_MATQ_03','S03','SC_MAT_QZ','ST08',65,'Verified','2026-07-20'),
('M_MATQ_04','S04','SC_MAT_QZ','ST08',95,'Verified','2026-07-20'),
('M_MATQ_05','S05','SC_MAT_QZ','ST08',88,'Verified','2026-07-20'),
('M_MATQ_06','S06','SC_MAT_QZ','ST08',78,'Verified','2026-07-20'),
('M_MATQ_07','S07','SC_MAT_QZ','ST08',82,'Verified','2026-07-20'),
('M_MATQ_08','S08','SC_MAT_QZ','ST08',90,'Verified','2026-07-20'),
('M_MATQ_09','S09','SC_MAT_QZ','ST08',0,'Verified','2026-07-20'),
('M_MATQ_10','S10','SC_MAT_QZ','ST08',72,'Verified','2026-07-20'),

-- MAT PROJECT (SC_MAT_PR)
('M_MATP_01','S01','SC_MAT_PR','ST08',88,'Verified','2026-07-22'),
('M_MATP_02','S02','SC_MAT_PR','ST08',79,'Verified','2026-07-22'),
('M_MATP_03','S03','SC_MAT_PR','ST08',68,'Verified','2026-07-22'),
('M_MATP_04','S04','SC_MAT_PR','ST08',92,'Verified','2026-07-22'),
('M_MATP_05','S05','SC_MAT_PR','ST08',85,'Verified','2026-07-22'),
('M_MATP_06','S06','SC_MAT_PR','ST08',75,'Verified','2026-07-22'),
('M_MATP_07','S07','SC_MAT_PR','ST08',84,'Verified','2026-07-22'),
('M_MATP_08','S08','SC_MAT_PR','ST08',92,'Verified','2026-07-22'),
('M_MATP_09','S09','SC_MAT_PR','ST08',0,'Verified','2026-07-22'),
('M_MATP_10','S10','SC_MAT_PR','ST08',74,'Verified','2026-07-22'),

-- MAT MID THEORY (SC_MAT_MT)
('M_MATM_01','S01','SC_MAT_MT','ST08',80,'Verified','2026-07-25'),
('M_MATM_02','S02','SC_MAT_MT','ST08',82,'Verified','2026-07-25'),
('M_MATM_03','S03','SC_MAT_MT','ST08',70,'Verified','2026-07-25'),
('M_MATM_04','S04','SC_MAT_MT','ST08',90,'Verified','2026-07-25'),
('M_MATM_05','S05','SC_MAT_MT','ST08',88,'Verified','2026-07-25'),
('M_MATM_06','S06','SC_MAT_MT','ST08',75,'Verified','2026-07-25'),
('M_MATM_07','S07','SC_MAT_MT','ST08',80,'Verified','2026-07-25'),
('M_MATM_08','S08','SC_MAT_MT','ST08',88,'Verified','2026-07-25'),
('M_MATM_09','S09','SC_MAT_MT','ST08',0,'Verified','2026-07-25'),
('M_MATM_10','S10','SC_MAT_MT','ST08',75,'Verified','2026-07-25'),

-- MAT FINAL THEORY (SC_MAT_FT)
('M_MATF_01','S01','SC_MAT_FT','ST08',88,'Verified','2026-08-20'),
('M_MATF_02','S02','SC_MAT_FT','ST08',85,'Verified','2026-08-20'),
('M_MATF_03','S03','SC_MAT_FT','ST08',72,'Verified','2026-08-20'),
('M_MATF_04','S04','SC_MAT_FT','ST08',90,'Verified','2026-08-20'),
('M_MATF_05','S05','SC_MAT_FT','ST08',92,'Verified','2026-08-20'),
('M_MATF_06','S06','SC_MAT_FT','ST08',80,'Verified','2026-08-20'),
('M_MATF_07','S07','SC_MAT_FT','ST08',82,'Verified','2026-08-20'),
('M_MATF_08','S08','SC_MAT_FT','ST08',90,'Verified','2026-08-20'),
('M_MATF_09','S09','SC_MAT_FT','ST08',0,'Verified','2026-08-20'),
('M_MATF_10','S10','SC_MAT_FT','ST08',78,'Verified','2026-08-20'),

-- -------------------------------------------------------------------------
-- 7. ENG (English II) - ST09
-- -------------------------------------------------------------------------
-- ENG QUIZ (SC_ENG_QZ)
('M_ENGQ_01','S01','SC_ENG_QZ','ST09',85,'Verified','2026-07-20'),
('M_ENGQ_02','S02','SC_ENG_QZ','ST09',75,'Verified','2026-07-20'),
('M_ENGQ_03','S03','SC_ENG_QZ','ST09',65,'Verified','2026-07-20'),
('M_ENGQ_04','S04','SC_ENG_QZ','ST09',95,'Verified','2026-07-20'),
('M_ENGQ_05','S05','SC_ENG_QZ','ST09',88,'Verified','2026-07-20'),
('M_ENGQ_06','S06','SC_ENG_QZ','ST09',78,'Verified','2026-07-20'),
('M_ENGQ_07','S07','SC_ENG_QZ','ST09',82,'Verified','2026-07-20'),
('M_ENGQ_08','S08','SC_ENG_QZ','ST09',90,'Verified','2026-07-20'),
('M_ENGQ_09','S09','SC_ENG_QZ','ST09',0,'Verified','2026-07-20'),
('M_ENGQ_10','S10','SC_ENG_QZ','ST09',72,'Verified','2026-07-20'),

-- ENG PROJECT (SC_ENG_PR)
('M_ENGP_01','S01','SC_ENG_PR','ST09',88,'Verified','2026-07-22'),
('M_ENGP_02','S02','SC_ENG_PR','ST09',79,'Verified','2026-07-22'),
('M_ENGP_03','S03','SC_ENG_PR','ST09',68,'Verified','2026-07-22'),
('M_ENGP_04','S04','SC_ENG_PR','ST09',92,'Verified','2026-07-22'),
('M_ENGP_05','S05','SC_ENG_PR','ST09',85,'Verified','2026-07-22'),
('M_ENGP_06','S06','SC_ENG_PR','ST09',75,'Verified','2026-07-22'),
('M_ENGP_07','S07','SC_ENG_PR','ST09',84,'Verified','2026-07-22'),
('M_ENGP_08','S08','SC_ENG_PR','ST09',92,'Verified','2026-07-22'),
('M_ENGP_09','S09','SC_ENG_PR','ST09',0,'Verified','2026-07-22'),
('M_ENGP_10','S10','SC_ENG_PR','ST09',74,'Verified','2026-07-22'),

-- ENG MID THEORY (SC_ENG_MT)
('M_ENGM_01','S01','SC_ENG_MT','ST09',80,'Verified','2026-07-25'),
('M_ENGM_02','S02','SC_ENG_MT','ST09',82,'Verified','2026-07-25'),
('M_ENGM_03','S03','SC_ENG_MT','ST09',70,'Verified','2026-07-25'),
('M_ENGM_04','S04','SC_ENG_MT','ST09',90,'Verified','2026-07-25'),
('M_ENGM_05','S05','SC_ENG_MT','ST09',88,'Verified','2026-07-25'),
('M_ENGM_06','S06','SC_ENG_MT','ST09',75,'Verified','2026-07-25'),
('M_ENGM_07','S07','SC_ENG_MT','ST09',80,'Verified','2026-07-25'),
('M_ENGM_08','S08','SC_ENG_MT','ST09',88,'Verified','2026-07-25'),
('M_ENGM_09','S09','SC_ENG_MT','ST09',0,'Verified','2026-07-25'),
('M_ENGM_10','S10','SC_ENG_MT','ST09',75,'Verified','2026-07-25'),

-- ENG FINAL THEORY (SC_ENG_FT)
('M_ENGF_01','S01','SC_ENG_FT','ST09',88,'Verified','2026-08-20'),
('M_ENGF_02','S02','SC_ENG_FT','ST09',85,'Verified','2026-08-20'),
('M_ENGF_03','S03','SC_ENG_FT','ST09',72,'Verified','2026-08-20'),
('M_ENGF_04','S04','SC_ENG_FT','ST09',90,'Verified','2026-08-20'),
('M_ENGF_05','S05','SC_ENG_FT','ST09',92,'Verified','2026-08-20'),
('M_ENGF_06','S06','SC_ENG_FT','ST09',80,'Verified','2026-08-20'),
('M_ENGF_07','S07','SC_ENG_FT','ST09',82,'Verified','2026-08-20'),
('M_ENGF_08','S08','SC_ENG_FT','ST09',90,'Verified','2026-08-20'),
('M_ENGF_09','S09','SC_ENG_FT','ST09',0,'Verified','2026-08-20'),
('M_ENGF_10','S10','SC_ENG_FT','ST09',78,'Verified','2026-08-20'),

-- -------------------------------------------------------------------------
-- 8. DBS (Database Management Systems) - ST10
-- -------------------------------------------------------------------------
-- DBS QUIZ (SC_DBS_QZ)
('M_DBSQ_01','S01','SC_DBS_QZ','ST10',85,'Verified','2026-07-20'),
('M_DBSQ_02','S02','SC_DBS_QZ','ST10',75,'Verified','2026-07-20'),
('M_DBSQ_03','S03','SC_DBS_QZ','ST10',65,'Verified','2026-07-20'),
('M_DBSQ_04','S04','SC_DBS_QZ','ST10',95,'Verified','2026-07-20'),
('M_DBSQ_05','S05','SC_DBS_QZ','ST10',88,'Verified','2026-07-20'),
('M_DBSQ_06','S06','SC_DBS_QZ','ST10',78,'Verified','2026-07-20'),
('M_DBSQ_07','S07','SC_DBS_QZ','ST10',82,'Verified','2026-07-20'),
('M_DBSQ_08','S08','SC_DBS_QZ','ST10',90,'Verified','2026-07-20'),
('M_DBSQ_09','S09','SC_DBS_QZ','ST10',0,'Verified','2026-07-20'),
('M_DBSQ_10','S10','SC_DBS_QZ','ST10',72,'Verified','2026-07-20'),

-- DBS PROJECT (SC_DBS_PR)
('M_DBSP_01','S01','SC_DBS_PR','ST10',88,'Verified','2026-07-22'),
('M_DBSP_02','S02','SC_DBS_PR','ST10',79,'Verified','2026-07-22'),
('M_DBSP_03','S03','SC_DBS_PR','ST10',68,'Verified','2026-07-22'),
('M_DBSP_04','S04','SC_DBS_PR','ST10',92,'Verified','2026-07-22'),
('M_DBSP_05','S05','SC_DBS_PR','ST10',85,'Verified','2026-07-22'),
('M_DBSP_06','S06','SC_DBS_PR','ST10',75,'Verified','2026-07-22'),
('M_DBSP_07','S07','SC_DBS_PR','ST10',84,'Verified','2026-07-22'),
('M_DBSP_08','S08','SC_DBS_PR','ST10',92,'Verified','2026-07-22'),
('M_DBSP_09','S09','SC_DBS_PR','ST10',0,'Verified','2026-07-22'),
('M_DBSP_10','S10','SC_DBS_PR','ST10',74,'Verified','2026-07-22'),

-- DBS MID THEORY (SC_DBS_MT)
('M_DBSM_01','S01','SC_DBS_MT','ST10',80,'Verified','2026-07-25'),
('M_DBSM_02','S02','SC_DBS_MT','ST10',82,'Verified','2026-07-25'),
('M_DBSM_03','S03','SC_DBS_MT','ST10',70,'Verified','2026-07-25'),
('M_DBSM_04','S04','SC_DBS_MT','ST10',90,'Verified','2026-07-25'),
('M_DBSM_05','S05','SC_DBS_MT','ST10',88,'Verified','2026-07-25'),
('M_DBSM_06','S06','SC_DBS_MT','ST10',75,'Verified','2026-07-25'),
('M_DBSM_07','S07','SC_DBS_MT','ST10',80,'Verified','2026-07-25'),
('M_DBSM_08','S08','SC_DBS_MT','ST10',88,'Verified','2026-07-25'),
('M_DBSM_09','S09','SC_DBS_MT','ST10',0,'Verified','2026-07-25'),
('M_DBSM_10','S10','SC_DBS_MT','ST10',75,'Verified','2026-07-25'),

-- DBS FINAL THEORY (SC_DBS_FT)
('M_DBSF_01','S01','SC_DBS_FT','ST10',88,'Verified','2026-08-20'),
('M_DBSF_02','S02','SC_DBS_FT','ST10',85,'Verified','2026-08-20'),
('M_DBSF_03','S03','SC_DBS_FT','ST10',72,'Verified','2026-08-20'),
('M_DBSF_04','S04','SC_DBS_FT','ST10',90,'Verified','2026-08-20'),
('M_DBSF_05','S05','SC_DBS_FT','ST10',92,'Verified','2026-08-20'),
('M_DBSF_06','S06','SC_DBS_FT','ST10',80,'Verified','2026-08-20'),
('M_DBSF_07','S07','SC_DBS_FT','ST10',82,'Verified','2026-08-20'),
('M_DBSF_08','S08','SC_DBS_FT','ST10',90,'Verified','2026-08-20'),
('M_DBSF_09','S09','SC_DBS_FT','ST10',0,'Verified','2026-08-20'),
('M_DBSF_10','S10','SC_DBS_FT','ST10',78,'Verified','2026-08-20'),

-- -------------------------------------------------------------------------
-- 9. OSC (OS Concepts and Application) - ST03
-- -------------------------------------------------------------------------
-- OSC QUIZ (SC_OSC_QZ)
('M_OSCQ_01','S01','SC_OSC_QZ','ST03',85,'Verified','2026-07-20'),
('M_OSCQ_02','S02','SC_OSC_QZ','ST03',75,'Verified','2026-07-20'),
('M_OSCQ_03','S03','SC_OSC_QZ','ST03',65,'Verified','2026-07-20'),
('M_OSCQ_04','S04','SC_OSC_QZ','ST03',95,'Verified','2026-07-20'),
('M_OSCQ_05','S05','SC_OSC_QZ','ST03',88,'Verified','2026-07-20'),
('M_OSCQ_06','S06','SC_OSC_QZ','ST03',78,'Verified','2026-07-20'),
('M_OSCQ_07','S07','SC_OSC_QZ','ST03',82,'Verified','2026-07-20'),
('M_OSCQ_08','S08','SC_OSC_QZ','ST03',90,'Verified','2026-07-20'),
('M_OSCQ_09','S09','SC_OSC_QZ','ST03',0,'Verified','2026-07-20'),
('M_OSCQ_10','S10','SC_OSC_QZ','ST03',72,'Verified','2026-07-20'),

-- OSC PROJECT (SC_OSC_PR)
('M_OSCP_01','S01','SC_OSC_PR','ST03',88,'Verified','2026-07-22'),
('M_OSCP_02','S02','SC_OSC_PR','ST03',79,'Verified','2026-07-22'),
('M_OSCP_03','S03','SC_OSC_PR','ST03',68,'Verified','2026-07-22'),
('M_OSCP_04','S04','SC_OSC_PR','ST03',92,'Verified','2026-07-22'),
('M_OSCP_05','S05','SC_OSC_PR','ST03',85,'Verified','2026-07-22'),
('M_OSCP_06','S06','SC_OSC_PR','ST03',75,'Verified','2026-07-22'),
('M_OSCP_07','S07','SC_OSC_PR','ST03',84,'Verified','2026-07-22'),
('M_OSCP_08','S08','SC_OSC_PR','ST03',92,'Verified','2026-07-22'),
('M_OSCP_09','S09','SC_OSC_PR','ST03',0,'Verified','2026-07-22'),
('M_OSCP_10','S10','SC_OSC_PR','ST03',74,'Verified','2026-07-22'),

-- OSC MID THEORY (SC_OSC_MT)
('M_OSCM_01','S01','SC_OSC_MT','ST03',80,'Verified','2026-07-25'),
('M_OSCM_02','S02','SC_OSC_MT','ST03',82,'Verified','2026-07-25'),
('M_OSCM_03','S03','SC_OSC_MT','ST03',70,'Verified','2026-07-25'),
('M_OSCM_04','S04','SC_OSC_MT','ST03',90,'Verified','2026-07-25'),
('M_OSCM_05','S05','SC_OSC_MT','ST03',88,'Verified','2026-07-25'),
('M_OSCM_06','S06','SC_OSC_MT','ST03',75,'Verified','2026-07-25'),
('M_OSCM_07','S07','SC_OSC_MT','ST03',80,'Verified','2026-07-25'),
('M_OSCM_08','S08','SC_OSC_MT','ST03',88,'Verified','2026-07-25'),
('M_OSCM_09','S09','SC_OSC_MT','ST03',0,'Verified','2026-07-25'),
('M_OSCM_10','S10','SC_OSC_MT','ST03',75,'Verified','2026-07-25'),

-- OSC FINAL THEORY (SC_OSC_FT)
('M_OSCF_01','S01','SC_OSC_FT','ST03',88,'Verified','2026-08-20'),
('M_OSCF_02','S02','SC_OSC_FT','ST03',85,'Verified','2026-08-20'),
('M_OSCF_03','S03','SC_OSC_FT','ST03',72,'Verified','2026-08-20'),
('M_OSCF_04','S04','SC_OSC_FT','ST03',90,'Verified','2026-08-20'),
('M_OSCF_05','S05','SC_OSC_FT','ST03',92,'Verified','2026-08-20'),
('M_OSCF_06','S06','SC_OSC_FT','ST03',80,'Verified','2026-08-20'),
('M_OSCF_07','S07','SC_OSC_FT','ST03',82,'Verified','2026-08-20'),
('M_OSCF_08','S08','SC_OSC_FT','ST03',90,'Verified','2026-08-20'),
('M_OSCF_09','S09','SC_OSC_FT','ST03',0,'Verified','2026-08-20'),
('M_OSCF_10','S10','SC_OSC_FT','ST03',78,'Verified','2026-08-20');                  


