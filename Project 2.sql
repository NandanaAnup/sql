-- Question 1 --
CREATE SCHEMA alumni;
-- Question 2 --
-- .csv files have been imported in mysql
-- Question 3 --
USE alumni;
DESC college_a_hs;
DESC college_a_se;
DESC college_a_sj;
DESC college_b_hs;
DESC college_b_se;
DESC college_b_sj; 

-- Question 6 --
CREATE VIEW college_a_hs_v AS SELECT * FROM college_a_hs WHERE RollNo IS NOT NULL AND
LastUpdate IS NOT NULL AND Name IS NOT NULL AND FatherName IS NOT NULL AND MotherName IS NOT NULL AND
Batch IS NOT NULL AND Degree IS NOT NULL AND PresentStatus IS NOT NULL AND HSDegree IS NOT NULL AND
EntranceExam IS NOT NULL AND Institute IS NOT NULL AND Location IS NOT NULL;

SELECT * FROM college_a_hs_v;

-- Question 7 --
CREATE VIEW college_a_se_v AS SELECT * FROM college_a_se WHERE RollNo IS NOT NULL AND
LastUpdate IS NOT NULL AND Name IS NOT NULL AND FatherName IS NOT NULL AND MotherName IS NOT NULL AND
Batch IS NOT NULL AND Degree IS NOT NULL AND PresentStatus IS NOT NULL AND Organization IS NOT NULL AND
 Location IS NOT NULL;

SELECT * FROM college_a_se_v;

-- Question 8 --
CREATE VIEW college_a_sj_v AS SELECT * FROM college_a_sj WHERE RollNo IS NOT NULL AND
LastUpdate IS NOT NULL AND Name IS NOT NULL AND FatherName IS NOT NULL AND MotherName IS NOT NULL AND
Batch IS NOT NULL AND Degree IS NOT NULL AND PresentStatus IS NOT NULL AND Organization IS NOT NULL AND
Designation  IS NOT NULL AND Location IS NOT NULL;

SELECT * FROM college_a_sj_v;

-- Question 9 --
CREATE VIEW college_b_hs_v AS SELECT * FROM college_b_hs WHERE RollNo IS NOT NULL AND
LastUpdate IS NOT NULL AND Name IS NOT NULL AND FatherName IS NOT NULL AND MotherName IS NOT NULL AND
Branch IS NOT NULL AND Batch IS NOT NULL AND Degree IS NOT NULL AND PresentStatus IS NOT NULL AND 
HSDegree IS NOT NULL AND EntranceExam IS NOT NULL AND Institute IS NOT NULL AND Location IS NOT NULL;

SELECT * FROM college_b_hs_v;

-- Question 10 --
CREATE VIEW college_b_se_v AS SELECT * FROM college_b_se WHERE RollNo IS NOT NULL AND
LastUpdate IS NOT NULL AND Name IS NOT NULL AND FatherName IS NOT NULL AND MotherName IS NOT NULL AND
Branch IS NOT NULL AND Batch IS NOT NULL AND Degree IS NOT NULL AND PresentStatus IS NOT NULL AND 
Organization IS NOT NULL AND Location IS NOT NULL;

SELECT * FROM college_b_se_v;

-- Question 11 --
CREATE VIEW college_b_sj_v AS SELECT * FROM college_b_sj WHERE RollNo IS NOT NULL AND
LastUpdate IS NOT NULL AND Name IS NOT NULL AND FatherName IS NOT NULL AND MotherName IS NOT NULL AND
Branch IS NOT NULL AND Batch IS NOT NULL AND Degree IS NOT NULL AND PresentStatus IS NOT NULL AND 
Organization IS NOT NULL AND  Designation IS NOT NULL AND Location IS NOT NULL;

SELECT * FROM college_b_sj_v;

-- Question 12 --
DELIMITER $$
CREATE PROCEDURE LowerCase ()
BEGIN
SELECT LOWER(Name) Name , LOWER(FatherName) FatherName, LOWER(MotherName) MotherName FROM college_a_hs;
SELECT LOWER(Name) Name, LOWER(FatherName) FatherName, LOWER(MotherName) MotherName FROM college_a_se;
SELECT LOWER(Name) Name, LOWER(FatherName) FatherName, LOWER(MotherName) MotherName FROM college_a_sj;
SELECT LOWER(Name) Name, LOWER(FatherName) FatherName, LOWER(MotherName) MotherName FROM college_b_hs;
SELECT LOWER(Name) Name, LOWER(FatherName) FatherName, LOWER(MotherName) MotherName FROM college_b_se;
SELECT LOWER(Name) Name, LOWER(FatherName) FatherName, LOWER(MotherName) MotherFather FROM college_b_sj;
END $$
DELIMITER ;

CALL LowerCase();

-- Question 14 --
DELIMITER $$
CREATE PROCEDURE get_name_collegeA (
INOUT getnameA TEXT(40000)   )
BEGIN
     DECLARE finished INT DEFAULT 0;
     DECLARE getnamelistA VARCHAR(16000) DEFAULT "" ;
     
     DECLARE getnamedetailA 
            CURSOR FOR
                 SELECT Name from college_a_hs UNION SELECT Name from college_a_se UNION 
				 SELECT Name from college_a_sj;
                 
	 DECLARE CONTINUE HANDLER 
     FOR NOT FOUND SET finished = 1;
     
     OPEN getnamedetailA;
     
     getloop:
     LOOP
		FETCH getnamedetailA INTO getnamelistA;
        IF finished = 1 THEN
            LEAVE getloop;
		END IF;
        SET getnameA = CONCAT(getnamelistA," ; ",getnameA);
		END LOOP getloop;
        CLOSE getnamedetailA;
END $$
DELIMITER ;

SET @getnameA = "";
CALL get_name_collegeA(@getnameA);
SELECT @getnameA NamesA;
-- Question 15 --
DELIMITER $$
CREATE PROCEDURE get_name_collegeB (
INOUT getnameB TEXT(40000)   )
BEGIN
     DECLARE finished INT DEFAULT 0;
     DECLARE getnamelistB VARCHAR(16000) DEFAULT "" ;
     
     DECLARE getnamedetailB 
            CURSOR FOR
                 SELECT Name from college_b_hs UNION SELECT Name from college_b_se UNION 
				 SELECT Name from college_b_sj;
                 
	 DECLARE CONTINUE HANDLER 
     FOR NOT FOUND SET finished = 1;
     
     OPEN getnamedetailB;
     
     getloop:
     LOOP
		FETCH getnamedetailB INTO getnamelistB;
        IF finished = 1 THEN
            LEAVE getloop;
		END IF;
        SET getnameB = CONCAT(getnamelistB," ; ",getnameB);
		END LOOP getloop;
        CLOSE getnamedetailB;
END $$
DELIMITER ;

SET @getnameB = "";
CALL get_name_collegeB(@getnameB);
SELECT @getnameB NamesB;
-- Question 16 --
SELECT ('Higher Studies') 'Career_choice',(SELECT COUNT(*) FROM college_a_hs )/((SELECT COUNT(*)  FROM college_a_hs) + (SELECT COUNT(*)  FROM college_a_se)
+ (SELECT COUNT(*)  FROM college_a_sj))*100 'College_A_Percentage',
(SELECT COUNT(*) FROM college_b_hs )/((SELECT COUNT(*)  FROM college_b_hs) + (SELECT COUNT(*)  FROM college_b_se)
+ (SELECT COUNT(*)  FROM college_b_sj))*100 'College_B_Percentage' UNION 
SELECT 'Self_Employed',(SELECT COUNT(*) FROM college_a_se )/((SELECT COUNT(*)  FROM college_a_hs) + (SELECT COUNT(*)  FROM college_a_se)
+ (SELECT COUNT(*)  FROM college_a_sj))*100 'College_A_Percentage',
(SELECT COUNT(*) FROM college_b_se )/((SELECT COUNT(*)  FROM college_b_hs) + (SELECT COUNT(*)  FROM college_b_se)
+ (SELECT COUNT(*)  FROM college_b_sj))*100 'College_B_Percentage'UNION
SELECT 'Service Jobs',(SELECT COUNT(*) FROM college_a_sj )/((SELECT COUNT(*)  FROM college_a_hs) + (SELECT COUNT(*)  FROM college_a_se)
+ (SELECT COUNT(*)  FROM college_a_sj))*100 'College_A_Percentage',
(SELECT COUNT(*) FROM college_b_sj )/((SELECT COUNT(*)  FROM college_b_hs) + (SELECT COUNT(*)  FROM college_b_se)
+ (SELECT COUNT(*)  FROM college_b_sj))*100 'College_B_Percentage';







