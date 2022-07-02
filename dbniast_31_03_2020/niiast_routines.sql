-- MySQL dump 10.13  Distrib 8.0.17, for Win64 (x86_64)
--
-- Host: localhost    Database: niiast
-- ------------------------------------------------------
-- Server version	8.0.17

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping events for database 'niiast'
--

--
-- Dumping routines for database 'niiast'
--
/*!50003 DROP FUNCTION IF EXISTS `fn_splitcasesections` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_splitcasesections`(argCaseSections varchar(250)) RETURNS varchar(50) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
set @pos:=instr(argCaseSections,  ',');
if @pos>0 then
set @returnstring:=substring_index(argCaseSections,',',1);
else
set  @returnstring=null;
end if;
RETURN @returnstring;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `check_table_exists` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `check_table_exists`(table_name VARCHAR(100))
BEGIN
    DECLARE CONTINUE HANDLER FOR SQLSTATE '42S02' SET @err = 1;
    SET @err = 0;
    SET @table_name = table_name;
    SET @sql_query = CONCAT('SELECT 1 FROM ',@table_name);
    PREPARE stmt1 FROM @sql_query;
    IF (@err = 1) THEN
        SET @table_exists = 0;
    ELSE
        SET @table_exists = 1;
        DEALLOCATE PREPARE stmt1;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetAllCoursesForEntities` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetAllCoursesForEntities`(argRelationName varchar(50),argStudentId int)
BEGIN
if argRelationName='student_course' then
  select c.CourseId, c.CourseName from m_student_course mc
  inner join m_course c
  on c.CourseId=mc.StuCourseId
  inner join m_student s
  on s.StudentId=mc.stuId
  where mc.IsDeleted=0
  and mc.StuId=argStudentId;
 end if;  
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetAllOrSingleFeesPaymentDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetAllOrSingleFeesPaymentDetails`(argMasterFeesPaymentId int, argFeesPaymentId int,
argStudentId int,argCourseId int)
BEGIN

  select MasterFeesPaymentId,FeesPaymentId, s.StuFirstName,s.StudentId,mc.CourseId,
  mc.CourseName , tf.Fees,
  tf.FeesPaidDate from t_feespayment tf
  inner join m_student s
  on s.StudentId=tf.StudentId 
  inner join  m_course mc on 
   tf.CourseId=mc.CourseId   
  where (argStudentId is null or s.StudentId=argStudentId)
  and (argCourseId is null or tf.CourseId=argCourseId)
  and (argMasterFeesPaymentId is null or tf.MasterFeesPaymentId=argMasterFeesPaymentId)
  and (argFeesPaymentId is null or tf.FeesPaymentId=argFeesPaymentId);
 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetAllOrSingleFeesPaymentMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetAllOrSingleFeesPaymentMaster`(argFeesPaymentMasterId int,argStudentId int,argCourseId int)
BEGIN
SELECT 
FeesPaymentMasterId ,
mf.StudentId ,
mf.CourseId ,
mf.FeesPaid ,
mf.FeesDueAmount,
s.StuFirstName,
mc.CourseName
FROM m_feespayment mf
INNER JOIN m_student s
ON s.StudentId=mf.StudentId
INNER JOIN m_course mc
ON mc.CourseId=mf.CourseId
INNER JOIN m_student_course msc
ON msc.StuCourseId=mf.courseId
AND msc.StuId=mf.StudentId
AND s.StudentId=msc.StuId
WHERE (argFeesPaymentMasterId IS NULL OR FeesPaymentMasterId=argFeesPaymentMasterId)
AND (argStudentId IS NULL OR mf.StudentId=argStudentId)
AND (argCourseId IS NULL OR mf.CourseId=argCourseId)
and msc.IsDeleted=0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetAllOrSingleStudent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetAllOrSingleStudent`(argStudentId int,
argStuRegistrationDate datetime,
argStuPhoneNo varchar(15),
argStuFirstName varchar(15),
argStuCourse int)
BEGIN
if argStudentId>0 then
select StudentId,StuFirstName,StuLastName,StuAdharNo,StuPhoneNo,IsPlacementRequired,StuRegistrationDate,
IsWorking,StuNotes,StuEmailId,
(select t1.Studen  from (SELECT t2.StuId ,
group_concat(StuCourseId) as 'Studen' 
FROM niiast.m_student_course as t2
where m_student.StudentId=argStudentId
and t2.IsDeleted=0
group by t2.StuId) as t1) as StuCourse,
(select t1.Studegree  from (SELECT t2.StuId ,
group_concat(StuDegreeId) as 'Studegree' 
FROM niiast.m_student_degree as t2
where StudentId=m_student.StudentId
and t2.IsDeleted=0
group by StudentId) as t1) as StuDegree
from m_student
where StudentId=argStudentId;
else
select distinct m_student.StudentId, m_student.StuFirstName,m_student.StuEmailId,
m_student.StuPhoneNo,m_student.StuRegistrationDate,
m_student.StuAdharNo,m_student.IsPlacementRequired,m_student.IsWorking from m_student
left outer join m_student_course on
 m_student.studentid=m_student_course.StuId
 left outer join m_course on 
 m_student_course.StuCourseId=m_course.CourseId
 WHERE (argStuPhoneNo is null or StuPhoneNo LIKE argStuPhoneNo)
 # AND (argStudentId = 0 or StudentId = argStudentId)
 and (argStuFirstName is null or StuFirstName LIKE  concat('%' , argStuFirstName ,'%'))
 and (argStuCourse is null or m_student_course.StuCourseId = argStuCourse)
AND (argStuRegistrationDate is null or StuRegistrationDate = argStuRegistrationDate)
and m_student_course.IsDeleted=0;
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetAllOrSingleStudent1` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetAllOrSingleStudent1`(argStudentId int,
argStuRegistrationDate datetime,
argStuPhoneNo varchar(15),
argStuFirstName varchar(15),
argStuCourse int)
BEGIN
CALL check_table_exists('m_student_temp');
IF @table_exists=1 then
DROP TEMPORARY TABLE m_student_temp;
END IF;
CREATE TEMPORARY TABLE `m_student_temp` (
  `StudentId` int ,
  `StuFirstName` varchar(45) ,
  `StuLastName` varchar(45) ,
  `StuAdharNo` varchar(45) ,
  `StuPhoneNo` varchar(45) ,
  `IsPlacementRequired` int(11) ,
  `StuRegistrationDate` date,
  `IsWorking` tinyint(4) ,
  `StuNotes` text,
  `StuEmailId` varchar(45) ,
  `IsActive` tinyint(4),
  `StuCourse` varchar(25),
  `StuDegree` varchar(25),
  `StuPhotoPath` varchar(500),
  PRIMARY KEY (`StudentId`)
) ;

IF argStudentId>0 THEN
INSERT INTO m_student_temp(StudentId,StuFirstName,StuLastName,StuAdharNo,StuPhoneNo,IsPlacementRequired,StuRegistrationDate,
IsWorking,StuNotes,StuEmailId,StuPhotoPath)
SELECT StudentId,StuFirstName,StuLastName,StuAdharNo,StuPhoneNo,IsPlacementRequired,StuRegistrationDate,
IsWorking,StuNotes,StuEmailId,StuPhotoPath
FROM m_student
WHERE StudentId=argStudentId; 
SET @courseid:=(Select group_concat(StuCourseId)
FROM  m_student_course
WHERE StuId=argStudentId
and IsDeleted=0 GROUP BY(StuId));
UPDATE m_student_temp SET StuCourse=@courseid
WHERE m_student_temp.StudentId=argStudentId;
 SET @degreeid:=(SELECT group_concat(StuDegreeId)
FROM  m_student_degree
WHERE StuId=argStudentId
and IsDeleted=0 GROUP BY(StuId));
UPDATE m_student_temp SET StuDegree=@degreeid
WHERE m_student_temp.StudentId=argStudentId;
SELECT * FROM m_student_temp;
ELSE
SELECT DISTINCT m_student.StudentId, m_student.StuFirstName,m_student.StuEmailId,
m_student.StuPhoneNo,m_student.StuRegistrationDate,
m_student.StuAdharNo,m_student.IsPlacementRequired,m_student.IsWorking ,m_student.StuPhotoPath FROM m_student
LEFT OUTER JOIN m_student_course ON
 m_student.studentid=m_student_course.StuId
 LEFT OUTER JOIN m_course ON 
 m_student_course.StuCourseId=m_course.CourseId
 WHERE (argStuPhoneNo IS NULL OR StuPhoneNo LIKE argStuPhoneNo) 
 AND (argStuFirstName IS NULL OR StuFirstName LIKE  concat('%' , argStuFirstName ,'%'))
 and (argStuCourse is null or m_student_course.StuCourseId = argStuCourse)
AND (argStuRegistrationDate is null or StuRegistrationDate = argStuRegistrationDate);
#and m_student_course.IsDeleted=0;

END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetColumnNames` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetColumnNames`(argTableName varchar(50))
BEGIN
SELECT column_name
FROM information_schema.columns
WHERE table_name= argTableName; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetFeesDetailsForCardDeckStudent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetFeesDetailsForCardDeckStudent`(argRelationName varchar(50),argStudentId int)
BEGIN
if argRelationName='fees_payment_for_deck' then
 select argStudentId, @totalfeespaid:=Sum(FeesPaid),@totalfees:=Sum(FeesDueAmount),
 @totalfeesdue:=@totalfees-@totalfeespaid
 group by argStudentId;
 end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetFeesStudentCourseWise` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetFeesStudentCourseWise`(argStudentId int,argCourseId int)
BEGIN
CALL check_table_exists('m_fees_student_course_wise_temp');
IF @table_exists=1 then
DROP TEMPORARY TABLE m_fees_student_course_wise_temp;
END IF;
CREATE TEMPORARY TABLE `m_fees_student_course_wise_temp` (
  `StudentId` int ,
  `FeesPaid` decimal(10,2),
  `Fees` decimal(10,2),
  `CourseId` int ,  
  `FeesDueAmount` decimal(10,2),
  PRIMARY KEY (`StudentId`)
) ;
set @FeesPaid:=0.0;
set @Fees:=0.0;
set @FeesDueAmount:=0;
set @FeesPaid:=(select (FeesPaid) from
m_feespayment where StudentId=argStudentId
and CourseId=argCourseId);
set @Fees:=(select CourseFees as Fees from m_course
where CourseId=argCourseId);
set @FeesDueAmount=(select FeesDueAmount from m_feespayment where
StudentId=argStudentId and CourseId=argCourseId);
#select @FeesDueAmount;
if @FeesDueAmount is null then
  set @FeesDueAmount:=@Fees;
 end if; 
insert into m_fees_student_course_wise_temp(StudentId,CourseId,FeesPaid,Fees,FeesDueAmount)
values(argStudentId,argCourseId,0.0,0.0,0.0);
update m_fees_student_course_wise_temp
set StudentId=argStudentId,
CourseId=argCourseId,
FeesPaid=@FeesPaid,
#Fees=@Fees,
FeesDueAmount=@FeesDueAmount
where StudentId=argStudentId
and CourseId=argCourseId;
select * from m_fees_student_course_wise_temp;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_getlookupvalues` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getlookupvalues`(argmaincolumnname varchar(50),argmaincolumnvalue int,argtablename varchar(100))
BEGIN

if argmaincolumnname <>'' then
	SET @main:=argmaincolumnname;
    SET @mainval:=argmaincolumnvalue;
	#SET @where := CONCAT('where ', @main ,'=',@argmaincolumnvalue);
    SET @where := CONCAT('  where ', @main , '=',@mainval,';');
     #select @where;
     SET @table := argtablename;
SET @sql := CONCAT('SELECT * FROM ', @table,  @where,  ';');
   else
   SET @table := argtablename;
	SET @sql := CONCAT('SELECT * FROM ', @table, ';');
  end if ;
 
#SET @table := argtablename;
#SET @sql := CONCAT('SELECT * FROM ', @table,  @where,  ';');
#select @sql;
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_savecommaseparatedstudentcourse` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_savecommaseparatedstudentcourse`(argStudentId int,argStudentCourse varchar(250))
BEGIN
DECLARE counter INT DEFAULT 1;
declare newargCaseSections varchar(250);
declare originalCaseSections  varchar(250);
set @originalCaseSections=argStudentCourse;
WHILE counter = 1 DO
set @singlesection:=fn_splitcasesections(argStudentCourse);
        if @singlesection is not null then
            call sp_savestudentcourse(argStudentId,@singlesection);			
            select @singlesection;
            set @newargCaseSections:=replace(argStudentCourse,concat(@singlesection ,','),'');
            select @newargCaseSections;
            # ,illengil
            set argStudentCourse=@newargCaseSections;
            select argStudentCourse;
            set counter=1;
		else 
             set @singlesection= reverse(substring_index( reverse(@originalCaseSections),',',1));
             call sp_savestudentcourse(argStudentId,@singlesection);
             set counter=0;
        end if;
    END WHILE;  
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_savecommaseparatedstudentdegree` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_savecommaseparatedstudentdegree`(argStudentId int,argStudentDegree varchar(250))
BEGIN
DECLARE counter INT DEFAULT 1;
declare newargCaseSections varchar(250);
declare originalCaseSections  varchar(250);
set @originalCaseSections=argStudentDegree;
WHILE counter = 1 DO
set @singlesection:=fn_splitcasesections(argStudentDegree);
        if @singlesection is not null then
            call sp_savestudentdegree(argStudentId,@singlesection);			
            select @singlesection;
            set @newargCaseSections:=replace(argStudentDegree,concat(@singlesection ,','),'');
            select @newargCaseSections;
            # ,illengil
            set argStudentDegree=@newargCaseSections;
            select argStudentDegree;
            set counter=1;
		else 
             set @singlesection= reverse(substring_index( reverse(@originalCaseSections),',',1));
             call sp_savestudentdegree(argStudentId,@singlesection);
             set counter=0;
        end if;
    END WHILE;  
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_savestudent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_savestudent`(argStudentId int,argStuFirstName varchar(45),
argStuLastName varchar(45),
argStuAdharNo varchar(45),
argStuPhoneNo varchar(45),
argStuCourse varchar(45),
argStuDegree varchar(45),
argIsPlacementRequired bool,
argStuRegistrationDate date,
argIsWorking bool,
argStuNotes varchar(45),
argStuEmailId varchar(45),
argStuPhotoPath varchar(500))
BEGIN
#DECLARE EXIT HANDLER FOR SQLEXCEPTION
    #BEGIN
        #ROLLBACK;  -- rollback any error in the transaction
   # END;
 # START TRANSACTION;   
 set @studentcount:=0;
select @studentcount:=Count(StudentId) from m_student
where StudentId=argStudentId;
if @studentcount=0 then
INSERT INTO `niiast`.`m_student`
(
`StuFirstName`,
`StuLastName`,
`StuAdharNo`,
`StuPhoneNo`,
`IsPlacementRequired`,
`StuRegistrationDate`,
`IsWorking`,
`StuNotes`,
`StuEmailId`,
`StuPhotoPath`)
VALUES
(
argStuFirstName,
argStuLastName,
argStuAdharNo,
argStuPhoneNo,
argIsPlacementRequired,
argStuRegistrationDate,
argIsWorking,
argStuNotes,
argStuEmailId,
argStuPhotoPath);
set @insertedargStudentId:= last_insert_id();
IF LENGTH(argStuCourse)>0 THEN
call sp_savecommaseparatedstudentcourse (@insertedargStudentId,argStuCourse);
END IF;
IF length(argStuDegree) >0  THEN
call sp_savecommaseparatedstudentdegree(@insertedargStudentId,argStuDegree);
end if;
else
update m_student
set StuFirstName=argStuFirstName,
StuLastName=argStuLastName,
StuAdharNo=argStuAdharNo,
StuPhoneNo=argStuPhoneNo,
IsPlacementRequired=argIsPlacementRequired,
StuRegistrationDate=argStuRegistrationDate,
IsWorking=argIsWorking,
StuNotes=argStuNotes,
StuEmailId=argStuEmailId,
StuPhotoPath=argStuPhotoPath
where StudentId=argStudentId;
set @insertedargStudentId:=argStudentId;
IF LENGTH(argStuCourse)>0 THEN
update m_student_course
set IsDeleted=1
where StuId=argStudentId;
call sp_savecommaseparatedstudentcourse (@insertedargStudentId,argStuCourse);
END IF;
IF length(argStuDegree) >0  THEN
update m_student_degree
set IsDeleted=1
where StuId=argStudentId;
call sp_savecommaseparatedstudentdegree(@insertedargStudentId,argStuDegree);
end if;
end if;
#COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_savestudentcourse` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_savestudentcourse`(argStuId varchar(45),
argStuCourseId int)
BEGIN

INSERT INTO `niiast`.`m_student_course`
(
`StuId`,
`StuCourseId`)
VALUES
(
argStuId,
argStuCourseId);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_savestudentdegree` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_savestudentdegree`(argStuId varchar(45),
argStuDegreeId int)
BEGIN

INSERT INTO `niiast`.`m_student_degree`
(
`StuId`,
`StuDegreeId`)
VALUES
(
argStuId,
argStuDegreeId);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_save_feespayment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_save_feespayment`(argFeesPaymentId int,argMasterFeesPaymentId int,
argCourseId int,
argFees decimal(10,3),
argFeesPaidDate date,
argStudentId int

)
BEGIN
set @feespaymentcount:=0;
set @feespaymentcount:=(select count(FeesPaymentId) 
from t_feespayment
where FeesPaymentId=argFeesPaymentId);
if @feespaymentcount=0 then
INSERT INTO `niiast`.`t_feespayment`
(
`StudentId`,
`CourseId`,
`FeesPaidDate`,
`Fees`,
`MasterFeesPaymentId`)
VALUES
(
argStudentId,
argCourseId,
argFeesPaidDate,
argFees,
argMasterFeesPaymentId);
else
update t_feespayment
set #StudentId=argStudentId,
 #CourseId=argCourseId,
 #FeesPaidDate=argFeesPaidDate,
 Fees=argFees where
 FeesPaymentId=argFeesPaymentId;

end if;
set @totalfeespaidcoursewise:=0;
set @totalfeespaidcoursewise:=(select sum(Fees)
from t_feespayment
where StudentId=argStudentId
and CourseId=argCourseId
group by StudentId,CourseId);
update m_feespayment
set FeesPaid=@totalfeespaidcoursewise
where FeesPaymentMasterId=argMasterFeesPaymentId;
select argMasterFeesPaymentId;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_save_masterfeespayment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_save_masterfeespayment`(
argStudentId int,
argCourseId int,
argFeesPaid decimal,
argFeesDueAmount decimal, 
argFeesPaymentId int,
argFees decimal(10,3),
argFeesPaidDate date

)
BEGIN
set @masterrecordcount=0;
set @FeesDueAmount=0;
select @masterrecordcount:=count(FeesPaymentMasterId) from 
m_feespayment
where StudentId=argStudentId
and CourseId=argCourseId;
if @masterrecordcount=0 then
select @FeesDueAmount:= coursefees from
m_course mc
inner join m_student_course msc
on mc.CourseId = msc.StuCourseId
inner join m_student s
on s.StudentId=msc.StuId
where s.StudentId=argStudentId
and msc.StuCourseId=argCourseId;
INSERT INTO `niiast`.`m_feespayment`
(
`StudentId`,
`CourseId`,
#`FeesPaid`,
`FeesDueAmount`)
VALUES
(
argStudentId,
argCourseId,
#argFeesPaid,
@FeesDueAmount);
set @masterid:=last_insert_id();
else
set @masterid :=(select FeesPaymentMasterId from m_feespayment
where StudentId=argStudentId
and CourseId=argCourseId);
#update m_feespayment
#set feesPaid=feesPaid+argFeesPaid
#where FeesPaymentMasterId=@masterid;
#where StudentId=argStudentId
#and CourseID=argCourseId;
end if;
call sp_save_feespayment(argFeesPaymentId,@masterid,argCourseId,argFees,argFeesPaidDate,argStudentId);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_spparamnamelist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_spparamnamelist`(dbname varchar(100),spname varchar(100))
BEGIN
  SELECT parameter_name as parametername,data_type as datatype
FROM information_schema.parameters 
WHERE SPECIFIC_NAME = spname;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `veruthecheckcheyan` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `veruthecheckcheyan`(argCourseId varchar(10))
BEGIN
set argCourseId:='2,1,3';
  select * from m_student_course
  where StuCourseId in (argCourseId);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-03-31 18:34:55
