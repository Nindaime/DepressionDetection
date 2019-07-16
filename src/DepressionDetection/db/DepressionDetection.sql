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
  CONSTRAINT `fk_ActivityTable_UserHealthStatus1` FOREIGN KEY (`User_ID`) REFERENCES `UserMentalHealthStatus` (`User_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `DepressionDetection`.`Comments_BEFORE_INSERT`
BEFORE INSERT ON `DepressionDetection`.`Comments`
FOR EACH ROW
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
-- Table structure for table `DepressionType`
--

DROP TABLE IF EXISTS `DepressionType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DepressionType` (
  `DepressionTypeID` enum('General','Seasonal Affective Disorder','Persistent Depressive Disorder','Premenstrual Dysphoric Disorder','Situational Depression','Atypical Depression','Major Depressive Disorder','Psychotic Depression','Bipolar Disorder') NOT NULL DEFAULT 'General',
  `InitImapScore` tinyint(4) DEFAULT NULL,
  `DiagnosisName` varchar(12) DEFAULT NULL,
  `DiagnosisDescriptionText` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`DepressionTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DepressionType`
--

LOCK TABLES `DepressionType` WRITE;
/*!40000 ALTER TABLE `DepressionType` DISABLE KEYS */;
INSERT INTO `DepressionType` (`DepressionTypeID`, `InitImapScore`, `DiagnosisName`, `DiagnosisDescriptionText`) VALUES ('General',NULL,NULL,NULL),('Seasonal Affective Disorder',NULL,NULL,NULL),('Persistent Depressive Disorder',NULL,NULL,NULL),('Premenstrual Dysphoric Disorder',NULL,NULL,NULL),('Situational Depression',NULL,NULL,NULL),('Atypical Depression',NULL,NULL,NULL),('Major Depressive Disorder',NULL,NULL,NULL),('Psychotic Depression',NULL,NULL,NULL),('Bipolar Disorder',NULL,NULL,NULL);
/*!40000 ALTER TABLE `DepressionType` ENABLE KEYS */;
UNLOCK TABLES;

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
  `PostCaption` varchar(255) DEFAULT NULL,
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `DepressionDetection`.`Post_BEFORE_INSERT`
BEFORE INSERT ON `DepressionDetection`.`Post`
FOR EACH ROW
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
  `AnswerID` enum('Extremely likely','Unlikely','Sometimes','Likely','Extremely unlikely','Yes','No','Six months ago','One year ago','Two years ago','Less than a month','One to six months','Six to two years','Not at all') NOT NULL,
  `Question_ID` int(11) NOT NULL,
  `AnswerText` varchar(8) DEFAULT NULL,
  `AnswerImplication` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`AnswerID`,`Question_ID`),
  KEY `fk_QuestionnaireA_1_idx` (`Question_ID`),
  CONSTRAINT `fk_QuestionnaireA_1` FOREIGN KEY (`Question_ID`) REFERENCES `QuestionnaireQ` (`Question_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
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
  `Question_ID` int(11) NOT NULL AUTO_INCREMENT,
  `DepressionTypeID` enum('General','Seasonal Affective Disorder','Persistent Depressive Disorder','Premenstrual Dysphoric Disorder','Situational Depression','Atypical Depression','Major Depressive Disorder','Psychotic Depression','Bipolar Disorder') NOT NULL DEFAULT 'General',
  `QuestionText` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Question_ID`,`DepressionTypeID`),
  KEY `fk_QuestionnaireQ_1_idx` (`DepressionTypeID`),
  CONSTRAINT `fk_QuestionnaireQ_1` FOREIGN KEY (`DepressionTypeID`) REFERENCES `DepressionType` (`DepressionTypeID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=194 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QuestionnaireQ`
--

LOCK TABLES `QuestionnaireQ` WRITE;
/*!40000 ALTER TABLE `QuestionnaireQ` DISABLE KEYS */;
INSERT INTO `QuestionnaireQ` (`Question_ID`, `DepressionTypeID`, `QuestionText`) VALUES (1,'General','Are things getting out of control for you?'),(2,'General','Do you think you don’t look forward to much of anything?'),(3,'General','Lately, do you find it impossible to make decisions?'),(4,'General','Do you find it difficult to concentrate, and forget what you read?'),(5,'General','Are you extremely pessimistic about things?'),(6,'General','Do you make too many mistakes?'),(7,'General','Do you think your life is full of regrets?'),(8,'General','Do you think/ feel you have been letting down those close to you?'),(9,'General','Do you think/feel people don’t want to be around you?'),(10,'General','Have you been having more difficulties than usual talking about your concerns?'),(11,'General','Have you been losing your appetite lately?'),(12,'General','Have you been avoiding people more than usual, including friends and family?'),(13,'General','Do you often feel sick to your stomach?'),(14,'General','Are you finding it difficult to control worrying?'),(15,'General','Do you ever feel you’re just as good as other people?'),(16,'General','Did you engage in any activities or hobby?'),(17,'General','Are you fatigued easily?'),(18,'General','Are your thoughts overwhelming, and you can’t seem to catch a break?'),(19,'General','Have you had frightening thoughts that last for days?'),(20,'General','Do you sleep at least five (5) hours at night?'),(21,'General','Do you think, you are pessimistic about life?'),(22,'General','Do people easily irritate you?'),(23,'General','Are there days you feel proud of yourself?'),(24,'General','Are there days you can’t seem to shake the blues?'),(25,'General','Have you felt like being physically intimate with anyone lately?'),(26,'General','Have you being feeling down, depressed or hopeless?'),(27,'General','Do you experience an inability to concentrate?'),(28,'General','Are you unable to make decisions?'),(29,'General','Are you experiencing difficulties in doing your work or taking care of things at home?'),(30,'General','Are there signs of being slowed in functioning?'),(31,'General','Have you had thoughts that you’ve being a failure?'),(32,'General','Are there moments you just can’t get along with others?'),(33,'General','Do you think, you’ve let your family/friends down?'),(34,'General','Do you experience an intense feeling of guilt?'),(35,'General','Do you feel you have a very low sense of personal worth?'),(36,'General','Is there a striking change in your appetite?'),(37,'General','Is there evident changes in your body’s weight?'),(38,'General','Do you succumb to self-condemnation?'),(39,'General','Do you experience mood swings?'),(40,'General','Are there moments when you feel extreme fatigue?'),(41,'General','Is there major changes in your sleeping patterns?'),(42,'General','Are there clear signs of revved up agitation?'),(43,'General','Do you’ve repetitive thoughts of suicide?'),(44,'General','Has there being thoughts of being better off, when dead?'),(45,'General','Do you experience little pleasure or interest in doing things?'),(46,'General','Do you experience mania or hypomania? (i.e. mania is a state of abnormal elevated or  irritable mood, arousal, and/or energy levels.)'),(47,'General','Do you’ve a family/relative with bipolar disorder?'),(48,'General','Do you’ve a family/relative with psychiatric comorbidities?'),(49,'General','Have you experienced an inability/poor concentration?'),(50,'General','Have you had an intense feeling of being anxious?'),(51,'General','Have you had problems making decisions?'),(52,'General','Are there moments when insecurity were your biggest concern?'),(53,'General','Have you had an experience when your pessimism got the best of you?'),(54,'General','Do you get the feeling that you’ve a poor self-image?'),(55,'General','Guilty feelings?'),(56,'General','Have you ever had a low sense of personal worth?'),(57,'General','Do you get an intensified feeling of Hopelessness?'),(58,'General','Are there days when you get gloomy?'),(59,'General','Have you noticed/experienced a significant increase or decrease in your appetite?'),(60,'General','Are there days you just can’t seem to catch a break or an overwhelming feeling of restlessness?'),(61,'General','Are there days where you sleep less than four (4) hours or more than six (6) hours?'),(62,'General','Chronically Fatigue or low energy?'),(63,'General','Do you an intense feeling of body aches? (i.e. back pain, headaches, muscles soreness.)'),(64,'General','Have you had thoughts of suicide/death?'),(65,'General','Do you take alcohol?'),(66,'General','Do you find yourself increasingly depending on alcohol?'),(67,'General','Divorce/separation'),(68,'General','Family conflicts'),(69,'General','Conflicts in work life'),(70,'General','Conflicts with neighbors'),(71,'General','Illness of a loved one'),(72,'General','Death of a loved one'),(73,'General','Adjustment due to retirement'),(74,'General','Unemployment'),(75,'General','Too much/too little work'),(76,'General','Pressure to meet deadlines/time pressure'),(77,'General','Moving to a new home'),(78,'General','Financial problems'),(79,'General','Own serious illness'),(80,'General','Serious accident'),(81,'General','Assault'),(82,'General','Termination of an important leisure activity'),(83,'General','Any other stressful event (please indicate)'),(84,'General','Any other stressful event (please indicate)'),(85,'General','Since the event, I feel low and sad.'),(86,'General','I have to think about the event repeatedly.'),(87,'General','I try to avoid talking about the event whenever possible.'),(88,'General','I have to think about the event a lot and this is a great burden to me.'),(89,'General','I rarely do those activities which I used to enjoy anymore.'),(90,'General','If I think about the event, I find myself in a real state of anxiety.'),(91,'General','I avoid certain things that might remind me of the event.'),(92,'General','I’m nervous and restless since the event.'),(93,'General','Since the event, I lose my temper much quicker than I used to, even over small things.'),(94,'General','Since the event , I find it difficult to concentrate on certain things.'),(95,'General','I try to dismiss the event from my memory.'),(96,'General','I have noticed that I’m becoming more irritable due to the event.'),(97,'General','I constantly get memories of the event and can’t do anything to stop them.'),(98,'General','I try to suppress my feelings because they are a burden to me.'),(99,'General','My thoughts often revolve around anything related to the event.'),(100,'General','Since the event, I’m scared of doing certain things or of getting into certain situations.'),(101,'General','Since the event, I don’t like going to work or carrying out the necessary tasks in everyday life.'),(102,'General','I have been feeling dispirited since the event and have little hope for the future.'),(103,'General','Since the event, I can no longer sleep properly.'),(104,'General','All in all, the event causes serious impairment in my social or occupational life, my leisure time, and other important areas of functioning.'),(105,'General','You felt so good or so hyper that people thought you were not your normal self or you were so hyper that you got into trouble?'),(106,'General','You were so irritable that you shouted at people or started fights or arguments?'),(107,'General','you felt much more self-confident than usual?'),(108,'General','You got much less sleep than usual and found you didn’t really miss it?'),(109,'General','You were much more talkative or spoke much faster than usual?'),(110,'General','Thoughts raced through your head or you couldn’t slow your mind down?'),(111,'General','You were so easily distracted by things around you that you had trouble concentrating or staying on track?'),(112,'General','You had much more energy than usual?'),(113,'General','You were much more interested in sex than usual?'),(114,'General','You were much more active or did many more things than usual?'),(115,'General','You were much more social or outgoing than usual, for example, you telephoned friends in the middle of the night?'),(116,'General','You did things that were unusual for you or that other people might have thought were excessive, foolish, or risky?'),(117,'General','Spending money got you or your family into trouble?'),(118,'General','If you checked yes to more than one of the above, have several of these ever happened during the same period of time?'),(119,'General','How much of a problem did any of these cause you, like being unable to work; having family, money or legal troubles; getting into arguments or fights?'),(120,'General','Have any of your blood relatives (i.e. children, siblings, parents, grandparents, aunts, uncles) had manic-depressive illness or bipolar disorder?'),(121,'General','Has a health professional ever told you that you’ve manic-depressive illness or bipolar disorder?'),(122,'General','Change in your total sleep length (including nighttime sleep and naps)'),(123,'General','Change in your level of social activity (including friends, family and co-workers)'),(124,'General','Change in your general mood, or overall feeling of well-being'),(125,'General','Change in your weight'),(126,'General','Change in your appetite (both food cravings and the amount you eat)'),(127,'General','Change in your energy level'),(128,'General','When you had trouble falling sleep or staying asleep, or sleeping too much?'),(129,'General','When you were feeling tired or had little energy?'),(130,'General','When you experienced poor appetite or overeating?'),(131,'General','Significant weight gain or loss, although you were not dieting?'),(132,'General','When you found little interest or little pleasure in doing things?'),(133,'General','When you were feeling down, depressed, or hopeless?'),(134,'General','When you were feeling bad about yourself ?'),(135,'General','When you were feeling that you were a failure?'),(136,'General','When you were feeling that you were letting yourself or family down?'),(137,'General','When you had trouble concentrating on things, like reading the newspaper or watching television?'),(138,'General','When you were so fidgety or restless that you were moving around a lot more than usual? Or the opposite?'),(139,'General','When you were thinking about death or that you would be better off dead, or even thinking of hurting yourself?'),(140,'General','I tend to sleep longer hours (napping included).'),(141,'General','I tend to have trouble waking up in the morning.'),(142,'General','I tend to have low daytime energy, feeling tired most of the time.'),(143,'General','I tend to feel worse, overall, in the evening than in the morning.'),(144,'General','I tend to have a distinct temporary slump in mood or energy in the afternoon.'),(145,'General','I tend to crave more sweets and starches.'),(146,'General','I tend to eat more sweets and starches, whether or not I crave them.'),(147,'General','I tend to crave sweets, but mostly in the afternoon and evening.'),(148,'General','I tend to gain more weight than in the summer.'),(149,'General','Anger'),(150,'General','Irritability'),(151,'General','Anxiety'),(152,'General','Tension/ Mood swing'),(153,'General','Depressed mood/ Sadness'),(154,'General','Hopelessness'),(155,'General','Decreased interest in work, home, or social activities'),(156,'General','Difficulty concentrating'),(157,'General','Fatigue'),(158,'General','Lack of energy'),(159,'General','Withdrawal'),(160,'General','Crying/ Tearfulness'),(161,'General','Overeating/food cravings'),(162,'General','Hypersomnia'),(163,'General','Insomnia'),(164,'General','Feeling overwhelmed/ out of control'),(165,'General','Physical symptoms: Headaches, Joint/muscle pain, bloating, weight gain, tenderness of the breast.'),(166,'General','I have being able to laugh and see the funny side of things'),(167,'General','I have looked forwards with enjoyments of things'),(168,'General','I have blamed myself unnecessarily when things went wrong'),(169,'General','I have been anxious or worried for no good reason'),(170,'General','I have felt scared or panicky for no just reason'),(171,'General','How have you been able to cope with things'),(172,'General','I have been so unhappy that I have had difficulty sleep'),(173,'General','I have felt sad or miserable'),(174,'General','I have been so unhappy that I’ve been crying'),(175,'General','The thought of harming myself has occurred to me'),(176,'General','Exhaustion'),(177,'General','Shows no interest in holding the baby'),(178,'General','Increased irritability'),(179,'General','Can’t shoulder responsibility'),(180,'General','Hypersomnia (i.e. sleeping too much, more than 10 hours per day, at least 3 days in a week for minimum of 3months)'),(181,'General','Significant increase in appetite over the last 3months'),(182,'General','Significant increase in weight (i.e. at least 3-5KG over the last 3 months)'),(183,'General','Leaden paralysis (heavy, leaden feeling in arms or legs) present for at least an hour per day'),(184,'General','Interpersonal rejection sensitivity'),(185,'General','Do you generally feel down?'),(186,'General','Does your mood fluctuate?'),(187,'General','Does your erratic mood interfere with your daily life or relationship?'),(188,'General','DO you often feel irritable?'),(189,'General','Do you ever have suicidal thoughts?'),(190,'General','Do you have any blood relatives with depression?'),(191,'General','Do you have other mental or physical health conditions?'),(192,'General','Do you drink alcohol?'),(193,'General','Do you use recreational drugs?');
/*!40000 ALTER TABLE `QuestionnaireQ` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QuestionnaireSession`
--

DROP TABLE IF EXISTS `QuestionnaireSession`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QuestionnaireSession` (
  `QuestionnaireSessionID` int(11) NOT NULL,
  `User_ID` int(11) DEFAULT NULL,
  `AnswerID` enum('Extremely likely','Unlikely','Sometimes','Likely','Extremely unlikely','Yes','No','Six months ago','One year ago','Two years ago','Less than a month','One to six months','Six to two years','Not at all') DEFAULT NULL,
  `Question_ID` int(11) NOT NULL,
  PRIMARY KEY (`QuestionnaireSessionID`),
  KEY `fk_QuestionnaireSession_User1_idx` (`User_ID`),
  KEY `fk_QuestionnaireSession_1_idx` (`Question_ID`),
  KEY `fk_QuestionnaireSession_2_idx` (`AnswerID`),
  CONSTRAINT `fk_QuestionnaireSession_1` FOREIGN KEY (`Question_ID`) REFERENCES `QuestionnaireQ` (`Question_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_QuestionnaireSession_2` FOREIGN KEY (`AnswerID`) REFERENCES `QuestionnaireA` (`AnswerID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_QuestionnaireSession_User1` FOREIGN KEY (`User_ID`) REFERENCES `User` (`User_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QuestionnaireSession`
--

LOCK TABLES `QuestionnaireSession` WRITE;
/*!40000 ALTER TABLE `QuestionnaireSession` DISABLE KEYS */;
/*!40000 ALTER TABLE `QuestionnaireSession` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `DepressionDetection`.`User_AFTER_INSERT`
AFTER INSERT ON `DepressionDetection`.`User`
FOR EACH ROW
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
-- Table structure for table `UserMentalHealthStatus`
--

DROP TABLE IF EXISTS `UserMentalHealthStatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UserMentalHealthStatus` (
  `User_ID` int(11) NOT NULL,
  `Variability` blob,
  `Instability` blob,
  `DiagnosisHistory` blob,
  `CurrDeprTypeID` enum('General','Seasonal Affective Disorder','Persistent Depressive Disorder','Premenstrual Dysphoric Disorder','Situational Depression','Atypical Depression','Major Depressive Disorder','Psychotic Depression','Bipolar Disorder') NOT NULL DEFAULT 'General',
  PRIMARY KEY (`User_ID`,`CurrDeprTypeID`),
  KEY `fk_UserMentalHealthStatus_DepressionType1_idx` (`CurrDeprTypeID`),
  CONSTRAINT `fk_UserHealthStatus_User1` FOREIGN KEY (`User_ID`) REFERENCES `User` (`User_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_UserMentalHealthStatus_DepressionType1` FOREIGN KEY (`CurrDeprTypeID`) REFERENCES `DepressionType` (`DepressionTypeID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserMentalHealthStatus`
--

LOCK TABLES `UserMentalHealthStatus` WRITE;
/*!40000 ALTER TABLE `UserMentalHealthStatus` DISABLE KEYS */;
/*!40000 ALTER TABLE `UserMentalHealthStatus` ENABLE KEYS */;
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

-- Dump completed on 2019-07-16 16:38:35
