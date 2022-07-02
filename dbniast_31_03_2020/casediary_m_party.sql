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
-- Table structure for table `m_party`
--

DROP TABLE IF EXISTS `m_party`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `m_party` (
  `PartyId` int(11) NOT NULL AUTO_INCREMENT,
  `PartyFirstName` varchar(45) DEFAULT NULL,
  `PartyLastName` varchar(45) DEFAULT NULL,
  `PartyHouseName` varchar(45) DEFAULT NULL,
  `PartyStreetName` varchar(45) DEFAULT NULL,
  `PartyDistrict` smallint(6) DEFAULT NULL,
  `PartyState` smallint(6) DEFAULT NULL,
  `PartyPincode` varchar(15) DEFAULT NULL,
  `PartyAdharNo` varchar(15) DEFAULT NULL,
  `PartyPhoneNo` varchar(15) DEFAULT NULL,
  `PartyEmailId` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`PartyId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_party`
--

LOCK TABLES `m_party` WRITE;
/*!40000 ALTER TABLE `m_party` DISABLE KEYS */;
INSERT INTO `m_party` VALUES (1,'Joseph','Mini','kochi parambath','Gandhiji road',4,6,'2300989','asd2300989','9080345698','maaani@wert.com'),(2,'Ajith','Pavithran','Valiya parambil house','Gandhiji road',0,0,'683108','mmm9765','9497250882','nishababu2000@yahoo.com'),(3,'Laitha','Ajith','Vellamcherry','Shady lane',3,4,'687234','bh876','9995147089','laithavj@gmail.com'),(4,'Leela','Muraleedharan','Chakkiath','perumbavoor',6,4,'680026','awopi456','9934087178','lekhasadan @hotmail.com'),(5,'Sheela','sunil','kochiparambarh','merrit island',3,5,'670197','mvp670197','76892340','laithavj@gmail.com'),(6,'Anirudhan','Sankar','Chakkiat','Chakkiat lane',3,3,'789567','jfgh','12390876','kvava@gmail.com');
/*!40000 ALTER TABLE `m_party` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-03-31 18:35:01
