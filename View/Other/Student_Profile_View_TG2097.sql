CREATE OR REPLACE VIEW Student_Profile_View AS
SELECT 
    S.Reg_no AS Reg_No,
    CONCAT(P.F_Name, ' ', P.L_Name) AS Full_Name,
    P.F_Name,
    P.L_Name,
    P.NIC,
    P.Gender,
    P.DOB,
    P.Phone_No,
    P.Address,
    S.Batch,
    S.Intake_Year AS Academic_Year,
    S.Status AS Student_Status
FROM STUDENT S
JOIN PERSON P ON S.Person_ID = P.Person_ID;

-- SELECT * FROM Student_Profile_View;