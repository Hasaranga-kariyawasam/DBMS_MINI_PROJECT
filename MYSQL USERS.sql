-- =========================================================================
-- 1. CREATING MYSQL USERS
-- =========================================================================

-- Admin, Dean, Lecturer, and Technical Officer (TO) Users
CREATE USER IF NOT EXISTS 'admin_nalin'@'localhost' IDENTIFIED BY 'pass123';
CREATE USER IF NOT EXISTS 'dean_saman'@'localhost' IDENTIFIED BY 'pass123';
CREATE USER IF NOT EXISTS 'lec_amali'@'localhost' IDENTIFIED BY 'pass123';
CREATE USER IF NOT EXISTS 'to_kamal'@'localhost' IDENTIFIED BY 'pass123';

-- Student Users (5 Sample Students)
CREATE USER IF NOT EXISTS 'tg2095'@'localhost' IDENTIFIED BY 'pass123';
CREATE USER IF NOT EXISTS 'tg2096'@'localhost' IDENTIFIED BY 'pass123';
CREATE USER IF NOT EXISTS 'tg2097'@'localhost' IDENTIFIED BY 'pass123';
CREATE USER IF NOT EXISTS 'tg2112'@'localhost' IDENTIFIED BY 'pass123';
CREATE USER IF NOT EXISTS 'tg2113'@'localhost' IDENTIFIED BY 'pass123';

-- =========================================================================
-- 2. GRANTING PERMISSIONS FOR STAFF
-- =========================================================================

-- 1. ADMIN - All privileges with Grant Option for all tables in the database
GRANT ALL PRIVILEGES ON *.* TO 'admin_nalin'@'localhost' WITH GRANT OPTION;

-- 2. DEAN - All privileges without Grant Option for all tables in the database
GRANT ALL PRIVILEGES ON FOT_Academic_Management_DB.* TO 'dean_saman'@'localhost';

-- 3. LECTURER - All privileges without Grant Option and User Creation
GRANT ALL PRIVILEGES ON FOT_Academic_Management_DB.* TO 'lec_amali'@'localhost';

-- 4. TECHNICAL OFFICER (TO) - Read, write, and update permissions ONLY for attendance-related tables/views
GRANT SELECT, INSERT, UPDATE ON FOT_Academic_Management_DB.ATTENDANCE_RECORD TO 'to_kamal'@'localhost';
GRANT SELECT, INSERT, UPDATE ON FOT_Academic_Management_DB.SESSION TO 'to_kamal'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Batch_Attendance_Summary TO 'to_kamal'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Individual_Attendance_Summary TO 'to_kamal'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Individual_Subject_Attendance_Detail TO 'to_kamal'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Component_Wise_Attendance TO 'to_kamal'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Low_Attendance_View TO 'to_kamal'@'localhost';

-- =========================================================================
-- 3. GRANTING PERMISSIONS FOR STUDENTS
-- (Read permission for final attendance and final marks/grades views only)
-- =========================================================================

-- Permissions for tg2095
GRANT SELECT ON FOT_Academic_Management_DB.Student_Eligibility_Summary TO 'tg2095'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Final_Marks_Summary TO 'tg2095'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Detailed_Academic_Transcript TO 'tg2095'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Student_Grades_Summary TO 'tg2095'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Student_Profile_View TO 'tg2095'@'localhost';

-- Permissions for tg2096
GRANT SELECT ON FOT_Academic_Management_DB.Student_Eligibility_Summary TO 'tg2096'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Final_Marks_Summary TO 'tg2096'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Detailed_Academic_Transcript TO 'tg2096'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Student_Grades_Summary TO 'tg2096'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Student_Profile_View TO 'tg2096'@'localhost';

-- Permissions for tg2097
GRANT SELECT ON FOT_Academic_Management_DB.Student_Eligibility_Summary TO 'tg2097'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Final_Marks_Summary TO 'tg2097'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Detailed_Academic_Transcript TO 'tg2097'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Student_Grades_Summary TO 'tg2097'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Student_Profile_View TO 'tg2097'@'localhost';

-- Permissions for tg2112
GRANT SELECT ON FOT_Academic_Management_DB.Student_Eligibility_Summary TO 'tg2112'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Final_Marks_Summary TO 'tg2112'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Detailed_Academic_Transcript TO 'tg2112'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Student_Grades_Summary TO 'tg2112'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Student_Profile_View TO 'tg2112'@'localhost';

-- Permissions for tg2113
GRANT SELECT ON FOT_Academic_Management_DB.Student_Eligibility_Summary TO 'tg2113'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Final_Marks_Summary TO 'tg2113'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Detailed_Academic_Transcript TO 'tg2113'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Student_Grades_Summary TO 'tg2113'@'localhost';
GRANT SELECT ON FOT_Academic_Management_DB.Student_Profile_View TO 'tg2113'@'localhost';

-- =========================================================================
-- 4. APPLY AND SAVE CHANGES
-- =========================================================================
FLUSH PRIVILEGES;