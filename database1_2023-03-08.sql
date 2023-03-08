# ************************************************************
# Antares - SQL Client
# Version 0.7.6
# 
# https://antares-sql.app/
# https://github.com/antares-sql/antares
# 
# Host: 127.0.0.1 (MySQL Community Server - GPL 8.0.32)
# Database: database1
# Generation time: 2023-03-08T04:03:16-06:00
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
SET NAMES utf8mb4;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table branch
# ------------------------------------------------------------

DROP TABLE IF EXISTS `branch`;

CREATE TABLE `branch` (
  `branch_id` int NOT NULL,
  `branch_name` varchar(20) DEFAULT NULL,
  `mgr_id` int DEFAULT NULL,
  `mgr_start_date` date DEFAULT NULL,
  PRIMARY KEY (`branch_id`),
  KEY `mgr_id` (`mgr_id`),
  CONSTRAINT `branch_ibfk_1` FOREIGN KEY (`mgr_id`) REFERENCES `employee` (`emp_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `branch` WRITE;
/*!40000 ALTER TABLE `branch` DISABLE KEYS */;

INSERT INTO `branch` (`branch_id`, `branch_name`, `mgr_id`, `mgr_start_date`) VALUES
	(1, "Corporate", 100, "2006-02-09"),
	(2, "scranton", 102, "1992-04-06"),
	(3, "Stamford", 106, "1998-02-13");

/*!40000 ALTER TABLE `branch` ENABLE KEYS */;
UNLOCK TABLES;



# Dump of table branch_supplier
# ------------------------------------------------------------

DROP TABLE IF EXISTS `branch_supplier`;

CREATE TABLE `branch_supplier` (
  `branch_id` int NOT NULL,
  `supplier_name` varchar(20) NOT NULL,
  `supply_type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`branch_id`,`supplier_name`),
  CONSTRAINT `branch_supplier_ibfk_1` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `branch_supplier` WRITE;
/*!40000 ALTER TABLE `branch_supplier` DISABLE KEYS */;

INSERT INTO `branch_supplier` (`branch_id`, `supplier_name`, `supply_type`) VALUES
	(2, "Hammer Mill", "Paper"),
	(2, "J.T. Forms & Labels", "Custom Forms"),
	(2, "Uni-ball", "Writing Utensils"),
	(3, "Hammer Mill", "Paper"),
	(3, "Patriot Paper", "Paper"),
	(3, "Stamford Lables", "Custom Forms"),
	(3, "Uni-ball", "Writing Utensils");

/*!40000 ALTER TABLE `branch_supplier` ENABLE KEYS */;
UNLOCK TABLES;



# Dump of table client
# ------------------------------------------------------------

DROP TABLE IF EXISTS `client`;

CREATE TABLE `client` (
  `client_id` int NOT NULL,
  `client_name` varchar(30) DEFAULT NULL,
  `branch_id` int DEFAULT NULL,
  PRIMARY KEY (`client_id`),
  KEY `branch_id` (`branch_id`),
  CONSTRAINT `client_ibfk_1` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;

INSERT INTO `client` (`client_id`, `client_name`, `branch_id`) VALUES
	(400, "Dunmore Highschool", 2),
	(401, "Lackawana Country", 2),
	(402, "FedEx", 3),
	(403, "John Daly Law, LLC", 3),
	(404, "Scranton Whitepages", 2),
	(405, "Times Newspaper", 3),
	(406, "FedEx", 2);

/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;



# Dump of table employee
# ------------------------------------------------------------

DROP TABLE IF EXISTS `employee`;

CREATE TABLE `employee` (
  `emp_id` int NOT NULL,
  `firat_name` varchar(20) DEFAULT NULL,
  `last_name` varchar(20) DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `sex` varchar(1) DEFAULT NULL,
  `salary` int DEFAULT NULL,
  `super_id` int DEFAULT NULL,
  `branch_id` int DEFAULT NULL,
  PRIMARY KEY (`emp_id`),
  KEY `super_id` (`super_id`),
  KEY `branch_id` (`branch_id`),
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`super_id`) REFERENCES `employee` (`emp_id`) ON DELETE SET NULL,
  CONSTRAINT `employee_ibfk_2` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;

INSERT INTO `employee` (`emp_id`, `firat_name`, `last_name`, `birth_date`, `sex`, `salary`, `super_id`, `branch_id`) VALUES
	(100, "David", "Wallace", "1967-11-17", "M", 250000, NULL, 1),
	(101, "Jan", "Levinson", "1961-05-11", "F", 110000, 100, 1),
	(102, "Michael", "Scott", "1964-03-15", "M", 75000, 100, 2),
	(103, "Angela", "Martin", "1971-06-25", "F", 63000, 102, 2),
	(104, "Kelly", "Kapoor", "1980-02-05", "F", 55000, 102, 2),
	(105, "Stanley", "Hudson", "1958-02-19", "M", 69000, 102, 2),
	(106, "Josh", "Porter", "1969-09-05", "M", 78000, 100, 3),
	(107, "Andy", "Bernard", "1973-07-22", "M", 65000, 106, 3),
	(108, "Jim", "Halpert", "1978-10-01", "M", 71000, 106, 3);

/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;



# Dump of table works_with
# ------------------------------------------------------------

DROP TABLE IF EXISTS `works_with`;

CREATE TABLE `works_with` (
  `emp_id` int NOT NULL,
  `client_id` int NOT NULL,
  `total_sales` int DEFAULT NULL,
  PRIMARY KEY (`emp_id`,`client_id`),
  KEY `client_id` (`client_id`),
  CONSTRAINT `works_with_ibfk_1` FOREIGN KEY (`emp_id`) REFERENCES `employee` (`emp_id`) ON DELETE CASCADE,
  CONSTRAINT `works_with_ibfk_2` FOREIGN KEY (`client_id`) REFERENCES `client` (`client_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `works_with` WRITE;
/*!40000 ALTER TABLE `works_with` DISABLE KEYS */;

INSERT INTO `works_with` (`emp_id`, `client_id`, `total_sales`) VALUES
	(102, 401, 267000),
	(102, 406, 15000),
	(105, 400, 55000),
	(105, 404, 33000),
	(107, 403, 5000),
	(107, 405, 26000),
	(108, 402, 22500),
	(108, 403, 12000);

/*!40000 ALTER TABLE `works_with` ENABLE KEYS */;
UNLOCK TABLES;



# Dump of views
# ------------------------------------------------------------

# Creating temporary tables to overcome VIEW dependency errors


/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

# Dump completed on 2023-03-08T04:03:16-06:00
