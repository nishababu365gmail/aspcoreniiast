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
-- Table structure for table `m_student`
--

DROP TABLE IF EXISTS `m_student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `m_student` (
  `StudentId` int(11) NOT NULL AUTO_INCREMENT,
  `StuFirstName` varchar(45) DEFAULT NULL,
  `StuLastName` varchar(45) DEFAULT NULL,
  `StuAdharNo` varchar(45) DEFAULT NULL,
  `StuPhoneNo` varchar(45) DEFAULT NULL,
  `IsPlacementRequired` int(11) DEFAULT NULL,
  `StuRegistrationDate` date DEFAULT NULL,
  `IsWorking` tinyint(4) DEFAULT NULL,
  `StuNotes` text,
  `StuEmailId` varchar(45) DEFAULT NULL,
  `IsActive` tinyint(4) DEFAULT NULL,
  `StuPhotoPath` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`StudentId`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_student`
--

LOCK TABLES `m_student` WRITE;
/*!40000 ALTER TABLE `m_student` DISABLE KEYS */;
INSERT INTO `m_student` VALUES (1,'Lalitha','Raghavan','KLOP654','9526998444',1,'2020-03-20',1,'She was working in an infopark company','lalitha123@hotmail.com',1,'Null'),(4,'Ajitha','Sangeeth','TYD0309','9735844409',1,'2020-03-12',1,'house wife','agitha123@hotmail.com',1,'Null'),(6,'Manthra','Vivian','LUY654','8735754409',1,'2020-02-12',1,'Notes for Manthra mythri course test','manthra@gmail.com',1,'Null'),(7,'Kanaka','Prathap','JKDF','8835794009',0,'2020-03-19',1,'jkdf is anew Adhar no','kanaka@yahoo.com',1,'Null'),(11,'Nish','babu','KLOP654','9526672964',1,'2020-03-21',0,'ss','nishababu365@gmail.com',1,'Null'),(12,'Deepu','George','JHSIO0303','6782390120',1,'2020-03-25',0,'tHIS IS TO TEST Fees multiple payment','Deepu@yahoo.com',1,'ab6600d2-55fd-4c2b-b8aa-4cb49160d813_Deepu.jpg'),(13,'Geetha','Chandran','WERFG56','7782590876',0,'2020-03-25',1,'tHIS IS TO TEST Fees multiple payment','Geetha@yahoo.com',1,'Null'),(14,'Thambi','Padmanabhan','hjasop98','99780650001',0,'2020-03-25',0,'Testing fees payment module','thambi@amala.com',1,'Null'),(15,'Madhuri','Dixit','QDFGT3090','9087341090',1,'2020-03-27',0,'Testing before demo','madhuri@yahoo.com',NULL,'Null');
/*!40000 ALTER TABLE `m_student` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-03-31 18:34:51
