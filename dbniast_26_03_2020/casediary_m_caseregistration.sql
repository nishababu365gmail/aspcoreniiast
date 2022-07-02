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
-- Table structure for table `m_caseregistration`
--

DROP TABLE IF EXISTS `m_caseregistration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `m_caseregistration` (
  `CaseId` int(11) NOT NULL AUTO_INCREMENT,
  `PartyId` int(11) DEFAULT NULL,
  `PartyAdvocate` int(11) DEFAULT NULL,
  `CourtName` int(11) DEFAULT NULL,
  `CaseNature` int(11) DEFAULT NULL,
  `CourtPlace` int(11) DEFAULT NULL,
  `OppositePartyAdvocate` varchar(50) DEFAULT NULL,
  `CaseRegistrationDate` date DEFAULT NULL,
  `IsClosed` tinyint(4) DEFAULT NULL,
  `ClosedDate` date DEFAULT NULL,
  `CaseNo` varchar(45) DEFAULT NULL,
  `SubCourtName` int(11) DEFAULT NULL,
  `SubCaseNature` int(11) DEFAULT NULL,
  `OpponentName` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`CaseId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_caseregistration`
--

LOCK TABLES `m_caseregistration` WRITE;
/*!40000 ALTER TABLE `m_caseregistration` DISABLE KEYS */;
INSERT INTO `m_caseregistration` VALUES (1,5,2,2,2,3,'Balgopal','2020-03-05',0,'0001-01-01','05032020cr',1,4,'James'),(2,3,1,9,1,3,'Annoottan','2020-03-05',0,'0001-01-01','nmio-89',0,1,'Siva'),(3,3,3,1,2,3,'Rajeevan','2020-03-05',0,'0001-01-01','klou 90',0,4,'Manoj');
/*!40000 ALTER TABLE `m_caseregistration` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-03-26 15:07:10
