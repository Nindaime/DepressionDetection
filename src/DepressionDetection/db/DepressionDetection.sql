CREATE DATABASE  IF NOT EXISTS `DepressionDetection` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `DepressionDetection`;
-- MySQL dump 10.13  Distrib 5.7.26, for Linux (x86_64)
--
-- Host: localhost    Database: DepressionDetection
-- ------------------------------------------------------
-- Server version	5.7.26-0ubuntu0.18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ActivityTable`
--

DROP TABLE IF EXISTS `ActivityTable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ActivityTable` (
  `User_ID` int(11) NOT NULL,
  `ActivityName` varchar(20) DEFAULT NULL,
  `ActivityTime` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`User_ID`),
  CONSTRAINT `fk_ActivityTable_User1` FOREIGN KEY (`User_ID`) REFERENCES `User` (`User_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ActivityTable_UserHealthStatus1` FOREIGN KEY (`User_ID`) REFERENCES `UserHealthStatus` (`User_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ActivityTable`
--

LOCK TABLES `ActivityTable` WRITE;
/*!40000 ALTER TABLE `ActivityTable` DISABLE KEYS */;
/*!40000 ALTER TABLE `ActivityTable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Comments`
--

DROP TABLE IF EXISTS `Comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Comments` (
  `Post_ID` int(11) NOT NULL,
  `CommentTime` timestamp NULL DEFAULT NULL,
  `CommenterUsername` varchar(10) NOT NULL,
  `CommentText` varchar(120) DEFAULT NULL,
  KEY `fk_Comments_User1_idx` (`CommenterUsername`),
  KEY `fk_Comments_Post1` (`Post_ID`),
  CONSTRAINT `fk_Comments_Post1` FOREIGN KEY (`Post_ID`) REFERENCES `Post` (`Post_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comments_User1` FOREIGN KEY (`CommenterUsername`) REFERENCES `User` (`Username`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Comments`
--

LOCK TABLES `Comments` WRITE;
/*!40000 ALTER TABLE `Comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `Comments` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `DepressionDetection`.`Comments_BEFORE_INSERT` BEFORE INSERT ON `Comments` FOR EACH ROW
BEGIN
	declare userid int;
    declare postid int;
    declare commenttime timestamp;
    
    set userid = (select User.User_ID from  User, Comments where User.Username=NEW.CommenterUsername);  
    set postid = (select NEW.Post_ID from Comments);
    set commenttime = (select New.CommentTime from Comments);
    
    insert into ActivityTable values(userid, concat('Comment_', postid, '_'), commenttime);

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Friends`
--

DROP TABLE IF EXISTS `Friends`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Friends` (
  `User_ID` int(11) NOT NULL,
  `FriendUsername` varchar(10) DEFAULT NULL,
  KEY `fk_Friends_User_idx` (`User_ID`),
  CONSTRAINT `fk_Friends_User` FOREIGN KEY (`User_ID`) REFERENCES `User` (`User_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Friends`
--

LOCK TABLES `Friends` WRITE;
/*!40000 ALTER TABLE `Friends` DISABLE KEYS */;
/*!40000 ALTER TABLE `Friends` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Message`
--

DROP TABLE IF EXISTS `Message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Message` (
  `SenderUsername` varchar(10) NOT NULL,
  `TimeSent` timestamp NULL DEFAULT NULL,
  `ReceiverUsername` varchar(10) NOT NULL,
  `MessageStatus` varchar(10) DEFAULT NULL,
  `MessageContent` varchar(100) DEFAULT NULL,
  KEY `fk_Message_User2_idx` (`ReceiverUsername`),
  KEY `fk_Message_User1` (`SenderUsername`),
  CONSTRAINT `fk_Message_User1` FOREIGN KEY (`SenderUsername`) REFERENCES `User` (`Username`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Message_User2` FOREIGN KEY (`ReceiverUsername`) REFERENCES `User` (`Username`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Message`
--

LOCK TABLES `Message` WRITE;
/*!40000 ALTER TABLE `Message` DISABLE KEYS */;
/*!40000 ALTER TABLE `Message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Post`
--

DROP TABLE IF EXISTS `Post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Post` (
  `Post_ID` int(11) NOT NULL,
  `PosterUsername` varchar(10) NOT NULL,
  `PostTime` timestamp NULL DEFAULT NULL,
  `PostType` varchar(12) DEFAULT NULL,
  `PostCaption` varchar(120) DEFAULT NULL,
  `PostImage` varchar(30) DEFAULT NULL,
  `PostText` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`Post_ID`),
  KEY `fk_Post_User1_idx` (`PosterUsername`),
  CONSTRAINT `fk_Post_User1` FOREIGN KEY (`PosterUsername`) REFERENCES `User` (`Username`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Post`
--

LOCK TABLES `Post` WRITE;
/*!40000 ALTER TABLE `Post` DISABLE KEYS */;
/*!40000 ALTER TABLE `Post` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `DepressionDetection`.`Post_BEFORE_INSERT` BEFORE INSERT ON `Post` FOR EACH ROW
BEGIN
	declare userid int;
    declare postid int;
    declare posttime timestamp;
    
    set userid = (select User.User_ID from  User, Post where User.Username=NEW.PosterUsername);  
    set postid = (select NEW.Post_ID from Post);
    set posttime = (select New.PostTime from Post);
    
    insert into ActivityTable values(userid, concat('Post_', postid, '_'), posttime);

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `QuestionnaireA`
--

DROP TABLE IF EXISTS `QuestionnaireA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QuestionnaireA` (
  `User_ID` int(11) NOT NULL,
  `Question_ID` int(11) NOT NULL,
  `QuestionSession` varchar(10) DEFAULT NULL,
  `QuestionAnswer` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`Question_ID`),
  KEY `fk_QuestionnaireA_UserHealthStatus1_idx` (`User_ID`),
  CONSTRAINT `fk_QuestionnaireA_QuestionnaireQ1` FOREIGN KEY (`Question_ID`) REFERENCES `QuestionnaireQ` (`Question_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_QuestionnaireA_User1` FOREIGN KEY (`User_ID`) REFERENCES `User` (`User_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_QuestionnaireA_UserHealthStatus1` FOREIGN KEY (`User_ID`) REFERENCES `UserHealthStatus` (`User_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QuestionnaireA`
--

LOCK TABLES `QuestionnaireA` WRITE;
/*!40000 ALTER TABLE `QuestionnaireA` DISABLE KEYS */;
/*!40000 ALTER TABLE `QuestionnaireA` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QuestionnaireQ`
--

DROP TABLE IF EXISTS `QuestionnaireQ`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QuestionnaireQ` (
  `Question_ID` int(11) NOT NULL,
  `QuestionType` varchar(12) DEFAULT NULL,
  `QuestionText` varchar(45) DEFAULT NULL,
  `AnswerImplication` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Question_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QuestionnaireQ`
--

LOCK TABLES `QuestionnaireQ` WRITE;
/*!40000 ALTER TABLE `QuestionnaireQ` DISABLE KEYS */;
/*!40000 ALTER TABLE `QuestionnaireQ` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `User` (
  `User_ID` int(11) NOT NULL,
  `Username` varchar(10) DEFAULT NULL,
  `Password` varchar(45) DEFAULT NULL,
  `Gender` varchar(10) DEFAULT NULL,
  `Age` int(11) DEFAULT NULL,
  `UserType` varchar(12) DEFAULT NULL,
  `OnlineStatus` varchar(10) DEFAULT NULL,
  `RelationshipStatus` varchar(10) DEFAULT NULL,
  `LevelOfEducation` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`User_ID`),
  UNIQUE KEY `Username_UNIQUE` (`Username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `DepressionDetection`.`User_AFTER_INSERT` AFTER INSERT ON `User` FOR EACH ROW
BEGIN
	declare userid int;
    declare activity_name varchar(20);
    declare activity_time timestamp;
    
    set userid = NEW.User_ID;
    set activity_name = concat(NEW.Username, '_', NEW.OnlineStatus);
    set activity_time = Now();
    
    insert into ActivityTable values(userid, activity_name, activity_time);

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `UserHealthStatus`
--

DROP TABLE IF EXISTS `UserHealthStatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UserHealthStatus` (
  `User_ID` int(11) NOT NULL,
  `Variability` blob DEFAULT NULL,
  `Instability` blob DEFAULT NULL,
  `Diagnosis` json DEFAULT NULL,
  PRIMARY KEY (`User_ID`),
  CONSTRAINT `fk_UserHealthStatus_User1` FOREIGN KEY (`User_ID`) REFERENCES `User` (`User_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserHealthStatus`
--

LOCK TABLES `UserHealthStatus` WRITE;
/*!40000 ALTER TABLE `UserHealthStatus` DISABLE KEYS */;
/*!40000 ALTER TABLE `UserHealthStatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'DepressionDetection'
--

--
-- Dumping routines for database 'DepressionDetection'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-07-11 21:13:39
