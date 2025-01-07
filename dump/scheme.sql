Enter password: 
-- MySQL dump 10.13  Distrib 8.0.40, for Linux (x86_64)
--
-- Host: localhost    Database: speedpay
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `DT_ONE_OPERATORS`
--

DROP TABLE IF EXISTS `DT_ONE_OPERATORS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DT_ONE_OPERATORS` (
  `DT_OPERATOR_ID` int NOT NULL,
  `DT_OPERATOR_NAME` varchar(50) DEFAULT NULL,
  `OPERATOR_ID` int DEFAULT NULL,
  `OPERATOR_NAME` varchar(45) DEFAULT NULL,
  `STATUS` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`DT_OPERATOR_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `DT_ONE_PRODUCTS`
--

DROP TABLE IF EXISTS `DT_ONE_PRODUCTS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DT_ONE_PRODUCTS` (
  `PRODUCT_ID` bigint NOT NULL,
  `AVAILABILITY_ZONES` varchar(100) DEFAULT NULL,
  `DESCRIPTION` varchar(1000) DEFAULT NULL,
  `PRODUCT_NAME` varchar(500) DEFAULT NULL,
  `TYPE` varchar(100) DEFAULT NULL,
  `DESTINATION_AMOUNT` decimal(10,0) DEFAULT NULL,
  `DESTINATION_UNIT` varchar(50) DEFAULT NULL,
  `DESTINATION_UNIT_TYPE` varchar(50) DEFAULT NULL,
  `REQUIRED_ADDTNL_IDENTFR_FIELDS` varchar(255) DEFAULT NULL,
  `REQUIRED_BENEFICIARY_FIELDS` varchar(255) DEFAULT NULL,
  `REQUIRED_CREDIT_PARTY_IDENTFR` varchar(255) DEFAULT NULL,
  `REQUIRED_DEBIT_PARTY_IDENTFR` varchar(255) DEFAULT NULL,
  `REQUIRED_SENDER_FIELDS` varchar(255) DEFAULT NULL,
  `REQUIRED_STATEMENT_IDENTIFIER` varchar(255) DEFAULT NULL,
  `SERVICE_ID` decimal(10,0) DEFAULT NULL,
  `SERVICE_NAME` varchar(25) DEFAULT NULL,
  `SUBSERVICE_ID` decimal(10,0) DEFAULT NULL,
  `SUBSERVICE_NAME` varchar(25) DEFAULT NULL,
  `OPERATOR_ID` decimal(10,0) DEFAULT NULL,
  `OPERATOR_NAME` varchar(50) DEFAULT NULL,
  `VALIDITY_QUANTITY` decimal(10,0) DEFAULT NULL,
  `VALIDITY_UNIT` varchar(25) DEFAULT NULL,
  `TAGS` varchar(100) DEFAULT NULL,
  `BASE_RATE` decimal(10,0) DEFAULT NULL,
  `RETAIL_RATE` decimal(10,0) DEFAULT NULL,
  `WHOLESALE_RATE` decimal(10,0) DEFAULT NULL,
  `CREATED_DATE` timestamp NULL DEFAULT NULL,
  `CREATED_USER` varchar(255) DEFAULT NULL,
  `COUNTRY_CODE` varchar(50) DEFAULT NULL,
  `COUNTRY_NAME` varchar(50) DEFAULT NULL,
  `SOURCE_AMOUNT` decimal(10,0) DEFAULT NULL,
  `SOURCE_UNIT` varchar(10) DEFAULT NULL,
  `SOURCE_UNIT_TYPE` varchar(50) DEFAULT NULL,
  `DESTINATION_AMOUNT_MAX` decimal(10,0) DEFAULT NULL,
  `DESTINATION_AMOUNT_MIN` decimal(10,0) DEFAULT NULL,
  `INCREMENTS` decimal(10,0) DEFAULT NULL,
  `SOURCE_AMOUNT_MAX` decimal(10,0) DEFAULT NULL,
  `SOURCE_AMOUNT_MIN` decimal(10,0) DEFAULT NULL,
  `ACCEPTED_CALCULATION_MODES` varchar(500) DEFAULT NULL,
  `DESTINATION_INCREMENT` decimal(10,0) DEFAULT NULL,
  `PAYMENT_MODES` varchar(255) DEFAULT NULL,
  `PAYMENT_POSTING_QUANTITY` bigint DEFAULT NULL,
  `PAYMENT_POSTING_TYPE` varchar(255) DEFAULT NULL,
  `PAYMENT_POSTING_UNIT` varchar(255) DEFAULT NULL,
  `SUPPORTS_STATEMENT_INQUIRY` varchar(255) DEFAULT NULL,
  `SPEEDPAY_OPERATOR_ID` int DEFAULT '0',
  PRIMARY KEY (`PRODUCT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `DT_ONE_PRODUCTS_BACKUP`
--

DROP TABLE IF EXISTS `DT_ONE_PRODUCTS_BACKUP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DT_ONE_PRODUCTS_BACKUP` (
  `PRODUCT_ID` bigint NOT NULL,
  `AVAILABILITY_ZONES` varchar(100) DEFAULT NULL,
  `DESCRIPTION` varchar(1000) DEFAULT NULL,
  `PRODUCT_NAME` varchar(500) DEFAULT NULL,
  `TYPE` varchar(100) DEFAULT NULL,
  `DESTINATION_AMOUNT` decimal(10,0) DEFAULT NULL,
  `DESTINATION_UNIT` varchar(50) DEFAULT NULL,
  `DESTINATION_UNIT_TYPE` varchar(50) DEFAULT NULL,
  `REQUIRED_ADDTNL_IDENTFR_FIELDS` varchar(255) DEFAULT NULL,
  `REQUIRED_BENEFICIARY_FIELDS` varchar(255) DEFAULT NULL,
  `REQUIRED_CREDIT_PARTY_IDENTFR` varchar(255) DEFAULT NULL,
  `REQUIRED_DEBIT_PARTY_IDENTFR` varchar(255) DEFAULT NULL,
  `REQUIRED_SENDER_FIELDS` varchar(255) DEFAULT NULL,
  `REQUIRED_STATEMENT_IDENTIFIER` varchar(255) DEFAULT NULL,
  `SERVICE_ID` decimal(10,0) DEFAULT NULL,
  `SERVICE_NAME` varchar(25) DEFAULT NULL,
  `SUBSERVICE_ID` decimal(10,0) DEFAULT NULL,
  `SUBSERVICE_NAME` varchar(25) DEFAULT NULL,
  `OPERATOR_ID` decimal(10,0) DEFAULT NULL,
  `OPERATOR_NAME` varchar(50) DEFAULT NULL,
  `VALIDITY_QUANTITY` decimal(10,0) DEFAULT NULL,
  `VALIDITY_UNIT` varchar(25) DEFAULT NULL,
  `TAGS` varchar(100) DEFAULT NULL,
  `BASE_RATE` decimal(10,0) DEFAULT NULL,
  `RETAIL_RATE` decimal(10,0) DEFAULT NULL,
  `WHOLESALE_RATE` decimal(10,0) DEFAULT NULL,
  `CREATED_DATE` timestamp NULL DEFAULT NULL,
  `CREATED_USER` varchar(255) DEFAULT NULL,
  `COUNTRY_CODE` varchar(50) DEFAULT NULL,
  `COUNTRY_NAME` varchar(50) DEFAULT NULL,
  `SOURCE_AMOUNT` decimal(10,0) DEFAULT NULL,
  `SOURCE_UNIT` varchar(10) DEFAULT NULL,
  `SOURCE_UNIT_TYPE` varchar(50) DEFAULT NULL,
  `DESTINATION_AMOUNT_MAX` decimal(10,0) DEFAULT NULL,
  `DESTINATION_AMOUNT_MIN` decimal(10,0) DEFAULT NULL,
  `INCREMENTS` decimal(10,0) DEFAULT NULL,
  `SOURCE_AMOUNT_MAX` decimal(10,0) DEFAULT NULL,
  `SOURCE_AMOUNT_MIN` decimal(10,0) DEFAULT NULL,
  `ACCEPTED_CALCULATION_MODES` varchar(500) DEFAULT NULL,
  `DESTINATION_INCREMENT` decimal(10,0) DEFAULT NULL,
  `PAYMENT_MODES` varchar(255) DEFAULT NULL,
  `PAYMENT_POSTING_QUANTITY` bigint DEFAULT NULL,
  `PAYMENT_POSTING_TYPE` varchar(255) DEFAULT NULL,
  `PAYMENT_POSTING_UNIT` varchar(255) DEFAULT NULL,
  `SUPPORTS_STATEMENT_INQUIRY` varchar(255) DEFAULT NULL,
  `SPEEDPAY_OPERATOR_ID` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `DT_ONE_PRODUCTS_TEMP`
--

DROP TABLE IF EXISTS `DT_ONE_PRODUCTS_TEMP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DT_ONE_PRODUCTS_TEMP` (
  `PRODUCT_ID` bigint NOT NULL,
  `AVAILABILITY_ZONES` varchar(100) DEFAULT NULL,
  `DESCRIPTION` varchar(1000) DEFAULT NULL,
  `PRODUCT_NAME` varchar(500) DEFAULT NULL,
  `TYPE` varchar(100) DEFAULT NULL,
  `DESTINATION_AMOUNT` decimal(10,0) DEFAULT NULL,
  `DESTINATION_UNIT` varchar(50) DEFAULT NULL,
  `DESTINATION_UNIT_TYPE` varchar(50) DEFAULT NULL,
  `REQUIRED_ADDTNL_IDENTFR_FIELDS` varchar(255) DEFAULT NULL,
  `REQUIRED_BENEFICIARY_FIELDS` varchar(255) DEFAULT NULL,
  `REQUIRED_CREDIT_PARTY_IDENTFR` varchar(255) DEFAULT NULL,
  `REQUIRED_DEBIT_PARTY_IDENTFR` varchar(255) DEFAULT NULL,
  `REQUIRED_SENDER_FIELDS` varchar(255) DEFAULT NULL,
  `REQUIRED_STATEMENT_IDENTIFIER` varchar(255) DEFAULT NULL,
  `SERVICE_ID` decimal(10,0) DEFAULT NULL,
  `SERVICE_NAME` varchar(25) DEFAULT NULL,
  `SUBSERVICE_ID` decimal(10,0) DEFAULT NULL,
  `SUBSERVICE_NAME` varchar(25) DEFAULT NULL,
  `OPERATOR_ID` decimal(10,0) DEFAULT NULL,
  `OPERATOR_NAME` varchar(50) DEFAULT NULL,
  `VALIDITY_QUANTITY` decimal(10,0) DEFAULT NULL,
  `VALIDITY_UNIT` varchar(25) DEFAULT NULL,
  `TAGS` varchar(100) DEFAULT NULL,
  `BASE_RATE` decimal(10,0) DEFAULT NULL,
  `RETAIL_RATE` decimal(10,0) DEFAULT NULL,
  `WHOLESALE_RATE` decimal(10,0) DEFAULT NULL,
  `CREATED_DATE` timestamp(6) NULL DEFAULT NULL,
  `CREATED_USER` varchar(255) DEFAULT NULL,
  `COUNTRY_CODE` varchar(50) DEFAULT NULL,
  `COUNTRY_NAME` varchar(50) DEFAULT NULL,
  `SOURCE_AMOUNT` decimal(10,0) DEFAULT NULL,
  `SOURCE_UNIT` varchar(10) DEFAULT NULL,
  `SOURCE_UNIT_TYPE` varchar(50) DEFAULT NULL,
  `DESTINATION_AMOUNT_MAX` decimal(10,0) DEFAULT NULL,
  `DESTINATION_AMOUNT_MIN` decimal(10,0) DEFAULT NULL,
  `INCREMENTS` decimal(10,0) DEFAULT NULL,
  `SOURCE_AMOUNT_MAX` decimal(10,0) DEFAULT NULL,
  `SOURCE_AMOUNT_MIN` decimal(10,0) DEFAULT NULL,
  `ACCEPTED_CALCULATION_MODES` varchar(500) DEFAULT NULL,
  `DESTINATION_INCREMENT` decimal(10,0) DEFAULT NULL,
  `PAYMENT_MODES` varchar(255) DEFAULT NULL,
  `PAYMENT_POSTING_QUANTITY` bigint DEFAULT NULL,
  `PAYMENT_POSTING_TYPE` varchar(255) DEFAULT NULL,
  `PAYMENT_POSTING_UNIT` varchar(255) DEFAULT NULL,
  `SUPPORTS_STATEMENT_INQUIRY` varchar(255) DEFAULT NULL,
  `SPEEDPAY_OPERATOR_ID` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `WR_TBL_COUNTRY_DETAILS`
--

DROP TABLE IF EXISTS `WR_TBL_COUNTRY_DETAILS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `WR_TBL_COUNTRY_DETAILS` (
  `CODE` varchar(255) NOT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `SERVICE_CODE` varchar(255) DEFAULT NULL,
  `STATUSCODE` int DEFAULT NULL,
  `INSERTED_DATE` date DEFAULT NULL,
  `INSERTED_USER` varchar(255) DEFAULT NULL,
  `updated_Date` date DEFAULT NULL,
  `updated_User` varchar(255) DEFAULT NULL,
  `status` int DEFAULT NULL,
  PRIMARY KEY (`CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `WR_TBL_OPERATORS`
--

DROP TABLE IF EXISTS `WR_TBL_OPERATORS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `WR_TBL_OPERATORS` (
  `CODE` varchar(50) NOT NULL,
  `NAME` varchar(100) NOT NULL,
  `COUNTRY_CODE` varchar(50) NOT NULL,
  `SERVICE_CODE` varchar(50) NOT NULL,
  `INSERTED_DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `INSERTED_USER` varchar(50) NOT NULL DEFAULT 'API',
  `STATUS` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `WR_TBL_OPERATORS_MAPPING`
--

DROP TABLE IF EXISTS `WR_TBL_OPERATORS_MAPPING`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `WR_TBL_OPERATORS_MAPPING` (
  `sp_op_code` varchar(255) DEFAULT NULL,
  `sp_op_name` varchar(255) DEFAULT NULL,
  `wr_op_code` varchar(255) DEFAULT NULL,
  `wr_op_name` varchar(255) DEFAULT NULL,
  `status` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `WR_TBL_OPERATORS_MAPPING_BKP`
--

DROP TABLE IF EXISTS `WR_TBL_OPERATORS_MAPPING_BKP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `WR_TBL_OPERATORS_MAPPING_BKP` (
  `sp_op_code` varchar(255) DEFAULT NULL,
  `sp_op_name` varchar(255) DEFAULT NULL,
  `wr_op_code` varchar(255) DEFAULT NULL,
  `wr_op_name` varchar(255) DEFAULT NULL,
  `status` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `WR_TBL_PLANS`
--

DROP TABLE IF EXISTS `WR_TBL_PLANS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `WR_TBL_PLANS` (
  `PLAN_CODE` varchar(50) NOT NULL,
  `BENEFICIARY_AMOUNT` varchar(255) DEFAULT NULL,
  `COMMISSION` varchar(50) DEFAULT NULL,
  `COUNTRY_CODE` varchar(10) DEFAULT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `mrp` varchar(100) DEFAULT NULL,
  `OPERATOR_CODE` varchar(50) DEFAULT NULL,
  `OPERATOR_NAME` varchar(100) DEFAULT NULL,
  `SERVICE_CODE` varchar(50) DEFAULT NULL,
  `SURCHARGE` varchar(1000) DEFAULT NULL,
  `TITLE` varchar(255) DEFAULT NULL,
  `VALIDITY` varchar(1000) DEFAULT NULL,
  `INSERTED_DATE` datetime DEFAULT CURRENT_TIMESTAMP,
  `INSERTED_USER` varchar(50) DEFAULT 'API',
  `status` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `WR_TBL_PLANS_LIVE`
--

DROP TABLE IF EXISTS `WR_TBL_PLANS_LIVE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `WR_TBL_PLANS_LIVE` (
  `PLAN_CODE` varchar(50) NOT NULL,
  `BENEFICIARY_AMOUNT` varchar(255) DEFAULT NULL,
  `COMMISSION` varchar(50) DEFAULT NULL,
  `COUNTRY_CODE` varchar(10) DEFAULT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `mrp` varchar(100) DEFAULT NULL,
  `OPERATOR_CODE` varchar(50) DEFAULT NULL,
  `OPERATOR_NAME` varchar(100) DEFAULT NULL,
  `SERVICE_CODE` varchar(50) DEFAULT NULL,
  `SURCHARGE` varchar(1000) DEFAULT NULL,
  `TITLE` varchar(255) DEFAULT NULL,
  `VALIDITY` varchar(1000) DEFAULT NULL,
  `INSERTED_DATE` datetime DEFAULT CURRENT_TIMESTAMP,
  `INSERTED_USER` varchar(50) DEFAULT 'API',
  `status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`PLAN_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `WR_TBL_PLANS_LIVE_bkp`
--

DROP TABLE IF EXISTS `WR_TBL_PLANS_LIVE_bkp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `WR_TBL_PLANS_LIVE_bkp` (
  `PLAN_CODE` varchar(50) NOT NULL,
  `BENEFICIARY_AMOUNT` varchar(255) DEFAULT NULL,
  `COMMISSION` varchar(50) DEFAULT NULL,
  `COUNTRY_CODE` varchar(10) DEFAULT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `mrp` varchar(100) DEFAULT NULL,
  `OPERATOR_CODE` varchar(50) DEFAULT NULL,
  `OPERATOR_NAME` varchar(100) DEFAULT NULL,
  `SERVICE_CODE` varchar(50) DEFAULT NULL,
  `SURCHARGE` varchar(1000) DEFAULT NULL,
  `TITLE` varchar(255) DEFAULT NULL,
  `VALIDITY` varchar(1000) DEFAULT NULL,
  `INSERTED_DATE` datetime DEFAULT CURRENT_TIMESTAMP,
  `INSERTED_USER` varchar(50) DEFAULT 'API',
  `status` varchar(255) DEFAULT NULL,
  `sp_operator_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ser_tbl_operator_circle`
--

DROP TABLE IF EXISTS `ser_tbl_operator_circle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ser_tbl_operator_circle` (
  `circle_id` int NOT NULL AUTO_INCREMENT,
  `circle_name` varchar(255) DEFAULT NULL,
  `operator_id` int DEFAULT NULL,
  `status` int DEFAULT NULL,
  PRIMARY KEY (`circle_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_approval_tasks`
--

DROP TABLE IF EXISTS `tbl_approval_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_approval_tasks` (
  `approval_task_id` int NOT NULL AUTO_INCREMENT,
  `dest_channel_id` int DEFAULT NULL,
  `inserted_date` datetime DEFAULT NULL,
  `inserted_user` int DEFAULT NULL,
  `last_modified_date` datetime DEFAULT NULL,
  `last_modified_user` int DEFAULT NULL,
  `src_channel_id` int DEFAULT NULL,
  `status` int DEFAULT NULL,
  `task_type_id` int DEFAULT NULL,
  `txn_amount` double DEFAULT NULL,
  `txn_data_id` int DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `is_processed` int DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`approval_task_id`)
) ENGINE=InnoDB AUTO_INCREMENT=207 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_areas`
--

DROP TABLE IF EXISTS `tbl_areas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_areas` (
  `area_id` int NOT NULL,
  `area_name` varchar(255) DEFAULT NULL,
  `city_id` int DEFAULT NULL,
  PRIMARY KEY (`area_id`),
  KEY `FK7aqxog2iat8jfgchgx2vexxex` (`city_id`),
  CONSTRAINT `FK7aqxog2iat8jfgchgx2vexxex` FOREIGN KEY (`city_id`) REFERENCES `tbl_cities` (`city_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_channel`
--

DROP TABLE IF EXISTS `tbl_channel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_channel` (
  `channel_id` int NOT NULL AUTO_INCREMENT,
  `address` varchar(255) DEFAULT NULL,
  `area_id` int DEFAULT NULL,
  `ch_reference_id` int DEFAULT NULL,
  `channel_code` varchar(255) DEFAULT NULL,
  `channel_type` int DEFAULT NULL,
  `city_id` int DEFAULT NULL,
  `country_id` int DEFAULT NULL,
  `date_of_birth` datetime DEFAULT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `gender_id` int DEFAULT NULL,
  `inserted_date` datetime DEFAULT NULL,
  `inserted_user` int DEFAULT NULL,
  `langitude` double DEFAULT NULL,
  `last_modified_date` datetime DEFAULT NULL,
  `last_modified_user` int DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `level` int DEFAULT NULL,
  `mobile_number` varchar(255) DEFAULT NULL,
  `pincode` varchar(255) DEFAULT NULL,
  `region_id` int DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `status` int DEFAULT NULL,
  `profile_id` int DEFAULT NULL,
  `ch_level` int DEFAULT NULL,
  `password` varchar(200) DEFAULT NULL,
  `currency_id` int DEFAULT NULL,
  `currency_name` varchar(255) DEFAULT NULL,
  `country_name` varchar(255) DEFAULT NULL,
  `area_name` varchar(255) DEFAULT NULL,
  `city_name` varchar(255) DEFAULT NULL,
  `region_name` varchar(255) DEFAULT NULL,
  `profile_name` varchar(255) DEFAULT NULL,
  `ch_reference_code` varchar(255) DEFAULT NULL,
  `ch_reference_name` varchar(255) DEFAULT NULL,
  `commission` double DEFAULT NULL,
  `commission_type` int DEFAULT NULL,
  `commission_value` double DEFAULT NULL,
  `dob` varchar(255) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `sales_manager_id` int DEFAULT NULL,
  `imei` varchar(255) DEFAULT NULL,
  `serial_number` varchar(255) DEFAULT NULL,
  `sim_number` varchar(255) DEFAULT NULL,
  `calc_type` int DEFAULT NULL,
  `cat_id` int DEFAULT NULL,
  `client_name` varchar(255) DEFAULT NULL,
  `contact_person` varchar(255) DEFAULT NULL,
  `markup_value` double DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `currency_code` varchar(255) DEFAULT NULL,
  `status_desc` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`channel_id`),
  KEY `FKt1fgterrm84u16w1ym2p5ck3w` (`country_id`),
  KEY `FKp04jqlwalmlgvwx4n60era6em` (`currency_id`),
  CONSTRAINT `FKp04jqlwalmlgvwx4n60era6em` FOREIGN KEY (`currency_id`) REFERENCES `tbl_currencies` (`currency_id`),
  CONSTRAINT `FKt1fgterrm84u16w1ym2p5ck3w` FOREIGN KEY (`country_id`) REFERENCES `tbl_countries` (`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1006 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_channel_commissions`
--

DROP TABLE IF EXISTS `tbl_channel_commissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_channel_commissions` (
  `channel_operator_id` int NOT NULL AUTO_INCREMENT,
  `channel_id` int DEFAULT NULL,
  `cm_id` int DEFAULT NULL,
  `commission_type` int DEFAULT NULL,
  `commission_value` double DEFAULT NULL,
  `denomination_flag` int DEFAULT NULL,
  `denomination_max` double DEFAULT NULL,
  `denomination_min` double DEFAULT NULL,
  `first_level` double DEFAULT NULL,
  `inserted_date` datetime DEFAULT NULL,
  `inserted_user` int DEFAULT NULL,
  `last_modified_date` datetime DEFAULT NULL,
  `last_modified_user` int DEFAULT NULL,
  `operator_id` int DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `second_level` double DEFAULT NULL,
  `second_level_commission` double DEFAULT NULL,
  `status` int DEFAULT NULL,
  `third_level` double DEFAULT NULL,
  `third_level_commission` double DEFAULT NULL,
  `third_level_second` double DEFAULT NULL,
  `client_name` varchar(255) DEFAULT NULL,
  `operator_name` varchar(255) DEFAULT NULL,
  `channel_code` varchar(255) DEFAULT NULL,
  `operator_country` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`channel_operator_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11041 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_channel_wallet`
--

DROP TABLE IF EXISTS `tbl_channel_wallet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_channel_wallet` (
  `channel_id` int NOT NULL,
  `amount` double DEFAULT NULL,
  `inserted_date` datetime DEFAULT NULL,
  `inserted_user` int DEFAULT NULL,
  `last_modified_date` datetime DEFAULT NULL,
  `last_modified_user` int DEFAULT NULL,
  `status` int DEFAULT NULL,
  `currency_name` varchar(255) DEFAULT NULL,
  `currency_id` int DEFAULT NULL,
  `retailer_name` varchar(255) DEFAULT NULL,
  `amount_enc` varchar(255) DEFAULT NULL,
  `private_key` text,
  `public_key` text,
  `currency_code` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`channel_id`),
  KEY `FKmjt4dtwoie5lkkugh0httbxbp` (`currency_id`),
  CONSTRAINT `FKmjt4dtwoie5lkkugh0httbxbp` FOREIGN KEY (`currency_id`) REFERENCES `tbl_currencies` (`currency_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_channel_wallet_ledger`
--

DROP TABLE IF EXISTS `tbl_channel_wallet_ledger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_channel_wallet_ledger` (
  `channel_wallet_txn_id` bigint NOT NULL AUTO_INCREMENT,
  `channel_id` int DEFAULT NULL,
  `inserted_date` datetime DEFAULT NULL,
  `inserted_user` int DEFAULT NULL,
  `last_modified_date` datetime DEFAULT NULL,
  `last_modified_user` int DEFAULT NULL,
  `status` int DEFAULT NULL,
  `after_amount` double DEFAULT NULL,
  `before_amount` double DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `transection_id` bigint DEFAULT NULL,
  `txn_amount` double DEFAULT NULL,
  `txn_type` int DEFAULT NULL,
  `currency_name` varchar(255) DEFAULT NULL,
  `txn_type_name` varchar(255) DEFAULT NULL,
  `transection_time` varchar(255) DEFAULT NULL,
  `currency_id` int DEFAULT NULL,
  `invoice_no` varchar(255) DEFAULT NULL,
  `txn_process_type` int DEFAULT NULL,
  `txn_process_type_name` varchar(255) DEFAULT NULL,
  `invoice_from` int DEFAULT NULL,
  `invoice_to` int DEFAULT NULL,
  PRIMARY KEY (`channel_wallet_txn_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2359 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_channel_wallet_ledger_report`
--

DROP TABLE IF EXISTS `tbl_channel_wallet_ledger_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_channel_wallet_ledger_report` (
  `channel_wallet_txn_id` bigint NOT NULL,
  `after_amount` double DEFAULT NULL,
  `before_amount` double DEFAULT NULL,
  `channel_id` int DEFAULT NULL,
  `channel_name` varchar(255) DEFAULT NULL,
  `currency_id` int DEFAULT NULL,
  `currency_name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `inserted_date` datetime DEFAULT NULL,
  `inserted_user` int DEFAULT NULL,
  `invoice_from` int DEFAULT NULL,
  `invoice_no` varchar(255) DEFAULT NULL,
  `invoice_to` int DEFAULT NULL,
  `last_modified_date` datetime DEFAULT NULL,
  `last_modified_user` int DEFAULT NULL,
  `status` int DEFAULT NULL,
  `status_name` varchar(255) DEFAULT NULL,
  `transection_id` bigint DEFAULT NULL,
  `txn_amount` double DEFAULT NULL,
  `txn_process_type` int DEFAULT NULL,
  `txn_process_type_name` varchar(255) DEFAULT NULL,
  `txn_type` int DEFAULT NULL,
  `txn_type_name` varchar(255) DEFAULT NULL,
  `channel_msisdn` varchar(255) DEFAULT NULL,
  `txn_date_time` varchar(255) DEFAULT NULL,
  `invoice_link` varchar(255) DEFAULT NULL,
  `invoice_from_mobile` varchar(255) DEFAULT NULL,
  `invoice_from_name` varchar(255) DEFAULT NULL,
  `invoice_to_mobile` varchar(255) DEFAULT NULL,
  `invoice_to_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`channel_wallet_txn_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_circle`
--

DROP TABLE IF EXISTS `tbl_circle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_circle` (
  `circle_id` int NOT NULL AUTO_INCREMENT,
  `circle_code` varchar(255) DEFAULT NULL,
  `circle_name` varchar(255) DEFAULT NULL,
  `operator_id` int DEFAULT NULL,
  `status` int DEFAULT NULL,
  PRIMARY KEY (`circle_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_cities`
--

DROP TABLE IF EXISTS `tbl_cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_cities` (
  `city_id` int NOT NULL,
  `city_name` varchar(255) DEFAULT NULL,
  `region_id` int DEFAULT NULL,
  PRIMARY KEY (`city_id`),
  KEY `FKh0cxv5je1lygv6tcbt3cyvxsl` (`region_id`),
  CONSTRAINT `FKh0cxv5je1lygv6tcbt3cyvxsl` FOREIGN KEY (`region_id`) REFERENCES `tbl_regions` (`region_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_countries`
--

DROP TABLE IF EXISTS `tbl_countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_countries` (
  `country_id` int NOT NULL,
  `country_name` varchar(255) DEFAULT NULL,
  `country_code` varchar(45) DEFAULT NULL,
  `calling_code` varchar(45) DEFAULT NULL,
  `country_alpha_code3` varchar(45) DEFAULT NULL,
  `region` varchar(45) DEFAULT NULL,
  `flag_url` varchar(255) DEFAULT NULL,
  `num_maxlength` int DEFAULT NULL,
  `num_minlength` int DEFAULT NULL,
  `status` int DEFAULT NULL,
  `currency_id_temp` int DEFAULT NULL,
  PRIMARY KEY (`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_countries_bkp`
--

DROP TABLE IF EXISTS `tbl_countries_bkp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_countries_bkp` (
  `country_id` int NOT NULL,
  `country_name` varchar(255) DEFAULT NULL,
  `country_code` varchar(45) DEFAULT NULL,
  `calling_code` varchar(45) DEFAULT NULL,
  `country_alpha_code3` varchar(45) DEFAULT NULL,
  `region` varchar(45) DEFAULT NULL,
  `flag_url` varchar(255) DEFAULT NULL,
  `num_maxlength` int DEFAULT NULL,
  `num_minlength` int DEFAULT NULL,
  `status` int DEFAULT NULL,
  PRIMARY KEY (`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_currencies`
--

DROP TABLE IF EXISTS `tbl_currencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_currencies` (
  `currency_id` int NOT NULL,
  `currency_name` varchar(255) DEFAULT NULL,
  `currency_code` varchar(45) DEFAULT NULL,
  `country_id` int DEFAULT NULL,
  PRIMARY KEY (`currency_id`),
  KEY `FKnwuc9mhtexg67hqsfv09ao7u` (`country_id`),
  CONSTRAINT `FKnwuc9mhtexg67hqsfv09ao7u` FOREIGN KEY (`country_id`) REFERENCES `tbl_countries` (`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_currencies_bkp`
--

DROP TABLE IF EXISTS `tbl_currencies_bkp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_currencies_bkp` (
  `currency_id` int NOT NULL,
  `country_id` int DEFAULT NULL,
  `currency_name` varchar(255) DEFAULT NULL,
  `currency_code` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`currency_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_fetch_bill_info`
--

DROP TABLE IF EXISTS `tbl_fetch_bill_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_fetch_bill_info` (
  `bill_ref_id` bigint NOT NULL AUTO_INCREMENT,
  `account_name` varchar(255) DEFAULT NULL,
  `account_number` varchar(255) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `biller_error_code` varchar(255) DEFAULT NULL,
  `biller_message` varchar(255) DEFAULT NULL,
  `inserted_date` datetime DEFAULT NULL,
  `inserted_user` int DEFAULT NULL,
  `last_modified_date` datetime DEFAULT NULL,
  `last_modified_user` int DEFAULT NULL,
  `operator_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `response_code` varchar(255) DEFAULT NULL,
  `response_json` varchar(3000) DEFAULT NULL,
  `response_message` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `trid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`bill_ref_id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_forex`
--

DROP TABLE IF EXISTS `tbl_forex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_forex` (
  `forex_id` int NOT NULL AUTO_INCREMENT,
  `src_country_currency` int DEFAULT NULL,
  `dest_country_currency` int DEFAULT NULL,
  `conversion_rate` double DEFAULT NULL,
  `inserted_date` datetime DEFAULT NULL,
  `inserted_user` int DEFAULT NULL,
  `last_modified_date` datetime DEFAULT NULL,
  `last_modified_user` int DEFAULT NULL,
  `processing_type` int DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `status` int DEFAULT NULL,
  `dest_currency_name` varchar(255) DEFAULT NULL,
  `src_currency_name` varchar(255) DEFAULT NULL,
  `dest_currency_code` varchar(255) DEFAULT NULL,
  `src_currency_code` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`forex_id`),
  KEY `FKt1auwbisb4wfhl1i5v68bf54e` (`dest_country_currency`),
  KEY `FKkwesk53sxx1wthhgh8peu2xfr` (`src_country_currency`),
  CONSTRAINT `FKkwesk53sxx1wthhgh8peu2xfr` FOREIGN KEY (`src_country_currency`) REFERENCES `tbl_currencies` (`currency_id`),
  CONSTRAINT `FKt1auwbisb4wfhl1i5v68bf54e` FOREIGN KEY (`dest_country_currency`) REFERENCES `tbl_currencies` (`currency_id`)
) ENGINE=InnoDB AUTO_INCREMENT=918 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_markup`
--

DROP TABLE IF EXISTS `tbl_markup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_markup` (
  `markup_id` int NOT NULL AUTO_INCREMENT,
  `country_id` int DEFAULT NULL,
  `operator_id` int DEFAULT NULL,
  `markup_value` double DEFAULT NULL,
  `inserted_date` datetime DEFAULT NULL,
  `inserted_user` int DEFAULT NULL,
  `last_modified_date` datetime DEFAULT NULL,
  `last_modified_user` int DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `status` int DEFAULT NULL,
  `country_name` varchar(255) DEFAULT NULL,
  `operator_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`markup_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_number_series`
--

DROP TABLE IF EXISTS `tbl_number_series`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_number_series` (
  `number_series_id` int NOT NULL AUTO_INCREMENT,
  `operator_id` int DEFAULT NULL,
  `number_series` int DEFAULT NULL,
  `status` int DEFAULT NULL,
  PRIMARY KEY (`number_series_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9355 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_operator`
--

DROP TABLE IF EXISTS `tbl_operator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_operator` (
  `operator_id` int NOT NULL AUTO_INCREMENT,
  `country_id` int DEFAULT NULL,
  `operator_code` varchar(255) DEFAULT NULL,
  `operator_logo` varchar(255) DEFAULT NULL,
  `operator_name` varchar(255) DEFAULT NULL,
  `inserted_date` datetime DEFAULT NULL,
  `inserted_user` int DEFAULT NULL,
  `last_modified_date` datetime DEFAULT NULL,
  `last_modified_user` int DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `status` int NOT NULL DEFAULT '0',
  `currency_id` int DEFAULT NULL,
  `service_type_codes` varchar(100) DEFAULT NULL,
  `validation_regex` varchar(100) DEFAULT NULL,
  `operator_sync_code` varchar(255) DEFAULT NULL,
  `operator_sync_code2` varchar(255) DEFAULT NULL,
  `print_template_id` int DEFAULT NULL,
  `service_type_id` int DEFAULT NULL,
  `country_name` varchar(255) DEFAULT NULL,
  `currency_code` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`operator_id`),
  KEY `FKfiviloe5y16plapewl8kipe8l` (`country_id`),
  KEY `FKrev573iy2ix3ggeyv4nqe1xb8` (`currency_id`),
  CONSTRAINT `FKfiviloe5y16plapewl8kipe8l` FOREIGN KEY (`country_id`) REFERENCES `tbl_countries` (`country_id`),
  CONSTRAINT `FKrev573iy2ix3ggeyv4nqe1xb8` FOREIGN KEY (`currency_id`) REFERENCES `tbl_currencies` (`currency_id`)
) ENGINE=InnoDB AUTO_INCREMENT=584 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_operator_bkp`
--

DROP TABLE IF EXISTS `tbl_operator_bkp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_operator_bkp` (
  `operator_id` int NOT NULL DEFAULT '0',
  `country_id` int DEFAULT NULL,
  `operator_code` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `operator_logo` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `operator_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `inserted_date` datetime DEFAULT NULL,
  `inserted_user` int DEFAULT NULL,
  `last_modified_date` datetime DEFAULT NULL,
  `last_modified_user` int DEFAULT NULL,
  `remarks` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `status` int NOT NULL DEFAULT '0',
  `currency_id` int DEFAULT NULL,
  `service_type_codes` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `validation_regex` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `operator_sync_code` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `operator_sync_code2` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `print_template_id` int DEFAULT NULL,
  `service_type_id` int DEFAULT NULL,
  `country_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `currency_code` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_operator_services`
--

DROP TABLE IF EXISTS `tbl_operator_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_operator_services` (
  `operator_service_id` int NOT NULL AUTO_INCREMENT,
  `operator_id` int DEFAULT NULL,
  `operator_service_code` varchar(255) DEFAULT NULL,
  `operator_service_name` varchar(255) DEFAULT NULL,
  `service_type_id` int DEFAULT NULL,
  `status` int DEFAULT NULL,
  PRIMARY KEY (`operator_service_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_products`
--

DROP TABLE IF EXISTS `tbl_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_products` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `operator_id` int DEFAULT NULL,
  `price` double DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `service_type_id` int DEFAULT NULL,
  `validity` int DEFAULT NULL,
  `sync_provider_id` int DEFAULT NULL,
  `provider_product_code` varchar(45) DEFAULT NULL,
  `short_description` varchar(255) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `product_code` varchar(45) DEFAULT NULL,
  `service_type_temp` varchar(100) DEFAULT NULL,
  `receive_currency_name` varchar(255) DEFAULT NULL,
  `send_currency_name` varchar(255) DEFAULT NULL,
  `send_price` double DEFAULT NULL,
  `service_type_name` varchar(255) DEFAULT NULL,
  `inserted_date` datetime DEFAULT NULL,
  `inserted_user` int DEFAULT NULL,
  `last_modified_date` datetime DEFAULT NULL,
  `last_modified_user` int DEFAULT NULL,
  `status` int DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `validity_type_id` int DEFAULT NULL,
  `product_image` varchar(255) DEFAULT NULL,
  `voucher_template` varchar(255) DEFAULT NULL,
  `validity_desc` varchar(255) DEFAULT NULL,
  `benefits` varchar(255) DEFAULT NULL,
  `currency_name` varchar(255) DEFAULT NULL,
  `language_code` varchar(255) DEFAULT NULL,
  `language_id` int DEFAULT NULL,
  `max_price` double DEFAULT NULL,
  `max_send_price` double DEFAULT NULL,
  `more_description` varchar(1000) DEFAULT NULL,
  `op_param_1` varchar(255) DEFAULT NULL,
  `op_param_2` varchar(255) DEFAULT NULL,
  `op_param_3` varchar(255) DEFAULT NULL,
  `op_param_4` varchar(255) DEFAULT NULL,
  `op_param_5` varchar(255) DEFAULT NULL,
  `validity_period_iso` varchar(255) DEFAULT NULL,
  `benefit_codes` varchar(100) DEFAULT NULL,
  `currency_id` int DEFAULT NULL,
  `sp_currency_id` int DEFAULT NULL,
  `sp_max_price` double DEFAULT NULL,
  `sp_price` double DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  KEY `FKk9a28xuoe29r11x5oh4binr59` (`currency_id`),
  KEY `FKr10glwo9rq4s2lm7peixggtjk` (`operator_id`),
  KEY `FKjuurbjewsqf89phnrt9n3mr78` (`service_type_id`),
  KEY `FKonpfyffq9p4x23jdro8khu6tv` (`sp_currency_id`),
  CONSTRAINT `FKjuurbjewsqf89phnrt9n3mr78` FOREIGN KEY (`service_type_id`) REFERENCES `tbl_service_types` (`service_type_id`),
  CONSTRAINT `FKk9a28xuoe29r11x5oh4binr59` FOREIGN KEY (`currency_id`) REFERENCES `tbl_currencies` (`currency_id`),
  CONSTRAINT `FKonpfyffq9p4x23jdro8khu6tv` FOREIGN KEY (`sp_currency_id`) REFERENCES `tbl_currencies` (`currency_id`),
  CONSTRAINT `FKr10glwo9rq4s2lm7peixggtjk` FOREIGN KEY (`operator_id`) REFERENCES `tbl_operator` (`operator_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9964 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_products_ding_bkp`
--

DROP TABLE IF EXISTS `tbl_products_ding_bkp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_products_ding_bkp` (
  `product_id` int NOT NULL DEFAULT '0',
  `operator_id` int DEFAULT NULL,
  `price` double DEFAULT NULL,
  `product_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `service_type_id` int DEFAULT NULL,
  `validity` int DEFAULT NULL,
  `sync_provider_id` int DEFAULT NULL,
  `provider_product_code` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `short_description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `description` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `product_code` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `service_type_temp` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `receive_currency_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `send_currency_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `send_price` double DEFAULT NULL,
  `service_type_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `inserted_date` datetime DEFAULT NULL,
  `inserted_user` int DEFAULT NULL,
  `last_modified_date` datetime DEFAULT NULL,
  `last_modified_user` int DEFAULT NULL,
  `status` int DEFAULT NULL,
  `remarks` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `validity_type_id` int DEFAULT NULL,
  `product_image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `voucher_template` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `validity_desc` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `benefits` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `currency_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `language_code` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `language_id` int DEFAULT NULL,
  `max_price` double DEFAULT NULL,
  `max_send_price` double DEFAULT NULL,
  `more_description` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `op_param_1` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `op_param_2` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `op_param_3` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `op_param_4` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `op_param_5` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `validity_period_iso` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `benefit_codes` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `currency_id` int DEFAULT NULL,
  `sp_currency_id` int DEFAULT NULL,
  `sp_max_price` double DEFAULT NULL,
  `sp_price` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_recharges`
--

DROP TABLE IF EXISTS `tbl_recharges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_recharges` (
  `recharge_id` int NOT NULL AUTO_INCREMENT,
  `actual_price` double DEFAULT NULL,
  `bill_price` double DEFAULT NULL,
  `discount_price` double DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `offer_id` int DEFAULT NULL,
  `operator_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `recharge_time` datetime DEFAULT NULL,
  `service_type_id` int DEFAULT NULL,
  `session_id` varchar(255) DEFAULT NULL,
  `status` int DEFAULT NULL,
  `subscriber_number` varchar(255) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`recharge_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_regions`
--

DROP TABLE IF EXISTS `tbl_regions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_regions` (
  `region_id` int NOT NULL,
  `country_id` int DEFAULT NULL,
  `region_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`region_id`),
  KEY `FK2xinyjy6rbjbeojy1oxdpnskw` (`country_id`),
  CONSTRAINT `FK2xinyjy6rbjbeojy1oxdpnskw` FOREIGN KEY (`country_id`) REFERENCES `tbl_countries` (`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_role`
--

DROP TABLE IF EXISTS `tbl_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_role` (
  `role_id` int NOT NULL,
  `created_by` int DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `modified_by` int DEFAULT NULL,
  `modified_time` datetime DEFAULT NULL,
  `role_name` varchar(255) DEFAULT NULL,
  `status` int NOT NULL DEFAULT '0',
  `is_custom_role` int DEFAULT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_role_permission_map`
--

DROP TABLE IF EXISTS `tbl_role_permission_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_role_permission_map` (
  `role_permission_map_id` int NOT NULL AUTO_INCREMENT,
  `role_id` int DEFAULT NULL,
  `role_permission_id` int DEFAULT NULL,
  PRIMARY KEY (`role_permission_map_id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_role_permissions`
--

DROP TABLE IF EXISTS `tbl_role_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_role_permissions` (
  `role_permission_id` int NOT NULL,
  `role_permission_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`role_permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_sales_collection_ledger`
--

DROP TABLE IF EXISTS `tbl_sales_collection_ledger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_sales_collection_ledger` (
  `collection_txn_id` bigint NOT NULL AUTO_INCREMENT,
  `channel_id` int DEFAULT NULL,
  `currency_id` int DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `inserted_date` datetime DEFAULT NULL,
  `inserted_user` int DEFAULT NULL,
  `invoice_from` int DEFAULT NULL,
  `invoice_no` varchar(255) DEFAULT NULL,
  `invoice_to` int DEFAULT NULL,
  `last_modified_date` datetime DEFAULT NULL,
  `last_modified_user` int DEFAULT NULL,
  `sales_manager_id` int DEFAULT NULL,
  `status` int DEFAULT NULL,
  `txn_amount` double DEFAULT NULL,
  `txn_process_type` int DEFAULT NULL,
  `txn_type` int DEFAULT NULL,
  PRIMARY KEY (`collection_txn_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_service_provider`
--

DROP TABLE IF EXISTS `tbl_service_provider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_service_provider` (
  `service_provider_id` int NOT NULL AUTO_INCREMENT,
  `inserted_date` datetime DEFAULT NULL,
  `inserted_user` int DEFAULT NULL,
  `last_modified_date` datetime DEFAULT NULL,
  `last_modified_user` int DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `service_provider_code` varchar(255) DEFAULT NULL,
  `service_provider_name` varchar(255) DEFAULT NULL,
  `status` int DEFAULT NULL,
  `contact_person` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `country_id` int DEFAULT NULL,
  `currency_id` int DEFAULT NULL,
  `country_name` varchar(255) DEFAULT NULL,
  `currency_name` varchar(255) DEFAULT NULL,
  `interface_url` varchar(255) DEFAULT NULL,
  `currency_code` varchar(255) DEFAULT NULL,
  `integration_status` int DEFAULT NULL,
  `service_provider_website` varchar(255) DEFAULT NULL,
  `status_desc` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`service_provider_id`),
  KEY `FKemi2oxpgkfxrt0wx4jl4s4uph` (`country_id`),
  KEY `FKd3nhgidrl9n13b8fh9uagv6p6` (`currency_id`),
  CONSTRAINT `FKd3nhgidrl9n13b8fh9uagv6p6` FOREIGN KEY (`currency_id`) REFERENCES `tbl_currencies` (`currency_id`),
  CONSTRAINT `FKemi2oxpgkfxrt0wx4jl4s4uph` FOREIGN KEY (`country_id`) REFERENCES `tbl_countries` (`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_service_provider_wallet`
--

DROP TABLE IF EXISTS `tbl_service_provider_wallet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_service_provider_wallet` (
  `service_provider_id` int NOT NULL,
  `amount` double DEFAULT NULL,
  `inserted_date` datetime DEFAULT NULL,
  `inserted_user` int DEFAULT NULL,
  `last_modified_date` datetime DEFAULT NULL,
  `last_modified_user` int DEFAULT NULL,
  `status` int DEFAULT NULL,
  `currency_name` varchar(255) DEFAULT NULL,
  `currency_id` int DEFAULT NULL,
  `service_provider_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`service_provider_id`),
  KEY `FK9yk9el8j296gwgderc4js9yv5` (`currency_id`),
  CONSTRAINT `FK4u5fql9o2od496ixhc3kc8l3k` FOREIGN KEY (`service_provider_id`) REFERENCES `tbl_service_provider` (`service_provider_id`),
  CONSTRAINT `FK9yk9el8j296gwgderc4js9yv5` FOREIGN KEY (`currency_id`) REFERENCES `tbl_currencies` (`currency_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_service_provider_wallet_ledger`
--

DROP TABLE IF EXISTS `tbl_service_provider_wallet_ledger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_service_provider_wallet_ledger` (
  `sp_wallet_txn_id` bigint NOT NULL AUTO_INCREMENT,
  `inserted_date` datetime DEFAULT NULL,
  `inserted_user` int DEFAULT NULL,
  `last_modified_date` datetime DEFAULT NULL,
  `last_modified_user` int DEFAULT NULL,
  `service_provider_id` int DEFAULT NULL,
  `status` int DEFAULT NULL,
  `after_amount` double DEFAULT NULL,
  `before_amount` double DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `transection_id` bigint DEFAULT NULL,
  `txn_amount` double DEFAULT NULL,
  `txn_type` int DEFAULT NULL,
  `currency_name` varchar(255) DEFAULT NULL,
  `transection_time` varchar(255) DEFAULT NULL,
  `txn_type_name` varchar(255) DEFAULT NULL,
  `currency_id` int DEFAULT NULL,
  `txn_process_type` int DEFAULT NULL,
  `txn_process_type_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`sp_wallet_txn_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1240 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_service_provider_wallet_ledger_report`
--

DROP TABLE IF EXISTS `tbl_service_provider_wallet_ledger_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_service_provider_wallet_ledger_report` (
  `sp_wallet_txn_id` bigint NOT NULL AUTO_INCREMENT,
  `after_amount` double DEFAULT NULL,
  `before_amount` double DEFAULT NULL,
  `currency_id` int DEFAULT NULL,
  `currency_name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `inserted_date` datetime DEFAULT NULL,
  `inserted_user` int DEFAULT NULL,
  `last_modified_date` datetime DEFAULT NULL,
  `last_modified_user` int DEFAULT NULL,
  `service_provider_code` varchar(255) DEFAULT NULL,
  `service_provider_id` int DEFAULT NULL,
  `service_provider_name` varchar(255) DEFAULT NULL,
  `status` int DEFAULT NULL,
  `transection_id` bigint DEFAULT NULL,
  `transection_time` varchar(255) DEFAULT NULL,
  `txn_amount` double DEFAULT NULL,
  `txn_process_type` int DEFAULT NULL,
  `txn_process_type_name` varchar(255) DEFAULT NULL,
  `txn_type` int DEFAULT NULL,
  `txn_type_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`sp_wallet_txn_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_service_types`
--

DROP TABLE IF EXISTS `tbl_service_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_service_types` (
  `service_type_id` int NOT NULL,
  `service_type_name` varchar(255) DEFAULT NULL,
  `service_type_code` varchar(45) DEFAULT NULL,
  `inserted_date` datetime DEFAULT NULL,
  `inserted_user` int DEFAULT NULL,
  `last_modified_date` datetime DEFAULT NULL,
  `last_modified_user` int DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `status` int NOT NULL DEFAULT '0',
  `sync_code1` varchar(100) DEFAULT NULL,
  `sync_codes` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`service_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_siteinfo`
--

DROP TABLE IF EXISTS `tbl_siteinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_siteinfo` (
  `circle_id` int NOT NULL AUTO_INCREMENT,
  `circle_code` varchar(255) DEFAULT NULL,
  `circle_name` varchar(255) DEFAULT NULL,
  `operator_id` int DEFAULT NULL,
  `status` int DEFAULT NULL,
  PRIMARY KEY (`circle_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_sp_operators`
--

DROP TABLE IF EXISTS `tbl_sp_operators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_sp_operators` (
  `service_provider_operator_id` int NOT NULL AUTO_INCREMENT,
  `inserted_date` datetime DEFAULT NULL,
  `inserted_user` int DEFAULT NULL,
  `last_modified_date` datetime DEFAULT NULL,
  `last_modified_user` int DEFAULT NULL,
  `operator_id` int DEFAULT NULL,
  `priority` int DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `service_provider_id` int DEFAULT NULL,
  `status` int DEFAULT NULL,
  `operator_name` varchar(255) DEFAULT NULL,
  `service_provider_name` varchar(255) DEFAULT NULL,
  `status_desc` varchar(255) DEFAULT NULL,
  `service_charge` double DEFAULT NULL,
  `service_charge_type` int DEFAULT NULL,
  PRIMARY KEY (`service_provider_operator_id`),
  KEY `FK97fpn7xdsd7xf04hnf9au4lqo` (`operator_id`),
  KEY `FKhnol74krd574treh9aqjneilg` (`service_provider_id`),
  CONSTRAINT `FK97fpn7xdsd7xf04hnf9au4lqo` FOREIGN KEY (`operator_id`) REFERENCES `tbl_operator` (`operator_id`),
  CONSTRAINT `FKhnol74krd574treh9aqjneilg` FOREIGN KEY (`service_provider_id`) REFERENCES `tbl_service_provider` (`service_provider_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1295 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_sp_products`
--

DROP TABLE IF EXISTS `tbl_sp_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_sp_products` (
  `service_provider_product_id` bigint NOT NULL,
  `benefit_codes` varchar(255) DEFAULT NULL,
  `benefits` varchar(255) DEFAULT NULL,
  `currency_id` int DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `inserted_date` datetime DEFAULT NULL,
  `inserted_user` int DEFAULT NULL,
  `language_code` varchar(255) DEFAULT NULL,
  `language_id` int DEFAULT NULL,
  `last_modified_date` datetime DEFAULT NULL,
  `last_modified_user` int DEFAULT NULL,
  `max_price` double DEFAULT NULL,
  `more_description` varchar(255) DEFAULT NULL,
  `op_param_1` varchar(255) DEFAULT NULL,
  `op_param_2` varchar(255) DEFAULT NULL,
  `op_param_3` varchar(255) DEFAULT NULL,
  `op_param_4` varchar(255) DEFAULT NULL,
  `op_param_5` varchar(255) DEFAULT NULL,
  `operator_id` int DEFAULT NULL,
  `price` double DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `product_image` varchar(255) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `service_provider_id` int DEFAULT NULL,
  `service_type_id` int DEFAULT NULL,
  `short_description` varchar(255) DEFAULT NULL,
  `sp_currency_id` int DEFAULT NULL,
  `sp_fetch_code` varchar(255) DEFAULT NULL,
  `sp_max_price` double DEFAULT NULL,
  `sp_price` double DEFAULT NULL,
  `sp_product_code` varchar(255) DEFAULT NULL,
  `status` int DEFAULT NULL,
  `validity` int DEFAULT NULL,
  `validity_desc` varchar(255) DEFAULT NULL,
  `validity_period_iso` varchar(255) DEFAULT NULL,
  `validity_type_id` int DEFAULT NULL,
  `voucher_template` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`service_provider_product_id`),
  KEY `FK9aewopgrweve8n3c9pghwiwso` (`operator_id`),
  CONSTRAINT `FK9aewopgrweve8n3c9pghwiwso` FOREIGN KEY (`operator_id`) REFERENCES `tbl_operator` (`operator_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_transactions`
--

DROP TABLE IF EXISTS `tbl_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_transactions` (
  `channel_id` int DEFAULT NULL,
  `commission_value` double DEFAULT NULL,
  `inserted_user` int DEFAULT NULL,
  `last_modified_date` datetime DEFAULT NULL,
  `last_modified_user` int DEFAULT NULL,
  `operator_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `profit` double DEFAULT NULL,
  `provider_price` double DEFAULT NULL,
  `receive_price` double DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `send_price` double DEFAULT NULL,
  `service_provider_id` int DEFAULT NULL,
  `service_provider_product_id` varchar(255) DEFAULT NULL,
  `status` int DEFAULT NULL,
  `validity` int DEFAULT NULL,
  `msisdn` varchar(255) DEFAULT NULL,
  `client_tid` varchar(45) DEFAULT NULL,
  `inserted_date` datetime DEFAULT NULL,
  `provider_currency_id` int DEFAULT NULL,
  `channel_after_amount` double DEFAULT NULL,
  `channel_before_amount` double DEFAULT NULL,
  `channel_wallet_txn_id` bigint DEFAULT NULL,
  `sp_after_amount` double DEFAULT NULL,
  `sp_before_amount` double DEFAULT NULL,
  `sp_wallet_txn_id` bigint DEFAULT NULL,
  `channel_currency_id` int DEFAULT NULL,
  `channel_price` double DEFAULT NULL,
  `product_currency_id` int DEFAULT NULL,
  `product_price` double DEFAULT NULL,
  `sp_req_tid` varchar(255) DEFAULT NULL,
  `sp_resp_tid` varchar(255) DEFAULT NULL,
  `sp_status` varchar(255) DEFAULT NULL,
  `channel_name` varchar(255) DEFAULT NULL,
  `operation` varchar(255) DEFAULT NULL,
  `operator_name` varchar(255) DEFAULT NULL,
  `service_provider_name` varchar(255) DEFAULT NULL,
  `adjust_amount` double DEFAULT NULL,
  `print_template` varchar(2000) DEFAULT NULL,
  `voucher_expiry_date` datetime DEFAULT NULL,
  `voucher_pin` varchar(255) DEFAULT NULL,
  `voucher_serial_number` varchar(255) DEFAULT NULL,
  `transaction_id` bigint NOT NULL AUTO_INCREMENT,
  `service_type_id` int DEFAULT NULL,
  `service_type_name` varchar(255) DEFAULT NULL,
  `account_number` varchar(255) DEFAULT NULL,
  `bill_amount` double DEFAULT NULL,
  `bill_ref_id` bigint DEFAULT NULL,
  PRIMARY KEY (`transaction_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1101050 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_transactions_report`
--

DROP TABLE IF EXISTS `tbl_transactions_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_transactions_report` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `channel_after_amount` double DEFAULT NULL,
  `channel_before_amount` double DEFAULT NULL,
  `channel_currency_id` int DEFAULT NULL,
  `channel_currency_name` varchar(255) DEFAULT NULL,
  `channel_id` int DEFAULT NULL,
  `channel_name` varchar(255) DEFAULT NULL,
  `channel_price` double DEFAULT NULL,
  `channel_wallet_txn_id` bigint DEFAULT NULL,
  `client_tid` varchar(255) DEFAULT NULL,
  `commission_value` double DEFAULT NULL,
  `device_id` varchar(255) DEFAULT NULL,
  `inserted_date` datetime DEFAULT NULL,
  `inserted_user` int DEFAULT NULL,
  `last_modified_date` datetime DEFAULT NULL,
  `last_modified_user` int DEFAULT NULL,
  `msisdn` varchar(255) DEFAULT NULL,
  `operation` varchar(255) DEFAULT NULL,
  `operator_id` int DEFAULT NULL,
  `operator_name` varchar(255) DEFAULT NULL,
  `product_currency_id` int DEFAULT NULL,
  `product_currency_name` varchar(255) DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `product_price` double DEFAULT NULL,
  `profit` double DEFAULT NULL,
  `provider_currency_id` int DEFAULT NULL,
  `provider_currency_name` varchar(255) DEFAULT NULL,
  `provider_price` double DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `service_provider_id` int DEFAULT NULL,
  `service_provider_name` varchar(255) DEFAULT NULL,
  `service_provider_product_id` varchar(255) DEFAULT NULL,
  `sp_after_amount` double DEFAULT NULL,
  `sp_before_amount` double DEFAULT NULL,
  `sp_wallet_txn_id` bigint DEFAULT NULL,
  `status` int DEFAULT NULL,
  `status_description` varchar(255) DEFAULT NULL,
  `transaction_id` bigint DEFAULT NULL,
  `txn_date_time` varchar(255) DEFAULT NULL,
  `txn_process_type` int DEFAULT NULL,
  `txn_process_type_name` varchar(255) DEFAULT NULL,
  `txn_type` int DEFAULT NULL,
  `txn_type_name` varchar(255) DEFAULT NULL,
  `validity` int DEFAULT NULL,
  `sp_req_tid` varchar(255) DEFAULT NULL,
  `sp_resp_tid` varchar(255) DEFAULT NULL,
  `sp_status` varchar(255) DEFAULT NULL,
  `print_template` varchar(2000) DEFAULT NULL,
  `voucher_expiry_date` datetime DEFAULT NULL,
  `voucher_pin` varchar(255) DEFAULT NULL,
  `voucher_serial_number` varchar(255) DEFAULT NULL,
  `channel_msisdn` varchar(255) DEFAULT NULL,
  `service_type_id` int DEFAULT NULL,
  `service_type_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2225 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_user`
--

DROP TABLE IF EXISTS `tbl_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `login_id` varchar(255) DEFAULT NULL,
  `mobile_number` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `channel_id` int DEFAULT NULL,
  `otp` int DEFAULT NULL,
  `mpin` varchar(255) DEFAULT NULL,
  `role_id` int DEFAULT NULL,
  `api_user` int DEFAULT NULL,
  `status` int DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1006 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_validity_master`
--

DROP TABLE IF EXISTS `tbl_validity_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_validity_master` (
  `validity_type_id` int NOT NULL,
  `validity_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`validity_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_voucher_pin`
--

DROP TABLE IF EXISTS `tbl_voucher_pin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_voucher_pin` (
  `voucher_pin_id` int NOT NULL AUTO_INCREMENT,
  `barcode` varchar(255) DEFAULT NULL,
  `expiry_date` datetime DEFAULT NULL,
  `inserted_date` datetime DEFAULT NULL,
  `inserted_user` int DEFAULT NULL,
  `last_modified_date` datetime DEFAULT NULL,
  `last_modified_user` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `status` int DEFAULT NULL,
  `used_status` int DEFAULT NULL,
  `voucher_pin` varchar(255) DEFAULT NULL,
  `voucher_serial_no` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`voucher_pin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temp1`
--

DROP TABLE IF EXISTS `temp1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `temp1` (
  `operator_id` int DEFAULT NULL,
  `currency_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wr_country`
--

DROP TABLE IF EXISTS `wr_country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wr_country` (
  `wr_country_code` varchar(255) DEFAULT NULL,
  `wr_country_name` varchar(255) DEFAULT NULL,
  `country_code` varchar(255) DEFAULT NULL,
  `country_name` varchar(255) DEFAULT NULL,
  `id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `zz_tbl_countries`
--

DROP TABLE IF EXISTS `zz_tbl_countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_tbl_countries` (
  `country_id` int NOT NULL AUTO_INCREMENT,
  `calling_code` varchar(255) DEFAULT NULL,
  `country_alpha_code3` varchar(255) DEFAULT NULL,
  `country_currency` varchar(255) DEFAULT NULL,
  `country_iso` varchar(255) DEFAULT NULL,
  `country_name` varchar(255) DEFAULT NULL,
  `number_man_length` int DEFAULT NULL,
  `number_min_length` int DEFAULT NULL,
  `region` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=235 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `zz_tbl_currencies`
--

DROP TABLE IF EXISTS `zz_tbl_currencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_tbl_currencies` (
  `currency_id` int NOT NULL AUTO_INCREMENT,
  `currency_iso` varchar(255) DEFAULT NULL,
  `currency_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`currency_id`)
) ENGINE=InnoDB AUTO_INCREMENT=157 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `zz_tbl_operators`
--

DROP TABLE IF EXISTS `zz_tbl_operators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_tbl_operators` (
  `operator_id` int NOT NULL AUTO_INCREMENT,
  `validation_regex` varchar(255) DEFAULT NULL,
  `country_id` int DEFAULT NULL,
  `country_iso` varchar(255) DEFAULT NULL,
  `operator_code` varchar(255) DEFAULT NULL,
  `operator_logo` varchar(255) DEFAULT NULL,
  `operator_name` varchar(255) DEFAULT NULL,
  `service_type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`operator_id`)
) ENGINE=InnoDB AUTO_INCREMENT=584 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `zz_tbl_products`
--

DROP TABLE IF EXISTS `zz_tbl_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zz_tbl_products` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `benefits` varchar(255) DEFAULT NULL,
  `currency_id` int DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `language_code` varchar(255) DEFAULT NULL,
  `language_id` int DEFAULT NULL,
  `max_price` double DEFAULT NULL,
  `more_description` varchar(1000) DEFAULT NULL,
  `op_param_1` varchar(255) DEFAULT NULL,
  `op_param_2` varchar(255) DEFAULT NULL,
  `op_param_3` varchar(255) DEFAULT NULL,
  `op_param_4` varchar(255) DEFAULT NULL,
  `op_param_5` varchar(255) DEFAULT NULL,
  `operator_id` int DEFAULT NULL,
  `price` double DEFAULT NULL,
  `product_code` varchar(255) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `service_type` varchar(255) DEFAULT NULL,
  `short_description` varchar(255) DEFAULT NULL,
  `sp_currency_id` int DEFAULT NULL,
  `sp_max_price` double DEFAULT NULL,
  `sp_price` double DEFAULT NULL,
  `validity` int DEFAULT NULL,
  `validity_period_iso` varchar(255) DEFAULT NULL,
  `validity_type_id` int DEFAULT NULL,
  `service_type_id` int DEFAULT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3662 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-01-02  5:21:06
