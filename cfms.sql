-- MySQL dump 10.13  Distrib 5.7.9, for Win32 (AMD64)
--
-- Host: localhost    Database: cfms
-- ------------------------------------------------------
-- Server version	5.7.9-log

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
-- Table structure for table `batch`
--

DROP TABLE IF EXISTS `batch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `batch` (
  `intake` varchar(255) NOT NULL,
  `batchID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`batchID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batch`
--

LOCK TABLES `batch` WRITE;
/*!40000 ALTER TABLE `batch` DISABLE KEYS */;
INSERT INTO `batch` VALUES ('20122013',1),('20132014',2),('20142015',3),('20152016',4);
/*!40000 ALTER TABLE `batch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batch_courses`
--

DROP TABLE IF EXISTS `batch_courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `batch_courses` (
  `batchID` int(11) NOT NULL,
  `sem` int(2) NOT NULL,
  `courseCode` varchar(255) NOT NULL,
  `courseID` int(11) NOT NULL,
  `label` int(2) NOT NULL,
  `major` varchar(10) NOT NULL,
  PRIMARY KEY (`batchID`,`courseID`,`courseCode`),
  KEY `courseID` (`courseID`),
  KEY `courses_ID` (`courseCode`,`courseID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batch_courses`
--

LOCK TABLES `batch_courses` WRITE;
/*!40000 ALTER TABLE `batch_courses` DISABLE KEYS */;
INSERT INTO `batch_courses` VALUES (2,1,'SCSI',1013,0,'SCSJ'),(2,1,'SCSJ',1013,0,'SCSJ'),(2,1,'SCSR',1013,0,'SCSJ'),(2,2,'SCSJ',1023,0,'SCSJ'),(2,2,'SCSI',1113,0,'SCSJ'),(2,2,'SCSR',1213,0,'SCSJ'),(2,2,'SCSV',1223,0,'SCSJ'),(2,1,'SCSD',1513,0,'SCSJ'),(2,3,'SCSJ',2013,0,'SCSJ'),(2,3,'SCSR',2033,0,'SCSJ'),(2,4,'SCSR',2043,0,'SCSJ'),(2,3,'SCSV',2113,0,'SCSJ'),(2,4,'SCSI',2143,0,'SCSJ'),(2,4,'SCSJ',2154,0,'SCSJ'),(2,4,'SCSJ',2203,0,'SCSJ'),(2,4,'SCSJ',2253,0,'SCSJ'),(2,4,'SCSJ',2363,0,'SCSJ'),(2,3,'SCSD',2523,0,'SCSJ'),(2,3,'SCSD',2613,0,'SCSJ'),(2,6,'SCSJ',3032,2,'SCSJ'),(2,5,'SCSJ',3104,1,'SCSJ'),(2,5,'SCSJ',3203,1,'SCSJ'),(2,6,'SCSJ',3253,2,'SCSJ'),(2,5,'SCSJ',3303,1,'SCSJ'),(2,6,'SCSJ',3323,2,'SCSJ'),(2,5,'SCSJ',3343,1,'SCSJ'),(2,6,'SCSJ',3403,2,'SCSJ'),(2,5,'SCSJ',3553,1,'SCSJ'),(2,6,'SCSJ',3563,2,'SCSJ'),(2,5,'SCSJ',3603,1,'SCSJ'),(2,6,'SCSD',3761,2,'SCSJ'),(2,7,'SCSJ',4114,3,'SCSJ'),(2,7,'SCSJ',4118,3,'SCSJ'),(2,8,'SCSJ',4134,4,'SCSJ'),(2,8,'SCSJ',4383,4,'SCSJ'),(2,8,'SCSJ',4423,4,'SCSJ'),(2,8,'SCSJ',4463,4,'SCSJ'),(2,8,'SCSJ',4483,4,'SCSJ');
/*!40000 ALTER TABLE `batch_courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course` (
  `courseCode` varchar(5) NOT NULL,
  `courseID` int(11) NOT NULL,
  `courseName` varchar(255) NOT NULL,
  `shortForm` varchar(255) NOT NULL,
  `creditHours` int(1) NOT NULL,
  PRIMARY KEY (`courseCode`,`courseID`),
  KEY `courseCode` (`courseCode`),
  KEY `courseID` (`courseID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES ('SCSB',2103,'Bioinformatics I','Bioinformatics I',3),('SCSB',3032,'Bioinformatic Project I','Bioinformatic Project I',2),('SCSB',3103,'Bioinformatics II','Bioinformatics II',3),('SCSB',3133,'Computational Biology I','Comp Biology I',3),('SCSB',3203,'Programming for Bioinformatics','Programming for Bioinformatics',3),('SCSB',3213,'Bioinformatics Database','Bioinformatics Database',3),('SCSB',3223,'Computational Biology II','Comp Biology II',3),('SCSB',4114,'Industrial Training Report','LI Report',4),('SCSB',4118,'Industrial Training (HW)','LI (HW)',8),('SCSB',4134,'Bioinformatics Project II','Bioinformatics Project II',4),('SCSB',4213,'Bioinformatics Visualization','Bioinformatics Visualization',3),('SCSB',4243,'Special Topics in Bioinformatics','Special Topics in Bioinformatics',3),('SCSB',4313,'Bioinformatics Modelling and Simulation','Bioinformatics Modelling and Simulation',3),('SCSD',1513,'Technology & Information System','TIS',3),('SCSD',2523,'Database','DB',3),('SCSD',2613,'System Analysis and  Design','SADM',3),('SCSD',2623,'Database Programming','Database Programming',3),('SCSD',3761,'Technopreneurship Seminar','Technopreneurship Seminar',1),('SCSI',1013,'Discrete Structure','Discrete Structure',3),('SCSI',1113,'Computational Mathematics','Comp Maths',3),('SCSI',2143,'Probability & Statistical Data Analysis','PSDA',3),('SCSJ',1013,'Programming Technique I','PT I',3),('SCSJ',1023,'Programming Technique II','PT II',3),('SCSJ',2013,'Data Structure and Algorithm','Data Structure and Algorithm',3),('SCSJ',2154,'Object-Oriented Programming','OOP',4),('SCSJ',2203,'Software Engineering','SE',3),('SCSJ',2253,'Requirement Engineering & Software Modelling','RESM',3),('SCSJ',2363,'Software Project Management','Software Project Management',3),('SCSJ',3032,'Software Engineering Project I','SE Project I',2),('SCSJ',3104,'Applications Development','AD',4),('SCSJ',3203,'Computer Science Theory','CST',3),('SCSJ',3253,'Programming Technique III','PT III',3),('SCSJ',3303,'Internet Programming','IP',3),('SCSJ',3323,'Software Design & Architecture','SDA',3),('SCSJ',3343,'Software Quality Assurance','SQA',3),('SCSJ',3403,'Special Topics in Software Engineering','Special Topics in SE',3),('SCSJ',3553,'Artificial Intelligence','AI',3),('SCSJ',3563,'Computational Intelligence','CI',3),('SCSJ',3603,'Knowledge-based Expert System','Knowledge-based Expert System',3),('SCSJ',4114,'Industrial Training Report','LI Report',4),('SCSJ',4118,'Industrial Training (HW)','LI (HW)',8),('SCSJ',4134,'Software Engineering Project II','SE Project II',4),('SCSJ',4383,'Software Construction','Software Construction',3),('SCSJ',4423,'Real-time Software Engineering','Real-time SE',3),('SCSJ',4463,'Agent-Oriented Software Engineering','Agent-Oriented Software Engineering',3),('SCSJ',4483,'Web Technology','Web Technology',3),('SCSR',1013,'Digital Logic','Digital Logic',3),('SCSR',1213,'Network Communications','Net Comm',3),('SCSR',2033,'Computer Organisation & Architecture','COA',3),('SCSR',2043,'Operating Systems','OS',3),('SCSR',2233,'Network','Network',3),('SCSR',2242,'Computer Networks','Computer Networks',3),('SCSR',2941,'Computer Networks Lab','Computer Networks Lab',3),('SCSR',3032,'Computer Network & Security Project I','Computer Network & Security Project I',2),('SCSR',3104,'Applications Development','AD',4),('SCSR',3242,'Inter Networking Technology','Inter Networking Technology',2),('SCSR',3243,'Netcentric Computing','Netcentric Computing',3),('SCSR',3253,'Network Programming','Network Programming',3),('SCSR',3413,'Computer Security','Computer Security',3),('SCSR',3443,'Cryptography','Cryptography',3),('SCSR',3941,'Inter Networking Technology Lab','Inter Networking Technology Lab',1),('SCSR',4114,'Industrial Training Report','LI Report',4),('SCSR',4118,'Industrial Training (HW)','LI (HW)',8),('SCSR',4273,'Network Administration and Management','Network Administration and Management',3),('SCSR',4283,'Network Analysis and Design Simulation','Network Analysis and Design Simulation',3),('SCSR',4453,'Network Security','Network Security',3),('SCSR',4473,'Security Management','Security Management',3),('SCSR',4483,'Security Programming','Security Prog',3),('SCSR',4493,'Computer Forensic','Computer Forensic',3),('SCSR',4973,'Computer Network & Security Special Topic','Computer Network & Security Special Topic',3),('SCSV',1113,'Mathematics for Computer Graphics','Mathematics for Computer Graphics',3),('SCSV',1223,'Web Programming','Web Prog',3),('SCSV',2013,'Graphic Design','Graphic Design',3),('SCSV',2113,'Human Computer Interaction','HCI',3),('SCSV',2122,'Fundamental of image Processing','Fundamental of image Processing',3),('SCSV',3032,'Graphics and Multimedia Software Project I','Graphics and Multimedia Software Project I',2),('SCSV',3104,'Applications Development','AD',4),('SCSV',3113,'Geometric Modelling','Geometric Modelling',3),('SCSV',3123,'Real-time Computer Graphics','Real-time Computer Graphics',3),('SCSV',3213,'Fundamental of Image Processing','Fundamental of Image Processing',3),('SCSV',3223,'Multimedia Data Processing','Multimedia Data Processing',3),('SCSV',3233,'Multimedia Networking','Multimedia Networking',3),('SCSV',4114,'Industrial Training Report','LI Report',4),('SCSV',4118,'Industrial Training (HW)','LI (HW)',8),('SCSV',4213,'Computer Games Development','Computer Games Development',3),('SCSV',4233,'Data Visualization','Data Visualization',3),('SCSV',4263,'Multimedia Web Programming','Multimedia Web Programming',3),('SCSV',4273,'Introduction to Speech Recognition','Introduction to Speech Recognition',3),('SCSV',4283,'Windows Programming','Windows Programming',3),('UCSD',2762,'Fundamental of Technopreneurship','Fundamental of Technopreneurship',2),('UHAS',1162,'Art, Custom and Beliefs of Malaysia','Art, Custom and Beliefs of Malaysia',2),('UHAS',1172,'Malaysia Dynamic','Malaysia Dynamic',2),('UICI',1022,'Islamic & Aisan Civilisation (TITAS)','TITAS',2),('UICI',2032,'Science, Technology & Human','STM',2),('ULAB',1112,'Academic English Skills','Academic English Skills',2),('ULAB',2122,'Advanced Academic English Skills','Advanced Academic English Skills',2),('ULAB',3162,'English for Professional Purpose','English for Professional Purpose',2),('ULAM',1112,'Bahasa Melayu untuk Komunikasi','Bahasa Melayu untuk Komunikasi',2);
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_offered`
--

DROP TABLE IF EXISTS `course_offered`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_offered` (
  `semesterID` int(11) NOT NULL,
  `courseCode` varchar(5) NOT NULL,
  `courseID` int(11) NOT NULL,
  `username` varchar(225) DEFAULT NULL,
  `course_offered_ID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`course_offered_ID`),
  KEY `semesterID` (`semesterID`),
  KEY `courseCode` (`courseCode`),
  KEY `courseID` (`courseID`),
  KEY `username` (`username`),
  KEY `course_ID` (`courseCode`,`courseID`),
  CONSTRAINT `course_ID` FOREIGN KEY (`courseCode`, `courseID`) REFERENCES `course` (`courseCode`, `courseID`),
  CONSTRAINT `course_offered_ibfk_1` FOREIGN KEY (`semesterID`) REFERENCES `year_semester` (`semesterID`),
  CONSTRAINT `course_offered_ibfk_2` FOREIGN KEY (`username`) REFERENCES `user` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_offered`
--

LOCK TABLES `course_offered` WRITE;
/*!40000 ALTER TABLE `course_offered` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_offered` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department` (
  `departmentID` int(11) NOT NULL AUTO_INCREMENT,
  `department` varchar(255) NOT NULL,
  `major` varchar(255) NOT NULL,
  PRIMARY KEY (`departmentID`),
  KEY `department` (`department`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (2,'Software Engineering','Software Engineering'),(3,'Computer Science','Computer Science'),(4,'Information System','Information System');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `files`
--

DROP TABLE IF EXISTS `files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `files` (
  `fileID` int(255) NOT NULL AUTO_INCREMENT,
  `fileDirectory` varchar(255) NOT NULL,
  PRIMARY KEY (`fileID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `files`
--

LOCK TABLES `files` WRITE;
/*!40000 ALTER TABLE `files` DISABLE KEYS */;
/*!40000 ALTER TABLE `files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lecturer_upload`
--

DROP TABLE IF EXISTS `lecturer_upload`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lecturer_upload` (
  `fileID` int(11) NOT NULL,
  `sectionID` int(11) NOT NULL,
  `checklistID` int(11) NOT NULL,
  PRIMARY KEY (`fileID`,`sectionID`),
  KEY `sectionID` (`sectionID`),
  KEY `checklistID` (`checklistID`),
  CONSTRAINT `lecturer_upload_ibfk_2` FOREIGN KEY (`sectionID`) REFERENCES `section` (`sectionID`),
  CONSTRAINT `lecturer_upload_ibfk_3` FOREIGN KEY (`fileID`) REFERENCES `files` (`fileID`),
  CONSTRAINT `lecturer_upload_ibfk_4` FOREIGN KEY (`checklistID`) REFERENCES `upload_checklist` (`checklistID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lecturer_upload`
--

LOCK TABLES `lecturer_upload` WRITE;
/*!40000 ALTER TABLE `lecturer_upload` DISABLE KEYS */;
/*!40000 ALTER TABLE `lecturer_upload` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profile`
--

DROP TABLE IF EXISTS `profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profile` (
  `name` varchar(255) NOT NULL,
  `emailAdd` varchar(255) NOT NULL,
  `phoneNo` varchar(20) NOT NULL,
  `departmentID` int(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  KEY `username` (`username`),
  KEY `department` (`departmentID`),
  CONSTRAINT `profile_ibfk_1` FOREIGN KEY (`username`) REFERENCES `user` (`username`),
  CONSTRAINT `profile_ibfk_2` FOREIGN KEY (`departmentID`) REFERENCES `department` (`departmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile`
--

LOCK TABLES `profile` WRITE;
/*!40000 ALTER TABLE `profile` DISABLE KEYS */;
INSERT INTO `profile` VALUES ('ADMIN','admin@admin.com','999',4,'Active','admin'),('Super!!','super@gmail.com!!','999',2,'Active','super'),('Akmal Irfan','akmalirfan94@yes.my','123',2,'Active','irfan');
/*!40000 ALTER TABLE `profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `section`
--

DROP TABLE IF EXISTS `section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `section` (
  `username` varchar(255) NOT NULL,
  `semesterID` int(11) NOT NULL,
  `sectionID` int(11) NOT NULL AUTO_INCREMENT,
  `course_offered_ID` int(11) NOT NULL,
  `courseCode` varchar(5) NOT NULL,
  `courseID` int(5) NOT NULL,
  `sectionNo` int(2) NOT NULL,
  `sectionMajor` varchar(20) NOT NULL,
  PRIMARY KEY (`sectionID`),
  UNIQUE KEY `course_section` (`course_offered_ID`,`sectionNo`),
  KEY `username` (`username`),
  KEY `course_offered_ID` (`course_offered_ID`),
  KEY `semesterID` (`semesterID`),
  KEY `courseID` (`courseID`),
  KEY `coursess_ID` (`courseCode`,`courseID`),
  CONSTRAINT `coursess_ID` FOREIGN KEY (`courseCode`, `courseID`) REFERENCES `course` (`courseCode`, `courseID`),
  CONSTRAINT `section_ibfk_1` FOREIGN KEY (`username`) REFERENCES `user` (`username`),
  CONSTRAINT `section_ibfk_2` FOREIGN KEY (`semesterID`) REFERENCES `year_semester` (`semesterID`),
  CONSTRAINT `section_ibfk_3` FOREIGN KEY (`course_offered_ID`) REFERENCES `course_offered` (`course_offered_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `section`
--

LOCK TABLES `section` WRITE;
/*!40000 ALTER TABLE `section` DISABLE KEYS */;
/*!40000 ALTER TABLE `section` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `section_lecturer`
--

DROP TABLE IF EXISTS `section_lecturer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `section_lecturer` (
  `username` varchar(255) NOT NULL,
  `sectionID` int(11) NOT NULL,
  KEY `username` (`username`),
  KEY `sectionID` (`sectionID`),
  CONSTRAINT `section_lecturer_ibfk_1` FOREIGN KEY (`username`) REFERENCES `user` (`username`),
  CONSTRAINT `section_lecturer_ibfk_2` FOREIGN KEY (`sectionID`) REFERENCES `section` (`sectionID`),
  CONSTRAINT `section_lecturer_ibfk_3` FOREIGN KEY (`sectionID`) REFERENCES `section` (`sectionID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `section_lecturer`
--

LOCK TABLES `section_lecturer` WRITE;
/*!40000 ALTER TABLE `section_lecturer` DISABLE KEYS */;
/*!40000 ALTER TABLE `section_lecturer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `upload_checklist`
--

DROP TABLE IF EXISTS `upload_checklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `upload_checklist` (
  `checklistID` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `status` varchar(20) NOT NULL,
  PRIMARY KEY (`checklistID`),
  UNIQUE KEY `label_2` (`label`),
  KEY `label` (`label`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `upload_checklist`
--

LOCK TABLES `upload_checklist` WRITE;
/*!40000 ALTER TABLE `upload_checklist` DISABLE KEYS */;
INSERT INTO `upload_checklist` VALUES (1,'Appointment Letter','Appointment Letter of Lecturer','active'),(2,'L1','L1','active'),(3,'Student List','Student List','active'),(4,'Slides','Copy of Teaching Material','active'),(5,'Course Work','Assignments/Tutorials/Labs Related/Others','active'),(6,'Quizes and Mid-Term','Quizes/Mid-Term Exams papers with answer scheme','active'),(7,'Final Exam','Final Exam Papers with answer scheme','active'),(8,'Course work grades','Course work grades','active'),(9,'Grade Report','Grade sheet and statistical report','active'),(10,'Attendance Report','Attendance list and record of consultation with problematic students','active'),(11,'E-learning','A snapshot of e-learning/individual website for course management','active'),(12,'Questionaire','Course survey questionnaires and results','active'),(13,'Others teaching materials','Other materials related to teaching','active'),(14,'Course coordinator report','Course coordinator report','active'),(15,'Course Review Report','Course Review Report','active');
/*!40000 ALTER TABLE `upload_checklist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `username` varchar(30) NOT NULL,
  `password` varchar(255) NOT NULL,
  `usertype` varchar(20) NOT NULL,
  `viewPermission` varchar(255) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('admin','admin','root','PENTADBIR'),('irfan','irfan','lecturer','LECTURER'),('super','super','super','PENTADBIR');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `year_semester`
--

DROP TABLE IF EXISTS `year_semester`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `year_semester` (
  `semesterID` int(11) NOT NULL AUTO_INCREMENT,
  `year` varchar(10) NOT NULL,
  `semester` int(1) NOT NULL,
  PRIMARY KEY (`semesterID`),
  UNIQUE KEY `session` (`year`,`semester`),
  KEY `semester` (`semester`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `year_semester`
--

LOCK TABLES `year_semester` WRITE;
/*!40000 ALTER TABLE `year_semester` DISABLE KEYS */;
INSERT INTO `year_semester` VALUES (100,'20152016',1);
/*!40000 ALTER TABLE `year_semester` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-11-02 14:44:27
