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
-- Table structure for table `m_subcourt`
--

DROP TABLE IF EXISTS `m_subcourt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `m_subcourt` (
  `SubCourtId` int(11) NOT NULL AUTO_INCREMENT,
  `MainCourtId` int(11) DEFAULT NULL,
  `SubCourtName` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`SubCourtId`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_subcourt`
--

LOCK TABLES `m_subcourt` WRITE;
/*!40000 ALTER TABLE `m_subcourt` DISABLE KEYS */;
INSERT INTO `m_subcourt` VALUES (1,2,'Principal Muncif Court'),(2,2,'1 st additional muncif court'),(3,2,'2 nd additional muncif court'),(4,2,'3 rd additional muncif court'),(5,3,'Principal sub court'),(6,3,'1 st additional Sub court'),(7,3,'2 nd additional subcourt'),(8,3,'3 rd additional subcourt'),(9,4,'Principal District & Session court'),(10,4,'1st  additional District & Session court'),(11,4,'2nd additional District & Session court'),(12,4,'3 rd additional District & Session court'),(13,4,'4 th additional District & Session court'),(14,8,'Number 1 Judicial magistrate'),(15,8,'Number 2 Judicial magistrate'),(16,8,'Number 3 Judicial magistrate');
/*!40000 ALTER TABLE `m_subcourt` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-03-26 15:07:08
