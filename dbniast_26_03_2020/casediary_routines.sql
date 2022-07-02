-- MySQL dump 10.13  Distrib 8.0.17, for Win64 (x86_64)
--
-- Host: localhost    Database: casediary
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
-- Dumping events for database 'casediary'
--

--
-- Dumping routines for database 'casediary'
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetAllOrSingleCase` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetAllOrSingleCase`(argCaseNo varchar(45),argPartyId int,argCaseId int)
BEGIN
if argCaseId=-1 then

  SELECT m_party.PartyFirstName as PartyFirstName,m_advocate.NameOfAdvocate as NameOfAdvocate,
  m_court.CourtName as CourtName,
  m_caseregistration.CaseId as CaseId
  
  FROM m_caseregistration 
  left outer join m_party
  on m_party.PartyId=m_caseregistration.PartyId
  left outer join m_advocate 
  on m_advocate.Id=m_caseregistration.PartyAdvocate
  left outer join m_court
  on m_court.CourtId=m_caseregistration.CourtName
  left outer join m_subcourt
  on m_subcourt.SubCourtId=m_caseregistration.SubCourtName
  left outer join m_casenature
  on m_casenature.CaseNatureId=m_caseregistration.CaseNature
  left outer join m_subcasenature 
  on m_subcasenature.CaseSubNatureId=m_caseregistration.SubCaseNature
  left outer join m_courtplace
  on m_courtplace.Id=m_caseregistration.CourtPlace
  WHERE (argCaseNo is null or CaseNo LIKE argCaseNo)
  AND (argPartyId = 0 or m_caseregistration.PartyId = argPartyId);
  else
  select CaseId ,PartyId,
  PartyAdvocate,CourtName,CaseNature,
  CourtPlace,OppositePartyAdvocate,
  CaseRegistrationDate,IsClosed,
  ClosedDate,CaseNo,SubCourtName,
  SubCaseNature,OpponentName,
  (select t1.CaseSection  from (SELECT t2.caseid ,
group_concat(CaseSection) as 'CaseSection' 
FROM casediary.t_casesections as t2
where caseid=m_caseregistration.CaseId
group by caseid) as t1) as CaseSections
  from m_caseregistration
  where m_caseregistration.CaseId=argCaseid;
  end  if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetAllOrSingleCaseProceedings` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetAllOrSingleCaseProceedings`(argCaseNo varchar(50),argProceedingDate date,argPartyFirstName varchar(50))
BEGIN
select * from t_caseproceedings
WHERE ( CaseNo LIKE argCaseNo);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetAllOrSingleCaseProceedingsMaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetAllOrSingleCaseProceedingsMaster`(argCaseNo varchar(50),argProceedingDate date,argPartyFirstName varchar(50))
BEGIN
 SELECT m_party.PartyFirstName as PartyFirstName,
 OpponentName,
 OppositePartyAdvocate,
 m_advocate.NameOfAdvocate as NameOfAdvocate,
 m_court.CourtName as CourtName,
 m_caseregistration.CaseRegistrationDate as CaseRegistrationDate

  
  FROM m_caseregistration 
  left outer join m_party
  on m_party.PartyId=m_caseregistration.PartyId
  left outer join m_advocate 
  on m_advocate.Id=m_caseregistration.PartyAdvocate
  left outer join m_court
  on m_court.CourtId=m_caseregistration.CourtName
  left outer join m_subcourt
  on m_subcourt.SubCourtId=m_caseregistration.SubCourtName
  left outer join m_casenature
  on m_casenature.CaseNatureId=m_caseregistration.CaseNature
  left outer join m_subcasenature 
  on m_subcasenature.CaseSubNatureId=m_caseregistration.SubCaseNature
  left outer join m_courtplace
  on m_courtplace.Id=m_caseregistration.CourtPlace  
  WHERE (argCaseNo is null or CaseNo LIKE argCaseNo)
  #AND (argProceedingDate is null or m_caseregistration.ProceedingDate = argProceedingDate)
  AND (argPartyFirstName is null or PartyFirstName LIKE argPartyFirstName);
  
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetAllOrSingleParty` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetAllOrSingleParty`(argPartyId int,argPartyFirstName varchar(50),argPartyLastName varchar(50),argPartyHouseName varchar(50),argPartyPhoneNo varchar(15))
BEGIN
	SELECT * FROM M_PARTY  
    WHERE (argPartyFirstName is null or PartyFirstName LIKE argPartyFirstName) 
    AND (argPartyLastName is null or PartyLastName LIKE argPartyLastName )
	AND (argPartyHouseName is null or PartyHouseName LIKE argPartyHouseName)
    AND (argPartyId = 0 or PartyId = argPartyId)
	AND (argPartyPhoneNo is null or PartyPhoneNo like argPartyPhoneNo);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_getAllOrSingleStates` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getAllOrSingleStates`(argid int )
BEGIN
  if (argid=null) then
	select * from states;   
  else
   select * from states where id=argid;
  end if;
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
/*!50003 DROP PROCEDURE IF EXISTS `sp_savecaseopponent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_savecaseopponent`(argCaseNo varchar(45),
argOpponentName varchar(45))
BEGIN
set @opponentcount=0;
select @opponentcount=count(CaseNo) from m_case_opponent
where CaseNo=argCaseNo
and OpponentName=argOpponentName;
if(@opponentcount=0) then
INSERT INTO `casediary`.`m_case_opponent`
(
`CaseNo`,
`OpponentName`)
VALUES
(
argCaseNo,
argOpponentName);
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_savecaseparty` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_savecaseparty`(argCaseNo varchar(45),
argPartyId int)
BEGIN
set @partycount:=0;
select @partycount=count(PartyId) from m_case_party
where CaseNo=argCaseNo
and PartyId=argPartyId;
if(@partycount=0) then
INSERT INTO `casediary`.`m_case_party`
(
`CaseNo`,
`PartyId`)
VALUES
(
argCaseNo,
argPartyId);
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_savecaseregistration` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_savecaseregistration`(argCaseId int,argPartyId varchar(45),
argPartyAdvocate int,
argCourtName int,
argCaseNature int,
argCourtPlace int,
argOppositePartyAdvocate varchar(50),
argCaseRegistrationDate date,
argIsClosed bool,
argClosedDate date,
argCaseNo varchar(100),
argSubCourtName int,
argSubCaseNature int,
argOpponentName text,
argCaseSections varchar(250))
BEGIN
set @casecount=0;
select @casecount:=Count(CaseId) from m_caseregistration
where CaseId=argCaseId;
if(@casecount=0) then
INSERT INTO `casediary`.`m_caseregistration`
(

`PartyAdvocate`,
`CourtName`,
`CaseNature`,
`CourtPlace`,
`OppositePartyAdvocate`,
`CaseRegistrationDate`,
`IsClosed`,
`ClosedDate`,
`CaseNo`,
`SubCourtName`,
`SubCaseNature`
)
VALUES
(

argPartyAdvocate,
argCourtName,
argCaseNature,
argCourtPlace,
argOppositePartyAdvocate,
argCaseRegistrationDate,
argIsClosed,
argClosedDate,
argCaseNo,
argSubCourtName,
argSubCaseNature
);
set @insertedargCaseId:= last_insert_id();
call sp_savecasesections (@insertedargCaseId,argCaseSections);
call sp_savecommaseparatedparty(@insertedargCaseId,argPartyId);
call sp_savecommaseparatedopponent(@insertedargCaseId,argOpponentName);
else
update m_caseregistration
set CaseNo=argCaseNo,
PartyAdvocate=argPartyAdvocate,
CourtName=argCourtName,
CaseNature=argCaseNature,
CourtPlace=argCourtPlace,
OppositePartyAdvocate=argOppositePartyAdvocate,
CaseRegistrationDate=argCaseRegistrationDate,
IsClosed=argIsClosed,
ClosedDate=argClosedDate,
CaseNo=argCaseNo,
SubCourtName=argSubCourtName,
SubCaseNature=argSubCaseNature
where caseid=argCaseId;
call sp_savecasesections (argCaseId,argCaseSections);
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_savecasesections` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_savecasesections`(argCaseId int,argCaseSections varchar(250))
BEGIN
DECLARE counter INT DEFAULT 1;
declare newargCaseSections varchar(250);
declare originalCaseSections  varchar(50);
set @originalCaseSections=argCaseSections;
WHILE counter = 1 DO
set @singlesection:=fn_splitcasesections(argCaseSections);
        if @singlesection is not null then
			insert into t_casesections(CaseId,CaseSection)
			values(argCaseId,@singlesection);
            select @singlesection;
            set @newargCaseSections:=replace(argCaseSections,concat(@singlesection ,','),'');
            select @newargCaseSections;
            # ,illengil
            set argCaseSections=@newargCaseSections;
            select argCaseSections;
            set counter=1;
		else 
             set @singlesection= reverse(substring_index( reverse(@originalCaseSections),',',1));
             insert into t_casesections(CaseId,CaseSection)
			values(argCaseId,@singlesection);
             set counter=0;
        end if;
    END WHILE;  
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_savecommaseparatedopponent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_savecommaseparatedopponent`(argCaseId int,argCaseOpponent text)
BEGIN
DECLARE counter INT DEFAULT 1;
declare newargCaseSections varchar(250);
declare originalCaseSections  varchar(250);
set @originalCaseSections=argCaseOpponent;
WHILE counter = 1 DO
set @singlesection:=fn_splitcasesections(argCaseOpponent);
        if @singlesection is not null then
            call sp_savecaseopponent(argCaseId,@singlesection);			
            select @singlesection;
            set @newargCaseSections:=replace(argCaseOpponent,concat(@singlesection ,','),'');
            select @newargCaseSections;
            # ,illengil
            set argCaseOpponent=@newargCaseSections;
            select argCaseOpponent;
            set counter=1;
		else 
             set @singlesection= reverse(substring_index( reverse(@originalCaseSections),',',1));
             call sp_savecaseopponent(argCaseId,@singlesection);
             set counter=0;
        end if;
    END WHILE;  
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_savecommaseparatedparty` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_savecommaseparatedparty`(argCaseId int,argCaseParty varchar(250))
BEGIN
DECLARE counter INT DEFAULT 1;
declare newargCaseSections varchar(250);
declare originalCaseSections  varchar(250);
set @originalCaseSections=argCaseParty;
WHILE counter = 1 DO
set @singlesection:=fn_splitcasesections(argCaseParty);
        if @singlesection is not null then
            call sp_savecaseparty(argCaseId,@singlesection);			
            select @singlesection;
            set @newargCaseSections:=replace(argCaseParty,concat(@singlesection ,','),'');
            select @newargCaseSections;
            # ,illengil
            set argCaseParty=@newargCaseSections;
            select argCaseParty;
            set counter=1;
		else 
             set @singlesection= reverse(substring_index( reverse(@originalCaseSections),',',1));
             call sp_savecaseparty(argCaseId,@singlesection);
             set counter=0;
        end if;
    END WHILE;  
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_saveparty` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_saveparty`(argPartyId int,argPartyFirstName varchar(50),argPartyLastName varchar(50),argPartyHouseName varchar(50),argPartyStreetName varchar(50),
argPartyDistrict int,argPartyState int,argPartyPincode varchar(50),
argPartyAdharNo varchar(15),argPartyPhoneNo varchar(15),
argPartyEmailId varchar(50))
BEGIN
select @partycount:=Count(PartyId) from m_party
where PartyId=argPartyId;
if (@partycount=0) then
  INSERT INTO `casediary`.`m_party`
(
`PartyFirstName`,
`PartyLastName`,
`PartyHouseName`,
`PartyStreetName`,
`PartyDistrict`,
`PartyState`,
`PartyPincode`,
`PartyAdharNo`,
`PartyPhoneNo`,
`PartyEmailId`)
VALUES
(
argPartyFirstName,
argPartyLastName,
argPartyHouseName,
argPartyStreetName,
argPartyDistrict,
argPartyState,
argPartyPincode,
argPartyAdharNo,
argPartyPhoneNo,
argPartyEmailId
);
else
update m_party set
PartyFirstName=argPartyFirstName,
PartyLastName=argPartyLastName,
PartyHouseName=argPartyHouseName,
PartyStreetName=argPartyStreetName,
PartyDistrict=argPartyDistrict,
PartyState=argPartyState,
PartyPincode=argPartyPincode,
PartyAdharNo=argPartyAdharNo,
PartyPhoneNo=argPartyPhoneNo,
PartyEmailId=argPartyEmailId
where partyId=argPartyId;
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_saveproceedings` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_saveproceedings`(argProceedingsID int,
 argCaseNo varchar(50),
 argProceedings varchar(250),
 argProceedingDate date,argNextProceedingDate date)
BEGIN
select @proceedingcount:=Count(ProceedingsID) from t_caseproceedings
where ProceedingsID=argProceedingsID;
if (@proceedingcount=0) then
insert into t_caseproceedings(CaseNo,Proceedings,ProceedingDate,NextProceedingDate)
values(argCaseNo,argProceedings,argProceedingDate,argNextProceedingDate);
else
update t_caseproceedings
set 
Proceedings=argProceedings,
ProceedingDate=argProceedingDate,
NextProceedingDate=argNextProceedingDate
where ProceedingID=argProceedingsID;
end if;

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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-03-26 15:07:12
