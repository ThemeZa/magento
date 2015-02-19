-- MySQL dump 10.13  Distrib 5.5.41, for Win32 (x86)
--
-- Host: localhost    Database: mag_db
-- ------------------------------------------------------
-- Server version	5.5.41-log

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
-- Table structure for table `mag_admin_assert`
--

DROP TABLE IF EXISTS `mag_admin_assert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_admin_assert` (
  `assert_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Assert ID',
  `assert_type` varchar(20) DEFAULT NULL COMMENT 'Assert Type',
  `assert_data` text COMMENT 'Assert Data',
  PRIMARY KEY (`assert_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Admin Assert Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_admin_assert`
--

LOCK TABLES `mag_admin_assert` WRITE;
/*!40000 ALTER TABLE `mag_admin_assert` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_admin_assert` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_admin_role`
--

DROP TABLE IF EXISTS `mag_admin_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_admin_role` (
  `role_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Role ID',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Parent Role ID',
  `tree_level` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Role Tree Level',
  `sort_order` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Role Sort Order',
  `role_type` varchar(1) NOT NULL DEFAULT '0' COMMENT 'Role Type',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'User ID',
  `role_name` varchar(50) DEFAULT NULL COMMENT 'Role Name',
  PRIMARY KEY (`role_id`),
  KEY `IDX_MAG_ADMIN_ROLE_PARENT_ID_SORT_ORDER` (`parent_id`,`sort_order`),
  KEY `IDX_MAG_ADMIN_ROLE_TREE_LEVEL` (`tree_level`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Admin Role Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_admin_role`
--

LOCK TABLES `mag_admin_role` WRITE;
/*!40000 ALTER TABLE `mag_admin_role` DISABLE KEYS */;
INSERT INTO `mag_admin_role` VALUES (1,0,1,1,'G',0,'Administrators'),(2,1,2,0,'U',1,'Vasya');
/*!40000 ALTER TABLE `mag_admin_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_admin_rule`
--

DROP TABLE IF EXISTS `mag_admin_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_admin_rule` (
  `rule_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rule ID',
  `role_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Role ID',
  `resource_id` varchar(255) DEFAULT NULL COMMENT 'Resource ID',
  `privileges` varchar(20) DEFAULT NULL COMMENT 'Privileges',
  `assert_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Assert ID',
  `role_type` varchar(1) DEFAULT NULL COMMENT 'Role Type',
  `permission` varchar(10) DEFAULT NULL COMMENT 'Permission',
  PRIMARY KEY (`rule_id`),
  KEY `IDX_MAG_ADMIN_RULE_RESOURCE_ID_ROLE_ID` (`resource_id`,`role_id`),
  KEY `IDX_MAG_ADMIN_RULE_ROLE_ID_RESOURCE_ID` (`role_id`,`resource_id`),
  CONSTRAINT `FK_MAG_ADMIN_RULE_ROLE_ID_MAG_ADMIN_ROLE_ROLE_ID` FOREIGN KEY (`role_id`) REFERENCES `mag_admin_role` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Admin Rule Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_admin_rule`
--

LOCK TABLES `mag_admin_rule` WRITE;
/*!40000 ALTER TABLE `mag_admin_rule` DISABLE KEYS */;
INSERT INTO `mag_admin_rule` VALUES (1,1,'all',NULL,0,'G','allow');
/*!40000 ALTER TABLE `mag_admin_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_admin_user`
--

DROP TABLE IF EXISTS `mag_admin_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_admin_user` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'User ID',
  `firstname` varchar(32) DEFAULT NULL COMMENT 'User First Name',
  `lastname` varchar(32) DEFAULT NULL COMMENT 'User Last Name',
  `email` varchar(128) DEFAULT NULL COMMENT 'User Email',
  `username` varchar(40) DEFAULT NULL COMMENT 'User Login',
  `password` varchar(100) DEFAULT NULL COMMENT 'User Password',
  `created` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'User Created Time',
  `modified` timestamp NULL DEFAULT NULL COMMENT 'User Modified Time',
  `logdate` timestamp NULL DEFAULT NULL COMMENT 'User Last Login Time',
  `lognum` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'User Login Number',
  `reload_acl_flag` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Reload ACL',
  `is_active` smallint(6) NOT NULL DEFAULT '1' COMMENT 'User Is Active',
  `extra` text COMMENT 'User Extra Data',
  `rp_token` text COMMENT 'Reset Password Link Token',
  `rp_token_created_at` timestamp NULL DEFAULT NULL COMMENT 'Reset Password Link Token Creation Date',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `UNQ_MAG_ADMIN_USER_USERNAME` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Admin User Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_admin_user`
--

LOCK TABLES `mag_admin_user` WRITE;
/*!40000 ALTER TABLE `mag_admin_user` DISABLE KEYS */;
INSERT INTO `mag_admin_user` VALUES (1,'Vasya','Morarash','squirtle479@gmail.com','admin','998fca6c95103e4a4ac38f72c435e600:m6SbBevjpLo61HHjACqCHdNoTb00Dvde','2015-02-19 08:10:22','2015-02-19 08:10:22','2015-02-19 09:21:35',4,0,1,'a:1:{s:11:\"configState\";a:8:{s:14:\"design_package\";s:1:\"1\";s:12:\"design_theme\";s:1:\"1\";s:11:\"design_head\";s:1:\"0\";s:13:\"design_header\";s:1:\"0\";s:13:\"design_footer\";s:1:\"0\";s:16:\"design_watermark\";s:1:\"0\";s:17:\"design_pagination\";s:1:\"0\";s:12:\"design_email\";s:1:\"0\";}}',NULL,NULL);
/*!40000 ALTER TABLE `mag_admin_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_adminnotification_inbox`
--

DROP TABLE IF EXISTS `mag_adminnotification_inbox`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_adminnotification_inbox` (
  `notification_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Notification id',
  `severity` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Problem type',
  `date_added` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Create date',
  `title` varchar(255) NOT NULL COMMENT 'Title',
  `description` text COMMENT 'Description',
  `url` varchar(255) DEFAULT NULL COMMENT 'Url',
  `is_read` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Flag if notification read',
  `is_remove` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Flag if notification might be removed',
  PRIMARY KEY (`notification_id`),
  KEY `IDX_MAG_ADMINNOTIFICATION_INBOX_SEVERITY` (`severity`),
  KEY `IDX_MAG_ADMINNOTIFICATION_INBOX_IS_READ` (`is_read`),
  KEY `IDX_MAG_ADMINNOTIFICATION_INBOX_IS_REMOVE` (`is_remove`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8 COMMENT='Adminnotification Inbox';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_adminnotification_inbox`
--

LOCK TABLES `mag_adminnotification_inbox` WRITE;
/*!40000 ALTER TABLE `mag_adminnotification_inbox` DISABLE KEYS */;
INSERT INTO `mag_adminnotification_inbox` VALUES (1,4,'2008-07-25 02:24:40','Magento 1.1 Production Version Now Available','We are thrilled to announce the availability of the production release of Magento 1.1. Read more about the release in the Magento Blog.','http://www.magentocommerce.com/blog/comments/magento-11-is-here-1/',0,0),(2,4,'2008-08-02 02:30:16','Updated iPhone Theme is now available','Updated iPhone theme for Magento 1.1 is now available on Magento Connect and for upgrade through your Magento Connect Manager.','http://www.magentocommerce.com/blog/comments/updated-iphone-theme-for-magento-11-is-now-available/',0,0),(3,3,'2008-08-02 02:40:27','Magento version 1.1.2 is now available','Magento version 1.1.2 is now available for download and upgrade.','http://www.magentocommerce.com/blog/comments/magento-version-112-is-now-available/',0,0),(4,3,'2008-08-13 18:51:46','Magento version 1.1.3 is now available','Magento version 1.1.3 is now available','http://www.magentocommerce.com/blog/comments/magento-version-113-is-now-available/',0,0),(5,1,'2008-09-02 22:10:31','Magento Version 1.1.4 Security Update Now Available','Magento 1.1.4 Security Update Now Available. If you are using Magento version 1.1.x, we highly recommend upgrading to this version as soon as possible.','http://www.magentocommerce.com/blog/comments/magento-version-114-security-update/',0,0),(6,3,'2008-09-15 23:09:54','Magento version 1.1.5 Now Available','Magento version 1.1.5 Now Available.\n\nThis release includes many bug fixes, a new category manager and a new skin for the default Magento theme.','http://www.magentocommerce.com/blog/comments/magento-version-115-now-available/',0,0),(7,3,'2008-09-17 21:18:35','Magento version 1.1.6 Now Available','Magento version 1.1.6 Now Available.\n\nThis version includes bug fixes for Magento 1.1.x that are listed in the release notes section.','http://www.magentocommerce.com/blog/comments/magento-version-116-now-available/',0,0),(8,4,'2008-11-08 02:46:42','Reminder: Change Magento`s default phone numbers and callouts before site launch','Before launching your Magento store, please remember to change Magento`s default phone numbers that appear in email templates, callouts, templates, etc.','',0,0),(9,3,'2008-11-20 04:31:12','Magento version 1.1.7 Now Available','Magento version 1.1.7 Now Available.\n\nThis version includes over 350 issue resolutions for Magento 1.1.x that are listed in the release notes section, and new functionality that includes:\n\n-Google Website Optimizer integration\n-Google Base integration\n-Scheduled DB logs cleaning option','http://www.magentocommerce.com/blog/comments/magento-version-117-now-available/',0,0),(10,3,'2008-11-27 00:24:50','Magento Version 1.1.8 Now Available','Magento version 1.1.8 now available.\n\nThis version includes some issue resolutions for Magento 1.1.x that are listed in the release notes section.','http://www.magentocommerce.com/blog/comments/magento-version-118-now-available/',0,0),(11,3,'2008-12-30 10:45:59','Magento version 1.2.0 is now available for download and upgrade','We are extremely happy to announce the availability of Magento version 1.2.0 for download and upgrade.\n\nThis version includes numerous issue resolutions for Magento version 1.1.x and some highly requested new features such as:\n\n    * Support for Downloadable/Digital Products. \n    * Added Layered Navigation to site search result page.\n    * Improved site search to utilize MySQL fulltext search\n    * Added support for fixed-taxes on product level.\n    * Upgraded Zend Framework to the latest stable version 1.7.2','http://www.magentocommerce.com/blog/comments/magento-version-120-is-now-available/',0,0),(12,2,'2008-12-31 00:59:22','Magento version 1.2.0.1 now available','Magento version 1.2.0.1 now available.This version includes some issue resolutions for Magento 1.2.x that are listed in the release notes section.','http://www.magentocommerce.com/blog/comments/magento-version-1201-available/',0,0),(13,2,'2009-01-12 23:41:49','Magento version 1.2.0.2 now available','Magento version 1.2.0.2 is now available for download and upgrade. This version includes an issue resolutions for Magento version 1.2.0.x as listed in the release notes.','http://www.magentocommerce.com/blog/comments/magento-version-1202-now-available/',0,0),(14,3,'2009-01-24 03:25:56','Magento version 1.2.0.3 now available','Magento version 1.2.0.3 is now available for download and upgrade. This version includes issue resolutions for Magento version 1.2.0.x as listed in the release notes.','http://www.magentocommerce.com/blog/comments/magento-version-1203-now-available/',0,0),(15,3,'2009-02-03 00:57:00','Magento version 1.2.1 is now available for download and upgrade','We are happy to announce the availability of Magento version 1.2.1 for download and upgrade.\n\nThis version includes some issue resolutions for Magento version 1.2.x. A full list of items included in this release can be found on the release notes page.','http://www.magentocommerce.com/blog/comments/magento-version-121-now-available/',0,0),(16,3,'2009-02-24 03:45:47','Magento version 1.2.1.1 now available','Magento version 1.2.1.1 now available.This version includes some issue resolutions for Magento 1.2.x that are listed in the release notes section.','http://www.magentocommerce.com/blog/comments/magento-version-1211-now-available/',0,0),(17,3,'2009-02-27 04:39:24','CSRF Attack Prevention','We have just posted a blog entry about a hypothetical CSRF attack on a Magento admin panel. Please read the post to find out if your Magento installation is at risk at http://www.magentocommerce.com/blog/comments/csrf-vulnerabilities-in-web-application-and-how-to-avoid-them-in-magento/','http://www.magentocommerce.com/blog/comments/csrf-vulnerabilities-in-web-application-and-how-to-avoid-them-in-magento/',0,0),(18,2,'2009-03-04 02:03:58','Magento version 1.2.1.2 now available','Magento version 1.2.1.2 is now available for download and upgrade.\nThis version includes some updates to improve admin security as described in the release notes page.','http://www.magentocommerce.com/blog/comments/magento-version-1212-now-available/',0,0),(19,3,'2009-03-31 03:22:40','Magento version 1.3.0 now available','Magento version 1.3.0 is now available for download and upgrade. This version includes numerous issue resolutions for Magento version 1.2.x and new features as described on the release notes page.','http://www.magentocommerce.com/blog/comments/magento-version-130-is-now-available/',0,0),(20,3,'2009-04-18 05:06:02','Magento version 1.3.1 now available','Magento version 1.3.1 is now available for download and upgrade. This version includes some issue resolutions for Magento version 1.3.x and new features such as Checkout By Amazon and Amazon Flexible Payment. To see a full list of updates please check the release notes page.','http://www.magentocommerce.com/blog/comments/magento-version-131-now-available/',0,0),(21,3,'2009-05-19 23:31:21','Magento version 1.3.1.1 now available','Magento version 1.3.1.1 is now available for download and upgrade. This version includes some issue resolutions for Magento version 1.3.x and a security update for Magento installations that run on multiple domains or sub-domains. If you are running Magento with multiple domains or sub-domains we highly recommend upgrading to this version.','http://www.magentocommerce.com/blog/comments/magento-version-1311-now-available/',0,0),(22,3,'2009-05-29 23:54:06','Magento version 1.3.2 now available','This version includes some improvements and issue resolutions for version 1.3.x that are listed on the release notes page. also included is a Beta version of the Compile module.','http://www.magentocommerce.com/blog/comments/magento-version-132-now-available/',0,0),(23,3,'2009-06-01 20:32:52','Magento version 1.3.2.1 now available','Magento version 1.3.2.1 now available for download and upgrade.\n\nThis release solves an issue for users running Magento with PHP 5.2.0, and changes to index.php to support the new Compiler Module.','http://www.magentocommerce.com/blog/comments/magento-version-1321-now-available/',0,0),(24,3,'2009-07-02 02:21:44','Magento version 1.3.2.2 now available','Magento version 1.3.2.2 is now available for download and upgrade.\n\nThis release includes issue resolution for Magento version 1.3.x. To see a full list of changes please visit the release notes page http://www.magentocommerce.com/download/release_notes.','http://www.magentocommerce.com/blog/comments/magento-version-1322-now-available/',0,0),(25,3,'2009-07-23 07:48:54','Magento version 1.3.2.3 now available','Magento version 1.3.2.3 is now available for download and upgrade.\n\nThis release includes issue resolution for Magento version 1.3.x. We recommend to upgrade to this version if PayPal payment modules are in use. To see a full list of changes please visit the release notes page http://www.magentocommerce.com/download/release_notes.','http://www.magentocommerce.com/blog/comments/magento-version-1323-now-available/',0,0),(26,4,'2009-08-28 19:26:28','PayPal is updating Payflow Pro and Website Payments Pro (Payflow Edition) UK.','If you are using Payflow Pro and/or Website Payments Pro (Payflow Edition) UK.  payment methods, you will need to update the URLâ€˜s in your Magento Administrator Panel in order to process transactions after September 1, 2009. Full details are available here: http://www.magentocommerce.com/wiki/paypal_payflow_changes','http://www.magentocommerce.com/wiki/paypal_payflow_changes',0,0),(27,2,'2009-09-23 21:16:49','Magento Version 1.3.2.4 Security Update','Magento Version 1.3.2.4 is now available. This version includes a security updates for Magento 1.3.x that solves possible XSS vulnerability issue on customer registration page and is available through SVN, Download Page and through the Magento Connect Manager.','http://www.magentocommerce.com/blog/comments/magento-version-1324-security-update/',0,0),(28,4,'2009-09-25 15:57:54','Magento Preview Version 1.4.0.0-alpha2 is now available','We are happy to announce the availability of Magento Preview Version 1.4.0.0-alpha2 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-1400-alpha2-now-available/',0,0),(29,4,'2009-10-07 01:55:40','Magento Preview Version 1.4.0.0-alpha3 is now available','We are happy to announce the availability of Magento Preview Version 1.4.0.0-alpha3 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-1400-alpha3-now-available/',0,0),(30,4,'2009-12-09 02:30:36','Magento Preview Version 1.4.0.0-beta1 is now available','We are happy to announce the availability of Magento Preview Version 1.4.0.0-beta1 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-1400-beta1-now-available/',0,0),(31,4,'2009-12-31 12:22:12','Magento Preview Version 1.4.0.0-rc1 is now available','We are happy to announce the availability of Magento Preview Version 1.4.0.0-rc1 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-1400-rc1-now-available/',0,0),(32,4,'2010-02-13 06:39:53','Magento CE Version 1.4.0.0 Stable is now available','We are excited to announce the availability of Magento CE Version 1.4.0.0 Stable for upgrade and download.','http://bit.ly/c53rpK',0,0),(33,3,'2010-02-20 05:39:36','Magento CE Version 1.4.0.1 Stable is now available','Magento CE 1.4.0.1 Stable is now available for upgrade and download.','http://www.magentocommerce.com/blog/comments/magento-ce-version-1401-stable-now-available/',0,0),(34,4,'2010-04-23 21:09:03','Magento Version CE 1.3.3.0 Stable - Now Available With Support for 3-D Secure','Based on community requests, we are excited to announce the release of Magento CE 1.3.3.0-Stable with support for 3-D Secure. This release is intended for Magento merchants using version 1.3.x, who want to add support for 3-D Secure.','http://www.magentocommerce.com/blog/comments/magento-version-ce-1330-stable-now-available-with-support-for-3-d-secure/',0,0),(35,4,'2010-05-31 18:20:21','Announcing the Launch of Magento Mobile','The Magento team is pleased to announce the launch of Magento mobile, a new product that will allow Magento merchants to easily create branded, native mobile storefront applications that are deeply integrated with Magentoâ€™s market-leading eCommerce platform. The product includes a new administrative manager, a native iPhone app that is fully customizable, and a service where Magento manages the submission and maintenance process for the iTunes App Store.\n\nLearn more by visiting the Magento mobile product page and sign-up to be the first to launch a native mobile commerce app, fully integrated with Magento.','http://www.magentocommerce.com/product/mobile',0,0),(36,4,'2010-06-10 21:08:08','Magento CE Version 1.4.1.0 Stable is now available','We are excited to announce the availability of Magento CE Version 1.4.1.0 Stable for upgrade and download. Some of the highlights of this release include: Enhanced PayPal integration (more info to follow), Change of Database structure of the Sales module to no longer use EAV, and much more.','http://www.magentocommerce.com/blog/comments/magento-ce-version-1410-stable-now-available/',0,0),(37,4,'2010-07-26 22:37:34','Magento CE Version 1.4.1.1 Stable is now available','We are excited to announce the availability of Magento CE Version 1.4.1.1 Stable for download and upgrade.','http://www.magentocommerce.com/blog/comments/magento-ce-version-1411-stable-now-available/',0,0),(38,4,'2010-07-28 06:12:12','Magento CE Version 1.4.2.0-beta1 Preview Release Now Available','This release gives a preview of the new Magento Connect Manager.','http://www.magentocommerce.com/blog/comments/magento-preview-version-1420-beta1-now-available/',0,0),(39,4,'2010-07-28 21:15:01','Magento CE Version 1.4.1.1 Patch Available','As some users experienced issues with upgrading to CE 1.4.1.1 through PEAR channels we provided a patch for it that is available on our blog http://www.magentocommerce.com/blog/comments/magento-ce-version-1411-stable-patch/','http://www.magentocommerce.com/blog/comments/magento-ce-version-1411-stable-patch/',0,0),(40,4,'2010-10-12 01:13:25','Magento Mobile is now live!','Magento Mobile is now live! Signup today to have your own native iPhone mobile-shopping app in iTunes for the holiday season! Learn more at http://www.magentomobile.com/','http://www.magentomobile.com/',0,0),(41,4,'2010-11-09 00:52:06','Magento CE Version 1.4.2.0-RC1 Preview Release Now Available','We are happy to announce the availability of Magento Preview Version 1.4.2.0-RC1 for download.','http://www.magentocommerce.com/blog/comments/magento-preview-version-1420-rc1-now-available/',0,0),(42,4,'2010-12-02 23:33:00','Magento CE Version 1.4.2.0-RC2 Preview Release Now Available','We are happy to announce the availability of Magento Preview Version 1.4.2.0-RC2 for download.','http://www.magentocommerce.com/blog/comments/magento-preview-version-1420-rc2-now-available/',0,0),(43,4,'2010-12-09 01:29:55','Magento CE Version 1.4.2.0 Stable is now available','We are excited to announce the availability of Magento CE Version 1.4.2.0 Stable for download and upgrade.','http://www.magentocommerce.com/blog/comments/magento-ce-version-1420-stable-now-available/',0,0),(44,4,'2010-12-18 02:23:55','Magento Preview Version CE 1.5.0.0-alpha1 is now available','We are happy to announce the availability of Magento Preview Version CE 1.5.0.0-alpha1 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1500-alpha1-now-available/',0,0),(45,4,'2010-12-30 02:51:08','Magento Preview Version CE 1.5.0.0-alpha2 is now available','We are happy to announce the availability of Magento Preview Version CE 1.5.0.0-alpha2 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1500-alpha2-now-available/',0,0),(46,4,'2011-01-14 03:35:36','Magento Preview Version CE 1.5.0.0-beta1 is now available','We are happy to announce the availability of Magento Preview Version CE 1.5.0.0-beta1 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1500-beta1-now-available/',0,0),(47,4,'2011-01-22 00:19:09','Magento Preview Version CE 1.5.0.0-beta2 is now available','We are happy to announce the availability of Magento Preview Version CE 1.5.0.0-beta2 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1500-beta2-now-available/',0,0),(48,4,'2011-01-28 00:27:57','Magento Preview Version CE 1.5.0.0-rc1 is now available','We are happy to announce the availability of Magento Preview Version CE 1.5.0.0-rc1 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1500-rc1-now-available/',0,0),(49,4,'2011-02-04 00:56:33','Magento Preview Version CE 1.5.0.0-rc2 is now available','We are happy to announce the availability of Magento Preview Version CE 1.5.0.0-rc2 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1500-rc2-now-available/',0,0),(50,4,'2011-02-08 22:43:23','Magento CE Version 1.5.0.0 Stable is now available','We are excited to announce the availability of Magento CE Version 1.5.0.0 Stable for download and upgrade.','http://www.magentocommerce.com/blog/comments/magento-community-professional-and-enterprise-editions-releases-now-availab/',0,0),(51,4,'2011-02-10 02:42:57','Magento CE 1.5.0.1 stable Now Available','We are excited to announce the availability of Magento CE Version 1.5.0.1 Stable for download and upgrade.','http://www.magentocommerce.com/blog/comments/magento-ce-1501-stable-now-available/',0,0),(52,4,'2011-03-18 22:15:45','Magento CE 1.5.1.0-beta1 Now Available','We are happy to announce the availability of Magento Preview Version CE 1.5.1.0-beta1 for download and upgrade.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1510-beta1-now-available/',0,0),(53,4,'2011-03-31 19:43:02','Magento CE 1.5.1.0-rc1 Now Available','We are happy to announce the availability of Magento Preview Version CE 1.5.1.0-rc1 for download and upgrade.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1510-rc1-now-available/',0,0),(54,4,'2011-04-26 20:21:07','Magento CE 1.5.1.0-stable Now Available','We are excited to announce the availability of Magento CE Version 1.5.1.0 Stable for download and upgrade.','http://www.magentocommerce.com/blog/comments/magento-ce-version-1510-stable-now-available/',0,0),(55,4,'2011-05-26 20:33:23','Magento Preview Version CE 1.6.0.0-alpha1 is now available','We are happy to announce the availability of Magento Preview Version CE 1.6.0.0-alpha1 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1600-alpha1-now-available/',0,0),(56,4,'2011-06-15 19:12:08','Magento Preview Version CE 1.6.0.0-beta1 is now available','We are happy to announce the availability of Magento Preview Version CE 1.6.0.0-beta1for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1600-beta1-now-available/',0,0),(57,4,'2011-06-30 20:03:58','Magento Preview Version CE 1.6.0.0-rc1 is now available','We are happy to announce the availability of Magento Preview Version CE 1.6.0.0-rc1 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1600-rc1-now-available/',0,0),(58,4,'2011-07-11 20:07:39','Magento Preview Version CE 1.6.0.0-rc2 is now available','We are happy to announce the availability of Magento Preview Version CE 1.6.0.0-rc2 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1600-rc2-now-available/',0,0),(59,4,'2011-08-19 18:58:31','Magento CE 1.6.0.0-stable Now Available','We are excited to announce the availability of Magento CE Version 1.6.0.0 Stable for download and upgrade.','http://www.magentocommerce.com/blog/comments/magento-ce-version-1600-stable-now-available/',0,0),(60,4,'2011-09-17 02:31:26','Magento Preview Version CE 1.6.1.0-beta1 is now available','We are happy to announce the availability of Magento Preview Version CE 1.6.1.0-beta1 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1610-beta1-now-available/',0,0),(61,4,'2011-09-29 16:44:10','Magento Preview Version CE 1.6.1.0-rc1 is now available','We are happy to announce the availability of Magento Preview Version CE 1.6.1.0-rc1 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1610-rc1-now-available/',0,0),(62,4,'2011-10-19 18:50:05','Magento CE 1.6.1.0-stable Now Available','We are excited to announce the availability of Magento CE Version 1.6.1.0 Stable for download and upgrade.','http://www.magentocommerce.com/blog/comments/magento-ce-version-1610-stable-now-available/',0,0),(63,4,'2011-12-30 20:39:35','Magento Preview Version CE 1.7.0.0-alpha1 is now available','We are happy to announce the availability of Magento Preview Version CE 1.7.0.0-alpha1 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1700-alpha1-now-available/',0,0),(64,4,'2012-01-11 20:24:20','Magento CE 1.6.2.0-stable Now Available','We are excited to announce the availability of Magento CE Version 1.6.2.0 Stable for download and upgrade.','http://www.magentocommerce.com/blog/comments/magento-ce-version-1620-stable-now-available/',0,0),(65,4,'2012-03-02 22:54:12','Magento Preview Version CE 1.7.0.0-beta1 is now available','We are happy to announce the availability of Magento Preview Version CE 1.7.0.0-beta1 for download.\nAs this is a preview version it is NOT recommended in any way to be used in a production environment.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1700-beta1-now-available/',0,0),(66,4,'2012-04-23 11:02:40','Magento Community Preview Version CE 1.7.0.0-RC1 has been released!','Learn more about the exciting new features and updates in this release and how you can take it for a test drive. As this is a preview version, we need to stress that it\'s likely unstable and that we DON\'T recommend that you use it in any production environment just yet.','http://www.magentocommerce.com/blog/comments/magento-preview-version-ce-1700-rc1-now-available/',0,0),(67,4,'2012-05-11 06:46:54','Magento Community 1.7 and Magento Enterprise 1.12 now available!','Learn more about the exciting new features and updates in these releases.','http://www.magentocommerce.com/blog/comments/magento-enterprise-112-and-community-17-now-available/',0,0),(68,4,'2012-06-20 15:54:07','Magento Community Edition 1.7.0.1 now available! ','We have just released an updated version of Magento Community Edition, version 1.7.0.1. This update delivers new, minor functionality and fixes for some potential security vulnerabilities.','http://www.magentocommerce.com/blog/comments/magento-community-edition-1701-released/',0,0),(69,4,'2012-07-05 16:21:43','Important Security Update - Zend Platform Vulnerability','We have recently learned of a serious vulnerability in the Zend platform on which Magento is built. Learn more and access a patch that addresses this issue. ','http://www.magentocommerce.com/blog/comments/important-security-update-zend-platform-vulnerability/',0,0),(70,4,'2012-11-19 18:27:42','Wrap up more holiday sales with financing','Give your customers up to 6 months financing. You get paid right away with Bill Me Later, a PayPal service. It’s a great way to extend financing in time for the holidays. Learn More.','http://www.magentocommerce.com/paypal/billmelater?utm_source=CEMessaging&utm_medium=copy&utm_content=sixmonths&utm_campaign=BML',0,0),(71,4,'2012-12-07 09:22:30','Increase Your Sales With PayPal','Magento merchants using PayPal Express Checkout can help increase their sales on average 18%. It is one simple thing you can do right now to help boost your sales. Learn more.','http://www.magentocommerce.com/add-paypal?utm_source=CEModule&utm_medium=copy&utm_content=18&utm_campaign=choosepaypal',0,0),(72,4,'2013-01-15 20:02:07','Imagine 2013 Registration is Now Open!','Join 1500 merchants, partners, developers and enthusiasts from 35+ countries around the world for Magento’s premier global conference! Collaborate, learn, network and get inspired by the future of eCommerce. Tickets will sell out fast! April 8th – 10th in Las Vegas.','https://registration.imagineecommerce.com/',0,0),(73,4,'2013-02-12 15:53:42','Get More eCommerce Power with Magento Enterprise','Limited time offer: Get a free, customized evaluation of your Community Edition site from a Magento Solution Partner. This evaluation gives you a clear look at the numerous benefits you can achieve by upgrading to Enterprise Edition. ','http://www.magentocommerce.com/community-to-enterprise?utm_source=CEMM&utm_medium=copy&utm_campaign=CE2EE',0,0),(74,2,'2013-09-27 14:28:13','Magento Community Edition 1.8.0.0 - now available for download!','Get tax, security, performance, and many other improvements. \n\nLearn more at http://www.magentocommerce.com/blog/comments/magento-community-edition-one-eight-now-available/ ','http://www.magentocommerce.com/blog/comments/magento-community-edition-one-eight-now-available/',0,0),(75,4,'2013-12-11 13:35:06','Magento Community Edition 1.8.1.0 is here!','This new version offers significant tax calculation, product quality, and security enhancements. Be sure to carefully review the upgrade instructions before starting. More information is available at http://www.magentocommerce.com/blog/comments/magento-community-edition-1810-is-here/','http://www.magentocommerce.com/blog/comments/magento-community-edition-1810-is-here/',0,0),(76,4,'2013-12-12 21:24:39','Important Magento Community Edition Patch','A security patch is available for Magento Community Edition 1.4.0.0 through 1.7.0.2; the issue has been fixed in Magento Community Edition 1.8.0.0 and later. It resolves a vulnerability discovered through our quarterly penetration testing process and has not been reported by merchants. We encourage all merchants to apply the patch in their next regularly scheduled maintenance cycle. The patch is available at http://www.magentocommerce.com/download in the Magento Community Edition Patches section.','http://www.magentocommerce.com/download',0,0),(77,4,'2014-01-21 16:34:48','PHP 5.4 Patch Now Available','Magento is advancing its platform and making development more efficient by adding support for PHP 5.4. Patches are available for download at www.magentocommerce.com/download and you can learn more about this update in our blog post at http://www.magentocommerce.com/blog/comments/magento-now-supports-php-54 .','http://www.magentocommerce.com/blog/comments/magento-now-supports-php-54',0,0),(78,4,'2014-02-20 15:51:46','Discover Card Validation Patch Available','A patch that resolves an issue with validating Discover credit cards is now available for download at http://www.magentocommerce.com/download. More information on the patch is available in the Magento Knowledge Base at http://www.magentocommerce.com/knowledge-base/entry/discover-card-validation','http://www.magentocommerce.com/knowledge-base/entry/discover-card-validation ',0,0),(79,4,'2014-03-04 13:12:26','Learn How to Quickly Increase Sales on Your Site','Adding the PayPal Express Checkout button to your checkout page can help increase sales 18% on average. It’s fast and easy and you can do it right now to boost sales. Express Checkout is already seamlessly integrated into Community Edition.','http://magento.com/paypal/CE_Express_Checkout_NA?utm_source=messagemodule&utm_medium=message&utm_campaign=Ceexpresscheckout',0,0),(80,4,'2014-05-13 13:46:11','Magento Community Edition 1.9 is now available!','It accelerates your entry into the mobile commerce space by slashing the time and cost of getting a mobile device-friendly responsive site.  And a new Bill Me Later payment option helps boost your sales. Visit http://magento.com/blog/magento-news/magento-enables-responsive-sites-half-time to learn more.','http://magento.com/blog/magento-news/magento-enables-responsive-sites-half-time',0,0),(81,4,'2014-10-08 01:55:06','It’s still not too late: Boost your 2014 Holiday sales today.','See results in as little as one week with eBay Enterprise Display and 2 business days with eBay Enterprise Affiliate. DID YOU KNOW: Get access to over 128 million highly qualified shoppers on eBay.com with eBay Enterprise Display. And the average retail client using product retargeting sees a $10 to $1 ROI on retargeting spend during Q4. With the eBay Enterprise Affiliate Network, get access to over 200,000 active network publishers across 30+ verticals, and only pay when a customer makes a purchase (Affiliate Network is only available in the U.S. & Canada).  GET STARTED TODAY by visiting www.ebayenterprise.com/turbochargesales','http://www.ebayenterprise.com/turbochargesales',0,0),(82,4,'2014-11-12 17:03:26','Important: PayPal Users Must Discontinue Using SSL 3.0 By December 3, 2014','To address a vulnerability with the SSL 3.0 security protocol, PayPal and other payment gateways will be disabling SSL 3.0 support. Merchants must upgrade to Transport Layer Service (TLS) by December 3, 2014 to avoid PayPal payment operation failures. Learn more about what you need to do at https://devblog.paypal.com/poodle-ssl-3-0-vulnerability/','https://devblog.paypal.com/poodle-ssl-3-0-vulnerability/',0,0),(83,4,'2014-11-24 21:25:21','Magento Community Edition 1.9.1 is available!','Magento Community Edition 1.9.1 empowers merchants to deliver compelling shopping experiences by offering enhanced responsive design capabilities, new swatches to display product variations, and improved performance through support for MySQL 5.6 and PHP 5.5. It also includes support for Google Universal Analytics and over 70 product improvements. Find out more at http://magento.com/blog/magento-news/magento-community-edition-191-now-available-download','http://magento.com/blog/magento-news/magento-community-edition-191-now-available-download',0,0),(84,4,'2015-01-22 15:47:08','Join Us at Imagine Commerce 2015 - April 20-22 at the Wynn Las Vegas','Join Magento, eBay Enterprise, and over 2,000 merchants, developers, and eCommerce experts at the premier Commerce event of the year. With three days of cutting-edge keynote presentations, special technical programs, dynamic breakout sessions, and incredible networking opportunities, Imagine Commerce 2015 will educate, enrich, and inspire you to take your business to new heights. Register now at http://imagine2015.magento.com/.','http://imagine2015.magento.com/',0,0);
/*!40000 ALTER TABLE `mag_adminnotification_inbox` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_api2_acl_attribute`
--

DROP TABLE IF EXISTS `mag_api2_acl_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_api2_acl_attribute` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `user_type` varchar(20) NOT NULL COMMENT 'Type of user',
  `resource_id` varchar(255) NOT NULL COMMENT 'Resource ID',
  `operation` varchar(20) NOT NULL COMMENT 'Operation',
  `allowed_attributes` text COMMENT 'Allowed attributes',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_MAG_MAG_API2_ACL_ATTRIBUTE_USER_TYPE_RESOURCE_ID_OPERATION` (`user_type`,`resource_id`,`operation`),
  KEY `IDX_MAG_API2_ACL_ATTRIBUTE_USER_TYPE` (`user_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api2 Filter ACL Attributes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_api2_acl_attribute`
--

LOCK TABLES `mag_api2_acl_attribute` WRITE;
/*!40000 ALTER TABLE `mag_api2_acl_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_api2_acl_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_api2_acl_role`
--

DROP TABLE IF EXISTS `mag_api2_acl_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_api2_acl_role` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `role_name` varchar(255) NOT NULL COMMENT 'Name of role',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_MAG_API2_ACL_ROLE_CREATED_AT` (`created_at`),
  KEY `IDX_MAG_API2_ACL_ROLE_UPDATED_AT` (`updated_at`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Api2 Global ACL Roles';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_api2_acl_role`
--

LOCK TABLES `mag_api2_acl_role` WRITE;
/*!40000 ALTER TABLE `mag_api2_acl_role` DISABLE KEYS */;
INSERT INTO `mag_api2_acl_role` VALUES (1,'2015-02-19 10:08:50',NULL,'Guest'),(2,'2015-02-19 10:08:50',NULL,'Customer');
/*!40000 ALTER TABLE `mag_api2_acl_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_api2_acl_rule`
--

DROP TABLE IF EXISTS `mag_api2_acl_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_api2_acl_rule` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `role_id` int(10) unsigned NOT NULL COMMENT 'Role ID',
  `resource_id` varchar(255) NOT NULL COMMENT 'Resource ID',
  `privilege` varchar(20) DEFAULT NULL COMMENT 'ACL Privilege',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_MAG_MAG_API2_ACL_RULE_ROLE_ID_RESOURCE_ID_PRIVILEGE` (`role_id`,`resource_id`,`privilege`),
  CONSTRAINT `FK_MAG_API2_ACL_RULE_ROLE_ID_MAG_API2_ACL_ROLE_ENTITY_ID` FOREIGN KEY (`role_id`) REFERENCES `mag_api2_acl_role` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api2 Global ACL Rules';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_api2_acl_rule`
--

LOCK TABLES `mag_api2_acl_rule` WRITE;
/*!40000 ALTER TABLE `mag_api2_acl_rule` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_api2_acl_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_api2_acl_user`
--

DROP TABLE IF EXISTS `mag_api2_acl_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_api2_acl_user` (
  `admin_id` int(10) unsigned NOT NULL COMMENT 'Admin ID',
  `role_id` int(10) unsigned NOT NULL COMMENT 'Role ID',
  UNIQUE KEY `UNQ_MAG_MAG_API2_ACL_USER_ADMIN_ID` (`admin_id`),
  KEY `FK_MAG_API2_ACL_USER_ROLE_ID_MAG_API2_ACL_ROLE_ENTITY_ID` (`role_id`),
  CONSTRAINT `FK_MAG_API2_ACL_USER_ADMIN_ID_MAG_ADMIN_USER_USER_ID` FOREIGN KEY (`admin_id`) REFERENCES `mag_admin_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_API2_ACL_USER_ROLE_ID_MAG_API2_ACL_ROLE_ENTITY_ID` FOREIGN KEY (`role_id`) REFERENCES `mag_api2_acl_role` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api2 Global ACL Users';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_api2_acl_user`
--

LOCK TABLES `mag_api2_acl_user` WRITE;
/*!40000 ALTER TABLE `mag_api2_acl_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_api2_acl_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_api_assert`
--

DROP TABLE IF EXISTS `mag_api_assert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_api_assert` (
  `assert_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Assert id',
  `assert_type` varchar(20) DEFAULT NULL COMMENT 'Assert type',
  `assert_data` text COMMENT 'Assert additional data',
  PRIMARY KEY (`assert_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api ACL Asserts';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_api_assert`
--

LOCK TABLES `mag_api_assert` WRITE;
/*!40000 ALTER TABLE `mag_api_assert` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_api_assert` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_api_role`
--

DROP TABLE IF EXISTS `mag_api_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_api_role` (
  `role_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Role id',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Parent role id',
  `tree_level` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Role level in tree',
  `sort_order` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort order to display on admin area',
  `role_type` varchar(1) NOT NULL DEFAULT '0' COMMENT 'Role type',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'User id',
  `role_name` varchar(50) DEFAULT NULL COMMENT 'Role name',
  PRIMARY KEY (`role_id`),
  KEY `IDX_MAG_API_ROLE_PARENT_ID_SORT_ORDER` (`parent_id`,`sort_order`),
  KEY `IDX_MAG_API_ROLE_TREE_LEVEL` (`tree_level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api ACL Roles';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_api_role`
--

LOCK TABLES `mag_api_role` WRITE;
/*!40000 ALTER TABLE `mag_api_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_api_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_api_rule`
--

DROP TABLE IF EXISTS `mag_api_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_api_rule` (
  `rule_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Api rule Id',
  `role_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Api role Id',
  `resource_id` varchar(255) DEFAULT NULL COMMENT 'Module code',
  `api_privileges` varchar(20) DEFAULT NULL COMMENT 'Privileges',
  `assert_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Assert id',
  `role_type` varchar(1) DEFAULT NULL COMMENT 'Role type',
  `api_permission` varchar(10) DEFAULT NULL COMMENT 'Permission',
  PRIMARY KEY (`rule_id`),
  KEY `IDX_MAG_API_RULE_RESOURCE_ID_ROLE_ID` (`resource_id`,`role_id`),
  KEY `IDX_MAG_API_RULE_ROLE_ID_RESOURCE_ID` (`role_id`,`resource_id`),
  CONSTRAINT `FK_MAG_API_RULE_ROLE_ID_MAG_API_ROLE_ROLE_ID` FOREIGN KEY (`role_id`) REFERENCES `mag_api_role` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api ACL Rules';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_api_rule`
--

LOCK TABLES `mag_api_rule` WRITE;
/*!40000 ALTER TABLE `mag_api_rule` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_api_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_api_session`
--

DROP TABLE IF EXISTS `mag_api_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_api_session` (
  `user_id` int(10) unsigned NOT NULL COMMENT 'User id',
  `logdate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Login date',
  `sessid` varchar(40) DEFAULT NULL COMMENT 'Sessioin id',
  KEY `IDX_MAG_API_SESSION_USER_ID` (`user_id`),
  KEY `IDX_MAG_API_SESSION_SESSID` (`sessid`),
  CONSTRAINT `FK_MAG_API_SESSION_USER_ID_MAG_API_USER_USER_ID` FOREIGN KEY (`user_id`) REFERENCES `mag_api_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api Sessions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_api_session`
--

LOCK TABLES `mag_api_session` WRITE;
/*!40000 ALTER TABLE `mag_api_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_api_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_api_user`
--

DROP TABLE IF EXISTS `mag_api_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_api_user` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'User id',
  `firstname` varchar(32) DEFAULT NULL COMMENT 'First name',
  `lastname` varchar(32) DEFAULT NULL COMMENT 'Last name',
  `email` varchar(128) DEFAULT NULL COMMENT 'Email',
  `username` varchar(40) DEFAULT NULL COMMENT 'Nickname',
  `api_key` varchar(100) DEFAULT NULL COMMENT 'Api key',
  `created` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'User record create date',
  `modified` timestamp NULL DEFAULT NULL COMMENT 'User record modify date',
  `lognum` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Quantity of log ins',
  `reload_acl_flag` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Refresh ACL flag',
  `is_active` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Account status',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Api Users';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_api_user`
--

LOCK TABLES `mag_api_user` WRITE;
/*!40000 ALTER TABLE `mag_api_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_api_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_captcha_log`
--

DROP TABLE IF EXISTS `mag_captcha_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_captcha_log` (
  `type` varchar(32) NOT NULL COMMENT 'Type',
  `value` varchar(32) NOT NULL COMMENT 'Value',
  `count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Count',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Update Time',
  PRIMARY KEY (`type`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Count Login Attempts';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_captcha_log`
--

LOCK TABLES `mag_captcha_log` WRITE;
/*!40000 ALTER TABLE `mag_captcha_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_captcha_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_category_anc_categs_index_idx`
--

DROP TABLE IF EXISTS `mag_catalog_category_anc_categs_index_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_category_anc_categs_index_idx` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `path` varchar(255) DEFAULT NULL COMMENT 'Path',
  KEY `IDX_MAG_CATALOG_CATEGORY_ANC_CATEGS_INDEX_IDX_CATEGORY_ID` (`category_id`),
  KEY `IDX_MAG_CATALOG_CATEGORY_ANC_CATEGS_INDEX_IDX_PATH_CATEGORY_ID` (`path`,`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Anchor Indexer Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_category_anc_categs_index_idx`
--

LOCK TABLES `mag_catalog_category_anc_categs_index_idx` WRITE;
/*!40000 ALTER TABLE `mag_catalog_category_anc_categs_index_idx` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_category_anc_categs_index_idx` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_category_anc_categs_index_tmp`
--

DROP TABLE IF EXISTS `mag_catalog_category_anc_categs_index_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_category_anc_categs_index_tmp` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `path` varchar(255) DEFAULT NULL COMMENT 'Path',
  KEY `IDX_MAG_CATALOG_CATEGORY_ANC_CATEGS_INDEX_TMP_CATEGORY_ID` (`category_id`),
  KEY `IDX_MAG_CATALOG_CATEGORY_ANC_CATEGS_INDEX_TMP_PATH_CATEGORY_ID` (`path`,`category_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Category Anchor Indexer Temp Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_category_anc_categs_index_tmp`
--

LOCK TABLES `mag_catalog_category_anc_categs_index_tmp` WRITE;
/*!40000 ALTER TABLE `mag_catalog_category_anc_categs_index_tmp` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_category_anc_categs_index_tmp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_category_anc_products_index_idx`
--

DROP TABLE IF EXISTS `mag_catalog_category_anc_products_index_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_category_anc_products_index_idx` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `position` int(10) unsigned DEFAULT NULL COMMENT 'Position',
  KEY `IDX_MAG_CAT_CTGR_ANC_PRDS_IDX_IDX_CTGR_ID_PRD_ID_POSITION` (`category_id`,`product_id`,`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Anchor Product Indexer Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_category_anc_products_index_idx`
--

LOCK TABLES `mag_catalog_category_anc_products_index_idx` WRITE;
/*!40000 ALTER TABLE `mag_catalog_category_anc_products_index_idx` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_category_anc_products_index_idx` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_category_anc_products_index_tmp`
--

DROP TABLE IF EXISTS `mag_catalog_category_anc_products_index_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_category_anc_products_index_tmp` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `position` int(10) unsigned DEFAULT NULL COMMENT 'Position',
  KEY `IDX_MAG_CAT_CTGR_ANC_PRDS_IDX_TMP_CTGR_ID_PRD_ID_POSITION` (`category_id`,`product_id`,`position`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Category Anchor Product Indexer Temp Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_category_anc_products_index_tmp`
--

LOCK TABLES `mag_catalog_category_anc_products_index_tmp` WRITE;
/*!40000 ALTER TABLE `mag_catalog_category_anc_products_index_tmp` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_category_anc_products_index_tmp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_category_entity`
--

DROP TABLE IF EXISTS `mag_catalog_category_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_category_entity` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attriute Set ID',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Parent Category ID',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Creation Time',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Update Time',
  `path` varchar(255) NOT NULL COMMENT 'Tree Path',
  `position` int(11) NOT NULL COMMENT 'Position',
  `level` int(11) NOT NULL DEFAULT '0' COMMENT 'Tree Level',
  `children_count` int(11) NOT NULL COMMENT 'Child Count',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_MAG_CATALOG_CATEGORY_ENTITY_LEVEL` (`level`),
  KEY `IDX_MAG_CATALOG_CATEGORY_ENTITY_PATH_ENTITY_ID` (`path`,`entity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Catalog Category Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_category_entity`
--

LOCK TABLES `mag_catalog_category_entity` WRITE;
/*!40000 ALTER TABLE `mag_catalog_category_entity` DISABLE KEYS */;
INSERT INTO `mag_catalog_category_entity` VALUES (1,3,0,0,'2015-02-19 08:09:22','2015-02-19 08:09:23','1',0,0,1),(2,3,3,1,'2015-02-19 08:09:23','2015-02-19 08:09:23','1/2',1,1,0);
/*!40000 ALTER TABLE `mag_catalog_category_entity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_category_entity_datetime`
--

DROP TABLE IF EXISTS `mag_catalog_category_entity_datetime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_category_entity_datetime` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` datetime DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `0822EA832B8EF745BCF4C0D0D7E0D6B0` (`entity_type_id`,`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_MAG_CATALOG_CATEGORY_ENTITY_DATETIME_ENTITY_ID` (`entity_id`),
  KEY `IDX_MAG_CATALOG_CATEGORY_ENTITY_DATETIME_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MAG_CATALOG_CATEGORY_ENTITY_DATETIME_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MAG_CAT_CTGR_ENTT_DTIME_ATTR_ID_MAG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mag_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_CTGR_ENTT_DTIME_ENTT_ID_MAG_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mag_catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_CTGR_ENTT_DTIME_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Datetime Attribute Backend Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_category_entity_datetime`
--

LOCK TABLES `mag_catalog_category_entity_datetime` WRITE;
/*!40000 ALTER TABLE `mag_catalog_category_entity_datetime` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_category_entity_datetime` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_category_entity_decimal`
--

DROP TABLE IF EXISTS `mag_catalog_category_entity_decimal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_category_entity_decimal` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` decimal(12,4) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MAG_CAT_CTGR_ENTT_DEC_ENTT_TYPE_ID_ENTT_ID_ATTR_ID_STORE_ID` (`entity_type_id`,`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_MAG_CATALOG_CATEGORY_ENTITY_DECIMAL_ENTITY_ID` (`entity_id`),
  KEY `IDX_MAG_CATALOG_CATEGORY_ENTITY_DECIMAL_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MAG_CATALOG_CATEGORY_ENTITY_DECIMAL_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MAG_CAT_CTGR_ENTT_DEC_ATTR_ID_MAG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mag_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_CTGR_ENTT_DEC_ENTT_ID_MAG_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mag_catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_CTGR_ENTT_DEC_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Decimal Attribute Backend Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_category_entity_decimal`
--

LOCK TABLES `mag_catalog_category_entity_decimal` WRITE;
/*!40000 ALTER TABLE `mag_catalog_category_entity_decimal` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_category_entity_decimal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_category_entity_int`
--

DROP TABLE IF EXISTS `mag_catalog_category_entity_int`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_category_entity_int` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` int(11) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MAG_CAT_CTGR_ENTT_INT_ENTT_TYPE_ID_ENTT_ID_ATTR_ID_STORE_ID` (`entity_type_id`,`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_MAG_CATALOG_CATEGORY_ENTITY_INT_ENTITY_ID` (`entity_id`),
  KEY `IDX_MAG_CATALOG_CATEGORY_ENTITY_INT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MAG_CATALOG_CATEGORY_ENTITY_INT_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MAG_CAT_CTGR_ENTT_INT_ATTR_ID_MAG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mag_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_CTGR_ENTT_INT_ENTT_ID_MAG_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mag_catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_CTGR_ENTT_INT_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='Catalog Category Integer Attribute Backend Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_category_entity_int`
--

LOCK TABLES `mag_catalog_category_entity_int` WRITE;
/*!40000 ALTER TABLE `mag_catalog_category_entity_int` DISABLE KEYS */;
INSERT INTO `mag_catalog_category_entity_int` VALUES (1,3,67,0,1,1),(2,3,67,1,1,1),(3,3,42,0,2,1),(4,3,67,0,2,1),(5,3,42,1,2,1),(6,3,67,1,2,1);
/*!40000 ALTER TABLE `mag_catalog_category_entity_int` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_category_entity_text`
--

DROP TABLE IF EXISTS `mag_catalog_category_entity_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_category_entity_text` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` text COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MAG_CAT_CTGR_ENTT_TEXT_ENTT_TYPE_ID_ENTT_ID_ATTR_ID_STORE_ID` (`entity_type_id`,`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_MAG_CATALOG_CATEGORY_ENTITY_TEXT_ENTITY_ID` (`entity_id`),
  KEY `IDX_MAG_CATALOG_CATEGORY_ENTITY_TEXT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MAG_CATALOG_CATEGORY_ENTITY_TEXT_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MAG_CAT_CTGR_ENTT_TEXT_ATTR_ID_MAG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mag_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_CTGR_ENTT_TEXT_ENTT_ID_MAG_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mag_catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_CTGR_ENTT_TEXT_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Catalog Category Text Attribute Backend Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_category_entity_text`
--

LOCK TABLES `mag_catalog_category_entity_text` WRITE;
/*!40000 ALTER TABLE `mag_catalog_category_entity_text` DISABLE KEYS */;
INSERT INTO `mag_catalog_category_entity_text` VALUES (1,3,65,0,1,NULL),(2,3,65,1,1,NULL),(3,3,65,0,2,NULL),(4,3,65,1,2,NULL);
/*!40000 ALTER TABLE `mag_catalog_category_entity_text` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_category_entity_varchar`
--

DROP TABLE IF EXISTS `mag_catalog_category_entity_varchar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_category_entity_varchar` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MAG_CAT_CTGR_ENTT_VCHR_ENTT_TYPE_ID_ENTT_ID_ATTR_ID_STORE_ID` (`entity_type_id`,`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_MAG_CATALOG_CATEGORY_ENTITY_VARCHAR_ENTITY_ID` (`entity_id`),
  KEY `IDX_MAG_CATALOG_CATEGORY_ENTITY_VARCHAR_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MAG_CATALOG_CATEGORY_ENTITY_VARCHAR_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MAG_CAT_CTGR_ENTT_VCHR_ATTR_ID_MAG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mag_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_CTGR_ENTT_VCHR_ENTT_ID_MAG_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mag_catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_CTGR_ENTT_VCHR_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='Catalog Category Varchar Attribute Backend Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_category_entity_varchar`
--

LOCK TABLES `mag_catalog_category_entity_varchar` WRITE;
/*!40000 ALTER TABLE `mag_catalog_category_entity_varchar` DISABLE KEYS */;
INSERT INTO `mag_catalog_category_entity_varchar` VALUES (1,3,41,0,1,'Root Catalog'),(2,3,41,1,1,'Root Catalog'),(3,3,43,1,1,'root-catalog'),(4,3,41,0,2,'Default Category'),(5,3,41,1,2,'Default Category'),(6,3,49,1,2,'PRODUCTS'),(7,3,43,1,2,'default-category');
/*!40000 ALTER TABLE `mag_catalog_category_entity_varchar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_category_product`
--

DROP TABLE IF EXISTS `mag_catalog_category_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_category_product` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `position` int(11) NOT NULL DEFAULT '0' COMMENT 'Position',
  PRIMARY KEY (`category_id`,`product_id`),
  KEY `IDX_MAG_CATALOG_CATEGORY_PRODUCT_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_MAG_CAT_CTGR_PRD_CTGR_ID_MAG_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`category_id`) REFERENCES `mag_catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_CTGR_PRD_PRD_ID_MAG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product To Category Linkage Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_category_product`
--

LOCK TABLES `mag_catalog_category_product` WRITE;
/*!40000 ALTER TABLE `mag_catalog_category_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_category_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_category_product_index`
--

DROP TABLE IF EXISTS `mag_catalog_category_product_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_category_product_index` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `position` int(11) DEFAULT NULL COMMENT 'Position',
  `is_parent` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Parent',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `visibility` smallint(5) unsigned NOT NULL COMMENT 'Visibility',
  PRIMARY KEY (`category_id`,`product_id`,`store_id`),
  KEY `IDX_MAG_CAT_CTGR_PRD_IDX_PRD_ID_STORE_ID_CTGR_ID_VISIBILITY` (`product_id`,`store_id`,`category_id`,`visibility`),
  KEY `14C9C65BA2E5D8348EBA4926F536DDB3` (`store_id`,`category_id`,`visibility`,`is_parent`,`position`),
  CONSTRAINT `FK_MAG_CAT_CTGR_PRD_IDX_CTGR_ID_MAG_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`category_id`) REFERENCES `mag_catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_CTGR_PRD_IDX_PRD_ID_MAG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_CTGR_PRD_IDX_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Product Index';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_category_product_index`
--

LOCK TABLES `mag_catalog_category_product_index` WRITE;
/*!40000 ALTER TABLE `mag_catalog_category_product_index` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_category_product_index` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_category_product_index_enbl_idx`
--

DROP TABLE IF EXISTS `mag_catalog_category_product_index_enbl_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_category_product_index_enbl_idx` (
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `visibility` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Visibility',
  KEY `IDX_MAG_CATALOG_CATEGORY_PRODUCT_INDEX_ENBL_IDX_PRODUCT_ID` (`product_id`),
  KEY `IDX_MAG_CAT_CTGR_PRD_IDX_ENBL_IDX_PRD_ID_VISIBILITY` (`product_id`,`visibility`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Product Enabled Indexer Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_category_product_index_enbl_idx`
--

LOCK TABLES `mag_catalog_category_product_index_enbl_idx` WRITE;
/*!40000 ALTER TABLE `mag_catalog_category_product_index_enbl_idx` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_category_product_index_enbl_idx` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_category_product_index_enbl_tmp`
--

DROP TABLE IF EXISTS `mag_catalog_category_product_index_enbl_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_category_product_index_enbl_tmp` (
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `visibility` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Visibility',
  KEY `IDX_MAG_CATALOG_CATEGORY_PRODUCT_INDEX_ENBL_TMP_PRODUCT_ID` (`product_id`),
  KEY `IDX_MAG_CAT_CTGR_PRD_IDX_ENBL_TMP_PRD_ID_VISIBILITY` (`product_id`,`visibility`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Category Product Enabled Indexer Temp Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_category_product_index_enbl_tmp`
--

LOCK TABLES `mag_catalog_category_product_index_enbl_tmp` WRITE;
/*!40000 ALTER TABLE `mag_catalog_category_product_index_enbl_tmp` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_category_product_index_enbl_tmp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_category_product_index_idx`
--

DROP TABLE IF EXISTS `mag_catalog_category_product_index_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_category_product_index_idx` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `position` int(11) NOT NULL DEFAULT '0' COMMENT 'Position',
  `is_parent` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Parent',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `visibility` smallint(5) unsigned NOT NULL COMMENT 'Visibility',
  KEY `IDX_MAG_CAT_CTGR_PRD_IDX_IDX_PRD_ID_CTGR_ID_STORE_ID` (`product_id`,`category_id`,`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Category Product Indexer Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_category_product_index_idx`
--

LOCK TABLES `mag_catalog_category_product_index_idx` WRITE;
/*!40000 ALTER TABLE `mag_catalog_category_product_index_idx` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_category_product_index_idx` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_category_product_index_tmp`
--

DROP TABLE IF EXISTS `mag_catalog_category_product_index_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_category_product_index_tmp` (
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Category ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `position` int(11) NOT NULL DEFAULT '0' COMMENT 'Position',
  `is_parent` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Parent',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `visibility` smallint(5) unsigned NOT NULL COMMENT 'Visibility',
  KEY `IDX_MAG_CAT_CTGR_PRD_IDX_TMP_PRD_ID_CTGR_ID_STORE_ID` (`product_id`,`category_id`,`store_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Category Product Indexer Temp Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_category_product_index_tmp`
--

LOCK TABLES `mag_catalog_category_product_index_tmp` WRITE;
/*!40000 ALTER TABLE `mag_catalog_category_product_index_tmp` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_category_product_index_tmp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_compare_item`
--

DROP TABLE IF EXISTS `mag_catalog_compare_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_compare_item` (
  `catalog_compare_item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Compare Item ID',
  `visitor_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Visitor ID',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store ID',
  PRIMARY KEY (`catalog_compare_item_id`),
  KEY `IDX_MAG_CATALOG_COMPARE_ITEM_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_MAG_CATALOG_COMPARE_ITEM_PRODUCT_ID` (`product_id`),
  KEY `IDX_MAG_CATALOG_COMPARE_ITEM_VISITOR_ID_PRODUCT_ID` (`visitor_id`,`product_id`),
  KEY `IDX_MAG_CATALOG_COMPARE_ITEM_CUSTOMER_ID_PRODUCT_ID` (`customer_id`,`product_id`),
  KEY `IDX_MAG_CATALOG_COMPARE_ITEM_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MAG_CATALOG_COMPARE_ITEM_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_CMP_ITEM_CSTR_ID_MAG_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `mag_customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_CMP_ITEM_PRD_ID_MAG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Compare Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_compare_item`
--

LOCK TABLES `mag_catalog_compare_item` WRITE;
/*!40000 ALTER TABLE `mag_catalog_compare_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_compare_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_eav_attribute`
--

DROP TABLE IF EXISTS `mag_catalog_eav_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_eav_attribute` (
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `frontend_input_renderer` varchar(255) DEFAULT NULL COMMENT 'Frontend Input Renderer',
  `is_global` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Global',
  `is_visible` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Visible',
  `is_searchable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Searchable',
  `is_filterable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Filterable',
  `is_comparable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Comparable',
  `is_visible_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible On Front',
  `is_html_allowed_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is HTML Allowed On Front',
  `is_used_for_price_rules` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Used For Price Rules',
  `is_filterable_in_search` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Filterable In Search',
  `used_in_product_listing` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Used In Product Listing',
  `used_for_sort_by` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Used For Sorting',
  `is_configurable` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Configurable',
  `apply_to` varchar(255) DEFAULT NULL COMMENT 'Apply To',
  `is_visible_in_advanced_search` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible In Advanced Search',
  `position` int(11) NOT NULL DEFAULT '0' COMMENT 'Position',
  `is_wysiwyg_enabled` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is WYSIWYG Enabled',
  `is_used_for_promo_rules` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Used For Promo Rules',
  PRIMARY KEY (`attribute_id`),
  KEY `IDX_MAG_CATALOG_EAV_ATTRIBUTE_USED_FOR_SORT_BY` (`used_for_sort_by`),
  KEY `IDX_MAG_CATALOG_EAV_ATTRIBUTE_USED_IN_PRODUCT_LISTING` (`used_in_product_listing`),
  CONSTRAINT `FK_MAG_CAT_EAV_ATTR_ATTR_ID_MAG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mag_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog EAV Attribute Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_eav_attribute`
--

LOCK TABLES `mag_catalog_eav_attribute` WRITE;
/*!40000 ALTER TABLE `mag_catalog_eav_attribute` DISABLE KEYS */;
INSERT INTO `mag_catalog_eav_attribute` VALUES (41,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(42,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(43,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(44,NULL,0,1,0,0,0,0,1,0,0,0,0,1,NULL,0,0,1,0),(45,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(46,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(47,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(48,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(49,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(50,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(51,NULL,1,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(52,NULL,1,0,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(53,NULL,1,0,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(54,NULL,1,0,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(55,NULL,1,0,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(56,NULL,1,0,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(57,NULL,0,0,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(58,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(59,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(60,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(61,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(62,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(63,NULL,1,0,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(64,NULL,1,0,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(65,'adminhtml/catalog_category_helper_sortby_available',0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(66,'adminhtml/catalog_category_helper_sortby_default',0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(67,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(68,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(69,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(70,'adminhtml/catalog_category_helper_pricestep',0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(71,NULL,0,1,1,0,0,0,0,0,0,1,1,1,NULL,1,0,0,0),(72,NULL,0,1,1,0,1,0,1,0,0,0,0,1,NULL,1,0,1,0),(73,NULL,0,1,1,0,1,0,1,0,0,1,0,1,NULL,1,0,1,0),(74,NULL,1,1,1,0,1,0,0,0,0,0,0,1,NULL,1,0,0,0),(75,NULL,2,1,1,1,0,0,0,0,0,1,1,1,'simple,configurable,virtual,bundle,downloadable',1,0,0,0),(76,NULL,2,1,0,0,0,0,0,0,0,1,0,1,'simple,configurable,virtual,bundle,downloadable',0,0,0,0),(77,NULL,2,1,0,0,0,0,0,0,0,1,0,1,'simple,configurable,virtual,bundle,downloadable',0,0,0,0),(78,NULL,2,1,0,0,0,0,0,0,0,1,0,1,'simple,configurable,virtual,bundle,downloadable',0,0,0,0),(79,NULL,2,1,0,0,0,0,0,0,0,0,0,1,'virtual,downloadable',0,0,0,0),(80,NULL,1,1,0,0,0,0,0,0,0,0,0,1,'simple,bundle',0,0,0,0),(81,NULL,1,1,1,1,1,0,0,0,0,0,0,1,'simple',1,0,0,0),(82,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(83,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(84,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(85,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(86,NULL,0,1,0,0,0,0,0,0,0,1,0,1,NULL,0,0,0,0),(87,NULL,0,1,0,0,0,0,0,0,0,1,0,1,NULL,0,0,0,0),(88,NULL,1,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(89,NULL,1,0,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(90,NULL,2,1,0,0,0,0,0,0,0,0,0,1,'simple,configurable,virtual,bundle,downloadable',0,0,0,0),(91,NULL,2,1,0,0,0,0,0,0,0,0,0,1,'simple,configurable,virtual,bundle,downloadable',0,0,0,0),(92,NULL,1,1,1,1,1,0,0,0,0,0,0,1,'simple',1,0,0,0),(93,NULL,2,1,0,0,0,0,0,0,0,1,0,1,NULL,0,0,0,0),(94,NULL,2,1,0,0,0,0,0,0,0,1,0,1,NULL,0,0,0,0),(95,NULL,1,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(96,NULL,2,1,1,0,0,0,0,0,0,1,0,1,NULL,0,0,0,0),(97,NULL,0,1,0,0,0,0,0,0,0,1,0,1,NULL,0,0,0,0),(98,NULL,0,0,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(99,NULL,0,0,0,0,0,0,0,0,0,0,0,1,'simple,configurable,virtual,bundle,downloadable',0,0,0,0),(100,NULL,1,1,0,0,0,0,0,0,0,0,0,0,'simple,virtual',0,0,0,0),(101,NULL,1,1,0,0,0,0,0,0,0,0,0,0,'simple,virtual',0,0,0,0),(102,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(103,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(104,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(105,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(106,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(107,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(108,NULL,1,0,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(109,NULL,0,1,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(110,NULL,1,0,0,0,0,0,0,0,0,1,0,1,NULL,0,0,0,0),(111,NULL,1,0,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(112,NULL,0,0,0,0,0,0,0,0,0,1,0,0,NULL,0,0,0,0),(113,NULL,0,0,0,0,0,0,0,0,0,1,0,0,NULL,0,0,0,0),(114,NULL,0,0,0,0,0,0,0,0,0,1,0,0,NULL,0,0,0,0),(115,NULL,1,0,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(116,NULL,1,0,0,0,0,0,0,0,0,0,0,1,NULL,0,0,0,0),(117,NULL,2,1,0,0,0,0,0,0,0,0,0,0,'simple,configurable,bundle,grouped',0,0,0,0),(118,'adminhtml/catalog_product_helper_form_msrp_enabled',2,1,0,0,0,0,0,0,0,1,0,1,'simple,bundle,configurable,virtual,downloadable',0,0,0,0),(119,'adminhtml/catalog_product_helper_form_msrp_price',2,1,0,0,0,0,0,0,0,1,0,1,'simple,bundle,configurable,virtual,downloadable',0,0,0,0),(120,NULL,2,1,0,0,0,0,0,0,0,1,0,1,'simple,bundle,configurable,virtual,downloadable',0,0,0,0),(121,NULL,2,1,1,0,0,0,0,0,0,1,0,1,'simple,configurable,virtual,downloadable,bundle',1,0,0,0),(122,'giftmessage/adminhtml_product_helper_form_config',1,1,0,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0),(123,NULL,1,0,0,0,0,0,0,0,0,1,0,0,'bundle',0,0,0,0),(124,NULL,1,0,0,0,0,0,0,0,0,0,0,0,'bundle',0,0,0,0),(125,NULL,1,0,0,0,0,0,0,0,0,1,0,0,'bundle',0,0,0,0),(126,NULL,1,1,0,0,0,0,0,0,0,1,0,0,'bundle',0,0,0,0),(127,NULL,1,0,0,0,0,0,0,0,0,1,0,0,'bundle',0,0,0,0),(128,NULL,1,0,0,0,0,0,0,0,0,1,0,0,'downloadable',0,0,0,0),(129,NULL,0,0,0,0,0,0,0,0,0,0,0,0,'downloadable',0,0,0,0),(130,NULL,0,0,0,0,0,0,0,0,0,0,0,0,'downloadable',0,0,0,0),(131,NULL,1,0,0,0,0,0,0,0,0,1,0,0,'downloadable',0,0,0,0),(132,NULL,0,1,0,0,0,1,1,0,0,0,0,1,NULL,0,0,1,0),(133,NULL,0,1,0,0,0,1,0,0,0,0,0,1,NULL,0,0,0,0),(134,NULL,0,1,0,0,0,1,1,0,0,0,0,1,NULL,0,0,1,0),(135,NULL,0,1,0,0,0,1,1,0,0,0,0,1,NULL,0,0,1,0),(136,NULL,0,1,0,0,0,1,0,0,0,0,0,1,NULL,0,0,0,0);
/*!40000 ALTER TABLE `mag_catalog_eav_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_bundle_option`
--

DROP TABLE IF EXISTS `mag_catalog_product_bundle_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_bundle_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `required` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Required',
  `position` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Position',
  `type` varchar(255) DEFAULT NULL COMMENT 'Type',
  PRIMARY KEY (`option_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_BUNDLE_OPTION_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_MAG_CAT_PRD_BNDL_OPT_PARENT_ID_MAG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`parent_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Option';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_bundle_option`
--

LOCK TABLES `mag_catalog_product_bundle_option` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_bundle_option` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_bundle_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_bundle_option_value`
--

DROP TABLE IF EXISTS `mag_catalog_product_bundle_option_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_bundle_option_value` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `option_id` int(10) unsigned NOT NULL COMMENT 'Option Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MAG_CATALOG_PRODUCT_BUNDLE_OPTION_VALUE_OPTION_ID_STORE_ID` (`option_id`,`store_id`),
  CONSTRAINT `FK_MAG_CAT_PRD_BNDL_OPT_VAL_OPT_ID_MAG_CAT_PRD_BNDL_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `mag_catalog_product_bundle_option` (`option_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Option Value';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_bundle_option_value`
--

LOCK TABLES `mag_catalog_product_bundle_option_value` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_bundle_option_value` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_bundle_option_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_bundle_price_index`
--

DROP TABLE IF EXISTS `mag_catalog_product_bundle_price_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_bundle_price_index` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `min_price` decimal(12,4) NOT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) NOT NULL COMMENT 'Max Price',
  PRIMARY KEY (`entity_id`,`website_id`,`customer_group_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_BUNDLE_PRICE_INDEX_WEBSITE_ID` (`website_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_BUNDLE_PRICE_INDEX_CUSTOMER_GROUP_ID` (`customer_group_id`),
  CONSTRAINT `FK_F2ACE5A7499536E9E3BC8C9883BA426F` FOREIGN KEY (`customer_group_id`) REFERENCES `mag_customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_BNDL_PRICE_IDX_ENTT_ID_MAG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_BNDL_PRICE_IDX_WS_ID_MAG_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `mag_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Price Index';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_bundle_price_index`
--

LOCK TABLES `mag_catalog_product_bundle_price_index` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_bundle_price_index` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_bundle_price_index` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_bundle_selection`
--

DROP TABLE IF EXISTS `mag_catalog_product_bundle_selection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_bundle_selection` (
  `selection_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Selection Id',
  `option_id` int(10) unsigned NOT NULL COMMENT 'Option Id',
  `parent_product_id` int(10) unsigned NOT NULL COMMENT 'Parent Product Id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `position` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Position',
  `is_default` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Default',
  `selection_price_type` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Selection Price Type',
  `selection_price_value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Selection Price Value',
  `selection_qty` decimal(12,4) DEFAULT NULL COMMENT 'Selection Qty',
  `selection_can_change_qty` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Selection Can Change Qty',
  PRIMARY KEY (`selection_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_BUNDLE_SELECTION_OPTION_ID` (`option_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_BUNDLE_SELECTION_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_MAG_CAT_PRD_BNDL_SELECTION_OPT_ID_MAG_CAT_PRD_BNDL_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `mag_catalog_product_bundle_option` (`option_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_BNDL_SELECTION_PRD_ID_MAG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Selection';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_bundle_selection`
--

LOCK TABLES `mag_catalog_product_bundle_selection` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_bundle_selection` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_bundle_selection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_bundle_selection_price`
--

DROP TABLE IF EXISTS `mag_catalog_product_bundle_selection_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_bundle_selection_price` (
  `selection_id` int(10) unsigned NOT NULL COMMENT 'Selection Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `selection_price_type` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Selection Price Type',
  `selection_price_value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Selection Price Value',
  PRIMARY KEY (`selection_id`,`website_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_BUNDLE_SELECTION_PRICE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_3A6AD0A44EFFF4165E886E19038A6E44` FOREIGN KEY (`selection_id`) REFERENCES `mag_catalog_product_bundle_selection` (`selection_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_BNDL_SELECTION_PRICE_WS_ID_MAG_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `mag_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Selection Price';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_bundle_selection_price`
--

LOCK TABLES `mag_catalog_product_bundle_selection_price` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_bundle_selection_price` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_bundle_selection_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_bundle_stock_index`
--

DROP TABLE IF EXISTS `mag_catalog_product_bundle_stock_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_bundle_stock_index` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `stock_id` smallint(5) unsigned NOT NULL COMMENT 'Stock Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `stock_status` smallint(6) DEFAULT '0' COMMENT 'Stock Status',
  PRIMARY KEY (`entity_id`,`website_id`,`stock_id`,`option_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Bundle Stock Index';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_bundle_stock_index`
--

LOCK TABLES `mag_catalog_product_bundle_stock_index` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_bundle_stock_index` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_bundle_stock_index` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_enabled_index`
--

DROP TABLE IF EXISTS `mag_catalog_product_enabled_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_enabled_index` (
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `visibility` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Visibility',
  PRIMARY KEY (`product_id`,`store_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_ENABLED_INDEX_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MAG_CAT_PRD_ENABLED_IDX_PRD_ID_MAG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_ENABLED_IDX_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Visibility Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_enabled_index`
--

LOCK TABLES `mag_catalog_product_enabled_index` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_enabled_index` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_enabled_index` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_entity`
--

DROP TABLE IF EXISTS `mag_catalog_product_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_entity` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set ID',
  `type_id` varchar(32) NOT NULL DEFAULT 'simple' COMMENT 'Type ID',
  `sku` varchar(64) DEFAULT NULL COMMENT 'SKU',
  `has_options` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Has Options',
  `required_options` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Required Options',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Creation Time',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Update Time',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_ENTITY_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_ENTITY_ATTRIBUTE_SET_ID` (`attribute_set_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_ENTITY_SKU` (`sku`),
  CONSTRAINT `FK_MAG_CAT_PRD_ENTT_ATTR_SET_ID_MAG_EAV_ATTR_SET_ATTR_SET_ID` FOREIGN KEY (`attribute_set_id`) REFERENCES `mag_eav_attribute_set` (`attribute_set_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_ENTT_ENTT_TYPE_ID_MAG_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `mag_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_entity`
--

LOCK TABLES `mag_catalog_product_entity` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_entity` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_entity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_entity_datetime`
--

DROP TABLE IF EXISTS `mag_catalog_product_entity_datetime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_entity_datetime` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` datetime DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MAG_CAT_PRD_ENTT_DTIME_ENTT_ID_ATTR_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_ENTITY_DATETIME_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_ENTITY_DATETIME_STORE_ID` (`store_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_ENTITY_DATETIME_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_MAG_CAT_PRD_ENTT_DTIME_ATTR_ID_MAG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mag_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_ENTT_DTIME_ENTT_ID_MAG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_ENTT_DTIME_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Datetime Attribute Backend Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_entity_datetime`
--

LOCK TABLES `mag_catalog_product_entity_datetime` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_entity_datetime` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_entity_datetime` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_entity_decimal`
--

DROP TABLE IF EXISTS `mag_catalog_product_entity_decimal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_entity_decimal` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` decimal(12,4) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MAG_CAT_PRD_ENTT_DEC_ENTT_ID_ATTR_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_ENTITY_DECIMAL_STORE_ID` (`store_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_ENTITY_DECIMAL_ENTITY_ID` (`entity_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_ENTITY_DECIMAL_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `FK_MAG_CAT_PRD_ENTT_DEC_ATTR_ID_MAG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mag_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_ENTT_DEC_ENTT_ID_MAG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_ENTT_DEC_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Decimal Attribute Backend Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_entity_decimal`
--

LOCK TABLES `mag_catalog_product_entity_decimal` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_entity_decimal` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_entity_decimal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_entity_gallery`
--

DROP TABLE IF EXISTS `mag_catalog_product_entity_gallery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_entity_gallery` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `position` int(11) NOT NULL DEFAULT '0' COMMENT 'Position',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MAG_CAT_PRD_ENTT_GLR_ENTT_TYPE_ID_ENTT_ID_ATTR_ID_STORE_ID` (`entity_type_id`,`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_ENTITY_GALLERY_ENTITY_ID` (`entity_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_ENTITY_GALLERY_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_ENTITY_GALLERY_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MAG_CAT_PRD_ENTT_GLR_ATTR_ID_MAG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mag_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_ENTT_GLR_ENTT_ID_MAG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_ENTT_GLR_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Gallery Attribute Backend Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_entity_gallery`
--

LOCK TABLES `mag_catalog_product_entity_gallery` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_entity_gallery` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_entity_gallery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_entity_group_price`
--

DROP TABLE IF EXISTS `mag_catalog_product_entity_group_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_entity_group_price` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `all_groups` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Applicable To All Customer Groups',
  `customer_group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Group ID',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `C8252CE781ED7B5FFB941D5F25AA1D09` (`entity_id`,`all_groups`,`customer_group_id`,`website_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_ENTITY_GROUP_PRICE_ENTITY_ID` (`entity_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_ENTITY_GROUP_PRICE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_ENTITY_GROUP_PRICE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_3CC99B93A7F55BF09A4FE1A98D4DBE68` FOREIGN KEY (`customer_group_id`) REFERENCES `mag_customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_ENTT_GROUP_PRICE_ENTT_ID_MAG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_ENTT_GROUP_PRICE_WS_ID_MAG_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `mag_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Group Price Attribute Backend Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_entity_group_price`
--

LOCK TABLES `mag_catalog_product_entity_group_price` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_entity_group_price` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_entity_group_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_entity_int`
--

DROP TABLE IF EXISTS `mag_catalog_product_entity_int`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_entity_int` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` int(11) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MAG_CAT_PRD_ENTT_INT_ENTT_ID_ATTR_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_ENTITY_INT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_ENTITY_INT_STORE_ID` (`store_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_ENTITY_INT_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_MAG_CAT_PRD_ENTT_INT_ATTR_ID_MAG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mag_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_ENTT_INT_ENTT_ID_MAG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_ENTT_INT_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Integer Attribute Backend Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_entity_int`
--

LOCK TABLES `mag_catalog_product_entity_int` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_entity_int` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_entity_int` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_entity_media_gallery`
--

DROP TABLE IF EXISTS `mag_catalog_product_entity_media_gallery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_entity_media_gallery` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_ENTITY_MEDIA_GALLERY_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_ENTITY_MEDIA_GALLERY_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_MAG_CAT_PRD_ENTT_MDA_GLR_ATTR_ID_MAG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mag_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_ENTT_MDA_GLR_ENTT_ID_MAG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Media Gallery Attribute Backend Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_entity_media_gallery`
--

LOCK TABLES `mag_catalog_product_entity_media_gallery` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_entity_media_gallery` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_entity_media_gallery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_entity_media_gallery_value`
--

DROP TABLE IF EXISTS `mag_catalog_product_entity_media_gallery_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_entity_media_gallery_value` (
  `value_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Value ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `label` varchar(255) DEFAULT NULL COMMENT 'Label',
  `position` int(10) unsigned DEFAULT NULL COMMENT 'Position',
  `disabled` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Disabled',
  PRIMARY KEY (`value_id`,`store_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_ENTITY_MEDIA_GALLERY_VALUE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_429A1A8B83CCDE27F0D67D9F4D207187` FOREIGN KEY (`value_id`) REFERENCES `mag_catalog_product_entity_media_gallery` (`value_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_ENTT_MDA_GLR_VAL_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Media Gallery Attribute Value Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_entity_media_gallery_value`
--

LOCK TABLES `mag_catalog_product_entity_media_gallery_value` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_entity_media_gallery_value` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_entity_media_gallery_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_entity_text`
--

DROP TABLE IF EXISTS `mag_catalog_product_entity_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_entity_text` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` text COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MAG_CAT_PRD_ENTT_TEXT_ENTT_ID_ATTR_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_ENTITY_TEXT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_ENTITY_TEXT_STORE_ID` (`store_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_ENTITY_TEXT_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_MAG_CAT_PRD_ENTT_TEXT_ATTR_ID_MAG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mag_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_ENTT_TEXT_ENTT_ID_MAG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_ENTT_TEXT_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Text Attribute Backend Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_entity_text`
--

LOCK TABLES `mag_catalog_product_entity_text` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_entity_text` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_entity_text` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_entity_tier_price`
--

DROP TABLE IF EXISTS `mag_catalog_product_entity_tier_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_entity_tier_price` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `all_groups` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Applicable To All Customer Groups',
  `customer_group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Group ID',
  `qty` decimal(12,4) NOT NULL DEFAULT '1.0000' COMMENT 'QTY',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `03C65988CEC92BC811724E9726843968` (`entity_id`,`all_groups`,`customer_group_id`,`qty`,`website_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_ENTITY_TIER_PRICE_ENTITY_ID` (`entity_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_ENTITY_TIER_PRICE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_ENTITY_TIER_PRICE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_AAC4C59C15EACEAC2F4E9643EC2E49F6` FOREIGN KEY (`customer_group_id`) REFERENCES `mag_customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_ENTT_TIER_PRICE_ENTT_ID_MAG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_ENTT_TIER_PRICE_WS_ID_MAG_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `mag_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Tier Price Attribute Backend Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_entity_tier_price`
--

LOCK TABLES `mag_catalog_product_entity_tier_price` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_entity_tier_price` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_entity_tier_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_entity_varchar`
--

DROP TABLE IF EXISTS `mag_catalog_product_entity_varchar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_entity_varchar` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `entity_type_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MAG_CAT_PRD_ENTT_VCHR_ENTT_ID_ATTR_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_ENTITY_VARCHAR_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_ENTITY_VARCHAR_STORE_ID` (`store_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_ENTITY_VARCHAR_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_MAG_CAT_PRD_ENTT_VCHR_ATTR_ID_MAG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mag_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_ENTT_VCHR_ENTT_ID_MAG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_ENTT_VCHR_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Varchar Attribute Backend Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_entity_varchar`
--

LOCK TABLES `mag_catalog_product_entity_varchar` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_entity_varchar` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_entity_varchar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_index_eav`
--

DROP TABLE IF EXISTS `mag_catalog_product_index_eav`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_index_eav` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` int(10) unsigned NOT NULL COMMENT 'Value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`,`value`),
  KEY `IDX_MAG_CATALOG_PRODUCT_INDEX_EAV_ENTITY_ID` (`entity_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_INDEX_EAV_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_INDEX_EAV_STORE_ID` (`store_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_INDEX_EAV_VALUE` (`value`),
  CONSTRAINT `FK_MAG_CAT_PRD_IDX_EAV_ATTR_ID_MAG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mag_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_IDX_EAV_ENTT_ID_MAG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_IDX_EAV_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_index_eav`
--

LOCK TABLES `mag_catalog_product_index_eav` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_index_eav` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_index_eav` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_index_eav_decimal`
--

DROP TABLE IF EXISTS `mag_catalog_product_index_eav_decimal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_index_eav_decimal` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` decimal(12,4) NOT NULL COMMENT 'Value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_ENTITY_ID` (`entity_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_STORE_ID` (`store_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_VALUE` (`value`),
  CONSTRAINT `FK_MAG_CAT_PRD_IDX_EAV_DEC_ATTR_ID_MAG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mag_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_IDX_EAV_DEC_ENTT_ID_MAG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_IDX_EAV_DEC_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Decimal Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_index_eav_decimal`
--

LOCK TABLES `mag_catalog_product_index_eav_decimal` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_index_eav_decimal` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_index_eav_decimal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_index_eav_decimal_idx`
--

DROP TABLE IF EXISTS `mag_catalog_product_index_eav_decimal_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_index_eav_decimal_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` decimal(12,4) NOT NULL COMMENT 'Value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`,`value`),
  KEY `IDX_MAG_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_IDX_ENTITY_ID` (`entity_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_IDX_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_IDX_STORE_ID` (`store_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_IDX_VALUE` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Decimal Indexer Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_index_eav_decimal_idx`
--

LOCK TABLES `mag_catalog_product_index_eav_decimal_idx` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_index_eav_decimal_idx` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_index_eav_decimal_idx` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_index_eav_decimal_tmp`
--

DROP TABLE IF EXISTS `mag_catalog_product_index_eav_decimal_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_index_eav_decimal_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` decimal(12,4) NOT NULL COMMENT 'Value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_TMP_ENTITY_ID` (`entity_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_TMP_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_TMP_STORE_ID` (`store_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_INDEX_EAV_DECIMAL_TMP_VALUE` (`value`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Decimal Indexer Temp Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_index_eav_decimal_tmp`
--

LOCK TABLES `mag_catalog_product_index_eav_decimal_tmp` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_index_eav_decimal_tmp` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_index_eav_decimal_tmp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_index_eav_idx`
--

DROP TABLE IF EXISTS `mag_catalog_product_index_eav_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_index_eav_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` int(10) unsigned NOT NULL COMMENT 'Value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`,`value`),
  KEY `IDX_MAG_CATALOG_PRODUCT_INDEX_EAV_IDX_ENTITY_ID` (`entity_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_INDEX_EAV_IDX_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_INDEX_EAV_IDX_STORE_ID` (`store_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_INDEX_EAV_IDX_VALUE` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Indexer Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_index_eav_idx`
--

LOCK TABLES `mag_catalog_product_index_eav_idx` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_index_eav_idx` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_index_eav_idx` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_index_eav_tmp`
--

DROP TABLE IF EXISTS `mag_catalog_product_index_eav_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_index_eav_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `value` int(10) unsigned NOT NULL COMMENT 'Value',
  PRIMARY KEY (`entity_id`,`attribute_id`,`store_id`,`value`),
  KEY `IDX_MAG_CATALOG_PRODUCT_INDEX_EAV_TMP_ENTITY_ID` (`entity_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_INDEX_EAV_TMP_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_INDEX_EAV_TMP_STORE_ID` (`store_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_INDEX_EAV_TMP_VALUE` (`value`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product EAV Indexer Temp Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_index_eav_tmp`
--

LOCK TABLES `mag_catalog_product_index_eav_tmp` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_index_eav_tmp` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_index_eav_tmp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_index_group_price`
--

DROP TABLE IF EXISTS `mag_catalog_product_index_group_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_index_group_price` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_INDEX_GROUP_PRICE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_INDEX_GROUP_PRICE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_038B7B2458827CE4C833A38FA407ED83` FOREIGN KEY (`customer_group_id`) REFERENCES `mag_customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_IDX_GROUP_PRICE_ENTT_ID_MAG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_IDX_GROUP_PRICE_WS_ID_MAG_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `mag_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Group Price Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_index_group_price`
--

LOCK TABLES `mag_catalog_product_index_group_price` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_index_group_price` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_index_group_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_index_price`
--

DROP TABLE IF EXISTS `mag_catalog_product_index_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_index_price` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class ID',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `final_price` decimal(12,4) DEFAULT NULL COMMENT 'Final Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_INDEX_PRICE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_INDEX_PRICE_WEBSITE_ID` (`website_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_INDEX_PRICE_MIN_PRICE` (`min_price`),
  KEY `IDX_MAG_CAT_PRD_IDX_PRICE_WS_ID_CSTR_GROUP_ID_MIN_PRICE` (`website_id`,`customer_group_id`,`min_price`),
  CONSTRAINT `FK_3B94CB707E5135CBD90DE1EE80F71141` FOREIGN KEY (`customer_group_id`) REFERENCES `mag_customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_IDX_PRICE_ENTT_ID_MAG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_IDX_PRICE_WS_ID_MAG_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `mag_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_index_price`
--

LOCK TABLES `mag_catalog_product_index_price` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_index_price` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_index_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_index_price_bundle_idx`
--

DROP TABLE IF EXISTS `mag_catalog_product_index_price_bundle_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_index_price_bundle_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class Id',
  `price_type` smallint(5) unsigned NOT NULL COMMENT 'Price Type',
  `special_price` decimal(12,4) DEFAULT NULL COMMENT 'Special Price',
  `tier_percent` decimal(12,4) DEFAULT NULL COMMENT 'Tier Percent',
  `orig_price` decimal(12,4) DEFAULT NULL COMMENT 'Orig Price',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `base_tier` decimal(12,4) DEFAULT NULL COMMENT 'Base Tier',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  `base_group_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Group Price',
  `group_price_percent` decimal(12,4) DEFAULT NULL COMMENT 'Group Price Percent',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Idx';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_index_price_bundle_idx`
--

LOCK TABLES `mag_catalog_product_index_price_bundle_idx` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_index_price_bundle_idx` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_index_price_bundle_idx` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_index_price_bundle_opt_idx`
--

DROP TABLE IF EXISTS `mag_catalog_product_index_price_bundle_opt_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_index_price_bundle_opt_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `alt_price` decimal(12,4) DEFAULT NULL COMMENT 'Alt Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `alt_tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Alt Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  `alt_group_price` decimal(12,4) DEFAULT NULL COMMENT 'Alt Group Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Opt Idx';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_index_price_bundle_opt_idx`
--

LOCK TABLES `mag_catalog_product_index_price_bundle_opt_idx` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_index_price_bundle_opt_idx` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_index_price_bundle_opt_idx` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_index_price_bundle_opt_tmp`
--

DROP TABLE IF EXISTS `mag_catalog_product_index_price_bundle_opt_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_index_price_bundle_opt_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `alt_price` decimal(12,4) DEFAULT NULL COMMENT 'Alt Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `alt_tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Alt Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  `alt_group_price` decimal(12,4) DEFAULT NULL COMMENT 'Alt Group Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Opt Tmp';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_index_price_bundle_opt_tmp`
--

LOCK TABLES `mag_catalog_product_index_price_bundle_opt_tmp` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_index_price_bundle_opt_tmp` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_index_price_bundle_opt_tmp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_index_price_bundle_sel_idx`
--

DROP TABLE IF EXISTS `mag_catalog_product_index_price_bundle_sel_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_index_price_bundle_sel_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `selection_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Selection Id',
  `group_type` smallint(5) unsigned DEFAULT '0' COMMENT 'Group Type',
  `is_required` smallint(5) unsigned DEFAULT '0' COMMENT 'Is Required',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`,`selection_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Sel Idx';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_index_price_bundle_sel_idx`
--

LOCK TABLES `mag_catalog_product_index_price_bundle_sel_idx` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_index_price_bundle_sel_idx` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_index_price_bundle_sel_idx` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_index_price_bundle_sel_tmp`
--

DROP TABLE IF EXISTS `mag_catalog_product_index_price_bundle_sel_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_index_price_bundle_sel_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `selection_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Selection Id',
  `group_type` smallint(5) unsigned DEFAULT '0' COMMENT 'Group Type',
  `is_required` smallint(5) unsigned DEFAULT '0' COMMENT 'Is Required',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`,`selection_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Sel Tmp';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_index_price_bundle_sel_tmp`
--

LOCK TABLES `mag_catalog_product_index_price_bundle_sel_tmp` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_index_price_bundle_sel_tmp` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_index_price_bundle_sel_tmp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_index_price_bundle_tmp`
--

DROP TABLE IF EXISTS `mag_catalog_product_index_price_bundle_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_index_price_bundle_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class Id',
  `price_type` smallint(5) unsigned NOT NULL COMMENT 'Price Type',
  `special_price` decimal(12,4) DEFAULT NULL COMMENT 'Special Price',
  `tier_percent` decimal(12,4) DEFAULT NULL COMMENT 'Tier Percent',
  `orig_price` decimal(12,4) DEFAULT NULL COMMENT 'Orig Price',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `base_tier` decimal(12,4) DEFAULT NULL COMMENT 'Base Tier',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  `base_group_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Group Price',
  `group_price_percent` decimal(12,4) DEFAULT NULL COMMENT 'Group Price Percent',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Index Price Bundle Tmp';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_index_price_bundle_tmp`
--

LOCK TABLES `mag_catalog_product_index_price_bundle_tmp` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_index_price_bundle_tmp` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_index_price_bundle_tmp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_index_price_cfg_opt_agr_idx`
--

DROP TABLE IF EXISTS `mag_catalog_product_index_price_cfg_opt_agr_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_index_price_cfg_opt_agr_idx` (
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent ID',
  `child_id` int(10) unsigned NOT NULL COMMENT 'Child ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`parent_id`,`child_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Config Option Aggregate Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_index_price_cfg_opt_agr_idx`
--

LOCK TABLES `mag_catalog_product_index_price_cfg_opt_agr_idx` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_index_price_cfg_opt_agr_idx` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_index_price_cfg_opt_agr_idx` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_index_price_cfg_opt_agr_tmp`
--

DROP TABLE IF EXISTS `mag_catalog_product_index_price_cfg_opt_agr_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_index_price_cfg_opt_agr_tmp` (
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent ID',
  `child_id` int(10) unsigned NOT NULL COMMENT 'Child ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`parent_id`,`child_id`,`customer_group_id`,`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Config Option Aggregate Temp Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_index_price_cfg_opt_agr_tmp`
--

LOCK TABLES `mag_catalog_product_index_price_cfg_opt_agr_tmp` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_index_price_cfg_opt_agr_tmp` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_index_price_cfg_opt_agr_tmp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_index_price_cfg_opt_idx`
--

DROP TABLE IF EXISTS `mag_catalog_product_index_price_cfg_opt_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_index_price_cfg_opt_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Config Option Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_index_price_cfg_opt_idx`
--

LOCK TABLES `mag_catalog_product_index_price_cfg_opt_idx` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_index_price_cfg_opt_idx` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_index_price_cfg_opt_idx` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_index_price_cfg_opt_tmp`
--

DROP TABLE IF EXISTS `mag_catalog_product_index_price_cfg_opt_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_index_price_cfg_opt_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Config Option Temp Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_index_price_cfg_opt_tmp`
--

LOCK TABLES `mag_catalog_product_index_price_cfg_opt_tmp` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_index_price_cfg_opt_tmp` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_index_price_cfg_opt_tmp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_index_price_downlod_idx`
--

DROP TABLE IF EXISTS `mag_catalog_product_index_price_downlod_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_index_price_downlod_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Minimum price',
  `max_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Maximum price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Indexer Table for price of downloadable products';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_index_price_downlod_idx`
--

LOCK TABLES `mag_catalog_product_index_price_downlod_idx` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_index_price_downlod_idx` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_index_price_downlod_idx` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_index_price_downlod_tmp`
--

DROP TABLE IF EXISTS `mag_catalog_product_index_price_downlod_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_index_price_downlod_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Minimum price',
  `max_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Maximum price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Temporary Indexer Table for price of downloadable products';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_index_price_downlod_tmp`
--

LOCK TABLES `mag_catalog_product_index_price_downlod_tmp` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_index_price_downlod_tmp` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_index_price_downlod_tmp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_index_price_final_idx`
--

DROP TABLE IF EXISTS `mag_catalog_product_index_price_final_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_index_price_final_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class ID',
  `orig_price` decimal(12,4) DEFAULT NULL COMMENT 'Original Price',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `base_tier` decimal(12,4) DEFAULT NULL COMMENT 'Base Tier',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  `base_group_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Group Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Final Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_index_price_final_idx`
--

LOCK TABLES `mag_catalog_product_index_price_final_idx` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_index_price_final_idx` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_index_price_final_idx` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_index_price_final_tmp`
--

DROP TABLE IF EXISTS `mag_catalog_product_index_price_final_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_index_price_final_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class ID',
  `orig_price` decimal(12,4) DEFAULT NULL COMMENT 'Original Price',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `base_tier` decimal(12,4) DEFAULT NULL COMMENT 'Base Tier',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  `base_group_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Group Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Final Temp Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_index_price_final_tmp`
--

LOCK TABLES `mag_catalog_product_index_price_final_tmp` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_index_price_final_tmp` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_index_price_final_tmp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_index_price_idx`
--

DROP TABLE IF EXISTS `mag_catalog_product_index_price_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_index_price_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class ID',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `final_price` decimal(12,4) DEFAULT NULL COMMENT 'Final Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_INDEX_PRICE_IDX_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_INDEX_PRICE_IDX_WEBSITE_ID` (`website_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_INDEX_PRICE_IDX_MIN_PRICE` (`min_price`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_index_price_idx`
--

LOCK TABLES `mag_catalog_product_index_price_idx` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_index_price_idx` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_index_price_idx` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_index_price_opt_agr_idx`
--

DROP TABLE IF EXISTS `mag_catalog_product_index_price_opt_agr_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_index_price_opt_agr_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Option Aggregate Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_index_price_opt_agr_idx`
--

LOCK TABLES `mag_catalog_product_index_price_opt_agr_idx` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_index_price_opt_agr_idx` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_index_price_opt_agr_idx` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_index_price_opt_agr_tmp`
--

DROP TABLE IF EXISTS `mag_catalog_product_index_price_opt_agr_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_index_price_opt_agr_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`,`option_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Option Aggregate Temp Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_index_price_opt_agr_tmp`
--

LOCK TABLES `mag_catalog_product_index_price_opt_agr_tmp` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_index_price_opt_agr_tmp` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_index_price_opt_agr_tmp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_index_price_opt_idx`
--

DROP TABLE IF EXISTS `mag_catalog_product_index_price_opt_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_index_price_opt_idx` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Option Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_index_price_opt_idx`
--

LOCK TABLES `mag_catalog_product_index_price_opt_idx` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_index_price_opt_idx` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_index_price_opt_idx` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_index_price_opt_tmp`
--

DROP TABLE IF EXISTS `mag_catalog_product_index_price_opt_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_index_price_opt_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Option Temp Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_index_price_opt_tmp`
--

LOCK TABLES `mag_catalog_product_index_price_opt_tmp` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_index_price_opt_tmp` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_index_price_opt_tmp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_index_price_tmp`
--

DROP TABLE IF EXISTS `mag_catalog_product_index_price_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_index_price_tmp` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `tax_class_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Tax Class ID',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `final_price` decimal(12,4) DEFAULT NULL COMMENT 'Final Price',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  `max_price` decimal(12,4) DEFAULT NULL COMMENT 'Max Price',
  `tier_price` decimal(12,4) DEFAULT NULL COMMENT 'Tier Price',
  `group_price` decimal(12,4) DEFAULT NULL COMMENT 'Group price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_INDEX_PRICE_TMP_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_INDEX_PRICE_TMP_WEBSITE_ID` (`website_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_INDEX_PRICE_TMP_MIN_PRICE` (`min_price`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Catalog Product Price Indexer Temp Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_index_price_tmp`
--

LOCK TABLES `mag_catalog_product_index_price_tmp` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_index_price_tmp` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_index_price_tmp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_index_tier_price`
--

DROP TABLE IF EXISTS `mag_catalog_product_index_tier_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_index_tier_price` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity ID',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `min_price` decimal(12,4) DEFAULT NULL COMMENT 'Min Price',
  PRIMARY KEY (`entity_id`,`customer_group_id`,`website_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_INDEX_TIER_PRICE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_INDEX_TIER_PRICE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_C4B342B0C711FE97F7E37F03C2D68666` FOREIGN KEY (`customer_group_id`) REFERENCES `mag_customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_IDX_TIER_PRICE_ENTT_ID_MAG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_IDX_TIER_PRICE_WS_ID_MAG_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `mag_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Tier Price Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_index_tier_price`
--

LOCK TABLES `mag_catalog_product_index_tier_price` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_index_tier_price` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_index_tier_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_index_website`
--

DROP TABLE IF EXISTS `mag_catalog_product_index_website`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_index_website` (
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  `website_date` date DEFAULT NULL COMMENT 'Website Date',
  `rate` float DEFAULT '1' COMMENT 'Rate',
  PRIMARY KEY (`website_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_INDEX_WEBSITE_WEBSITE_DATE` (`website_date`),
  CONSTRAINT `FK_MAG_CAT_PRD_IDX_WS_WS_ID_MAG_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `mag_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Website Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_index_website`
--

LOCK TABLES `mag_catalog_product_index_website` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_index_website` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_index_website` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_link`
--

DROP TABLE IF EXISTS `mag_catalog_product_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_link` (
  `link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Link ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `linked_product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Linked Product ID',
  `link_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Link Type ID',
  PRIMARY KEY (`link_id`),
  UNIQUE KEY `UNQ_MAG_CAT_PRD_LNK_LNK_TYPE_ID_PRD_ID_LNKED_PRD_ID` (`link_type_id`,`product_id`,`linked_product_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_LINK_PRODUCT_ID` (`product_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_LINK_LINKED_PRODUCT_ID` (`linked_product_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_LINK_LINK_TYPE_ID` (`link_type_id`),
  CONSTRAINT `FK_MAG_CAT_PRD_LNK_LNKED_PRD_ID_MAG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`linked_product_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_LNK_LNK_TYPE_ID_MAG_CAT_PRD_LNK_TYPE_LNK_TYPE_ID` FOREIGN KEY (`link_type_id`) REFERENCES `mag_catalog_product_link_type` (`link_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_LNK_PRD_ID_MAG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product To Product Linkage Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_link`
--

LOCK TABLES `mag_catalog_product_link` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_link` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_link` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_link_attribute`
--

DROP TABLE IF EXISTS `mag_catalog_product_link_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_link_attribute` (
  `product_link_attribute_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Product Link Attribute ID',
  `link_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Link Type ID',
  `product_link_attribute_code` varchar(32) DEFAULT NULL COMMENT 'Product Link Attribute Code',
  `data_type` varchar(32) DEFAULT NULL COMMENT 'Data Type',
  PRIMARY KEY (`product_link_attribute_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_LINK_ATTRIBUTE_LINK_TYPE_ID` (`link_type_id`),
  CONSTRAINT `FK_2843C2FD1AD431823F9DC54BDF9DC48A` FOREIGN KEY (`link_type_id`) REFERENCES `mag_catalog_product_link_type` (`link_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='Catalog Product Link Attribute Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_link_attribute`
--

LOCK TABLES `mag_catalog_product_link_attribute` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_link_attribute` DISABLE KEYS */;
INSERT INTO `mag_catalog_product_link_attribute` VALUES (1,1,'position','int'),(2,3,'position','int'),(3,3,'qty','decimal'),(4,4,'position','int'),(5,5,'position','int');
/*!40000 ALTER TABLE `mag_catalog_product_link_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_link_attribute_decimal`
--

DROP TABLE IF EXISTS `mag_catalog_product_link_attribute_decimal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_link_attribute_decimal` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `product_link_attribute_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Product Link Attribute ID',
  `link_id` int(10) unsigned NOT NULL COMMENT 'Link ID',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MAG_CAT_PRD_LNK_ATTR_DEC_PRD_LNK_ATTR_ID_LNK_ID` (`product_link_attribute_id`,`link_id`),
  KEY `IDX_MAG_CAT_PRD_LNK_ATTR_DEC_PRD_LNK_ATTR_ID` (`product_link_attribute_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_LINK_ATTRIBUTE_DECIMAL_LINK_ID` (`link_id`),
  CONSTRAINT `FK_6E15E8A572DEBF05F629AA261E9A5622` FOREIGN KEY (`product_link_attribute_id`) REFERENCES `mag_catalog_product_link_attribute` (`product_link_attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_LNK_ATTR_DEC_LNK_ID_MAG_CAT_PRD_LNK_LNK_ID` FOREIGN KEY (`link_id`) REFERENCES `mag_catalog_product_link` (`link_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Link Decimal Attribute Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_link_attribute_decimal`
--

LOCK TABLES `mag_catalog_product_link_attribute_decimal` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_link_attribute_decimal` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_link_attribute_decimal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_link_attribute_int`
--

DROP TABLE IF EXISTS `mag_catalog_product_link_attribute_int`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_link_attribute_int` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `product_link_attribute_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Product Link Attribute ID',
  `link_id` int(10) unsigned NOT NULL COMMENT 'Link ID',
  `value` int(11) NOT NULL DEFAULT '0' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MAG_CAT_PRD_LNK_ATTR_INT_PRD_LNK_ATTR_ID_LNK_ID` (`product_link_attribute_id`,`link_id`),
  KEY `IDX_MAG_CAT_PRD_LNK_ATTR_INT_PRD_LNK_ATTR_ID` (`product_link_attribute_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_LINK_ATTRIBUTE_INT_LINK_ID` (`link_id`),
  CONSTRAINT `FK_BA08A366616DB000D81BCE4AE2964F5F` FOREIGN KEY (`product_link_attribute_id`) REFERENCES `mag_catalog_product_link_attribute` (`product_link_attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_LNK_ATTR_INT_LNK_ID_MAG_CAT_PRD_LNK_LNK_ID` FOREIGN KEY (`link_id`) REFERENCES `mag_catalog_product_link` (`link_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Link Integer Attribute Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_link_attribute_int`
--

LOCK TABLES `mag_catalog_product_link_attribute_int` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_link_attribute_int` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_link_attribute_int` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_link_attribute_varchar`
--

DROP TABLE IF EXISTS `mag_catalog_product_link_attribute_varchar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_link_attribute_varchar` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `product_link_attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Link Attribute ID',
  `link_id` int(10) unsigned NOT NULL COMMENT 'Link ID',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MAG_CAT_PRD_LNK_ATTR_VCHR_PRD_LNK_ATTR_ID_LNK_ID` (`product_link_attribute_id`,`link_id`),
  KEY `IDX_MAG_CAT_PRD_LNK_ATTR_VCHR_PRD_LNK_ATTR_ID` (`product_link_attribute_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_LINK_ATTRIBUTE_VARCHAR_LINK_ID` (`link_id`),
  CONSTRAINT `FK_9D8B3C268400E172BAA525031A4DBCD3` FOREIGN KEY (`product_link_attribute_id`) REFERENCES `mag_catalog_product_link_attribute` (`product_link_attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_LNK_ATTR_VCHR_LNK_ID_MAG_CAT_PRD_LNK_LNK_ID` FOREIGN KEY (`link_id`) REFERENCES `mag_catalog_product_link` (`link_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Link Varchar Attribute Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_link_attribute_varchar`
--

LOCK TABLES `mag_catalog_product_link_attribute_varchar` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_link_attribute_varchar` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_link_attribute_varchar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_link_type`
--

DROP TABLE IF EXISTS `mag_catalog_product_link_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_link_type` (
  `link_type_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Link Type ID',
  `code` varchar(32) DEFAULT NULL COMMENT 'Code',
  PRIMARY KEY (`link_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='Catalog Product Link Type Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_link_type`
--

LOCK TABLES `mag_catalog_product_link_type` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_link_type` DISABLE KEYS */;
INSERT INTO `mag_catalog_product_link_type` VALUES (1,'relation'),(3,'super'),(4,'up_sell'),(5,'cross_sell');
/*!40000 ALTER TABLE `mag_catalog_product_link_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_option`
--

DROP TABLE IF EXISTS `mag_catalog_product_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `type` varchar(50) DEFAULT NULL COMMENT 'Type',
  `is_require` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Is Required',
  `sku` varchar(64) DEFAULT NULL COMMENT 'SKU',
  `max_characters` int(10) unsigned DEFAULT NULL COMMENT 'Max Characters',
  `file_extension` varchar(50) DEFAULT NULL COMMENT 'File Extension',
  `image_size_x` smallint(5) unsigned DEFAULT NULL COMMENT 'Image Size X',
  `image_size_y` smallint(5) unsigned DEFAULT NULL COMMENT 'Image Size Y',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`option_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_OPTION_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_MAG_CAT_PRD_OPT_PRD_ID_MAG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_option`
--

LOCK TABLES `mag_catalog_product_option` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_option` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_option_price`
--

DROP TABLE IF EXISTS `mag_catalog_product_option_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_option_price` (
  `option_price_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Price ID',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `price_type` varchar(7) NOT NULL DEFAULT 'fixed' COMMENT 'Price Type',
  PRIMARY KEY (`option_price_id`),
  UNIQUE KEY `UNQ_MAG_CATALOG_PRODUCT_OPTION_PRICE_OPTION_ID_STORE_ID` (`option_id`,`store_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_OPTION_PRICE_OPTION_ID` (`option_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_OPTION_PRICE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MAG_CAT_PRD_OPT_PRICE_OPT_ID_MAG_CAT_PRD_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `mag_catalog_product_option` (`option_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_OPT_PRICE_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Price Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_option_price`
--

LOCK TABLES `mag_catalog_product_option_price` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_option_price` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_option_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_option_title`
--

DROP TABLE IF EXISTS `mag_catalog_product_option_title`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_option_title` (
  `option_title_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Title ID',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  PRIMARY KEY (`option_title_id`),
  UNIQUE KEY `UNQ_MAG_CATALOG_PRODUCT_OPTION_TITLE_OPTION_ID_STORE_ID` (`option_id`,`store_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_OPTION_TITLE_OPTION_ID` (`option_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_OPTION_TITLE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MAG_CAT_PRD_OPT_TTL_OPT_ID_MAG_CAT_PRD_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `mag_catalog_product_option` (`option_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_OPT_TTL_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Title Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_option_title`
--

LOCK TABLES `mag_catalog_product_option_title` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_option_title` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_option_title` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_option_type_price`
--

DROP TABLE IF EXISTS `mag_catalog_product_option_type_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_option_type_price` (
  `option_type_price_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Type Price ID',
  `option_type_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Type ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `price_type` varchar(7) NOT NULL DEFAULT 'fixed' COMMENT 'Price Type',
  PRIMARY KEY (`option_type_price_id`),
  UNIQUE KEY `UNQ_MAG_CAT_PRD_OPT_TYPE_PRICE_OPT_TYPE_ID_STORE_ID` (`option_type_id`,`store_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_OPTION_TYPE_PRICE_OPTION_TYPE_ID` (`option_type_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_OPTION_TYPE_PRICE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_A5E0726930CC73399E3D7B8AB434BFAF` FOREIGN KEY (`option_type_id`) REFERENCES `mag_catalog_product_option_type_value` (`option_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_OPT_TYPE_PRICE_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Type Price Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_option_type_price`
--

LOCK TABLES `mag_catalog_product_option_type_price` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_option_type_price` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_option_type_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_option_type_title`
--

DROP TABLE IF EXISTS `mag_catalog_product_option_type_title`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_option_type_title` (
  `option_type_title_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Type Title ID',
  `option_type_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Type ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  PRIMARY KEY (`option_type_title_id`),
  UNIQUE KEY `UNQ_MAG_CAT_PRD_OPT_TYPE_TTL_OPT_TYPE_ID_STORE_ID` (`option_type_id`,`store_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_OPTION_TYPE_TITLE_OPTION_TYPE_ID` (`option_type_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_OPTION_TYPE_TITLE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_8BECB1AB69F8A0C7B51709013FBB21BE` FOREIGN KEY (`option_type_id`) REFERENCES `mag_catalog_product_option_type_value` (`option_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_OPT_TYPE_TTL_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Type Title Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_option_type_title`
--

LOCK TABLES `mag_catalog_product_option_type_title` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_option_type_title` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_option_type_title` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_option_type_value`
--

DROP TABLE IF EXISTS `mag_catalog_product_option_type_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_option_type_value` (
  `option_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Type ID',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option ID',
  `sku` varchar(64) DEFAULT NULL COMMENT 'SKU',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`option_type_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_OPTION_TYPE_VALUE_OPTION_ID` (`option_id`),
  CONSTRAINT `FK_MAG_CAT_PRD_OPT_TYPE_VAL_OPT_ID_MAG_CAT_PRD_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `mag_catalog_product_option` (`option_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Option Type Value Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_option_type_value`
--

LOCK TABLES `mag_catalog_product_option_type_value` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_option_type_value` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_option_type_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_relation`
--

DROP TABLE IF EXISTS `mag_catalog_product_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_relation` (
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent ID',
  `child_id` int(10) unsigned NOT NULL COMMENT 'Child ID',
  PRIMARY KEY (`parent_id`,`child_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_RELATION_CHILD_ID` (`child_id`),
  CONSTRAINT `FK_MAG_CAT_PRD_RELATION_CHILD_ID_MAG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`child_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_RELATION_PARENT_ID_MAG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`parent_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Relation Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_relation`
--

LOCK TABLES `mag_catalog_product_relation` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_relation` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_super_attribute`
--

DROP TABLE IF EXISTS `mag_catalog_product_super_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_super_attribute` (
  `product_super_attribute_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Product Super Attribute ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute ID',
  `position` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Position',
  PRIMARY KEY (`product_super_attribute_id`),
  UNIQUE KEY `UNQ_MAG_CATALOG_PRODUCT_SUPER_ATTRIBUTE_PRODUCT_ID_ATTRIBUTE_ID` (`product_id`,`attribute_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_SUPER_ATTRIBUTE_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_MAG_CAT_PRD_SPR_ATTR_PRD_ID_MAG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Super Attribute Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_super_attribute`
--

LOCK TABLES `mag_catalog_product_super_attribute` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_super_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_super_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_super_attribute_label`
--

DROP TABLE IF EXISTS `mag_catalog_product_super_attribute_label`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_super_attribute_label` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `product_super_attribute_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Super Attribute ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `use_default` smallint(5) unsigned DEFAULT '0' COMMENT 'Use Default Value',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MAG_CAT_PRD_SPR_ATTR_LBL_PRD_SPR_ATTR_ID_STORE_ID` (`product_super_attribute_id`,`store_id`),
  KEY `IDX_MAG_CAT_PRD_SPR_ATTR_LBL_PRD_SPR_ATTR_ID` (`product_super_attribute_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_SUPER_ATTRIBUTE_LABEL_STORE_ID` (`store_id`),
  CONSTRAINT `FK_6AD27CB471E548C459B522732358AFC8` FOREIGN KEY (`product_super_attribute_id`) REFERENCES `mag_catalog_product_super_attribute` (`product_super_attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_SPR_ATTR_LBL_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Super Attribute Label Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_super_attribute_label`
--

LOCK TABLES `mag_catalog_product_super_attribute_label` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_super_attribute_label` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_super_attribute_label` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_super_attribute_pricing`
--

DROP TABLE IF EXISTS `mag_catalog_product_super_attribute_pricing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_super_attribute_pricing` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value ID',
  `product_super_attribute_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Super Attribute ID',
  `value_index` varchar(255) DEFAULT NULL COMMENT 'Value Index',
  `is_percent` smallint(5) unsigned DEFAULT '0' COMMENT 'Is Percent',
  `pricing_value` decimal(12,4) DEFAULT NULL COMMENT 'Pricing Value',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website ID',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MAG_CAT_PRD_SPR_ATTR_PRICING_PRD_SPR_ATTR_ID_VAL_IDX_WS_ID` (`product_super_attribute_id`,`value_index`,`website_id`),
  KEY `IDX_MAG_CAT_PRD_SPR_ATTR_PRICING_PRD_SPR_ATTR_ID` (`product_super_attribute_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_SUPER_ATTRIBUTE_PRICING_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_091E022B428262E7BCEB66E51B8AD94A` FOREIGN KEY (`product_super_attribute_id`) REFERENCES `mag_catalog_product_super_attribute` (`product_super_attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_SPR_ATTR_PRICING_WS_ID_MAG_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `mag_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Super Attribute Pricing Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_super_attribute_pricing`
--

LOCK TABLES `mag_catalog_product_super_attribute_pricing` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_super_attribute_pricing` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_super_attribute_pricing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_super_link`
--

DROP TABLE IF EXISTS `mag_catalog_product_super_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_super_link` (
  `link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Link ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Parent ID',
  PRIMARY KEY (`link_id`),
  UNIQUE KEY `UNQ_MAG_CATALOG_PRODUCT_SUPER_LINK_PRODUCT_ID_PARENT_ID` (`product_id`,`parent_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_SUPER_LINK_PARENT_ID` (`parent_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_SUPER_LINK_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_MAG_CAT_PRD_SPR_LNK_PARENT_ID_MAG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`parent_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_SPR_LNK_PRD_ID_MAG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product Super Link Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_super_link`
--

LOCK TABLES `mag_catalog_product_super_link` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_super_link` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_super_link` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalog_product_website`
--

DROP TABLE IF EXISTS `mag_catalog_product_website`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalog_product_website` (
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product ID',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website ID',
  PRIMARY KEY (`product_id`,`website_id`),
  KEY `IDX_MAG_CATALOG_PRODUCT_WEBSITE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_MAG_CAT_PRD_WS_PRD_ID_MAG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CAT_PRD_WS_WS_ID_MAG_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `mag_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Product To Website Linkage Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalog_product_website`
--

LOCK TABLES `mag_catalog_product_website` WRITE;
/*!40000 ALTER TABLE `mag_catalog_product_website` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalog_product_website` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_cataloginventory_stock`
--

DROP TABLE IF EXISTS `mag_cataloginventory_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_cataloginventory_stock` (
  `stock_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Stock Id',
  `stock_name` varchar(255) DEFAULT NULL COMMENT 'Stock Name',
  PRIMARY KEY (`stock_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Cataloginventory Stock';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_cataloginventory_stock`
--

LOCK TABLES `mag_cataloginventory_stock` WRITE;
/*!40000 ALTER TABLE `mag_cataloginventory_stock` DISABLE KEYS */;
INSERT INTO `mag_cataloginventory_stock` VALUES (1,'Default');
/*!40000 ALTER TABLE `mag_cataloginventory_stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_cataloginventory_stock_item`
--

DROP TABLE IF EXISTS `mag_cataloginventory_stock_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_cataloginventory_stock_item` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Item Id',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Id',
  `stock_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Stock Id',
  `qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty',
  `min_qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Min Qty',
  `use_config_min_qty` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Min Qty',
  `is_qty_decimal` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Qty Decimal',
  `backorders` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Backorders',
  `use_config_backorders` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Backorders',
  `min_sale_qty` decimal(12,4) NOT NULL DEFAULT '1.0000' COMMENT 'Min Sale Qty',
  `use_config_min_sale_qty` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Min Sale Qty',
  `max_sale_qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Max Sale Qty',
  `use_config_max_sale_qty` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Max Sale Qty',
  `is_in_stock` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is In Stock',
  `low_stock_date` timestamp NULL DEFAULT NULL COMMENT 'Low Stock Date',
  `notify_stock_qty` decimal(12,4) DEFAULT NULL COMMENT 'Notify Stock Qty',
  `use_config_notify_stock_qty` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Notify Stock Qty',
  `manage_stock` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Manage Stock',
  `use_config_manage_stock` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Manage Stock',
  `stock_status_changed_auto` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Stock Status Changed Automatically',
  `use_config_qty_increments` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Qty Increments',
  `qty_increments` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty Increments',
  `use_config_enable_qty_inc` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Use Config Enable Qty Increments',
  `enable_qty_increments` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Enable Qty Increments',
  `is_decimal_divided` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Divided into Multiple Boxes for Shipping',
  PRIMARY KEY (`item_id`),
  UNIQUE KEY `UNQ_MAG_CATALOGINVENTORY_STOCK_ITEM_PRODUCT_ID_STOCK_ID` (`product_id`,`stock_id`),
  KEY `IDX_MAG_CATALOGINVENTORY_STOCK_ITEM_PRODUCT_ID` (`product_id`),
  KEY `IDX_MAG_CATALOGINVENTORY_STOCK_ITEM_STOCK_ID` (`stock_id`),
  CONSTRAINT `FK_MAG_CATINV_STOCK_ITEM_PRD_ID_MAG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CATINV_STOCK_ITEM_STOCK_ID_MAG_CATINV_STOCK_STOCK_ID` FOREIGN KEY (`stock_id`) REFERENCES `mag_cataloginventory_stock` (`stock_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cataloginventory Stock Item';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_cataloginventory_stock_item`
--

LOCK TABLES `mag_cataloginventory_stock_item` WRITE;
/*!40000 ALTER TABLE `mag_cataloginventory_stock_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_cataloginventory_stock_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_cataloginventory_stock_status`
--

DROP TABLE IF EXISTS `mag_cataloginventory_stock_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_cataloginventory_stock_status` (
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `stock_id` smallint(5) unsigned NOT NULL COMMENT 'Stock Id',
  `qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty',
  `stock_status` smallint(5) unsigned NOT NULL COMMENT 'Stock Status',
  PRIMARY KEY (`product_id`,`website_id`,`stock_id`),
  KEY `IDX_MAG_CATALOGINVENTORY_STOCK_STATUS_STOCK_ID` (`stock_id`),
  KEY `IDX_MAG_CATALOGINVENTORY_STOCK_STATUS_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_MAG_CATINV_STOCK_STS_PRD_ID_MAG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CATINV_STOCK_STS_STOCK_ID_MAG_CATINV_STOCK_STOCK_ID` FOREIGN KEY (`stock_id`) REFERENCES `mag_cataloginventory_stock` (`stock_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CATINV_STOCK_STS_WS_ID_MAG_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `mag_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cataloginventory Stock Status';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_cataloginventory_stock_status`
--

LOCK TABLES `mag_cataloginventory_stock_status` WRITE;
/*!40000 ALTER TABLE `mag_cataloginventory_stock_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_cataloginventory_stock_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_cataloginventory_stock_status_idx`
--

DROP TABLE IF EXISTS `mag_cataloginventory_stock_status_idx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_cataloginventory_stock_status_idx` (
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `stock_id` smallint(5) unsigned NOT NULL COMMENT 'Stock Id',
  `qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty',
  `stock_status` smallint(5) unsigned NOT NULL COMMENT 'Stock Status',
  PRIMARY KEY (`product_id`,`website_id`,`stock_id`),
  KEY `IDX_MAG_CATALOGINVENTORY_STOCK_STATUS_IDX_STOCK_ID` (`stock_id`),
  KEY `IDX_MAG_CATALOGINVENTORY_STOCK_STATUS_IDX_WEBSITE_ID` (`website_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cataloginventory Stock Status Indexer Idx';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_cataloginventory_stock_status_idx`
--

LOCK TABLES `mag_cataloginventory_stock_status_idx` WRITE;
/*!40000 ALTER TABLE `mag_cataloginventory_stock_status_idx` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_cataloginventory_stock_status_idx` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_cataloginventory_stock_status_tmp`
--

DROP TABLE IF EXISTS `mag_cataloginventory_stock_status_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_cataloginventory_stock_status_tmp` (
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `stock_id` smallint(5) unsigned NOT NULL COMMENT 'Stock Id',
  `qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty',
  `stock_status` smallint(5) unsigned NOT NULL COMMENT 'Stock Status',
  PRIMARY KEY (`product_id`,`website_id`,`stock_id`),
  KEY `IDX_MAG_CATALOGINVENTORY_STOCK_STATUS_TMP_STOCK_ID` (`stock_id`),
  KEY `IDX_MAG_CATALOGINVENTORY_STOCK_STATUS_TMP_WEBSITE_ID` (`website_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 COMMENT='Cataloginventory Stock Status Indexer Tmp';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_cataloginventory_stock_status_tmp`
--

LOCK TABLES `mag_cataloginventory_stock_status_tmp` WRITE;
/*!40000 ALTER TABLE `mag_cataloginventory_stock_status_tmp` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_cataloginventory_stock_status_tmp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalogrule`
--

DROP TABLE IF EXISTS `mag_catalogrule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalogrule` (
  `rule_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rule Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `description` text COMMENT 'Description',
  `from_date` date DEFAULT NULL COMMENT 'From Date',
  `to_date` date DEFAULT NULL COMMENT 'To Date',
  `is_active` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is Active',
  `conditions_serialized` mediumtext COMMENT 'Conditions Serialized',
  `actions_serialized` mediumtext COMMENT 'Actions Serialized',
  `stop_rules_processing` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Stop Rules Processing',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `simple_action` varchar(32) DEFAULT NULL COMMENT 'Simple Action',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount',
  `sub_is_enable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Rule Enable For Subitems',
  `sub_simple_action` varchar(32) DEFAULT NULL COMMENT 'Simple Action For Subitems',
  `sub_discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount For Subitems',
  PRIMARY KEY (`rule_id`),
  KEY `IDX_MAG_CATALOGRULE_IS_ACTIVE_SORT_ORDER_TO_DATE_FROM_DATE` (`is_active`,`sort_order`,`to_date`,`from_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CatalogRule';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalogrule`
--

LOCK TABLES `mag_catalogrule` WRITE;
/*!40000 ALTER TABLE `mag_catalogrule` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalogrule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalogrule_affected_product`
--

DROP TABLE IF EXISTS `mag_catalogrule_affected_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalogrule_affected_product` (
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CatalogRule Affected Product';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalogrule_affected_product`
--

LOCK TABLES `mag_catalogrule_affected_product` WRITE;
/*!40000 ALTER TABLE `mag_catalogrule_affected_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalogrule_affected_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalogrule_customer_group`
--

DROP TABLE IF EXISTS `mag_catalogrule_customer_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalogrule_customer_group` (
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  PRIMARY KEY (`rule_id`,`customer_group_id`),
  KEY `IDX_MAG_CATALOGRULE_CUSTOMER_GROUP_RULE_ID` (`rule_id`),
  KEY `IDX_MAG_CATALOGRULE_CUSTOMER_GROUP_CUSTOMER_GROUP_ID` (`customer_group_id`),
  CONSTRAINT `FK_8BAD63067FC5924077F8EABF98912920` FOREIGN KEY (`customer_group_id`) REFERENCES `mag_customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CATRULE_CSTR_GROUP_RULE_ID_MAG_CATRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `mag_catalogrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Rules To Customer Groups Relations';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalogrule_customer_group`
--

LOCK TABLES `mag_catalogrule_customer_group` WRITE;
/*!40000 ALTER TABLE `mag_catalogrule_customer_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalogrule_customer_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalogrule_group_website`
--

DROP TABLE IF EXISTS `mag_catalogrule_group_website`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalogrule_group_website` (
  `rule_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Rule Id',
  `customer_group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Group Id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  PRIMARY KEY (`rule_id`,`customer_group_id`,`website_id`),
  KEY `IDX_MAG_CATALOGRULE_GROUP_WEBSITE_RULE_ID` (`rule_id`),
  KEY `IDX_MAG_CATALOGRULE_GROUP_WEBSITE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_MAG_CATALOGRULE_GROUP_WEBSITE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_A70F0D1ECDF64758DE0999A259F4AE18` FOREIGN KEY (`customer_group_id`) REFERENCES `mag_customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CATALOGRULE_GROUP_WEBSITE_RULE_ID_MAG_CATALOGRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `mag_catalogrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CATRULE_GROUP_WS_WS_ID_MAG_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `mag_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CatalogRule Group Website';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalogrule_group_website`
--

LOCK TABLES `mag_catalogrule_group_website` WRITE;
/*!40000 ALTER TABLE `mag_catalogrule_group_website` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalogrule_group_website` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalogrule_product`
--

DROP TABLE IF EXISTS `mag_catalogrule_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalogrule_product` (
  `rule_product_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rule Product Id',
  `rule_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Rule Id',
  `from_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'From Time',
  `to_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'To time',
  `customer_group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Group Id',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Id',
  `action_operator` varchar(10) DEFAULT 'to_fixed' COMMENT 'Action Operator',
  `action_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Action Amount',
  `action_stop` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Action Stop',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `sub_simple_action` varchar(32) DEFAULT NULL COMMENT 'Simple Action For Subitems',
  `sub_discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount For Subitems',
  PRIMARY KEY (`rule_product_id`),
  UNIQUE KEY `37825F859536178279998D674B0186D1` (`rule_id`,`from_time`,`to_time`,`website_id`,`customer_group_id`,`product_id`,`sort_order`),
  KEY `IDX_MAG_CATALOGRULE_PRODUCT_RULE_ID` (`rule_id`),
  KEY `IDX_MAG_CATALOGRULE_PRODUCT_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_MAG_CATALOGRULE_PRODUCT_WEBSITE_ID` (`website_id`),
  KEY `IDX_MAG_CATALOGRULE_PRODUCT_FROM_TIME` (`from_time`),
  KEY `IDX_MAG_CATALOGRULE_PRODUCT_TO_TIME` (`to_time`),
  KEY `IDX_MAG_CATALOGRULE_PRODUCT_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_MAG_CATALOGRULE_PRODUCT_RULE_ID_MAG_CATALOGRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `mag_catalogrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CATRULE_PRD_CSTR_GROUP_ID_MAG_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `mag_customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CATRULE_PRD_PRD_ID_MAG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CATRULE_PRD_WS_ID_MAG_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `mag_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CatalogRule Product';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalogrule_product`
--

LOCK TABLES `mag_catalogrule_product` WRITE;
/*!40000 ALTER TABLE `mag_catalogrule_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalogrule_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalogrule_product_price`
--

DROP TABLE IF EXISTS `mag_catalogrule_product_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalogrule_product_price` (
  `rule_product_price_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rule Product PriceId',
  `rule_date` date NOT NULL COMMENT 'Rule Date',
  `customer_group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Group Id',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Id',
  `rule_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Rule Price',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `latest_start_date` date DEFAULT NULL COMMENT 'Latest StartDate',
  `earliest_end_date` date DEFAULT NULL COMMENT 'Earliest EndDate',
  PRIMARY KEY (`rule_product_price_id`),
  UNIQUE KEY `UNQ_MAG_CATRULE_PRD_PRICE_RULE_DATE_WS_ID_CSTR_GROUP_ID_PRD_ID` (`rule_date`,`website_id`,`customer_group_id`,`product_id`),
  KEY `IDX_MAG_CATALOGRULE_PRODUCT_PRICE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_MAG_CATALOGRULE_PRODUCT_PRICE_WEBSITE_ID` (`website_id`),
  KEY `IDX_MAG_CATALOGRULE_PRODUCT_PRICE_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_111DC1E942DDAAEF643E097F9B3B1CE3` FOREIGN KEY (`customer_group_id`) REFERENCES `mag_customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CATRULE_PRD_PRICE_PRD_ID_MAG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CATRULE_PRD_PRICE_WS_ID_MAG_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `mag_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CatalogRule Product Price';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalogrule_product_price`
--

LOCK TABLES `mag_catalogrule_product_price` WRITE;
/*!40000 ALTER TABLE `mag_catalogrule_product_price` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalogrule_product_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalogrule_website`
--

DROP TABLE IF EXISTS `mag_catalogrule_website`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalogrule_website` (
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  PRIMARY KEY (`rule_id`,`website_id`),
  KEY `IDX_MAG_CATALOGRULE_WEBSITE_RULE_ID` (`rule_id`),
  KEY `IDX_MAG_CATALOGRULE_WEBSITE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_MAG_CATALOGRULE_WEBSITE_RULE_ID_MAG_CATALOGRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `mag_catalogrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CATRULE_WS_WS_ID_MAG_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `mag_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog Rules To Websites Relations';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalogrule_website`
--

LOCK TABLES `mag_catalogrule_website` WRITE;
/*!40000 ALTER TABLE `mag_catalogrule_website` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalogrule_website` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalogsearch_fulltext`
--

DROP TABLE IF EXISTS `mag_catalogsearch_fulltext`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalogsearch_fulltext` (
  `fulltext_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `data_index` longtext COMMENT 'Data index',
  PRIMARY KEY (`fulltext_id`),
  UNIQUE KEY `UNQ_MAG_CATALOGSEARCH_FULLTEXT_PRODUCT_ID_STORE_ID` (`product_id`,`store_id`),
  FULLTEXT KEY `FTI_MAG_CATALOGSEARCH_FULLTEXT_DATA_INDEX` (`data_index`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Catalog search result table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalogsearch_fulltext`
--

LOCK TABLES `mag_catalogsearch_fulltext` WRITE;
/*!40000 ALTER TABLE `mag_catalogsearch_fulltext` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalogsearch_fulltext` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalogsearch_query`
--

DROP TABLE IF EXISTS `mag_catalogsearch_query`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalogsearch_query` (
  `query_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Query ID',
  `query_text` varchar(255) DEFAULT NULL COMMENT 'Query text',
  `num_results` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Num results',
  `popularity` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Popularity',
  `redirect` varchar(255) DEFAULT NULL COMMENT 'Redirect',
  `synonym_for` varchar(255) DEFAULT NULL COMMENT 'Synonym for',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `display_in_terms` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Display in terms',
  `is_active` smallint(6) DEFAULT '1' COMMENT 'Active status',
  `is_processed` smallint(6) DEFAULT '0' COMMENT 'Processed status',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated at',
  PRIMARY KEY (`query_id`),
  KEY `IDX_MAG_CATALOGSEARCH_QUERY_QUERY_TEXT_STORE_ID_POPULARITY` (`query_text`,`store_id`,`popularity`),
  KEY `IDX_MAG_CATALOGSEARCH_QUERY_STORE_ID` (`store_id`),
  KEY `IDX_MAG_MAG_CATALOGSEARCH_QUERY_SYNONYM_FOR` (`synonym_for`),
  CONSTRAINT `FK_MAG_CATALOGSEARCH_QUERY_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog search query table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalogsearch_query`
--

LOCK TABLES `mag_catalogsearch_query` WRITE;
/*!40000 ALTER TABLE `mag_catalogsearch_query` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalogsearch_query` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_catalogsearch_result`
--

DROP TABLE IF EXISTS `mag_catalogsearch_result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_catalogsearch_result` (
  `query_id` int(10) unsigned NOT NULL COMMENT 'Query ID',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product ID',
  `relevance` decimal(20,4) NOT NULL DEFAULT '0.0000' COMMENT 'Relevance',
  PRIMARY KEY (`query_id`,`product_id`),
  KEY `IDX_MAG_CATALOGSEARCH_RESULT_QUERY_ID` (`query_id`),
  KEY `IDX_MAG_CATALOGSEARCH_RESULT_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_MAG_CATSRCH_RESULT_PRD_ID_MAG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CATSRCH_RESULT_QR_ID_MAG_CATSRCH_QR_QR_ID` FOREIGN KEY (`query_id`) REFERENCES `mag_catalogsearch_query` (`query_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Catalog search result table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_catalogsearch_result`
--

LOCK TABLES `mag_catalogsearch_result` WRITE;
/*!40000 ALTER TABLE `mag_catalogsearch_result` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_catalogsearch_result` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_checkout_agreement`
--

DROP TABLE IF EXISTS `mag_checkout_agreement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_checkout_agreement` (
  `agreement_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Agreement Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `content` text COMMENT 'Content',
  `content_height` varchar(25) DEFAULT NULL COMMENT 'Content Height',
  `checkbox_text` text COMMENT 'Checkbox Text',
  `is_active` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is Active',
  `is_html` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is Html',
  PRIMARY KEY (`agreement_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Checkout Agreement';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_checkout_agreement`
--

LOCK TABLES `mag_checkout_agreement` WRITE;
/*!40000 ALTER TABLE `mag_checkout_agreement` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_checkout_agreement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_checkout_agreement_store`
--

DROP TABLE IF EXISTS `mag_checkout_agreement_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_checkout_agreement_store` (
  `agreement_id` int(10) unsigned NOT NULL COMMENT 'Agreement Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  PRIMARY KEY (`agreement_id`,`store_id`),
  KEY `FK_MAG_CHECKOUT_AGREEMENT_STORE_STORE_ID_MAG_CORE_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MAG_CHECKOUT_AGREEMENT_STORE_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CHKT_AGRT_STORE_AGRT_ID_MAG_CHKT_AGRT_AGRT_ID` FOREIGN KEY (`agreement_id`) REFERENCES `mag_checkout_agreement` (`agreement_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Checkout Agreement Store';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_checkout_agreement_store`
--

LOCK TABLES `mag_checkout_agreement_store` WRITE;
/*!40000 ALTER TABLE `mag_checkout_agreement_store` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_checkout_agreement_store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_cms_block`
--

DROP TABLE IF EXISTS `mag_cms_block`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_cms_block` (
  `block_id` smallint(6) NOT NULL AUTO_INCREMENT COMMENT 'Block ID',
  `title` varchar(255) NOT NULL COMMENT 'Block Title',
  `identifier` varchar(255) NOT NULL COMMENT 'Block String Identifier',
  `content` mediumtext COMMENT 'Block Content',
  `creation_time` timestamp NULL DEFAULT NULL COMMENT 'Block Creation Time',
  `update_time` timestamp NULL DEFAULT NULL COMMENT 'Block Modification Time',
  `is_active` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Is Block Active',
  PRIMARY KEY (`block_id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8 COMMENT='CMS Block Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_cms_block`
--

LOCK TABLES `mag_cms_block` WRITE;
/*!40000 ALTER TABLE `mag_cms_block` DISABLE KEYS */;
INSERT INTO `mag_cms_block` VALUES (1,'Footer Links','footer_links','\n<ul>\n    <li><a href=\"{{store direct_url=\"about-magento-demo-store\"}}\">About Us</a></li>\n    <li><a href=\"{{store direct_url=\"customer-service\"}}\">Customer Service</a></li>\n<li class=\"last privacy\"><a href=\"{{store direct_url=\"privacy-policy-cookie-restriction-mode\"}}\">Privacy Policy</a></li>\r\n</ul>','2015-02-19 08:09:04','2015-02-19 08:09:06',1),(2,'Footer Links Company','footer_links_company','\n<div class=\"links\">\n    <div class=\"block-title\">\n        <strong><span>Company</span></strong>\n    </div>\n    <ul>\n        <li><a href=\"{{store url=\"\"}}about-magento-demo-store/\">About Us</a></li>\n        <li><a href=\"{{store url=\"\"}}contacts/\">Contact Us</a></li>\n        <li><a href=\"{{store url=\"\"}}customer-service/\">Customer Service</a></li>\n        <li><a href=\"{{store url=\"\"}}privacy-policy-cookie-restriction-mode/\">Privacy Policy</a></li>\n    </ul>\n</div>','2015-02-19 08:09:06','2015-02-19 08:09:06',1),(3,'Cookie restriction notice','cookie_restriction_notice_block','<p>This website requires cookies to provide all of its features. For more information on what data is contained in the cookies, please see our <a href=\"{{store direct_url=\"privacy-policy-cookie-restriction-mode\"}}\">Privacy Policy page</a>. To accept cookies from this site, please click the Allow button below.</p>','2015-02-19 08:09:06','2015-02-19 08:09:06',1),(4,'Custom landing page 1','block_landing_page1','<div class=\"landing-page nested-container\">\n	<br />\n    \n	<div class=\"vertical-section grid12-4 persistent-grid2-1\">\n        <a href=\"{{store direct_url=\"downloadable/ebooks.html\"}}\">\n        	<img class=\"center-block\" src=\"{{media url=\"wysiwyg/infortis/ultimo/custom/landing/vert1.jpg\"}}\" alt=\"Sample banner\" />\n            <div class=\"caption dark2 full-width\">\n                <h2 class=\"heading permanent\">Lorem</h2>\n                <p class=\"permanent\">Nullam ornare enim nectis</p>\n                <p>Lorem ipsum dolor </p>\n            </div>\n        </a>\n	</div>\n	<div class=\"vertical-section grid12-4 persistent-grid2-1\">\n        <a href=\"{{store direct_url=\"downloadable/music.html\"}}\">\n        	<img class=\"center-block\" src=\"{{media url=\"wysiwyg/infortis/ultimo/custom/landing/vert2.jpg\"}}\" alt=\"Sample banner\" />\n            <div class=\"caption dark2 full-width\">\n	            <h2 class=\"heading permanent\">Ipsum</h2>\n    	        <p class=\"permanent\">In eget metus ornare itis est</p>\n        	    <p>Lorem ipsum dolor </p>\n            </div>\n        </a>\n	</div>\n	<div class=\"vertical-section grid12-4 persistent-grid2-1\">\n        <a href=\"{{store direct_url=\"downloadable/software.html\"}}\">\n        	<img class=\"center-block\" src=\"{{media url=\"wysiwyg/infortis/ultimo/custom/landing/vert3.jpg\"}}\" alt=\"Sample banner\" />\n            <div class=\"caption dark2 full-width\">\n	            <h2 class=\"heading permanent\">Dolor</h2>\n    	        <p class=\"permanent\">Etiam neque velit blandit sed</p>\n        	    <p>Lorem ipsum dolor </p>\n            </div>\n        </a>\n	</div>\n    <br />\n    \n	<div class=\"vertical-section grid-full\">\n		{{block type=\"ultimo/product_list_featured\" category_id=\"58\" product_count=\"16\" show_items=\"5\" is_responsive=\"1\" centered=\"1\" size=\"size-s\" move=\"2\" hide_button=\"1\" block_name=\"See Also: Recommended New Products\" template=\"catalog/product/list_featured_slider.phtml\"}}\n	</div>\n</div>','2015-02-19 08:30:45','2015-02-19 08:30:45',1),(5,'Custom footer links 2','block_footer_links2','<ul class=\"links hide-below-768\">\n\n	<li class=\"first\">\n		<a href=\"{{store direct_url=\'about-magento-demo-store/\'}}\" title=\"You can add more custom links here\">About Us</a>\n	</li>\n	<li class=\"last\">\n		<a href=\"{{store direct_url=\'customer-service/\'}}\"  title=\"You can even replace these links with any other content\">Customer Service</a>\n	</li>\n\n</ul>','2015-02-19 08:30:45','2015-02-19 08:30:45',1),(6,'Custom footer links','block_footer_links','This block can replace Magento\'s default footer links.\n\n<ul class=\"links\">\n\n    <li class=\"first\">\n    	<a href=\"{{store url=\'\'}}\" title=\"\">Custom Link</a>\n    </li>\n    <li>\n    	<a href=\"{{store url=\'catalog/seo_sitemap/category\'}}\" title=\"The Site Map\">Site Map</a>\n    </li>\n    <li>\n    	<a href=\"{{store url=\'catalogsearch/term/popular\'}}\" title=\"Search Terms\">Search Terms</a>\n    </li>\n    <li>\n    	<a href=\"{{store url=\'catalogsearch/advanced\'}}\" title=\"Advanced Search\">Advanced Search</a>\n    </li>\n    <li>\n    	<a href=\"{{store url=\'sales/guest/form\'}}\" title=\"Orders and Returns\">Orders and Returns</a>\n    </li>\n    <li>\n    	<a href=\"{{store url=\'contacts\'}}\" title=\"Contact Us\">Contact Us</a>\n    </li>\n    <li class=\" last\">\n    	<a class=\"link-rss\" href=\"{{store url=\'rss\'}}\" title=\"RSS\">RSS</a>\n    </li>\n    \n</ul>','2015-02-19 08:30:46','2015-02-19 08:30:46',0),(7,'Category above collection','block_category_above_collection','<div class=\"sample-block\">Static CMS block displayed above list/grid of products. Put your own content here.</div>','2015-02-19 08:30:47','2015-02-19 08:30:47',0),(8,'Footer primary bottom left - social links','block_footer_primary_bottom_left','<div class=\"social-links icon-wrapper-square\">\n\n	<a class=\"first\" href=\"http://twitter.com/infortis\" title=\"Follow Infortis on Twitter\">\n		<span class=\"icon icon-hover i-twitter-w\"></span>\n	</a>\n	<a href=\"#\" title=\"Join us on Facebook\">\n		<span class=\"icon icon-hover i-facebook-w\"></span>\n	</a>\n	<a href=\"#\" title=\"Join us on Google Plus\">\n		<span class=\"icon icon-hover i-googleplus-w\"></span>\n	</a>\n	<a href=\"#\" title=\"Youtube\">\n		<span class=\"icon icon-hover i-youtube-w\"></span>\n	</a>\n	<a href=\"#\" title=\"Vimeo\">\n		<span class=\"icon icon-hover i-vimeo-w\"></span>\n	</a>\n	<a href=\"#\" title=\"Wordpress\">\n		<span class=\"icon icon-hover i-wordpress-w\"></span>\n	</a>\n	<a href=\"#\" title=\"Pinterest\">\n		<span class=\"icon icon-hover i-pinterest-w\"></span>\n	</a>\n	<a href=\"#\" title=\"Linked in\">\n		<span class=\"icon icon-hover i-linkedin-w\"></span>\n	</a>\n	<a href=\"#\" title=\"Blogger\" class=\"hide-below-960\">\n		<span class=\"icon icon-hover i-blogger-w\"></span>\n	</a>\n	<a href=\"#\" title=\"Envato marketplaces\">\n		<span class=\"icon icon-hover i-envato-w\"></span>\n	</a>\n\n</div>','2015-02-19 08:30:47','2015-02-19 08:30:47',1),(9,'Footer payment','block_footer_payment','<img src=\"{{media url=\"wysiwyg/infortis/ultimo/custom/payment.gif}}\" alt=\"Payment methods\" title=\"Sample image with payment methods\" />','2015-02-19 08:30:48','2015-02-19 08:30:48',1),(10,'Category below collection','block_category_below_collection','<div class=\"nested-container hide-below-768\">\n\n    <div class=\"page-banners clearer\">\n        <div class=\"grid12-6 banner\">\n            <a href=\"{{store direct_url=\"about-magento-demo-store\"}}\" title=\"Replace this image with your own\">\n                <img src=\"{{media url=\"wysiwyg/infortis/ultimo/custom/banners/01.png\"}}\" alt=\"Sample banner\" />\n            </a>\n        </div>\n        <div class=\"grid12-6 banner\">\n            <a href=\"{{store direct_url=\"about-magento-demo-store\"}}\" title=\"Replace this image with your own\">\n                <img src=\"{{media url=\"wysiwyg/infortis/ultimo/custom/banners/03.png\"}}\" alt=\"Sample banner\" />\n            </a>\n        </div>\n    </div>\n\n</div>','2015-02-19 08:30:48','2015-02-19 08:30:48',0),(11,'Category above empty collection','block_category_above_empty_collection','<div class=\"note-msg empty-catalog\">\n\n	<h3>There are no products matching the selection</h3>\n	This is a custom CMS block displayed if category is empty.<br>\n	You can replace it with any custom content.\n\n</div>','2015-02-19 08:30:49','2015-02-19 08:30:49',1),(12,'Product secondary column bottom','block_product_secondary_bottom','<div class=\"feature feature-icon-hover indent first\">\n	<span class=\"icon\">\n		<img src=\"{{media url=\"wysiwyg/infortis/ultimo/icons/delivery.png\"}}\" />\n	</span>\n	<p class=\"no-margin \">We will send this product in 2 days. <a href=\"#\">Read more...</a></p>\n</div>\n<div class=\"feature feature-icon-hover indent\">\n	<span class=\"icon\">\n		<img src=\"{{media url=\"wysiwyg/infortis/ultimo/icons/phone.png\"}}\" />\n	</span>\n	<p class=\"no-margin \">Call us now for more info about our products.</p>\n</div>\n<div class=\"feature feature-icon-hover indent\">\n	<span class=\"icon\">\n		<img src=\"{{media url=\"wysiwyg/infortis/ultimo/icons/back.png\"}}\" />\n	</span>\n	<p class=\"no-margin \">Return purchased items and get all your money back.</p>\n</div>\n<div class=\"feature feature-icon-hover indent last\">\n	<span class=\"icon\">\n		<img src=\"{{media url=\"wysiwyg/infortis/ultimo/icons/star.png\"}}\" />\n	</span>\n	<p class=\"no-margin \">Buy this product and earn 10 special loyalty points!</p>\n</div>\n\n\n<!-- Social bookmarks from http://www.addthis.com/get/sharing  -->\n<!--\n<div class=\"feature-wrapper top-border\">\n	<div class=\"addthis_toolbox addthis_default_style \">\n	<a class=\"addthis_button_preferred_1\"></a>\n	<a class=\"addthis_button_preferred_2\"></a>\n	<a class=\"addthis_button_preferred_3\"></a>\n	<a class=\"addthis_button_preferred_4\"></a>\n	<a class=\"addthis_button_compact\"></a>\n	<a class=\"addthis_counter addthis_bubble_style\"></a>\n	</div>\n	<script type=\"text/javascript\" src=\"http://s7.addthis.com/js/300/addthis_widget.js#pubid=xa-5054e6c6502d114f\"></script>\n</div>\n-->','2015-02-19 08:30:49','2015-02-19 08:30:49',1),(13,'Product - primary column bottom','block_product_primary_bottom','Sample content of the static block - primary column bottom.','2015-02-19 08:30:50','2015-02-19 08:30:50',0),(14,'Cart - below totals','block_cart_below_totals','<div class=\"hide-below-320\" style=\"display: table; float: right; padding-right: 10px; text-align: right;\"><span style=\"display: table-cell; vertical-align: middle;\">Sample info about SSL Certificate</span> <img src=\"{{media url=\"wysiwyg/infortis/ultimo/custom/block_cart_below_totals.png\"}}\" alt=\"Example Image\" title=\"Static CMS block displayed below totals. Put your own content here.\" /></div>','2015-02-19 08:30:51','2015-02-19 08:30:51',1),(15,'One page checkout  below progress','block_opc_below_progress','<div class=\"sample-block\">Custom CMS block displayed below the one page checkout progress block. Put your own content here.</div>','2015-02-19 08:30:51','2015-02-19 08:30:51',1),(16,'Mini cart above products','block_mini_cart_above_products','<div style=\"padding:15px; background-color:#f5f5f5; color:#d90000;\" title=\"Customizable CMS block for promo info\">\n<a class=\"go\" href=\"{{store url=\"\"}}\">Check our latest super promotions!</a>\n</div>','2015-02-19 08:30:52','2015-02-19 08:30:52',0),(17,'Custom Tab 1','block_product_tab1','<p>Custom CMS block displayed as a tab. You can use it to display info about returns and refunds, latest promotions etc. You can put your own content here: text, HTML, images - whatever you like. There are <strong>many similar blocks</strong> accross the store. All CMS blocks are editable from the admin panel.</p>\n\n<div class=\"feature indent first\">\n	<span class=\"icon i-right no-bg-color\"></span>\n	<p class=\"no-margin\"><strong>Magento Community Edition is the most powerful</strong> open source e-commerce software and can be downloaded 100% for free. Developers can modify the core code, add custom features and functionality by installing extensions from Magento Connect marketplace.</p>\n</div>\n<div class=\"feature indent\">\n	<span class=\"icon i-right no-bg-color\"></span>\n	<p class=\"no-margin\"><strong>Manage the fully dynamic catalog</strong> with the intutive admistrative interface. The flexible catalog system includes various options for the display of items. Magento is also integrated with a variety of major payment gateways out of the box.</p>\n</div>\n<div class=\"feature indent last\">\n	<span class=\"icon i-right no-bg-color\"></span>\n	<p class=\"no-margin\"><strong>Magento is a fully global platform</strong>, allowing for the expansion of business or simply offering multiple versions of your site to meet the needs of your customers.\nTranslated into over 60 languages, supporting multiple currencies, payment methods and taxes, Magento allows for internationalization of your online stores.</p>\n</div>','2015-02-19 08:30:52','2015-02-19 08:30:52',1),(18,'Custom Tab 2','block_product_tab2','<p>Another custom CMS block displayed as a tab. You can use it to display info about returns and refunds, latest promotions etc. You can put your own content here: text, HTML, images - whatever you like. There are <strong>many similar blocks</strong> accross the store. All CMS blocks are editable from the admin panel.</p>\n\n<p>Lorem ipsum dolor sit, consectetur adipiscing elit. Etiam neque velit, blandit sed scelerisque quis. Nullam ornare enim nec justo bibendum lobortis. In eget metus.</p>','2015-02-19 08:30:53','2015-02-19 08:30:53',0),(19,'Cart - below table','block_cart_below_table','<div class=\"nested-container hide-below-768\">\n\n    <div class=\"page-banners clearer\">\n        <div class=\"grid12-6 banner\">\n            <a href=\"{{store direct_url=\"about-magento-demo-store\"}}\" title=\"Static CMS block displayed below the cart. Put your own content here.\">\n                <img src=\"{{media url=\"wysiwyg/infortis/ultimo/custom/banners/01.png\"}}\" alt=\"Sample banner\" />\n            </a>\n        </div>\n        <div class=\"grid12-6 banner\">\n            <a href=\"{{store direct_url=\"about-magento-demo-store\"}}\" title=\"Static CMS block displayed below the cart. Put your own content here.\">\n                <img src=\"{{media url=\"wysiwyg/infortis/ultimo/custom/banners/02.png\"}}\" alt=\"Sample banner\" />\n            </a>\n        </div>\n    </div>\n\n</div>','2015-02-19 08:30:53','2015-02-19 08:30:53',1),(20,'Footer column 1','block_footer_column1','<div class=\"collapsible mobile-collapsible\">\n	<h6 class=\"block-title heading\">About Ultimo</h6>\n\n	<div class=\"block-content\">\n\n		<div class=\"feature first last\">\n			<img class=\"icon\" src=\"{{media url=\"wysiwyg/infortis/ultimo/icons/info.png\"}}\" alt=\"About Ultimo Magento Theme\" />\n			<p>Ultimo is a premium Magento theme with advanced admin module. It’s extremely customizable, easy to use and fully responsive.</p>\n			<p>Suitable for every type of store. Great starting point for your custom projects.</p>\n			<h5><a class=\"go\" href=\"http://themeforest.net/item/ultimo-fluid-responsive-magento-theme/3231798?ref=infortis\">Buy this theme</a></h5>\n		</div>\n\n	</div>\n</div>','2015-02-19 08:30:54','2015-02-19 08:30:54',0),(21,'Footer column 2','block_footer_column2','<div class=\"collapsible mobile-collapsible\">\n	<h6 class=\"block-title heading\">Key Features</h6>\n\n	<div class=\"block-content\">\n\n		<div class=\"feature feature-icon-hover indent first\">\n			<span class=\"icon i-number\">1</span>\n			<p class=\"no-margin\">Unlimited colors, dozens of customizable elements</p>\n		</div>\n		<div class=\"feature feature-icon-hover indent\">\n			<span class=\"icon i-number\">2</span>\n			<p class=\"no-margin \">Customizable responsive layout based on fluid grid</p>\n		</div>\n		<div class=\"feature feature-icon-hover indent\">\n			<span class=\"icon i-number\">3</span>\n			<p class=\"no-margin \">50+ placeholders to display custom content</p>\n		</div>\n		<div class=\"feature feature-icon-hover indent\">\n			<span class=\"icon i-number\">4</span>\n			<p class=\"no-margin \">Create your custom sub-themes (variants)</p>\n		</div>\n\n	</div>\n</div>','2015-02-19 08:30:55','2015-02-19 08:30:55',0),(22,'Footer column 3','block_footer_column3','<div class=\"collapsible mobile-collapsible\">\n	<h6 class=\"block-title heading\">Theme Features</h6>\n\n	<div class=\"block-content\">\n	\n		<ul class=\"bullet\">\n			<li><a href=\"{{store url=\'ultimo-responsive-magento-theme\'}}\">Theme Features</a></li>\n			<li><a href=\"{{store url=\'typography\'}}\">Typography</a></li>\n			<li><a href=\"#\">Some Sample Link</a></li>\n			<li><a href=\"#\">Meat Our Best Partners</a></li>\n			<li><a href=\"#\">Latest Work Samples</a></li>\n			<li><a href=\"#\">Our Other Projects</a></li>\n			<li><a href=\"#\">One Click To Join Us</a></li>\n			<li><a href=\"#\">Follow Us On Twitter</a></li>\n			<li><a href=\"http://infortis-themes.com/\">Magento Themes</a></li>\n			<li><a href=\"#\">Ecommerce</a></li>\n		</ul>\n\n	</div>\n</div>','2015-02-19 08:30:55','2015-02-19 08:30:55',0),(23,'Footer column 4','block_footer_column4','<div class=\"collapsible mobile-collapsible\">\n	<h6 class=\"block-title heading\">Company Info</h6>\n\n	<div class=\"block-content\">\n\n		<div class=\"feature indent first\">\n			<span class=\"icon i-telephone-w\"></span>\n			<p class=\"no-margin \">Call Us +001 555 801<br/>Fax +001 555 802</p>\n		</div>\n		<div class=\"feature indent\">\n			<span class=\"icon i-mobile-w\"></span>\n			<p class=\"no-margin \">+77 123 1234<br/>+42 98 9876</p>\n		</div>\n		<div class=\"feature indent\">\n			<span class=\"icon i-letter-w\"></span>\n			<p class=\"no-margin \">boss@example.com<br/>me@example.com</p>\n		</div>\n		<div class=\"feature indent last\">\n			<span class=\"icon i-skype-w\"></span>\n			<p class=\"no-margin \">Skype: samplelogin<br/>skype_support</p>\n		</div>\n\n	</div>\n</div>','2015-02-19 08:30:56','2015-02-19 08:30:56',0),(24,'Footer column 5','block_footer_column5','<div class=\"grid12-3\">\n	<div class=\"collapsible mobile-collapsible\">\n\n		<h6 class=\"block-title heading\">About Ultimo</h6>\n		<div class=\"block-content\">\n			<div class=\"feature first last\">\n				<img class=\"icon\" src=\"{{media url=\"wysiwyg/infortis/ultimo/icons/info.png\"}}\" alt=\"About Ultimo Magento theme\" />\n				<p>Ultimo is a premium Magento theme with advanced admin module. It’s extremely customizable, easy to use and fully responsive.</p>\n				<p>Suitable for every type of store. Great starting point for your custom projects.</p>\n				<h5><a class=\"go\" href=\"http://themeforest.net/item/ultimo-fluid-responsive-magento-theme/3231798?ref=infortis\">Buy this theme</a></h5>\n			</div>\n		</div>\n\n	</div>\n</div>\n\n<div class=\"grid12-3\">\n	<div class=\"collapsible mobile-collapsible\">\n\n		<h6 class=\"block-title heading\">Theme Features</h6>\n		<div class=\"block-content\">\n			<ul class=\"bullet\">\n				<li><a href=\"{{store url=\'ultimo-responsive-magento-theme\'}}\">Theme Features</a></li>\n				<li><a href=\"{{store url=\'typography\'}}\">Typography</a></li>\n				<li><a href=\"#\">Some Sample Link</a></li>\n				<li><a href=\"#\">Meat Our Best Partners</a></li>\n				<li><a href=\"#\">Latest Work Samples</a></li>\n				<li><a href=\"#\">Our Other Projects</a></li>\n				<li><a href=\"#\">One Click To Join Us</a></li>\n				<li><a href=\"#\">Follow Us On Twitter</a></li>\n				<li><a href=\"http://infortis-themes.com/\">Magento Themes</a></li>\n				<li><a href=\"#\">Ecommerce</a></li>\n			</ul>\n		</div>\n\n	</div>\n</div>\n\n<div class=\"grid12-3\">\n	<div class=\"collapsible mobile-collapsible\">\n\n		<h6 class=\"block-title heading\">Key Features</h6>\n		<div class=\"block-content\">\n			<div class=\"feature feature-icon-hover indent first\">\n				<span class=\"icon i-number\">1</span>\n				<p class=\"no-margin\">Unlimited colors, dozens of customizable elements</p>\n			</div>\n			<div class=\"feature feature-icon-hover indent\">\n				<span class=\"icon i-number\">2</span>\n				<p class=\"no-margin \">Customizable responsive layout based on fluid grid</p>\n			</div>\n			<div class=\"feature feature-icon-hover indent\">\n				<span class=\"icon i-number\">3</span>\n				<p class=\"no-margin \">50+ placeholders to display custom content</p>\n			</div>\n			<div class=\"feature feature-icon-hover indent\">\n				<span class=\"icon i-number\">4</span>\n				<p class=\"no-margin \">Create your custom sub-themes (variants)</p>\n			</div>\n		</div>\n\n	</div>\n</div>\n\n<div class=\"grid12-3\">\n	<div class=\"collapsible mobile-collapsible\">\n\n		<h6 class=\"block-title heading\">Company Info</h6>\n		<div class=\"block-content\">\n			<div class=\"feature feature-icon-hover indent first\">\n				<span class=\"icon i-telephone-w\"></span>\n				<p class=\"no-margin \">Call Us +001 555 801<br/>Fax +001 555 802</p>\n			</div>\n			<div class=\"feature feature-icon-hover indent\">\n				<span class=\"icon i-mobile-w\"></span>\n				<p class=\"no-margin \">+77 123 1234<br/>+42 98 9876</p>\n			</div>\n			<div class=\"feature feature-icon-hover indent\">\n				<span class=\"icon i-letter-w\"></span>\n				<p class=\"no-margin \">boss@example.com<br/>me@example.com</p>\n			</div>\n			<div class=\"feature feature-icon-hover indent last\">\n				<span class=\"icon i-skype-w\"></span>\n				<p class=\"no-margin \">Skype: samplelogin<br/>skype-support</p>\n			</div>\n		</div>\n\n	</div>\n</div>','2015-02-19 08:30:56','2015-02-19 08:30:56',1),(25,'Footer column 6','block_footer_column6','<h6 class=\"heading\">Sample Column</h6>\n<ul>\n<li><a href=\"#\">Responsive Magento Theme</a></li>\n<li><a href=\"#\">Magento Extensions</a></li>\n<li><a href=\"#\">Store Overview</a></li>\n<li><a href=\"#\">Buy This</a></li>\n<li><a href=\"#\">Sample Link</a></li>\n<li><a href=\"#\">Some Other Link</a></li>\n<li><a href=\"#\">Link Example</a></li>\n</ul>','2015-02-19 08:30:57','2015-02-19 08:30:57',0),(26,'Custom','block_header_nav_dropdown','<div class=\"grid12-3\">\n\n	<h2 class=\"heading\">Responsive Magento Theme</h2>\n	<p>Ultimo is a premium Magento theme with advanced admin module. It\'s extremely customizable and fully responsive. Can be used for every type of store.</p>\n	<h5><a class=\"go\" href=\"http://themeforest.net/item/ultimo-fluid-responsive-magento-theme/3231798?ref=infortis\" style=\"color:red;\">Buy this Magento theme</a></h5>\n\n</div>\n<div class=\"grid12-3\">\n\n	<img src=\"{{media url=\'wysiwyg/infortis/ultimo/menu/custom/01.png\'}}\" alt=\"Magento CMS blocks\" />\n	<h4 class=\"heading\">50+ CMS blocks</h4>\n	<p>You can use CMS blocks as content placeholders to display custom content in almost every part of the store. Import sample CMS blocks from the demo.</p>\n	<a href=\"{{store url=\'ultimo-responsive-magento-theme\'}}\" class=\"go\">See all features</a>\n\n</div>\n<div class=\"grid12-3\">\n\n	<img src=\"{{media url=\'wysiwyg/infortis/ultimo/menu/custom/02.png\'}}\" alt=\"Magento theme documentation\" />\n	<h4 class=\"heading\">140-pages documentation</h4>\n	<p>The best Magento theme documentation on ThemeForest. It also describes selected Magento features which you need to know when starting to work with Magento.</p>\n	<a href=\"{{store url=\'ultimo-responsive-magento-theme\'}}\" class=\"go\">See all features</a>\n\n</div>\n<div class=\"grid12-3\">\n\n	<img src=\"{{media url=\'wysiwyg/infortis/ultimo/menu/custom/03.png\'}}\" alt=\"Create Magento sub-themes\" />\n	<h4 class=\"heading\">Easy to customize</h4>\n	<p>Use Ultimo as a starting point for your custom projects. Unlike many other themes, Ultimo lets you create multiple custom sub-themes (theme variants) for your clients.</p>\n	<a href=\"{{store url=\'ultimo-responsive-magento-theme\'}}\" class=\"go\">See all features</a>\n\n</div>','2015-02-19 08:30:58','2015-02-19 08:30:58',1),(27,'CMS page top','block_cms_page_top','<div class=\"nested-container\">\n\n    <div class=\"page-banners clearer\">\n        <div class=\"grid12-6 banner\">\n            <a href=\"{{store direct_url=\"about-magento-demo-store\"}}\" title=\"Replace this image with your own\">\n                <img src=\"{{media url=\"wysiwyg/infortis/ultimo/custom/banners/01.png\"}}\" alt=\"Sample banner\" />\n            </a>\n        </div>\n        <div class=\"grid12-6 banner\">\n            <a href=\"{{store direct_url=\"about-magento-demo-store\"}}\" title=\"Replace this image with your own\">\n                <img src=\"{{media url=\"wysiwyg/infortis/ultimo/custom/banners/02.png\"}}\" alt=\"Sample banner\" />\n            </a>\n        </div>\n\n    </div>\n\n</div>','2015-02-19 08:30:58','2015-02-19 08:30:58',0),(28,'Product replace related','block_product_replace_related','<div class=\"block\">\n	<div class=\"block-title\">\n		<strong><span>Replace related</span></strong>\n	</div>\n\n	<p style=\"background-color: #eee; padding:10px; margin-bottom:10px; margin-top:10px;\">\n		Custom CMS block replacing related products. Put your own content here: text, HTML, images - whatever you want.\n	</p>\n	<p style=\"background-color: #eee; padding:10px;\">\n		There are many similar blocks accross the store. All editable from admin panel.\n	</p>\n</div>','2015-02-19 08:30:59','2015-02-19 08:30:59',1),(29,'Product replace up-sell','block_product_replace_upsell','<div class=\"sample-block\">Custom CMS block displayed when you want to replace up-sell products with custom content. You can put here simple text, images, HTML or whatever you like.</div>','2015-02-19 08:30:59','2015-02-19 08:30:59',1),(30,'Header top left 2','block_header_top_left2','<div class=\"links-wrapper-separators\">\n\n	<ul class=\"links\">\n		<li class=\"first hide-below-480\">\n			<a href=\"http://ultimo.infortis-themes.com/demo/select-demo/\" title=\"See more demos\">All demos</a>\n		</li>\n		<li class=\"hide-below-768\">\n			<a href=\"{{store url=\'ultimo-responsive-magento-theme\'}}\" title=\"See the list of all features\">Features</a>\n		</li>\n		<li class=\"last hide-below-480\">\n			<a href=\"http://themeforest.net/item/ultimo-fluid-responsive-magento-theme/3231798?ref=infortis\" title=\"Click to buy this theme\">Buy me!</a>\n		</li>\n	</ul>\n\n</div>','2015-02-19 08:31:00','2015-02-19 08:31:00',1),(31,'Header top left','block_header_top_left','<div class=\"hide-below-768\" title=\"You can put here a phone number or some additional help info\"><span class=\"icon i-telephone no-bg-color\"></span>Call +001 555 801</div>','2015-02-19 08:31:00','2015-02-19 08:31:00',1),(32,'Right sidebar top','block_right_top','<div class=\"block\">\n	<div class=\"block-title\">\n		<strong><span>Custom Block (top)</span></strong>\n	</div>\n\n	<div class=\"block-content sample-block\">\n		<p>Custom CMS block displayed at the top of the right sidebar. Put your own content here: text, HTML, images - whatever you like. There are many similar content placeholders across the store. All editable from admin panel.</p>	\n	</div>\n</div>','2015-02-19 08:31:01','2015-02-19 08:31:01',1),(33,'Custom Top Links (to replace Magento\'s default Top Links)','block_header_top_links','<ul class=\"links\">\n\n	<li class=\"first hide-below-768\">\n		<a href=\"#\" title=\"Sample\">Sample</a>\n	</li>\n	<li class=\"hide-below-768\">\n		<a href=\"#\" title=\"Custom\">Custom</a>\n	</li>\n	<li class=\"last hide-below-768\">\n		<a href=\"#\" title=\"Links\">Links</a>\n	</li>\n\n</ul>','2015-02-19 08:31:01','2015-02-19 08:31:01',0),(34,'Custom Top Links 2','block_header_top_links2','<ul class=\"links\">\n\n	<li class=\"first\">\n		<a href=\"{{store url=\'about-magento-demo-store\'}}\" title=\"Custom link\">Sample</a>\n	</li>\n	<li class=\"last\">\n		<a href=\"{{store url=\'any/custom/page\'}}\" title=\"Link Hidden on Mobile\">Links</a>\n	</li>\n\n</ul>','2015-02-19 08:31:01','2015-02-19 08:31:01',0),(35,'Left sidebar top','block_left_top','<div class=\"block\">\n	<div class=\"block-title\">\n		<strong><span>Custom Block (top)</span></strong>\n	</div>\n	<div class=\"block-content sample-block\">\n		<p>Custom CMS block displayed at the top of the left sidebar. Put your own content here.</p>\n	</div>\n</div>','2015-02-19 08:31:02','2015-02-19 08:31:02',1),(36,'Left sidebar bottom','block_left_bottom','<div class=\"block\">\n	<div class=\"block-title\">\n		<strong><span>Custom Block (bottom)</span></strong>\n	</div>\n	<div class=\"block-content sample-block\">\n		<p>Custom CMS block displayed in the left sidebar below the other blocks. Put your own content here. There are many similar content placeholders across the store. All editable from admin panel.</p>\n	</div>\n</div>','2015-02-19 08:31:02','2015-02-19 08:31:02',1),(37,'Footer primary bottom right - newsletter','block_footer_primary_bottom_right','This block can replace default newsletter form.','2015-02-19 08:31:02','2015-02-19 08:31:02',0),(38,'Footer - row 2 column 1','block_footer_row2_column1','<div class=\"collapsible mobile-collapsible\">\n	<h6 class=\"block-title heading\">First Heading</h6>\n\n	<div class=\"block-content\">\n\n		<ul class=\"bullet\">\n			<li><a href=\"{{store url=\"ultimo-responsive-magento-theme\"}}\">This is just a sample link</a></li>\n			<li><a href=\"#\">And this is some other link</a></li>\n			<li><a href=\"#\">Another dummy text</a></li>\n		</ul>\n\n	</div>\n</div>','2015-02-19 08:31:03','2015-02-19 08:31:03',0),(39,'Footer - row 2 column 2','block_footer_row2_column2','<div class=\"collapsible mobile-collapsible\">\n	<h6 class=\"block-title heading\">Second Heading</h6>\n\n	<div class=\"block-content\">\n\n		<ul class=\"bullet\">\n			<li><a href=\"{{store url=\"ultimo-responsive-magento-theme\"}}\">This is just a sample link</a></li>\n			<li><a href=\"#\">And this is some other link</a></li>\n			<li><a href=\"#\">Another dummy text</a></li>\n		</ul>\n\n	</div>\n</div>','2015-02-19 08:31:03','2015-02-19 08:31:03',0),(40,'Footer - row 2 column 3','block_footer_row2_column3','<div class=\"collapsible mobile-collapsible\">\n	<h6 class=\"block-title heading\">Third Heading</h6>\n\n	<div class=\"block-content\">\n\n		<ul class=\"bullet\">\n			<li><a href=\"{{store url=\"ultimo-responsive-magento-theme\"}}\">This is just a sample link</a></li>\n			<li><a href=\"#\">And this is some other link</a></li>\n			<li><a href=\"#\">Another dummy text</a></li>\n		</ul>\n\n	</div>\n</div>','2015-02-19 08:31:04','2015-02-19 08:31:04',0),(41,'Footer - row 2 column 5','block_footer_row2_column5','<div class=\"grid12-9 no-gutter\">\n\n	<div class=\"grid12-3\">\n		<div class=\"collapsible mobile-collapsible\">\n			<h6 class=\"block-title heading\">Questions?</h6>\n			<div class=\"block-content\">\n\n				<ul class=\"bullet\">\n					<li><a href=\"#\">Terms</a></li>\n					<li><a href=\"#\">Conditions</a></li>\n					<li><a href=\"#\">About us</a></li>\n					<li><a href=\"#\">Example</a></li>\n				</ul>\n\n			</div>\n		</div>\n	</div>\n\n	<div class=\"grid12-3\">\n		<div class=\"collapsible mobile-collapsible\">\n			<h6 class=\"block-title heading\">Shipping</h6>\n			<div class=\"block-content\">\n\n				<ul class=\"bullet\">\n					<li><a href=\"#\">Delivery</a></li>\n					<li><a href=\"#\">Track your order</a></li>\n					<li><a href=\"#\">Buy gift cards</a></li>\n					<li><a href=\"#\">Returns</a></li>\n				</ul>\n\n			</div>\n		</div>\n	</div>\n\n	<div class=\"grid12-3\">\n		<div class=\"collapsible mobile-collapsible\">\n			<h6 class=\"block-title heading\">About Us</h6>\n			<div class=\"block-content\">\n\n				<ul class=\"bullet\">\n					<li><a href=\"#\">Responsive</a></li>\n					<li><a href=\"#\">Magento themes</a></li>\n					<li><a href=\"#\">E-commerce</a></li>\n					<li><a href=\"#\">The company</a></li>\n				</ul>\n\n			</div>\n		</div>\n	</div>\n\n	<div class=\"grid12-3\">\n		<div class=\"collapsible mobile-collapsible\">\n			<h6 class=\"block-title heading\">News</h6>\n			<div class=\"block-content\">\n\n				<ul class=\"bullet\">\n					<li><a href=\"#\">What\'s new</a></li>\n					<li><a href=\"#\">Products</a></li>\n					<li><a href=\"#\">Magento template</a></li>\n					<li><a href=\"#\">Our sites</a></li>\n				</ul>\n\n			</div>\n		</div>\n	</div>\n\n</div>\n<div class=\"grid12-3 no-right-gutter\">\n	<div class=\"collapsible mobile-collapsible\">\n		<h6 class=\"block-title heading\">Additional Info</h6>\n		<div class=\"block-content\">\n\n			<div class=\"feature indent first feature-icon-hover\">\n				<span class=\"icon i-location-w\" style=\"background-color: lightskyblue;\"></span>\n				<p class=\"no-margin\">Friends Inc., 90 Bedford St<br />New York, NY 041, USA</p>\n			</div>\n			<div class=\"feature indent feature-icon-hover\">\n				<span class=\"icon i-twitter-w\" style=\"background-color: lightskyblue;\"></span>\n				<p class=\"no-margin\">Follow us on our<br><a href=\"http://twitter.com/infortis\">Twitter</a> account</p>\n			</div>\n			<br />\n\n		</div>\n	</div>\n</div>','2015-02-19 08:31:04','2015-02-19 08:31:04',0),(42,'Footer - row 2 column 6','block_footer_row2_column6','Sample content of block_footer_row2_column6','2015-02-19 08:31:04','2015-02-19 08:31:04',0),(43,'Footer - row 2 column 4','block_footer_row2_column4','<div class=\"collapsible mobile-collapsible\">\n	<h6 class=\"block-title heading\">Fourth Heading</h6>\n\n	<div class=\"block-content\">\n\n		<ul class=\"bullet\">\n			<li><a href=\"{{store url=\"ultimo-responsive-magento-theme\"}}\">Link example</a></li>\n			<li><a href=\"#\">And this is some other link</a></li>\n			<li><a href=\"#\">Last Sample Link</a></li>\n		</ul>\n\n	</div>\n</div>','2015-02-19 08:31:05','2015-02-19 08:31:05',0),(44,'Custom landing page 2','block_landing_page2','<div class=\"landing-page\">\n\n	<p class=\"horizontal-section sample-block\">This is a custom landing page with sidebar: a CMS block which can replace category products. You can put your own content here: text, HTML, images - whatever you want. You can create landing page for every category.</p>\n\n	<a class=\"horizontal-section\" href=\"{{store direct_url=\"about-magento-demo-store\"}}\" title=\"Replace this image with your own content.\">\n		<img src=\"{{media url=\"wysiwyg/infortis/ultimo/custom/landing/horiz1.jpg\"}}\" alt=\"Sample Image\" />\n	</a>\n\n	<a class=\"horizontal-section\" href=\"{{store direct_url=\"about-magento-demo-store\"}}\" title=\"Replace this image with your own content.\">\n		<img src=\"{{media url=\"wysiwyg/infortis/ultimo/custom/landing/horiz2.jpg\"}}\" alt=\"Sample Image\" />\n	</a>\n\n	<a class=\"horizontal-section\" href=\"{{store direct_url=\"about-magento-demo-store\"}}\" title=\"Replace this image with your own content.\">\n		<img src=\"{{media url=\"wysiwyg/infortis/ultimo/custom/landing/horiz3.jpg\"}}\" alt=\"Sample Image\" />\n	</a>\n\n</div>','2015-02-19 08:31:05','2015-02-19 08:31:05',1),(45,'Home slide 1','block_slide1','<a href=\"{{store url=\'about-magento-demo-store\'}}\">\n	<img src=\"{{media url=\'wysiwyg/infortis/ultimo/slideshow/01.jpg\'}}\" alt=\"Sample slide\" />\n\n		<div class=\"caption light2 full-width\">\n			<h2 class=\"heading permanent\">Sample Caption</h2>\n			<p>Lorem ipsum dolor sit amet consectetur</p>\n			<p>Nullam ornare enim nec justo</p>\n		</div>\n\n</a>','2015-02-19 08:31:05','2015-02-19 08:31:05',1),(46,'Home slide 2','block_slide2','<a href=\"{{store url=\'about-magento-demo-store\'}}\">\n	<img src=\"{{media url=\'wysiwyg/infortis/ultimo/slideshow/02.jpg\'}}\" alt=\"Sample slide\" />\n\n		<div class=\"caption light3\">\n			<h2 class=\"heading permanent\">Sample Caption</h2>\n			<p>Lorem ipsum dolor sit amet consectetur</p>\n		</div>\n\n		<div class=\"caption light2 bottom-right narrow\">\n			<h2 class=\"heading permanent\">Sample Caption</h2>\n			<p>Lorem ipsum dolor sit amet consectetur</p>\n		</div>\n\n		<div class=\"caption light1 top-right narrow\">\n			<h2 class=\"heading permanent\">Sample Caption</h2>\n			<p>Lorem ipsum dolor sit amet consectetur</p>\n		</div>\n\n		<div class=\"caption light1 top\">\n			<h2 class=\"heading permanent\">Sample Caption</h2>\n			<p>Lorem ipsum dolor sit amet consectetur</p>\n		</div>\n\n</a>','2015-02-19 08:31:06','2015-02-19 08:31:06',1),(47,'Home slide 3','block_slide3','<a href=\"{{store url=\'about-magento-demo-store\'}}\">\n	<img src=\"{{media url=\'wysiwyg/infortis/ultimo/slideshow/03.jpg\'}}\" alt=\"Sample slide\" />\n\n		<div class=\"caption dark3\">\n			<h2 class=\"heading permanent\">Sample Caption</h2>\n			<p>Etiam neque velit, blandit sed scelerisque quis. Lorem ipsum.</p>\n			<p>Lorem ipsum dolor sit amet consectetur</p>\n		</div>\n\n		<div class=\"caption dark1 top-right\">\n			<h2 class=\"heading permanent\">Sample Caption</h2>\n			<p>Nullam ornare enim nec justo bibendum lobortis metus</p>\n		</div>\n\n</a>','2015-02-19 08:31:06','2015-02-19 08:31:06',1),(48,'Custom landing page 3 - category banner','block_landing_page3','<div class=\"horizontal-section\">\n\n	<a href=\"{{store direct_url=\'#\'}}\">\n		<img src=\"{{media url=\"wysiwyg/infortis/ultimo/custom/landing/category01.jpg\"}}\" title=\"You can edit this block or replace it with custom content\" alt=\"Sample banner\" />\n    \n		<div class=\"caption light2 full-width\">\n			<h2 class=\"heading permanent\">Category Banner</h2>\n			<p>Upload image and description for every category in the store</p>\n			<p>Create custom category blocks</p>\n		</div>\n	</a>\n    \n</div>','2015-02-19 08:31:06','2015-02-19 08:31:06',1),(49,'Slideshow banners','block_slideshow_banners','<a class=\"banner\" href=\"{{store url=\'about-magento-demo-store\'}}\">\n	<img src=\"{{media url=\'wysiwyg/infortis/ultimo/slideshow/banner/01.png\'}}\" alt=\"Sample banner\" />\n\n	<div class=\"caption light1 full-width right\">\n		<p class=\"right\">Sample caption</p>\n	</div>\n\n</a>\n\n<a class=\"banner\" href=\"{{store url=\'about-magento-demo-store\'}}\">\n	<img src=\"{{media url=\'wysiwyg/infortis/ultimo/slideshow/banner/02.png\'}}\" alt=\"Sample banner\" />\n\n	<div class=\"caption dark1 full-width right\">\n		<p class=\"right\">Add custom text</p>\n	</div>\n\n</a>\n\n<a class=\"banner\" href=\"{{store url=\'about-magento-demo-store\'}}\">\n	<img src=\"{{media url=\'wysiwyg/infortis/ultimo/slideshow/banner/03.png\'}}\" alt=\"Sample banner\" />\n\n	<div class=\"caption dark3 full-width right\">\n		<p class=\"right\">Simple example</p>\n	</div>\n</a>','2015-02-19 08:31:07','2015-02-19 08:31:07',1),(50,'Home page - preface','block_home_preface','<span class=\"section-line\"></span>\n<br/>\n<div class=\"grid12-3\">\n\n	<div class=\"feature feature-icon-hover large\">\n		<span class=\"icon large\">\n			<img src=\"{{media url=\'wysiwyg/infortis/ultimo/icons/large/paintbrush.png\'}}\" />\n		</span>\n		<h6 class=\"above-heading\">Customizable design</h6>\n		<h3>Unlimited Colors</h3>\n		<p>You have never seen so many options! Change colors of dozens of elements, apply textures, upload background images...</p>\n		<a href=\"{{store url=\'ultimo-responsive-magento-theme\'}}\" class=\"go\">See all features</a>\n	</div>\n\n</div>\n<div class=\"grid12-3\">\n\n	<div class=\"feature feature-icon-hover large\">\n		<span class=\"icon large\">\n			<img src=\"{{media url=\'wysiwyg/infortis/ultimo/icons/large/responsive.png\'}}\" />\n		</span>\n		<h6 class=\"above-heading\">12-column grid</h6>\n		<h3>Responsive Layout</h3>\n		<p>Ultimo can be displayed on any screen. It is based on fluid grid system. If screen is resized, layout will be automatically adjusted...</p>\n		<a href=\"{{store url=\'ultimo-responsive-magento-theme\'}}\" class=\"go\">See all features</a>\n	</div>\n\n</div>\n<div class=\"grid12-3\">\n\n	<div class=\"feature feature-icon-hover large\">\n		<span class=\"icon large\">\n			<img src=\"{{media url=\'wysiwyg/infortis/ultimo/icons/large/menu.png\'}}\" />\n		</span>\n		<h6 class=\"above-heading\">Customizable drop-down menu</h6>\n		<h3>Mega Menu</h3>\n		<p>Two styles: wide mega menu or classic drop-down menu. You can add any custom content (images, text, HTML) to any category in the catalog...</p>\n		<a href=\"{{store url=\'ultimo-responsive-magento-theme\'}}\" class=\"go\">See all features</a>\n	</div>\n\n</div>\n<div class=\"grid12-3\">\n\n	<div class=\"feature feature-icon-hover large\">\n		<span class=\"icon large\">\n			<img src=\"{{media url=\'wysiwyg/infortis/ultimo/icons/large/star.png\'}}\" />\n		</span>\n		<h6 class=\"above-heading\">Content placeholders</h6>\n		<h3>50+ CMS blocks</h3>\n		<p>You can use content placeholders to display custom content in almost every part of the store. Import sample CMS blocks from the demo...</p>\n		<a href=\"{{store url=\'ultimo-responsive-magento-theme\'}}\" class=\"go\">See all features</a>\n	</div>\n\n</div>\n<div class=\"clearer\"></div>\n<br/>\n<span class=\"section-line\"></span>\n<br/>\n<br/>','2015-02-19 08:31:07','2015-02-19 08:31:07',0),(51,'Home page - left 2','block_home_left2','<div class=\"block\">\n	<div class=\"block-title\">\n		<strong><span>Home Custom Block</span></strong>\n	</div>\n\n	<p style=\"background-color: #f5f5f5; color:#666; padding:10px; margin-bottom:10px; margin-top:10px;\">\n		Custom CMS block displayed at the left sidebar on the home page. Put your own content here: text, HTML, images - whatever you like.\n	</p>\n	<p style=\"background-color: #f5f5f5; color:#666; padding:10px;\">\n		There are many similar content placeholders across the store. All editable from admin panel.\n	</p>\n</div>','2015-02-19 08:31:08','2015-02-19 08:31:08',1),(52,'Home page - left 1','block_home_left1','{{block type=\"ultramegamenu/navigation\" template=\"infortis/ultramegamenu/categories.phtml\"}}','2015-02-19 08:31:08','2015-02-19 08:31:08',0),(53,'Home page - left 3','block_home_left3','<div class=\"block\">\n	<div class=\"block-title\">\n		<strong><span>Another Custom Block</span></strong>\n	</div>\n\n	<p style=\"background-color: #f5f5f5; color:#666; padding:10px; margin-bottom:10px; margin-top:10px;\">\n		Custom CMS block displayed at the left sidebar on the home page. Put your own content here: text, HTML, images - whatever you like.\n	</p>\n</div>','2015-02-19 08:31:08','2015-02-19 08:31:08',1),(54,'Home page - postscript','block_home_postscript','Placeholder for custom content (block_home_postscript)','2015-02-19 08:31:09','2015-02-19 08:31:09',0),(55,'Home page - right 3','block_home_right3','<div class=\"block\">\n	<div class=\"block-title\">\n		<strong><span>Another Custom Block</span></strong>\n	</div>\n	<div class=\"block-content sample-block\">\n		<p>Custom CMS block displayed at the right sidebar on the home page. Put your own content here: text, HTML, images - whatever you like.</p>\n	</div>\n	<div class=\"block-content sample-block\">\n		<p>There are many similar content placeholders across the store. All editable from admin panel. </p>\n	</div>\n</div>','2015-02-19 08:31:09','2015-02-19 08:31:09',1),(56,'Home page - right 2','block_home_right2','<div class=\"block\">\n	<div class=\"block-title\">\n		<strong><span>Home Custom Block</span></strong>\n	</div>\n\n	<p style=\"background-color: #f5f5f5; color:#666; padding:10px; margin-bottom:10px; margin-top:10px;\">\n		Custom CMS block displayed at the right sidebar on the home page. Put your own content here: text, HTML, images - whatever you like.\n	</p>\n	<p style=\"background-color: #f5f5f5; color:#666; padding:10px;\">\n		There are many similar content placeholders across the store. All editable from admin panel.\n	</p>\n</div>','2015-02-19 08:31:09','2015-02-19 08:31:09',1),(57,'Home page - right 1','block_home_right1','{{block type=\"ultramegamenu/navigation\" parent=\"root\" depth=\"2\" block_name=\"My Category Block\" template=\"infortis/ultramegamenu/categories.phtml\"}}\n','2015-02-19 08:31:10','2015-02-19 08:31:10',0),(58,'Right sidebar bottom','block_right_bottom','<div class=\"block\">\n	<div class=\"block-title\">\n		<strong><span>Custom Block (bottom)</span></strong>\n	</div>\n	<div class=\"block-content sample-block\">\n		<p>Custom CMS block displayed at the bottom of the right sidebar.  There are many similar content placeholders across the store.</p>\n	</div>\n</div>','2015-02-19 08:31:10','2015-02-19 08:31:10',1),(59,'Header top right 2','block_header_top_right2','Sample content of the static block','2015-02-19 08:31:10','2015-02-19 08:31:10',0),(60,'Header top right','block_header_top_right','Sample content of the top right static block','2015-02-19 08:31:11','2015-02-19 08:31:11',0),(61,'Main menu - custom links','block_nav_links','	<li class=\"level0 level-top right\">\n		<a class=\"level-top\" href=\"{{store direct_url=\'about-magento-demo-store\'}}\" title=\"About Us\">\n			<span>About Us</span>\n		</a>\n	</li>','2015-02-19 08:31:11','2015-02-19 08:31:11',1);
/*!40000 ALTER TABLE `mag_cms_block` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_cms_block_store`
--

DROP TABLE IF EXISTS `mag_cms_block_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_cms_block_store` (
  `block_id` smallint(6) NOT NULL COMMENT 'Block ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  PRIMARY KEY (`block_id`,`store_id`),
  KEY `IDX_MAG_CMS_BLOCK_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MAG_CMS_BLOCK_STORE_BLOCK_ID_MAG_CMS_BLOCK_BLOCK_ID` FOREIGN KEY (`block_id`) REFERENCES `mag_cms_block` (`block_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CMS_BLOCK_STORE_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS Block To Store Linkage Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_cms_block_store`
--

LOCK TABLES `mag_cms_block_store` WRITE;
/*!40000 ALTER TABLE `mag_cms_block_store` DISABLE KEYS */;
INSERT INTO `mag_cms_block_store` VALUES (1,0),(2,0),(3,0),(4,0),(5,0),(6,0),(7,0),(8,0),(9,0),(10,0),(11,0),(12,0),(13,0),(14,0),(15,0),(16,0),(17,0),(18,0),(19,0),(20,0),(21,0),(22,0),(23,0),(24,0),(25,0),(26,0),(27,0),(28,0),(29,0),(30,0),(31,0),(32,0),(33,0),(34,0),(35,0),(36,0),(37,0),(38,0),(39,0),(40,0),(41,0),(42,0),(43,0),(44,0),(45,0),(46,0),(47,0),(48,0),(49,0),(50,0),(51,0),(52,0),(53,0),(54,0),(55,0),(56,0),(57,0),(58,0),(59,0),(60,0),(61,0);
/*!40000 ALTER TABLE `mag_cms_block_store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_cms_page`
--

DROP TABLE IF EXISTS `mag_cms_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_cms_page` (
  `page_id` smallint(6) NOT NULL AUTO_INCREMENT COMMENT 'Page ID',
  `title` varchar(255) DEFAULT NULL COMMENT 'Page Title',
  `root_template` varchar(255) DEFAULT NULL COMMENT 'Page Template',
  `meta_keywords` text COMMENT 'Page Meta Keywords',
  `meta_description` text COMMENT 'Page Meta Description',
  `identifier` varchar(100) DEFAULT NULL COMMENT 'Page String Identifier',
  `content_heading` varchar(255) DEFAULT NULL COMMENT 'Page Content Heading',
  `content` mediumtext COMMENT 'Page Content',
  `creation_time` timestamp NULL DEFAULT NULL COMMENT 'Page Creation Time',
  `update_time` timestamp NULL DEFAULT NULL COMMENT 'Page Modification Time',
  `is_active` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Is Page Active',
  `sort_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Page Sort Order',
  `layout_update_xml` text COMMENT 'Page Layout Update Content',
  `custom_theme` varchar(100) DEFAULT NULL COMMENT 'Page Custom Theme',
  `custom_root_template` varchar(255) DEFAULT NULL COMMENT 'Page Custom Template',
  `custom_layout_update_xml` text COMMENT 'Page Custom Layout Update Content',
  `custom_theme_from` date DEFAULT NULL COMMENT 'Page Custom Theme Active From Date',
  `custom_theme_to` date DEFAULT NULL COMMENT 'Page Custom Theme Active To Date',
  PRIMARY KEY (`page_id`),
  KEY `IDX_MAG_CMS_PAGE_IDENTIFIER` (`identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='CMS Page Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_cms_page`
--

LOCK TABLES `mag_cms_page` WRITE;
/*!40000 ALTER TABLE `mag_cms_page` DISABLE KEYS */;
INSERT INTO `mag_cms_page` VALUES (1,'404 Not Found 1','two_columns_right','Page keywords','Page description','no-route',NULL,'\n<div class=\"page-title\"><h1>Whoops, our bad...</h1></div>\n<dl>\n    <dt>The page you requested was not found, and we have a fine guess why.</dt>\n    <dd>\n        <ul class=\"disc\">\n            <li>If you typed the URL directly, please make sure the spelling is correct.</li>\n            <li>If you clicked on a link to get here, the link is outdated.</li>\n        </ul>\n    </dd>\n</dl>\n<dl>\n    <dt>What can you do?</dt>\n    <dd>Have no fear, help is near! There are many ways you can get back on track with Magento Store.</dd>\n    <dd>\n        <ul class=\"disc\">\n            <li><a href=\"#\" onclick=\"history.go(-1); return false;\">Go back</a> to the previous page.</li>\n            <li>Use the search bar at the top of the page to search for your products.</li>\n            <li>Follow these links to get you back on track!<br /><a href=\"{{store url=\"\"}}\">Store Home</a>\n            <span class=\"separator\">|</span> <a href=\"{{store url=\"customer/account\"}}\">My Account</a></li>\n        </ul>\n    </dd>\n</dl>\n','2015-02-19 08:09:05','2015-02-19 08:09:05',1,0,NULL,NULL,NULL,NULL,NULL,NULL),(2,'Home page','two_columns_right',NULL,NULL,'home',NULL,'<div class=\"page-title\"><h2>Home Page</h2></div>','2015-02-19 08:09:05','2015-02-19 08:09:24',1,0,'<!--<reference name=\"content\">\n        <block type=\"catalog/product_new\" name=\"home.catalog.product.new\" alias=\"product_new\" template=\"catalog/product/new.phtml\" after=\"cms_page\">\n            <action method=\"addPriceBlockType\">\n                <type>bundle</type>\n                <block>bundle/catalog_product_price</block>\n                <template>bundle/catalog/product/price.phtml</template>\n            </action>\n        </block>\n        <block type=\"reports/product_viewed\" name=\"home.reports.product.viewed\" alias=\"product_viewed\" template=\"reports/home_product_viewed.phtml\" after=\"product_new\">\n            <action method=\"addPriceBlockType\">\n                <type>bundle</type>\n                <block>bundle/catalog_product_price</block>\n                <template>bundle/catalog/product/price.phtml</template>\n            </action>\n        </block>\n        <block type=\"reports/product_compared\" name=\"home.reports.product.compared\" template=\"reports/home_product_compared.phtml\" after=\"product_viewed\">\n            <action method=\"addPriceBlockType\">\n                <type>bundle</type>\n                <block>bundle/catalog_product_price</block>\n                <template>bundle/catalog/product/price.phtml</template>\n            </action>\n        </block>\n    </reference>\n    <reference name=\"right\">\n        <action method=\"unsetChild\"><alias>right.reports.product.viewed</alias></action>\n        <action method=\"unsetChild\"><alias>right.reports.product.compared</alias></action>\n    </reference>-->',NULL,NULL,NULL,NULL,NULL),(3,'About Us','two_columns_right',NULL,NULL,'about-magento-demo-store',NULL,'\n<div class=\"page-title\">\n    <h1>About Magento Store</h1>\n</div>\n<div class=\"col3-set\">\n<div class=\"col-1\"><p style=\"line-height:1.2em;\"><small>Lorem ipsum dolor sit amet, consectetuer adipiscing elit.\nMorbi luctus. Duis lobortis. Nulla nec velit. Mauris pulvinar erat non massa. Suspendisse tortor turpis, porta nec,\ntempus vitae, iaculis semper, pede.</small></p>\n<p style=\"color:#888; font:1.2em/1.4em georgia, serif;\">Lorem ipsum dolor sit amet, consectetuer adipiscing elit.\nMorbi luctus. Duis lobortis. Nulla nec velit. Mauris pulvinar erat non massa. Suspendisse tortor turpis,\nporta nec, tempus vitae, iaculis semper, pede. Cras vel libero id lectus rhoncus porta.</p></div>\n<div class=\"col-2\">\n<p><strong style=\"color:#de036f;\">Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi luctus.\nDuis lobortis. Nulla nec velit.</strong></p>\n<p>Vivamus tortor nisl, lobortis in, faucibus et, tempus at, dui. Nunc risus. Proin scelerisque augue. Nam ullamcorper.\nPhasellus id massa. Pellentesque nisl. Pellentesque habitant morbi tristique senectus et netus et malesuada\nfames ac turpis egestas. Nunc augue. Aenean sed justo non leo vehicula laoreet. Praesent ipsum libero, auctor ac,\ntempus nec, tempor nec, justo. </p>\n<p>Maecenas ullamcorper, odio vel tempus egestas, dui orci faucibus orci, sit amet aliquet lectus dolor et quam.\nPellentesque consequat luctus purus. Nunc et risus. Etiam a nibh. Phasellus dignissim metus eget nisi.\nVestibulum sapien dolor, aliquet nec, porta ac, malesuada a, libero. Praesent feugiat purus eget est.\nNulla facilisi. Vestibulum tincidunt sapien eu velit. Mauris purus. Maecenas eget mauris eu orci accumsan feugiat.\nPellentesque eget velit. Nunc tincidunt.</p></div>\n<div class=\"col-3\">\n<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi luctus. Duis lobortis. Nulla nec velit.\nMauris pulvinar erat non massa. Suspendisse tortor turpis, porta nec, tempus vitae, iaculis semper, pede.\nCras vel libero id lectus rhoncus porta. Suspendisse convallis felis ac enim. Vivamus tortor nisl, lobortis in,\nfaucibus et, tempus at, dui. Nunc risus. Proin scelerisque augue. Nam ullamcorper </p>\n<p><strong style=\"color:#de036f;\">Maecenas ullamcorper, odio vel tempus egestas, dui orci faucibus orci,\nsit amet aliquet lectus dolor et quam. Pellentesque consequat luctus purus.</strong></p>\n<p>Nunc et risus. Etiam a nibh. Phasellus dignissim metus eget nisi.</p>\n<div class=\"divider\"></div>\n<p>To all of you, from all of us at Magento Store - Thank you and Happy eCommerce!</p>\n<p style=\"line-height:1.2em;\"><strong style=\"font:italic 2em Georgia, serif;\">John Doe</strong><br />\n<small>Some important guy</small></p></div>\n</div>','2015-02-19 08:09:05','2015-02-19 08:09:05',1,0,NULL,NULL,NULL,NULL,NULL,NULL),(4,'Customer Service','three_columns',NULL,NULL,'customer-service',NULL,'<div class=\"page-title\">\n<h1>Customer Service</h1>\n</div>\n<ul class=\"disc\">\n<li><a href=\"#answer1\">Shipping &amp; Delivery</a></li>\n<li><a href=\"#answer2\">Privacy &amp; Security</a></li>\n<li><a href=\"#answer3\">Returns &amp; Replacements</a></li>\n<li><a href=\"#answer4\">Ordering</a></li>\n<li><a href=\"#answer5\">Payment, Pricing &amp; Promotions</a></li>\n<li><a href=\"#answer6\">Viewing Orders</a></li>\n<li><a href=\"#answer7\">Updating Account Information</a></li>\n</ul>\n<dl>\n<dt id=\"answer1\">Shipping &amp; Delivery</dt>\n<dd>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi luctus. Duis lobortis. Nulla nec velit.\nMauris pulvinar erat non massa. Suspendisse tortor turpis, porta nec, tempus vitae, iaculis semper, pede.\nCras vel libero id lectus rhoncus porta. Suspendisse convallis felis ac enim. Vivamus tortor nisl, lobortis in,\nfaucibus et, tempus at, dui. Nunc risus. Proin scelerisque augue. Nam ullamcorper. Phasellus id massa.\nPellentesque nisl. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.\nNunc augue. Aenean sed justo non leo vehicula laoreet. Praesent ipsum libero, auctor ac, tempus nec, tempor nec,\njusto.</dd>\n<dt id=\"answer2\">Privacy &amp; Security</dt>\n<dd>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi luctus. Duis lobortis. Nulla nec velit.\nMauris pulvinar erat non massa. Suspendisse tortor turpis, porta nec, tempus vitae, iaculis semper, pede.\nCras vel libero id lectus rhoncus porta. Suspendisse convallis felis ac enim. Vivamus tortor nisl, lobortis in,\nfaucibus et, tempus at, dui. Nunc risus. Proin scelerisque augue. Nam ullamcorper. Phasellus id massa.\nPellentesque nisl. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.\nNunc augue. Aenean sed justo non leo vehicula laoreet. Praesent ipsum libero, auctor ac, tempus nec, tempor nec,\njusto.</dd>\n<dt id=\"answer3\">Returns &amp; Replacements</dt>\n<dd>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi luctus. Duis lobortis. Nulla nec velit.\nMauris pulvinar erat non massa. Suspendisse tortor turpis, porta nec, tempus vitae, iaculis semper, pede.\nCras vel libero id lectus rhoncus porta. Suspendisse convallis felis ac enim. Vivamus tortor nisl, lobortis in,\nfaucibus et, tempus at, dui. Nunc risus. Proin scelerisque augue. Nam ullamcorper. Phasellus id massa.\nPellentesque nisl. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.\nNunc augue. Aenean sed justo non leo vehicula laoreet. Praesent ipsum libero, auctor ac, tempus nec, tempor nec,\njusto.</dd>\n<dt id=\"answer4\">Ordering</dt>\n<dd>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi luctus. Duis lobortis. Nulla nec velit.\nMauris pulvinar erat non massa. Suspendisse tortor turpis, porta nec, tempus vitae, iaculis semper, pede.\nCras vel libero id lectus rhoncus porta. Suspendisse convallis felis ac enim. Vivamus tortor nisl, lobortis in,\nfaucibus et, tempus at, dui. Nunc risus. Proin scelerisque augue. Nam ullamcorper. Phasellus id massa.\nPellentesque nisl. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.\nNunc augue. Aenean sed justo non leo vehicula laoreet. Praesent ipsum libero, auctor ac, tempus nec, tempor nec,\njusto.</dd>\n<dt id=\"answer5\">Payment, Pricing &amp; Promotions</dt>\n<dd>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi luctus. Duis lobortis. Nulla nec velit.\nMauris pulvinar erat non massa. Suspendisse tortor turpis, porta nec, tempus vitae, iaculis semper, pede.\nCras vel libero id lectus rhoncus porta. Suspendisse convallis felis ac enim. Vivamus tortor nisl, lobortis in,\nfaucibus et, tempus at, dui. Nunc risus. Proin scelerisque augue. Nam ullamcorper. Phasellus id massa.\nPellentesque nisl. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.\nNunc augue. Aenean sed justo non leo vehicula laoreet. Praesent ipsum libero, auctor ac, tempus nec, tempor nec,\njusto.</dd>\n<dt id=\"answer6\">Viewing Orders</dt>\n<dd>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi luctus. Duis lobortis. Nulla nec velit.\nMauris pulvinar erat non massa. Suspendisse tortor turpis, porta nec, tempus vitae, iaculis semper, pede.\nCras vel libero id lectus rhoncus porta. Suspendisse convallis felis ac enim. Vivamus tortor nisl, lobortis in,\nfaucibus et, tempus at, dui. Nunc risus. Proin scelerisque augue. Nam ullamcorper. Phasellus id massa.\n Pellentesque nisl. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.\n Nunc augue. Aenean sed justo non leo vehicula laoreet. Praesent ipsum libero, auctor ac, tempus nec, tempor nec,\n justo.</dd>\n<dt id=\"answer7\">Updating Account Information</dt>\n<dd>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi luctus. Duis lobortis. Nulla nec velit.\n Mauris pulvinar erat non massa. Suspendisse tortor turpis, porta nec, tempus vitae, iaculis semper, pede.\n Cras vel libero id lectus rhoncus porta. Suspendisse convallis felis ac enim. Vivamus tortor nisl, lobortis in,\n faucibus et, tempus at, dui. Nunc risus. Proin scelerisque augue. Nam ullamcorper. Phasellus id massa.\n Pellentesque nisl. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.\n Nunc augue. Aenean sed justo non leo vehicula laoreet. Praesent ipsum libero, auctor ac, tempus nec, tempor nec,\n justo.</dd>\n</dl>','2015-02-19 08:09:05','2015-02-19 08:09:05',1,0,NULL,NULL,NULL,NULL,NULL,NULL),(5,'Enable Cookies','one_column',NULL,NULL,'enable-cookies',NULL,'<div class=\"std\">\n    <ul class=\"messages\">\n        <li class=\"notice-msg\">\n            <ul>\n                <li>Please enable cookies in your web browser to continue.</li>\n            </ul>\n        </li>\n    </ul>\n    <div class=\"page-title\">\n        <h1><a name=\"top\"></a>What are Cookies?</h1>\n    </div>\n    <p>Cookies are short pieces of data that are sent to your computer when you visit a website.\n    On later visits, this data is then returned to that website. Cookies allow us to recognize you automatically\n    whenever you visit our site so that we can personalize your experience and provide you with better service.\n    We also use cookies (and similar browser data, such as Flash cookies) for fraud prevention and other purposes.\n     If your web browser is set to refuse cookies from our website, you will not be able to complete a purchase\n     or take advantage of certain features of our website, such as storing items in your Shopping Cart or\n     receiving personalized recommendations. As a result, we strongly encourage you to configure your web\n     browser to accept cookies from our website.</p>\n    <h2 class=\"subtitle\">Enabling Cookies</h2>\n    <ul class=\"disc\">\n        <li><a href=\"#ie7\">Internet Explorer 7.x</a></li>\n        <li><a href=\"#ie6\">Internet Explorer 6.x</a></li>\n        <li><a href=\"#firefox\">Mozilla/Firefox</a></li>\n        <li><a href=\"#opera\">Opera 7.x</a></li>\n    </ul>\n    <h3><a name=\"ie7\"></a>Internet Explorer 7.x</h3>\n    <ol>\n        <li>\n            <p>Start Internet Explorer</p>\n        </li>\n        <li>\n            <p>Under the <strong>Tools</strong> menu, click <strong>Internet Options</strong></p>\n            <p><img src=\"{{skin url=\"images/cookies/ie7-1.gif\"}}\" alt=\"\" /></p>\n        </li>\n        <li>\n            <p>Click the <strong>Privacy</strong> tab</p>\n            <p><img src=\"{{skin url=\"images/cookies/ie7-2.gif\"}}\" alt=\"\" /></p>\n        </li>\n        <li>\n            <p>Click the <strong>Advanced</strong> button</p>\n            <p><img src=\"{{skin url=\"images/cookies/ie7-3.gif\"}}\" alt=\"\" /></p>\n        </li>\n        <li>\n            <p>Put a check mark in the box for <strong>Override Automatic Cookie Handling</strong>,\n            put another check mark in the <strong>Always accept session cookies </strong>box</p>\n            <p><img src=\"{{skin url=\"images/cookies/ie7-4.gif\"}}\" alt=\"\" /></p>\n        </li>\n        <li>\n            <p>Click <strong>OK</strong></p>\n            <p><img src=\"{{skin url=\"images/cookies/ie7-5.gif\"}}\" alt=\"\" /></p>\n        </li>\n        <li>\n            <p>Click <strong>OK</strong></p>\n            <p><img src=\"{{skin url=\"images/cookies/ie7-6.gif\"}}\" alt=\"\" /></p>\n        </li>\n        <li>\n            <p>Restart Internet Explore</p>\n        </li>\n    </ol>\n    <p class=\"a-top\"><a href=\"#top\">Back to Top</a></p>\n    <h3><a name=\"ie6\"></a>Internet Explorer 6.x</h3>\n    <ol>\n        <li>\n            <p>Select <strong>Internet Options</strong> from the Tools menu</p>\n            <p><img src=\"{{skin url=\"images/cookies/ie6-1.gif\"}}\" alt=\"\" /></p>\n        </li>\n        <li>\n            <p>Click on the <strong>Privacy</strong> tab</p>\n        </li>\n        <li>\n            <p>Click the <strong>Default</strong> button (or manually slide the bar down to <strong>Medium</strong>)\n            under <strong>Settings</strong>. Click <strong>OK</strong></p>\n            <p><img src=\"{{skin url=\"images/cookies/ie6-2.gif\"}}\" alt=\"\" /></p>\n        </li>\n    </ol>\n    <p class=\"a-top\"><a href=\"#top\">Back to Top</a></p>\n    <h3><a name=\"firefox\"></a>Mozilla/Firefox</h3>\n    <ol>\n        <li>\n            <p>Click on the <strong>Tools</strong>-menu in Mozilla</p>\n        </li>\n        <li>\n            <p>Click on the <strong>Options...</strong> item in the menu - a new window open</p>\n        </li>\n        <li>\n            <p>Click on the <strong>Privacy</strong> selection in the left part of the window. (See image below)</p>\n            <p><img src=\"{{skin url=\"images/cookies/firefox.png\"}}\" alt=\"\" /></p>\n        </li>\n        <li>\n            <p>Expand the <strong>Cookies</strong> section</p>\n        </li>\n        <li>\n            <p>Check the <strong>Enable cookies</strong> and <strong>Accept cookies normally</strong> checkboxes</p>\n        </li>\n        <li>\n            <p>Save changes by clicking <strong>Ok</strong>.</p>\n        </li>\n    </ol>\n    <p class=\"a-top\"><a href=\"#top\">Back to Top</a></p>\n    <h3><a name=\"opera\"></a>Opera 7.x</h3>\n    <ol>\n        <li>\n            <p>Click on the <strong>Tools</strong> menu in Opera</p>\n        </li>\n        <li>\n            <p>Click on the <strong>Preferences...</strong> item in the menu - a new window open</p>\n        </li>\n        <li>\n            <p>Click on the <strong>Privacy</strong> selection near the bottom left of the window. (See image below)</p>\n            <p><img src=\"{{skin url=\"images/cookies/opera.png\"}}\" alt=\"\" /></p>\n        </li>\n        <li>\n            <p>The <strong>Enable cookies</strong> checkbox must be checked, and <strong>Accept all cookies</strong>\n            should be selected in the &quot;<strong>Normal cookies</strong>&quot; drop-down</p>\n        </li>\n        <li>\n            <p>Save changes by clicking <strong>Ok</strong></p>\n        </li>\n    </ol>\n    <p class=\"a-top\"><a href=\"#top\">Back to Top</a></p>\n</div>\n','2015-02-19 08:09:05','2015-02-19 08:09:05',1,0,NULL,NULL,NULL,NULL,NULL,NULL),(6,'Privacy Policy','one_column',NULL,NULL,'privacy-policy-cookie-restriction-mode','Privacy Policy','<p style=\"color: #ff0000; font-weight: bold; font-size: 13px\">\n    Please replace this text with you Privacy Policy.\n    Please add any additional cookies your website uses below (e.g., Google Analytics)\n</p>\n<p>\n    This privacy policy sets out how {{config path=\"general/store_information/name\"}} uses and protects any information\n    that you give {{config path=\"general/store_information/name\"}} when you use this website.\n    {{config path=\"general/store_information/name\"}} is committed to ensuring that your privacy is protected.\n    Should we ask you to provide certain information by which you can be identified when using this website,\n    then you can be assured that it will only be used in accordance with this privacy statement.\n    {{config path=\"general/store_information/name\"}} may change this policy from time to time by updating this page.\n    You should check this page from time to time to ensure that you are happy with any changes.\n</p>\n<h2>What we collect</h2>\n<p>We may collect the following information:</p>\n<ul>\n    <li>name</li>\n    <li>contact information including email address</li>\n    <li>demographic information such as postcode, preferences and interests</li>\n    <li>other information relevant to customer surveys and/or offers</li>\n</ul>\n<p>\n    For the exhaustive list of cookies we collect see the <a href=\"#list\">List of cookies we collect</a> section.\n</p>\n<h2>What we do with the information we gather</h2>\n<p>\n    We require this information to understand your needs and provide you with a better service,\n    and in particular for the following reasons:\n</p>\n<ul>\n    <li>Internal record keeping.</li>\n    <li>We may use the information to improve our products and services.</li>\n    <li>\n        We may periodically send promotional emails about new products, special offers or other information which we\n        think you may find interesting using the email address which you have provided.\n    </li>\n    <li>\n        From time to time, we may also use your information to contact you for market research purposes.\n        We may contact you by email, phone, fax or mail. We may use the information to customise the website\n        according to your interests.\n    </li>\n</ul>\n<h2>Security</h2>\n<p>\n    We are committed to ensuring that your information is secure. In order to prevent unauthorised access or disclosure,\n    we have put in place suitable physical, electronic and managerial procedures to safeguard and secure\n    the information we collect online.\n</p>\n<h2>How we use cookies</h2>\n<p>\n    A cookie is a small file which asks permission to be placed on your computer\'s hard drive.\n    Once you agree, the file is added and the cookie helps analyse web traffic or lets you know when you visit\n    a particular site. Cookies allow web applications to respond to you as an individual. The web application\n    can tailor its operations to your needs, likes and dislikes by gathering and remembering information about\n    your preferences.\n</p>\n<p>\n    We use traffic log cookies to identify which pages are being used. This helps us analyse data about web page traffic\n    and improve our website in order to tailor it to customer needs. We only use this information for statistical\n    analysis purposes and then the data is removed from the system.\n</p>\n<p>\n    Overall, cookies help us provide you with a better website, by enabling us to monitor which pages you find useful\n    and which you do not. A cookie in no way gives us access to your computer or any information about you,\n    other than the data you choose to share with us. You can choose to accept or decline cookies.\n    Most web browsers automatically accept cookies, but you can usually modify your browser setting\n    to decline cookies if you prefer. This may prevent you from taking full advantage of the website.\n</p>\n<h2>Links to other websites</h2>\n<p>\n    Our website may contain links to other websites of interest. However, once you have used these links\n    to leave our site, you should note that we do not have any control over that other website.\n    Therefore, we cannot be responsible for the protection and privacy of any information which you provide whilst\n    visiting such sites and such sites are not governed by this privacy statement.\n    You should exercise caution and look at the privacy statement applicable to the website in question.\n</p>\n<h2>Controlling your personal information</h2>\n<p>You may choose to restrict the collection or use of your personal information in the following ways:</p>\n<ul>\n    <li>\n        whenever you are asked to fill in a form on the website, look for the box that you can click to indicate\n        that you do not want the information to be used by anybody for direct marketing purposes\n    </li>\n    <li>\n        if you have previously agreed to us using your personal information for direct marketing purposes,\n        you may change your mind at any time by writing to or emailing us at\n        {{config path=\"trans_email/ident_general/email\"}}\n    </li>\n</ul>\n<p>\n    We will not sell, distribute or lease your personal information to third parties unless we have your permission\n    or are required by law to do so. We may use your personal information to send you promotional information\n    about third parties which we think you may find interesting if you tell us that you wish this to happen.\n</p>\n<p>\n    You may request details of personal information which we hold about you under the Data Protection Act 1998.\n    A small fee will be payable. If you would like a copy of the information held on you please write to\n    {{config path=\"general/store_information/address\"}}.\n</p>\n<p>\n    If you believe that any information we are holding on you is incorrect or incomplete,\n    please write to or email us as soon as possible, at the above address.\n    We will promptly correct any information found to be incorrect.\n</p>\n<h2><a name=\"list\"></a>List of cookies we collect</h2>\n<p>The table below lists the cookies we collect and what information they store.</p>\n<table class=\"data-table\">\n    <thead>\n        <tr>\n            <th>COOKIE name</th>\n            <th>COOKIE Description</th>\n        </tr>\n    </thead>\n    <tbody>\n        <tr>\n            <th>CART</th>\n            <td>The association with your shopping cart.</td>\n        </tr>\n        <tr>\n            <th>CATEGORY_INFO</th>\n            <td>Stores the category info on the page, that allows to display pages more quickly.</td>\n        </tr>\n        <tr>\n            <th>COMPARE</th>\n            <td>The items that you have in the Compare Products list.</td>\n        </tr>\n        <tr>\n            <th>CURRENCY</th>\n            <td>Your preferred currency</td>\n        </tr>\n        <tr>\n            <th>CUSTOMER</th>\n            <td>An encrypted version of your customer id with the store.</td>\n        </tr>\n        <tr>\n            <th>CUSTOMER_AUTH</th>\n            <td>An indicator if you are currently logged into the store.</td>\n        </tr>\n        <tr>\n            <th>CUSTOMER_INFO</th>\n            <td>An encrypted version of the customer group you belong to.</td>\n        </tr>\n        <tr>\n            <th>CUSTOMER_SEGMENT_IDS</th>\n            <td>Stores the Customer Segment ID</td>\n        </tr>\n        <tr>\n            <th>EXTERNAL_NO_CACHE</th>\n            <td>A flag, which indicates whether caching is disabled or not.</td>\n        </tr>\n        <tr>\n            <th>FRONTEND</th>\n            <td>You sesssion ID on the server.</td>\n        </tr>\n        <tr>\n            <th>GUEST-VIEW</th>\n            <td>Allows guests to edit their orders.</td>\n        </tr>\n        <tr>\n            <th>LAST_CATEGORY</th>\n            <td>The last category you visited.</td>\n        </tr>\n        <tr>\n            <th>LAST_PRODUCT</th>\n            <td>The most recent product you have viewed.</td>\n        </tr>\n        <tr>\n            <th>NEWMESSAGE</th>\n            <td>Indicates whether a new message has been received.</td>\n        </tr>\n        <tr>\n            <th>NO_CACHE</th>\n            <td>Indicates whether it is allowed to use cache.</td>\n        </tr>\n        <tr>\n            <th>PERSISTENT_SHOPPING_CART</th>\n            <td>A link to information about your cart and viewing history if you have asked the site.</td>\n        </tr>\n        <tr>\n            <th>POLL</th>\n            <td>The ID of any polls you have recently voted in.</td>\n        </tr>\n        <tr>\n            <th>POLLN</th>\n            <td>Information on what polls you have voted on.</td>\n        </tr>\n        <tr>\n            <th>RECENTLYCOMPARED</th>\n            <td>The items that you have recently compared.            </td>\n        </tr>\n        <tr>\n            <th>STF</th>\n            <td>Information on products you have emailed to friends.</td>\n        </tr>\n        <tr>\n            <th>STORE</th>\n            <td>The store view or language you have selected.</td>\n        </tr>\n        <tr>\n            <th>USER_ALLOWED_SAVE_COOKIE</th>\n            <td>Indicates whether a customer allowed to use cookies.</td>\n        </tr>\n        <tr>\n            <th>VIEWED_PRODUCT_IDS</th>\n            <td>The products that you have recently viewed.</td>\n        </tr>\n        <tr>\n            <th>WISHLIST</th>\n            <td>An encrypted list of products added to your Wishlist.</td>\n        </tr>\n        <tr>\n            <th>WISHLIST_CNT</th>\n            <td>The number of items in your Wishlist.</td>\n        </tr>\n    </tbody>\n</table>','2015-02-19 08:09:06','2015-02-19 08:09:06',1,0,NULL,NULL,NULL,NULL,NULL,NULL),(7,'ULTIMO Home Page',NULL,NULL,NULL,'ultimo-home-page',NULL,'<span class=\"section-line\"></span>\n<br/>\n<div class=\"grid12-4\">\n\n	<div class=\"feature feature-icon-hover indent large\">\n		<span class=\"icon large\">\n			<img src=\"{{media url=\'wysiwyg/infortis/ultimo/icons/large/paintbrush.png\'}}\" alt=\"Customizable design\" />\n		</span>\n		<h6 class=\"above-heading\">Customizable design</h6>\n		<h3>Unlimited Colors</h3>\n		<p>You have never seen so many options! Change colors of dozens of elements, apply textures, upload background images...</p>\n		<a href=\"{{store url=\'ultimo-responsive-magento-theme\'}}\" class=\"go\">See all features</a>\n	</div>\n\n</div>\n<div class=\"grid12-4\">\n\n	<div class=\"feature feature-icon-hover indent large\">\n		<span class=\"icon large\">\n			<img src=\"{{media url=\'wysiwyg/infortis/ultimo/icons/large/responsive.png\'}}\" alt=\"Responsive Layout\" />\n		</span>\n		<h6 class=\"above-heading\">12-column grid</h6>\n		<h3>Responsive Layout</h3>\n		<p>Ultimo can be displayed on any screen. It is based on fluid grid system. If screen is resized, layout will be automatically adjusted...</p>\n		<a href=\"{{store url=\'ultimo-responsive-magento-theme\'}}\" class=\"go\">See all features</a>\n	</div>\n\n</div>\n<div class=\"grid12-4\">\n\n	<div class=\"feature feature-icon-hover indent large\">\n		<span class=\"icon large\">\n			<img src=\"{{media url=\'wysiwyg/infortis/ultimo/icons/large/menu.png\'}}\" alt=\"Mega Menu\" />\n		</span>\n		<h6 class=\"above-heading\">Customizable drop-down menu</h6>\n		<h3>Mega Menu</h3>\n		<p>Two styles: wide mega menu or classic drop-down menu. You can add any custom content (images, text, HTML) to any category in the catalog...</p>\n		<a href=\"{{store url=\'ultimo-responsive-magento-theme\'}}\" class=\"go\">See all features</a>\n	</div>\n\n</div>\n<div class=\"clearer\"></div>\n\n\n\n<br/>\n<br/>\n{{block type=\"ultimo/product_list_featured\" category_id=\"37\" product_count=\"16\" show_items=\"5\" is_responsive=\"1\" centered=\"1\" move=\"2\" hide_button=\"1\" block_name=\"See Our Featured Products\" template=\"catalog/product/list_featured_slider.phtml\"}}\n\n{{block type=\"brands/brands\" show_items=\"4\" is_responsive=\"1\" timeout=\"3000\" init_delay=\"3000\" move=\"1\" block_name=\"Product Brands\" template=\"infortis/brands/brand_slider.phtml\"}}\n\n{{block type=\"ultimo/product_list_featured\" category_id=\"15\" product_count=\"16\" show_items=\"5\" is_responsive=\"1\" centered=\"1\"  move=\"2\" hide_button=\"1\" block_name=\"See Our Featured Products\" template=\"catalog/product/list_featured_slider.phtml\"}}\n\n<!--\nblock type=\"catalog/product_new\" products_count=\"10\" show_items=\"5\" is_responsive=\"1\" centered=\"1\" block_name=\"New Products in our Store\" hide_button=\"1\" template=\"catalog/product/new.phtml\"}}\n-->\n\n\n\n<span class=\"section-title\">Sample Custom Banners</span>\n<br />\n<div class=\"nested-container\">\n\n	<div class=\"page-banners grid-row\">\n		<div class=\"grid12-3 banner\">\n			<a href=\"{{store direct_url=\'typography#banners\'}}\" title=\"Click to see more exemples of banners\">\n				<img src=\"{{media url=\"wysiwyg/infortis/ultimo/custom/banners/11.png\"}}\" alt=\"Sample banner\" />\n			</a>\n		</div>\n		<div class=\"grid12-3 banner\">\n			<a href=\"{{store direct_url=\'typography#banners\'}}\" title=\"Click to see more exemples of banners\">\n				<img src=\"{{media url=\"wysiwyg/infortis/ultimo/custom/banners/11.png\"}}\" alt=\"Sample banner\" />\n			</a>\n		</div>\n		<div class=\"grid12-6 banner fade-on-hover\">\n			<a href=\"{{store direct_url=\'typography#banners\'}}\" title=\"Click to see more exemples of banners\">\n				<img src=\"{{media url=\"wysiwyg/infortis/ultimo/custom/banners/03.png\"}}\" alt=\"Sample banner\" />\n			</a>\n		</div>\n	</div>\n\n	<div class=\"page-banners grid-row\">\n		<div class=\"grid12-6 banner\">\n			<a href=\"{{store direct_url=\'typography#banners\'}}\" title=\"Click to see more exemples of banners\">\n				<img src=\"{{media url=\"wysiwyg/infortis/ultimo/custom/banners/03.png\"}}\" alt=\"Sample banner\" />\n			</a>\n		</div>\n		<div class=\"grid12-3 banner\">\n			<a href=\"{{store direct_url=\'typography#banners\'}}\" title=\"Click to see more exemples of banners\">\n				<img src=\"{{media url=\"wysiwyg/infortis/ultimo/custom/banners/11.png\"}}\" alt=\"Sample banner\" />\n			</a>\n		</div>\n		<div class=\"grid12-3 banner\">\n			<a href=\"{{store direct_url=\'typography#banners\'}}\" title=\"Click to see more exemples of banners\">\n				<img src=\"{{media url=\"wysiwyg/infortis/ultimo/custom/banners/11.png\"}}\" alt=\"Sample banner\" />\n			</a>\n		</div>\n	</div>\n\n</div>\n\n\n\n\n<br/>\n<br/>\n<div class=\"grid12-3\">\n\n	<div class=\"feature feature-icon-hover\">\n		<span class=\"icon i-twitter-w\"></span>\n		<h6 class=\"above-heading\">Secondary Heading</h6>\n		<h4>Sample Heading</h4>\n		<p>Lorem ipsum dolor sit, consectetur adipiscing elit. Etiam neque velit, blandit rory solare de equis.</p>\n		<a href=\"#\" class=\"go\">Read more</a>\n	</div>\n\n</div>\n<div class=\"grid12-3 hide-below-768\">\n\n	<div class=\"feature feature-icon-hover\">\n		<span class=\"icon i-vimeo-w\"></span>\n		<h6 class=\"above-heading\">Secondary Heading</h6>\n		<h4>Feature Title</h4>\n		<p>Lorem ipsum dolor sit, consectetur adipiscing elit. Etiam neque velit, blandit sed scelerisque quis.</p>\n		<a href=\"#\" class=\"go\">Read more</a>\n	</div>\n\n</div>\n<div class=\"grid12-3 hide-below-768\">\n\n	<div class=\"feature feature-icon-hover\">\n		<span class=\"icon i-wordpress-w\"></span>\n		<h6 class=\"above-heading\">Secondary Heading</h6>\n		<h4>Sample Title</h4>\n		<p>Lorem ipsum dolor sit, consectetur adipiscing elit. Etiam neque velit, blandit sed scelerisque quis.</p>\n		<a href=\"#\" class=\"go\">Read more</a>\n	</div>\n\n</div>\n<div class=\"grid12-3 hide-below-768\">\n\n	<div class=\"feature feature-icon-hover\">\n		<span class=\"icon i-envato-w\"></span>\n		<h6 class=\"above-heading\">Secondary Heading</h6>\n		<h4>Feature Title</h4>\n		<p>Lorem ipsum dolor sit, consectetur adipiscing elit. Etiam neque velit, blandit sed scelerisque quis.</p>\n		<a href=\"http://themeforest.net/item/fortis-flexible-magento-theme/1744309?ref=infortis\" class=\"go\">Read more</a>\n	</div>\n\n</div>\n<div class=\"clearer\"></div>\n<br/>\n<br/>\n','2015-02-19 08:31:30','2015-02-19 08:31:30',1,0,NULL,NULL,NULL,NULL,NULL,NULL),(8,'ULTIMO Ultimo - Responsive Magento Theme | Download',NULL,NULL,NULL,'ultimo-responsive-magento-theme',NULL,'Add custom content in: CMS > Pages','2015-02-19 08:31:31','2015-02-19 08:31:31',1,0,NULL,NULL,NULL,NULL,NULL,NULL),(9,'ULTIMO Home Page 2',NULL,NULL,NULL,'ultimo-home-page2',NULL,'<span class=\"section-line\"></span>\n<br/>\n<div class=\"grid12-4\">\n\n	<div class=\"feature feature-icon-hover indent large\">\n		<span class=\"icon large\">\n			<img src=\"{{media url=\'wysiwyg/infortis/ultimo/icons/large/paintbrush.png\'}}\" alt=\"sample icon\" />\n		</span>\n		<h6 class=\"above-heading\">Customizable design</h6>\n		<h3>Unlimited Colors</h3>\n		<p>You have never seen so many options! Change colors of dozens of elements, apply textures, upload background images...</p>\n		<a href=\"{{store url=\'ultimo-responsive-magento-theme\'}}\" class=\"go\">See all features</a>\n	</div>\n\n</div>\n<div class=\"grid12-4\">\n\n	<div class=\"feature feature-icon-hover indent large\">\n		<span class=\"icon large\">\n			<img src=\"{{media url=\'wysiwyg/infortis/ultimo/icons/large/responsive.png\'}}\" alt=\"sample icon\" />\n		</span>\n		<h6 class=\"above-heading\">12-column grid</h6>\n		<h3>Responsive Layout</h3>\n		<p>Ultimo can be displayed on any screen. It is based on fluid grid system. If screen is resized, layout will be automatically adjusted...</p>\n		<a href=\"{{store url=\'ultimo-responsive-magento-theme\'}}\" class=\"go\">See all features</a>\n	</div>\n\n</div>\n<div class=\"grid12-4\">\n\n	<div class=\"feature feature-icon-hover  indent large\">\n		<span class=\"icon large\">\n			<img src=\"{{media url=\'wysiwyg/infortis/ultimo/icons/large/star.png\'}}\" alt=\"sample icon\" />\n		</span>\n		<h6 class=\"above-heading\">Content placeholders</h6>\n		<h3>50+ CMS blocks</h3>\n		<p>You can use content placeholders to display custom content in almost every part of the store. Import sample CMS blocks from the demo...</p>\n		<a href=\"{{store url=\'ultimo-responsive-magento-theme\'}}\" class=\"go\">See all features</a>\n	</div>\n\n</div>\n<div class=\"clearer\"></div>\n\n\n\n<br/>\n<br/>\n{{block type=\"ultimo/product_list_featured\" category_id=\"6\" product_count=\"16\" show_items=\"5\" is_responsive=\"1\" centered=\"1\" move=\"2\" hide_button=\"1\" block_name=\"See Our Featured Products\" template=\"catalog/product/list_featured_slider.phtml\"}}\n{{block type=\"catalog/product_new\" products_count=\"10\" show_items=\"5\" is_responsive=\"1\" centered=\"1\" move=\"2\" hide_button=\"1\" block_name=\"New Products in our Store\" template=\"catalog/product/new.phtml\"}}\n\n\n\n<span class=\"section-title\">Sample Custom Banners</span>\n<br />\n\n	<div class=\"page-banners grid-row\">\n		<div class=\"grid12-3 banner\">\n			<a href=\"{{store direct_url=\'typography#banners\'}}\" title=\"Click to see more exemples of banners\">\n				<img src=\"{{media url=\"wysiwyg/infortis/ultimo/custom/banners/11.png\"}}\" alt=\"Sample banner\" />\n			</a>\n		</div>\n		<div class=\"grid12-3 banner\">\n			<a href=\"{{store direct_url=\'typography#banners\'}}\" title=\"Click to see more exemples of banners\">\n				<img src=\"{{media url=\"wysiwyg/infortis/ultimo/custom/banners/11.png\"}}\" alt=\"Sample banner\" />\n			</a>\n		</div>\n		<div class=\"grid12-6 banner fade-on-hover\">\n			<a href=\"{{store direct_url=\'typography#banners\'}}\" title=\"Click to see more exemples of banners\">\n				<img src=\"{{media url=\"wysiwyg/infortis/ultimo/custom/banners/03.png\"}}\" alt=\"Sample banner\" />\n			</a>\n		</div>\n	</div>\n\n\n\n\n<br/>\n<br/>\n<div class=\"grid12-3\">\n\n	<div class=\"feature feature-icon-hover\">\n		<span class=\"icon i-twitter-w\"></span>\n		<h6 class=\"above-heading\">Secondary Heading</h6>\n		<h4>Sample Heading</h4>\n		<p>Lorem ipsum dolor sit, consectetur adipiscing elit. Etiam neque velit, blandit rory solare de equis.</p>\n		<a href=\"#\" class=\"go\">Read more</a>\n	</div>\n\n</div>\n<div class=\"grid12-3 hide-below-768\">\n\n	<div class=\"feature feature-icon-hover\">\n		<span class=\"icon i-vimeo-w\"></span>\n		<h6 class=\"above-heading\">Secondary Heading</h6>\n		<h4>Feature Title</h4>\n		<p>Lorem ipsum dolor sit, consectetur adipiscing elit. Etiam neque velit, blandit sed scelerisque quis.</p>\n		<a href=\"#\" class=\"go\">Read more</a>\n	</div>\n\n</div>\n<div class=\"grid12-3 hide-below-768\">\n\n	<div class=\"feature feature-icon-hover\">\n		<span class=\"icon i-wordpress-w\"></span>\n		<h6 class=\"above-heading\">Secondary Heading</h6>\n		<h4>Sample Title</h4>\n		<p>Lorem ipsum dolor sit, consectetur adipiscing elit. Etiam neque velit, blandit sed scelerisque quis.</p>\n		<a href=\"#\" class=\"go\">Read more</a>\n	</div>\n\n</div>\n<div class=\"grid12-3 hide-below-768\">\n\n	<div class=\"feature feature-icon-hover\">\n		<span class=\"icon i-envato-w\"></span>\n		<h6 class=\"above-heading\">Secondary Heading</h6>\n		<h4>Feature Title</h4>\n		<p>Lorem ipsum dolor sit, consectetur adipiscing elit. Etiam neque velit, blandit sed scelerisque quis.</p>\n		<a href=\"http://themeforest.net/item/fortis-flexible-magento-theme/1744309?ref=infortis\" class=\"go\">Read more</a>\n	</div>\n\n</div>\n<div class=\"clearer\"></div>\n\n\n\n<br/>\n{{block type=\"brands/brands\" show_items=\"4\" is_responsive=\"1\" block_name=\"Product Brands\" template=\"infortis/brands/brand_slider.phtml\"}}\n','2015-02-19 08:31:31','2015-02-19 08:31:31',1,0,NULL,NULL,NULL,NULL,NULL,NULL),(10,'ULTIMO Typography | Ultimo - Responsive Magento Theme',NULL,NULL,NULL,'typography',NULL,'			{{block type=\"ultraslideshow/slideshow\" template=\"infortis/ultraslideshow/slideshow.phtml\"}}\n			{{block type=\"ultraslideshow/config\" template=\"infortis/ultraslideshow/config.phtml\" }}\n\n\n\n\n\n<div class=\"grid12-6\">\n\n<span class=\"section-title\">Sample of basic typography</span>\n<br/>\n\n<h1>H1 Heading</h1>\n<p>Lid est laborum et dolorum fuga. Et harum quidem rerum facilis est et expeditasi distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihilse impedit quo minus id quod amets untra dolor amet sad. Sed ut perspser iciatis unde omnis iste natus error sit voluptatem accusantium doloremque laste. Dolores sadips ipsums sits.</p>\n<div style=\"margin-top: 40px;\"></div>\n<h2>H2 Heading</h2>\n<p>Lid est laborum et dolorum fuga. Et harum quidem rerum facilis est et expeditasi distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihilse impedit quo minus id quod amets untra dolor amet sad. Sed ut perspser iciatis unde omnis iste natus error sit voluptatem accusantium doloremque laste. Dolores sadips ipsums sits.</p>\n<div style=\"margin-top: 40px;\"></div>\n<h3>H3 Heading</h3>\n<p>Lid est laborum et dolorum fuga. Et harum quidem rerum facilis est et expeditasi distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihilse impedit quo minus id quod amets untra dolor amet sad. Sed ut perspser iciatis unde omnis iste natus error sit voluptatem accusantium doloremque laste. Dolores sadips ipsums sits.</p>\n<div style=\"margin-top: 40px;\"></div>\n<h4>H4 Heading</h4>\n<p>Lid est laborum et dolorum fuga. Et harum quidem rerum facilis est et expeditasi distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihilse impedit quo minus id quod amets untra dolor amet sad. Sed ut perspser iciatis unde omnis iste natus error sit voluptatem accusantium doloremque laste. Dolores sadips ipsums sits.</p>\n<div style=\"margin-top: 40px;\"></div>\n<h5>H5 Heading</h5>\n<p>Lid est laborum et dolorum fuga. Et harum quidem rerum facilis est et expeditasi distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihilse impedit quo minus id quod amets untra dolor amet sad. Sed ut perspser iciatis unde omnis iste natus error sit voluptatem accusantium doloremque laste. Dolores sadips ipsums sits.</p>\n<div style=\"margin-top: 40px;\"></div>\n<h6>H6 Heading</h6>\n<p>Lid est laborum et dolorum fuga. Et harum quidem rerum facilis est et expeditasi distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihilse impedit quo minus id quod amets untra dolor amet sad. Sed ut perspser iciatis unde omnis iste natus error sit voluptatem accusantium doloremque laste. Dolores sadips ipsums sits.</p>\n\n</div>\n<div class=\"grid12-6\">\n\n	<span class=\"section-title\">Paragraphs with icons</span>\n	<br/>\n\n	<div class=\"feature feature-icon-hover indent large\">\n		<span class=\"icon large\">\n			<img src=\"{{media url=\"wysiwyg/infortis/ultimo/icons/large/star.png\"}}\" />\n		</span>\n		<h6 class=\"above-heading\">The Secondary Heading</h6>\n		<h3>Sample Heading</h3>\n		<p>Lorem ipsum dolor sit, consectetur adipiscing elit. Etiam neque velit, blandit sed scelerisque solare de equis.</p>\n		<p>Nullam ornare enim nec justo biben lobortis. In eget metus. Lorem ipsum dolor sit consectetur...</p>\n		<a href=\"#\" class=\"go\">Read more</a>\n	</div>\n	<br/>\n	<div class=\"feature feature-icon-hover indent large\">\n		<span class=\"icon large\">\n			<img src=\"{{media url=\"wysiwyg/infortis/ultimo/icons/large/world.png\"}}\" />\n		</span>\n		<h6 class=\"above-heading\">The Secondary Heading</h6>\n		<h3>Feature Title</h3>\n		<p>Lorem ipsum dolor sit, consectetur adipiscing elit. Etiam neque velit, blandit sed scelerisque quis.</p>\n		<p>Nullam ornare enim nec justo bibendum lobortis. In eget metus. Lorem ipsum dolor sit consectetur, adipiscing elit</p>\n		<a href=\"#\" class=\"go\">Read more</a>\n	</div>\n	<br/>\n	<div class=\"feature feature-icon-hover indent large\">\n		<span class=\"icon large\">\n			<img src=\"{{media url=\"wysiwyg/infortis/ultimo/icons/large/star.png\"}}\" />\n		</span>\n		<h6 class=\"above-heading\">The Secondary Heading</h6>\n		<h3>Sample Title</h3>\n		<p>Lorem ipsum dolor sit, consectetur adipiscing elit. Etiam neque velit, blandit sed scelerisque quis.</p>\n		<p>Nullam ornare enim nec justo bibendum lobortis. In eget metus. Lorem ipsum dolor sit consectetur, adipiscing elit</p>\n		<a href=\"#\" class=\"go\">Read more</a>\n	</div>\n	<br/>\n	<div class=\"feature feature-icon-hover indent large\">\n		<span class=\"icon large\">\n			<img src=\"{{media url=\"wysiwyg/infortis/ultimo/icons/large/world.png\"}}\" />\n		</span>\n		<h6 class=\"above-heading\">The Secondary Heading</h6>\n		<h3>Feature Title</h3>\n		<p>Lorem ipsum dolor sit, consectetur adipiscing elit. Etiam neque velit, blandit sed scelerisque quis.</p>\n		<p>Nullam ornare enim nec justo bibendum lobortis. In eget metus. Lorem ipsum dolor sit consectetur, adipiscing elit</p>\n		<a href=\"#\" class=\"go\">Read more</a>\n	</div>\n\n</div>\n<div class=\"clearer\"></div>\n\n\n\n<br/>\n<br/>\n<span class=\"section-title\">Ordered  and unordered lists</span>\n<br/>\n\n<div class=\"grid12-3\">\n\n	<ul class=\"bullet\">\n		<li><a href=\"#\">Sample Link</a></li>\n		<li><a href=\"#\">Lectus vitae ligula tempus</a></li>\n		<li><a href=\"#\">Vitae lorem ipsum dolor sit amet</a></li>\n		<li><a href=\"#\">Sample lectus vitae ligula tempus</a></li>\n		<li><a href=\"#\">Meat Our Best Partners</a></li>\n		<li><a href=\"#\">Our Other Projects</a></li>\n		<li><a href=\"#\">One Click To Join Us</a></li>\n		<li><a href=\"#\">Follow Us On Twitter</a></li>\n		<li><a href=\"http://infortis-themes.com/\">Magento Themes</a></li>\n	</ul>\n\n</div>\n<div class=\"grid12-3\">\n\n	<ul class=\"disc\">\n		<li><a href=\"#\">Sample Link</a></li>\n		<li><a href=\"#\">Lectus vitae ligula tempus</a></li>\n		<li><a href=\"#\">Vitae lorem ipsum dolor sit amet</a></li>\n		<li><a href=\"#\">Sample lectus vitae ligula tempus</a></li>\n		<li><a href=\"#\">Meat Our Best Partners</a></li>\n		<li><a href=\"#\">Our Other Projects</a></li>\n		<li><a href=\"#\">One Click To Join Us</a></li>\n		<li><a href=\"#\">Follow Us On Twitter</a></li>\n		<li><a href=\"http://infortis-themes.com/\">Magento Themes</a></li>\n	</ul>\n\n</div>\n<div class=\"grid12-3\">\n\n	<ol>\n		<li><a href=\"#\">Sample Link</a></li>\n		<li><a href=\"#\">Lectus vitae ligula tempus</a></li>\n		<li><a href=\"#\">Vitae lorem ipsum dolor sit amet</a></li>\n		<li><a href=\"#\">Sample lectus vitae ligula tempus</a></li>\n		<li><a href=\"#\">Meat Our Best Partners</a></li>\n		<li><a href=\"#\">Our Other Projects</a></li>\n		<li><a href=\"#\">One Click To Join Us</a></li>\n		<li><a href=\"#\">Follow Us On Twitter</a></li>\n		<li><a href=\"http://infortis-themes.com/\">Magento Themes</a></li>\n	</ol>\n\n</div>\n<div class=\"grid12-3\">\n\n		<div class=\"feature indent first\">\n			<span class=\"icon\">\n				<img src=\"{{media url=\'wysiwyg/infortis/ultimo/icons/one.png\'}}\" alt=\"Sample icon\"  />\n			</span>\n			<p class=\"no-margin\">Unlimited colors, dozens of customizable elements</p>\n		</div>\n		<div class=\"feature indent\">\n			<span class=\"icon\">\n				<img src=\"{{media url=\'wysiwyg/infortis/ultimo/icons/two.png\'}}\" alt=\"Sample icon\" />\n			</span>\n			<p class=\"no-margin \">Customizable responsive layout based on fluid grid</p>\n		</div>\n		<div class=\"feature indent\">\n			<span class=\"icon\">\n				<img src=\"{{media url=\'wysiwyg/infortis/ultimo/icons/three.png\'}}\" alt=\"Sample icon\" />\n			</span>\n			<p class=\"no-margin \">50+ placeholders to display custom content</p>\n		</div>\n		<div class=\"feature indent last\">\n			<span class=\"icon\">\n				<img src=\"{{media url=\'wysiwyg/infortis/ultimo/icons/four.png\'}}\" alt=\"Sample icon\" />\n			</span>\n			<p class=\"no-margin \">Create your custom sub-themes (variants)</p>\n		</div>\n\n</div>\n<div class=\"clearer\"></div>\n\n\n\n<br/>\n<br/>\n<span class=\"section-title\">System messages</span>\n<br/>\n\n<ul class=\"messages\">\n\n	<li class=\"success-msg\">\n		<ul><li><span>These are sample system messages displayed by Magento.</span></li></ul>\n	</li>\n	<li class=\"error-msg\">\n		<ul><li><span>The maximum quantity allowed for purchase is 10.</span></li></ul>\n	</li>\n	<li class=\"notice-msg\">\n		<ul><li><span>Please specify the product\'s option(s).</span></li></ul>\n	</li>\n	\n</ul>\n\n\n\n<br/>\n<br/>\n<span class=\"section-title\">Paragraphs with icons</span>\n<br/>\n\n<div class=\"grid12-4\">\n\n	<div class=\"feature feature-icon-hover large\">\n		<span class=\"icon large\">\n			<img src=\"{{media url=\"wysiwyg/infortis/ultimo/icons/large/star.png\"}}\" />\n		</span>\n		<h6 class=\"above-heading\">The Secondary Heading</h6>\n		<h3>Sample Heading</h3>\n		<p>Lorem ipsum dolor sit, consectetur adipiscing elit. Etiam neque velit, blandit sed scelerisque solare de equis.</p>\n		<p>Nullam ornare enim nec justo biben lobortis. In eget metus. Lorem ipsum dolor sit consectetur...</p>\n		<a href=\"#\" class=\"go\">Read more</a>\n	</div>\n\n</div>\n<div class=\"grid12-4\">\n\n	<div class=\"feature feature-icon-hover large\">\n		<span class=\"icon large\">\n			<img src=\"{{media url=\"wysiwyg/infortis/ultimo/icons/large/world.png\"}}\" />\n		</span>\n		<h6 class=\"above-heading\">The Secondary Heading</h6>\n		<h3>Feature Title</h3>\n		<p>Lorem ipsum dolor sit, consectetur adipiscing elit. Etiam neque velit, blandit sed scelerisque quis.</p>\n		<p>Nullam ornare enim nec justo bibendum lobortis. In eget metus. Lorem ipsum dolor sit consectetur, adipiscing elit</p>\n		<a href=\"#\" class=\"go\">Read more</a>\n	</div>\n\n</div>\n<div class=\"grid12-4\">\n\n	<div class=\"feature feature-icon-hover large\">\n		<span class=\"icon large\">\n			<img src=\"{{media url=\"wysiwyg/infortis/ultimo/icons/large/star.png\"}}\" />\n		</span>\n		<h6 class=\"above-heading\">The Secondary Heading</h6>\n		<h3>Sample Title</h3>\n		<p>Lorem ipsum dolor sit, consectetur adipiscing elit. Etiam neque velit, blandit sed scelerisque quis.</p>\n		<p>Nullam ornare enim nec justo bibendum lobortis. In eget metus. Lorem ipsum dolor sit consectetur, adipiscing elit</p>\n		<a href=\"#\" class=\"go\">Read more</a>\n	</div>\n\n</div>\n<div class=\"clearer\"></div>\n\n\n\n<br />\n<br />\n<h3 class=\"section-title\" id=\"banners\">Sample Custom Banners</h3>\n<br />\n\n<p>Here you can see some examples of banners.<br />\nBanners can be placed on any CMS page, and in any CMS block. Each banner is a simple image inside a link.</p>\n<br />\n\n<div class=\"nested-container hide-below-1280\">\n\n    <div class=\"page-banners clearer\">\n        <div class=\"grid12-6 banner\">\n            <a href=\"{{store direct_url=\"#\"}}\" title=\"Replace this image with your own\">\n                <img src=\"{{media url=\"wysiwyg/infortis/ultimo/custom/banners/01.png\"}}\" alt=\"Sample banner\" />\n            </a>\n        </div>\n        <div class=\"grid12-6 banner\">\n            <a href=\"{{store direct_url=\"#\"}}\" title=\"Replace this image with your own\">\n                <img src=\"{{media url=\"wysiwyg/infortis/ultimo/custom/banners/01.png\"}}\" alt=\"Sample banner\" />\n            </a>\n        </div>\n    </div>\n\n</div>\n\n\n<div class=\"nested-container hide-below-960\">\n\n    <div class=\"page-banners clearer\">\n        <div class=\"grid12-4 banner\">\n            <a href=\"{{store direct_url=\"about-magento-demo-store\"}}\" title=\"Replace this image with your own\">\n                <img src=\"{{media url=\"wysiwyg/infortis/ultimo/custom/banners/01.png\"}}\" alt=\"Sample banner\" />\n            </a>\n        </div>\n        <div class=\"grid12-4 banner\">\n            <a href=\"{{store direct_url=\"about-magento-demo-store\"}}\" title=\"Replace this image with your own\">\n                <img src=\"{{media url=\"wysiwyg/infortis/ultimo/custom/banners/01.png\"}}\" alt=\"Sample banner\" />\n            </a>\n        </div>\n        <div class=\"grid12-4 banner\">\n            <a href=\"{{store direct_url=\"about-magento-demo-store\"}}\" title=\"Replace this image with your own\">\n                <img src=\"{{media url=\"wysiwyg/infortis/ultimo/custom/banners/01.png\"}}\" alt=\"Sample banner\" />\n            </a>\n        </div>\n    </div>\n\n</div>\n\n\n<div class=\"nested-container hide-below-768\">\n\n    <div class=\"page-banners clearer\">\n        <div class=\"grid12-3 banner\">\n            <a href=\"{{store direct_url=\"about-magento-demo-store\"}}\" title=\"Replace this image with your own\">\n                <img src=\"{{media url=\"wysiwyg/infortis/ultimo/custom/banners/11.png\"}}\" alt=\"Sample banner\" />\n            </a>\n        </div>\n        <div class=\"grid12-3 banner\">\n            <a href=\"{{store direct_url=\"about-magento-demo-store\"}}\" title=\"Replace this image with your own\">\n                <img src=\"{{media url=\"wysiwyg/infortis/ultimo/custom/banners/11.png\"}}\" alt=\"Sample banner\" />\n            </a>\n        </div>\n        <div class=\"grid12-6 banner\">\n            <a href=\"{{store direct_url=\"about-magento-demo-store\"}}\" title=\"Replace this image with your own\">\n                <img src=\"{{media url=\"wysiwyg/infortis/ultimo/custom/banners/03.png\"}}\" alt=\"Sample banner\" />\n            </a>\n        </div>\n    </div>\n\n</div>\n\n\n<div class=\"nested-container\">\n\n    <div class=\"page-banners clearer\">\n        <div class=\"grid12-3 banner hide-below-768\">\n            <a href=\"{{store direct_url=\"about-magento-demo-store\"}}\" title=\"Replace this image with your own\">\n                <img src=\"{{media url=\"wysiwyg/infortis/ultimo/custom/banners/01.png\"}}\" alt=\"Sample banner\" />\n            </a>\n        </div>\n        <div class=\"grid12-3 banner hide-below-480\">\n            <a href=\"{{store direct_url=\"about-magento-demo-store\"}}\" title=\"Replace this image with your own\">\n                <img src=\"{{media url=\"wysiwyg/infortis/ultimo/custom/banners/01.png\"}}\" alt=\"Sample banner\" />\n            </a>\n       	</div>\n        <div class=\"grid12-3 banner\">\n            <a href=\"{{store direct_url=\"about-magento-demo-store\"}}\" title=\"Replace this image with your own\">\n                <img src=\"{{media url=\"wysiwyg/infortis/ultimo/custom/banners/01.png\"}}\" alt=\"Sample banner\" />\n            </a>\n        </div>\n        <div class=\"grid12-3 banner\">\n            <a href=\"{{store direct_url=\"about-magento-demo-store\"}}\" title=\"Replace this image with your own\">\n                <img src=\"{{media url=\"wysiwyg/infortis/ultimo/custom/banners/01.png\"}}\" alt=\"Sample banner\" />\n            </a>\n        </div>\n    </div>\n\n</div>','2015-02-19 08:31:32','2015-02-19 08:31:32',1,0,NULL,NULL,NULL,NULL,NULL,NULL),(11,'ULTIMO Home Page 3',NULL,NULL,NULL,'ultimo-home-page3',NULL,'<span class=\"section-line\"></span>\n<br/>\n<div class=\"grid12-4\">\n\n	<div class=\"feature feature-icon-hover indent large\">\n		<span class=\"icon large\">\n			<img src=\"{{media url=\'wysiwyg/infortis/ultimo/icons/large/paintbrush.png\'}}\" alt=\"sample icon\" />\n		</span>\n		<h3>Unlimited Colors</h3>\n		<p>You have never seen so many options! Change colors of dozens of elements, apply textures, upload background images...</p>\n		<a href=\"{{store url=\'ultimo-responsive-magento-theme\'}}\" class=\"go\">See all features</a>\n	</div>\n\n</div>\n<div class=\"grid12-4\">\n\n	<div class=\"feature feature-icon-hover indent large\">\n		<span class=\"icon large\">\n			<img src=\"{{media url=\'wysiwyg/infortis/ultimo/icons/large/responsive.png\'}}\" alt=\"sample icon\" />\n		</span>\n		<h3>Responsive Layout</h3>\n		<p>Ultimo can be displayed on any screen. It is based on fluid grid system. If screen is resized, layout will be automatically adjusted...</p>\n		<a href=\"{{store url=\'ultimo-responsive-magento-theme\'}}\" class=\"go\">See all features</a>\n	</div>\n\n</div>\n<div class=\"grid12-4\">\n\n	<div class=\"feature feature-icon-hover indent large\">\n		<span class=\"icon large\">\n			<img src=\"{{media url=\'wysiwyg/infortis/ultimo/icons/large/menu.png\'}}\" alt=\"sample icon\" />\n		</span>\n		<h3>Mega Menu</h3>\n		<p>Two styles: wide mega menu or classic drop-down menu. You can add any custom content (images, text, HTML) to any category in the catalog...</p>\n		<a href=\"{{store url=\'ultimo-responsive-magento-theme\'}}\" class=\"go\">See all features</a>\n	</div>\n\n</div>\n<div class=\"clearer\"></div>\n\n\n\n<br/>\n<br/>\n{{block type=\"ultimo/product_list_featured\" category_id=\"6\" product_count=\"16\" show_items=\"5\" is_responsive=\"1\" centered=\"1\" size=\"size-s\" move=\"2\" hide_button=\"1\" block_name=\"Our Featured Products\" template=\"catalog/product/list_featured_slider.phtml\"}}\n\n{{block type=\"ultimo/product_list_featured\" category_id=\"37\" product_count=\"16\" show_items=\"5\" is_responsive=\"1\" centered=\"1\" size=\"size-s\" move=\"2\" hide_button=\"1\" block_name=\"Our Featured Products\" template=\"catalog/product/list_featured_slider.phtml\"}}\n','2015-02-19 08:31:32','2015-02-19 08:31:32',1,0,NULL,NULL,NULL,NULL,NULL,NULL),(12,'ULTIMO Home Page 4',NULL,NULL,NULL,'ultimo-home-page4',NULL,'<div class=\"nested-container hide-below-768\">\n\n    <div class=\"page-banners clearer\">\n        <div class=\"grid12-4 banner hide-below-768\">\n            <a href=\"{{store direct_url=\'typography#banners\'}}\" title=\"Click to see more exemples of banners\">\n                <img src=\"{{media url=\'wysiwyg/infortis/ultimo/custom/banners/01.png\'}}\" alt=\"Sample banner\"  />\n            </a>\n        </div>\n        <div class=\"grid12-4 banner hide-below-480\">\n            <a href=\"{{store direct_url=\'typography#banners\'}}\" title=\"Replace this image with your own\">\n                <img src=\"{{media url=\'wysiwyg/infortis/ultimo/custom/banners/01.png\'}}\" alt=\"Sample banner\" />\n            </a>\n       	</div>\n        <div class=\"grid12-4 banner\">\n            <a href=\"{{store direct_url=\'typography#banners\'}}\" title=\"Replace this image with your own\">\n                <img src=\"{{media url=\'wysiwyg/infortis/ultimo/custom/banners/01.png\'}}\" alt=\"Sample banner\" />\n            </a>\n        </div>\n    </div>\n\n</div>\n<span class=\"clearer\"></span>\n\n\n\n<br/>\n<div class=\"grid12-4\">\n\n	<div class=\"feature feature-icon-hover large centered\">\n		<span class=\"icon large\">\n			<img src=\"{{media url=\'wysiwyg/infortis/ultimo/icons/large/paintbrush.png\'}}\" alt=\"sample icon\" />\n		</span>\n		<h6 class=\"above-heading\">Customizable design</h6>\n		<h3>Unlimited Colors</h3>\n		<p>You have never seen so many options! Change colors of dozens of elements, apply textures, upload background images...</p>\n		<a href=\"{{store url=\'ultimo-responsive-magento-theme\'}}\" class=\"go\">See all features</a>\n	</div>\n\n</div>\n<div class=\"grid12-4\">\n\n	<div class=\"feature feature-icon-hover centered large\">\n		<span class=\"icon large\">\n			<img src=\"{{media url=\'wysiwyg/infortis/ultimo/icons/large/responsive.png\'}}\" alt=\"sample icon\" />\n		</span>\n		<h6 class=\"above-heading\">12-column grid</h6>\n		<h3>Responsive Layout</h3>\n		<p>Ultimo can be displayed on any screen. It is based on fluid grid system. If screen is resized, layout will be automatically adjusted...</p>\n		<a href=\"{{store url=\'ultimo-responsive-magento-theme\'}}\" class=\"go\">See all features</a>\n	</div>\n\n</div>\n<div class=\"grid12-4\">\n\n	<div class=\"feature feature-icon-hover centered large\">\n		<span class=\"icon large\">\n			<img src=\"{{media url=\'wysiwyg/infortis/ultimo/icons/large/menu.png\'}}\" alt=\"sample icon\" />\n		</span>\n		<h6 class=\"above-heading\">Customizable drop-down menu</h6>\n		<h3>Mega Menu</h3>\n		<p>Two styles: wide mega menu or classic drop-down menu. You can add any custom content (images, text, HTML) to any category in the catalog...</p>\n		<a href=\"{{store url=\'ultimo-responsive-magento-theme\'}}\" class=\"go\">See all features</a>\n	</div>\n\n</div>\n<div class=\"clearer\"></div>\n<br/>\n<br/>\n\n\n\n{{block type=\"catalog/product_new\" products_count=\"10\" show_items=\"5\" is_responsive=\"1\" centered=\"1\" size=\"size-s\" move=\"2\" hide_button=\"1\" block_name=\"New Products in our Store\" template=\"catalog/product/new.phtml\"}}\n\n{{block type=\"brands/brands\" show_items=\"4\" is_responsive=\"1\" block_name=\"Product Brands\" template=\"infortis/brands/brand_slider.phtml\"}}\n<br />\n\n{{block type=\"ultimo/product_list_featured\" category_id=\"58\" product_count=\"16\" show_items=\"5\" is_responsive=\"1\" centered=\"1\" size=\"size-s\" move=\"2\" hide_button=\"1\" block_name=\"See Our Featured Products\" template=\"catalog/product/list_featured_slider.phtml\"}}\n\n\n\n\n\n<div class=\"grid12-3\">\n\n	<div class=\"feature feature-icon-hover\">\n		<span class=\"icon i-wordpress-w\"></span>\n		<h6 class=\"above-heading\">Secondary Heading</h6>\n		<h4>Sample Heading</h4>\n		<p>Lorem ipsum dolor sit, consectetur adipiscing elit. Etiam neque velit, blandit rory solare de equis.</p>\n		<a href=\"#\" class=\"go\">Read more</a>\n	</div>\n\n</div>\n<div class=\"grid12-3 hide-below-768\">\n\n	<div class=\"feature feature-icon-hover\">\n		<span class=\"icon i-googleplus-w\"></span>\n		<h6 class=\"above-heading\">Secondary Heading</h6>\n		<h4>Feature Title</h4>\n		<p>Lorem ipsum dolor sit, consectetur adipiscing elit. Etiam neque velit, blandit sed scelerisque quis.</p>\n		<a href=\"#\" class=\"go\">Read more</a>\n	</div>\n\n</div>\n<div class=\"grid12-3 hide-below-768\">\n\n	<div class=\"feature feature-icon-hover\">\n		<span class=\"icon i-vimeo-w\"></span>\n		<h6 class=\"above-heading\">Secondary Heading</h6>\n		<h4>Sample Title</h4>\n		<p>Lorem ipsum dolor sit, consectetur adipiscing elit. Etiam neque velit, blandit sed scelerisque quis.</p>\n		<a href=\"#\" class=\"go\">Read more</a>\n	</div>\n\n</div>\n<div class=\"grid12-3 hide-below-768\">\n\n	<div class=\"feature feature-icon-hover\">\n		<span class=\"icon i-facebook-w\"></span>\n		<h6 class=\"above-heading\">Secondary Heading</h6>\n		<h4>Feature Title</h4>\n		<p>Lorem ipsum dolor sit, consectetur adipiscing elit. Etiam neque velit, blandit sed scelerisque quis.</p>\n		<a href=\"#\" class=\"go\">Read more</a>\n	</div>\n\n</div>\n<div class=\"clearer\"></div>\n<br/>\n<br/>','2015-02-19 08:31:32','2015-02-19 08:31:32',1,0,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `mag_cms_page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_cms_page_store`
--

DROP TABLE IF EXISTS `mag_cms_page_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_cms_page_store` (
  `page_id` smallint(6) NOT NULL COMMENT 'Page ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  PRIMARY KEY (`page_id`,`store_id`),
  KEY `IDX_MAG_CMS_PAGE_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MAG_CMS_PAGE_STORE_PAGE_ID_MAG_CMS_PAGE_PAGE_ID` FOREIGN KEY (`page_id`) REFERENCES `mag_cms_page` (`page_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CMS_PAGE_STORE_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='CMS Page To Store Linkage Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_cms_page_store`
--

LOCK TABLES `mag_cms_page_store` WRITE;
/*!40000 ALTER TABLE `mag_cms_page_store` DISABLE KEYS */;
INSERT INTO `mag_cms_page_store` VALUES (1,0),(2,0),(3,0),(4,0),(5,0),(6,0),(7,0),(8,0),(9,0),(10,0),(11,0),(12,0);
/*!40000 ALTER TABLE `mag_cms_page_store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_core_cache`
--

DROP TABLE IF EXISTS `mag_core_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_core_cache` (
  `id` varchar(200) NOT NULL COMMENT 'Cache Id',
  `data` mediumblob COMMENT 'Cache Data',
  `create_time` int(11) DEFAULT NULL COMMENT 'Cache Creation Time',
  `update_time` int(11) DEFAULT NULL COMMENT 'Time of Cache Updating',
  `expire_time` int(11) DEFAULT NULL COMMENT 'Cache Expiration Time',
  PRIMARY KEY (`id`),
  KEY `IDX_MAG_CORE_CACHE_EXPIRE_TIME` (`expire_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Caches';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_core_cache`
--

LOCK TABLES `mag_core_cache` WRITE;
/*!40000 ALTER TABLE `mag_core_cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_core_cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_core_cache_option`
--

DROP TABLE IF EXISTS `mag_core_cache_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_core_cache_option` (
  `code` varchar(32) NOT NULL COMMENT 'Code',
  `value` smallint(6) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache Options';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_core_cache_option`
--

LOCK TABLES `mag_core_cache_option` WRITE;
/*!40000 ALTER TABLE `mag_core_cache_option` DISABLE KEYS */;
INSERT INTO `mag_core_cache_option` VALUES ('block_html',1),('collections',1),('config',1),('config_api',1),('config_api2',1),('eav',1),('layout',1),('translate',1);
/*!40000 ALTER TABLE `mag_core_cache_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_core_cache_tag`
--

DROP TABLE IF EXISTS `mag_core_cache_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_core_cache_tag` (
  `tag` varchar(100) NOT NULL COMMENT 'Tag',
  `cache_id` varchar(200) NOT NULL COMMENT 'Cache Id',
  PRIMARY KEY (`tag`,`cache_id`),
  KEY `IDX_MAG_CORE_CACHE_TAG_CACHE_ID` (`cache_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tag Caches';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_core_cache_tag`
--

LOCK TABLES `mag_core_cache_tag` WRITE;
/*!40000 ALTER TABLE `mag_core_cache_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_core_cache_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_core_config_data`
--

DROP TABLE IF EXISTS `mag_core_config_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_core_config_data` (
  `config_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Config Id',
  `scope` varchar(8) NOT NULL DEFAULT 'default' COMMENT 'Config Scope',
  `scope_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Config Scope Id',
  `path` varchar(255) NOT NULL DEFAULT 'general' COMMENT 'Config Path',
  `value` text COMMENT 'Config Value',
  PRIMARY KEY (`config_id`),
  UNIQUE KEY `UNQ_MAG_CORE_CONFIG_DATA_SCOPE_SCOPE_ID_PATH` (`scope`,`scope_id`,`path`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8 COMMENT='Config Data';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_core_config_data`
--

LOCK TABLES `mag_core_config_data` WRITE;
/*!40000 ALTER TABLE `mag_core_config_data` DISABLE KEYS */;
INSERT INTO `mag_core_config_data` VALUES (1,'default',0,'general/region/display_all','1'),(2,'default',0,'general/region/state_required','AT,CA,CH,DE,EE,ES,FI,FR,LT,LV,RO,US'),(3,'default',0,'catalog/category/root_id','2'),(4,'default',0,'payment/paypal_express/skip_order_review_step','1'),(5,'default',0,'payment/payflow_link/mobile_optimized','1'),(6,'default',0,'payment/payflow_advanced/mobile_optimized','1'),(7,'default',0,'payment/hosted_pro/mobile_optimized','1'),(8,'default',0,'admin/dashboard/enable_charts','1'),(9,'default',0,'web/unsecure/base_url','http://magento.dev/'),(10,'default',0,'web/secure/base_url','http://magento.dev/'),(11,'default',0,'general/locale/code','en_US'),(12,'default',0,'general/locale/timezone','America/Los_Angeles'),(13,'default',0,'currency/options/base','USD'),(14,'default',0,'currency/options/default','USD'),(15,'default',0,'currency/options/allow','USD'),(16,'default',0,'design/package/name','ultimo'),(17,'default',0,'design/package/ua_regexp','a:0:{}'),(18,'default',0,'design/theme/locale',NULL),(19,'default',0,'design/theme/template','shop'),(20,'default',0,'design/theme/template_ua_regexp','a:0:{}'),(21,'default',0,'design/theme/skin',NULL),(22,'default',0,'design/theme/skin_ua_regexp','a:0:{}'),(23,'default',0,'design/theme/layout',NULL),(24,'default',0,'design/theme/layout_ua_regexp','a:0:{}'),(25,'default',0,'design/theme/default',NULL),(26,'default',0,'design/theme/default_ua_regexp','a:0:{}'),(27,'default',0,'design/head/default_title','Magento Commerce'),(28,'default',0,'design/head/title_prefix',NULL),(29,'default',0,'design/head/title_suffix',NULL),(30,'default',0,'design/head/default_description','Default Description'),(31,'default',0,'design/head/default_keywords','Magento, Varien, E-commerce'),(32,'default',0,'design/head/default_robots','INDEX,FOLLOW'),(33,'default',0,'design/head/includes',NULL),(34,'default',0,'design/head/demonotice','0'),(35,'default',0,'design/header/logo_src','images/logo.gif'),(36,'default',0,'design/header/logo_alt','Magento Commerce'),(37,'default',0,'design/header/logo_src_small','images/logo.gif'),(38,'default',0,'design/header/welcome','Default welcome msg!'),(39,'default',0,'design/footer/copyright','&copy; 2014 Magento Demo Store. All Rights Reserved.'),(40,'default',0,'design/footer/absolute_footer',NULL),(41,'default',0,'design/watermark/image_size',NULL),(42,'default',0,'design/watermark/image_imageOpacity',NULL),(43,'default',0,'design/watermark/image_position','stretch'),(44,'default',0,'design/watermark/small_image_size',NULL),(45,'default',0,'design/watermark/small_image_imageOpacity',NULL),(46,'default',0,'design/watermark/small_image_position','stretch'),(47,'default',0,'design/watermark/thumbnail_size',NULL),(48,'default',0,'design/watermark/thumbnail_imageOpacity',NULL),(49,'default',0,'design/watermark/thumbnail_position','stretch'),(50,'default',0,'design/pagination/pagination_frame','5'),(51,'default',0,'design/pagination/pagination_frame_skip',NULL),(52,'default',0,'design/pagination/anchor_text_for_previous',NULL),(53,'default',0,'design/pagination/anchor_text_for_next',NULL),(54,'default',0,'design/email/logo_alt',NULL),(55,'default',0,'design/email/logo_width',NULL),(56,'default',0,'design/email/logo_height',NULL),(57,'default',0,'design/email/header','design_email_header'),(58,'default',0,'design/email/footer','design_email_footer'),(59,'default',0,'design/email/css_non_inline','email-non-inline.css'),(60,'default',0,'cms/wysiwyg/enabled','hidden'),(61,'default',0,'ultimo_design/nav/border','5');
/*!40000 ALTER TABLE `mag_core_config_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_core_email_queue`
--

DROP TABLE IF EXISTS `mag_core_email_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_core_email_queue` (
  `message_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Message Id',
  `entity_id` int(10) unsigned DEFAULT NULL COMMENT 'Entity ID',
  `entity_type` varchar(128) DEFAULT NULL COMMENT 'Entity Type',
  `event_type` varchar(128) DEFAULT NULL COMMENT 'Event Type',
  `message_body_hash` varchar(64) NOT NULL COMMENT 'Message Body Hash',
  `message_body` mediumtext NOT NULL COMMENT 'Message Body',
  `message_parameters` text NOT NULL COMMENT 'Message Parameters',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Creation Time',
  `processed_at` timestamp NULL DEFAULT NULL COMMENT 'Finish Time',
  PRIMARY KEY (`message_id`),
  KEY `118B03182A5C6A31DB6BE10335921DA1` (`entity_id`,`entity_type`,`event_type`,`message_body_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Email Queue';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_core_email_queue`
--

LOCK TABLES `mag_core_email_queue` WRITE;
/*!40000 ALTER TABLE `mag_core_email_queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_core_email_queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_core_email_queue_recipients`
--

DROP TABLE IF EXISTS `mag_core_email_queue_recipients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_core_email_queue_recipients` (
  `recipient_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Recipient Id',
  `message_id` int(10) unsigned NOT NULL COMMENT 'Message ID',
  `recipient_email` varchar(128) NOT NULL COMMENT 'Recipient Email',
  `recipient_name` varchar(255) NOT NULL COMMENT 'Recipient Name',
  `email_type` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Email Type',
  PRIMARY KEY (`recipient_id`),
  UNIQUE KEY `38EEAF40A0B378060A6868CF42A9F9B0` (`message_id`,`recipient_email`,`email_type`),
  KEY `IDX_MAG_CORE_EMAIL_QUEUE_RECIPIENTS_RECIPIENT_EMAIL` (`recipient_email`),
  KEY `IDX_MAG_CORE_EMAIL_QUEUE_RECIPIENTS_EMAIL_TYPE` (`email_type`),
  CONSTRAINT `FK_4A8FF6C0DF0EF503B65E5B4E2AF27077` FOREIGN KEY (`message_id`) REFERENCES `mag_core_email_queue` (`message_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Email Queue';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_core_email_queue_recipients`
--

LOCK TABLES `mag_core_email_queue_recipients` WRITE;
/*!40000 ALTER TABLE `mag_core_email_queue_recipients` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_core_email_queue_recipients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_core_email_template`
--

DROP TABLE IF EXISTS `mag_core_email_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_core_email_template` (
  `template_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Template Id',
  `template_code` varchar(150) NOT NULL COMMENT 'Template Name',
  `template_text` text NOT NULL COMMENT 'Template Content',
  `template_styles` text COMMENT 'Templste Styles',
  `template_type` int(10) unsigned DEFAULT NULL COMMENT 'Template Type',
  `template_subject` varchar(200) NOT NULL COMMENT 'Template Subject',
  `template_sender_name` varchar(200) DEFAULT NULL COMMENT 'Template Sender Name',
  `template_sender_email` varchar(200) DEFAULT NULL COMMENT 'Template Sender Email',
  `added_at` timestamp NULL DEFAULT NULL COMMENT 'Date of Template Creation',
  `modified_at` timestamp NULL DEFAULT NULL COMMENT 'Date of Template Modification',
  `orig_template_code` varchar(200) DEFAULT NULL COMMENT 'Original Template Code',
  `orig_template_variables` text COMMENT 'Original Template Variables',
  PRIMARY KEY (`template_id`),
  UNIQUE KEY `UNQ_MAG_CORE_EMAIL_TEMPLATE_TEMPLATE_CODE` (`template_code`),
  KEY `IDX_MAG_CORE_EMAIL_TEMPLATE_ADDED_AT` (`added_at`),
  KEY `IDX_MAG_CORE_EMAIL_TEMPLATE_MODIFIED_AT` (`modified_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Email Templates';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_core_email_template`
--

LOCK TABLES `mag_core_email_template` WRITE;
/*!40000 ALTER TABLE `mag_core_email_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_core_email_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_core_flag`
--

DROP TABLE IF EXISTS `mag_core_flag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_core_flag` (
  `flag_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Flag Id',
  `flag_code` varchar(255) NOT NULL COMMENT 'Flag Code',
  `state` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Flag State',
  `flag_data` text COMMENT 'Flag Data',
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Date of Last Flag Update',
  PRIMARY KEY (`flag_id`),
  KEY `IDX_MAG_CORE_FLAG_LAST_UPDATE` (`last_update`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Flag';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_core_flag`
--

LOCK TABLES `mag_core_flag` WRITE;
/*!40000 ALTER TABLE `mag_core_flag` DISABLE KEYS */;
INSERT INTO `mag_core_flag` VALUES (1,'admin_notification_survey',0,'a:1:{s:13:\"survey_viewed\";b:1;}','2015-02-19 08:10:24');
/*!40000 ALTER TABLE `mag_core_flag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_core_layout_link`
--

DROP TABLE IF EXISTS `mag_core_layout_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_core_layout_link` (
  `layout_link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Link Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `area` varchar(64) DEFAULT NULL COMMENT 'Area',
  `package` varchar(64) DEFAULT NULL COMMENT 'Package',
  `theme` varchar(64) DEFAULT NULL COMMENT 'Theme',
  `layout_update_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Layout Update Id',
  PRIMARY KEY (`layout_link_id`),
  UNIQUE KEY `UNQ_MAG_CORE_LAYOUT_LINK_STORE_ID_PACKAGE_THEME_LAYOUT_UPDATE_ID` (`store_id`,`package`,`theme`,`layout_update_id`),
  KEY `IDX_MAG_CORE_LAYOUT_LINK_LAYOUT_UPDATE_ID` (`layout_update_id`),
  CONSTRAINT `FK_B1FFAB9041AC90F763B02DF30345A9C7` FOREIGN KEY (`layout_update_id`) REFERENCES `mag_core_layout_update` (`layout_update_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CORE_LAYOUT_LINK_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Layout Link';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_core_layout_link`
--

LOCK TABLES `mag_core_layout_link` WRITE;
/*!40000 ALTER TABLE `mag_core_layout_link` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_core_layout_link` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_core_layout_update`
--

DROP TABLE IF EXISTS `mag_core_layout_update`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_core_layout_update` (
  `layout_update_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Layout Update Id',
  `handle` varchar(255) DEFAULT NULL COMMENT 'Handle',
  `xml` text COMMENT 'Xml',
  `sort_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`layout_update_id`),
  KEY `IDX_MAG_CORE_LAYOUT_UPDATE_HANDLE` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Layout Updates';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_core_layout_update`
--

LOCK TABLES `mag_core_layout_update` WRITE;
/*!40000 ALTER TABLE `mag_core_layout_update` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_core_layout_update` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_core_resource`
--

DROP TABLE IF EXISTS `mag_core_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_core_resource` (
  `code` varchar(50) NOT NULL COMMENT 'Resource Code',
  `version` varchar(50) DEFAULT NULL COMMENT 'Resource Version',
  `data_version` varchar(50) DEFAULT NULL COMMENT 'Data Version',
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Resources';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_core_resource`
--

LOCK TABLES `mag_core_resource` WRITE;
/*!40000 ALTER TABLE `mag_core_resource` DISABLE KEYS */;
INSERT INTO `mag_core_resource` VALUES ('adminnotification_setup','1.6.0.0','1.6.0.0'),('admin_setup','1.6.1.1','1.6.1.1'),('api2_setup','1.0.0.0','1.0.0.0'),('api_setup','1.6.0.1','1.6.0.1'),('backup_setup','1.6.0.0','1.6.0.0'),('bundle_setup','1.6.0.0.1','1.6.0.0.1'),('captcha_setup','1.7.0.0.0','1.7.0.0.0'),('catalogindex_setup','1.6.0.0','1.6.0.0'),('cataloginventory_setup','1.6.0.0.2','1.6.0.0.2'),('catalogrule_setup','1.6.0.3','1.6.0.3'),('catalogsearch_setup','1.8.2.0','1.8.2.0'),('catalog_setup','1.6.0.0.19','1.6.0.0.19'),('checkout_setup','1.6.0.0','1.6.0.0'),('cms_setup','1.6.0.0.2','1.6.0.0.2'),('compiler_setup','1.6.0.0','1.6.0.0'),('contacts_setup','1.6.0.0','1.6.0.0'),('core_setup','1.6.0.6','1.6.0.6'),('cron_setup','1.6.0.0','1.6.0.0'),('customer_setup','1.6.2.0.3','1.6.2.0.3'),('dataflow_setup','1.6.0.0','1.6.0.0'),('directory_setup','1.6.0.2','1.6.0.2'),('downloadable_setup','1.6.0.0.2','1.6.0.0.2'),('eav_setup','1.6.0.1','1.6.0.1'),('giftmessage_setup','1.6.0.0','1.6.0.0'),('googleanalytics_setup','1.6.0.0','1.6.0.0'),('importexport_setup','1.6.0.2','1.6.0.2'),('index_setup','1.6.0.0','1.6.0.0'),('log_setup','1.6.1.0','1.6.1.0'),('moneybookers_setup','1.6.0.0','1.6.0.0'),('newsletter_setup','1.6.0.2','1.6.0.2'),('oauth_setup','1.0.0.0','1.0.0.0'),('paygate_setup','1.6.0.0','1.6.0.0'),('payment_setup','1.6.0.0','1.6.0.0'),('paypaluk_setup','1.6.0.0','1.6.0.0'),('paypal_setup','1.6.0.6','1.6.0.6'),('persistent_setup','1.0.0.0','1.0.0.0'),('poll_setup','1.6.0.0','1.6.0.0'),('productalert_setup','1.6.0.0','1.6.0.0'),('rating_setup','1.6.0.0','1.6.0.0'),('reports_setup','1.6.0.0.1','1.6.0.0.1'),('review_setup','1.6.0.0','1.6.0.0'),('salesrule_setup','1.6.0.3','1.6.0.3'),('sales_setup','1.6.0.8','1.6.0.8'),('sendfriend_setup','1.6.0.0','1.6.0.0'),('shipping_setup','1.6.0.0','1.6.0.0'),('sitemap_setup','1.6.0.0','1.6.0.0'),('tag_setup','1.6.0.0','1.6.0.0'),('tax_setup','1.6.0.4','1.6.0.4'),('ultimo_setup','1.5.7','1.5.7'),('ultramegamenu_setup','1.0.0','1.0.0'),('usa_setup','1.6.0.3','1.6.0.3'),('weee_setup','1.6.0.0','1.6.0.0'),('widget_setup','1.6.0.0','1.6.0.0'),('wishlist_setup','1.6.0.0','1.6.0.0');
/*!40000 ALTER TABLE `mag_core_resource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_core_session`
--

DROP TABLE IF EXISTS `mag_core_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_core_session` (
  `session_id` varchar(255) NOT NULL COMMENT 'Session Id',
  `session_expires` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Date of Session Expiration',
  `session_data` mediumblob NOT NULL COMMENT 'Session Data',
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Database Sessions Storage';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_core_session`
--

LOCK TABLES `mag_core_session` WRITE;
/*!40000 ALTER TABLE `mag_core_session` DISABLE KEYS */;
INSERT INTO `mag_core_session` VALUES ('295jcv2hv5ies228tpj7j91tj0',1424348603,'core|a:3:{s:23:\"_session_validator_data\";a:4:{s:11:\"remote_addr\";s:9:\"127.0.0.1\";s:8:\"http_via\";s:0:\"\";s:20:\"http_x_forwarded_for\";s:0:\"\";s:15:\"http_user_agent\";s:109:\"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.111 Safari/537.36\";}s:9:\"_form_key\";s:16:\"Km0gc7fADOomX4js\";s:8:\"messages\";O:34:\"Mage_Core_Model_Message_Collection\":2:{s:12:\"\0*\0_messages\";a:0:{}s:20:\"\0*\0_lastAddedMessage\";N;}}adminhtml|a:3:{s:23:\"_session_validator_data\";a:4:{s:11:\"remote_addr\";s:9:\"127.0.0.1\";s:8:\"http_via\";s:0:\"\";s:20:\"http_x_forwarded_for\";s:0:\"\";s:15:\"http_user_agent\";s:109:\"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.111 Safari/537.36\";}s:6:\"locale\";s:5:\"en_US\";s:8:\"messages\";O:34:\"Mage_Core_Model_Message_Collection\":2:{s:12:\"\0*\0_messages\";a:0:{}s:20:\"\0*\0_lastAddedMessage\";O:31:\"Mage_Core_Model_Message_Success\":6:{s:8:\"\0*\0_type\";s:7:\"success\";s:8:\"\0*\0_code\";s:33:\"The configuration has been saved.\";s:9:\"\0*\0_class\";s:0:\"\";s:10:\"\0*\0_method\";s:0:\"\";s:14:\"\0*\0_identifier\";N;s:12:\"\0*\0_isSticky\";b:0;}}}admin|a:4:{s:23:\"_session_validator_data\";a:4:{s:11:\"remote_addr\";s:9:\"127.0.0.1\";s:8:\"http_via\";s:0:\"\";s:20:\"http_x_forwarded_for\";s:0:\"\";s:15:\"http_user_agent\";s:109:\"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.111 Safari/537.36\";}s:23:\"sync_process_stop_watch\";b:0;s:4:\"user\";O:21:\"Mage_Admin_Model_User\":17:{s:15:\"\0*\0_eventPrefix\";s:10:\"admin_user\";s:8:\"\0*\0_role\";N;s:25:\"\0*\0_hasAvailableResources\";b:1;s:15:\"\0*\0_eventObject\";s:6:\"object\";s:16:\"\0*\0_resourceName\";s:10:\"admin/user\";s:12:\"\0*\0_resource\";N;s:26:\"\0*\0_resourceCollectionName\";s:21:\"admin/user_collection\";s:12:\"\0*\0_cacheTag\";b:0;s:19:\"\0*\0_dataSaveAllowed\";b:1;s:15:\"\0*\0_isObjectNew\";N;s:8:\"\0*\0_data\";a:15:{s:7:\"user_id\";s:1:\"1\";s:9:\"firstname\";s:5:\"Vasya\";s:8:\"lastname\";s:8:\"Morarash\";s:5:\"email\";s:21:\"squirtle479@gmail.com\";s:8:\"username\";s:5:\"admin\";s:8:\"password\";s:65:\"998fca6c95103e4a4ac38f72c435e600:m6SbBevjpLo61HHjACqCHdNoTb00Dvde\";s:7:\"created\";s:19:\"2015-02-19 10:10:22\";s:8:\"modified\";s:19:\"2015-02-19 10:10:22\";s:7:\"logdate\";s:19:\"2015-02-19 11:21:35\";s:6:\"lognum\";s:1:\"4\";s:15:\"reload_acl_flag\";s:1:\"0\";s:9:\"is_active\";s:1:\"1\";s:5:\"extra\";a:1:{s:11:\"configState\";a:8:{s:14:\"design_package\";s:1:\"1\";s:12:\"design_theme\";s:1:\"1\";s:11:\"design_head\";s:1:\"0\";s:13:\"design_header\";s:1:\"0\";s:13:\"design_footer\";s:1:\"0\";s:16:\"design_watermark\";s:1:\"0\";s:17:\"design_pagination\";s:1:\"0\";s:12:\"design_email\";s:1:\"0\";}}s:8:\"rp_token\";N;s:19:\"rp_token_created_at\";N;}s:18:\"\0*\0_hasDataChanges\";b:0;s:12:\"\0*\0_origData\";a:15:{s:7:\"user_id\";s:1:\"1\";s:9:\"firstname\";s:5:\"Vasya\";s:8:\"lastname\";s:8:\"Morarash\";s:5:\"email\";s:21:\"squirtle479@gmail.com\";s:8:\"username\";s:5:\"admin\";s:8:\"password\";s:65:\"998fca6c95103e4a4ac38f72c435e600:m6SbBevjpLo61HHjACqCHdNoTb00Dvde\";s:7:\"created\";s:19:\"2015-02-19 10:10:22\";s:8:\"modified\";s:19:\"2015-02-19 10:10:22\";s:7:\"logdate\";s:19:\"2015-02-19 11:21:35\";s:6:\"lognum\";s:1:\"4\";s:15:\"reload_acl_flag\";s:1:\"0\";s:9:\"is_active\";s:1:\"1\";s:5:\"extra\";a:1:{s:11:\"configState\";a:8:{s:14:\"design_package\";s:1:\"1\";s:12:\"design_theme\";s:1:\"1\";s:11:\"design_head\";s:1:\"0\";s:13:\"design_header\";s:1:\"0\";s:13:\"design_footer\";s:1:\"0\";s:16:\"design_watermark\";s:1:\"0\";s:17:\"design_pagination\";s:1:\"0\";s:12:\"design_email\";s:1:\"0\";}}s:8:\"rp_token\";N;s:19:\"rp_token_created_at\";N;}s:15:\"\0*\0_idFieldName\";s:7:\"user_id\";s:13:\"\0*\0_isDeleted\";b:0;s:16:\"\0*\0_oldFieldsMap\";a:0:{}s:17:\"\0*\0_syncFieldsMap\";a:0:{}}s:3:\"acl\";O:20:\"Mage_Admin_Model_Acl\":6:{s:16:\"\0*\0_roleRegistry\";O:34:\"Mage_Admin_Model_Acl_Role_Registry\":1:{s:9:\"\0*\0_roles\";a:2:{s:2:\"G1\";a:3:{s:8:\"instance\";O:31:\"Mage_Admin_Model_Acl_Role_Group\":1:{s:10:\"\0*\0_roleId\";s:2:\"G1\";}s:7:\"parents\";a:0:{}s:8:\"children\";a:1:{s:2:\"U1\";O:30:\"Mage_Admin_Model_Acl_Role_User\":1:{s:10:\"\0*\0_roleId\";s:2:\"U1\";}}}s:2:\"U1\";a:3:{s:8:\"instance\";r:108;s:7:\"parents\";a:1:{s:2:\"G1\";r:104;}s:8:\"children\";a:0:{}}}}s:13:\"\0*\0_resources\";a:204:{s:3:\"all\";a:3:{s:8:\"instance\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:3:\"all\";}s:6:\"parent\";N;s:8:\"children\";a:0:{}}s:5:\"admin\";a:3:{s:8:\"instance\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:5:\"admin\";}s:6:\"parent\";N;s:8:\"children\";a:11:{s:15:\"admin/dashboard\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:15:\"admin/dashboard\";}s:12:\"admin/system\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:12:\"admin/system\";}s:19:\"admin/global_search\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:19:\"admin/global_search\";}s:9:\"admin/cms\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:9:\"admin/cms\";}s:14:\"admin/customer\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:14:\"admin/customer\";}s:13:\"admin/catalog\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:13:\"admin/catalog\";}s:11:\"admin/promo\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:11:\"admin/promo\";}s:11:\"admin/sales\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:11:\"admin/sales\";}s:12:\"admin/report\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:12:\"admin/report\";}s:16:\"admin/newsletter\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:16:\"admin/newsletter\";}s:16:\"admin/page_cache\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:16:\"admin/page_cache\";}}}s:15:\"admin/dashboard\";a:3:{s:8:\"instance\";r:126;s:6:\"parent\";r:122;s:8:\"children\";a:0:{}}s:12:\"admin/system\";a:3:{s:8:\"instance\";r:128;s:6:\"parent\";r:122;s:8:\"children\";a:16:{s:16:\"admin/system/acl\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:16:\"admin/system/acl\";}s:18:\"admin/system/store\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:18:\"admin/system/store\";}s:19:\"admin/system/design\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:19:\"admin/system/design\";}s:19:\"admin/system/config\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:19:\"admin/system/config\";}s:21:\"admin/system/currency\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:21:\"admin/system/currency\";}s:27:\"admin/system/email_template\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:27:\"admin/system/email_template\";}s:21:\"admin/system/variable\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:21:\"admin/system/variable\";}s:22:\"admin/system/myaccount\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:22:\"admin/system/myaccount\";}s:18:\"admin/system/tools\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:18:\"admin/system/tools\";}s:20:\"admin/system/convert\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:20:\"admin/system/convert\";}s:18:\"admin/system/cache\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:18:\"admin/system/cache\";}s:23:\"admin/system/extensions\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:23:\"admin/system/extensions\";}s:30:\"admin/system/adminnotification\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:30:\"admin/system/adminnotification\";}s:18:\"admin/system/index\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:18:\"admin/system/index\";}s:27:\"admin/system/order_statuses\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:27:\"admin/system/order_statuses\";}s:16:\"admin/system/api\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:16:\"admin/system/api\";}}}s:16:\"admin/system/acl\";a:3:{s:8:\"instance\";r:156;s:6:\"parent\";r:128;s:8:\"children\";a:2:{s:22:\"admin/system/acl/roles\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:22:\"admin/system/acl/roles\";}s:22:\"admin/system/acl/users\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:22:\"admin/system/acl/users\";}}}s:22:\"admin/system/acl/roles\";a:3:{s:8:\"instance\";r:192;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:22:\"admin/system/acl/users\";a:3:{s:8:\"instance\";r:194;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:18:\"admin/system/store\";a:3:{s:8:\"instance\";r:158;s:6:\"parent\";r:128;s:8:\"children\";a:0:{}}s:19:\"admin/system/design\";a:3:{s:8:\"instance\";r:160;s:6:\"parent\";r:128;s:8:\"children\";a:0:{}}s:19:\"admin/system/config\";a:3:{s:8:\"instance\";r:162;s:6:\"parent\";r:128;s:8:\"children\";a:45:{s:27:\"admin/system/config/general\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:27:\"admin/system/config/general\";}s:23:\"admin/system/config/web\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:23:\"admin/system/config/web\";}s:26:\"admin/system/config/design\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:26:\"admin/system/config/design\";}s:26:\"admin/system/config/system\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:26:\"admin/system/config/system\";}s:28:\"admin/system/config/advanced\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:28:\"admin/system/config/advanced\";}s:31:\"admin/system/config/trans_email\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:31:\"admin/system/config/trans_email\";}s:23:\"admin/system/config/dev\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:23:\"admin/system/config/dev\";}s:28:\"admin/system/config/currency\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:28:\"admin/system/config/currency\";}s:30:\"admin/system/config/sendfriend\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:30:\"admin/system/config/sendfriend\";}s:25:\"admin/system/config/admin\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:25:\"admin/system/config/admin\";}s:23:\"admin/system/config/cms\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:23:\"admin/system/config/cms\";}s:28:\"admin/system/config/customer\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:28:\"admin/system/config/customer\";}s:27:\"admin/system/config/catalog\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:27:\"admin/system/config/catalog\";}s:27:\"admin/system/config/payment\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:27:\"admin/system/config/payment\";}s:36:\"admin/system/config/payment_services\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:36:\"admin/system/config/payment_services\";}s:25:\"admin/system/config/sales\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:25:\"admin/system/config/sales\";}s:31:\"admin/system/config/sales_email\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:31:\"admin/system/config/sales_email\";}s:29:\"admin/system/config/sales_pdf\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:29:\"admin/system/config/sales_pdf\";}s:36:\"admin/system/config/cataloginventory\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:36:\"admin/system/config/cataloginventory\";}s:28:\"admin/system/config/shipping\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:28:\"admin/system/config/shipping\";}s:28:\"admin/system/config/carriers\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:28:\"admin/system/config/carriers\";}s:25:\"admin/system/config/promo\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:25:\"admin/system/config/promo\";}s:28:\"admin/system/config/checkout\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:28:\"admin/system/config/checkout\";}s:26:\"admin/system/config/paypal\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:26:\"admin/system/config/paypal\";}s:27:\"admin/system/config/reports\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:27:\"admin/system/config/reports\";}s:26:\"admin/system/config/google\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:26:\"admin/system/config/google\";}s:23:\"admin/system/config/tax\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:23:\"admin/system/config/tax\";}s:28:\"admin/system/config/wishlist\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:28:\"admin/system/config/wishlist\";}s:28:\"admin/system/config/contacts\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:28:\"admin/system/config/contacts\";}s:27:\"admin/system/config/sitemap\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:27:\"admin/system/config/sitemap\";}s:23:\"admin/system/config/rss\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:23:\"admin/system/config/rss\";}s:23:\"admin/system/config/api\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:23:\"admin/system/config/api\";}s:25:\"admin/system/config/oauth\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:25:\"admin/system/config/oauth\";}s:34:\"admin/system/config/configswatches\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:34:\"admin/system/config/configswatches\";}s:30:\"admin/system/config/newsletter\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:30:\"admin/system/config/newsletter\";}s:32:\"admin/system/config/downloadable\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:32:\"admin/system/config/downloadable\";}s:30:\"admin/system/config/persistent\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:30:\"admin/system/config/persistent\";}s:29:\"admin/system/config/cloudzoom\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:29:\"admin/system/config/cloudzoom\";}s:26:\"admin/system/config/brands\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:26:\"admin/system/config/brands\";}s:34:\"admin/system/config/ultraslideshow\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:34:\"admin/system/config/ultraslideshow\";}s:33:\"admin/system/config/ultramegamenu\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:33:\"admin/system/config/ultramegamenu\";}s:26:\"admin/system/config/ultimo\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:26:\"admin/system/config/ultimo\";}s:33:\"admin/system/config/ultimo_design\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:33:\"admin/system/config/ultimo_design\";}s:33:\"admin/system/config/ultimo_layout\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:33:\"admin/system/config/ultimo_layout\";}s:32:\"admin/system/config/moneybookers\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:32:\"admin/system/config/moneybookers\";}}}s:27:\"admin/system/config/general\";a:3:{s:8:\"instance\";r:216;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:23:\"admin/system/config/web\";a:3:{s:8:\"instance\";r:218;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:26:\"admin/system/config/design\";a:3:{s:8:\"instance\";r:220;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:26:\"admin/system/config/system\";a:3:{s:8:\"instance\";r:222;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:28:\"admin/system/config/advanced\";a:3:{s:8:\"instance\";r:224;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:31:\"admin/system/config/trans_email\";a:3:{s:8:\"instance\";r:226;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:23:\"admin/system/config/dev\";a:3:{s:8:\"instance\";r:228;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:28:\"admin/system/config/currency\";a:3:{s:8:\"instance\";r:230;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:30:\"admin/system/config/sendfriend\";a:3:{s:8:\"instance\";r:232;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:25:\"admin/system/config/admin\";a:3:{s:8:\"instance\";r:234;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:23:\"admin/system/config/cms\";a:3:{s:8:\"instance\";r:236;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:28:\"admin/system/config/customer\";a:3:{s:8:\"instance\";r:238;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:27:\"admin/system/config/catalog\";a:3:{s:8:\"instance\";r:240;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:27:\"admin/system/config/payment\";a:3:{s:8:\"instance\";r:242;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:36:\"admin/system/config/payment_services\";a:3:{s:8:\"instance\";r:244;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:25:\"admin/system/config/sales\";a:3:{s:8:\"instance\";r:246;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:31:\"admin/system/config/sales_email\";a:3:{s:8:\"instance\";r:248;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:29:\"admin/system/config/sales_pdf\";a:3:{s:8:\"instance\";r:250;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:36:\"admin/system/config/cataloginventory\";a:3:{s:8:\"instance\";r:252;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:28:\"admin/system/config/shipping\";a:3:{s:8:\"instance\";r:254;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:28:\"admin/system/config/carriers\";a:3:{s:8:\"instance\";r:256;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:25:\"admin/system/config/promo\";a:3:{s:8:\"instance\";r:258;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:28:\"admin/system/config/checkout\";a:3:{s:8:\"instance\";r:260;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:26:\"admin/system/config/paypal\";a:3:{s:8:\"instance\";r:262;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:27:\"admin/system/config/reports\";a:3:{s:8:\"instance\";r:264;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:26:\"admin/system/config/google\";a:3:{s:8:\"instance\";r:266;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:23:\"admin/system/config/tax\";a:3:{s:8:\"instance\";r:268;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:28:\"admin/system/config/wishlist\";a:3:{s:8:\"instance\";r:270;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:28:\"admin/system/config/contacts\";a:3:{s:8:\"instance\";r:272;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:27:\"admin/system/config/sitemap\";a:3:{s:8:\"instance\";r:274;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:23:\"admin/system/config/rss\";a:3:{s:8:\"instance\";r:276;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:23:\"admin/system/config/api\";a:3:{s:8:\"instance\";r:278;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:25:\"admin/system/config/oauth\";a:3:{s:8:\"instance\";r:280;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:34:\"admin/system/config/configswatches\";a:3:{s:8:\"instance\";r:282;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:30:\"admin/system/config/newsletter\";a:3:{s:8:\"instance\";r:284;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:32:\"admin/system/config/downloadable\";a:3:{s:8:\"instance\";r:286;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:30:\"admin/system/config/persistent\";a:3:{s:8:\"instance\";r:288;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:29:\"admin/system/config/cloudzoom\";a:3:{s:8:\"instance\";r:290;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:26:\"admin/system/config/brands\";a:3:{s:8:\"instance\";r:292;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:34:\"admin/system/config/ultraslideshow\";a:3:{s:8:\"instance\";r:294;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:33:\"admin/system/config/ultramegamenu\";a:3:{s:8:\"instance\";r:296;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:26:\"admin/system/config/ultimo\";a:3:{s:8:\"instance\";r:298;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:33:\"admin/system/config/ultimo_design\";a:3:{s:8:\"instance\";r:300;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:33:\"admin/system/config/ultimo_layout\";a:3:{s:8:\"instance\";r:302;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:32:\"admin/system/config/moneybookers\";a:3:{s:8:\"instance\";r:304;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:21:\"admin/system/currency\";a:3:{s:8:\"instance\";r:164;s:6:\"parent\";r:128;s:8:\"children\";a:2:{s:27:\"admin/system/currency/rates\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:27:\"admin/system/currency/rates\";}s:29:\"admin/system/currency/symbols\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:29:\"admin/system/currency/symbols\";}}}s:27:\"admin/system/currency/rates\";a:3:{s:8:\"instance\";r:490;s:6:\"parent\";r:164;s:8:\"children\";a:0:{}}s:29:\"admin/system/currency/symbols\";a:3:{s:8:\"instance\";r:492;s:6:\"parent\";r:164;s:8:\"children\";a:0:{}}s:27:\"admin/system/email_template\";a:3:{s:8:\"instance\";r:166;s:6:\"parent\";r:128;s:8:\"children\";a:0:{}}s:21:\"admin/system/variable\";a:3:{s:8:\"instance\";r:168;s:6:\"parent\";r:128;s:8:\"children\";a:0:{}}s:22:\"admin/system/myaccount\";a:3:{s:8:\"instance\";r:170;s:6:\"parent\";r:128;s:8:\"children\";a:0:{}}s:18:\"admin/system/tools\";a:3:{s:8:\"instance\";r:172;s:6:\"parent\";r:128;s:8:\"children\";a:2:{s:25:\"admin/system/tools/backup\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:25:\"admin/system/tools/backup\";}s:27:\"admin/system/tools/compiler\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:27:\"admin/system/tools/compiler\";}}}s:25:\"admin/system/tools/backup\";a:3:{s:8:\"instance\";r:518;s:6:\"parent\";r:172;s:8:\"children\";a:1:{s:34:\"admin/system/tools/backup/rollback\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:34:\"admin/system/tools/backup/rollback\";}}}s:34:\"admin/system/tools/backup/rollback\";a:3:{s:8:\"instance\";r:526;s:6:\"parent\";r:518;s:8:\"children\";a:0:{}}s:27:\"admin/system/tools/compiler\";a:3:{s:8:\"instance\";r:520;s:6:\"parent\";r:172;s:8:\"children\";a:0:{}}s:20:\"admin/system/convert\";a:3:{s:8:\"instance\";r:174;s:6:\"parent\";r:128;s:8:\"children\";a:4:{s:24:\"admin/system/convert/gui\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:24:\"admin/system/convert/gui\";}s:29:\"admin/system/convert/profiles\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:29:\"admin/system/convert/profiles\";}s:27:\"admin/system/convert/import\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:27:\"admin/system/convert/import\";}s:27:\"admin/system/convert/export\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:27:\"admin/system/convert/export\";}}}s:24:\"admin/system/convert/gui\";a:3:{s:8:\"instance\";r:540;s:6:\"parent\";r:174;s:8:\"children\";a:0:{}}s:29:\"admin/system/convert/profiles\";a:3:{s:8:\"instance\";r:542;s:6:\"parent\";r:174;s:8:\"children\";a:0:{}}s:27:\"admin/system/convert/import\";a:3:{s:8:\"instance\";r:544;s:6:\"parent\";r:174;s:8:\"children\";a:0:{}}s:27:\"admin/system/convert/export\";a:3:{s:8:\"instance\";r:546;s:6:\"parent\";r:174;s:8:\"children\";a:0:{}}s:18:\"admin/system/cache\";a:3:{s:8:\"instance\";r:176;s:6:\"parent\";r:128;s:8:\"children\";a:0:{}}s:23:\"admin/system/extensions\";a:3:{s:8:\"instance\";r:178;s:6:\"parent\";r:128;s:8:\"children\";a:2:{s:29:\"admin/system/extensions/local\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:29:\"admin/system/extensions/local\";}s:30:\"admin/system/extensions/custom\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:30:\"admin/system/extensions/custom\";}}}s:29:\"admin/system/extensions/local\";a:3:{s:8:\"instance\";r:572;s:6:\"parent\";r:178;s:8:\"children\";a:0:{}}s:30:\"admin/system/extensions/custom\";a:3:{s:8:\"instance\";r:574;s:6:\"parent\";r:178;s:8:\"children\";a:0:{}}s:30:\"admin/system/adminnotification\";a:3:{s:8:\"instance\";r:180;s:6:\"parent\";r:128;s:8:\"children\";a:4:{s:43:\"admin/system/adminnotification/show_toolbar\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:43:\"admin/system/adminnotification/show_toolbar\";}s:40:\"admin/system/adminnotification/show_list\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:40:\"admin/system/adminnotification/show_list\";}s:43:\"admin/system/adminnotification/mark_as_read\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:43:\"admin/system/adminnotification/mark_as_read\";}s:37:\"admin/system/adminnotification/remove\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:37:\"admin/system/adminnotification/remove\";}}}s:43:\"admin/system/adminnotification/show_toolbar\";a:3:{s:8:\"instance\";r:588;s:6:\"parent\";r:180;s:8:\"children\";a:0:{}}s:40:\"admin/system/adminnotification/show_list\";a:3:{s:8:\"instance\";r:590;s:6:\"parent\";r:180;s:8:\"children\";a:0:{}}s:43:\"admin/system/adminnotification/mark_as_read\";a:3:{s:8:\"instance\";r:592;s:6:\"parent\";r:180;s:8:\"children\";a:0:{}}s:37:\"admin/system/adminnotification/remove\";a:3:{s:8:\"instance\";r:594;s:6:\"parent\";r:180;s:8:\"children\";a:0:{}}s:18:\"admin/system/index\";a:3:{s:8:\"instance\";r:182;s:6:\"parent\";r:128;s:8:\"children\";a:0:{}}s:27:\"admin/system/order_statuses\";a:3:{s:8:\"instance\";r:184;s:6:\"parent\";r:128;s:8:\"children\";a:0:{}}s:16:\"admin/system/api\";a:3:{s:8:\"instance\";r:186;s:6:\"parent\";r:128;s:8:\"children\";a:7:{s:22:\"admin/system/api/users\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:22:\"admin/system/api/users\";}s:22:\"admin/system/api/roles\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:22:\"admin/system/api/roles\";}s:25:\"admin/system/api/consumer\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:25:\"admin/system/api/consumer\";}s:33:\"admin/system/api/authorizedTokens\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:33:\"admin/system/api/authorizedTokens\";}s:34:\"admin/system/api/oauth_admin_token\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:34:\"admin/system/api/oauth_admin_token\";}s:27:\"admin/system/api/rest_roles\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:27:\"admin/system/api/rest_roles\";}s:32:\"admin/system/api/rest_attributes\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:32:\"admin/system/api/rest_attributes\";}}}s:22:\"admin/system/api/users\";a:3:{s:8:\"instance\";r:624;s:6:\"parent\";r:186;s:8:\"children\";a:0:{}}s:22:\"admin/system/api/roles\";a:3:{s:8:\"instance\";r:626;s:6:\"parent\";r:186;s:8:\"children\";a:0:{}}s:25:\"admin/system/api/consumer\";a:3:{s:8:\"instance\";r:628;s:6:\"parent\";r:186;s:8:\"children\";a:2:{s:30:\"admin/system/api/consumer/edit\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:30:\"admin/system/api/consumer/edit\";}s:32:\"admin/system/api/consumer/delete\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:32:\"admin/system/api/consumer/delete\";}}}s:30:\"admin/system/api/consumer/edit\";a:3:{s:8:\"instance\";r:650;s:6:\"parent\";r:628;s:8:\"children\";a:0:{}}s:32:\"admin/system/api/consumer/delete\";a:3:{s:8:\"instance\";r:652;s:6:\"parent\";r:628;s:8:\"children\";a:0:{}}s:33:\"admin/system/api/authorizedTokens\";a:3:{s:8:\"instance\";r:630;s:6:\"parent\";r:186;s:8:\"children\";a:0:{}}s:34:\"admin/system/api/oauth_admin_token\";a:3:{s:8:\"instance\";r:632;s:6:\"parent\";r:186;s:8:\"children\";a:0:{}}s:27:\"admin/system/api/rest_roles\";a:3:{s:8:\"instance\";r:634;s:6:\"parent\";r:186;s:8:\"children\";a:3:{s:31:\"admin/system/api/rest_roles/add\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:31:\"admin/system/api/rest_roles/add\";}s:32:\"admin/system/api/rest_roles/edit\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:32:\"admin/system/api/rest_roles/edit\";}s:34:\"admin/system/api/rest_roles/delete\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:34:\"admin/system/api/rest_roles/delete\";}}}s:31:\"admin/system/api/rest_roles/add\";a:3:{s:8:\"instance\";r:674;s:6:\"parent\";r:634;s:8:\"children\";a:0:{}}s:32:\"admin/system/api/rest_roles/edit\";a:3:{s:8:\"instance\";r:676;s:6:\"parent\";r:634;s:8:\"children\";a:0:{}}s:34:\"admin/system/api/rest_roles/delete\";a:3:{s:8:\"instance\";r:678;s:6:\"parent\";r:634;s:8:\"children\";a:0:{}}s:32:\"admin/system/api/rest_attributes\";a:3:{s:8:\"instance\";r:636;s:6:\"parent\";r:186;s:8:\"children\";a:1:{s:37:\"admin/system/api/rest_attributes/edit\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:37:\"admin/system/api/rest_attributes/edit\";}}}s:37:\"admin/system/api/rest_attributes/edit\";a:3:{s:8:\"instance\";r:696;s:6:\"parent\";r:636;s:8:\"children\";a:0:{}}s:19:\"admin/global_search\";a:3:{s:8:\"instance\";r:130;s:6:\"parent\";r:122;s:8:\"children\";a:0:{}}s:9:\"admin/cms\";a:3:{s:8:\"instance\";r:132;s:6:\"parent\";r:122;s:8:\"children\";a:5:{s:15:\"admin/cms/block\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:15:\"admin/cms/block\";}s:14:\"admin/cms/page\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:14:\"admin/cms/page\";}s:23:\"admin/cms/media_gallery\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:23:\"admin/cms/media_gallery\";}s:14:\"admin/cms/poll\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:14:\"admin/cms/poll\";}s:25:\"admin/cms/widget_instance\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:25:\"admin/cms/widget_instance\";}}}s:15:\"admin/cms/block\";a:3:{s:8:\"instance\";r:710;s:6:\"parent\";r:132;s:8:\"children\";a:0:{}}s:14:\"admin/cms/page\";a:3:{s:8:\"instance\";r:712;s:6:\"parent\";r:132;s:8:\"children\";a:2:{s:19:\"admin/cms/page/save\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:19:\"admin/cms/page/save\";}s:21:\"admin/cms/page/delete\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:21:\"admin/cms/page/delete\";}}}s:19:\"admin/cms/page/save\";a:3:{s:8:\"instance\";r:728;s:6:\"parent\";r:712;s:8:\"children\";a:0:{}}s:21:\"admin/cms/page/delete\";a:3:{s:8:\"instance\";r:730;s:6:\"parent\";r:712;s:8:\"children\";a:0:{}}s:23:\"admin/cms/media_gallery\";a:3:{s:8:\"instance\";r:714;s:6:\"parent\";r:132;s:8:\"children\";a:0:{}}s:14:\"admin/cms/poll\";a:3:{s:8:\"instance\";r:716;s:6:\"parent\";r:132;s:8:\"children\";a:0:{}}s:25:\"admin/cms/widget_instance\";a:3:{s:8:\"instance\";r:718;s:6:\"parent\";r:132;s:8:\"children\";a:0:{}}s:14:\"admin/customer\";a:3:{s:8:\"instance\";r:134;s:6:\"parent\";r:122;s:8:\"children\";a:3:{s:20:\"admin/customer/group\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:20:\"admin/customer/group\";}s:21:\"admin/customer/manage\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:21:\"admin/customer/manage\";}s:21:\"admin/customer/online\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:21:\"admin/customer/online\";}}}s:20:\"admin/customer/group\";a:3:{s:8:\"instance\";r:756;s:6:\"parent\";r:134;s:8:\"children\";a:0:{}}s:21:\"admin/customer/manage\";a:3:{s:8:\"instance\";r:758;s:6:\"parent\";r:134;s:8:\"children\";a:0:{}}s:21:\"admin/customer/online\";a:3:{s:8:\"instance\";r:760;s:6:\"parent\";r:134;s:8:\"children\";a:0:{}}s:13:\"admin/catalog\";a:3:{s:8:\"instance\";r:136;s:6:\"parent\";r:122;s:8:\"children\";a:9:{s:24:\"admin/catalog/attributes\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:24:\"admin/catalog/attributes\";}s:24:\"admin/catalog/categories\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:24:\"admin/catalog/categories\";}s:22:\"admin/catalog/products\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:22:\"admin/catalog/products\";}s:31:\"admin/catalog/update_attributes\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:31:\"admin/catalog/update_attributes\";}s:24:\"admin/catalog/urlrewrite\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:24:\"admin/catalog/urlrewrite\";}s:20:\"admin/catalog/search\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:20:\"admin/catalog/search\";}s:29:\"admin/catalog/reviews_ratings\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:29:\"admin/catalog/reviews_ratings\";}s:17:\"admin/catalog/tag\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:17:\"admin/catalog/tag\";}s:21:\"admin/catalog/sitemap\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:21:\"admin/catalog/sitemap\";}}}s:24:\"admin/catalog/attributes\";a:3:{s:8:\"instance\";r:778;s:6:\"parent\";r:136;s:8:\"children\";a:2:{s:35:\"admin/catalog/attributes/attributes\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:35:\"admin/catalog/attributes/attributes\";}s:29:\"admin/catalog/attributes/sets\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:29:\"admin/catalog/attributes/sets\";}}}s:35:\"admin/catalog/attributes/attributes\";a:3:{s:8:\"instance\";r:800;s:6:\"parent\";r:778;s:8:\"children\";a:0:{}}s:29:\"admin/catalog/attributes/sets\";a:3:{s:8:\"instance\";r:802;s:6:\"parent\";r:778;s:8:\"children\";a:0:{}}s:24:\"admin/catalog/categories\";a:3:{s:8:\"instance\";r:780;s:6:\"parent\";r:136;s:8:\"children\";a:0:{}}s:22:\"admin/catalog/products\";a:3:{s:8:\"instance\";r:782;s:6:\"parent\";r:136;s:8:\"children\";a:0:{}}s:31:\"admin/catalog/update_attributes\";a:3:{s:8:\"instance\";r:784;s:6:\"parent\";r:136;s:8:\"children\";a:0:{}}s:24:\"admin/catalog/urlrewrite\";a:3:{s:8:\"instance\";r:786;s:6:\"parent\";r:136;s:8:\"children\";a:0:{}}s:20:\"admin/catalog/search\";a:3:{s:8:\"instance\";r:788;s:6:\"parent\";r:136;s:8:\"children\";a:0:{}}s:29:\"admin/catalog/reviews_ratings\";a:3:{s:8:\"instance\";r:790;s:6:\"parent\";r:136;s:8:\"children\";a:2:{s:37:\"admin/catalog/reviews_ratings/reviews\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:37:\"admin/catalog/reviews_ratings/reviews\";}s:37:\"admin/catalog/reviews_ratings/ratings\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:37:\"admin/catalog/reviews_ratings/ratings\";}}}s:37:\"admin/catalog/reviews_ratings/reviews\";a:3:{s:8:\"instance\";r:836;s:6:\"parent\";r:790;s:8:\"children\";a:2:{s:41:\"admin/catalog/reviews_ratings/reviews/all\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:41:\"admin/catalog/reviews_ratings/reviews/all\";}s:45:\"admin/catalog/reviews_ratings/reviews/pending\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:45:\"admin/catalog/reviews_ratings/reviews/pending\";}}}s:41:\"admin/catalog/reviews_ratings/reviews/all\";a:3:{s:8:\"instance\";r:844;s:6:\"parent\";r:836;s:8:\"children\";a:0:{}}s:45:\"admin/catalog/reviews_ratings/reviews/pending\";a:3:{s:8:\"instance\";r:846;s:6:\"parent\";r:836;s:8:\"children\";a:0:{}}s:37:\"admin/catalog/reviews_ratings/ratings\";a:3:{s:8:\"instance\";r:838;s:6:\"parent\";r:790;s:8:\"children\";a:0:{}}s:17:\"admin/catalog/tag\";a:3:{s:8:\"instance\";r:792;s:6:\"parent\";r:136;s:8:\"children\";a:2:{s:21:\"admin/catalog/tag/all\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:21:\"admin/catalog/tag/all\";}s:25:\"admin/catalog/tag/pending\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:25:\"admin/catalog/tag/pending\";}}}s:21:\"admin/catalog/tag/all\";a:3:{s:8:\"instance\";r:864;s:6:\"parent\";r:792;s:8:\"children\";a:0:{}}s:25:\"admin/catalog/tag/pending\";a:3:{s:8:\"instance\";r:866;s:6:\"parent\";r:792;s:8:\"children\";a:0:{}}s:21:\"admin/catalog/sitemap\";a:3:{s:8:\"instance\";r:794;s:6:\"parent\";r:136;s:8:\"children\";a:0:{}}s:11:\"admin/promo\";a:3:{s:8:\"instance\";r:138;s:6:\"parent\";r:122;s:8:\"children\";a:2:{s:19:\"admin/promo/catalog\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:19:\"admin/promo/catalog\";}s:17:\"admin/promo/quote\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:17:\"admin/promo/quote\";}}}s:19:\"admin/promo/catalog\";a:3:{s:8:\"instance\";r:884;s:6:\"parent\";r:138;s:8:\"children\";a:0:{}}s:17:\"admin/promo/quote\";a:3:{s:8:\"instance\";r:886;s:6:\"parent\";r:138;s:8:\"children\";a:0:{}}s:11:\"admin/sales\";a:3:{s:8:\"instance\";r:140;s:6:\"parent\";r:122;s:8:\"children\";a:9:{s:17:\"admin/sales/order\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:17:\"admin/sales/order\";}s:19:\"admin/sales/invoice\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:19:\"admin/sales/invoice\";}s:20:\"admin/sales/shipment\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:20:\"admin/sales/shipment\";}s:22:\"admin/sales/creditmemo\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:22:\"admin/sales/creditmemo\";}s:24:\"admin/sales/transactions\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:24:\"admin/sales/transactions\";}s:29:\"admin/sales/recurring_profile\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:29:\"admin/sales/recurring_profile\";}s:29:\"admin/sales/billing_agreement\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:29:\"admin/sales/billing_agreement\";}s:29:\"admin/sales/checkoutagreement\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:29:\"admin/sales/checkoutagreement\";}s:15:\"admin/sales/tax\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:15:\"admin/sales/tax\";}}}s:17:\"admin/sales/order\";a:3:{s:8:\"instance\";r:900;s:6:\"parent\";r:140;s:8:\"children\";a:1:{s:25:\"admin/sales/order/actions\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:25:\"admin/sales/order/actions\";}}}s:25:\"admin/sales/order/actions\";a:3:{s:8:\"instance\";r:922;s:6:\"parent\";r:900;s:8:\"children\";a:15:{s:32:\"admin/sales/order/actions/create\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:32:\"admin/sales/order/actions/create\";}s:30:\"admin/sales/order/actions/view\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:30:\"admin/sales/order/actions/view\";}s:31:\"admin/sales/order/actions/email\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:31:\"admin/sales/order/actions/email\";}s:33:\"admin/sales/order/actions/reorder\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:33:\"admin/sales/order/actions/reorder\";}s:30:\"admin/sales/order/actions/edit\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:30:\"admin/sales/order/actions/edit\";}s:32:\"admin/sales/order/actions/cancel\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:32:\"admin/sales/order/actions/cancel\";}s:40:\"admin/sales/order/actions/review_payment\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:40:\"admin/sales/order/actions/review_payment\";}s:33:\"admin/sales/order/actions/capture\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:33:\"admin/sales/order/actions/capture\";}s:33:\"admin/sales/order/actions/invoice\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:33:\"admin/sales/order/actions/invoice\";}s:36:\"admin/sales/order/actions/creditmemo\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:36:\"admin/sales/order/actions/creditmemo\";}s:30:\"admin/sales/order/actions/hold\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:30:\"admin/sales/order/actions/hold\";}s:32:\"admin/sales/order/actions/unhold\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:32:\"admin/sales/order/actions/unhold\";}s:30:\"admin/sales/order/actions/ship\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:30:\"admin/sales/order/actions/ship\";}s:33:\"admin/sales/order/actions/comment\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:33:\"admin/sales/order/actions/comment\";}s:32:\"admin/sales/order/actions/emails\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:32:\"admin/sales/order/actions/emails\";}}}s:32:\"admin/sales/order/actions/create\";a:3:{s:8:\"instance\";r:928;s:6:\"parent\";r:922;s:8:\"children\";a:0:{}}s:30:\"admin/sales/order/actions/view\";a:3:{s:8:\"instance\";r:930;s:6:\"parent\";r:922;s:8:\"children\";a:0:{}}s:31:\"admin/sales/order/actions/email\";a:3:{s:8:\"instance\";r:932;s:6:\"parent\";r:922;s:8:\"children\";a:0:{}}s:33:\"admin/sales/order/actions/reorder\";a:3:{s:8:\"instance\";r:934;s:6:\"parent\";r:922;s:8:\"children\";a:0:{}}s:30:\"admin/sales/order/actions/edit\";a:3:{s:8:\"instance\";r:936;s:6:\"parent\";r:922;s:8:\"children\";a:0:{}}s:32:\"admin/sales/order/actions/cancel\";a:3:{s:8:\"instance\";r:938;s:6:\"parent\";r:922;s:8:\"children\";a:0:{}}s:40:\"admin/sales/order/actions/review_payment\";a:3:{s:8:\"instance\";r:940;s:6:\"parent\";r:922;s:8:\"children\";a:0:{}}s:33:\"admin/sales/order/actions/capture\";a:3:{s:8:\"instance\";r:942;s:6:\"parent\";r:922;s:8:\"children\";a:0:{}}s:33:\"admin/sales/order/actions/invoice\";a:3:{s:8:\"instance\";r:944;s:6:\"parent\";r:922;s:8:\"children\";a:0:{}}s:36:\"admin/sales/order/actions/creditmemo\";a:3:{s:8:\"instance\";r:946;s:6:\"parent\";r:922;s:8:\"children\";a:0:{}}s:30:\"admin/sales/order/actions/hold\";a:3:{s:8:\"instance\";r:948;s:6:\"parent\";r:922;s:8:\"children\";a:0:{}}s:32:\"admin/sales/order/actions/unhold\";a:3:{s:8:\"instance\";r:950;s:6:\"parent\";r:922;s:8:\"children\";a:0:{}}s:30:\"admin/sales/order/actions/ship\";a:3:{s:8:\"instance\";r:952;s:6:\"parent\";r:922;s:8:\"children\";a:0:{}}s:33:\"admin/sales/order/actions/comment\";a:3:{s:8:\"instance\";r:954;s:6:\"parent\";r:922;s:8:\"children\";a:0:{}}s:32:\"admin/sales/order/actions/emails\";a:3:{s:8:\"instance\";r:956;s:6:\"parent\";r:922;s:8:\"children\";a:0:{}}s:19:\"admin/sales/invoice\";a:3:{s:8:\"instance\";r:902;s:6:\"parent\";r:140;s:8:\"children\";a:0:{}}s:20:\"admin/sales/shipment\";a:3:{s:8:\"instance\";r:904;s:6:\"parent\";r:140;s:8:\"children\";a:0:{}}s:22:\"admin/sales/creditmemo\";a:3:{s:8:\"instance\";r:906;s:6:\"parent\";r:140;s:8:\"children\";a:0:{}}s:24:\"admin/sales/transactions\";a:3:{s:8:\"instance\";r:908;s:6:\"parent\";r:140;s:8:\"children\";a:1:{s:30:\"admin/sales/transactions/fetch\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:30:\"admin/sales/transactions/fetch\";}}}s:30:\"admin/sales/transactions/fetch\";a:3:{s:8:\"instance\";r:1034;s:6:\"parent\";r:908;s:8:\"children\";a:0:{}}s:29:\"admin/sales/recurring_profile\";a:3:{s:8:\"instance\";r:910;s:6:\"parent\";r:140;s:8:\"children\";a:0:{}}s:29:\"admin/sales/billing_agreement\";a:3:{s:8:\"instance\";r:912;s:6:\"parent\";r:140;s:8:\"children\";a:1:{s:37:\"admin/sales/billing_agreement/actions\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:37:\"admin/sales/billing_agreement/actions\";}}}s:37:\"admin/sales/billing_agreement/actions\";a:3:{s:8:\"instance\";r:1048;s:6:\"parent\";r:912;s:8:\"children\";a:3:{s:42:\"admin/sales/billing_agreement/actions/view\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:42:\"admin/sales/billing_agreement/actions/view\";}s:44:\"admin/sales/billing_agreement/actions/manage\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:44:\"admin/sales/billing_agreement/actions/manage\";}s:41:\"admin/sales/billing_agreement/actions/use\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:41:\"admin/sales/billing_agreement/actions/use\";}}}s:42:\"admin/sales/billing_agreement/actions/view\";a:3:{s:8:\"instance\";r:1054;s:6:\"parent\";r:1048;s:8:\"children\";a:0:{}}s:44:\"admin/sales/billing_agreement/actions/manage\";a:3:{s:8:\"instance\";r:1056;s:6:\"parent\";r:1048;s:8:\"children\";a:0:{}}s:41:\"admin/sales/billing_agreement/actions/use\";a:3:{s:8:\"instance\";r:1058;s:6:\"parent\";r:1048;s:8:\"children\";a:0:{}}s:29:\"admin/sales/checkoutagreement\";a:3:{s:8:\"instance\";r:914;s:6:\"parent\";r:140;s:8:\"children\";a:0:{}}s:15:\"admin/sales/tax\";a:3:{s:8:\"instance\";r:916;s:6:\"parent\";r:140;s:8:\"children\";a:5:{s:32:\"admin/sales/tax/classes_customer\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:32:\"admin/sales/tax/classes_customer\";}s:31:\"admin/sales/tax/classes_product\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:31:\"admin/sales/tax/classes_product\";}s:29:\"admin/sales/tax/import_export\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:29:\"admin/sales/tax/import_export\";}s:21:\"admin/sales/tax/rates\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:21:\"admin/sales/tax/rates\";}s:21:\"admin/sales/tax/rules\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:21:\"admin/sales/tax/rules\";}}}s:32:\"admin/sales/tax/classes_customer\";a:3:{s:8:\"instance\";r:1080;s:6:\"parent\";r:916;s:8:\"children\";a:0:{}}s:31:\"admin/sales/tax/classes_product\";a:3:{s:8:\"instance\";r:1082;s:6:\"parent\";r:916;s:8:\"children\";a:0:{}}s:29:\"admin/sales/tax/import_export\";a:3:{s:8:\"instance\";r:1084;s:6:\"parent\";r:916;s:8:\"children\";a:0:{}}s:21:\"admin/sales/tax/rates\";a:3:{s:8:\"instance\";r:1086;s:6:\"parent\";r:916;s:8:\"children\";a:0:{}}s:21:\"admin/sales/tax/rules\";a:3:{s:8:\"instance\";r:1088;s:6:\"parent\";r:916;s:8:\"children\";a:0:{}}s:12:\"admin/report\";a:3:{s:8:\"instance\";r:142;s:6:\"parent\";r:122;s:8:\"children\";a:8:{s:22:\"admin/report/salesroot\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:22:\"admin/report/salesroot\";}s:21:\"admin/report/shopcart\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:21:\"admin/report/shopcart\";}s:21:\"admin/report/products\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:21:\"admin/report/products\";}s:22:\"admin/report/customers\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:22:\"admin/report/customers\";}s:19:\"admin/report/review\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:19:\"admin/report/review\";}s:17:\"admin/report/tags\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:17:\"admin/report/tags\";}s:19:\"admin/report/search\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:19:\"admin/report/search\";}s:23:\"admin/report/statistics\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:23:\"admin/report/statistics\";}}}s:22:\"admin/report/salesroot\";a:3:{s:8:\"instance\";r:1114;s:6:\"parent\";r:142;s:8:\"children\";a:7:{s:48:\"admin/report/salesroot/paypal_settlement_reports\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:48:\"admin/report/salesroot/paypal_settlement_reports\";}s:28:\"admin/report/salesroot/sales\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:28:\"admin/report/salesroot/sales\";}s:26:\"admin/report/salesroot/tax\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:26:\"admin/report/salesroot/tax\";}s:31:\"admin/report/salesroot/shipping\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:31:\"admin/report/salesroot/shipping\";}s:31:\"admin/report/salesroot/invoiced\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:31:\"admin/report/salesroot/invoiced\";}s:31:\"admin/report/salesroot/refunded\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:31:\"admin/report/salesroot/refunded\";}s:30:\"admin/report/salesroot/coupons\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:30:\"admin/report/salesroot/coupons\";}}}s:48:\"admin/report/salesroot/paypal_settlement_reports\";a:3:{s:8:\"instance\";r:1134;s:6:\"parent\";r:1114;s:8:\"children\";a:2:{s:53:\"admin/report/salesroot/paypal_settlement_reports/view\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:53:\"admin/report/salesroot/paypal_settlement_reports/view\";}s:54:\"admin/report/salesroot/paypal_settlement_reports/fetch\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:54:\"admin/report/salesroot/paypal_settlement_reports/fetch\";}}}s:53:\"admin/report/salesroot/paypal_settlement_reports/view\";a:3:{s:8:\"instance\";r:1152;s:6:\"parent\";r:1134;s:8:\"children\";a:0:{}}s:54:\"admin/report/salesroot/paypal_settlement_reports/fetch\";a:3:{s:8:\"instance\";r:1154;s:6:\"parent\";r:1134;s:8:\"children\";a:0:{}}s:28:\"admin/report/salesroot/sales\";a:3:{s:8:\"instance\";r:1136;s:6:\"parent\";r:1114;s:8:\"children\";a:0:{}}s:26:\"admin/report/salesroot/tax\";a:3:{s:8:\"instance\";r:1138;s:6:\"parent\";r:1114;s:8:\"children\";a:0:{}}s:31:\"admin/report/salesroot/shipping\";a:3:{s:8:\"instance\";r:1140;s:6:\"parent\";r:1114;s:8:\"children\";a:0:{}}s:31:\"admin/report/salesroot/invoiced\";a:3:{s:8:\"instance\";r:1142;s:6:\"parent\";r:1114;s:8:\"children\";a:0:{}}s:31:\"admin/report/salesroot/refunded\";a:3:{s:8:\"instance\";r:1144;s:6:\"parent\";r:1114;s:8:\"children\";a:0:{}}s:30:\"admin/report/salesroot/coupons\";a:3:{s:8:\"instance\";r:1146;s:6:\"parent\";r:1114;s:8:\"children\";a:0:{}}s:21:\"admin/report/shopcart\";a:3:{s:8:\"instance\";r:1116;s:6:\"parent\";r:142;s:8:\"children\";a:2:{s:29:\"admin/report/shopcart/product\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:29:\"admin/report/shopcart/product\";}s:31:\"admin/report/shopcart/abandoned\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:31:\"admin/report/shopcart/abandoned\";}}}s:29:\"admin/report/shopcart/product\";a:3:{s:8:\"instance\";r:1192;s:6:\"parent\";r:1116;s:8:\"children\";a:0:{}}s:31:\"admin/report/shopcart/abandoned\";a:3:{s:8:\"instance\";r:1194;s:6:\"parent\";r:1116;s:8:\"children\";a:0:{}}s:21:\"admin/report/products\";a:3:{s:8:\"instance\";r:1118;s:6:\"parent\";r:142;s:8:\"children\";a:5:{s:33:\"admin/report/products/bestsellers\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:33:\"admin/report/products/bestsellers\";}s:26:\"admin/report/products/sold\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:26:\"admin/report/products/sold\";}s:28:\"admin/report/products/viewed\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:28:\"admin/report/products/viewed\";}s:30:\"admin/report/products/lowstock\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:30:\"admin/report/products/lowstock\";}s:31:\"admin/report/products/downloads\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:31:\"admin/report/products/downloads\";}}}s:33:\"admin/report/products/bestsellers\";a:3:{s:8:\"instance\";r:1208;s:6:\"parent\";r:1118;s:8:\"children\";a:0:{}}s:26:\"admin/report/products/sold\";a:3:{s:8:\"instance\";r:1210;s:6:\"parent\";r:1118;s:8:\"children\";a:0:{}}s:28:\"admin/report/products/viewed\";a:3:{s:8:\"instance\";r:1212;s:6:\"parent\";r:1118;s:8:\"children\";a:0:{}}s:30:\"admin/report/products/lowstock\";a:3:{s:8:\"instance\";r:1214;s:6:\"parent\";r:1118;s:8:\"children\";a:0:{}}s:31:\"admin/report/products/downloads\";a:3:{s:8:\"instance\";r:1216;s:6:\"parent\";r:1118;s:8:\"children\";a:0:{}}s:22:\"admin/report/customers\";a:3:{s:8:\"instance\";r:1120;s:6:\"parent\";r:142;s:8:\"children\";a:3:{s:31:\"admin/report/customers/accounts\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:31:\"admin/report/customers/accounts\";}s:29:\"admin/report/customers/totals\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:29:\"admin/report/customers/totals\";}s:29:\"admin/report/customers/orders\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:29:\"admin/report/customers/orders\";}}}s:31:\"admin/report/customers/accounts\";a:3:{s:8:\"instance\";r:1242;s:6:\"parent\";r:1120;s:8:\"children\";a:0:{}}s:29:\"admin/report/customers/totals\";a:3:{s:8:\"instance\";r:1244;s:6:\"parent\";r:1120;s:8:\"children\";a:0:{}}s:29:\"admin/report/customers/orders\";a:3:{s:8:\"instance\";r:1246;s:6:\"parent\";r:1120;s:8:\"children\";a:0:{}}s:19:\"admin/report/review\";a:3:{s:8:\"instance\";r:1122;s:6:\"parent\";r:142;s:8:\"children\";a:2:{s:28:\"admin/report/review/customer\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:28:\"admin/report/review/customer\";}s:27:\"admin/report/review/product\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:27:\"admin/report/review/product\";}}}s:28:\"admin/report/review/customer\";a:3:{s:8:\"instance\";r:1264;s:6:\"parent\";r:1122;s:8:\"children\";a:0:{}}s:27:\"admin/report/review/product\";a:3:{s:8:\"instance\";r:1266;s:6:\"parent\";r:1122;s:8:\"children\";a:0:{}}s:17:\"admin/report/tags\";a:3:{s:8:\"instance\";r:1124;s:6:\"parent\";r:142;s:8:\"children\";a:3:{s:26:\"admin/report/tags/customer\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:26:\"admin/report/tags/customer\";}s:25:\"admin/report/tags/popular\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:25:\"admin/report/tags/popular\";}s:25:\"admin/report/tags/product\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:25:\"admin/report/tags/product\";}}}s:26:\"admin/report/tags/customer\";a:3:{s:8:\"instance\";r:1280;s:6:\"parent\";r:1124;s:8:\"children\";a:0:{}}s:25:\"admin/report/tags/popular\";a:3:{s:8:\"instance\";r:1282;s:6:\"parent\";r:1124;s:8:\"children\";a:0:{}}s:25:\"admin/report/tags/product\";a:3:{s:8:\"instance\";r:1284;s:6:\"parent\";r:1124;s:8:\"children\";a:0:{}}s:19:\"admin/report/search\";a:3:{s:8:\"instance\";r:1126;s:6:\"parent\";r:142;s:8:\"children\";a:0:{}}s:23:\"admin/report/statistics\";a:3:{s:8:\"instance\";r:1128;s:6:\"parent\";r:142;s:8:\"children\";a:0:{}}s:16:\"admin/newsletter\";a:3:{s:8:\"instance\";r:144;s:6:\"parent\";r:122;s:8:\"children\";a:4:{s:24:\"admin/newsletter/problem\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:24:\"admin/newsletter/problem\";}s:22:\"admin/newsletter/queue\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:22:\"admin/newsletter/queue\";}s:27:\"admin/newsletter/subscriber\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:27:\"admin/newsletter/subscriber\";}s:25:\"admin/newsletter/template\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:25:\"admin/newsletter/template\";}}}s:24:\"admin/newsletter/problem\";a:3:{s:8:\"instance\";r:1310;s:6:\"parent\";r:144;s:8:\"children\";a:0:{}}s:22:\"admin/newsletter/queue\";a:3:{s:8:\"instance\";r:1312;s:6:\"parent\";r:144;s:8:\"children\";a:0:{}}s:27:\"admin/newsletter/subscriber\";a:3:{s:8:\"instance\";r:1314;s:6:\"parent\";r:144;s:8:\"children\";a:0:{}}s:25:\"admin/newsletter/template\";a:3:{s:8:\"instance\";r:1316;s:6:\"parent\";r:144;s:8:\"children\";a:0:{}}s:16:\"admin/page_cache\";a:3:{s:8:\"instance\";r:146;s:6:\"parent\";r:122;s:8:\"children\";a:0:{}}}s:17:\"\0*\0_isAllowedRole\";r:108;s:21:\"\0*\0_isAllowedResource\";r:158;s:22:\"\0*\0_isAllowedPrivilege\";N;s:9:\"\0*\0_rules\";a:2:{s:12:\"allResources\";a:2:{s:8:\"allRoles\";a:2:{s:13:\"allPrivileges\";a:2:{s:4:\"type\";s:9:\"TYPE_DENY\";s:6:\"assert\";N;}s:13:\"byPrivilegeId\";a:0:{}}s:8:\"byRoleId\";a:1:{s:2:\"G1\";a:2:{s:13:\"byPrivilegeId\";a:0:{}s:13:\"allPrivileges\";a:2:{s:4:\"type\";s:10:\"TYPE_ALLOW\";s:6:\"assert\";N;}}}}s:12:\"byResourceId\";a:1:{s:3:\"all\";a:1:{s:8:\"byRoleId\";a:1:{s:2:\"G1\";a:2:{s:13:\"byPrivilegeId\";a:0:{}s:13:\"allPrivileges\";a:2:{s:4:\"type\";s:10:\"TYPE_ALLOW\";s:6:\"assert\";N;}}}}}}}}'),('6eace4lvm9ijcstn7hrgmdtk82',1424345507,'core|a:5:{s:23:\"_session_validator_data\";a:4:{s:11:\"remote_addr\";s:9:\"127.0.0.1\";s:8:\"http_via\";s:0:\"\";s:20:\"http_x_forwarded_for\";s:0:\"\";s:15:\"http_user_agent\";s:108:\"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36\";}s:8:\"messages\";O:34:\"Mage_Core_Model_Message_Collection\":2:{s:12:\"\0*\0_messages\";a:0:{}s:20:\"\0*\0_lastAddedMessage\";N;}s:15:\"just_voted_poll\";b:0;s:12:\"visitor_data\";a:16:{s:0:\"\";N;s:11:\"server_addr\";i:2130706433;s:11:\"remote_addr\";i:2130706433;s:11:\"http_secure\";b:0;s:9:\"http_host\";s:11:\"magento.loc\";s:15:\"http_user_agent\";s:108:\"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36\";s:20:\"http_accept_language\";s:23:\"ru,en-US;q=0.8,en;q=0.6\";s:19:\"http_accept_charset\";s:0:\"\";s:11:\"request_uri\";s:11:\"/index.php/\";s:10:\"session_id\";s:26:\"6eace4lvm9ijcstn7hrgmdtk82\";s:12:\"http_referer\";s:48:\"http://magento.loc/index.php/install/wizard/end/\";s:14:\"first_visit_at\";s:19:\"2015-02-19 10:11:39\";s:14:\"is_new_visitor\";b:0;s:13:\"last_visit_at\";s:19:\"2015-02-19 10:31:47\";s:10:\"visitor_id\";s:1:\"1\";s:11:\"last_url_id\";s:1:\"4\";}s:8:\"last_url\";s:45:\"http://magento.loc/index.php/cms/index/index/\";}customer_base|a:3:{s:23:\"_session_validator_data\";a:4:{s:11:\"remote_addr\";s:9:\"127.0.0.1\";s:8:\"http_via\";s:0:\"\";s:20:\"http_x_forwarded_for\";s:0:\"\";s:15:\"http_user_agent\";s:108:\"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36\";}s:8:\"messages\";O:34:\"Mage_Core_Model_Message_Collection\":2:{s:12:\"\0*\0_messages\";a:0:{}s:20:\"\0*\0_lastAddedMessage\";N;}s:19:\"wishlist_item_count\";i:0;}checkout|a:2:{s:23:\"_session_validator_data\";a:4:{s:11:\"remote_addr\";s:9:\"127.0.0.1\";s:8:\"http_via\";s:0:\"\";s:20:\"http_x_forwarded_for\";s:0:\"\";s:15:\"http_user_agent\";s:108:\"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36\";}s:8:\"messages\";O:34:\"Mage_Core_Model_Message_Collection\":2:{s:12:\"\0*\0_messages\";a:0:{}s:20:\"\0*\0_lastAddedMessage\";N;}}catalog|a:3:{s:23:\"_session_validator_data\";a:4:{s:11:\"remote_addr\";s:9:\"127.0.0.1\";s:8:\"http_via\";s:0:\"\";s:20:\"http_x_forwarded_for\";s:0:\"\";s:15:\"http_user_agent\";s:108:\"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36\";}s:8:\"messages\";O:34:\"Mage_Core_Model_Message_Collection\":2:{s:12:\"\0*\0_messages\";a:0:{}s:20:\"\0*\0_lastAddedMessage\";N;}s:27:\"catalog_compare_items_count\";i:0;}reports|a:3:{s:23:\"_session_validator_data\";a:4:{s:11:\"remote_addr\";s:9:\"127.0.0.1\";s:8:\"http_via\";s:0:\"\";s:20:\"http_x_forwarded_for\";s:0:\"\";s:15:\"http_user_agent\";s:108:\"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36\";}s:28:\"product_index_compared_count\";i:0;s:26:\"product_index_viewed_count\";i:0;}store_default|a:1:{s:23:\"_session_validator_data\";a:4:{s:11:\"remote_addr\";s:9:\"127.0.0.1\";s:8:\"http_via\";s:0:\"\";s:20:\"http_x_forwarded_for\";s:0:\"\";s:15:\"http_user_agent\";s:108:\"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36\";}}'),('7tq6vmshv1ltebum7tm9g2dtb4',1424348606,'core|a:4:{s:23:\"_session_validator_data\";a:4:{s:11:\"remote_addr\";s:9:\"127.0.0.1\";s:8:\"http_via\";s:0:\"\";s:20:\"http_x_forwarded_for\";s:0:\"\";s:15:\"http_user_agent\";s:109:\"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.111 Safari/537.36\";}s:8:\"messages\";O:34:\"Mage_Core_Model_Message_Collection\":2:{s:12:\"\0*\0_messages\";a:0:{}s:20:\"\0*\0_lastAddedMessage\";N;}s:12:\"visitor_data\";a:16:{s:0:\"\";N;s:11:\"server_addr\";i:2130706433;s:11:\"remote_addr\";i:2130706433;s:11:\"http_secure\";b:0;s:9:\"http_host\";s:11:\"magento.dev\";s:15:\"http_user_agent\";s:109:\"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.111 Safari/537.36\";s:20:\"http_accept_language\";s:35:\"ru-RU,ru;q=0.8,en-US;q=0.6,en;q=0.4\";s:19:\"http_accept_charset\";s:0:\"\";s:11:\"request_uri\";s:1:\"/\";s:10:\"session_id\";s:26:\"7tq6vmshv1ltebum7tm9g2dtb4\";s:12:\"http_referer\";s:0:\"\";s:14:\"first_visit_at\";s:19:\"2015-02-19 11:21:19\";s:14:\"is_new_visitor\";b:0;s:13:\"last_visit_at\";s:19:\"2015-02-19 11:23:26\";s:10:\"visitor_id\";s:1:\"3\";s:11:\"last_url_id\";s:1:\"7\";}s:8:\"last_url\";s:45:\"http://magento.dev/index.php/cms/index/index/\";}customer_base|a:3:{s:23:\"_session_validator_data\";a:4:{s:11:\"remote_addr\";s:9:\"127.0.0.1\";s:8:\"http_via\";s:0:\"\";s:20:\"http_x_forwarded_for\";s:0:\"\";s:15:\"http_user_agent\";s:109:\"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.111 Safari/537.36\";}s:8:\"messages\";O:34:\"Mage_Core_Model_Message_Collection\":2:{s:12:\"\0*\0_messages\";a:0:{}s:20:\"\0*\0_lastAddedMessage\";N;}s:19:\"wishlist_item_count\";i:0;}catalog|a:3:{s:23:\"_session_validator_data\";a:4:{s:11:\"remote_addr\";s:9:\"127.0.0.1\";s:8:\"http_via\";s:0:\"\";s:20:\"http_x_forwarded_for\";s:0:\"\";s:15:\"http_user_agent\";s:109:\"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.111 Safari/537.36\";}s:8:\"messages\";O:34:\"Mage_Core_Model_Message_Collection\":2:{s:12:\"\0*\0_messages\";a:0:{}s:20:\"\0*\0_lastAddedMessage\";N;}s:27:\"catalog_compare_items_count\";i:0;}checkout|a:2:{s:23:\"_session_validator_data\";a:4:{s:11:\"remote_addr\";s:9:\"127.0.0.1\";s:8:\"http_via\";s:0:\"\";s:20:\"http_x_forwarded_for\";s:0:\"\";s:15:\"http_user_agent\";s:109:\"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.111 Safari/537.36\";}s:8:\"messages\";O:34:\"Mage_Core_Model_Message_Collection\":2:{s:12:\"\0*\0_messages\";a:0:{}s:20:\"\0*\0_lastAddedMessage\";N;}}store_default|a:1:{s:23:\"_session_validator_data\";a:4:{s:11:\"remote_addr\";s:9:\"127.0.0.1\";s:8:\"http_via\";s:0:\"\";s:20:\"http_x_forwarded_for\";s:0:\"\";s:15:\"http_user_agent\";s:109:\"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.111 Safari/537.36\";}}'),('b3rh1sp6f3ln81b17ulv8p2to5',1424347238,'core|a:3:{s:23:\"_session_validator_data\";a:4:{s:11:\"remote_addr\";s:9:\"127.0.0.1\";s:8:\"http_via\";s:0:\"\";s:20:\"http_x_forwarded_for\";s:0:\"\";s:15:\"http_user_agent\";s:108:\"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36\";}s:9:\"_form_key\";s:16:\"8nUmWTDpg01buuHb\";s:8:\"messages\";O:34:\"Mage_Core_Model_Message_Collection\":2:{s:12:\"\0*\0_messages\";a:0:{}s:20:\"\0*\0_lastAddedMessage\";N;}}adminhtml|a:3:{s:23:\"_session_validator_data\";a:4:{s:11:\"remote_addr\";s:9:\"127.0.0.1\";s:8:\"http_via\";s:0:\"\";s:20:\"http_x_forwarded_for\";s:0:\"\";s:15:\"http_user_agent\";s:108:\"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36\";}s:6:\"locale\";s:5:\"en_US\";s:8:\"messages\";O:34:\"Mage_Core_Model_Message_Collection\":2:{s:12:\"\0*\0_messages\";a:0:{}s:20:\"\0*\0_lastAddedMessage\";N;}}admin|a:4:{s:23:\"_session_validator_data\";a:4:{s:11:\"remote_addr\";s:9:\"127.0.0.1\";s:8:\"http_via\";s:0:\"\";s:20:\"http_x_forwarded_for\";s:0:\"\";s:15:\"http_user_agent\";s:108:\"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36\";}s:23:\"sync_process_stop_watch\";b:0;s:4:\"user\";O:21:\"Mage_Admin_Model_User\":17:{s:15:\"\0*\0_eventPrefix\";s:10:\"admin_user\";s:8:\"\0*\0_role\";N;s:25:\"\0*\0_hasAvailableResources\";b:1;s:15:\"\0*\0_eventObject\";s:6:\"object\";s:16:\"\0*\0_resourceName\";s:10:\"admin/user\";s:12:\"\0*\0_resource\";N;s:26:\"\0*\0_resourceCollectionName\";s:21:\"admin/user_collection\";s:12:\"\0*\0_cacheTag\";b:0;s:19:\"\0*\0_dataSaveAllowed\";b:1;s:15:\"\0*\0_isObjectNew\";N;s:8:\"\0*\0_data\";a:15:{s:7:\"user_id\";s:1:\"1\";s:9:\"firstname\";s:5:\"Vasya\";s:8:\"lastname\";s:8:\"Morarash\";s:5:\"email\";s:21:\"squirtle479@gmail.com\";s:8:\"username\";s:5:\"admin\";s:8:\"password\";s:65:\"998fca6c95103e4a4ac38f72c435e600:m6SbBevjpLo61HHjACqCHdNoTb00Dvde\";s:7:\"created\";s:19:\"2015-02-19 10:10:22\";s:8:\"modified\";s:19:\"2015-02-19 10:10:22\";s:7:\"logdate\";s:19:\"2015-02-19 11:00:30\";s:6:\"lognum\";s:1:\"3\";s:15:\"reload_acl_flag\";s:1:\"0\";s:9:\"is_active\";s:1:\"1\";s:5:\"extra\";a:1:{s:11:\"configState\";a:8:{s:14:\"design_package\";s:1:\"1\";s:12:\"design_theme\";s:1:\"0\";s:11:\"design_head\";s:1:\"0\";s:13:\"design_header\";s:1:\"0\";s:13:\"design_footer\";s:1:\"0\";s:16:\"design_watermark\";s:1:\"0\";s:17:\"design_pagination\";s:1:\"0\";s:12:\"design_email\";s:1:\"0\";}}s:8:\"rp_token\";N;s:19:\"rp_token_created_at\";N;}s:18:\"\0*\0_hasDataChanges\";b:0;s:12:\"\0*\0_origData\";a:15:{s:7:\"user_id\";s:1:\"1\";s:9:\"firstname\";s:5:\"Vasya\";s:8:\"lastname\";s:8:\"Morarash\";s:5:\"email\";s:21:\"squirtle479@gmail.com\";s:8:\"username\";s:5:\"admin\";s:8:\"password\";s:65:\"998fca6c95103e4a4ac38f72c435e600:m6SbBevjpLo61HHjACqCHdNoTb00Dvde\";s:7:\"created\";s:19:\"2015-02-19 10:10:22\";s:8:\"modified\";s:19:\"2015-02-19 10:10:22\";s:7:\"logdate\";s:19:\"2015-02-19 11:00:30\";s:6:\"lognum\";s:1:\"3\";s:15:\"reload_acl_flag\";s:1:\"0\";s:9:\"is_active\";s:1:\"1\";s:5:\"extra\";a:1:{s:11:\"configState\";a:8:{s:14:\"design_package\";s:1:\"1\";s:12:\"design_theme\";s:1:\"0\";s:11:\"design_head\";s:1:\"0\";s:13:\"design_header\";s:1:\"0\";s:13:\"design_footer\";s:1:\"0\";s:16:\"design_watermark\";s:1:\"0\";s:17:\"design_pagination\";s:1:\"0\";s:12:\"design_email\";s:1:\"0\";}}s:8:\"rp_token\";N;s:19:\"rp_token_created_at\";N;}s:15:\"\0*\0_idFieldName\";s:7:\"user_id\";s:13:\"\0*\0_isDeleted\";b:0;s:16:\"\0*\0_oldFieldsMap\";a:0:{}s:17:\"\0*\0_syncFieldsMap\";a:0:{}}s:3:\"acl\";O:20:\"Mage_Admin_Model_Acl\":6:{s:16:\"\0*\0_roleRegistry\";O:34:\"Mage_Admin_Model_Acl_Role_Registry\":1:{s:9:\"\0*\0_roles\";a:2:{s:2:\"G1\";a:3:{s:8:\"instance\";O:31:\"Mage_Admin_Model_Acl_Role_Group\":1:{s:10:\"\0*\0_roleId\";s:2:\"G1\";}s:7:\"parents\";a:0:{}s:8:\"children\";a:1:{s:2:\"U1\";O:30:\"Mage_Admin_Model_Acl_Role_User\":1:{s:10:\"\0*\0_roleId\";s:2:\"U1\";}}}s:2:\"U1\";a:3:{s:8:\"instance\";r:102;s:7:\"parents\";a:1:{s:2:\"G1\";r:98;}s:8:\"children\";a:0:{}}}}s:13:\"\0*\0_resources\";a:204:{s:3:\"all\";a:3:{s:8:\"instance\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:3:\"all\";}s:6:\"parent\";N;s:8:\"children\";a:0:{}}s:5:\"admin\";a:3:{s:8:\"instance\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:5:\"admin\";}s:6:\"parent\";N;s:8:\"children\";a:11:{s:15:\"admin/dashboard\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:15:\"admin/dashboard\";}s:12:\"admin/system\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:12:\"admin/system\";}s:19:\"admin/global_search\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:19:\"admin/global_search\";}s:9:\"admin/cms\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:9:\"admin/cms\";}s:14:\"admin/customer\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:14:\"admin/customer\";}s:13:\"admin/catalog\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:13:\"admin/catalog\";}s:11:\"admin/promo\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:11:\"admin/promo\";}s:11:\"admin/sales\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:11:\"admin/sales\";}s:12:\"admin/report\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:12:\"admin/report\";}s:16:\"admin/newsletter\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:16:\"admin/newsletter\";}s:16:\"admin/page_cache\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:16:\"admin/page_cache\";}}}s:15:\"admin/dashboard\";a:3:{s:8:\"instance\";r:120;s:6:\"parent\";r:116;s:8:\"children\";a:0:{}}s:12:\"admin/system\";a:3:{s:8:\"instance\";r:122;s:6:\"parent\";r:116;s:8:\"children\";a:16:{s:16:\"admin/system/acl\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:16:\"admin/system/acl\";}s:18:\"admin/system/store\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:18:\"admin/system/store\";}s:19:\"admin/system/design\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:19:\"admin/system/design\";}s:19:\"admin/system/config\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:19:\"admin/system/config\";}s:21:\"admin/system/currency\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:21:\"admin/system/currency\";}s:27:\"admin/system/email_template\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:27:\"admin/system/email_template\";}s:21:\"admin/system/variable\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:21:\"admin/system/variable\";}s:22:\"admin/system/myaccount\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:22:\"admin/system/myaccount\";}s:18:\"admin/system/tools\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:18:\"admin/system/tools\";}s:20:\"admin/system/convert\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:20:\"admin/system/convert\";}s:18:\"admin/system/cache\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:18:\"admin/system/cache\";}s:23:\"admin/system/extensions\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:23:\"admin/system/extensions\";}s:30:\"admin/system/adminnotification\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:30:\"admin/system/adminnotification\";}s:18:\"admin/system/index\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:18:\"admin/system/index\";}s:27:\"admin/system/order_statuses\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:27:\"admin/system/order_statuses\";}s:16:\"admin/system/api\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:16:\"admin/system/api\";}}}s:16:\"admin/system/acl\";a:3:{s:8:\"instance\";r:150;s:6:\"parent\";r:122;s:8:\"children\";a:2:{s:22:\"admin/system/acl/roles\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:22:\"admin/system/acl/roles\";}s:22:\"admin/system/acl/users\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:22:\"admin/system/acl/users\";}}}s:22:\"admin/system/acl/roles\";a:3:{s:8:\"instance\";r:186;s:6:\"parent\";r:150;s:8:\"children\";a:0:{}}s:22:\"admin/system/acl/users\";a:3:{s:8:\"instance\";r:188;s:6:\"parent\";r:150;s:8:\"children\";a:0:{}}s:18:\"admin/system/store\";a:3:{s:8:\"instance\";r:152;s:6:\"parent\";r:122;s:8:\"children\";a:0:{}}s:19:\"admin/system/design\";a:3:{s:8:\"instance\";r:154;s:6:\"parent\";r:122;s:8:\"children\";a:0:{}}s:19:\"admin/system/config\";a:3:{s:8:\"instance\";r:156;s:6:\"parent\";r:122;s:8:\"children\";a:45:{s:27:\"admin/system/config/general\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:27:\"admin/system/config/general\";}s:23:\"admin/system/config/web\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:23:\"admin/system/config/web\";}s:26:\"admin/system/config/design\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:26:\"admin/system/config/design\";}s:26:\"admin/system/config/system\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:26:\"admin/system/config/system\";}s:28:\"admin/system/config/advanced\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:28:\"admin/system/config/advanced\";}s:31:\"admin/system/config/trans_email\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:31:\"admin/system/config/trans_email\";}s:23:\"admin/system/config/dev\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:23:\"admin/system/config/dev\";}s:28:\"admin/system/config/currency\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:28:\"admin/system/config/currency\";}s:30:\"admin/system/config/sendfriend\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:30:\"admin/system/config/sendfriend\";}s:25:\"admin/system/config/admin\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:25:\"admin/system/config/admin\";}s:23:\"admin/system/config/cms\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:23:\"admin/system/config/cms\";}s:28:\"admin/system/config/customer\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:28:\"admin/system/config/customer\";}s:27:\"admin/system/config/catalog\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:27:\"admin/system/config/catalog\";}s:27:\"admin/system/config/payment\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:27:\"admin/system/config/payment\";}s:36:\"admin/system/config/payment_services\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:36:\"admin/system/config/payment_services\";}s:25:\"admin/system/config/sales\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:25:\"admin/system/config/sales\";}s:31:\"admin/system/config/sales_email\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:31:\"admin/system/config/sales_email\";}s:29:\"admin/system/config/sales_pdf\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:29:\"admin/system/config/sales_pdf\";}s:36:\"admin/system/config/cataloginventory\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:36:\"admin/system/config/cataloginventory\";}s:28:\"admin/system/config/shipping\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:28:\"admin/system/config/shipping\";}s:28:\"admin/system/config/carriers\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:28:\"admin/system/config/carriers\";}s:25:\"admin/system/config/promo\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:25:\"admin/system/config/promo\";}s:28:\"admin/system/config/checkout\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:28:\"admin/system/config/checkout\";}s:26:\"admin/system/config/paypal\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:26:\"admin/system/config/paypal\";}s:27:\"admin/system/config/reports\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:27:\"admin/system/config/reports\";}s:26:\"admin/system/config/google\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:26:\"admin/system/config/google\";}s:23:\"admin/system/config/tax\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:23:\"admin/system/config/tax\";}s:28:\"admin/system/config/wishlist\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:28:\"admin/system/config/wishlist\";}s:28:\"admin/system/config/contacts\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:28:\"admin/system/config/contacts\";}s:27:\"admin/system/config/sitemap\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:27:\"admin/system/config/sitemap\";}s:23:\"admin/system/config/rss\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:23:\"admin/system/config/rss\";}s:23:\"admin/system/config/api\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:23:\"admin/system/config/api\";}s:25:\"admin/system/config/oauth\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:25:\"admin/system/config/oauth\";}s:34:\"admin/system/config/configswatches\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:34:\"admin/system/config/configswatches\";}s:30:\"admin/system/config/newsletter\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:30:\"admin/system/config/newsletter\";}s:32:\"admin/system/config/downloadable\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:32:\"admin/system/config/downloadable\";}s:30:\"admin/system/config/persistent\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:30:\"admin/system/config/persistent\";}s:29:\"admin/system/config/cloudzoom\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:29:\"admin/system/config/cloudzoom\";}s:26:\"admin/system/config/brands\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:26:\"admin/system/config/brands\";}s:34:\"admin/system/config/ultraslideshow\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:34:\"admin/system/config/ultraslideshow\";}s:33:\"admin/system/config/ultramegamenu\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:33:\"admin/system/config/ultramegamenu\";}s:26:\"admin/system/config/ultimo\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:26:\"admin/system/config/ultimo\";}s:33:\"admin/system/config/ultimo_design\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:33:\"admin/system/config/ultimo_design\";}s:33:\"admin/system/config/ultimo_layout\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:33:\"admin/system/config/ultimo_layout\";}s:32:\"admin/system/config/moneybookers\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:32:\"admin/system/config/moneybookers\";}}}s:27:\"admin/system/config/general\";a:3:{s:8:\"instance\";r:210;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:23:\"admin/system/config/web\";a:3:{s:8:\"instance\";r:212;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:26:\"admin/system/config/design\";a:3:{s:8:\"instance\";r:214;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:26:\"admin/system/config/system\";a:3:{s:8:\"instance\";r:216;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:28:\"admin/system/config/advanced\";a:3:{s:8:\"instance\";r:218;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:31:\"admin/system/config/trans_email\";a:3:{s:8:\"instance\";r:220;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:23:\"admin/system/config/dev\";a:3:{s:8:\"instance\";r:222;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:28:\"admin/system/config/currency\";a:3:{s:8:\"instance\";r:224;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:30:\"admin/system/config/sendfriend\";a:3:{s:8:\"instance\";r:226;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:25:\"admin/system/config/admin\";a:3:{s:8:\"instance\";r:228;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:23:\"admin/system/config/cms\";a:3:{s:8:\"instance\";r:230;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:28:\"admin/system/config/customer\";a:3:{s:8:\"instance\";r:232;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:27:\"admin/system/config/catalog\";a:3:{s:8:\"instance\";r:234;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:27:\"admin/system/config/payment\";a:3:{s:8:\"instance\";r:236;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:36:\"admin/system/config/payment_services\";a:3:{s:8:\"instance\";r:238;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:25:\"admin/system/config/sales\";a:3:{s:8:\"instance\";r:240;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:31:\"admin/system/config/sales_email\";a:3:{s:8:\"instance\";r:242;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:29:\"admin/system/config/sales_pdf\";a:3:{s:8:\"instance\";r:244;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:36:\"admin/system/config/cataloginventory\";a:3:{s:8:\"instance\";r:246;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:28:\"admin/system/config/shipping\";a:3:{s:8:\"instance\";r:248;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:28:\"admin/system/config/carriers\";a:3:{s:8:\"instance\";r:250;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:25:\"admin/system/config/promo\";a:3:{s:8:\"instance\";r:252;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:28:\"admin/system/config/checkout\";a:3:{s:8:\"instance\";r:254;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:26:\"admin/system/config/paypal\";a:3:{s:8:\"instance\";r:256;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:27:\"admin/system/config/reports\";a:3:{s:8:\"instance\";r:258;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:26:\"admin/system/config/google\";a:3:{s:8:\"instance\";r:260;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:23:\"admin/system/config/tax\";a:3:{s:8:\"instance\";r:262;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:28:\"admin/system/config/wishlist\";a:3:{s:8:\"instance\";r:264;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:28:\"admin/system/config/contacts\";a:3:{s:8:\"instance\";r:266;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:27:\"admin/system/config/sitemap\";a:3:{s:8:\"instance\";r:268;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:23:\"admin/system/config/rss\";a:3:{s:8:\"instance\";r:270;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:23:\"admin/system/config/api\";a:3:{s:8:\"instance\";r:272;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:25:\"admin/system/config/oauth\";a:3:{s:8:\"instance\";r:274;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:34:\"admin/system/config/configswatches\";a:3:{s:8:\"instance\";r:276;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:30:\"admin/system/config/newsletter\";a:3:{s:8:\"instance\";r:278;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:32:\"admin/system/config/downloadable\";a:3:{s:8:\"instance\";r:280;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:30:\"admin/system/config/persistent\";a:3:{s:8:\"instance\";r:282;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:29:\"admin/system/config/cloudzoom\";a:3:{s:8:\"instance\";r:284;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:26:\"admin/system/config/brands\";a:3:{s:8:\"instance\";r:286;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:34:\"admin/system/config/ultraslideshow\";a:3:{s:8:\"instance\";r:288;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:33:\"admin/system/config/ultramegamenu\";a:3:{s:8:\"instance\";r:290;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:26:\"admin/system/config/ultimo\";a:3:{s:8:\"instance\";r:292;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:33:\"admin/system/config/ultimo_design\";a:3:{s:8:\"instance\";r:294;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:33:\"admin/system/config/ultimo_layout\";a:3:{s:8:\"instance\";r:296;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:32:\"admin/system/config/moneybookers\";a:3:{s:8:\"instance\";r:298;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:21:\"admin/system/currency\";a:3:{s:8:\"instance\";r:158;s:6:\"parent\";r:122;s:8:\"children\";a:2:{s:27:\"admin/system/currency/rates\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:27:\"admin/system/currency/rates\";}s:29:\"admin/system/currency/symbols\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:29:\"admin/system/currency/symbols\";}}}s:27:\"admin/system/currency/rates\";a:3:{s:8:\"instance\";r:484;s:6:\"parent\";r:158;s:8:\"children\";a:0:{}}s:29:\"admin/system/currency/symbols\";a:3:{s:8:\"instance\";r:486;s:6:\"parent\";r:158;s:8:\"children\";a:0:{}}s:27:\"admin/system/email_template\";a:3:{s:8:\"instance\";r:160;s:6:\"parent\";r:122;s:8:\"children\";a:0:{}}s:21:\"admin/system/variable\";a:3:{s:8:\"instance\";r:162;s:6:\"parent\";r:122;s:8:\"children\";a:0:{}}s:22:\"admin/system/myaccount\";a:3:{s:8:\"instance\";r:164;s:6:\"parent\";r:122;s:8:\"children\";a:0:{}}s:18:\"admin/system/tools\";a:3:{s:8:\"instance\";r:166;s:6:\"parent\";r:122;s:8:\"children\";a:2:{s:25:\"admin/system/tools/backup\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:25:\"admin/system/tools/backup\";}s:27:\"admin/system/tools/compiler\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:27:\"admin/system/tools/compiler\";}}}s:25:\"admin/system/tools/backup\";a:3:{s:8:\"instance\";r:512;s:6:\"parent\";r:166;s:8:\"children\";a:1:{s:34:\"admin/system/tools/backup/rollback\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:34:\"admin/system/tools/backup/rollback\";}}}s:34:\"admin/system/tools/backup/rollback\";a:3:{s:8:\"instance\";r:520;s:6:\"parent\";r:512;s:8:\"children\";a:0:{}}s:27:\"admin/system/tools/compiler\";a:3:{s:8:\"instance\";r:514;s:6:\"parent\";r:166;s:8:\"children\";a:0:{}}s:20:\"admin/system/convert\";a:3:{s:8:\"instance\";r:168;s:6:\"parent\";r:122;s:8:\"children\";a:4:{s:24:\"admin/system/convert/gui\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:24:\"admin/system/convert/gui\";}s:29:\"admin/system/convert/profiles\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:29:\"admin/system/convert/profiles\";}s:27:\"admin/system/convert/import\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:27:\"admin/system/convert/import\";}s:27:\"admin/system/convert/export\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:27:\"admin/system/convert/export\";}}}s:24:\"admin/system/convert/gui\";a:3:{s:8:\"instance\";r:534;s:6:\"parent\";r:168;s:8:\"children\";a:0:{}}s:29:\"admin/system/convert/profiles\";a:3:{s:8:\"instance\";r:536;s:6:\"parent\";r:168;s:8:\"children\";a:0:{}}s:27:\"admin/system/convert/import\";a:3:{s:8:\"instance\";r:538;s:6:\"parent\";r:168;s:8:\"children\";a:0:{}}s:27:\"admin/system/convert/export\";a:3:{s:8:\"instance\";r:540;s:6:\"parent\";r:168;s:8:\"children\";a:0:{}}s:18:\"admin/system/cache\";a:3:{s:8:\"instance\";r:170;s:6:\"parent\";r:122;s:8:\"children\";a:0:{}}s:23:\"admin/system/extensions\";a:3:{s:8:\"instance\";r:172;s:6:\"parent\";r:122;s:8:\"children\";a:2:{s:29:\"admin/system/extensions/local\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:29:\"admin/system/extensions/local\";}s:30:\"admin/system/extensions/custom\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:30:\"admin/system/extensions/custom\";}}}s:29:\"admin/system/extensions/local\";a:3:{s:8:\"instance\";r:566;s:6:\"parent\";r:172;s:8:\"children\";a:0:{}}s:30:\"admin/system/extensions/custom\";a:3:{s:8:\"instance\";r:568;s:6:\"parent\";r:172;s:8:\"children\";a:0:{}}s:30:\"admin/system/adminnotification\";a:3:{s:8:\"instance\";r:174;s:6:\"parent\";r:122;s:8:\"children\";a:4:{s:43:\"admin/system/adminnotification/show_toolbar\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:43:\"admin/system/adminnotification/show_toolbar\";}s:40:\"admin/system/adminnotification/show_list\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:40:\"admin/system/adminnotification/show_list\";}s:43:\"admin/system/adminnotification/mark_as_read\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:43:\"admin/system/adminnotification/mark_as_read\";}s:37:\"admin/system/adminnotification/remove\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:37:\"admin/system/adminnotification/remove\";}}}s:43:\"admin/system/adminnotification/show_toolbar\";a:3:{s:8:\"instance\";r:582;s:6:\"parent\";r:174;s:8:\"children\";a:0:{}}s:40:\"admin/system/adminnotification/show_list\";a:3:{s:8:\"instance\";r:584;s:6:\"parent\";r:174;s:8:\"children\";a:0:{}}s:43:\"admin/system/adminnotification/mark_as_read\";a:3:{s:8:\"instance\";r:586;s:6:\"parent\";r:174;s:8:\"children\";a:0:{}}s:37:\"admin/system/adminnotification/remove\";a:3:{s:8:\"instance\";r:588;s:6:\"parent\";r:174;s:8:\"children\";a:0:{}}s:18:\"admin/system/index\";a:3:{s:8:\"instance\";r:176;s:6:\"parent\";r:122;s:8:\"children\";a:0:{}}s:27:\"admin/system/order_statuses\";a:3:{s:8:\"instance\";r:178;s:6:\"parent\";r:122;s:8:\"children\";a:0:{}}s:16:\"admin/system/api\";a:3:{s:8:\"instance\";r:180;s:6:\"parent\";r:122;s:8:\"children\";a:7:{s:22:\"admin/system/api/users\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:22:\"admin/system/api/users\";}s:22:\"admin/system/api/roles\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:22:\"admin/system/api/roles\";}s:25:\"admin/system/api/consumer\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:25:\"admin/system/api/consumer\";}s:33:\"admin/system/api/authorizedTokens\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:33:\"admin/system/api/authorizedTokens\";}s:34:\"admin/system/api/oauth_admin_token\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:34:\"admin/system/api/oauth_admin_token\";}s:27:\"admin/system/api/rest_roles\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:27:\"admin/system/api/rest_roles\";}s:32:\"admin/system/api/rest_attributes\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:32:\"admin/system/api/rest_attributes\";}}}s:22:\"admin/system/api/users\";a:3:{s:8:\"instance\";r:618;s:6:\"parent\";r:180;s:8:\"children\";a:0:{}}s:22:\"admin/system/api/roles\";a:3:{s:8:\"instance\";r:620;s:6:\"parent\";r:180;s:8:\"children\";a:0:{}}s:25:\"admin/system/api/consumer\";a:3:{s:8:\"instance\";r:622;s:6:\"parent\";r:180;s:8:\"children\";a:2:{s:30:\"admin/system/api/consumer/edit\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:30:\"admin/system/api/consumer/edit\";}s:32:\"admin/system/api/consumer/delete\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:32:\"admin/system/api/consumer/delete\";}}}s:30:\"admin/system/api/consumer/edit\";a:3:{s:8:\"instance\";r:644;s:6:\"parent\";r:622;s:8:\"children\";a:0:{}}s:32:\"admin/system/api/consumer/delete\";a:3:{s:8:\"instance\";r:646;s:6:\"parent\";r:622;s:8:\"children\";a:0:{}}s:33:\"admin/system/api/authorizedTokens\";a:3:{s:8:\"instance\";r:624;s:6:\"parent\";r:180;s:8:\"children\";a:0:{}}s:34:\"admin/system/api/oauth_admin_token\";a:3:{s:8:\"instance\";r:626;s:6:\"parent\";r:180;s:8:\"children\";a:0:{}}s:27:\"admin/system/api/rest_roles\";a:3:{s:8:\"instance\";r:628;s:6:\"parent\";r:180;s:8:\"children\";a:3:{s:31:\"admin/system/api/rest_roles/add\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:31:\"admin/system/api/rest_roles/add\";}s:32:\"admin/system/api/rest_roles/edit\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:32:\"admin/system/api/rest_roles/edit\";}s:34:\"admin/system/api/rest_roles/delete\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:34:\"admin/system/api/rest_roles/delete\";}}}s:31:\"admin/system/api/rest_roles/add\";a:3:{s:8:\"instance\";r:668;s:6:\"parent\";r:628;s:8:\"children\";a:0:{}}s:32:\"admin/system/api/rest_roles/edit\";a:3:{s:8:\"instance\";r:670;s:6:\"parent\";r:628;s:8:\"children\";a:0:{}}s:34:\"admin/system/api/rest_roles/delete\";a:3:{s:8:\"instance\";r:672;s:6:\"parent\";r:628;s:8:\"children\";a:0:{}}s:32:\"admin/system/api/rest_attributes\";a:3:{s:8:\"instance\";r:630;s:6:\"parent\";r:180;s:8:\"children\";a:1:{s:37:\"admin/system/api/rest_attributes/edit\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:37:\"admin/system/api/rest_attributes/edit\";}}}s:37:\"admin/system/api/rest_attributes/edit\";a:3:{s:8:\"instance\";r:690;s:6:\"parent\";r:630;s:8:\"children\";a:0:{}}s:19:\"admin/global_search\";a:3:{s:8:\"instance\";r:124;s:6:\"parent\";r:116;s:8:\"children\";a:0:{}}s:9:\"admin/cms\";a:3:{s:8:\"instance\";r:126;s:6:\"parent\";r:116;s:8:\"children\";a:5:{s:15:\"admin/cms/block\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:15:\"admin/cms/block\";}s:14:\"admin/cms/page\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:14:\"admin/cms/page\";}s:23:\"admin/cms/media_gallery\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:23:\"admin/cms/media_gallery\";}s:14:\"admin/cms/poll\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:14:\"admin/cms/poll\";}s:25:\"admin/cms/widget_instance\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:25:\"admin/cms/widget_instance\";}}}s:15:\"admin/cms/block\";a:3:{s:8:\"instance\";r:704;s:6:\"parent\";r:126;s:8:\"children\";a:0:{}}s:14:\"admin/cms/page\";a:3:{s:8:\"instance\";r:706;s:6:\"parent\";r:126;s:8:\"children\";a:2:{s:19:\"admin/cms/page/save\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:19:\"admin/cms/page/save\";}s:21:\"admin/cms/page/delete\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:21:\"admin/cms/page/delete\";}}}s:19:\"admin/cms/page/save\";a:3:{s:8:\"instance\";r:722;s:6:\"parent\";r:706;s:8:\"children\";a:0:{}}s:21:\"admin/cms/page/delete\";a:3:{s:8:\"instance\";r:724;s:6:\"parent\";r:706;s:8:\"children\";a:0:{}}s:23:\"admin/cms/media_gallery\";a:3:{s:8:\"instance\";r:708;s:6:\"parent\";r:126;s:8:\"children\";a:0:{}}s:14:\"admin/cms/poll\";a:3:{s:8:\"instance\";r:710;s:6:\"parent\";r:126;s:8:\"children\";a:0:{}}s:25:\"admin/cms/widget_instance\";a:3:{s:8:\"instance\";r:712;s:6:\"parent\";r:126;s:8:\"children\";a:0:{}}s:14:\"admin/customer\";a:3:{s:8:\"instance\";r:128;s:6:\"parent\";r:116;s:8:\"children\";a:3:{s:20:\"admin/customer/group\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:20:\"admin/customer/group\";}s:21:\"admin/customer/manage\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:21:\"admin/customer/manage\";}s:21:\"admin/customer/online\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:21:\"admin/customer/online\";}}}s:20:\"admin/customer/group\";a:3:{s:8:\"instance\";r:750;s:6:\"parent\";r:128;s:8:\"children\";a:0:{}}s:21:\"admin/customer/manage\";a:3:{s:8:\"instance\";r:752;s:6:\"parent\";r:128;s:8:\"children\";a:0:{}}s:21:\"admin/customer/online\";a:3:{s:8:\"instance\";r:754;s:6:\"parent\";r:128;s:8:\"children\";a:0:{}}s:13:\"admin/catalog\";a:3:{s:8:\"instance\";r:130;s:6:\"parent\";r:116;s:8:\"children\";a:9:{s:24:\"admin/catalog/attributes\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:24:\"admin/catalog/attributes\";}s:24:\"admin/catalog/categories\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:24:\"admin/catalog/categories\";}s:22:\"admin/catalog/products\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:22:\"admin/catalog/products\";}s:31:\"admin/catalog/update_attributes\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:31:\"admin/catalog/update_attributes\";}s:24:\"admin/catalog/urlrewrite\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:24:\"admin/catalog/urlrewrite\";}s:20:\"admin/catalog/search\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:20:\"admin/catalog/search\";}s:29:\"admin/catalog/reviews_ratings\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:29:\"admin/catalog/reviews_ratings\";}s:17:\"admin/catalog/tag\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:17:\"admin/catalog/tag\";}s:21:\"admin/catalog/sitemap\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:21:\"admin/catalog/sitemap\";}}}s:24:\"admin/catalog/attributes\";a:3:{s:8:\"instance\";r:772;s:6:\"parent\";r:130;s:8:\"children\";a:2:{s:35:\"admin/catalog/attributes/attributes\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:35:\"admin/catalog/attributes/attributes\";}s:29:\"admin/catalog/attributes/sets\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:29:\"admin/catalog/attributes/sets\";}}}s:35:\"admin/catalog/attributes/attributes\";a:3:{s:8:\"instance\";r:794;s:6:\"parent\";r:772;s:8:\"children\";a:0:{}}s:29:\"admin/catalog/attributes/sets\";a:3:{s:8:\"instance\";r:796;s:6:\"parent\";r:772;s:8:\"children\";a:0:{}}s:24:\"admin/catalog/categories\";a:3:{s:8:\"instance\";r:774;s:6:\"parent\";r:130;s:8:\"children\";a:0:{}}s:22:\"admin/catalog/products\";a:3:{s:8:\"instance\";r:776;s:6:\"parent\";r:130;s:8:\"children\";a:0:{}}s:31:\"admin/catalog/update_attributes\";a:3:{s:8:\"instance\";r:778;s:6:\"parent\";r:130;s:8:\"children\";a:0:{}}s:24:\"admin/catalog/urlrewrite\";a:3:{s:8:\"instance\";r:780;s:6:\"parent\";r:130;s:8:\"children\";a:0:{}}s:20:\"admin/catalog/search\";a:3:{s:8:\"instance\";r:782;s:6:\"parent\";r:130;s:8:\"children\";a:0:{}}s:29:\"admin/catalog/reviews_ratings\";a:3:{s:8:\"instance\";r:784;s:6:\"parent\";r:130;s:8:\"children\";a:2:{s:37:\"admin/catalog/reviews_ratings/reviews\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:37:\"admin/catalog/reviews_ratings/reviews\";}s:37:\"admin/catalog/reviews_ratings/ratings\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:37:\"admin/catalog/reviews_ratings/ratings\";}}}s:37:\"admin/catalog/reviews_ratings/reviews\";a:3:{s:8:\"instance\";r:830;s:6:\"parent\";r:784;s:8:\"children\";a:2:{s:41:\"admin/catalog/reviews_ratings/reviews/all\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:41:\"admin/catalog/reviews_ratings/reviews/all\";}s:45:\"admin/catalog/reviews_ratings/reviews/pending\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:45:\"admin/catalog/reviews_ratings/reviews/pending\";}}}s:41:\"admin/catalog/reviews_ratings/reviews/all\";a:3:{s:8:\"instance\";r:838;s:6:\"parent\";r:830;s:8:\"children\";a:0:{}}s:45:\"admin/catalog/reviews_ratings/reviews/pending\";a:3:{s:8:\"instance\";r:840;s:6:\"parent\";r:830;s:8:\"children\";a:0:{}}s:37:\"admin/catalog/reviews_ratings/ratings\";a:3:{s:8:\"instance\";r:832;s:6:\"parent\";r:784;s:8:\"children\";a:0:{}}s:17:\"admin/catalog/tag\";a:3:{s:8:\"instance\";r:786;s:6:\"parent\";r:130;s:8:\"children\";a:2:{s:21:\"admin/catalog/tag/all\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:21:\"admin/catalog/tag/all\";}s:25:\"admin/catalog/tag/pending\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:25:\"admin/catalog/tag/pending\";}}}s:21:\"admin/catalog/tag/all\";a:3:{s:8:\"instance\";r:858;s:6:\"parent\";r:786;s:8:\"children\";a:0:{}}s:25:\"admin/catalog/tag/pending\";a:3:{s:8:\"instance\";r:860;s:6:\"parent\";r:786;s:8:\"children\";a:0:{}}s:21:\"admin/catalog/sitemap\";a:3:{s:8:\"instance\";r:788;s:6:\"parent\";r:130;s:8:\"children\";a:0:{}}s:11:\"admin/promo\";a:3:{s:8:\"instance\";r:132;s:6:\"parent\";r:116;s:8:\"children\";a:2:{s:19:\"admin/promo/catalog\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:19:\"admin/promo/catalog\";}s:17:\"admin/promo/quote\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:17:\"admin/promo/quote\";}}}s:19:\"admin/promo/catalog\";a:3:{s:8:\"instance\";r:878;s:6:\"parent\";r:132;s:8:\"children\";a:0:{}}s:17:\"admin/promo/quote\";a:3:{s:8:\"instance\";r:880;s:6:\"parent\";r:132;s:8:\"children\";a:0:{}}s:11:\"admin/sales\";a:3:{s:8:\"instance\";r:134;s:6:\"parent\";r:116;s:8:\"children\";a:9:{s:17:\"admin/sales/order\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:17:\"admin/sales/order\";}s:19:\"admin/sales/invoice\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:19:\"admin/sales/invoice\";}s:20:\"admin/sales/shipment\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:20:\"admin/sales/shipment\";}s:22:\"admin/sales/creditmemo\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:22:\"admin/sales/creditmemo\";}s:24:\"admin/sales/transactions\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:24:\"admin/sales/transactions\";}s:29:\"admin/sales/recurring_profile\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:29:\"admin/sales/recurring_profile\";}s:29:\"admin/sales/billing_agreement\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:29:\"admin/sales/billing_agreement\";}s:29:\"admin/sales/checkoutagreement\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:29:\"admin/sales/checkoutagreement\";}s:15:\"admin/sales/tax\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:15:\"admin/sales/tax\";}}}s:17:\"admin/sales/order\";a:3:{s:8:\"instance\";r:894;s:6:\"parent\";r:134;s:8:\"children\";a:1:{s:25:\"admin/sales/order/actions\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:25:\"admin/sales/order/actions\";}}}s:25:\"admin/sales/order/actions\";a:3:{s:8:\"instance\";r:916;s:6:\"parent\";r:894;s:8:\"children\";a:15:{s:32:\"admin/sales/order/actions/create\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:32:\"admin/sales/order/actions/create\";}s:30:\"admin/sales/order/actions/view\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:30:\"admin/sales/order/actions/view\";}s:31:\"admin/sales/order/actions/email\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:31:\"admin/sales/order/actions/email\";}s:33:\"admin/sales/order/actions/reorder\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:33:\"admin/sales/order/actions/reorder\";}s:30:\"admin/sales/order/actions/edit\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:30:\"admin/sales/order/actions/edit\";}s:32:\"admin/sales/order/actions/cancel\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:32:\"admin/sales/order/actions/cancel\";}s:40:\"admin/sales/order/actions/review_payment\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:40:\"admin/sales/order/actions/review_payment\";}s:33:\"admin/sales/order/actions/capture\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:33:\"admin/sales/order/actions/capture\";}s:33:\"admin/sales/order/actions/invoice\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:33:\"admin/sales/order/actions/invoice\";}s:36:\"admin/sales/order/actions/creditmemo\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:36:\"admin/sales/order/actions/creditmemo\";}s:30:\"admin/sales/order/actions/hold\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:30:\"admin/sales/order/actions/hold\";}s:32:\"admin/sales/order/actions/unhold\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:32:\"admin/sales/order/actions/unhold\";}s:30:\"admin/sales/order/actions/ship\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:30:\"admin/sales/order/actions/ship\";}s:33:\"admin/sales/order/actions/comment\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:33:\"admin/sales/order/actions/comment\";}s:32:\"admin/sales/order/actions/emails\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:32:\"admin/sales/order/actions/emails\";}}}s:32:\"admin/sales/order/actions/create\";a:3:{s:8:\"instance\";r:922;s:6:\"parent\";r:916;s:8:\"children\";a:0:{}}s:30:\"admin/sales/order/actions/view\";a:3:{s:8:\"instance\";r:924;s:6:\"parent\";r:916;s:8:\"children\";a:0:{}}s:31:\"admin/sales/order/actions/email\";a:3:{s:8:\"instance\";r:926;s:6:\"parent\";r:916;s:8:\"children\";a:0:{}}s:33:\"admin/sales/order/actions/reorder\";a:3:{s:8:\"instance\";r:928;s:6:\"parent\";r:916;s:8:\"children\";a:0:{}}s:30:\"admin/sales/order/actions/edit\";a:3:{s:8:\"instance\";r:930;s:6:\"parent\";r:916;s:8:\"children\";a:0:{}}s:32:\"admin/sales/order/actions/cancel\";a:3:{s:8:\"instance\";r:932;s:6:\"parent\";r:916;s:8:\"children\";a:0:{}}s:40:\"admin/sales/order/actions/review_payment\";a:3:{s:8:\"instance\";r:934;s:6:\"parent\";r:916;s:8:\"children\";a:0:{}}s:33:\"admin/sales/order/actions/capture\";a:3:{s:8:\"instance\";r:936;s:6:\"parent\";r:916;s:8:\"children\";a:0:{}}s:33:\"admin/sales/order/actions/invoice\";a:3:{s:8:\"instance\";r:938;s:6:\"parent\";r:916;s:8:\"children\";a:0:{}}s:36:\"admin/sales/order/actions/creditmemo\";a:3:{s:8:\"instance\";r:940;s:6:\"parent\";r:916;s:8:\"children\";a:0:{}}s:30:\"admin/sales/order/actions/hold\";a:3:{s:8:\"instance\";r:942;s:6:\"parent\";r:916;s:8:\"children\";a:0:{}}s:32:\"admin/sales/order/actions/unhold\";a:3:{s:8:\"instance\";r:944;s:6:\"parent\";r:916;s:8:\"children\";a:0:{}}s:30:\"admin/sales/order/actions/ship\";a:3:{s:8:\"instance\";r:946;s:6:\"parent\";r:916;s:8:\"children\";a:0:{}}s:33:\"admin/sales/order/actions/comment\";a:3:{s:8:\"instance\";r:948;s:6:\"parent\";r:916;s:8:\"children\";a:0:{}}s:32:\"admin/sales/order/actions/emails\";a:3:{s:8:\"instance\";r:950;s:6:\"parent\";r:916;s:8:\"children\";a:0:{}}s:19:\"admin/sales/invoice\";a:3:{s:8:\"instance\";r:896;s:6:\"parent\";r:134;s:8:\"children\";a:0:{}}s:20:\"admin/sales/shipment\";a:3:{s:8:\"instance\";r:898;s:6:\"parent\";r:134;s:8:\"children\";a:0:{}}s:22:\"admin/sales/creditmemo\";a:3:{s:8:\"instance\";r:900;s:6:\"parent\";r:134;s:8:\"children\";a:0:{}}s:24:\"admin/sales/transactions\";a:3:{s:8:\"instance\";r:902;s:6:\"parent\";r:134;s:8:\"children\";a:1:{s:30:\"admin/sales/transactions/fetch\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:30:\"admin/sales/transactions/fetch\";}}}s:30:\"admin/sales/transactions/fetch\";a:3:{s:8:\"instance\";r:1028;s:6:\"parent\";r:902;s:8:\"children\";a:0:{}}s:29:\"admin/sales/recurring_profile\";a:3:{s:8:\"instance\";r:904;s:6:\"parent\";r:134;s:8:\"children\";a:0:{}}s:29:\"admin/sales/billing_agreement\";a:3:{s:8:\"instance\";r:906;s:6:\"parent\";r:134;s:8:\"children\";a:1:{s:37:\"admin/sales/billing_agreement/actions\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:37:\"admin/sales/billing_agreement/actions\";}}}s:37:\"admin/sales/billing_agreement/actions\";a:3:{s:8:\"instance\";r:1042;s:6:\"parent\";r:906;s:8:\"children\";a:3:{s:42:\"admin/sales/billing_agreement/actions/view\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:42:\"admin/sales/billing_agreement/actions/view\";}s:44:\"admin/sales/billing_agreement/actions/manage\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:44:\"admin/sales/billing_agreement/actions/manage\";}s:41:\"admin/sales/billing_agreement/actions/use\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:41:\"admin/sales/billing_agreement/actions/use\";}}}s:42:\"admin/sales/billing_agreement/actions/view\";a:3:{s:8:\"instance\";r:1048;s:6:\"parent\";r:1042;s:8:\"children\";a:0:{}}s:44:\"admin/sales/billing_agreement/actions/manage\";a:3:{s:8:\"instance\";r:1050;s:6:\"parent\";r:1042;s:8:\"children\";a:0:{}}s:41:\"admin/sales/billing_agreement/actions/use\";a:3:{s:8:\"instance\";r:1052;s:6:\"parent\";r:1042;s:8:\"children\";a:0:{}}s:29:\"admin/sales/checkoutagreement\";a:3:{s:8:\"instance\";r:908;s:6:\"parent\";r:134;s:8:\"children\";a:0:{}}s:15:\"admin/sales/tax\";a:3:{s:8:\"instance\";r:910;s:6:\"parent\";r:134;s:8:\"children\";a:5:{s:32:\"admin/sales/tax/classes_customer\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:32:\"admin/sales/tax/classes_customer\";}s:31:\"admin/sales/tax/classes_product\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:31:\"admin/sales/tax/classes_product\";}s:29:\"admin/sales/tax/import_export\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:29:\"admin/sales/tax/import_export\";}s:21:\"admin/sales/tax/rates\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:21:\"admin/sales/tax/rates\";}s:21:\"admin/sales/tax/rules\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:21:\"admin/sales/tax/rules\";}}}s:32:\"admin/sales/tax/classes_customer\";a:3:{s:8:\"instance\";r:1074;s:6:\"parent\";r:910;s:8:\"children\";a:0:{}}s:31:\"admin/sales/tax/classes_product\";a:3:{s:8:\"instance\";r:1076;s:6:\"parent\";r:910;s:8:\"children\";a:0:{}}s:29:\"admin/sales/tax/import_export\";a:3:{s:8:\"instance\";r:1078;s:6:\"parent\";r:910;s:8:\"children\";a:0:{}}s:21:\"admin/sales/tax/rates\";a:3:{s:8:\"instance\";r:1080;s:6:\"parent\";r:910;s:8:\"children\";a:0:{}}s:21:\"admin/sales/tax/rules\";a:3:{s:8:\"instance\";r:1082;s:6:\"parent\";r:910;s:8:\"children\";a:0:{}}s:12:\"admin/report\";a:3:{s:8:\"instance\";r:136;s:6:\"parent\";r:116;s:8:\"children\";a:8:{s:22:\"admin/report/salesroot\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:22:\"admin/report/salesroot\";}s:21:\"admin/report/shopcart\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:21:\"admin/report/shopcart\";}s:21:\"admin/report/products\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:21:\"admin/report/products\";}s:22:\"admin/report/customers\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:22:\"admin/report/customers\";}s:19:\"admin/report/review\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:19:\"admin/report/review\";}s:17:\"admin/report/tags\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:17:\"admin/report/tags\";}s:19:\"admin/report/search\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:19:\"admin/report/search\";}s:23:\"admin/report/statistics\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:23:\"admin/report/statistics\";}}}s:22:\"admin/report/salesroot\";a:3:{s:8:\"instance\";r:1108;s:6:\"parent\";r:136;s:8:\"children\";a:7:{s:48:\"admin/report/salesroot/paypal_settlement_reports\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:48:\"admin/report/salesroot/paypal_settlement_reports\";}s:28:\"admin/report/salesroot/sales\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:28:\"admin/report/salesroot/sales\";}s:26:\"admin/report/salesroot/tax\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:26:\"admin/report/salesroot/tax\";}s:31:\"admin/report/salesroot/shipping\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:31:\"admin/report/salesroot/shipping\";}s:31:\"admin/report/salesroot/invoiced\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:31:\"admin/report/salesroot/invoiced\";}s:31:\"admin/report/salesroot/refunded\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:31:\"admin/report/salesroot/refunded\";}s:30:\"admin/report/salesroot/coupons\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:30:\"admin/report/salesroot/coupons\";}}}s:48:\"admin/report/salesroot/paypal_settlement_reports\";a:3:{s:8:\"instance\";r:1128;s:6:\"parent\";r:1108;s:8:\"children\";a:2:{s:53:\"admin/report/salesroot/paypal_settlement_reports/view\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:53:\"admin/report/salesroot/paypal_settlement_reports/view\";}s:54:\"admin/report/salesroot/paypal_settlement_reports/fetch\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:54:\"admin/report/salesroot/paypal_settlement_reports/fetch\";}}}s:53:\"admin/report/salesroot/paypal_settlement_reports/view\";a:3:{s:8:\"instance\";r:1146;s:6:\"parent\";r:1128;s:8:\"children\";a:0:{}}s:54:\"admin/report/salesroot/paypal_settlement_reports/fetch\";a:3:{s:8:\"instance\";r:1148;s:6:\"parent\";r:1128;s:8:\"children\";a:0:{}}s:28:\"admin/report/salesroot/sales\";a:3:{s:8:\"instance\";r:1130;s:6:\"parent\";r:1108;s:8:\"children\";a:0:{}}s:26:\"admin/report/salesroot/tax\";a:3:{s:8:\"instance\";r:1132;s:6:\"parent\";r:1108;s:8:\"children\";a:0:{}}s:31:\"admin/report/salesroot/shipping\";a:3:{s:8:\"instance\";r:1134;s:6:\"parent\";r:1108;s:8:\"children\";a:0:{}}s:31:\"admin/report/salesroot/invoiced\";a:3:{s:8:\"instance\";r:1136;s:6:\"parent\";r:1108;s:8:\"children\";a:0:{}}s:31:\"admin/report/salesroot/refunded\";a:3:{s:8:\"instance\";r:1138;s:6:\"parent\";r:1108;s:8:\"children\";a:0:{}}s:30:\"admin/report/salesroot/coupons\";a:3:{s:8:\"instance\";r:1140;s:6:\"parent\";r:1108;s:8:\"children\";a:0:{}}s:21:\"admin/report/shopcart\";a:3:{s:8:\"instance\";r:1110;s:6:\"parent\";r:136;s:8:\"children\";a:2:{s:29:\"admin/report/shopcart/product\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:29:\"admin/report/shopcart/product\";}s:31:\"admin/report/shopcart/abandoned\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:31:\"admin/report/shopcart/abandoned\";}}}s:29:\"admin/report/shopcart/product\";a:3:{s:8:\"instance\";r:1186;s:6:\"parent\";r:1110;s:8:\"children\";a:0:{}}s:31:\"admin/report/shopcart/abandoned\";a:3:{s:8:\"instance\";r:1188;s:6:\"parent\";r:1110;s:8:\"children\";a:0:{}}s:21:\"admin/report/products\";a:3:{s:8:\"instance\";r:1112;s:6:\"parent\";r:136;s:8:\"children\";a:5:{s:33:\"admin/report/products/bestsellers\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:33:\"admin/report/products/bestsellers\";}s:26:\"admin/report/products/sold\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:26:\"admin/report/products/sold\";}s:28:\"admin/report/products/viewed\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:28:\"admin/report/products/viewed\";}s:30:\"admin/report/products/lowstock\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:30:\"admin/report/products/lowstock\";}s:31:\"admin/report/products/downloads\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:31:\"admin/report/products/downloads\";}}}s:33:\"admin/report/products/bestsellers\";a:3:{s:8:\"instance\";r:1202;s:6:\"parent\";r:1112;s:8:\"children\";a:0:{}}s:26:\"admin/report/products/sold\";a:3:{s:8:\"instance\";r:1204;s:6:\"parent\";r:1112;s:8:\"children\";a:0:{}}s:28:\"admin/report/products/viewed\";a:3:{s:8:\"instance\";r:1206;s:6:\"parent\";r:1112;s:8:\"children\";a:0:{}}s:30:\"admin/report/products/lowstock\";a:3:{s:8:\"instance\";r:1208;s:6:\"parent\";r:1112;s:8:\"children\";a:0:{}}s:31:\"admin/report/products/downloads\";a:3:{s:8:\"instance\";r:1210;s:6:\"parent\";r:1112;s:8:\"children\";a:0:{}}s:22:\"admin/report/customers\";a:3:{s:8:\"instance\";r:1114;s:6:\"parent\";r:136;s:8:\"children\";a:3:{s:31:\"admin/report/customers/accounts\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:31:\"admin/report/customers/accounts\";}s:29:\"admin/report/customers/totals\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:29:\"admin/report/customers/totals\";}s:29:\"admin/report/customers/orders\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:29:\"admin/report/customers/orders\";}}}s:31:\"admin/report/customers/accounts\";a:3:{s:8:\"instance\";r:1236;s:6:\"parent\";r:1114;s:8:\"children\";a:0:{}}s:29:\"admin/report/customers/totals\";a:3:{s:8:\"instance\";r:1238;s:6:\"parent\";r:1114;s:8:\"children\";a:0:{}}s:29:\"admin/report/customers/orders\";a:3:{s:8:\"instance\";r:1240;s:6:\"parent\";r:1114;s:8:\"children\";a:0:{}}s:19:\"admin/report/review\";a:3:{s:8:\"instance\";r:1116;s:6:\"parent\";r:136;s:8:\"children\";a:2:{s:28:\"admin/report/review/customer\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:28:\"admin/report/review/customer\";}s:27:\"admin/report/review/product\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:27:\"admin/report/review/product\";}}}s:28:\"admin/report/review/customer\";a:3:{s:8:\"instance\";r:1258;s:6:\"parent\";r:1116;s:8:\"children\";a:0:{}}s:27:\"admin/report/review/product\";a:3:{s:8:\"instance\";r:1260;s:6:\"parent\";r:1116;s:8:\"children\";a:0:{}}s:17:\"admin/report/tags\";a:3:{s:8:\"instance\";r:1118;s:6:\"parent\";r:136;s:8:\"children\";a:3:{s:26:\"admin/report/tags/customer\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:26:\"admin/report/tags/customer\";}s:25:\"admin/report/tags/popular\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:25:\"admin/report/tags/popular\";}s:25:\"admin/report/tags/product\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:25:\"admin/report/tags/product\";}}}s:26:\"admin/report/tags/customer\";a:3:{s:8:\"instance\";r:1274;s:6:\"parent\";r:1118;s:8:\"children\";a:0:{}}s:25:\"admin/report/tags/popular\";a:3:{s:8:\"instance\";r:1276;s:6:\"parent\";r:1118;s:8:\"children\";a:0:{}}s:25:\"admin/report/tags/product\";a:3:{s:8:\"instance\";r:1278;s:6:\"parent\";r:1118;s:8:\"children\";a:0:{}}s:19:\"admin/report/search\";a:3:{s:8:\"instance\";r:1120;s:6:\"parent\";r:136;s:8:\"children\";a:0:{}}s:23:\"admin/report/statistics\";a:3:{s:8:\"instance\";r:1122;s:6:\"parent\";r:136;s:8:\"children\";a:0:{}}s:16:\"admin/newsletter\";a:3:{s:8:\"instance\";r:138;s:6:\"parent\";r:116;s:8:\"children\";a:4:{s:24:\"admin/newsletter/problem\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:24:\"admin/newsletter/problem\";}s:22:\"admin/newsletter/queue\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:22:\"admin/newsletter/queue\";}s:27:\"admin/newsletter/subscriber\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:27:\"admin/newsletter/subscriber\";}s:25:\"admin/newsletter/template\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:25:\"admin/newsletter/template\";}}}s:24:\"admin/newsletter/problem\";a:3:{s:8:\"instance\";r:1304;s:6:\"parent\";r:138;s:8:\"children\";a:0:{}}s:22:\"admin/newsletter/queue\";a:3:{s:8:\"instance\";r:1306;s:6:\"parent\";r:138;s:8:\"children\";a:0:{}}s:27:\"admin/newsletter/subscriber\";a:3:{s:8:\"instance\";r:1308;s:6:\"parent\";r:138;s:8:\"children\";a:0:{}}s:25:\"admin/newsletter/template\";a:3:{s:8:\"instance\";r:1310;s:6:\"parent\";r:138;s:8:\"children\";a:0:{}}s:16:\"admin/page_cache\";a:3:{s:8:\"instance\";r:140;s:6:\"parent\";r:116;s:8:\"children\";a:0:{}}}s:17:\"\0*\0_isAllowedRole\";r:102;s:21:\"\0*\0_isAllowedResource\";r:262;s:22:\"\0*\0_isAllowedPrivilege\";N;s:9:\"\0*\0_rules\";a:2:{s:12:\"allResources\";a:2:{s:8:\"allRoles\";a:2:{s:13:\"allPrivileges\";a:2:{s:4:\"type\";s:9:\"TYPE_DENY\";s:6:\"assert\";N;}s:13:\"byPrivilegeId\";a:0:{}}s:8:\"byRoleId\";a:1:{s:2:\"G1\";a:2:{s:13:\"byPrivilegeId\";a:0:{}s:13:\"allPrivileges\";a:2:{s:4:\"type\";s:10:\"TYPE_ALLOW\";s:6:\"assert\";N;}}}}s:12:\"byResourceId\";a:1:{s:3:\"all\";a:1:{s:8:\"byRoleId\";a:1:{s:2:\"G1\";a:2:{s:13:\"byPrivilegeId\";a:0:{}s:13:\"allPrivileges\";a:2:{s:4:\"type\";s:10:\"TYPE_ALLOW\";s:6:\"assert\";N;}}}}}}}}'),('e23lsqchaag7d8d22lmkq61ba6',1424347187,'core|a:4:{s:23:\"_session_validator_data\";a:4:{s:11:\"remote_addr\";s:9:\"127.0.0.1\";s:8:\"http_via\";s:0:\"\";s:20:\"http_x_forwarded_for\";s:0:\"\";s:15:\"http_user_agent\";s:108:\"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36\";}s:8:\"messages\";O:34:\"Mage_Core_Model_Message_Collection\":2:{s:12:\"\0*\0_messages\";a:0:{}s:20:\"\0*\0_lastAddedMessage\";N;}s:12:\"visitor_data\";a:16:{s:0:\"\";N;s:11:\"server_addr\";i:2130706433;s:11:\"remote_addr\";i:2130706433;s:11:\"http_secure\";b:0;s:9:\"http_host\";s:11:\"magento.dev\";s:15:\"http_user_agent\";s:108:\"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36\";s:20:\"http_accept_language\";s:23:\"ru,en-US;q=0.8,en;q=0.6\";s:19:\"http_accept_charset\";s:0:\"\";s:11:\"request_uri\";s:1:\"/\";s:10:\"session_id\";s:26:\"e23lsqchaag7d8d22lmkq61ba6\";s:12:\"http_referer\";s:0:\"\";s:14:\"first_visit_at\";s:19:\"2015-02-19 10:59:43\";s:14:\"is_new_visitor\";b:0;s:13:\"last_visit_at\";s:19:\"2015-02-19 10:59:47\";s:10:\"visitor_id\";s:1:\"2\";s:11:\"last_url_id\";s:1:\"5\";}s:8:\"last_url\";s:45:\"http://magento.dev/index.php/cms/index/index/\";}customer_base|a:3:{s:23:\"_session_validator_data\";a:4:{s:11:\"remote_addr\";s:9:\"127.0.0.1\";s:8:\"http_via\";s:0:\"\";s:20:\"http_x_forwarded_for\";s:0:\"\";s:15:\"http_user_agent\";s:108:\"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36\";}s:8:\"messages\";O:34:\"Mage_Core_Model_Message_Collection\":2:{s:12:\"\0*\0_messages\";a:0:{}s:20:\"\0*\0_lastAddedMessage\";N;}s:19:\"wishlist_item_count\";i:0;}catalog|a:3:{s:23:\"_session_validator_data\";a:4:{s:11:\"remote_addr\";s:9:\"127.0.0.1\";s:8:\"http_via\";s:0:\"\";s:20:\"http_x_forwarded_for\";s:0:\"\";s:15:\"http_user_agent\";s:108:\"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36\";}s:8:\"messages\";O:34:\"Mage_Core_Model_Message_Collection\":2:{s:12:\"\0*\0_messages\";a:0:{}s:20:\"\0*\0_lastAddedMessage\";N;}s:27:\"catalog_compare_items_count\";i:0;}checkout|a:2:{s:23:\"_session_validator_data\";a:4:{s:11:\"remote_addr\";s:9:\"127.0.0.1\";s:8:\"http_via\";s:0:\"\";s:20:\"http_x_forwarded_for\";s:0:\"\";s:15:\"http_user_agent\";s:108:\"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36\";}s:8:\"messages\";O:34:\"Mage_Core_Model_Message_Collection\":2:{s:12:\"\0*\0_messages\";a:0:{}s:20:\"\0*\0_lastAddedMessage\";N;}}store_default|a:1:{s:23:\"_session_validator_data\";a:4:{s:11:\"remote_addr\";s:9:\"127.0.0.1\";s:8:\"http_via\";s:0:\"\";s:20:\"http_x_forwarded_for\";s:0:\"\";s:15:\"http_user_agent\";s:108:\"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36\";}}'),('f7gdc9dg1g5o0e2jfi7l3qhh30',1424345412,'core|a:3:{s:23:\"_session_validator_data\";a:4:{s:11:\"remote_addr\";s:9:\"127.0.0.1\";s:8:\"http_via\";s:0:\"\";s:20:\"http_x_forwarded_for\";s:0:\"\";s:15:\"http_user_agent\";s:108:\"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36\";}s:9:\"_form_key\";s:16:\"N9JU23Wjz9Ru3dhx\";s:8:\"messages\";O:34:\"Mage_Core_Model_Message_Collection\":2:{s:12:\"\0*\0_messages\";a:0:{}s:20:\"\0*\0_lastAddedMessage\";N;}}adminhtml|a:4:{s:23:\"_session_validator_data\";a:4:{s:11:\"remote_addr\";s:9:\"127.0.0.1\";s:8:\"http_via\";s:0:\"\";s:20:\"http_x_forwarded_for\";s:0:\"\";s:15:\"http_user_agent\";s:108:\"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36\";}s:6:\"locale\";s:5:\"en_US\";s:8:\"messages\";O:34:\"Mage_Core_Model_Message_Collection\":2:{s:12:\"\0*\0_messages\";a:0:{}s:20:\"\0*\0_lastAddedMessage\";O:31:\"Mage_Core_Model_Message_Success\":6:{s:8:\"\0*\0_type\";s:7:\"success\";s:8:\"\0*\0_code\";s:33:\"The configuration has been saved.\";s:9:\"\0*\0_class\";s:0:\"\";s:10:\"\0*\0_method\";s:0:\"\";s:14:\"\0*\0_identifier\";N;s:12:\"\0*\0_isSticky\";b:0;}}s:13:\"is_url_notice\";b:1;}admin|a:1:{s:8:\"messages\";O:34:\"Mage_Core_Model_Message_Collection\":2:{s:12:\"\0*\0_messages\";a:1:{s:7:\"success\";a:1:{i:0;O:31:\"Mage_Core_Model_Message_Success\":6:{s:8:\"\0*\0_type\";s:7:\"success\";s:8:\"\0*\0_code\";s:20:\"You have logged out.\";s:9:\"\0*\0_class\";s:0:\"\";s:10:\"\0*\0_method\";s:0:\"\";s:14:\"\0*\0_identifier\";N;s:12:\"\0*\0_isSticky\";b:0;}}}s:20:\"\0*\0_lastAddedMessage\";r:32;}}'),('h7lpiiq6m5maegugg3k62rfra5',1424345495,'core|a:3:{s:23:\"_session_validator_data\";a:4:{s:11:\"remote_addr\";s:9:\"127.0.0.1\";s:8:\"http_via\";s:0:\"\";s:20:\"http_x_forwarded_for\";s:0:\"\";s:15:\"http_user_agent\";s:108:\"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36\";}s:9:\"_form_key\";s:16:\"jWRenqaubLyqfL4m\";s:8:\"messages\";O:34:\"Mage_Core_Model_Message_Collection\":2:{s:12:\"\0*\0_messages\";a:0:{}s:20:\"\0*\0_lastAddedMessage\";N;}}adminhtml|a:3:{s:23:\"_session_validator_data\";a:4:{s:11:\"remote_addr\";s:9:\"127.0.0.1\";s:8:\"http_via\";s:0:\"\";s:20:\"http_x_forwarded_for\";s:0:\"\";s:15:\"http_user_agent\";s:108:\"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36\";}s:6:\"locale\";s:5:\"en_US\";s:8:\"messages\";O:34:\"Mage_Core_Model_Message_Collection\":2:{s:12:\"\0*\0_messages\";a:0:{}s:20:\"\0*\0_lastAddedMessage\";O:30:\"Mage_Core_Model_Message_Notice\":6:{s:8:\"\0*\0_type\";s:6:\"notice\";s:8:\"\0*\0_code\";s:117:\"Unable to import items (1) with the following identifiers (they already exist in the database):<br />customer-service\";s:9:\"\0*\0_class\";s:0:\"\";s:10:\"\0*\0_method\";s:0:\"\";s:14:\"\0*\0_identifier\";N;s:12:\"\0*\0_isSticky\";b:0;}}}admin|a:4:{s:23:\"_session_validator_data\";a:4:{s:11:\"remote_addr\";s:9:\"127.0.0.1\";s:8:\"http_via\";s:0:\"\";s:20:\"http_x_forwarded_for\";s:0:\"\";s:15:\"http_user_agent\";s:108:\"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36\";}s:23:\"sync_process_stop_watch\";b:0;s:4:\"user\";O:21:\"Mage_Admin_Model_User\":17:{s:15:\"\0*\0_eventPrefix\";s:10:\"admin_user\";s:8:\"\0*\0_role\";N;s:25:\"\0*\0_hasAvailableResources\";b:1;s:15:\"\0*\0_eventObject\";s:6:\"object\";s:16:\"\0*\0_resourceName\";s:10:\"admin/user\";s:12:\"\0*\0_resource\";N;s:26:\"\0*\0_resourceCollectionName\";s:21:\"admin/user_collection\";s:12:\"\0*\0_cacheTag\";b:0;s:19:\"\0*\0_dataSaveAllowed\";b:1;s:15:\"\0*\0_isObjectNew\";N;s:8:\"\0*\0_data\";a:15:{s:7:\"user_id\";s:1:\"1\";s:9:\"firstname\";s:5:\"Vasya\";s:8:\"lastname\";s:8:\"Morarash\";s:5:\"email\";s:21:\"squirtle479@gmail.com\";s:8:\"username\";s:5:\"admin\";s:8:\"password\";s:65:\"998fca6c95103e4a4ac38f72c435e600:m6SbBevjpLo61HHjACqCHdNoTb00Dvde\";s:7:\"created\";s:19:\"2015-02-19 10:10:22\";s:8:\"modified\";s:19:\"2015-02-19 10:10:22\";s:7:\"logdate\";s:19:\"2015-02-19 10:30:21\";s:6:\"lognum\";s:1:\"2\";s:15:\"reload_acl_flag\";s:1:\"0\";s:9:\"is_active\";s:1:\"1\";s:5:\"extra\";a:1:{s:11:\"configState\";a:8:{s:14:\"design_package\";s:1:\"1\";s:12:\"design_theme\";s:1:\"0\";s:11:\"design_head\";s:1:\"0\";s:13:\"design_header\";s:1:\"0\";s:13:\"design_footer\";s:1:\"0\";s:16:\"design_watermark\";s:1:\"0\";s:17:\"design_pagination\";s:1:\"0\";s:12:\"design_email\";s:1:\"0\";}}s:8:\"rp_token\";N;s:19:\"rp_token_created_at\";N;}s:18:\"\0*\0_hasDataChanges\";b:0;s:12:\"\0*\0_origData\";a:15:{s:7:\"user_id\";s:1:\"1\";s:9:\"firstname\";s:5:\"Vasya\";s:8:\"lastname\";s:8:\"Morarash\";s:5:\"email\";s:21:\"squirtle479@gmail.com\";s:8:\"username\";s:5:\"admin\";s:8:\"password\";s:65:\"998fca6c95103e4a4ac38f72c435e600:m6SbBevjpLo61HHjACqCHdNoTb00Dvde\";s:7:\"created\";s:19:\"2015-02-19 10:10:22\";s:8:\"modified\";s:19:\"2015-02-19 10:10:22\";s:7:\"logdate\";s:19:\"2015-02-19 10:30:21\";s:6:\"lognum\";s:1:\"2\";s:15:\"reload_acl_flag\";s:1:\"0\";s:9:\"is_active\";s:1:\"1\";s:5:\"extra\";a:1:{s:11:\"configState\";a:8:{s:14:\"design_package\";s:1:\"1\";s:12:\"design_theme\";s:1:\"0\";s:11:\"design_head\";s:1:\"0\";s:13:\"design_header\";s:1:\"0\";s:13:\"design_footer\";s:1:\"0\";s:16:\"design_watermark\";s:1:\"0\";s:17:\"design_pagination\";s:1:\"0\";s:12:\"design_email\";s:1:\"0\";}}s:8:\"rp_token\";N;s:19:\"rp_token_created_at\";N;}s:15:\"\0*\0_idFieldName\";s:7:\"user_id\";s:13:\"\0*\0_isDeleted\";b:0;s:16:\"\0*\0_oldFieldsMap\";a:0:{}s:17:\"\0*\0_syncFieldsMap\";a:0:{}}s:3:\"acl\";O:20:\"Mage_Admin_Model_Acl\":6:{s:16:\"\0*\0_roleRegistry\";O:34:\"Mage_Admin_Model_Acl_Role_Registry\":1:{s:9:\"\0*\0_roles\";a:2:{s:2:\"G1\";a:3:{s:8:\"instance\";O:31:\"Mage_Admin_Model_Acl_Role_Group\":1:{s:10:\"\0*\0_roleId\";s:2:\"G1\";}s:7:\"parents\";a:0:{}s:8:\"children\";a:1:{s:2:\"U1\";O:30:\"Mage_Admin_Model_Acl_Role_User\":1:{s:10:\"\0*\0_roleId\";s:2:\"U1\";}}}s:2:\"U1\";a:3:{s:8:\"instance\";r:108;s:7:\"parents\";a:1:{s:2:\"G1\";r:104;}s:8:\"children\";a:0:{}}}}s:13:\"\0*\0_resources\";a:204:{s:3:\"all\";a:3:{s:8:\"instance\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:3:\"all\";}s:6:\"parent\";N;s:8:\"children\";a:0:{}}s:5:\"admin\";a:3:{s:8:\"instance\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:5:\"admin\";}s:6:\"parent\";N;s:8:\"children\";a:11:{s:15:\"admin/dashboard\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:15:\"admin/dashboard\";}s:12:\"admin/system\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:12:\"admin/system\";}s:19:\"admin/global_search\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:19:\"admin/global_search\";}s:9:\"admin/cms\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:9:\"admin/cms\";}s:14:\"admin/customer\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:14:\"admin/customer\";}s:13:\"admin/catalog\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:13:\"admin/catalog\";}s:11:\"admin/promo\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:11:\"admin/promo\";}s:11:\"admin/sales\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:11:\"admin/sales\";}s:12:\"admin/report\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:12:\"admin/report\";}s:16:\"admin/newsletter\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:16:\"admin/newsletter\";}s:16:\"admin/page_cache\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:16:\"admin/page_cache\";}}}s:15:\"admin/dashboard\";a:3:{s:8:\"instance\";r:126;s:6:\"parent\";r:122;s:8:\"children\";a:0:{}}s:12:\"admin/system\";a:3:{s:8:\"instance\";r:128;s:6:\"parent\";r:122;s:8:\"children\";a:16:{s:16:\"admin/system/acl\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:16:\"admin/system/acl\";}s:18:\"admin/system/store\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:18:\"admin/system/store\";}s:19:\"admin/system/design\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:19:\"admin/system/design\";}s:19:\"admin/system/config\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:19:\"admin/system/config\";}s:21:\"admin/system/currency\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:21:\"admin/system/currency\";}s:27:\"admin/system/email_template\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:27:\"admin/system/email_template\";}s:21:\"admin/system/variable\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:21:\"admin/system/variable\";}s:22:\"admin/system/myaccount\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:22:\"admin/system/myaccount\";}s:18:\"admin/system/tools\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:18:\"admin/system/tools\";}s:20:\"admin/system/convert\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:20:\"admin/system/convert\";}s:18:\"admin/system/cache\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:18:\"admin/system/cache\";}s:23:\"admin/system/extensions\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:23:\"admin/system/extensions\";}s:30:\"admin/system/adminnotification\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:30:\"admin/system/adminnotification\";}s:18:\"admin/system/index\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:18:\"admin/system/index\";}s:27:\"admin/system/order_statuses\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:27:\"admin/system/order_statuses\";}s:16:\"admin/system/api\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:16:\"admin/system/api\";}}}s:16:\"admin/system/acl\";a:3:{s:8:\"instance\";r:156;s:6:\"parent\";r:128;s:8:\"children\";a:2:{s:22:\"admin/system/acl/roles\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:22:\"admin/system/acl/roles\";}s:22:\"admin/system/acl/users\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:22:\"admin/system/acl/users\";}}}s:22:\"admin/system/acl/roles\";a:3:{s:8:\"instance\";r:192;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:22:\"admin/system/acl/users\";a:3:{s:8:\"instance\";r:194;s:6:\"parent\";r:156;s:8:\"children\";a:0:{}}s:18:\"admin/system/store\";a:3:{s:8:\"instance\";r:158;s:6:\"parent\";r:128;s:8:\"children\";a:0:{}}s:19:\"admin/system/design\";a:3:{s:8:\"instance\";r:160;s:6:\"parent\";r:128;s:8:\"children\";a:0:{}}s:19:\"admin/system/config\";a:3:{s:8:\"instance\";r:162;s:6:\"parent\";r:128;s:8:\"children\";a:45:{s:27:\"admin/system/config/general\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:27:\"admin/system/config/general\";}s:23:\"admin/system/config/web\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:23:\"admin/system/config/web\";}s:26:\"admin/system/config/design\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:26:\"admin/system/config/design\";}s:26:\"admin/system/config/system\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:26:\"admin/system/config/system\";}s:28:\"admin/system/config/advanced\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:28:\"admin/system/config/advanced\";}s:31:\"admin/system/config/trans_email\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:31:\"admin/system/config/trans_email\";}s:23:\"admin/system/config/dev\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:23:\"admin/system/config/dev\";}s:28:\"admin/system/config/currency\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:28:\"admin/system/config/currency\";}s:30:\"admin/system/config/sendfriend\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:30:\"admin/system/config/sendfriend\";}s:25:\"admin/system/config/admin\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:25:\"admin/system/config/admin\";}s:23:\"admin/system/config/cms\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:23:\"admin/system/config/cms\";}s:28:\"admin/system/config/customer\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:28:\"admin/system/config/customer\";}s:27:\"admin/system/config/catalog\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:27:\"admin/system/config/catalog\";}s:27:\"admin/system/config/payment\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:27:\"admin/system/config/payment\";}s:36:\"admin/system/config/payment_services\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:36:\"admin/system/config/payment_services\";}s:25:\"admin/system/config/sales\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:25:\"admin/system/config/sales\";}s:31:\"admin/system/config/sales_email\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:31:\"admin/system/config/sales_email\";}s:29:\"admin/system/config/sales_pdf\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:29:\"admin/system/config/sales_pdf\";}s:36:\"admin/system/config/cataloginventory\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:36:\"admin/system/config/cataloginventory\";}s:28:\"admin/system/config/shipping\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:28:\"admin/system/config/shipping\";}s:28:\"admin/system/config/carriers\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:28:\"admin/system/config/carriers\";}s:25:\"admin/system/config/promo\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:25:\"admin/system/config/promo\";}s:28:\"admin/system/config/checkout\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:28:\"admin/system/config/checkout\";}s:26:\"admin/system/config/paypal\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:26:\"admin/system/config/paypal\";}s:27:\"admin/system/config/reports\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:27:\"admin/system/config/reports\";}s:26:\"admin/system/config/google\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:26:\"admin/system/config/google\";}s:23:\"admin/system/config/tax\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:23:\"admin/system/config/tax\";}s:28:\"admin/system/config/wishlist\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:28:\"admin/system/config/wishlist\";}s:28:\"admin/system/config/contacts\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:28:\"admin/system/config/contacts\";}s:27:\"admin/system/config/sitemap\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:27:\"admin/system/config/sitemap\";}s:23:\"admin/system/config/rss\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:23:\"admin/system/config/rss\";}s:23:\"admin/system/config/api\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:23:\"admin/system/config/api\";}s:25:\"admin/system/config/oauth\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:25:\"admin/system/config/oauth\";}s:34:\"admin/system/config/configswatches\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:34:\"admin/system/config/configswatches\";}s:30:\"admin/system/config/newsletter\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:30:\"admin/system/config/newsletter\";}s:32:\"admin/system/config/downloadable\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:32:\"admin/system/config/downloadable\";}s:30:\"admin/system/config/persistent\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:30:\"admin/system/config/persistent\";}s:29:\"admin/system/config/cloudzoom\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:29:\"admin/system/config/cloudzoom\";}s:26:\"admin/system/config/brands\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:26:\"admin/system/config/brands\";}s:34:\"admin/system/config/ultraslideshow\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:34:\"admin/system/config/ultraslideshow\";}s:33:\"admin/system/config/ultramegamenu\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:33:\"admin/system/config/ultramegamenu\";}s:26:\"admin/system/config/ultimo\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:26:\"admin/system/config/ultimo\";}s:33:\"admin/system/config/ultimo_design\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:33:\"admin/system/config/ultimo_design\";}s:33:\"admin/system/config/ultimo_layout\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:33:\"admin/system/config/ultimo_layout\";}s:32:\"admin/system/config/moneybookers\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:32:\"admin/system/config/moneybookers\";}}}s:27:\"admin/system/config/general\";a:3:{s:8:\"instance\";r:216;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:23:\"admin/system/config/web\";a:3:{s:8:\"instance\";r:218;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:26:\"admin/system/config/design\";a:3:{s:8:\"instance\";r:220;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:26:\"admin/system/config/system\";a:3:{s:8:\"instance\";r:222;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:28:\"admin/system/config/advanced\";a:3:{s:8:\"instance\";r:224;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:31:\"admin/system/config/trans_email\";a:3:{s:8:\"instance\";r:226;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:23:\"admin/system/config/dev\";a:3:{s:8:\"instance\";r:228;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:28:\"admin/system/config/currency\";a:3:{s:8:\"instance\";r:230;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:30:\"admin/system/config/sendfriend\";a:3:{s:8:\"instance\";r:232;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:25:\"admin/system/config/admin\";a:3:{s:8:\"instance\";r:234;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:23:\"admin/system/config/cms\";a:3:{s:8:\"instance\";r:236;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:28:\"admin/system/config/customer\";a:3:{s:8:\"instance\";r:238;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:27:\"admin/system/config/catalog\";a:3:{s:8:\"instance\";r:240;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:27:\"admin/system/config/payment\";a:3:{s:8:\"instance\";r:242;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:36:\"admin/system/config/payment_services\";a:3:{s:8:\"instance\";r:244;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:25:\"admin/system/config/sales\";a:3:{s:8:\"instance\";r:246;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:31:\"admin/system/config/sales_email\";a:3:{s:8:\"instance\";r:248;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:29:\"admin/system/config/sales_pdf\";a:3:{s:8:\"instance\";r:250;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:36:\"admin/system/config/cataloginventory\";a:3:{s:8:\"instance\";r:252;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:28:\"admin/system/config/shipping\";a:3:{s:8:\"instance\";r:254;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:28:\"admin/system/config/carriers\";a:3:{s:8:\"instance\";r:256;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:25:\"admin/system/config/promo\";a:3:{s:8:\"instance\";r:258;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:28:\"admin/system/config/checkout\";a:3:{s:8:\"instance\";r:260;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:26:\"admin/system/config/paypal\";a:3:{s:8:\"instance\";r:262;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:27:\"admin/system/config/reports\";a:3:{s:8:\"instance\";r:264;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:26:\"admin/system/config/google\";a:3:{s:8:\"instance\";r:266;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:23:\"admin/system/config/tax\";a:3:{s:8:\"instance\";r:268;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:28:\"admin/system/config/wishlist\";a:3:{s:8:\"instance\";r:270;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:28:\"admin/system/config/contacts\";a:3:{s:8:\"instance\";r:272;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:27:\"admin/system/config/sitemap\";a:3:{s:8:\"instance\";r:274;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:23:\"admin/system/config/rss\";a:3:{s:8:\"instance\";r:276;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:23:\"admin/system/config/api\";a:3:{s:8:\"instance\";r:278;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:25:\"admin/system/config/oauth\";a:3:{s:8:\"instance\";r:280;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:34:\"admin/system/config/configswatches\";a:3:{s:8:\"instance\";r:282;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:30:\"admin/system/config/newsletter\";a:3:{s:8:\"instance\";r:284;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:32:\"admin/system/config/downloadable\";a:3:{s:8:\"instance\";r:286;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:30:\"admin/system/config/persistent\";a:3:{s:8:\"instance\";r:288;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:29:\"admin/system/config/cloudzoom\";a:3:{s:8:\"instance\";r:290;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:26:\"admin/system/config/brands\";a:3:{s:8:\"instance\";r:292;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:34:\"admin/system/config/ultraslideshow\";a:3:{s:8:\"instance\";r:294;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:33:\"admin/system/config/ultramegamenu\";a:3:{s:8:\"instance\";r:296;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:26:\"admin/system/config/ultimo\";a:3:{s:8:\"instance\";r:298;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:33:\"admin/system/config/ultimo_design\";a:3:{s:8:\"instance\";r:300;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:33:\"admin/system/config/ultimo_layout\";a:3:{s:8:\"instance\";r:302;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:32:\"admin/system/config/moneybookers\";a:3:{s:8:\"instance\";r:304;s:6:\"parent\";r:162;s:8:\"children\";a:0:{}}s:21:\"admin/system/currency\";a:3:{s:8:\"instance\";r:164;s:6:\"parent\";r:128;s:8:\"children\";a:2:{s:27:\"admin/system/currency/rates\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:27:\"admin/system/currency/rates\";}s:29:\"admin/system/currency/symbols\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:29:\"admin/system/currency/symbols\";}}}s:27:\"admin/system/currency/rates\";a:3:{s:8:\"instance\";r:490;s:6:\"parent\";r:164;s:8:\"children\";a:0:{}}s:29:\"admin/system/currency/symbols\";a:3:{s:8:\"instance\";r:492;s:6:\"parent\";r:164;s:8:\"children\";a:0:{}}s:27:\"admin/system/email_template\";a:3:{s:8:\"instance\";r:166;s:6:\"parent\";r:128;s:8:\"children\";a:0:{}}s:21:\"admin/system/variable\";a:3:{s:8:\"instance\";r:168;s:6:\"parent\";r:128;s:8:\"children\";a:0:{}}s:22:\"admin/system/myaccount\";a:3:{s:8:\"instance\";r:170;s:6:\"parent\";r:128;s:8:\"children\";a:0:{}}s:18:\"admin/system/tools\";a:3:{s:8:\"instance\";r:172;s:6:\"parent\";r:128;s:8:\"children\";a:2:{s:25:\"admin/system/tools/backup\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:25:\"admin/system/tools/backup\";}s:27:\"admin/system/tools/compiler\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:27:\"admin/system/tools/compiler\";}}}s:25:\"admin/system/tools/backup\";a:3:{s:8:\"instance\";r:518;s:6:\"parent\";r:172;s:8:\"children\";a:1:{s:34:\"admin/system/tools/backup/rollback\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:34:\"admin/system/tools/backup/rollback\";}}}s:34:\"admin/system/tools/backup/rollback\";a:3:{s:8:\"instance\";r:526;s:6:\"parent\";r:518;s:8:\"children\";a:0:{}}s:27:\"admin/system/tools/compiler\";a:3:{s:8:\"instance\";r:520;s:6:\"parent\";r:172;s:8:\"children\";a:0:{}}s:20:\"admin/system/convert\";a:3:{s:8:\"instance\";r:174;s:6:\"parent\";r:128;s:8:\"children\";a:4:{s:24:\"admin/system/convert/gui\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:24:\"admin/system/convert/gui\";}s:29:\"admin/system/convert/profiles\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:29:\"admin/system/convert/profiles\";}s:27:\"admin/system/convert/import\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:27:\"admin/system/convert/import\";}s:27:\"admin/system/convert/export\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:27:\"admin/system/convert/export\";}}}s:24:\"admin/system/convert/gui\";a:3:{s:8:\"instance\";r:540;s:6:\"parent\";r:174;s:8:\"children\";a:0:{}}s:29:\"admin/system/convert/profiles\";a:3:{s:8:\"instance\";r:542;s:6:\"parent\";r:174;s:8:\"children\";a:0:{}}s:27:\"admin/system/convert/import\";a:3:{s:8:\"instance\";r:544;s:6:\"parent\";r:174;s:8:\"children\";a:0:{}}s:27:\"admin/system/convert/export\";a:3:{s:8:\"instance\";r:546;s:6:\"parent\";r:174;s:8:\"children\";a:0:{}}s:18:\"admin/system/cache\";a:3:{s:8:\"instance\";r:176;s:6:\"parent\";r:128;s:8:\"children\";a:0:{}}s:23:\"admin/system/extensions\";a:3:{s:8:\"instance\";r:178;s:6:\"parent\";r:128;s:8:\"children\";a:2:{s:29:\"admin/system/extensions/local\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:29:\"admin/system/extensions/local\";}s:30:\"admin/system/extensions/custom\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:30:\"admin/system/extensions/custom\";}}}s:29:\"admin/system/extensions/local\";a:3:{s:8:\"instance\";r:572;s:6:\"parent\";r:178;s:8:\"children\";a:0:{}}s:30:\"admin/system/extensions/custom\";a:3:{s:8:\"instance\";r:574;s:6:\"parent\";r:178;s:8:\"children\";a:0:{}}s:30:\"admin/system/adminnotification\";a:3:{s:8:\"instance\";r:180;s:6:\"parent\";r:128;s:8:\"children\";a:4:{s:43:\"admin/system/adminnotification/show_toolbar\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:43:\"admin/system/adminnotification/show_toolbar\";}s:40:\"admin/system/adminnotification/show_list\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:40:\"admin/system/adminnotification/show_list\";}s:43:\"admin/system/adminnotification/mark_as_read\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:43:\"admin/system/adminnotification/mark_as_read\";}s:37:\"admin/system/adminnotification/remove\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:37:\"admin/system/adminnotification/remove\";}}}s:43:\"admin/system/adminnotification/show_toolbar\";a:3:{s:8:\"instance\";r:588;s:6:\"parent\";r:180;s:8:\"children\";a:0:{}}s:40:\"admin/system/adminnotification/show_list\";a:3:{s:8:\"instance\";r:590;s:6:\"parent\";r:180;s:8:\"children\";a:0:{}}s:43:\"admin/system/adminnotification/mark_as_read\";a:3:{s:8:\"instance\";r:592;s:6:\"parent\";r:180;s:8:\"children\";a:0:{}}s:37:\"admin/system/adminnotification/remove\";a:3:{s:8:\"instance\";r:594;s:6:\"parent\";r:180;s:8:\"children\";a:0:{}}s:18:\"admin/system/index\";a:3:{s:8:\"instance\";r:182;s:6:\"parent\";r:128;s:8:\"children\";a:0:{}}s:27:\"admin/system/order_statuses\";a:3:{s:8:\"instance\";r:184;s:6:\"parent\";r:128;s:8:\"children\";a:0:{}}s:16:\"admin/system/api\";a:3:{s:8:\"instance\";r:186;s:6:\"parent\";r:128;s:8:\"children\";a:7:{s:22:\"admin/system/api/users\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:22:\"admin/system/api/users\";}s:22:\"admin/system/api/roles\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:22:\"admin/system/api/roles\";}s:25:\"admin/system/api/consumer\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:25:\"admin/system/api/consumer\";}s:33:\"admin/system/api/authorizedTokens\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:33:\"admin/system/api/authorizedTokens\";}s:34:\"admin/system/api/oauth_admin_token\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:34:\"admin/system/api/oauth_admin_token\";}s:27:\"admin/system/api/rest_roles\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:27:\"admin/system/api/rest_roles\";}s:32:\"admin/system/api/rest_attributes\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:32:\"admin/system/api/rest_attributes\";}}}s:22:\"admin/system/api/users\";a:3:{s:8:\"instance\";r:624;s:6:\"parent\";r:186;s:8:\"children\";a:0:{}}s:22:\"admin/system/api/roles\";a:3:{s:8:\"instance\";r:626;s:6:\"parent\";r:186;s:8:\"children\";a:0:{}}s:25:\"admin/system/api/consumer\";a:3:{s:8:\"instance\";r:628;s:6:\"parent\";r:186;s:8:\"children\";a:2:{s:30:\"admin/system/api/consumer/edit\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:30:\"admin/system/api/consumer/edit\";}s:32:\"admin/system/api/consumer/delete\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:32:\"admin/system/api/consumer/delete\";}}}s:30:\"admin/system/api/consumer/edit\";a:3:{s:8:\"instance\";r:650;s:6:\"parent\";r:628;s:8:\"children\";a:0:{}}s:32:\"admin/system/api/consumer/delete\";a:3:{s:8:\"instance\";r:652;s:6:\"parent\";r:628;s:8:\"children\";a:0:{}}s:33:\"admin/system/api/authorizedTokens\";a:3:{s:8:\"instance\";r:630;s:6:\"parent\";r:186;s:8:\"children\";a:0:{}}s:34:\"admin/system/api/oauth_admin_token\";a:3:{s:8:\"instance\";r:632;s:6:\"parent\";r:186;s:8:\"children\";a:0:{}}s:27:\"admin/system/api/rest_roles\";a:3:{s:8:\"instance\";r:634;s:6:\"parent\";r:186;s:8:\"children\";a:3:{s:31:\"admin/system/api/rest_roles/add\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:31:\"admin/system/api/rest_roles/add\";}s:32:\"admin/system/api/rest_roles/edit\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:32:\"admin/system/api/rest_roles/edit\";}s:34:\"admin/system/api/rest_roles/delete\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:34:\"admin/system/api/rest_roles/delete\";}}}s:31:\"admin/system/api/rest_roles/add\";a:3:{s:8:\"instance\";r:674;s:6:\"parent\";r:634;s:8:\"children\";a:0:{}}s:32:\"admin/system/api/rest_roles/edit\";a:3:{s:8:\"instance\";r:676;s:6:\"parent\";r:634;s:8:\"children\";a:0:{}}s:34:\"admin/system/api/rest_roles/delete\";a:3:{s:8:\"instance\";r:678;s:6:\"parent\";r:634;s:8:\"children\";a:0:{}}s:32:\"admin/system/api/rest_attributes\";a:3:{s:8:\"instance\";r:636;s:6:\"parent\";r:186;s:8:\"children\";a:1:{s:37:\"admin/system/api/rest_attributes/edit\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:37:\"admin/system/api/rest_attributes/edit\";}}}s:37:\"admin/system/api/rest_attributes/edit\";a:3:{s:8:\"instance\";r:696;s:6:\"parent\";r:636;s:8:\"children\";a:0:{}}s:19:\"admin/global_search\";a:3:{s:8:\"instance\";r:130;s:6:\"parent\";r:122;s:8:\"children\";a:0:{}}s:9:\"admin/cms\";a:3:{s:8:\"instance\";r:132;s:6:\"parent\";r:122;s:8:\"children\";a:5:{s:15:\"admin/cms/block\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:15:\"admin/cms/block\";}s:14:\"admin/cms/page\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:14:\"admin/cms/page\";}s:23:\"admin/cms/media_gallery\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:23:\"admin/cms/media_gallery\";}s:14:\"admin/cms/poll\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:14:\"admin/cms/poll\";}s:25:\"admin/cms/widget_instance\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:25:\"admin/cms/widget_instance\";}}}s:15:\"admin/cms/block\";a:3:{s:8:\"instance\";r:710;s:6:\"parent\";r:132;s:8:\"children\";a:0:{}}s:14:\"admin/cms/page\";a:3:{s:8:\"instance\";r:712;s:6:\"parent\";r:132;s:8:\"children\";a:2:{s:19:\"admin/cms/page/save\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:19:\"admin/cms/page/save\";}s:21:\"admin/cms/page/delete\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:21:\"admin/cms/page/delete\";}}}s:19:\"admin/cms/page/save\";a:3:{s:8:\"instance\";r:728;s:6:\"parent\";r:712;s:8:\"children\";a:0:{}}s:21:\"admin/cms/page/delete\";a:3:{s:8:\"instance\";r:730;s:6:\"parent\";r:712;s:8:\"children\";a:0:{}}s:23:\"admin/cms/media_gallery\";a:3:{s:8:\"instance\";r:714;s:6:\"parent\";r:132;s:8:\"children\";a:0:{}}s:14:\"admin/cms/poll\";a:3:{s:8:\"instance\";r:716;s:6:\"parent\";r:132;s:8:\"children\";a:0:{}}s:25:\"admin/cms/widget_instance\";a:3:{s:8:\"instance\";r:718;s:6:\"parent\";r:132;s:8:\"children\";a:0:{}}s:14:\"admin/customer\";a:3:{s:8:\"instance\";r:134;s:6:\"parent\";r:122;s:8:\"children\";a:3:{s:20:\"admin/customer/group\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:20:\"admin/customer/group\";}s:21:\"admin/customer/manage\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:21:\"admin/customer/manage\";}s:21:\"admin/customer/online\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:21:\"admin/customer/online\";}}}s:20:\"admin/customer/group\";a:3:{s:8:\"instance\";r:756;s:6:\"parent\";r:134;s:8:\"children\";a:0:{}}s:21:\"admin/customer/manage\";a:3:{s:8:\"instance\";r:758;s:6:\"parent\";r:134;s:8:\"children\";a:0:{}}s:21:\"admin/customer/online\";a:3:{s:8:\"instance\";r:760;s:6:\"parent\";r:134;s:8:\"children\";a:0:{}}s:13:\"admin/catalog\";a:3:{s:8:\"instance\";r:136;s:6:\"parent\";r:122;s:8:\"children\";a:9:{s:24:\"admin/catalog/attributes\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:24:\"admin/catalog/attributes\";}s:24:\"admin/catalog/categories\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:24:\"admin/catalog/categories\";}s:22:\"admin/catalog/products\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:22:\"admin/catalog/products\";}s:31:\"admin/catalog/update_attributes\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:31:\"admin/catalog/update_attributes\";}s:24:\"admin/catalog/urlrewrite\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:24:\"admin/catalog/urlrewrite\";}s:20:\"admin/catalog/search\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:20:\"admin/catalog/search\";}s:29:\"admin/catalog/reviews_ratings\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:29:\"admin/catalog/reviews_ratings\";}s:17:\"admin/catalog/tag\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:17:\"admin/catalog/tag\";}s:21:\"admin/catalog/sitemap\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:21:\"admin/catalog/sitemap\";}}}s:24:\"admin/catalog/attributes\";a:3:{s:8:\"instance\";r:778;s:6:\"parent\";r:136;s:8:\"children\";a:2:{s:35:\"admin/catalog/attributes/attributes\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:35:\"admin/catalog/attributes/attributes\";}s:29:\"admin/catalog/attributes/sets\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:29:\"admin/catalog/attributes/sets\";}}}s:35:\"admin/catalog/attributes/attributes\";a:3:{s:8:\"instance\";r:800;s:6:\"parent\";r:778;s:8:\"children\";a:0:{}}s:29:\"admin/catalog/attributes/sets\";a:3:{s:8:\"instance\";r:802;s:6:\"parent\";r:778;s:8:\"children\";a:0:{}}s:24:\"admin/catalog/categories\";a:3:{s:8:\"instance\";r:780;s:6:\"parent\";r:136;s:8:\"children\";a:0:{}}s:22:\"admin/catalog/products\";a:3:{s:8:\"instance\";r:782;s:6:\"parent\";r:136;s:8:\"children\";a:0:{}}s:31:\"admin/catalog/update_attributes\";a:3:{s:8:\"instance\";r:784;s:6:\"parent\";r:136;s:8:\"children\";a:0:{}}s:24:\"admin/catalog/urlrewrite\";a:3:{s:8:\"instance\";r:786;s:6:\"parent\";r:136;s:8:\"children\";a:0:{}}s:20:\"admin/catalog/search\";a:3:{s:8:\"instance\";r:788;s:6:\"parent\";r:136;s:8:\"children\";a:0:{}}s:29:\"admin/catalog/reviews_ratings\";a:3:{s:8:\"instance\";r:790;s:6:\"parent\";r:136;s:8:\"children\";a:2:{s:37:\"admin/catalog/reviews_ratings/reviews\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:37:\"admin/catalog/reviews_ratings/reviews\";}s:37:\"admin/catalog/reviews_ratings/ratings\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:37:\"admin/catalog/reviews_ratings/ratings\";}}}s:37:\"admin/catalog/reviews_ratings/reviews\";a:3:{s:8:\"instance\";r:836;s:6:\"parent\";r:790;s:8:\"children\";a:2:{s:41:\"admin/catalog/reviews_ratings/reviews/all\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:41:\"admin/catalog/reviews_ratings/reviews/all\";}s:45:\"admin/catalog/reviews_ratings/reviews/pending\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:45:\"admin/catalog/reviews_ratings/reviews/pending\";}}}s:41:\"admin/catalog/reviews_ratings/reviews/all\";a:3:{s:8:\"instance\";r:844;s:6:\"parent\";r:836;s:8:\"children\";a:0:{}}s:45:\"admin/catalog/reviews_ratings/reviews/pending\";a:3:{s:8:\"instance\";r:846;s:6:\"parent\";r:836;s:8:\"children\";a:0:{}}s:37:\"admin/catalog/reviews_ratings/ratings\";a:3:{s:8:\"instance\";r:838;s:6:\"parent\";r:790;s:8:\"children\";a:0:{}}s:17:\"admin/catalog/tag\";a:3:{s:8:\"instance\";r:792;s:6:\"parent\";r:136;s:8:\"children\";a:2:{s:21:\"admin/catalog/tag/all\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:21:\"admin/catalog/tag/all\";}s:25:\"admin/catalog/tag/pending\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:25:\"admin/catalog/tag/pending\";}}}s:21:\"admin/catalog/tag/all\";a:3:{s:8:\"instance\";r:864;s:6:\"parent\";r:792;s:8:\"children\";a:0:{}}s:25:\"admin/catalog/tag/pending\";a:3:{s:8:\"instance\";r:866;s:6:\"parent\";r:792;s:8:\"children\";a:0:{}}s:21:\"admin/catalog/sitemap\";a:3:{s:8:\"instance\";r:794;s:6:\"parent\";r:136;s:8:\"children\";a:0:{}}s:11:\"admin/promo\";a:3:{s:8:\"instance\";r:138;s:6:\"parent\";r:122;s:8:\"children\";a:2:{s:19:\"admin/promo/catalog\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:19:\"admin/promo/catalog\";}s:17:\"admin/promo/quote\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:17:\"admin/promo/quote\";}}}s:19:\"admin/promo/catalog\";a:3:{s:8:\"instance\";r:884;s:6:\"parent\";r:138;s:8:\"children\";a:0:{}}s:17:\"admin/promo/quote\";a:3:{s:8:\"instance\";r:886;s:6:\"parent\";r:138;s:8:\"children\";a:0:{}}s:11:\"admin/sales\";a:3:{s:8:\"instance\";r:140;s:6:\"parent\";r:122;s:8:\"children\";a:9:{s:17:\"admin/sales/order\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:17:\"admin/sales/order\";}s:19:\"admin/sales/invoice\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:19:\"admin/sales/invoice\";}s:20:\"admin/sales/shipment\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:20:\"admin/sales/shipment\";}s:22:\"admin/sales/creditmemo\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:22:\"admin/sales/creditmemo\";}s:24:\"admin/sales/transactions\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:24:\"admin/sales/transactions\";}s:29:\"admin/sales/recurring_profile\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:29:\"admin/sales/recurring_profile\";}s:29:\"admin/sales/billing_agreement\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:29:\"admin/sales/billing_agreement\";}s:29:\"admin/sales/checkoutagreement\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:29:\"admin/sales/checkoutagreement\";}s:15:\"admin/sales/tax\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:15:\"admin/sales/tax\";}}}s:17:\"admin/sales/order\";a:3:{s:8:\"instance\";r:900;s:6:\"parent\";r:140;s:8:\"children\";a:1:{s:25:\"admin/sales/order/actions\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:25:\"admin/sales/order/actions\";}}}s:25:\"admin/sales/order/actions\";a:3:{s:8:\"instance\";r:922;s:6:\"parent\";r:900;s:8:\"children\";a:15:{s:32:\"admin/sales/order/actions/create\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:32:\"admin/sales/order/actions/create\";}s:30:\"admin/sales/order/actions/view\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:30:\"admin/sales/order/actions/view\";}s:31:\"admin/sales/order/actions/email\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:31:\"admin/sales/order/actions/email\";}s:33:\"admin/sales/order/actions/reorder\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:33:\"admin/sales/order/actions/reorder\";}s:30:\"admin/sales/order/actions/edit\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:30:\"admin/sales/order/actions/edit\";}s:32:\"admin/sales/order/actions/cancel\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:32:\"admin/sales/order/actions/cancel\";}s:40:\"admin/sales/order/actions/review_payment\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:40:\"admin/sales/order/actions/review_payment\";}s:33:\"admin/sales/order/actions/capture\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:33:\"admin/sales/order/actions/capture\";}s:33:\"admin/sales/order/actions/invoice\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:33:\"admin/sales/order/actions/invoice\";}s:36:\"admin/sales/order/actions/creditmemo\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:36:\"admin/sales/order/actions/creditmemo\";}s:30:\"admin/sales/order/actions/hold\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:30:\"admin/sales/order/actions/hold\";}s:32:\"admin/sales/order/actions/unhold\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:32:\"admin/sales/order/actions/unhold\";}s:30:\"admin/sales/order/actions/ship\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:30:\"admin/sales/order/actions/ship\";}s:33:\"admin/sales/order/actions/comment\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:33:\"admin/sales/order/actions/comment\";}s:32:\"admin/sales/order/actions/emails\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:32:\"admin/sales/order/actions/emails\";}}}s:32:\"admin/sales/order/actions/create\";a:3:{s:8:\"instance\";r:928;s:6:\"parent\";r:922;s:8:\"children\";a:0:{}}s:30:\"admin/sales/order/actions/view\";a:3:{s:8:\"instance\";r:930;s:6:\"parent\";r:922;s:8:\"children\";a:0:{}}s:31:\"admin/sales/order/actions/email\";a:3:{s:8:\"instance\";r:932;s:6:\"parent\";r:922;s:8:\"children\";a:0:{}}s:33:\"admin/sales/order/actions/reorder\";a:3:{s:8:\"instance\";r:934;s:6:\"parent\";r:922;s:8:\"children\";a:0:{}}s:30:\"admin/sales/order/actions/edit\";a:3:{s:8:\"instance\";r:936;s:6:\"parent\";r:922;s:8:\"children\";a:0:{}}s:32:\"admin/sales/order/actions/cancel\";a:3:{s:8:\"instance\";r:938;s:6:\"parent\";r:922;s:8:\"children\";a:0:{}}s:40:\"admin/sales/order/actions/review_payment\";a:3:{s:8:\"instance\";r:940;s:6:\"parent\";r:922;s:8:\"children\";a:0:{}}s:33:\"admin/sales/order/actions/capture\";a:3:{s:8:\"instance\";r:942;s:6:\"parent\";r:922;s:8:\"children\";a:0:{}}s:33:\"admin/sales/order/actions/invoice\";a:3:{s:8:\"instance\";r:944;s:6:\"parent\";r:922;s:8:\"children\";a:0:{}}s:36:\"admin/sales/order/actions/creditmemo\";a:3:{s:8:\"instance\";r:946;s:6:\"parent\";r:922;s:8:\"children\";a:0:{}}s:30:\"admin/sales/order/actions/hold\";a:3:{s:8:\"instance\";r:948;s:6:\"parent\";r:922;s:8:\"children\";a:0:{}}s:32:\"admin/sales/order/actions/unhold\";a:3:{s:8:\"instance\";r:950;s:6:\"parent\";r:922;s:8:\"children\";a:0:{}}s:30:\"admin/sales/order/actions/ship\";a:3:{s:8:\"instance\";r:952;s:6:\"parent\";r:922;s:8:\"children\";a:0:{}}s:33:\"admin/sales/order/actions/comment\";a:3:{s:8:\"instance\";r:954;s:6:\"parent\";r:922;s:8:\"children\";a:0:{}}s:32:\"admin/sales/order/actions/emails\";a:3:{s:8:\"instance\";r:956;s:6:\"parent\";r:922;s:8:\"children\";a:0:{}}s:19:\"admin/sales/invoice\";a:3:{s:8:\"instance\";r:902;s:6:\"parent\";r:140;s:8:\"children\";a:0:{}}s:20:\"admin/sales/shipment\";a:3:{s:8:\"instance\";r:904;s:6:\"parent\";r:140;s:8:\"children\";a:0:{}}s:22:\"admin/sales/creditmemo\";a:3:{s:8:\"instance\";r:906;s:6:\"parent\";r:140;s:8:\"children\";a:0:{}}s:24:\"admin/sales/transactions\";a:3:{s:8:\"instance\";r:908;s:6:\"parent\";r:140;s:8:\"children\";a:1:{s:30:\"admin/sales/transactions/fetch\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:30:\"admin/sales/transactions/fetch\";}}}s:30:\"admin/sales/transactions/fetch\";a:3:{s:8:\"instance\";r:1034;s:6:\"parent\";r:908;s:8:\"children\";a:0:{}}s:29:\"admin/sales/recurring_profile\";a:3:{s:8:\"instance\";r:910;s:6:\"parent\";r:140;s:8:\"children\";a:0:{}}s:29:\"admin/sales/billing_agreement\";a:3:{s:8:\"instance\";r:912;s:6:\"parent\";r:140;s:8:\"children\";a:1:{s:37:\"admin/sales/billing_agreement/actions\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:37:\"admin/sales/billing_agreement/actions\";}}}s:37:\"admin/sales/billing_agreement/actions\";a:3:{s:8:\"instance\";r:1048;s:6:\"parent\";r:912;s:8:\"children\";a:3:{s:42:\"admin/sales/billing_agreement/actions/view\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:42:\"admin/sales/billing_agreement/actions/view\";}s:44:\"admin/sales/billing_agreement/actions/manage\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:44:\"admin/sales/billing_agreement/actions/manage\";}s:41:\"admin/sales/billing_agreement/actions/use\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:41:\"admin/sales/billing_agreement/actions/use\";}}}s:42:\"admin/sales/billing_agreement/actions/view\";a:3:{s:8:\"instance\";r:1054;s:6:\"parent\";r:1048;s:8:\"children\";a:0:{}}s:44:\"admin/sales/billing_agreement/actions/manage\";a:3:{s:8:\"instance\";r:1056;s:6:\"parent\";r:1048;s:8:\"children\";a:0:{}}s:41:\"admin/sales/billing_agreement/actions/use\";a:3:{s:8:\"instance\";r:1058;s:6:\"parent\";r:1048;s:8:\"children\";a:0:{}}s:29:\"admin/sales/checkoutagreement\";a:3:{s:8:\"instance\";r:914;s:6:\"parent\";r:140;s:8:\"children\";a:0:{}}s:15:\"admin/sales/tax\";a:3:{s:8:\"instance\";r:916;s:6:\"parent\";r:140;s:8:\"children\";a:5:{s:32:\"admin/sales/tax/classes_customer\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:32:\"admin/sales/tax/classes_customer\";}s:31:\"admin/sales/tax/classes_product\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:31:\"admin/sales/tax/classes_product\";}s:29:\"admin/sales/tax/import_export\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:29:\"admin/sales/tax/import_export\";}s:21:\"admin/sales/tax/rates\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:21:\"admin/sales/tax/rates\";}s:21:\"admin/sales/tax/rules\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:21:\"admin/sales/tax/rules\";}}}s:32:\"admin/sales/tax/classes_customer\";a:3:{s:8:\"instance\";r:1080;s:6:\"parent\";r:916;s:8:\"children\";a:0:{}}s:31:\"admin/sales/tax/classes_product\";a:3:{s:8:\"instance\";r:1082;s:6:\"parent\";r:916;s:8:\"children\";a:0:{}}s:29:\"admin/sales/tax/import_export\";a:3:{s:8:\"instance\";r:1084;s:6:\"parent\";r:916;s:8:\"children\";a:0:{}}s:21:\"admin/sales/tax/rates\";a:3:{s:8:\"instance\";r:1086;s:6:\"parent\";r:916;s:8:\"children\";a:0:{}}s:21:\"admin/sales/tax/rules\";a:3:{s:8:\"instance\";r:1088;s:6:\"parent\";r:916;s:8:\"children\";a:0:{}}s:12:\"admin/report\";a:3:{s:8:\"instance\";r:142;s:6:\"parent\";r:122;s:8:\"children\";a:8:{s:22:\"admin/report/salesroot\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:22:\"admin/report/salesroot\";}s:21:\"admin/report/shopcart\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:21:\"admin/report/shopcart\";}s:21:\"admin/report/products\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:21:\"admin/report/products\";}s:22:\"admin/report/customers\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:22:\"admin/report/customers\";}s:19:\"admin/report/review\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:19:\"admin/report/review\";}s:17:\"admin/report/tags\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:17:\"admin/report/tags\";}s:19:\"admin/report/search\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:19:\"admin/report/search\";}s:23:\"admin/report/statistics\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:23:\"admin/report/statistics\";}}}s:22:\"admin/report/salesroot\";a:3:{s:8:\"instance\";r:1114;s:6:\"parent\";r:142;s:8:\"children\";a:7:{s:48:\"admin/report/salesroot/paypal_settlement_reports\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:48:\"admin/report/salesroot/paypal_settlement_reports\";}s:28:\"admin/report/salesroot/sales\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:28:\"admin/report/salesroot/sales\";}s:26:\"admin/report/salesroot/tax\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:26:\"admin/report/salesroot/tax\";}s:31:\"admin/report/salesroot/shipping\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:31:\"admin/report/salesroot/shipping\";}s:31:\"admin/report/salesroot/invoiced\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:31:\"admin/report/salesroot/invoiced\";}s:31:\"admin/report/salesroot/refunded\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:31:\"admin/report/salesroot/refunded\";}s:30:\"admin/report/salesroot/coupons\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:30:\"admin/report/salesroot/coupons\";}}}s:48:\"admin/report/salesroot/paypal_settlement_reports\";a:3:{s:8:\"instance\";r:1134;s:6:\"parent\";r:1114;s:8:\"children\";a:2:{s:53:\"admin/report/salesroot/paypal_settlement_reports/view\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:53:\"admin/report/salesroot/paypal_settlement_reports/view\";}s:54:\"admin/report/salesroot/paypal_settlement_reports/fetch\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:54:\"admin/report/salesroot/paypal_settlement_reports/fetch\";}}}s:53:\"admin/report/salesroot/paypal_settlement_reports/view\";a:3:{s:8:\"instance\";r:1152;s:6:\"parent\";r:1134;s:8:\"children\";a:0:{}}s:54:\"admin/report/salesroot/paypal_settlement_reports/fetch\";a:3:{s:8:\"instance\";r:1154;s:6:\"parent\";r:1134;s:8:\"children\";a:0:{}}s:28:\"admin/report/salesroot/sales\";a:3:{s:8:\"instance\";r:1136;s:6:\"parent\";r:1114;s:8:\"children\";a:0:{}}s:26:\"admin/report/salesroot/tax\";a:3:{s:8:\"instance\";r:1138;s:6:\"parent\";r:1114;s:8:\"children\";a:0:{}}s:31:\"admin/report/salesroot/shipping\";a:3:{s:8:\"instance\";r:1140;s:6:\"parent\";r:1114;s:8:\"children\";a:0:{}}s:31:\"admin/report/salesroot/invoiced\";a:3:{s:8:\"instance\";r:1142;s:6:\"parent\";r:1114;s:8:\"children\";a:0:{}}s:31:\"admin/report/salesroot/refunded\";a:3:{s:8:\"instance\";r:1144;s:6:\"parent\";r:1114;s:8:\"children\";a:0:{}}s:30:\"admin/report/salesroot/coupons\";a:3:{s:8:\"instance\";r:1146;s:6:\"parent\";r:1114;s:8:\"children\";a:0:{}}s:21:\"admin/report/shopcart\";a:3:{s:8:\"instance\";r:1116;s:6:\"parent\";r:142;s:8:\"children\";a:2:{s:29:\"admin/report/shopcart/product\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:29:\"admin/report/shopcart/product\";}s:31:\"admin/report/shopcart/abandoned\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:31:\"admin/report/shopcart/abandoned\";}}}s:29:\"admin/report/shopcart/product\";a:3:{s:8:\"instance\";r:1192;s:6:\"parent\";r:1116;s:8:\"children\";a:0:{}}s:31:\"admin/report/shopcart/abandoned\";a:3:{s:8:\"instance\";r:1194;s:6:\"parent\";r:1116;s:8:\"children\";a:0:{}}s:21:\"admin/report/products\";a:3:{s:8:\"instance\";r:1118;s:6:\"parent\";r:142;s:8:\"children\";a:5:{s:33:\"admin/report/products/bestsellers\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:33:\"admin/report/products/bestsellers\";}s:26:\"admin/report/products/sold\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:26:\"admin/report/products/sold\";}s:28:\"admin/report/products/viewed\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:28:\"admin/report/products/viewed\";}s:30:\"admin/report/products/lowstock\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:30:\"admin/report/products/lowstock\";}s:31:\"admin/report/products/downloads\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:31:\"admin/report/products/downloads\";}}}s:33:\"admin/report/products/bestsellers\";a:3:{s:8:\"instance\";r:1208;s:6:\"parent\";r:1118;s:8:\"children\";a:0:{}}s:26:\"admin/report/products/sold\";a:3:{s:8:\"instance\";r:1210;s:6:\"parent\";r:1118;s:8:\"children\";a:0:{}}s:28:\"admin/report/products/viewed\";a:3:{s:8:\"instance\";r:1212;s:6:\"parent\";r:1118;s:8:\"children\";a:0:{}}s:30:\"admin/report/products/lowstock\";a:3:{s:8:\"instance\";r:1214;s:6:\"parent\";r:1118;s:8:\"children\";a:0:{}}s:31:\"admin/report/products/downloads\";a:3:{s:8:\"instance\";r:1216;s:6:\"parent\";r:1118;s:8:\"children\";a:0:{}}s:22:\"admin/report/customers\";a:3:{s:8:\"instance\";r:1120;s:6:\"parent\";r:142;s:8:\"children\";a:3:{s:31:\"admin/report/customers/accounts\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:31:\"admin/report/customers/accounts\";}s:29:\"admin/report/customers/totals\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:29:\"admin/report/customers/totals\";}s:29:\"admin/report/customers/orders\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:29:\"admin/report/customers/orders\";}}}s:31:\"admin/report/customers/accounts\";a:3:{s:8:\"instance\";r:1242;s:6:\"parent\";r:1120;s:8:\"children\";a:0:{}}s:29:\"admin/report/customers/totals\";a:3:{s:8:\"instance\";r:1244;s:6:\"parent\";r:1120;s:8:\"children\";a:0:{}}s:29:\"admin/report/customers/orders\";a:3:{s:8:\"instance\";r:1246;s:6:\"parent\";r:1120;s:8:\"children\";a:0:{}}s:19:\"admin/report/review\";a:3:{s:8:\"instance\";r:1122;s:6:\"parent\";r:142;s:8:\"children\";a:2:{s:28:\"admin/report/review/customer\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:28:\"admin/report/review/customer\";}s:27:\"admin/report/review/product\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:27:\"admin/report/review/product\";}}}s:28:\"admin/report/review/customer\";a:3:{s:8:\"instance\";r:1264;s:6:\"parent\";r:1122;s:8:\"children\";a:0:{}}s:27:\"admin/report/review/product\";a:3:{s:8:\"instance\";r:1266;s:6:\"parent\";r:1122;s:8:\"children\";a:0:{}}s:17:\"admin/report/tags\";a:3:{s:8:\"instance\";r:1124;s:6:\"parent\";r:142;s:8:\"children\";a:3:{s:26:\"admin/report/tags/customer\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:26:\"admin/report/tags/customer\";}s:25:\"admin/report/tags/popular\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:25:\"admin/report/tags/popular\";}s:25:\"admin/report/tags/product\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:25:\"admin/report/tags/product\";}}}s:26:\"admin/report/tags/customer\";a:3:{s:8:\"instance\";r:1280;s:6:\"parent\";r:1124;s:8:\"children\";a:0:{}}s:25:\"admin/report/tags/popular\";a:3:{s:8:\"instance\";r:1282;s:6:\"parent\";r:1124;s:8:\"children\";a:0:{}}s:25:\"admin/report/tags/product\";a:3:{s:8:\"instance\";r:1284;s:6:\"parent\";r:1124;s:8:\"children\";a:0:{}}s:19:\"admin/report/search\";a:3:{s:8:\"instance\";r:1126;s:6:\"parent\";r:142;s:8:\"children\";a:0:{}}s:23:\"admin/report/statistics\";a:3:{s:8:\"instance\";r:1128;s:6:\"parent\";r:142;s:8:\"children\";a:0:{}}s:16:\"admin/newsletter\";a:3:{s:8:\"instance\";r:144;s:6:\"parent\";r:122;s:8:\"children\";a:4:{s:24:\"admin/newsletter/problem\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:24:\"admin/newsletter/problem\";}s:22:\"admin/newsletter/queue\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:22:\"admin/newsletter/queue\";}s:27:\"admin/newsletter/subscriber\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:27:\"admin/newsletter/subscriber\";}s:25:\"admin/newsletter/template\";O:29:\"Mage_Admin_Model_Acl_Resource\":1:{s:14:\"\0*\0_resourceId\";s:25:\"admin/newsletter/template\";}}}s:24:\"admin/newsletter/problem\";a:3:{s:8:\"instance\";r:1310;s:6:\"parent\";r:144;s:8:\"children\";a:0:{}}s:22:\"admin/newsletter/queue\";a:3:{s:8:\"instance\";r:1312;s:6:\"parent\";r:144;s:8:\"children\";a:0:{}}s:27:\"admin/newsletter/subscriber\";a:3:{s:8:\"instance\";r:1314;s:6:\"parent\";r:144;s:8:\"children\";a:0:{}}s:25:\"admin/newsletter/template\";a:3:{s:8:\"instance\";r:1316;s:6:\"parent\";r:144;s:8:\"children\";a:0:{}}s:16:\"admin/page_cache\";a:3:{s:8:\"instance\";r:146;s:6:\"parent\";r:122;s:8:\"children\";a:0:{}}}s:17:\"\0*\0_isAllowedRole\";r:108;s:21:\"\0*\0_isAllowedResource\";r:158;s:22:\"\0*\0_isAllowedPrivilege\";N;s:9:\"\0*\0_rules\";a:2:{s:12:\"allResources\";a:2:{s:8:\"allRoles\";a:2:{s:13:\"allPrivileges\";a:2:{s:4:\"type\";s:9:\"TYPE_DENY\";s:6:\"assert\";N;}s:13:\"byPrivilegeId\";a:0:{}}s:8:\"byRoleId\";a:1:{s:2:\"G1\";a:2:{s:13:\"byPrivilegeId\";a:0:{}s:13:\"allPrivileges\";a:2:{s:4:\"type\";s:10:\"TYPE_ALLOW\";s:6:\"assert\";N;}}}}s:12:\"byResourceId\";a:1:{s:3:\"all\";a:1:{s:8:\"byRoleId\";a:1:{s:2:\"G1\";a:2:{s:13:\"byPrivilegeId\";a:0:{}s:13:\"allPrivileges\";a:2:{s:4:\"type\";s:10:\"TYPE_ALLOW\";s:6:\"assert\";N;}}}}}}}}');
/*!40000 ALTER TABLE `mag_core_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_core_store`
--

DROP TABLE IF EXISTS `mag_core_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_core_store` (
  `store_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Store Id',
  `code` varchar(32) DEFAULT NULL COMMENT 'Code',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Group Id',
  `name` varchar(255) NOT NULL COMMENT 'Store Name',
  `sort_order` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Sort Order',
  `is_active` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Activity',
  PRIMARY KEY (`store_id`),
  UNIQUE KEY `UNQ_MAG_CORE_STORE_CODE` (`code`),
  KEY `IDX_MAG_CORE_STORE_WEBSITE_ID` (`website_id`),
  KEY `IDX_MAG_CORE_STORE_IS_ACTIVE_SORT_ORDER` (`is_active`,`sort_order`),
  KEY `IDX_MAG_CORE_STORE_GROUP_ID` (`group_id`),
  CONSTRAINT `FK_MAG_CORE_STORE_GROUP_ID_MAG_CORE_STORE_GROUP_GROUP_ID` FOREIGN KEY (`group_id`) REFERENCES `mag_core_store_group` (`group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CORE_STORE_WEBSITE_ID_MAG_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `mag_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Stores';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_core_store`
--

LOCK TABLES `mag_core_store` WRITE;
/*!40000 ALTER TABLE `mag_core_store` DISABLE KEYS */;
INSERT INTO `mag_core_store` VALUES (0,'admin',0,0,'Admin',0,1),(1,'default',1,1,'Default Store View',0,1);
/*!40000 ALTER TABLE `mag_core_store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_core_store_group`
--

DROP TABLE IF EXISTS `mag_core_store_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_core_store_group` (
  `group_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Group Id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `name` varchar(255) NOT NULL COMMENT 'Store Group Name',
  `root_category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Root Category Id',
  `default_store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Default Store Id',
  PRIMARY KEY (`group_id`),
  KEY `IDX_MAG_CORE_STORE_GROUP_WEBSITE_ID` (`website_id`),
  KEY `IDX_MAG_CORE_STORE_GROUP_DEFAULT_STORE_ID` (`default_store_id`),
  CONSTRAINT `FK_MAG_CORE_STORE_GROUP_WEBSITE_ID_MAG_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `mag_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Store Groups';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_core_store_group`
--

LOCK TABLES `mag_core_store_group` WRITE;
/*!40000 ALTER TABLE `mag_core_store_group` DISABLE KEYS */;
INSERT INTO `mag_core_store_group` VALUES (0,0,'Default',0,0),(1,1,'Main Website Store',2,1);
/*!40000 ALTER TABLE `mag_core_store_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_core_translate`
--

DROP TABLE IF EXISTS `mag_core_translate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_core_translate` (
  `key_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Key Id of Translation',
  `string` varchar(255) NOT NULL DEFAULT 'Translate String' COMMENT 'Translation String',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `translate` varchar(255) DEFAULT NULL COMMENT 'Translate',
  `locale` varchar(20) NOT NULL DEFAULT 'en_US' COMMENT 'Locale',
  `crc_string` bigint(20) NOT NULL DEFAULT '1591228201' COMMENT 'Translation String CRC32 Hash',
  PRIMARY KEY (`key_id`),
  UNIQUE KEY `UNQ_MAG_CORE_TRANSLATE_STORE_ID_LOCALE_CRC_STRING_STRING` (`store_id`,`locale`,`crc_string`,`string`),
  KEY `IDX_MAG_CORE_TRANSLATE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MAG_CORE_TRANSLATE_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Translations';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_core_translate`
--

LOCK TABLES `mag_core_translate` WRITE;
/*!40000 ALTER TABLE `mag_core_translate` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_core_translate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_core_url_rewrite`
--

DROP TABLE IF EXISTS `mag_core_url_rewrite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_core_url_rewrite` (
  `url_rewrite_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rewrite Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `id_path` varchar(255) DEFAULT NULL COMMENT 'Id Path',
  `request_path` varchar(255) DEFAULT NULL COMMENT 'Request Path',
  `target_path` varchar(255) DEFAULT NULL COMMENT 'Target Path',
  `is_system` smallint(5) unsigned DEFAULT '1' COMMENT 'Defines is Rewrite System',
  `options` varchar(255) DEFAULT NULL COMMENT 'Options',
  `description` varchar(255) DEFAULT NULL COMMENT 'Deascription',
  `category_id` int(10) unsigned DEFAULT NULL COMMENT 'Category Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  PRIMARY KEY (`url_rewrite_id`),
  UNIQUE KEY `UNQ_MAG_CORE_URL_REWRITE_REQUEST_PATH_STORE_ID` (`request_path`,`store_id`),
  UNIQUE KEY `UNQ_MAG_CORE_URL_REWRITE_ID_PATH_IS_SYSTEM_STORE_ID` (`id_path`,`is_system`,`store_id`),
  KEY `IDX_MAG_CORE_URL_REWRITE_TARGET_PATH_STORE_ID` (`target_path`,`store_id`),
  KEY `IDX_MAG_CORE_URL_REWRITE_ID_PATH` (`id_path`),
  KEY `IDX_MAG_CORE_URL_REWRITE_STORE_ID` (`store_id`),
  KEY `FK_MAG_CORE_URL_REWRITE_CTGR_ID_MAG_CAT_CTGR_ENTT_ENTT_ID` (`category_id`),
  KEY `FK_MAG_CORE_URL_REWRITE_PRD_ID_MAG_CAT_CTGR_ENTT_ENTT_ID` (`product_id`),
  CONSTRAINT `FK_MAG_CORE_URL_REWRITE_CTGR_ID_MAG_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`category_id`) REFERENCES `mag_catalog_category_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CORE_URL_REWRITE_PRD_ID_MAG_CAT_CTGR_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CORE_URL_REWRITE_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Url Rewrites';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_core_url_rewrite`
--

LOCK TABLES `mag_core_url_rewrite` WRITE;
/*!40000 ALTER TABLE `mag_core_url_rewrite` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_core_url_rewrite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_core_variable`
--

DROP TABLE IF EXISTS `mag_core_variable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_core_variable` (
  `variable_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Variable Id',
  `code` varchar(255) DEFAULT NULL COMMENT 'Variable Code',
  `name` varchar(255) DEFAULT NULL COMMENT 'Variable Name',
  PRIMARY KEY (`variable_id`),
  UNIQUE KEY `UNQ_MAG_CORE_VARIABLE_CODE` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Variables';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_core_variable`
--

LOCK TABLES `mag_core_variable` WRITE;
/*!40000 ALTER TABLE `mag_core_variable` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_core_variable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_core_variable_value`
--

DROP TABLE IF EXISTS `mag_core_variable_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_core_variable_value` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Variable Value Id',
  `variable_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Variable Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `plain_value` text COMMENT 'Plain Text Value',
  `html_value` text COMMENT 'Html Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MAG_CORE_VARIABLE_VALUE_VARIABLE_ID_STORE_ID` (`variable_id`,`store_id`),
  KEY `IDX_MAG_CORE_VARIABLE_VALUE_VARIABLE_ID` (`variable_id`),
  KEY `IDX_MAG_CORE_VARIABLE_VALUE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_097E8BAA630EA4B7A96FEC750769C456` FOREIGN KEY (`variable_id`) REFERENCES `mag_core_variable` (`variable_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CORE_VARIABLE_VALUE_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Variable Value';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_core_variable_value`
--

LOCK TABLES `mag_core_variable_value` WRITE;
/*!40000 ALTER TABLE `mag_core_variable_value` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_core_variable_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_core_website`
--

DROP TABLE IF EXISTS `mag_core_website`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_core_website` (
  `website_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Website Id',
  `code` varchar(32) DEFAULT NULL COMMENT 'Code',
  `name` varchar(64) DEFAULT NULL COMMENT 'Website Name',
  `sort_order` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `default_group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Default Group Id',
  `is_default` smallint(5) unsigned DEFAULT '0' COMMENT 'Defines Is Website Default',
  PRIMARY KEY (`website_id`),
  UNIQUE KEY `UNQ_MAG_CORE_WEBSITE_CODE` (`code`),
  KEY `IDX_MAG_CORE_WEBSITE_SORT_ORDER` (`sort_order`),
  KEY `IDX_MAG_CORE_WEBSITE_DEFAULT_GROUP_ID` (`default_group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Websites';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_core_website`
--

LOCK TABLES `mag_core_website` WRITE;
/*!40000 ALTER TABLE `mag_core_website` DISABLE KEYS */;
INSERT INTO `mag_core_website` VALUES (0,'admin','Admin',0,0,0),(1,'base','Main Website',0,1,1);
/*!40000 ALTER TABLE `mag_core_website` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_coupon_aggregated`
--

DROP TABLE IF EXISTS `mag_coupon_aggregated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_coupon_aggregated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date NOT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `coupon_code` varchar(50) DEFAULT NULL COMMENT 'Coupon Code',
  `coupon_uses` int(11) NOT NULL DEFAULT '0' COMMENT 'Coupon Uses',
  `subtotal_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal Amount',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount',
  `total_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Amount',
  `subtotal_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal Amount Actual',
  `discount_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount Actual',
  `total_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Amount Actual',
  `rule_name` varchar(255) DEFAULT NULL COMMENT 'Rule Name',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_MAG_COUPON_AGGRED_PERIOD_STORE_ID_ORDER_STS_COUPON_CODE` (`period`,`store_id`,`order_status`,`coupon_code`),
  KEY `IDX_MAG_COUPON_AGGREGATED_STORE_ID` (`store_id`),
  KEY `IDX_MAG_COUPON_AGGREGATED_RULE_NAME` (`rule_name`),
  CONSTRAINT `FK_MAG_COUPON_AGGREGATED_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Coupon Aggregated';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_coupon_aggregated`
--

LOCK TABLES `mag_coupon_aggregated` WRITE;
/*!40000 ALTER TABLE `mag_coupon_aggregated` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_coupon_aggregated` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_coupon_aggregated_order`
--

DROP TABLE IF EXISTS `mag_coupon_aggregated_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_coupon_aggregated_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date NOT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `coupon_code` varchar(50) DEFAULT NULL COMMENT 'Coupon Code',
  `coupon_uses` int(11) NOT NULL DEFAULT '0' COMMENT 'Coupon Uses',
  `subtotal_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal Amount',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount',
  `total_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Amount',
  `rule_name` varchar(255) DEFAULT NULL COMMENT 'Rule Name',
  PRIMARY KEY (`id`),
  UNIQUE KEY `B5549031191AF89452F240E8575FDD63` (`period`,`store_id`,`order_status`,`coupon_code`),
  KEY `IDX_MAG_COUPON_AGGREGATED_ORDER_STORE_ID` (`store_id`),
  KEY `IDX_MAG_COUPON_AGGREGATED_ORDER_RULE_NAME` (`rule_name`),
  CONSTRAINT `FK_MAG_COUPON_AGGREGATED_ORDER_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Coupon Aggregated Order';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_coupon_aggregated_order`
--

LOCK TABLES `mag_coupon_aggregated_order` WRITE;
/*!40000 ALTER TABLE `mag_coupon_aggregated_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_coupon_aggregated_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_coupon_aggregated_updated`
--

DROP TABLE IF EXISTS `mag_coupon_aggregated_updated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_coupon_aggregated_updated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date NOT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `coupon_code` varchar(50) DEFAULT NULL COMMENT 'Coupon Code',
  `coupon_uses` int(11) NOT NULL DEFAULT '0' COMMENT 'Coupon Uses',
  `subtotal_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal Amount',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount',
  `total_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Amount',
  `subtotal_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal Amount Actual',
  `discount_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount Actual',
  `total_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Amount Actual',
  `rule_name` varchar(255) DEFAULT NULL COMMENT 'Rule Name',
  PRIMARY KEY (`id`),
  UNIQUE KEY `2BD08D4CEA64A4EC59A72C9173E330A6` (`period`,`store_id`,`order_status`,`coupon_code`),
  KEY `IDX_MAG_COUPON_AGGREGATED_UPDATED_STORE_ID` (`store_id`),
  KEY `IDX_MAG_COUPON_AGGREGATED_UPDATED_RULE_NAME` (`rule_name`),
  CONSTRAINT `FK_MAG_COUPON_AGGRED_UPDATED_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Mag Coupon Aggregated Updated';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_coupon_aggregated_updated`
--

LOCK TABLES `mag_coupon_aggregated_updated` WRITE;
/*!40000 ALTER TABLE `mag_coupon_aggregated_updated` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_coupon_aggregated_updated` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_cron_schedule`
--

DROP TABLE IF EXISTS `mag_cron_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_cron_schedule` (
  `schedule_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Schedule Id',
  `job_code` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Job Code',
  `status` varchar(7) NOT NULL DEFAULT 'pending' COMMENT 'Status',
  `messages` text COMMENT 'Messages',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Created At',
  `scheduled_at` timestamp NULL DEFAULT NULL COMMENT 'Scheduled At',
  `executed_at` timestamp NULL DEFAULT NULL COMMENT 'Executed At',
  `finished_at` timestamp NULL DEFAULT NULL COMMENT 'Finished At',
  PRIMARY KEY (`schedule_id`),
  KEY `IDX_MAG_CRON_SCHEDULE_JOB_CODE` (`job_code`),
  KEY `IDX_MAG_CRON_SCHEDULE_SCHEDULED_AT_STATUS` (`scheduled_at`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cron Schedule';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_cron_schedule`
--

LOCK TABLES `mag_cron_schedule` WRITE;
/*!40000 ALTER TABLE `mag_cron_schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_cron_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_customer_address_entity`
--

DROP TABLE IF EXISTS `mag_customer_address_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_customer_address_entity` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set Id',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `parent_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Id',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `is_active` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Active',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_MAG_CUSTOMER_ADDRESS_ENTITY_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_MAG_CSTR_ADDR_ENTT_PARENT_ID_MAG_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`parent_id`) REFERENCES `mag_customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_customer_address_entity`
--

LOCK TABLES `mag_customer_address_entity` WRITE;
/*!40000 ALTER TABLE `mag_customer_address_entity` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_customer_address_entity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_customer_address_entity_datetime`
--

DROP TABLE IF EXISTS `mag_customer_address_entity_datetime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_customer_address_entity_datetime` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MAG_CUSTOMER_ADDRESS_ENTITY_DATETIME_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_MAG_CUSTOMER_ADDRESS_ENTITY_DATETIME_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_MAG_CUSTOMER_ADDRESS_ENTITY_DATETIME_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MAG_CUSTOMER_ADDRESS_ENTITY_DATETIME_ENTITY_ID` (`entity_id`),
  KEY `IDX_MAG_CSTR_ADDR_ENTT_DTIME_ENTT_ID_ATTR_ID_VAL` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `FK_A2035C31589B5F6ECECD4404C4D3E91E` FOREIGN KEY (`entity_type_id`) REFERENCES `mag_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CSTR_ADDR_ENTT_DTIME_ATTR_ID_MAG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mag_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CSTR_ADDR_ENTT_DTIME_ENTT_ID_MAG_CSTR_ADDR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mag_customer_address_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity Datetime';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_customer_address_entity_datetime`
--

LOCK TABLES `mag_customer_address_entity_datetime` WRITE;
/*!40000 ALTER TABLE `mag_customer_address_entity_datetime` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_customer_address_entity_datetime` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_customer_address_entity_decimal`
--

DROP TABLE IF EXISTS `mag_customer_address_entity_decimal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_customer_address_entity_decimal` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MAG_CUSTOMER_ADDRESS_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_MAG_CUSTOMER_ADDRESS_ENTITY_DECIMAL_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_MAG_CUSTOMER_ADDRESS_ENTITY_DECIMAL_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MAG_CUSTOMER_ADDRESS_ENTITY_DECIMAL_ENTITY_ID` (`entity_id`),
  KEY `IDX_MAG_CSTR_ADDR_ENTT_DEC_ENTT_ID_ATTR_ID_VAL` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `FK_339497838C98137A2B6F078D6DF526A4` FOREIGN KEY (`entity_type_id`) REFERENCES `mag_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CSTR_ADDR_ENTT_DEC_ATTR_ID_MAG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mag_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CSTR_ADDR_ENTT_DEC_ENTT_ID_MAG_CSTR_ADDR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mag_customer_address_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity Decimal';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_customer_address_entity_decimal`
--

LOCK TABLES `mag_customer_address_entity_decimal` WRITE;
/*!40000 ALTER TABLE `mag_customer_address_entity_decimal` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_customer_address_entity_decimal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_customer_address_entity_int`
--

DROP TABLE IF EXISTS `mag_customer_address_entity_int`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_customer_address_entity_int` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` int(11) NOT NULL DEFAULT '0' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MAG_CUSTOMER_ADDRESS_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_MAG_CUSTOMER_ADDRESS_ENTITY_INT_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_MAG_CUSTOMER_ADDRESS_ENTITY_INT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MAG_CUSTOMER_ADDRESS_ENTITY_INT_ENTITY_ID` (`entity_id`),
  KEY `IDX_MAG_CUSTOMER_ADDRESS_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `FK_1085A58B55B8AB6F0CE309DFB1E62A1D` FOREIGN KEY (`entity_type_id`) REFERENCES `mag_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CSTR_ADDR_ENTT_INT_ATTR_ID_MAG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mag_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CSTR_ADDR_ENTT_INT_ENTT_ID_MAG_CSTR_ADDR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mag_customer_address_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity Int';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_customer_address_entity_int`
--

LOCK TABLES `mag_customer_address_entity_int` WRITE;
/*!40000 ALTER TABLE `mag_customer_address_entity_int` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_customer_address_entity_int` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_customer_address_entity_text`
--

DROP TABLE IF EXISTS `mag_customer_address_entity_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_customer_address_entity_text` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` text NOT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MAG_CUSTOMER_ADDRESS_ENTITY_TEXT_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_MAG_CUSTOMER_ADDRESS_ENTITY_TEXT_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_MAG_CUSTOMER_ADDRESS_ENTITY_TEXT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MAG_CUSTOMER_ADDRESS_ENTITY_TEXT_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_9D1CC21C5A001FD0E5201326A786245D` FOREIGN KEY (`entity_type_id`) REFERENCES `mag_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CSTR_ADDR_ENTT_TEXT_ATTR_ID_MAG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mag_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CSTR_ADDR_ENTT_TEXT_ENTT_ID_MAG_CSTR_ADDR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mag_customer_address_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity Text';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_customer_address_entity_text`
--

LOCK TABLES `mag_customer_address_entity_text` WRITE;
/*!40000 ALTER TABLE `mag_customer_address_entity_text` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_customer_address_entity_text` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_customer_address_entity_varchar`
--

DROP TABLE IF EXISTS `mag_customer_address_entity_varchar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_customer_address_entity_varchar` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MAG_CUSTOMER_ADDRESS_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_MAG_CUSTOMER_ADDRESS_ENTITY_VARCHAR_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_MAG_CUSTOMER_ADDRESS_ENTITY_VARCHAR_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MAG_CUSTOMER_ADDRESS_ENTITY_VARCHAR_ENTITY_ID` (`entity_id`),
  KEY `IDX_MAG_CSTR_ADDR_ENTT_VCHR_ENTT_ID_ATTR_ID_VAL` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `FK_2040BE3B99D312472BC2F987007D7F70` FOREIGN KEY (`entity_type_id`) REFERENCES `mag_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CSTR_ADDR_ENTT_VCHR_ATTR_ID_MAG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mag_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CSTR_ADDR_ENTT_VCHR_ENTT_ID_MAG_CSTR_ADDR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mag_customer_address_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Address Entity Varchar';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_customer_address_entity_varchar`
--

LOCK TABLES `mag_customer_address_entity_varchar` WRITE;
/*!40000 ALTER TABLE `mag_customer_address_entity_varchar` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_customer_address_entity_varchar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_customer_eav_attribute`
--

DROP TABLE IF EXISTS `mag_customer_eav_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_customer_eav_attribute` (
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  `is_visible` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Visible',
  `input_filter` varchar(255) DEFAULT NULL COMMENT 'Input Filter',
  `multiline_count` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Multiline Count',
  `validate_rules` text COMMENT 'Validate Rules',
  `is_system` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is System',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `data_model` varchar(255) DEFAULT NULL COMMENT 'Data Model',
  PRIMARY KEY (`attribute_id`),
  CONSTRAINT `FK_MAG_CSTR_EAV_ATTR_ATTR_ID_MAG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mag_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Eav Attribute';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_customer_eav_attribute`
--

LOCK TABLES `mag_customer_eav_attribute` WRITE;
/*!40000 ALTER TABLE `mag_customer_eav_attribute` DISABLE KEYS */;
INSERT INTO `mag_customer_eav_attribute` VALUES (1,1,NULL,0,NULL,1,10,NULL),(2,0,NULL,0,NULL,1,0,NULL),(3,1,NULL,0,NULL,1,20,NULL),(4,0,NULL,0,NULL,0,30,NULL),(5,1,NULL,0,'a:2:{s:15:\"max_text_length\";i:255;s:15:\"min_text_length\";i:1;}',1,40,NULL),(6,0,NULL,0,NULL,0,50,NULL),(7,1,NULL,0,'a:2:{s:15:\"max_text_length\";i:255;s:15:\"min_text_length\";i:1;}',1,60,NULL),(8,0,NULL,0,NULL,0,70,NULL),(9,1,NULL,0,'a:1:{s:16:\"input_validation\";s:5:\"email\";}',1,80,NULL),(10,1,NULL,0,NULL,1,25,NULL),(11,0,'date',0,'a:1:{s:16:\"input_validation\";s:4:\"date\";}',0,90,NULL),(12,0,NULL,0,NULL,1,0,NULL),(13,0,NULL,0,NULL,1,0,NULL),(14,0,NULL,0,NULL,1,0,NULL),(15,0,NULL,0,'a:1:{s:15:\"max_text_length\";i:255;}',0,100,NULL),(16,0,NULL,0,NULL,1,0,NULL),(17,0,'datetime',0,NULL,0,0,NULL),(18,0,NULL,0,'a:0:{}',0,110,NULL),(19,0,NULL,0,NULL,0,10,NULL),(20,1,NULL,0,'a:2:{s:15:\"max_text_length\";i:255;s:15:\"min_text_length\";i:1;}',1,20,NULL),(21,0,NULL,0,NULL,0,30,NULL),(22,1,NULL,0,'a:2:{s:15:\"max_text_length\";i:255;s:15:\"min_text_length\";i:1;}',1,40,NULL),(23,0,NULL,0,NULL,0,50,NULL),(24,1,NULL,0,'a:2:{s:15:\"max_text_length\";i:255;s:15:\"min_text_length\";i:1;}',1,60,NULL),(25,1,NULL,2,'a:2:{s:15:\"max_text_length\";i:255;s:15:\"min_text_length\";i:1;}',1,70,NULL),(26,1,NULL,0,'a:2:{s:15:\"max_text_length\";i:255;s:15:\"min_text_length\";i:1;}',1,80,NULL),(27,1,NULL,0,NULL,1,90,NULL),(28,1,NULL,0,NULL,1,100,NULL),(29,1,NULL,0,NULL,1,100,NULL),(30,1,NULL,0,'a:0:{}',1,110,'customer/attribute_data_postcode'),(31,1,NULL,0,'a:2:{s:15:\"max_text_length\";i:255;s:15:\"min_text_length\";i:1;}',1,120,NULL),(32,1,NULL,0,'a:2:{s:15:\"max_text_length\";i:255;s:15:\"min_text_length\";i:1;}',1,130,NULL),(33,0,NULL,0,NULL,1,0,NULL),(34,0,NULL,0,'a:1:{s:16:\"input_validation\";s:4:\"date\";}',1,0,NULL),(35,1,NULL,0,NULL,1,28,NULL),(36,1,NULL,0,NULL,1,140,NULL),(37,0,NULL,0,NULL,1,0,NULL),(38,0,NULL,0,NULL,1,0,NULL),(39,0,NULL,0,NULL,1,0,NULL),(40,0,NULL,0,NULL,1,0,NULL);
/*!40000 ALTER TABLE `mag_customer_eav_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_customer_eav_attribute_website`
--

DROP TABLE IF EXISTS `mag_customer_eav_attribute_website`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_customer_eav_attribute_website` (
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `is_visible` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Visible',
  `is_required` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Required',
  `default_value` text COMMENT 'Default Value',
  `multiline_count` smallint(5) unsigned DEFAULT NULL COMMENT 'Multiline Count',
  PRIMARY KEY (`attribute_id`,`website_id`),
  KEY `IDX_MAG_CUSTOMER_EAV_ATTRIBUTE_WEBSITE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_MAG_CSTR_EAV_ATTR_WS_ATTR_ID_MAG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mag_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CSTR_EAV_ATTR_WS_WS_ID_MAG_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `mag_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Eav Attribute Website';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_customer_eav_attribute_website`
--

LOCK TABLES `mag_customer_eav_attribute_website` WRITE;
/*!40000 ALTER TABLE `mag_customer_eav_attribute_website` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_customer_eav_attribute_website` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_customer_entity`
--

DROP TABLE IF EXISTS `mag_customer_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_customer_entity` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set Id',
  `website_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Website Id',
  `email` varchar(255) DEFAULT NULL COMMENT 'Email',
  `group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Group Id',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `store_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Store Id',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `is_active` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Active',
  `disable_auto_group_change` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Disable automatic group change based on VAT ID',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_MAG_CUSTOMER_ENTITY_EMAIL_WEBSITE_ID` (`email`,`website_id`),
  KEY `IDX_MAG_CUSTOMER_ENTITY_STORE_ID` (`store_id`),
  KEY `IDX_MAG_CUSTOMER_ENTITY_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_MAG_CUSTOMER_ENTITY_EMAIL_WEBSITE_ID` (`email`,`website_id`),
  KEY `IDX_MAG_CUSTOMER_ENTITY_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_MAG_CUSTOMER_ENTITY_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CUSTOMER_ENTITY_WEBSITE_ID_MAG_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `mag_core_website` (`website_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Entity';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_customer_entity`
--

LOCK TABLES `mag_customer_entity` WRITE;
/*!40000 ALTER TABLE `mag_customer_entity` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_customer_entity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_customer_entity_datetime`
--

DROP TABLE IF EXISTS `mag_customer_entity_datetime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_customer_entity_datetime` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MAG_CUSTOMER_ENTITY_DATETIME_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_MAG_CUSTOMER_ENTITY_DATETIME_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_MAG_CUSTOMER_ENTITY_DATETIME_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MAG_CUSTOMER_ENTITY_DATETIME_ENTITY_ID` (`entity_id`),
  KEY `IDX_MAG_CUSTOMER_ENTITY_DATETIME_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `FK_9D2C475471601FF54CD236162081390D` FOREIGN KEY (`entity_type_id`) REFERENCES `mag_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CSTR_ENTT_DTIME_ATTR_ID_MAG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mag_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CSTR_ENTT_DTIME_ENTT_ID_MAG_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mag_customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Entity Datetime';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_customer_entity_datetime`
--

LOCK TABLES `mag_customer_entity_datetime` WRITE;
/*!40000 ALTER TABLE `mag_customer_entity_datetime` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_customer_entity_datetime` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_customer_entity_decimal`
--

DROP TABLE IF EXISTS `mag_customer_entity_decimal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_customer_entity_decimal` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MAG_CUSTOMER_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_MAG_CUSTOMER_ENTITY_DECIMAL_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_MAG_CUSTOMER_ENTITY_DECIMAL_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MAG_CUSTOMER_ENTITY_DECIMAL_ENTITY_ID` (`entity_id`),
  KEY `IDX_MAG_CUSTOMER_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `FK_MAG_CSTR_ENTT_DEC_ATTR_ID_MAG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mag_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CSTR_ENTT_DEC_ENTT_ID_MAG_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mag_customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CSTR_ENTT_DEC_ENTT_TYPE_ID_MAG_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `mag_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Entity Decimal';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_customer_entity_decimal`
--

LOCK TABLES `mag_customer_entity_decimal` WRITE;
/*!40000 ALTER TABLE `mag_customer_entity_decimal` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_customer_entity_decimal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_customer_entity_int`
--

DROP TABLE IF EXISTS `mag_customer_entity_int`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_customer_entity_int` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` int(11) NOT NULL DEFAULT '0' COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MAG_CUSTOMER_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_MAG_CUSTOMER_ENTITY_INT_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_MAG_CUSTOMER_ENTITY_INT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MAG_CUSTOMER_ENTITY_INT_ENTITY_ID` (`entity_id`),
  KEY `IDX_MAG_CUSTOMER_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `FK_MAG_CSTR_ENTT_INT_ATTR_ID_MAG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mag_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CSTR_ENTT_INT_ENTT_ID_MAG_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mag_customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CSTR_ENTT_INT_ENTT_TYPE_ID_MAG_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `mag_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Entity Int';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_customer_entity_int`
--

LOCK TABLES `mag_customer_entity_int` WRITE;
/*!40000 ALTER TABLE `mag_customer_entity_int` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_customer_entity_int` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_customer_entity_text`
--

DROP TABLE IF EXISTS `mag_customer_entity_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_customer_entity_text` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` text NOT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MAG_CUSTOMER_ENTITY_TEXT_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_MAG_CUSTOMER_ENTITY_TEXT_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_MAG_CUSTOMER_ENTITY_TEXT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MAG_CUSTOMER_ENTITY_TEXT_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_FC63C8B07C911C8A958D5D4C66962FC2` FOREIGN KEY (`entity_type_id`) REFERENCES `mag_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CSTR_ENTT_TEXT_ATTR_ID_MAG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mag_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CSTR_ENTT_TEXT_ENTT_ID_MAG_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mag_customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Entity Text';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_customer_entity_text`
--

LOCK TABLES `mag_customer_entity_text` WRITE;
/*!40000 ALTER TABLE `mag_customer_entity_text` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_customer_entity_text` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_customer_entity_varchar`
--

DROP TABLE IF EXISTS `mag_customer_entity_varchar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_customer_entity_varchar` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MAG_CUSTOMER_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID` (`entity_id`,`attribute_id`),
  KEY `IDX_MAG_CUSTOMER_ENTITY_VARCHAR_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_MAG_CUSTOMER_ENTITY_VARCHAR_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MAG_CUSTOMER_ENTITY_VARCHAR_ENTITY_ID` (`entity_id`),
  KEY `IDX_MAG_CUSTOMER_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID_VALUE` (`entity_id`,`attribute_id`,`value`),
  CONSTRAINT `FK_81614EFEA82B186505CA38DFFD0E3428` FOREIGN KEY (`entity_type_id`) REFERENCES `mag_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CSTR_ENTT_VCHR_ATTR_ID_MAG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mag_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_CSTR_ENTT_VCHR_ENTT_ID_MAG_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mag_customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Entity Varchar';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_customer_entity_varchar`
--

LOCK TABLES `mag_customer_entity_varchar` WRITE;
/*!40000 ALTER TABLE `mag_customer_entity_varchar` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_customer_entity_varchar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_customer_form_attribute`
--

DROP TABLE IF EXISTS `mag_customer_form_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_customer_form_attribute` (
  `form_code` varchar(32) NOT NULL COMMENT 'Form Code',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  PRIMARY KEY (`form_code`,`attribute_id`),
  KEY `IDX_MAG_CUSTOMER_FORM_ATTRIBUTE_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `FK_MAG_CSTR_FORM_ATTR_ATTR_ID_MAG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mag_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Form Attribute';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_customer_form_attribute`
--

LOCK TABLES `mag_customer_form_attribute` WRITE;
/*!40000 ALTER TABLE `mag_customer_form_attribute` DISABLE KEYS */;
INSERT INTO `mag_customer_form_attribute` VALUES ('adminhtml_customer',1),('adminhtml_customer',3),('adminhtml_customer',4),('checkout_register',4),('customer_account_create',4),('customer_account_edit',4),('adminhtml_customer',5),('checkout_register',5),('customer_account_create',5),('customer_account_edit',5),('adminhtml_customer',6),('checkout_register',6),('customer_account_create',6),('customer_account_edit',6),('adminhtml_customer',7),('checkout_register',7),('customer_account_create',7),('customer_account_edit',7),('adminhtml_customer',8),('checkout_register',8),('customer_account_create',8),('customer_account_edit',8),('adminhtml_checkout',9),('adminhtml_customer',9),('checkout_register',9),('customer_account_create',9),('customer_account_edit',9),('adminhtml_checkout',10),('adminhtml_customer',10),('adminhtml_checkout',11),('adminhtml_customer',11),('checkout_register',11),('customer_account_create',11),('customer_account_edit',11),('adminhtml_checkout',15),('adminhtml_customer',15),('checkout_register',15),('customer_account_create',15),('customer_account_edit',15),('adminhtml_customer',17),('checkout_register',17),('customer_account_create',17),('customer_account_edit',17),('adminhtml_checkout',18),('adminhtml_customer',18),('checkout_register',18),('customer_account_create',18),('customer_account_edit',18),('adminhtml_customer_address',19),('customer_address_edit',19),('customer_register_address',19),('adminhtml_customer_address',20),('customer_address_edit',20),('customer_register_address',20),('adminhtml_customer_address',21),('customer_address_edit',21),('customer_register_address',21),('adminhtml_customer_address',22),('customer_address_edit',22),('customer_register_address',22),('adminhtml_customer_address',23),('customer_address_edit',23),('customer_register_address',23),('adminhtml_customer_address',24),('customer_address_edit',24),('customer_register_address',24),('adminhtml_customer_address',25),('customer_address_edit',25),('customer_register_address',25),('adminhtml_customer_address',26),('customer_address_edit',26),('customer_register_address',26),('adminhtml_customer_address',27),('customer_address_edit',27),('customer_register_address',27),('adminhtml_customer_address',28),('customer_address_edit',28),('customer_register_address',28),('adminhtml_customer_address',29),('customer_address_edit',29),('customer_register_address',29),('adminhtml_customer_address',30),('customer_address_edit',30),('customer_register_address',30),('adminhtml_customer_address',31),('customer_address_edit',31),('customer_register_address',31),('adminhtml_customer_address',32),('customer_address_edit',32),('customer_register_address',32),('adminhtml_customer',35),('adminhtml_customer_address',36),('customer_address_edit',36),('customer_register_address',36);
/*!40000 ALTER TABLE `mag_customer_form_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_customer_group`
--

DROP TABLE IF EXISTS `mag_customer_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_customer_group` (
  `customer_group_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Customer Group Id',
  `customer_group_code` varchar(32) NOT NULL COMMENT 'Customer Group Code',
  `tax_class_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Tax Class Id',
  PRIMARY KEY (`customer_group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Customer Group';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_customer_group`
--

LOCK TABLES `mag_customer_group` WRITE;
/*!40000 ALTER TABLE `mag_customer_group` DISABLE KEYS */;
INSERT INTO `mag_customer_group` VALUES (0,'NOT LOGGED IN',3),(1,'General',3),(2,'Wholesale',3),(3,'Retailer',3);
/*!40000 ALTER TABLE `mag_customer_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_dataflow_batch`
--

DROP TABLE IF EXISTS `mag_dataflow_batch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_dataflow_batch` (
  `batch_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Batch Id',
  `profile_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Profile ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `adapter` varchar(128) DEFAULT NULL COMMENT 'Adapter',
  `params` text COMMENT 'Parameters',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  PRIMARY KEY (`batch_id`),
  KEY `IDX_MAG_DATAFLOW_BATCH_PROFILE_ID` (`profile_id`),
  KEY `IDX_MAG_DATAFLOW_BATCH_STORE_ID` (`store_id`),
  KEY `IDX_MAG_DATAFLOW_BATCH_CREATED_AT` (`created_at`),
  CONSTRAINT `FK_MAG_DATAFLOW_BATCH_PROFILE_ID_MAG_DATAFLOW_PROFILE_PROFILE_ID` FOREIGN KEY (`profile_id`) REFERENCES `mag_dataflow_profile` (`profile_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_MAG_DATAFLOW_BATCH_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Dataflow Batch';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_dataflow_batch`
--

LOCK TABLES `mag_dataflow_batch` WRITE;
/*!40000 ALTER TABLE `mag_dataflow_batch` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_dataflow_batch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_dataflow_batch_export`
--

DROP TABLE IF EXISTS `mag_dataflow_batch_export`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_dataflow_batch_export` (
  `batch_export_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Batch Export Id',
  `batch_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Batch Id',
  `batch_data` longtext COMMENT 'Batch Data',
  `status` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Status',
  PRIMARY KEY (`batch_export_id`),
  KEY `IDX_MAG_DATAFLOW_BATCH_EXPORT_BATCH_ID` (`batch_id`),
  CONSTRAINT `FK_49BB0FD02BE2AFBD9A3F7182A9EFC46F` FOREIGN KEY (`batch_id`) REFERENCES `mag_dataflow_batch` (`batch_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Dataflow Batch Export';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_dataflow_batch_export`
--

LOCK TABLES `mag_dataflow_batch_export` WRITE;
/*!40000 ALTER TABLE `mag_dataflow_batch_export` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_dataflow_batch_export` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_dataflow_batch_import`
--

DROP TABLE IF EXISTS `mag_dataflow_batch_import`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_dataflow_batch_import` (
  `batch_import_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Batch Import Id',
  `batch_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Batch Id',
  `batch_data` longtext COMMENT 'Batch Data',
  `status` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Status',
  PRIMARY KEY (`batch_import_id`),
  KEY `IDX_MAG_DATAFLOW_BATCH_IMPORT_BATCH_ID` (`batch_id`),
  CONSTRAINT `FK_21777F07F633F40D3EBDB2206ADD5B2A` FOREIGN KEY (`batch_id`) REFERENCES `mag_dataflow_batch` (`batch_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Dataflow Batch Import';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_dataflow_batch_import`
--

LOCK TABLES `mag_dataflow_batch_import` WRITE;
/*!40000 ALTER TABLE `mag_dataflow_batch_import` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_dataflow_batch_import` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_dataflow_import_data`
--

DROP TABLE IF EXISTS `mag_dataflow_import_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_dataflow_import_data` (
  `import_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Import Id',
  `session_id` int(11) DEFAULT NULL COMMENT 'Session Id',
  `serial_number` int(11) NOT NULL DEFAULT '0' COMMENT 'Serial Number',
  `value` text COMMENT 'Value',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT 'Status',
  PRIMARY KEY (`import_id`),
  KEY `IDX_MAG_DATAFLOW_IMPORT_DATA_SESSION_ID` (`session_id`),
  CONSTRAINT `FK_MAG_DATAFLOW_IMPORT_DATA_SESS_ID_MAG_DATAFLOW_SESS_SESS_ID` FOREIGN KEY (`session_id`) REFERENCES `mag_dataflow_session` (`session_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Dataflow Import Data';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_dataflow_import_data`
--

LOCK TABLES `mag_dataflow_import_data` WRITE;
/*!40000 ALTER TABLE `mag_dataflow_import_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_dataflow_import_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_dataflow_profile`
--

DROP TABLE IF EXISTS `mag_dataflow_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_dataflow_profile` (
  `profile_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Profile Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `actions_xml` text COMMENT 'Actions Xml',
  `gui_data` text COMMENT 'Gui Data',
  `direction` varchar(6) DEFAULT NULL COMMENT 'Direction',
  `entity_type` varchar(64) DEFAULT NULL COMMENT 'Entity Type',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `data_transfer` varchar(11) DEFAULT NULL COMMENT 'Data Transfer',
  PRIMARY KEY (`profile_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='Dataflow Profile';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_dataflow_profile`
--

LOCK TABLES `mag_dataflow_profile` WRITE;
/*!40000 ALTER TABLE `mag_dataflow_profile` DISABLE KEYS */;
INSERT INTO `mag_dataflow_profile` VALUES (1,'Export All Products','2015-02-19 08:09:04','2015-02-19 08:09:04','<action type=\"catalog/convert_adapter_product\" method=\"load\">\\r\\n    <var name=\"store\"><![CDATA[0]]></var>\\r\\n</action>\\r\\n\\r\\n<action type=\"catalog/convert_parser_product\" method=\"unparse\">\\r\\n    <var name=\"store\"><![CDATA[0]]></var>\\r\\n</action>\\r\\n\\r\\n<action type=\"dataflow/convert_mapper_column\" method=\"map\">\\r\\n</action>\\r\\n\\r\\n<action type=\"dataflow/convert_parser_csv\" method=\"unparse\">\\r\\n    <var name=\"delimiter\"><![CDATA[,]]></var>\\r\\n    <var name=\"enclose\"><![CDATA[\"]]></var>\\r\\n    <var name=\"fieldnames\">true</var>\\r\\n</action>\\r\\n\\r\\n<action type=\"dataflow/convert_adapter_io\" method=\"save\">\\r\\n    <var name=\"type\">file</var>\\r\\n    <var name=\"path\">var/export</var>\\r\\n    <var name=\"filename\"><![CDATA[export_all_products.csv]]></var>\\r\\n</action>\\r\\n\\r\\n','a:5:{s:4:\"file\";a:7:{s:4:\"type\";s:4:\"file\";s:8:\"filename\";s:23:\"export_all_products.csv\";s:4:\"path\";s:10:\"var/export\";s:4:\"host\";s:0:\"\";s:4:\"user\";s:0:\"\";s:8:\"password\";s:0:\"\";s:7:\"passive\";s:0:\"\";}s:5:\"parse\";a:5:{s:4:\"type\";s:3:\"csv\";s:12:\"single_sheet\";s:0:\"\";s:9:\"delimiter\";s:1:\",\";s:7:\"enclose\";s:1:\"\"\";s:10:\"fieldnames\";s:4:\"true\";}s:3:\"map\";a:3:{s:14:\"only_specified\";s:0:\"\";s:7:\"product\";a:2:{s:2:\"db\";a:0:{}s:4:\"file\";a:0:{}}s:8:\"customer\";a:2:{s:2:\"db\";a:0:{}s:4:\"file\";a:0:{}}}s:7:\"product\";a:1:{s:6:\"filter\";a:8:{s:4:\"name\";s:0:\"\";s:3:\"sku\";s:0:\"\";s:4:\"type\";s:1:\"0\";s:13:\"attribute_set\";s:0:\"\";s:5:\"price\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:3:\"qty\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:10:\"visibility\";s:1:\"0\";s:6:\"status\";s:1:\"0\";}}s:8:\"customer\";a:1:{s:6:\"filter\";a:10:{s:9:\"firstname\";s:0:\"\";s:8:\"lastname\";s:0:\"\";s:5:\"email\";s:0:\"\";s:5:\"group\";s:1:\"0\";s:10:\"adressType\";s:15:\"default_billing\";s:9:\"telephone\";s:0:\"\";s:8:\"postcode\";s:0:\"\";s:7:\"country\";s:0:\"\";s:6:\"region\";s:0:\"\";s:10:\"created_at\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}}}}','export','product',0,'file'),(2,'Export Product Stocks','2015-02-19 08:09:04','2015-02-19 08:09:04','<action type=\"catalog/convert_adapter_product\" method=\"load\">\\r\\n    <var name=\"store\"><![CDATA[0]]></var>\\r\\n</action>\\r\\n\\r\\n<action type=\"catalog/convert_parser_product\" method=\"unparse\">\\r\\n    <var name=\"store\"><![CDATA[0]]></var>\\r\\n</action>\\r\\n\\r\\n<action type=\"dataflow/convert_mapper_column\" method=\"map\">\\r\\n</action>\\r\\n\\r\\n<action type=\"dataflow/convert_parser_csv\" method=\"unparse\">\\r\\n    <var name=\"delimiter\"><![CDATA[,]]></var>\\r\\n    <var name=\"enclose\"><![CDATA[\"]]></var>\\r\\n    <var name=\"fieldnames\">true</var>\\r\\n</action>\\r\\n\\r\\n<action type=\"dataflow/convert_adapter_io\" method=\"save\">\\r\\n    <var name=\"type\">file</var>\\r\\n    <var name=\"path\">var/export</var>\\r\\n    <var name=\"filename\"><![CDATA[export_all_products.csv]]></var>\\r\\n</action>\\r\\n\\r\\n','a:5:{s:4:\"file\";a:7:{s:4:\"type\";s:4:\"file\";s:8:\"filename\";s:25:\"export_product_stocks.csv\";s:4:\"path\";s:10:\"var/export\";s:4:\"host\";s:0:\"\";s:4:\"user\";s:0:\"\";s:8:\"password\";s:0:\"\";s:7:\"passive\";s:0:\"\";}s:5:\"parse\";a:5:{s:4:\"type\";s:3:\"csv\";s:12:\"single_sheet\";s:0:\"\";s:9:\"delimiter\";s:1:\",\";s:7:\"enclose\";s:1:\"\"\";s:10:\"fieldnames\";s:4:\"true\";}s:3:\"map\";a:3:{s:14:\"only_specified\";s:4:\"true\";s:7:\"product\";a:2:{s:2:\"db\";a:4:{i:1;s:5:\"store\";i:2;s:3:\"sku\";i:3;s:3:\"qty\";i:4;s:11:\"is_in_stock\";}s:4:\"file\";a:4:{i:1;s:5:\"store\";i:2;s:3:\"sku\";i:3;s:3:\"qty\";i:4;s:11:\"is_in_stock\";}}s:8:\"customer\";a:2:{s:2:\"db\";a:0:{}s:4:\"file\";a:0:{}}}s:7:\"product\";a:1:{s:6:\"filter\";a:8:{s:4:\"name\";s:0:\"\";s:3:\"sku\";s:0:\"\";s:4:\"type\";s:1:\"0\";s:13:\"attribute_set\";s:0:\"\";s:5:\"price\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:3:\"qty\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:10:\"visibility\";s:1:\"0\";s:6:\"status\";s:1:\"0\";}}s:8:\"customer\";a:1:{s:6:\"filter\";a:10:{s:9:\"firstname\";s:0:\"\";s:8:\"lastname\";s:0:\"\";s:5:\"email\";s:0:\"\";s:5:\"group\";s:1:\"0\";s:10:\"adressType\";s:15:\"default_billing\";s:9:\"telephone\";s:0:\"\";s:8:\"postcode\";s:0:\"\";s:7:\"country\";s:0:\"\";s:6:\"region\";s:0:\"\";s:10:\"created_at\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}}}}','export','product',0,'file'),(3,'Import All Products','2015-02-19 08:09:04','2015-02-19 08:09:04','<action type=\"dataflow/convert_parser_csv\" method=\"parse\">\\r\\n    <var name=\"delimiter\"><![CDATA[,]]></var>\\r\\n    <var name=\"enclose\"><![CDATA[\"]]></var>\\r\\n    <var name=\"fieldnames\">true</var>\\r\\n    <var name=\"store\"><![CDATA[0]]></var>\\r\\n    <var name=\"adapter\">catalog/convert_adapter_product</var>\\r\\n    <var name=\"method\">parse</var>\\r\\n</action>','a:5:{s:4:\"file\";a:7:{s:4:\"type\";s:4:\"file\";s:8:\"filename\";s:23:\"export_all_products.csv\";s:4:\"path\";s:10:\"var/export\";s:4:\"host\";s:0:\"\";s:4:\"user\";s:0:\"\";s:8:\"password\";s:0:\"\";s:7:\"passive\";s:0:\"\";}s:5:\"parse\";a:5:{s:4:\"type\";s:3:\"csv\";s:12:\"single_sheet\";s:0:\"\";s:9:\"delimiter\";s:1:\",\";s:7:\"enclose\";s:1:\"\"\";s:10:\"fieldnames\";s:4:\"true\";}s:3:\"map\";a:3:{s:14:\"only_specified\";s:0:\"\";s:7:\"product\";a:2:{s:2:\"db\";a:0:{}s:4:\"file\";a:0:{}}s:8:\"customer\";a:2:{s:2:\"db\";a:0:{}s:4:\"file\";a:0:{}}}s:7:\"product\";a:1:{s:6:\"filter\";a:8:{s:4:\"name\";s:0:\"\";s:3:\"sku\";s:0:\"\";s:4:\"type\";s:1:\"0\";s:13:\"attribute_set\";s:0:\"\";s:5:\"price\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:3:\"qty\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:10:\"visibility\";s:1:\"0\";s:6:\"status\";s:1:\"0\";}}s:8:\"customer\";a:1:{s:6:\"filter\";a:10:{s:9:\"firstname\";s:0:\"\";s:8:\"lastname\";s:0:\"\";s:5:\"email\";s:0:\"\";s:5:\"group\";s:1:\"0\";s:10:\"adressType\";s:15:\"default_billing\";s:9:\"telephone\";s:0:\"\";s:8:\"postcode\";s:0:\"\";s:7:\"country\";s:0:\"\";s:6:\"region\";s:0:\"\";s:10:\"created_at\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}}}}','import','product',0,'interactive'),(4,'Import Product Stocks','2015-02-19 08:09:04','2015-02-19 08:09:04','<action type=\"dataflow/convert_parser_csv\" method=\"parse\">\\r\\n    <var name=\"delimiter\"><![CDATA[,]]></var>\\r\\n    <var name=\"enclose\"><![CDATA[\"]]></var>\\r\\n    <var name=\"fieldnames\">true</var>\\r\\n    <var name=\"store\"><![CDATA[0]]></var>\\r\\n    <var name=\"adapter\">catalog/convert_adapter_product</var>\\r\\n    <var name=\"method\">parse</var>\\r\\n</action>','a:5:{s:4:\"file\";a:7:{s:4:\"type\";s:4:\"file\";s:8:\"filename\";s:18:\"export_product.csv\";s:4:\"path\";s:10:\"var/export\";s:4:\"host\";s:0:\"\";s:4:\"user\";s:0:\"\";s:8:\"password\";s:0:\"\";s:7:\"passive\";s:0:\"\";}s:5:\"parse\";a:5:{s:4:\"type\";s:3:\"csv\";s:12:\"single_sheet\";s:0:\"\";s:9:\"delimiter\";s:1:\",\";s:7:\"enclose\";s:1:\"\"\";s:10:\"fieldnames\";s:4:\"true\";}s:3:\"map\";a:3:{s:14:\"only_specified\";s:0:\"\";s:7:\"product\";a:2:{s:2:\"db\";a:0:{}s:4:\"file\";a:0:{}}s:8:\"customer\";a:2:{s:2:\"db\";a:0:{}s:4:\"file\";a:0:{}}}s:7:\"product\";a:1:{s:6:\"filter\";a:8:{s:4:\"name\";s:0:\"\";s:3:\"sku\";s:0:\"\";s:4:\"type\";s:1:\"0\";s:13:\"attribute_set\";s:0:\"\";s:5:\"price\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:3:\"qty\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:10:\"visibility\";s:1:\"0\";s:6:\"status\";s:1:\"0\";}}s:8:\"customer\";a:1:{s:6:\"filter\";a:10:{s:9:\"firstname\";s:0:\"\";s:8:\"lastname\";s:0:\"\";s:5:\"email\";s:0:\"\";s:5:\"group\";s:1:\"0\";s:10:\"adressType\";s:15:\"default_billing\";s:9:\"telephone\";s:0:\"\";s:8:\"postcode\";s:0:\"\";s:7:\"country\";s:0:\"\";s:6:\"region\";s:0:\"\";s:10:\"created_at\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}}}}','import','product',0,'interactive'),(5,'Export Customers','2015-02-19 08:09:04','2015-02-19 08:09:04','<action type=\"customer/convert_adapter_customer\" method=\"load\">\\r\\n    <var name=\"store\"><![CDATA[0]]></var>\\r\\n    <var name=\"filter/adressType\"><![CDATA[default_billing]]></var>\\r\\n</action>\\r\\n\\r\\n<action type=\"customer/convert_parser_customer\" method=\"unparse\">\\r\\n    <var name=\"store\"><![CDATA[0]]></var>\\r\\n</action>\\r\\n\\r\\n<action type=\"dataflow/convert_mapper_column\" method=\"map\">\\r\\n</action>\\r\\n\\r\\n<action type=\"dataflow/convert_parser_csv\" method=\"unparse\">\\r\\n    <var name=\"delimiter\"><![CDATA[,]]></var>\\r\\n    <var name=\"enclose\"><![CDATA[\"]]></var>\\r\\n    <var name=\"fieldnames\">true</var>\\r\\n</action>\\r\\n\\r\\n<action type=\"dataflow/convert_adapter_io\" method=\"save\">\\r\\n    <var name=\"type\">file</var>\\r\\n    <var name=\"path\">var/export</var>\\r\\n    <var name=\"filename\"><![CDATA[export_customers.csv]]></var>\\r\\n</action>\\r\\n\\r\\n','a:5:{s:4:\"file\";a:7:{s:4:\"type\";s:4:\"file\";s:8:\"filename\";s:20:\"export_customers.csv\";s:4:\"path\";s:10:\"var/export\";s:4:\"host\";s:0:\"\";s:4:\"user\";s:0:\"\";s:8:\"password\";s:0:\"\";s:7:\"passive\";s:0:\"\";}s:5:\"parse\";a:5:{s:4:\"type\";s:3:\"csv\";s:12:\"single_sheet\";s:0:\"\";s:9:\"delimiter\";s:1:\",\";s:7:\"enclose\";s:1:\"\"\";s:10:\"fieldnames\";s:4:\"true\";}s:3:\"map\";a:3:{s:14:\"only_specified\";s:0:\"\";s:7:\"product\";a:2:{s:2:\"db\";a:0:{}s:4:\"file\";a:0:{}}s:8:\"customer\";a:2:{s:2:\"db\";a:0:{}s:4:\"file\";a:0:{}}}s:7:\"product\";a:1:{s:6:\"filter\";a:8:{s:4:\"name\";s:0:\"\";s:3:\"sku\";s:0:\"\";s:4:\"type\";s:1:\"0\";s:13:\"attribute_set\";s:0:\"\";s:5:\"price\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:3:\"qty\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:10:\"visibility\";s:1:\"0\";s:6:\"status\";s:1:\"0\";}}s:8:\"customer\";a:1:{s:6:\"filter\";a:10:{s:9:\"firstname\";s:0:\"\";s:8:\"lastname\";s:0:\"\";s:5:\"email\";s:0:\"\";s:5:\"group\";s:1:\"0\";s:10:\"adressType\";s:15:\"default_billing\";s:9:\"telephone\";s:0:\"\";s:8:\"postcode\";s:0:\"\";s:7:\"country\";s:0:\"\";s:6:\"region\";s:0:\"\";s:10:\"created_at\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}}}}','export','customer',0,'file'),(6,'Import Customers','2015-02-19 08:09:04','2015-02-19 08:09:04','<action type=\"dataflow/convert_parser_csv\" method=\"parse\">\\r\\n    <var name=\"delimiter\"><![CDATA[,]]></var>\\r\\n    <var name=\"enclose\"><![CDATA[\"]]></var>\\r\\n    <var name=\"fieldnames\">true</var>\\r\\n    <var name=\"store\"><![CDATA[0]]></var>\\r\\n    <var name=\"adapter\">customer/convert_adapter_customer</var>\\r\\n    <var name=\"method\">parse</var>\\r\\n</action>','a:5:{s:4:\"file\";a:7:{s:4:\"type\";s:4:\"file\";s:8:\"filename\";s:19:\"export_customer.csv\";s:4:\"path\";s:10:\"var/export\";s:4:\"host\";s:0:\"\";s:4:\"user\";s:0:\"\";s:8:\"password\";s:0:\"\";s:7:\"passive\";s:0:\"\";}s:5:\"parse\";a:5:{s:4:\"type\";s:3:\"csv\";s:12:\"single_sheet\";s:0:\"\";s:9:\"delimiter\";s:1:\",\";s:7:\"enclose\";s:1:\"\"\";s:10:\"fieldnames\";s:4:\"true\";}s:3:\"map\";a:3:{s:14:\"only_specified\";s:0:\"\";s:7:\"product\";a:2:{s:2:\"db\";a:0:{}s:4:\"file\";a:0:{}}s:8:\"customer\";a:2:{s:2:\"db\";a:0:{}s:4:\"file\";a:0:{}}}s:7:\"product\";a:1:{s:6:\"filter\";a:8:{s:4:\"name\";s:0:\"\";s:3:\"sku\";s:0:\"\";s:4:\"type\";s:1:\"0\";s:13:\"attribute_set\";s:0:\"\";s:5:\"price\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:3:\"qty\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}s:10:\"visibility\";s:1:\"0\";s:6:\"status\";s:1:\"0\";}}s:8:\"customer\";a:1:{s:6:\"filter\";a:10:{s:9:\"firstname\";s:0:\"\";s:8:\"lastname\";s:0:\"\";s:5:\"email\";s:0:\"\";s:5:\"group\";s:1:\"0\";s:10:\"adressType\";s:15:\"default_billing\";s:9:\"telephone\";s:0:\"\";s:8:\"postcode\";s:0:\"\";s:7:\"country\";s:0:\"\";s:6:\"region\";s:0:\"\";s:10:\"created_at\";a:2:{s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}}}}','import','customer',0,'interactive');
/*!40000 ALTER TABLE `mag_dataflow_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_dataflow_profile_history`
--

DROP TABLE IF EXISTS `mag_dataflow_profile_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_dataflow_profile_history` (
  `history_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'History Id',
  `profile_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Profile Id',
  `action_code` varchar(64) DEFAULT NULL COMMENT 'Action Code',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'User Id',
  `performed_at` timestamp NULL DEFAULT NULL COMMENT 'Performed At',
  PRIMARY KEY (`history_id`),
  KEY `IDX_MAG_DATAFLOW_PROFILE_HISTORY_PROFILE_ID` (`profile_id`),
  CONSTRAINT `FK_F42A0517F8925B878E00D51F7457E8AF` FOREIGN KEY (`profile_id`) REFERENCES `mag_dataflow_profile` (`profile_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='Dataflow Profile History';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_dataflow_profile_history`
--

LOCK TABLES `mag_dataflow_profile_history` WRITE;
/*!40000 ALTER TABLE `mag_dataflow_profile_history` DISABLE KEYS */;
INSERT INTO `mag_dataflow_profile_history` VALUES (1,1,'create',0,'2015-02-19 08:09:04'),(2,2,'create',0,'2015-02-19 08:09:04'),(3,3,'create',0,'2015-02-19 08:09:04'),(4,4,'create',0,'2015-02-19 08:09:04'),(5,5,'create',0,'2015-02-19 08:09:04'),(6,6,'create',0,'2015-02-19 08:09:04');
/*!40000 ALTER TABLE `mag_dataflow_profile_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_dataflow_session`
--

DROP TABLE IF EXISTS `mag_dataflow_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_dataflow_session` (
  `session_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Session Id',
  `user_id` int(11) NOT NULL COMMENT 'User Id',
  `created_date` timestamp NULL DEFAULT NULL COMMENT 'Created Date',
  `file` varchar(255) DEFAULT NULL COMMENT 'File',
  `type` varchar(32) DEFAULT NULL COMMENT 'Type',
  `direction` varchar(32) DEFAULT NULL COMMENT 'Direction',
  `comment` varchar(255) DEFAULT NULL COMMENT 'Comment',
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Dataflow Session';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_dataflow_session`
--

LOCK TABLES `mag_dataflow_session` WRITE;
/*!40000 ALTER TABLE `mag_dataflow_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_dataflow_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_design_change`
--

DROP TABLE IF EXISTS `mag_design_change`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_design_change` (
  `design_change_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Design Change Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `design` varchar(255) DEFAULT NULL COMMENT 'Design',
  `date_from` date DEFAULT NULL COMMENT 'First Date of Design Activity',
  `date_to` date DEFAULT NULL COMMENT 'Last Date of Design Activity',
  PRIMARY KEY (`design_change_id`),
  KEY `IDX_MAG_DESIGN_CHANGE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MAG_DESIGN_CHANGE_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Design Changes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_design_change`
--

LOCK TABLES `mag_design_change` WRITE;
/*!40000 ALTER TABLE `mag_design_change` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_design_change` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_directory_country`
--

DROP TABLE IF EXISTS `mag_directory_country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_directory_country` (
  `country_id` varchar(2) NOT NULL DEFAULT '' COMMENT 'Country Id in ISO-2',
  `iso2_code` varchar(2) DEFAULT NULL COMMENT 'Country ISO-2 format',
  `iso3_code` varchar(3) DEFAULT NULL COMMENT 'Country ISO-3',
  PRIMARY KEY (`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Directory Country';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_directory_country`
--

LOCK TABLES `mag_directory_country` WRITE;
/*!40000 ALTER TABLE `mag_directory_country` DISABLE KEYS */;
INSERT INTO `mag_directory_country` VALUES ('AD','AD','AND'),('AE','AE','ARE'),('AF','AF','AFG'),('AG','AG','ATG'),('AI','AI','AIA'),('AL','AL','ALB'),('AM','AM','ARM'),('AN','AN','ANT'),('AO','AO','AGO'),('AQ','AQ','ATA'),('AR','AR','ARG'),('AS','AS','ASM'),('AT','AT','AUT'),('AU','AU','AUS'),('AW','AW','ABW'),('AX','AX','ALA'),('AZ','AZ','AZE'),('BA','BA','BIH'),('BB','BB','BRB'),('BD','BD','BGD'),('BE','BE','BEL'),('BF','BF','BFA'),('BG','BG','BGR'),('BH','BH','BHR'),('BI','BI','BDI'),('BJ','BJ','BEN'),('BL','BL','BLM'),('BM','BM','BMU'),('BN','BN','BRN'),('BO','BO','BOL'),('BR','BR','BRA'),('BS','BS','BHS'),('BT','BT','BTN'),('BV','BV','BVT'),('BW','BW','BWA'),('BY','BY','BLR'),('BZ','BZ','BLZ'),('CA','CA','CAN'),('CC','CC','CCK'),('CD','CD','COD'),('CF','CF','CAF'),('CG','CG','COG'),('CH','CH','CHE'),('CI','CI','CIV'),('CK','CK','COK'),('CL','CL','CHL'),('CM','CM','CMR'),('CN','CN','CHN'),('CO','CO','COL'),('CR','CR','CRI'),('CU','CU','CUB'),('CV','CV','CPV'),('CX','CX','CXR'),('CY','CY','CYP'),('CZ','CZ','CZE'),('DE','DE','DEU'),('DJ','DJ','DJI'),('DK','DK','DNK'),('DM','DM','DMA'),('DO','DO','DOM'),('DZ','DZ','DZA'),('EC','EC','ECU'),('EE','EE','EST'),('EG','EG','EGY'),('EH','EH','ESH'),('ER','ER','ERI'),('ES','ES','ESP'),('ET','ET','ETH'),('FI','FI','FIN'),('FJ','FJ','FJI'),('FK','FK','FLK'),('FM','FM','FSM'),('FO','FO','FRO'),('FR','FR','FRA'),('GA','GA','GAB'),('GB','GB','GBR'),('GD','GD','GRD'),('GE','GE','GEO'),('GF','GF','GUF'),('GG','GG','GGY'),('GH','GH','GHA'),('GI','GI','GIB'),('GL','GL','GRL'),('GM','GM','GMB'),('GN','GN','GIN'),('GP','GP','GLP'),('GQ','GQ','GNQ'),('GR','GR','GRC'),('GS','GS','SGS'),('GT','GT','GTM'),('GU','GU','GUM'),('GW','GW','GNB'),('GY','GY','GUY'),('HK','HK','HKG'),('HM','HM','HMD'),('HN','HN','HND'),('HR','HR','HRV'),('HT','HT','HTI'),('HU','HU','HUN'),('ID','ID','IDN'),('IE','IE','IRL'),('IL','IL','ISR'),('IM','IM','IMN'),('IN','IN','IND'),('IO','IO','IOT'),('IQ','IQ','IRQ'),('IR','IR','IRN'),('IS','IS','ISL'),('IT','IT','ITA'),('JE','JE','JEY'),('JM','JM','JAM'),('JO','JO','JOR'),('JP','JP','JPN'),('KE','KE','KEN'),('KG','KG','KGZ'),('KH','KH','KHM'),('KI','KI','KIR'),('KM','KM','COM'),('KN','KN','KNA'),('KP','KP','PRK'),('KR','KR','KOR'),('KW','KW','KWT'),('KY','KY','CYM'),('KZ','KZ','KAZ'),('LA','LA','LAO'),('LB','LB','LBN'),('LC','LC','LCA'),('LI','LI','LIE'),('LK','LK','LKA'),('LR','LR','LBR'),('LS','LS','LSO'),('LT','LT','LTU'),('LU','LU','LUX'),('LV','LV','LVA'),('LY','LY','LBY'),('MA','MA','MAR'),('MC','MC','MCO'),('MD','MD','MDA'),('ME','ME','MNE'),('MF','MF','MAF'),('MG','MG','MDG'),('MH','MH','MHL'),('MK','MK','MKD'),('ML','ML','MLI'),('MM','MM','MMR'),('MN','MN','MNG'),('MO','MO','MAC'),('MP','MP','MNP'),('MQ','MQ','MTQ'),('MR','MR','MRT'),('MS','MS','MSR'),('MT','MT','MLT'),('MU','MU','MUS'),('MV','MV','MDV'),('MW','MW','MWI'),('MX','MX','MEX'),('MY','MY','MYS'),('MZ','MZ','MOZ'),('NA','NA','NAM'),('NC','NC','NCL'),('NE','NE','NER'),('NF','NF','NFK'),('NG','NG','NGA'),('NI','NI','NIC'),('NL','NL','NLD'),('NO','NO','NOR'),('NP','NP','NPL'),('NR','NR','NRU'),('NU','NU','NIU'),('NZ','NZ','NZL'),('OM','OM','OMN'),('PA','PA','PAN'),('PE','PE','PER'),('PF','PF','PYF'),('PG','PG','PNG'),('PH','PH','PHL'),('PK','PK','PAK'),('PL','PL','POL'),('PM','PM','SPM'),('PN','PN','PCN'),('PR','PR','PRI'),('PS','PS','PSE'),('PT','PT','PRT'),('PW','PW','PLW'),('PY','PY','PRY'),('QA','QA','QAT'),('RE','RE','REU'),('RO','RO','ROU'),('RS','RS','SRB'),('RU','RU','RUS'),('RW','RW','RWA'),('SA','SA','SAU'),('SB','SB','SLB'),('SC','SC','SYC'),('SD','SD','SDN'),('SE','SE','SWE'),('SG','SG','SGP'),('SH','SH','SHN'),('SI','SI','SVN'),('SJ','SJ','SJM'),('SK','SK','SVK'),('SL','SL','SLE'),('SM','SM','SMR'),('SN','SN','SEN'),('SO','SO','SOM'),('SR','SR','SUR'),('ST','ST','STP'),('SV','SV','SLV'),('SY','SY','SYR'),('SZ','SZ','SWZ'),('TC','TC','TCA'),('TD','TD','TCD'),('TF','TF','ATF'),('TG','TG','TGO'),('TH','TH','THA'),('TJ','TJ','TJK'),('TK','TK','TKL'),('TL','TL','TLS'),('TM','TM','TKM'),('TN','TN','TUN'),('TO','TO','TON'),('TR','TR','TUR'),('TT','TT','TTO'),('TV','TV','TUV'),('TW','TW','TWN'),('TZ','TZ','TZA'),('UA','UA','UKR'),('UG','UG','UGA'),('UM','UM','UMI'),('US','US','USA'),('UY','UY','URY'),('UZ','UZ','UZB'),('VA','VA','VAT'),('VC','VC','VCT'),('VE','VE','VEN'),('VG','VG','VGB'),('VI','VI','VIR'),('VN','VN','VNM'),('VU','VU','VUT'),('WF','WF','WLF'),('WS','WS','WSM'),('YE','YE','YEM'),('YT','YT','MYT'),('ZA','ZA','ZAF'),('ZM','ZM','ZMB'),('ZW','ZW','ZWE');
/*!40000 ALTER TABLE `mag_directory_country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_directory_country_format`
--

DROP TABLE IF EXISTS `mag_directory_country_format`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_directory_country_format` (
  `country_format_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Country Format Id',
  `country_id` varchar(2) DEFAULT NULL COMMENT 'Country Id in ISO-2',
  `type` varchar(30) DEFAULT NULL COMMENT 'Country Format Type',
  `format` text NOT NULL COMMENT 'Country Format',
  PRIMARY KEY (`country_format_id`),
  UNIQUE KEY `UNQ_MAG_DIRECTORY_COUNTRY_FORMAT_COUNTRY_ID_TYPE` (`country_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Directory Country Format';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_directory_country_format`
--

LOCK TABLES `mag_directory_country_format` WRITE;
/*!40000 ALTER TABLE `mag_directory_country_format` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_directory_country_format` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_directory_country_region`
--

DROP TABLE IF EXISTS `mag_directory_country_region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_directory_country_region` (
  `region_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Region Id',
  `country_id` varchar(4) NOT NULL DEFAULT '0' COMMENT 'Country Id in ISO-2',
  `code` varchar(32) DEFAULT NULL COMMENT 'Region code',
  `default_name` varchar(255) DEFAULT NULL COMMENT 'Region Name',
  PRIMARY KEY (`region_id`),
  KEY `IDX_MAG_DIRECTORY_COUNTRY_REGION_COUNTRY_ID` (`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=485 DEFAULT CHARSET=utf8 COMMENT='Directory Country Region';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_directory_country_region`
--

LOCK TABLES `mag_directory_country_region` WRITE;
/*!40000 ALTER TABLE `mag_directory_country_region` DISABLE KEYS */;
INSERT INTO `mag_directory_country_region` VALUES (1,'US','AL','Alabama'),(2,'US','AK','Alaska'),(3,'US','AS','American Samoa'),(4,'US','AZ','Arizona'),(5,'US','AR','Arkansas'),(6,'US','AF','Armed Forces Africa'),(7,'US','AA','Armed Forces Americas'),(8,'US','AC','Armed Forces Canada'),(9,'US','AE','Armed Forces Europe'),(10,'US','AM','Armed Forces Middle East'),(11,'US','AP','Armed Forces Pacific'),(12,'US','CA','California'),(13,'US','CO','Colorado'),(14,'US','CT','Connecticut'),(15,'US','DE','Delaware'),(16,'US','DC','District of Columbia'),(17,'US','FM','Federated States Of Micronesia'),(18,'US','FL','Florida'),(19,'US','GA','Georgia'),(20,'US','GU','Guam'),(21,'US','HI','Hawaii'),(22,'US','ID','Idaho'),(23,'US','IL','Illinois'),(24,'US','IN','Indiana'),(25,'US','IA','Iowa'),(26,'US','KS','Kansas'),(27,'US','KY','Kentucky'),(28,'US','LA','Louisiana'),(29,'US','ME','Maine'),(30,'US','MH','Marshall Islands'),(31,'US','MD','Maryland'),(32,'US','MA','Massachusetts'),(33,'US','MI','Michigan'),(34,'US','MN','Minnesota'),(35,'US','MS','Mississippi'),(36,'US','MO','Missouri'),(37,'US','MT','Montana'),(38,'US','NE','Nebraska'),(39,'US','NV','Nevada'),(40,'US','NH','New Hampshire'),(41,'US','NJ','New Jersey'),(42,'US','NM','New Mexico'),(43,'US','NY','New York'),(44,'US','NC','North Carolina'),(45,'US','ND','North Dakota'),(46,'US','MP','Northern Mariana Islands'),(47,'US','OH','Ohio'),(48,'US','OK','Oklahoma'),(49,'US','OR','Oregon'),(50,'US','PW','Palau'),(51,'US','PA','Pennsylvania'),(52,'US','PR','Puerto Rico'),(53,'US','RI','Rhode Island'),(54,'US','SC','South Carolina'),(55,'US','SD','South Dakota'),(56,'US','TN','Tennessee'),(57,'US','TX','Texas'),(58,'US','UT','Utah'),(59,'US','VT','Vermont'),(60,'US','VI','Virgin Islands'),(61,'US','VA','Virginia'),(62,'US','WA','Washington'),(63,'US','WV','West Virginia'),(64,'US','WI','Wisconsin'),(65,'US','WY','Wyoming'),(66,'CA','AB','Alberta'),(67,'CA','BC','British Columbia'),(68,'CA','MB','Manitoba'),(69,'CA','NL','Newfoundland and Labrador'),(70,'CA','NB','New Brunswick'),(71,'CA','NS','Nova Scotia'),(72,'CA','NT','Northwest Territories'),(73,'CA','NU','Nunavut'),(74,'CA','ON','Ontario'),(75,'CA','PE','Prince Edward Island'),(76,'CA','QC','Quebec'),(77,'CA','SK','Saskatchewan'),(78,'CA','YT','Yukon Territory'),(79,'DE','NDS','Niedersachsen'),(80,'DE','BAW','Baden-Württemberg'),(81,'DE','BAY','Bayern'),(82,'DE','BER','Berlin'),(83,'DE','BRG','Brandenburg'),(84,'DE','BRE','Bremen'),(85,'DE','HAM','Hamburg'),(86,'DE','HES','Hessen'),(87,'DE','MEC','Mecklenburg-Vorpommern'),(88,'DE','NRW','Nordrhein-Westfalen'),(89,'DE','RHE','Rheinland-Pfalz'),(90,'DE','SAR','Saarland'),(91,'DE','SAS','Sachsen'),(92,'DE','SAC','Sachsen-Anhalt'),(93,'DE','SCN','Schleswig-Holstein'),(94,'DE','THE','Thüringen'),(95,'AT','WI','Wien'),(96,'AT','NO','Niederösterreich'),(97,'AT','OO','Oberösterreich'),(98,'AT','SB','Salzburg'),(99,'AT','KN','Kärnten'),(100,'AT','ST','Steiermark'),(101,'AT','TI','Tirol'),(102,'AT','BL','Burgenland'),(103,'AT','VB','Voralberg'),(104,'CH','AG','Aargau'),(105,'CH','AI','Appenzell Innerrhoden'),(106,'CH','AR','Appenzell Ausserrhoden'),(107,'CH','BE','Bern'),(108,'CH','BL','Basel-Landschaft'),(109,'CH','BS','Basel-Stadt'),(110,'CH','FR','Freiburg'),(111,'CH','GE','Genf'),(112,'CH','GL','Glarus'),(113,'CH','GR','Graubünden'),(114,'CH','JU','Jura'),(115,'CH','LU','Luzern'),(116,'CH','NE','Neuenburg'),(117,'CH','NW','Nidwalden'),(118,'CH','OW','Obwalden'),(119,'CH','SG','St. Gallen'),(120,'CH','SH','Schaffhausen'),(121,'CH','SO','Solothurn'),(122,'CH','SZ','Schwyz'),(123,'CH','TG','Thurgau'),(124,'CH','TI','Tessin'),(125,'CH','UR','Uri'),(126,'CH','VD','Waadt'),(127,'CH','VS','Wallis'),(128,'CH','ZG','Zug'),(129,'CH','ZH','Zürich'),(130,'ES','A Coruсa','A Coruña'),(131,'ES','Alava','Alava'),(132,'ES','Albacete','Albacete'),(133,'ES','Alicante','Alicante'),(134,'ES','Almeria','Almeria'),(135,'ES','Asturias','Asturias'),(136,'ES','Avila','Avila'),(137,'ES','Badajoz','Badajoz'),(138,'ES','Baleares','Baleares'),(139,'ES','Barcelona','Barcelona'),(140,'ES','Burgos','Burgos'),(141,'ES','Caceres','Caceres'),(142,'ES','Cadiz','Cadiz'),(143,'ES','Cantabria','Cantabria'),(144,'ES','Castellon','Castellon'),(145,'ES','Ceuta','Ceuta'),(146,'ES','Ciudad Real','Ciudad Real'),(147,'ES','Cordoba','Cordoba'),(148,'ES','Cuenca','Cuenca'),(149,'ES','Girona','Girona'),(150,'ES','Granada','Granada'),(151,'ES','Guadalajara','Guadalajara'),(152,'ES','Guipuzcoa','Guipuzcoa'),(153,'ES','Huelva','Huelva'),(154,'ES','Huesca','Huesca'),(155,'ES','Jaen','Jaen'),(156,'ES','La Rioja','La Rioja'),(157,'ES','Las Palmas','Las Palmas'),(158,'ES','Leon','Leon'),(159,'ES','Lleida','Lleida'),(160,'ES','Lugo','Lugo'),(161,'ES','Madrid','Madrid'),(162,'ES','Malaga','Malaga'),(163,'ES','Melilla','Melilla'),(164,'ES','Murcia','Murcia'),(165,'ES','Navarra','Navarra'),(166,'ES','Ourense','Ourense'),(167,'ES','Palencia','Palencia'),(168,'ES','Pontevedra','Pontevedra'),(169,'ES','Salamanca','Salamanca'),(170,'ES','Santa Cruz de Tenerife','Santa Cruz de Tenerife'),(171,'ES','Segovia','Segovia'),(172,'ES','Sevilla','Sevilla'),(173,'ES','Soria','Soria'),(174,'ES','Tarragona','Tarragona'),(175,'ES','Teruel','Teruel'),(176,'ES','Toledo','Toledo'),(177,'ES','Valencia','Valencia'),(178,'ES','Valladolid','Valladolid'),(179,'ES','Vizcaya','Vizcaya'),(180,'ES','Zamora','Zamora'),(181,'ES','Zaragoza','Zaragoza'),(182,'FR','1','Ain'),(183,'FR','2','Aisne'),(184,'FR','3','Allier'),(185,'FR','4','Alpes-de-Haute-Provence'),(186,'FR','5','Hautes-Alpes'),(187,'FR','6','Alpes-Maritimes'),(188,'FR','7','Ardèche'),(189,'FR','8','Ardennes'),(190,'FR','9','Ariège'),(191,'FR','10','Aube'),(192,'FR','11','Aude'),(193,'FR','12','Aveyron'),(194,'FR','13','Bouches-du-Rhône'),(195,'FR','14','Calvados'),(196,'FR','15','Cantal'),(197,'FR','16','Charente'),(198,'FR','17','Charente-Maritime'),(199,'FR','18','Cher'),(200,'FR','19','Corrèze'),(201,'FR','2A','Corse-du-Sud'),(202,'FR','2B','Haute-Corse'),(203,'FR','21','Côte-d\'Or'),(204,'FR','22','Côtes-d\'Armor'),(205,'FR','23','Creuse'),(206,'FR','24','Dordogne'),(207,'FR','25','Doubs'),(208,'FR','26','Drôme'),(209,'FR','27','Eure'),(210,'FR','28','Eure-et-Loir'),(211,'FR','29','Finistère'),(212,'FR','30','Gard'),(213,'FR','31','Haute-Garonne'),(214,'FR','32','Gers'),(215,'FR','33','Gironde'),(216,'FR','34','Hérault'),(217,'FR','35','Ille-et-Vilaine'),(218,'FR','36','Indre'),(219,'FR','37','Indre-et-Loire'),(220,'FR','38','Isère'),(221,'FR','39','Jura'),(222,'FR','40','Landes'),(223,'FR','41','Loir-et-Cher'),(224,'FR','42','Loire'),(225,'FR','43','Haute-Loire'),(226,'FR','44','Loire-Atlantique'),(227,'FR','45','Loiret'),(228,'FR','46','Lot'),(229,'FR','47','Lot-et-Garonne'),(230,'FR','48','Lozère'),(231,'FR','49','Maine-et-Loire'),(232,'FR','50','Manche'),(233,'FR','51','Marne'),(234,'FR','52','Haute-Marne'),(235,'FR','53','Mayenne'),(236,'FR','54','Meurthe-et-Moselle'),(237,'FR','55','Meuse'),(238,'FR','56','Morbihan'),(239,'FR','57','Moselle'),(240,'FR','58','Nièvre'),(241,'FR','59','Nord'),(242,'FR','60','Oise'),(243,'FR','61','Orne'),(244,'FR','62','Pas-de-Calais'),(245,'FR','63','Puy-de-Dôme'),(246,'FR','64','Pyrénées-Atlantiques'),(247,'FR','65','Hautes-Pyrénées'),(248,'FR','66','Pyrénées-Orientales'),(249,'FR','67','Bas-Rhin'),(250,'FR','68','Haut-Rhin'),(251,'FR','69','Rhône'),(252,'FR','70','Haute-Saône'),(253,'FR','71','Saône-et-Loire'),(254,'FR','72','Sarthe'),(255,'FR','73','Savoie'),(256,'FR','74','Haute-Savoie'),(257,'FR','75','Paris'),(258,'FR','76','Seine-Maritime'),(259,'FR','77','Seine-et-Marne'),(260,'FR','78','Yvelines'),(261,'FR','79','Deux-Sèvres'),(262,'FR','80','Somme'),(263,'FR','81','Tarn'),(264,'FR','82','Tarn-et-Garonne'),(265,'FR','83','Var'),(266,'FR','84','Vaucluse'),(267,'FR','85','Vendée'),(268,'FR','86','Vienne'),(269,'FR','87','Haute-Vienne'),(270,'FR','88','Vosges'),(271,'FR','89','Yonne'),(272,'FR','90','Territoire-de-Belfort'),(273,'FR','91','Essonne'),(274,'FR','92','Hauts-de-Seine'),(275,'FR','93','Seine-Saint-Denis'),(276,'FR','94','Val-de-Marne'),(277,'FR','95','Val-d\'Oise'),(278,'RO','AB','Alba'),(279,'RO','AR','Arad'),(280,'RO','AG','Argeş'),(281,'RO','BC','Bacău'),(282,'RO','BH','Bihor'),(283,'RO','BN','Bistriţa-Năsăud'),(284,'RO','BT','Botoşani'),(285,'RO','BV','Braşov'),(286,'RO','BR','Brăila'),(287,'RO','B','Bucureşti'),(288,'RO','BZ','Buzău'),(289,'RO','CS','Caraş-Severin'),(290,'RO','CL','Călăraşi'),(291,'RO','CJ','Cluj'),(292,'RO','CT','Constanţa'),(293,'RO','CV','Covasna'),(294,'RO','DB','Dâmboviţa'),(295,'RO','DJ','Dolj'),(296,'RO','GL','Galaţi'),(297,'RO','GR','Giurgiu'),(298,'RO','GJ','Gorj'),(299,'RO','HR','Harghita'),(300,'RO','HD','Hunedoara'),(301,'RO','IL','Ialomiţa'),(302,'RO','IS','Iaşi'),(303,'RO','IF','Ilfov'),(304,'RO','MM','Maramureş'),(305,'RO','MH','Mehedinţi'),(306,'RO','MS','Mureş'),(307,'RO','NT','Neamţ'),(308,'RO','OT','Olt'),(309,'RO','PH','Prahova'),(310,'RO','SM','Satu-Mare'),(311,'RO','SJ','Sălaj'),(312,'RO','SB','Sibiu'),(313,'RO','SV','Suceava'),(314,'RO','TR','Teleorman'),(315,'RO','TM','Timiş'),(316,'RO','TL','Tulcea'),(317,'RO','VS','Vaslui'),(318,'RO','VL','Vâlcea'),(319,'RO','VN','Vrancea'),(320,'FI','Lappi','Lappi'),(321,'FI','Pohjois-Pohjanmaa','Pohjois-Pohjanmaa'),(322,'FI','Kainuu','Kainuu'),(323,'FI','Pohjois-Karjala','Pohjois-Karjala'),(324,'FI','Pohjois-Savo','Pohjois-Savo'),(325,'FI','Etelä-Savo','Etelä-Savo'),(326,'FI','Etelä-Pohjanmaa','Etelä-Pohjanmaa'),(327,'FI','Pohjanmaa','Pohjanmaa'),(328,'FI','Pirkanmaa','Pirkanmaa'),(329,'FI','Satakunta','Satakunta'),(330,'FI','Keski-Pohjanmaa','Keski-Pohjanmaa'),(331,'FI','Keski-Suomi','Keski-Suomi'),(332,'FI','Varsinais-Suomi','Varsinais-Suomi'),(333,'FI','Etelä-Karjala','Etelä-Karjala'),(334,'FI','Päijät-Häme','Päijät-Häme'),(335,'FI','Kanta-Häme','Kanta-Häme'),(336,'FI','Uusimaa','Uusimaa'),(337,'FI','Itä-Uusimaa','Itä-Uusimaa'),(338,'FI','Kymenlaakso','Kymenlaakso'),(339,'FI','Ahvenanmaa','Ahvenanmaa'),(340,'EE','EE-37','Harjumaa'),(341,'EE','EE-39','Hiiumaa'),(342,'EE','EE-44','Ida-Virumaa'),(343,'EE','EE-49','Jõgevamaa'),(344,'EE','EE-51','Järvamaa'),(345,'EE','EE-57','Läänemaa'),(346,'EE','EE-59','Lääne-Virumaa'),(347,'EE','EE-65','Põlvamaa'),(348,'EE','EE-67','Pärnumaa'),(349,'EE','EE-70','Raplamaa'),(350,'EE','EE-74','Saaremaa'),(351,'EE','EE-78','Tartumaa'),(352,'EE','EE-82','Valgamaa'),(353,'EE','EE-84','Viljandimaa'),(354,'EE','EE-86','Võrumaa'),(355,'LV','LV-DGV','Daugavpils'),(356,'LV','LV-JEL','Jelgava'),(357,'LV','Jēkabpils','Jēkabpils'),(358,'LV','LV-JUR','Jūrmala'),(359,'LV','LV-LPX','Liepāja'),(360,'LV','LV-LE','Liepājas novads'),(361,'LV','LV-REZ','Rēzekne'),(362,'LV','LV-RIX','Rīga'),(363,'LV','LV-RI','Rīgas novads'),(364,'LV','Valmiera','Valmiera'),(365,'LV','LV-VEN','Ventspils'),(366,'LV','Aglonas novads','Aglonas novads'),(367,'LV','LV-AI','Aizkraukles novads'),(368,'LV','Aizputes novads','Aizputes novads'),(369,'LV','Aknīstes novads','Aknīstes novads'),(370,'LV','Alojas novads','Alojas novads'),(371,'LV','Alsungas novads','Alsungas novads'),(372,'LV','LV-AL','Alūksnes novads'),(373,'LV','Amatas novads','Amatas novads'),(374,'LV','Apes novads','Apes novads'),(375,'LV','Auces novads','Auces novads'),(376,'LV','Babītes novads','Babītes novads'),(377,'LV','Baldones novads','Baldones novads'),(378,'LV','Baltinavas novads','Baltinavas novads'),(379,'LV','LV-BL','Balvu novads'),(380,'LV','LV-BU','Bauskas novads'),(381,'LV','Beverīnas novads','Beverīnas novads'),(382,'LV','Brocēnu novads','Brocēnu novads'),(383,'LV','Burtnieku novads','Burtnieku novads'),(384,'LV','Carnikavas novads','Carnikavas novads'),(385,'LV','Cesvaines novads','Cesvaines novads'),(386,'LV','Ciblas novads','Ciblas novads'),(387,'LV','LV-CE','Cēsu novads'),(388,'LV','Dagdas novads','Dagdas novads'),(389,'LV','LV-DA','Daugavpils novads'),(390,'LV','LV-DO','Dobeles novads'),(391,'LV','Dundagas novads','Dundagas novads'),(392,'LV','Durbes novads','Durbes novads'),(393,'LV','Engures novads','Engures novads'),(394,'LV','Garkalnes novads','Garkalnes novads'),(395,'LV','Grobiņas novads','Grobiņas novads'),(396,'LV','LV-GU','Gulbenes novads'),(397,'LV','Iecavas novads','Iecavas novads'),(398,'LV','Ikšķiles novads','Ikšķiles novads'),(399,'LV','Ilūkstes novads','Ilūkstes novads'),(400,'LV','Inčukalna novads','Inčukalna novads'),(401,'LV','Jaunjelgavas novads','Jaunjelgavas novads'),(402,'LV','Jaunpiebalgas novads','Jaunpiebalgas novads'),(403,'LV','Jaunpils novads','Jaunpils novads'),(404,'LV','LV-JL','Jelgavas novads'),(405,'LV','LV-JK','Jēkabpils novads'),(406,'LV','Kandavas novads','Kandavas novads'),(407,'LV','Kokneses novads','Kokneses novads'),(408,'LV','Krimuldas novads','Krimuldas novads'),(409,'LV','Krustpils novads','Krustpils novads'),(410,'LV','LV-KR','Krāslavas novads'),(411,'LV','LV-KU','Kuldīgas novads'),(412,'LV','Kārsavas novads','Kārsavas novads'),(413,'LV','Lielvārdes novads','Lielvārdes novads'),(414,'LV','LV-LM','Limbažu novads'),(415,'LV','Lubānas novads','Lubānas novads'),(416,'LV','LV-LU','Ludzas novads'),(417,'LV','Līgatnes novads','Līgatnes novads'),(418,'LV','Līvānu novads','Līvānu novads'),(419,'LV','LV-MA','Madonas novads'),(420,'LV','Mazsalacas novads','Mazsalacas novads'),(421,'LV','Mālpils novads','Mālpils novads'),(422,'LV','Mārupes novads','Mārupes novads'),(423,'LV','Naukšēnu novads','Naukšēnu novads'),(424,'LV','Neretas novads','Neretas novads'),(425,'LV','Nīcas novads','Nīcas novads'),(426,'LV','LV-OG','Ogres novads'),(427,'LV','Olaines novads','Olaines novads'),(428,'LV','Ozolnieku novads','Ozolnieku novads'),(429,'LV','LV-PR','Preiļu novads'),(430,'LV','Priekules novads','Priekules novads'),(431,'LV','Priekuļu novads','Priekuļu novads'),(432,'LV','Pārgaujas novads','Pārgaujas novads'),(433,'LV','Pāvilostas novads','Pāvilostas novads'),(434,'LV','Pļaviņu novads','Pļaviņu novads'),(435,'LV','Raunas novads','Raunas novads'),(436,'LV','Riebiņu novads','Riebiņu novads'),(437,'LV','Rojas novads','Rojas novads'),(438,'LV','Ropažu novads','Ropažu novads'),(439,'LV','Rucavas novads','Rucavas novads'),(440,'LV','Rugāju novads','Rugāju novads'),(441,'LV','Rundāles novads','Rundāles novads'),(442,'LV','LV-RE','Rēzeknes novads'),(443,'LV','Rūjienas novads','Rūjienas novads'),(444,'LV','Salacgrīvas novads','Salacgrīvas novads'),(445,'LV','Salas novads','Salas novads'),(446,'LV','Salaspils novads','Salaspils novads'),(447,'LV','LV-SA','Saldus novads'),(448,'LV','Saulkrastu novads','Saulkrastu novads'),(449,'LV','Siguldas novads','Siguldas novads'),(450,'LV','Skrundas novads','Skrundas novads'),(451,'LV','Skrīveru novads','Skrīveru novads'),(452,'LV','Smiltenes novads','Smiltenes novads'),(453,'LV','Stopiņu novads','Stopiņu novads'),(454,'LV','Strenču novads','Strenču novads'),(455,'LV','Sējas novads','Sējas novads'),(456,'LV','LV-TA','Talsu novads'),(457,'LV','LV-TU','Tukuma novads'),(458,'LV','Tērvetes novads','Tērvetes novads'),(459,'LV','Vaiņodes novads','Vaiņodes novads'),(460,'LV','LV-VK','Valkas novads'),(461,'LV','LV-VM','Valmieras novads'),(462,'LV','Varakļānu novads','Varakļānu novads'),(463,'LV','Vecpiebalgas novads','Vecpiebalgas novads'),(464,'LV','Vecumnieku novads','Vecumnieku novads'),(465,'LV','LV-VE','Ventspils novads'),(466,'LV','Viesītes novads','Viesītes novads'),(467,'LV','Viļakas novads','Viļakas novads'),(468,'LV','Viļānu novads','Viļānu novads'),(469,'LV','Vārkavas novads','Vārkavas novads'),(470,'LV','Zilupes novads','Zilupes novads'),(471,'LV','Ādažu novads','Ādažu novads'),(472,'LV','Ērgļu novads','Ērgļu novads'),(473,'LV','Ķeguma novads','Ķeguma novads'),(474,'LV','Ķekavas novads','Ķekavas novads'),(475,'LT','LT-AL','Alytaus Apskritis'),(476,'LT','LT-KU','Kauno Apskritis'),(477,'LT','LT-KL','Klaipėdos Apskritis'),(478,'LT','LT-MR','Marijampolės Apskritis'),(479,'LT','LT-PN','Panevėžio Apskritis'),(480,'LT','LT-SA','Šiaulių Apskritis'),(481,'LT','LT-TA','Tauragės Apskritis'),(482,'LT','LT-TE','Telšių Apskritis'),(483,'LT','LT-UT','Utenos Apskritis'),(484,'LT','LT-VL','Vilniaus Apskritis');
/*!40000 ALTER TABLE `mag_directory_country_region` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_directory_country_region_name`
--

DROP TABLE IF EXISTS `mag_directory_country_region_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_directory_country_region_name` (
  `locale` varchar(8) NOT NULL DEFAULT '' COMMENT 'Locale',
  `region_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Region Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Region Name',
  PRIMARY KEY (`locale`,`region_id`),
  KEY `IDX_MAG_DIRECTORY_COUNTRY_REGION_NAME_REGION_ID` (`region_id`),
  CONSTRAINT `FK_5A1AD82B7E2209528777D483360F9057` FOREIGN KEY (`region_id`) REFERENCES `mag_directory_country_region` (`region_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Directory Country Region Name';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_directory_country_region_name`
--

LOCK TABLES `mag_directory_country_region_name` WRITE;
/*!40000 ALTER TABLE `mag_directory_country_region_name` DISABLE KEYS */;
INSERT INTO `mag_directory_country_region_name` VALUES ('en_US',1,'Alabama'),('en_US',2,'Alaska'),('en_US',3,'American Samoa'),('en_US',4,'Arizona'),('en_US',5,'Arkansas'),('en_US',6,'Armed Forces Africa'),('en_US',7,'Armed Forces Americas'),('en_US',8,'Armed Forces Canada'),('en_US',9,'Armed Forces Europe'),('en_US',10,'Armed Forces Middle East'),('en_US',11,'Armed Forces Pacific'),('en_US',12,'California'),('en_US',13,'Colorado'),('en_US',14,'Connecticut'),('en_US',15,'Delaware'),('en_US',16,'District of Columbia'),('en_US',17,'Federated States Of Micronesia'),('en_US',18,'Florida'),('en_US',19,'Georgia'),('en_US',20,'Guam'),('en_US',21,'Hawaii'),('en_US',22,'Idaho'),('en_US',23,'Illinois'),('en_US',24,'Indiana'),('en_US',25,'Iowa'),('en_US',26,'Kansas'),('en_US',27,'Kentucky'),('en_US',28,'Louisiana'),('en_US',29,'Maine'),('en_US',30,'Marshall Islands'),('en_US',31,'Maryland'),('en_US',32,'Massachusetts'),('en_US',33,'Michigan'),('en_US',34,'Minnesota'),('en_US',35,'Mississippi'),('en_US',36,'Missouri'),('en_US',37,'Montana'),('en_US',38,'Nebraska'),('en_US',39,'Nevada'),('en_US',40,'New Hampshire'),('en_US',41,'New Jersey'),('en_US',42,'New Mexico'),('en_US',43,'New York'),('en_US',44,'North Carolina'),('en_US',45,'North Dakota'),('en_US',46,'Northern Mariana Islands'),('en_US',47,'Ohio'),('en_US',48,'Oklahoma'),('en_US',49,'Oregon'),('en_US',50,'Palau'),('en_US',51,'Pennsylvania'),('en_US',52,'Puerto Rico'),('en_US',53,'Rhode Island'),('en_US',54,'South Carolina'),('en_US',55,'South Dakota'),('en_US',56,'Tennessee'),('en_US',57,'Texas'),('en_US',58,'Utah'),('en_US',59,'Vermont'),('en_US',60,'Virgin Islands'),('en_US',61,'Virginia'),('en_US',62,'Washington'),('en_US',63,'West Virginia'),('en_US',64,'Wisconsin'),('en_US',65,'Wyoming'),('en_US',66,'Alberta'),('en_US',67,'British Columbia'),('en_US',68,'Manitoba'),('en_US',69,'Newfoundland and Labrador'),('en_US',70,'New Brunswick'),('en_US',71,'Nova Scotia'),('en_US',72,'Northwest Territories'),('en_US',73,'Nunavut'),('en_US',74,'Ontario'),('en_US',75,'Prince Edward Island'),('en_US',76,'Quebec'),('en_US',77,'Saskatchewan'),('en_US',78,'Yukon Territory'),('en_US',79,'Niedersachsen'),('en_US',80,'Baden-Württemberg'),('en_US',81,'Bayern'),('en_US',82,'Berlin'),('en_US',83,'Brandenburg'),('en_US',84,'Bremen'),('en_US',85,'Hamburg'),('en_US',86,'Hessen'),('en_US',87,'Mecklenburg-Vorpommern'),('en_US',88,'Nordrhein-Westfalen'),('en_US',89,'Rheinland-Pfalz'),('en_US',90,'Saarland'),('en_US',91,'Sachsen'),('en_US',92,'Sachsen-Anhalt'),('en_US',93,'Schleswig-Holstein'),('en_US',94,'Thüringen'),('en_US',95,'Wien'),('en_US',96,'Niederösterreich'),('en_US',97,'Oberösterreich'),('en_US',98,'Salzburg'),('en_US',99,'Kärnten'),('en_US',100,'Steiermark'),('en_US',101,'Tirol'),('en_US',102,'Burgenland'),('en_US',103,'Voralberg'),('en_US',104,'Aargau'),('en_US',105,'Appenzell Innerrhoden'),('en_US',106,'Appenzell Ausserrhoden'),('en_US',107,'Bern'),('en_US',108,'Basel-Landschaft'),('en_US',109,'Basel-Stadt'),('en_US',110,'Freiburg'),('en_US',111,'Genf'),('en_US',112,'Glarus'),('en_US',113,'Graubünden'),('en_US',114,'Jura'),('en_US',115,'Luzern'),('en_US',116,'Neuenburg'),('en_US',117,'Nidwalden'),('en_US',118,'Obwalden'),('en_US',119,'St. Gallen'),('en_US',120,'Schaffhausen'),('en_US',121,'Solothurn'),('en_US',122,'Schwyz'),('en_US',123,'Thurgau'),('en_US',124,'Tessin'),('en_US',125,'Uri'),('en_US',126,'Waadt'),('en_US',127,'Wallis'),('en_US',128,'Zug'),('en_US',129,'Zürich'),('en_US',130,'A Coruña'),('en_US',131,'Alava'),('en_US',132,'Albacete'),('en_US',133,'Alicante'),('en_US',134,'Almeria'),('en_US',135,'Asturias'),('en_US',136,'Avila'),('en_US',137,'Badajoz'),('en_US',138,'Baleares'),('en_US',139,'Barcelona'),('en_US',140,'Burgos'),('en_US',141,'Caceres'),('en_US',142,'Cadiz'),('en_US',143,'Cantabria'),('en_US',144,'Castellon'),('en_US',145,'Ceuta'),('en_US',146,'Ciudad Real'),('en_US',147,'Cordoba'),('en_US',148,'Cuenca'),('en_US',149,'Girona'),('en_US',150,'Granada'),('en_US',151,'Guadalajara'),('en_US',152,'Guipuzcoa'),('en_US',153,'Huelva'),('en_US',154,'Huesca'),('en_US',155,'Jaen'),('en_US',156,'La Rioja'),('en_US',157,'Las Palmas'),('en_US',158,'Leon'),('en_US',159,'Lleida'),('en_US',160,'Lugo'),('en_US',161,'Madrid'),('en_US',162,'Malaga'),('en_US',163,'Melilla'),('en_US',164,'Murcia'),('en_US',165,'Navarra'),('en_US',166,'Ourense'),('en_US',167,'Palencia'),('en_US',168,'Pontevedra'),('en_US',169,'Salamanca'),('en_US',170,'Santa Cruz de Tenerife'),('en_US',171,'Segovia'),('en_US',172,'Sevilla'),('en_US',173,'Soria'),('en_US',174,'Tarragona'),('en_US',175,'Teruel'),('en_US',176,'Toledo'),('en_US',177,'Valencia'),('en_US',178,'Valladolid'),('en_US',179,'Vizcaya'),('en_US',180,'Zamora'),('en_US',181,'Zaragoza'),('en_US',182,'Ain'),('en_US',183,'Aisne'),('en_US',184,'Allier'),('en_US',185,'Alpes-de-Haute-Provence'),('en_US',186,'Hautes-Alpes'),('en_US',187,'Alpes-Maritimes'),('en_US',188,'Ardèche'),('en_US',189,'Ardennes'),('en_US',190,'Ariège'),('en_US',191,'Aube'),('en_US',192,'Aude'),('en_US',193,'Aveyron'),('en_US',194,'Bouches-du-Rhône'),('en_US',195,'Calvados'),('en_US',196,'Cantal'),('en_US',197,'Charente'),('en_US',198,'Charente-Maritime'),('en_US',199,'Cher'),('en_US',200,'Corrèze'),('en_US',201,'Corse-du-Sud'),('en_US',202,'Haute-Corse'),('en_US',203,'Côte-d\'Or'),('en_US',204,'Côtes-d\'Armor'),('en_US',205,'Creuse'),('en_US',206,'Dordogne'),('en_US',207,'Doubs'),('en_US',208,'Drôme'),('en_US',209,'Eure'),('en_US',210,'Eure-et-Loir'),('en_US',211,'Finistère'),('en_US',212,'Gard'),('en_US',213,'Haute-Garonne'),('en_US',214,'Gers'),('en_US',215,'Gironde'),('en_US',216,'Hérault'),('en_US',217,'Ille-et-Vilaine'),('en_US',218,'Indre'),('en_US',219,'Indre-et-Loire'),('en_US',220,'Isère'),('en_US',221,'Jura'),('en_US',222,'Landes'),('en_US',223,'Loir-et-Cher'),('en_US',224,'Loire'),('en_US',225,'Haute-Loire'),('en_US',226,'Loire-Atlantique'),('en_US',227,'Loiret'),('en_US',228,'Lot'),('en_US',229,'Lot-et-Garonne'),('en_US',230,'Lozère'),('en_US',231,'Maine-et-Loire'),('en_US',232,'Manche'),('en_US',233,'Marne'),('en_US',234,'Haute-Marne'),('en_US',235,'Mayenne'),('en_US',236,'Meurthe-et-Moselle'),('en_US',237,'Meuse'),('en_US',238,'Morbihan'),('en_US',239,'Moselle'),('en_US',240,'Nièvre'),('en_US',241,'Nord'),('en_US',242,'Oise'),('en_US',243,'Orne'),('en_US',244,'Pas-de-Calais'),('en_US',245,'Puy-de-Dôme'),('en_US',246,'Pyrénées-Atlantiques'),('en_US',247,'Hautes-Pyrénées'),('en_US',248,'Pyrénées-Orientales'),('en_US',249,'Bas-Rhin'),('en_US',250,'Haut-Rhin'),('en_US',251,'Rhône'),('en_US',252,'Haute-Saône'),('en_US',253,'Saône-et-Loire'),('en_US',254,'Sarthe'),('en_US',255,'Savoie'),('en_US',256,'Haute-Savoie'),('en_US',257,'Paris'),('en_US',258,'Seine-Maritime'),('en_US',259,'Seine-et-Marne'),('en_US',260,'Yvelines'),('en_US',261,'Deux-Sèvres'),('en_US',262,'Somme'),('en_US',263,'Tarn'),('en_US',264,'Tarn-et-Garonne'),('en_US',265,'Var'),('en_US',266,'Vaucluse'),('en_US',267,'Vendée'),('en_US',268,'Vienne'),('en_US',269,'Haute-Vienne'),('en_US',270,'Vosges'),('en_US',271,'Yonne'),('en_US',272,'Territoire-de-Belfort'),('en_US',273,'Essonne'),('en_US',274,'Hauts-de-Seine'),('en_US',275,'Seine-Saint-Denis'),('en_US',276,'Val-de-Marne'),('en_US',277,'Val-d\'Oise'),('en_US',278,'Alba'),('en_US',279,'Arad'),('en_US',280,'Argeş'),('en_US',281,'Bacău'),('en_US',282,'Bihor'),('en_US',283,'Bistriţa-Năsăud'),('en_US',284,'Botoşani'),('en_US',285,'Braşov'),('en_US',286,'Brăila'),('en_US',287,'Bucureşti'),('en_US',288,'Buzău'),('en_US',289,'Caraş-Severin'),('en_US',290,'Călăraşi'),('en_US',291,'Cluj'),('en_US',292,'Constanţa'),('en_US',293,'Covasna'),('en_US',294,'Dâmboviţa'),('en_US',295,'Dolj'),('en_US',296,'Galaţi'),('en_US',297,'Giurgiu'),('en_US',298,'Gorj'),('en_US',299,'Harghita'),('en_US',300,'Hunedoara'),('en_US',301,'Ialomiţa'),('en_US',302,'Iaşi'),('en_US',303,'Ilfov'),('en_US',304,'Maramureş'),('en_US',305,'Mehedinţi'),('en_US',306,'Mureş'),('en_US',307,'Neamţ'),('en_US',308,'Olt'),('en_US',309,'Prahova'),('en_US',310,'Satu-Mare'),('en_US',311,'Sălaj'),('en_US',312,'Sibiu'),('en_US',313,'Suceava'),('en_US',314,'Teleorman'),('en_US',315,'Timiş'),('en_US',316,'Tulcea'),('en_US',317,'Vaslui'),('en_US',318,'Vâlcea'),('en_US',319,'Vrancea'),('en_US',320,'Lappi'),('en_US',321,'Pohjois-Pohjanmaa'),('en_US',322,'Kainuu'),('en_US',323,'Pohjois-Karjala'),('en_US',324,'Pohjois-Savo'),('en_US',325,'Etelä-Savo'),('en_US',326,'Etelä-Pohjanmaa'),('en_US',327,'Pohjanmaa'),('en_US',328,'Pirkanmaa'),('en_US',329,'Satakunta'),('en_US',330,'Keski-Pohjanmaa'),('en_US',331,'Keski-Suomi'),('en_US',332,'Varsinais-Suomi'),('en_US',333,'Etelä-Karjala'),('en_US',334,'Päijät-Häme'),('en_US',335,'Kanta-Häme'),('en_US',336,'Uusimaa'),('en_US',337,'Itä-Uusimaa'),('en_US',338,'Kymenlaakso'),('en_US',339,'Ahvenanmaa'),('en_US',340,'Harjumaa'),('en_US',341,'Hiiumaa'),('en_US',342,'Ida-Virumaa'),('en_US',343,'Jõgevamaa'),('en_US',344,'Järvamaa'),('en_US',345,'Läänemaa'),('en_US',346,'Lääne-Virumaa'),('en_US',347,'Põlvamaa'),('en_US',348,'Pärnumaa'),('en_US',349,'Raplamaa'),('en_US',350,'Saaremaa'),('en_US',351,'Tartumaa'),('en_US',352,'Valgamaa'),('en_US',353,'Viljandimaa'),('en_US',354,'Võrumaa'),('en_US',355,'Daugavpils'),('en_US',356,'Jelgava'),('en_US',357,'Jēkabpils'),('en_US',358,'Jūrmala'),('en_US',359,'Liepāja'),('en_US',360,'Liepājas novads'),('en_US',361,'Rēzekne'),('en_US',362,'Rīga'),('en_US',363,'Rīgas novads'),('en_US',364,'Valmiera'),('en_US',365,'Ventspils'),('en_US',366,'Aglonas novads'),('en_US',367,'Aizkraukles novads'),('en_US',368,'Aizputes novads'),('en_US',369,'Aknīstes novads'),('en_US',370,'Alojas novads'),('en_US',371,'Alsungas novads'),('en_US',372,'Alūksnes novads'),('en_US',373,'Amatas novads'),('en_US',374,'Apes novads'),('en_US',375,'Auces novads'),('en_US',376,'Babītes novads'),('en_US',377,'Baldones novads'),('en_US',378,'Baltinavas novads'),('en_US',379,'Balvu novads'),('en_US',380,'Bauskas novads'),('en_US',381,'Beverīnas novads'),('en_US',382,'Brocēnu novads'),('en_US',383,'Burtnieku novads'),('en_US',384,'Carnikavas novads'),('en_US',385,'Cesvaines novads'),('en_US',386,'Ciblas novads'),('en_US',387,'Cēsu novads'),('en_US',388,'Dagdas novads'),('en_US',389,'Daugavpils novads'),('en_US',390,'Dobeles novads'),('en_US',391,'Dundagas novads'),('en_US',392,'Durbes novads'),('en_US',393,'Engures novads'),('en_US',394,'Garkalnes novads'),('en_US',395,'Grobiņas novads'),('en_US',396,'Gulbenes novads'),('en_US',397,'Iecavas novads'),('en_US',398,'Ikšķiles novads'),('en_US',399,'Ilūkstes novads'),('en_US',400,'Inčukalna novads'),('en_US',401,'Jaunjelgavas novads'),('en_US',402,'Jaunpiebalgas novads'),('en_US',403,'Jaunpils novads'),('en_US',404,'Jelgavas novads'),('en_US',405,'Jēkabpils novads'),('en_US',406,'Kandavas novads'),('en_US',407,'Kokneses novads'),('en_US',408,'Krimuldas novads'),('en_US',409,'Krustpils novads'),('en_US',410,'Krāslavas novads'),('en_US',411,'Kuldīgas novads'),('en_US',412,'Kārsavas novads'),('en_US',413,'Lielvārdes novads'),('en_US',414,'Limbažu novads'),('en_US',415,'Lubānas novads'),('en_US',416,'Ludzas novads'),('en_US',417,'Līgatnes novads'),('en_US',418,'Līvānu novads'),('en_US',419,'Madonas novads'),('en_US',420,'Mazsalacas novads'),('en_US',421,'Mālpils novads'),('en_US',422,'Mārupes novads'),('en_US',423,'Naukšēnu novads'),('en_US',424,'Neretas novads'),('en_US',425,'Nīcas novads'),('en_US',426,'Ogres novads'),('en_US',427,'Olaines novads'),('en_US',428,'Ozolnieku novads'),('en_US',429,'Preiļu novads'),('en_US',430,'Priekules novads'),('en_US',431,'Priekuļu novads'),('en_US',432,'Pārgaujas novads'),('en_US',433,'Pāvilostas novads'),('en_US',434,'Pļaviņu novads'),('en_US',435,'Raunas novads'),('en_US',436,'Riebiņu novads'),('en_US',437,'Rojas novads'),('en_US',438,'Ropažu novads'),('en_US',439,'Rucavas novads'),('en_US',440,'Rugāju novads'),('en_US',441,'Rundāles novads'),('en_US',442,'Rēzeknes novads'),('en_US',443,'Rūjienas novads'),('en_US',444,'Salacgrīvas novads'),('en_US',445,'Salas novads'),('en_US',446,'Salaspils novads'),('en_US',447,'Saldus novads'),('en_US',448,'Saulkrastu novads'),('en_US',449,'Siguldas novads'),('en_US',450,'Skrundas novads'),('en_US',451,'Skrīveru novads'),('en_US',452,'Smiltenes novads'),('en_US',453,'Stopiņu novads'),('en_US',454,'Strenču novads'),('en_US',455,'Sējas novads'),('en_US',456,'Talsu novads'),('en_US',457,'Tukuma novads'),('en_US',458,'Tērvetes novads'),('en_US',459,'Vaiņodes novads'),('en_US',460,'Valkas novads'),('en_US',461,'Valmieras novads'),('en_US',462,'Varakļānu novads'),('en_US',463,'Vecpiebalgas novads'),('en_US',464,'Vecumnieku novads'),('en_US',465,'Ventspils novads'),('en_US',466,'Viesītes novads'),('en_US',467,'Viļakas novads'),('en_US',468,'Viļānu novads'),('en_US',469,'Vārkavas novads'),('en_US',470,'Zilupes novads'),('en_US',471,'Ādažu novads'),('en_US',472,'Ērgļu novads'),('en_US',473,'Ķeguma novads'),('en_US',474,'Ķekavas novads'),('en_US',475,'Alytaus Apskritis'),('en_US',476,'Kauno Apskritis'),('en_US',477,'Klaipėdos Apskritis'),('en_US',478,'Marijampolės Apskritis'),('en_US',479,'Panevėžio Apskritis'),('en_US',480,'Šiaulių Apskritis'),('en_US',481,'Tauragės Apskritis'),('en_US',482,'Telšių Apskritis'),('en_US',483,'Utenos Apskritis'),('en_US',484,'Vilniaus Apskritis');
/*!40000 ALTER TABLE `mag_directory_country_region_name` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_directory_currency_rate`
--

DROP TABLE IF EXISTS `mag_directory_currency_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_directory_currency_rate` (
  `currency_from` varchar(3) NOT NULL DEFAULT '' COMMENT 'Currency Code Convert From',
  `currency_to` varchar(3) NOT NULL DEFAULT '' COMMENT 'Currency Code Convert To',
  `rate` decimal(24,12) NOT NULL DEFAULT '0.000000000000' COMMENT 'Currency Conversion Rate',
  PRIMARY KEY (`currency_from`,`currency_to`),
  KEY `IDX_MAG_DIRECTORY_CURRENCY_RATE_CURRENCY_TO` (`currency_to`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Directory Currency Rate';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_directory_currency_rate`
--

LOCK TABLES `mag_directory_currency_rate` WRITE;
/*!40000 ALTER TABLE `mag_directory_currency_rate` DISABLE KEYS */;
INSERT INTO `mag_directory_currency_rate` VALUES ('EUR','EUR',1.000000000000),('EUR','USD',1.415000000000),('USD','EUR',0.706700000000),('USD','USD',1.000000000000);
/*!40000 ALTER TABLE `mag_directory_currency_rate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_downloadable_link`
--

DROP TABLE IF EXISTS `mag_downloadable_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_downloadable_link` (
  `link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Link ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort order',
  `number_of_downloads` int(11) DEFAULT NULL COMMENT 'Number of downloads',
  `is_shareable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Shareable flag',
  `link_url` varchar(255) DEFAULT NULL COMMENT 'Link Url',
  `link_file` varchar(255) DEFAULT NULL COMMENT 'Link File',
  `link_type` varchar(20) DEFAULT NULL COMMENT 'Link Type',
  `sample_url` varchar(255) DEFAULT NULL COMMENT 'Sample Url',
  `sample_file` varchar(255) DEFAULT NULL COMMENT 'Sample File',
  `sample_type` varchar(20) DEFAULT NULL COMMENT 'Sample Type',
  PRIMARY KEY (`link_id`),
  KEY `IDX_MAG_DOWNLOADABLE_LINK_PRODUCT_ID` (`product_id`),
  KEY `IDX_MAG_DOWNLOADABLE_LINK_PRODUCT_ID_SORT_ORDER` (`product_id`,`sort_order`),
  CONSTRAINT `FK_MAG_DL_LNK_PRD_ID_MAG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Downloadable Link Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_downloadable_link`
--

LOCK TABLES `mag_downloadable_link` WRITE;
/*!40000 ALTER TABLE `mag_downloadable_link` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_downloadable_link` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_downloadable_link_price`
--

DROP TABLE IF EXISTS `mag_downloadable_link_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_downloadable_link_price` (
  `price_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Price ID',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Link ID',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website ID',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  PRIMARY KEY (`price_id`),
  KEY `IDX_MAG_DOWNLOADABLE_LINK_PRICE_LINK_ID` (`link_id`),
  KEY `IDX_MAG_DOWNLOADABLE_LINK_PRICE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_MAG_DL_LNK_PRICE_LNK_ID_MAG_DL_LNK_LNK_ID` FOREIGN KEY (`link_id`) REFERENCES `mag_downloadable_link` (`link_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_DL_LNK_PRICE_WS_ID_MAG_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `mag_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Downloadable Link Price Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_downloadable_link_price`
--

LOCK TABLES `mag_downloadable_link_price` WRITE;
/*!40000 ALTER TABLE `mag_downloadable_link_price` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_downloadable_link_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_downloadable_link_purchased`
--

DROP TABLE IF EXISTS `mag_downloadable_link_purchased`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_downloadable_link_purchased` (
  `purchased_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Purchased ID',
  `order_id` int(10) unsigned DEFAULT '0' COMMENT 'Order ID',
  `order_increment_id` varchar(50) DEFAULT NULL COMMENT 'Order Increment ID',
  `order_item_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Order Item ID',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Date of creation',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Date of modification',
  `customer_id` int(10) unsigned DEFAULT '0' COMMENT 'Customer ID',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product name',
  `product_sku` varchar(255) DEFAULT NULL COMMENT 'Product sku',
  `link_section_title` varchar(255) DEFAULT NULL COMMENT 'Link_section_title',
  PRIMARY KEY (`purchased_id`),
  KEY `IDX_MAG_DOWNLOADABLE_LINK_PURCHASED_ORDER_ID` (`order_id`),
  KEY `IDX_MAG_DOWNLOADABLE_LINK_PURCHASED_ORDER_ITEM_ID` (`order_item_id`),
  KEY `IDX_MAG_DOWNLOADABLE_LINK_PURCHASED_CUSTOMER_ID` (`customer_id`),
  CONSTRAINT `FK_MAG_DL_LNK_PURCHASED_CSTR_ID_MAG_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `mag_customer_entity` (`entity_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_DL_LNK_PURCHASED_ORDER_ID_MAG_SALES_FLAT_ORDER_ENTT_ID` FOREIGN KEY (`order_id`) REFERENCES `mag_sales_flat_order` (`entity_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Downloadable Link Purchased Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_downloadable_link_purchased`
--

LOCK TABLES `mag_downloadable_link_purchased` WRITE;
/*!40000 ALTER TABLE `mag_downloadable_link_purchased` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_downloadable_link_purchased` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_downloadable_link_purchased_item`
--

DROP TABLE IF EXISTS `mag_downloadable_link_purchased_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_downloadable_link_purchased_item` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Item ID',
  `purchased_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Purchased ID',
  `order_item_id` int(10) unsigned DEFAULT '0' COMMENT 'Order Item ID',
  `product_id` int(10) unsigned DEFAULT '0' COMMENT 'Product ID',
  `link_hash` varchar(255) DEFAULT NULL COMMENT 'Link hash',
  `number_of_downloads_bought` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Number of downloads bought',
  `number_of_downloads_used` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Number of downloads used',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Link ID',
  `link_title` varchar(255) DEFAULT NULL COMMENT 'Link Title',
  `is_shareable` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Shareable Flag',
  `link_url` varchar(255) DEFAULT NULL COMMENT 'Link Url',
  `link_file` varchar(255) DEFAULT NULL COMMENT 'Link File',
  `link_type` varchar(255) DEFAULT NULL COMMENT 'Link Type',
  `status` varchar(50) DEFAULT NULL COMMENT 'Status',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Creation Time',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Update Time',
  PRIMARY KEY (`item_id`),
  KEY `IDX_MAG_DOWNLOADABLE_LINK_PURCHASED_ITEM_LINK_HASH` (`link_hash`),
  KEY `IDX_MAG_DOWNLOADABLE_LINK_PURCHASED_ITEM_ORDER_ITEM_ID` (`order_item_id`),
  KEY `IDX_MAG_DOWNLOADABLE_LINK_PURCHASED_ITEM_PURCHASED_ID` (`purchased_id`),
  CONSTRAINT `FK_23B0EC09EC85A5C12F73EA9C2EF33038` FOREIGN KEY (`order_item_id`) REFERENCES `mag_sales_flat_order_item` (`item_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_704B4742838093783499609F0F4A8B8B` FOREIGN KEY (`purchased_id`) REFERENCES `mag_downloadable_link_purchased` (`purchased_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Downloadable Link Purchased Item Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_downloadable_link_purchased_item`
--

LOCK TABLES `mag_downloadable_link_purchased_item` WRITE;
/*!40000 ALTER TABLE `mag_downloadable_link_purchased_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_downloadable_link_purchased_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_downloadable_link_title`
--

DROP TABLE IF EXISTS `mag_downloadable_link_title`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_downloadable_link_title` (
  `title_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Title ID',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Link ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  PRIMARY KEY (`title_id`),
  UNIQUE KEY `UNQ_MAG_DOWNLOADABLE_LINK_TITLE_LINK_ID_STORE_ID` (`link_id`,`store_id`),
  KEY `IDX_MAG_DOWNLOADABLE_LINK_TITLE_LINK_ID` (`link_id`),
  KEY `IDX_MAG_DOWNLOADABLE_LINK_TITLE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MAG_DL_LNK_TTL_LNK_ID_MAG_DL_LNK_LNK_ID` FOREIGN KEY (`link_id`) REFERENCES `mag_downloadable_link` (`link_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_DOWNLOADABLE_LINK_TITLE_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Link Title Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_downloadable_link_title`
--

LOCK TABLES `mag_downloadable_link_title` WRITE;
/*!40000 ALTER TABLE `mag_downloadable_link_title` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_downloadable_link_title` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_downloadable_sample`
--

DROP TABLE IF EXISTS `mag_downloadable_sample`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_downloadable_sample` (
  `sample_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Sample ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `sample_url` varchar(255) DEFAULT NULL COMMENT 'Sample URL',
  `sample_file` varchar(255) DEFAULT NULL COMMENT 'Sample file',
  `sample_type` varchar(20) DEFAULT NULL COMMENT 'Sample Type',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`sample_id`),
  KEY `IDX_MAG_DOWNLOADABLE_SAMPLE_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_MAG_DL_SAMPLE_PRD_ID_MAG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Downloadable Sample Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_downloadable_sample`
--

LOCK TABLES `mag_downloadable_sample` WRITE;
/*!40000 ALTER TABLE `mag_downloadable_sample` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_downloadable_sample` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_downloadable_sample_title`
--

DROP TABLE IF EXISTS `mag_downloadable_sample_title`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_downloadable_sample_title` (
  `title_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Title ID',
  `sample_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sample ID',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store ID',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  PRIMARY KEY (`title_id`),
  UNIQUE KEY `UNQ_MAG_DOWNLOADABLE_SAMPLE_TITLE_SAMPLE_ID_STORE_ID` (`sample_id`,`store_id`),
  KEY `IDX_MAG_DOWNLOADABLE_SAMPLE_TITLE_SAMPLE_ID` (`sample_id`),
  KEY `IDX_MAG_DOWNLOADABLE_SAMPLE_TITLE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MAG_DL_SAMPLE_TTL_SAMPLE_ID_MAG_DL_SAMPLE_SAMPLE_ID` FOREIGN KEY (`sample_id`) REFERENCES `mag_downloadable_sample` (`sample_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_DL_SAMPLE_TTL_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Downloadable Sample Title Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_downloadable_sample_title`
--

LOCK TABLES `mag_downloadable_sample_title` WRITE;
/*!40000 ALTER TABLE `mag_downloadable_sample_title` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_downloadable_sample_title` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_eav_attribute`
--

DROP TABLE IF EXISTS `mag_eav_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_eav_attribute` (
  `attribute_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Attribute Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_code` varchar(255) DEFAULT NULL COMMENT 'Attribute Code',
  `attribute_model` varchar(255) DEFAULT NULL COMMENT 'Attribute Model',
  `backend_model` varchar(255) DEFAULT NULL COMMENT 'Backend Model',
  `backend_type` varchar(8) NOT NULL DEFAULT 'static' COMMENT 'Backend Type',
  `backend_table` varchar(255) DEFAULT NULL COMMENT 'Backend Table',
  `frontend_model` varchar(255) DEFAULT NULL COMMENT 'Frontend Model',
  `frontend_input` varchar(50) DEFAULT NULL COMMENT 'Frontend Input',
  `frontend_label` varchar(255) DEFAULT NULL COMMENT 'Frontend Label',
  `frontend_class` varchar(255) DEFAULT NULL COMMENT 'Frontend Class',
  `source_model` varchar(255) DEFAULT NULL COMMENT 'Source Model',
  `is_required` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Defines Is Required',
  `is_user_defined` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Defines Is User Defined',
  `default_value` text COMMENT 'Default Value',
  `is_unique` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Defines Is Unique',
  `note` varchar(255) DEFAULT NULL COMMENT 'Note',
  PRIMARY KEY (`attribute_id`),
  UNIQUE KEY `UNQ_MAG_EAV_ATTRIBUTE_ENTITY_TYPE_ID_ATTRIBUTE_CODE` (`entity_type_id`,`attribute_code`),
  KEY `IDX_MAG_EAV_ATTRIBUTE_ENTITY_TYPE_ID` (`entity_type_id`),
  CONSTRAINT `FK_MAG_EAV_ATTR_ENTT_TYPE_ID_MAG_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `mag_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8 COMMENT='Eav Attribute';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_eav_attribute`
--

LOCK TABLES `mag_eav_attribute` WRITE;
/*!40000 ALTER TABLE `mag_eav_attribute` DISABLE KEYS */;
INSERT INTO `mag_eav_attribute` VALUES (1,1,'website_id',NULL,'customer/customer_attribute_backend_website','static',NULL,NULL,'select','Associate to Website',NULL,'customer/customer_attribute_source_website',1,0,NULL,0,NULL),(2,1,'store_id',NULL,'customer/customer_attribute_backend_store','static',NULL,NULL,'select','Create In',NULL,'customer/customer_attribute_source_store',1,0,NULL,0,NULL),(3,1,'created_in',NULL,NULL,'varchar',NULL,NULL,'text','Created From',NULL,NULL,0,0,NULL,0,NULL),(4,1,'prefix',NULL,NULL,'varchar',NULL,NULL,'text','Prefix',NULL,NULL,0,0,NULL,0,NULL),(5,1,'firstname',NULL,NULL,'varchar',NULL,NULL,'text','First Name',NULL,NULL,1,0,NULL,0,NULL),(6,1,'middlename',NULL,NULL,'varchar',NULL,NULL,'text','Middle Name/Initial',NULL,NULL,0,0,NULL,0,NULL),(7,1,'lastname',NULL,NULL,'varchar',NULL,NULL,'text','Last Name',NULL,NULL,1,0,NULL,0,NULL),(8,1,'suffix',NULL,NULL,'varchar',NULL,NULL,'text','Suffix',NULL,NULL,0,0,NULL,0,NULL),(9,1,'email',NULL,NULL,'static',NULL,NULL,'text','Email',NULL,NULL,1,0,NULL,0,NULL),(10,1,'group_id',NULL,NULL,'static',NULL,NULL,'select','Group',NULL,'customer/customer_attribute_source_group',1,0,NULL,0,NULL),(11,1,'dob',NULL,'eav/entity_attribute_backend_datetime','datetime',NULL,'eav/entity_attribute_frontend_datetime','date','Date Of Birth',NULL,NULL,0,0,NULL,0,NULL),(12,1,'password_hash',NULL,'customer/customer_attribute_backend_password','varchar',NULL,NULL,'hidden',NULL,NULL,NULL,0,0,NULL,0,NULL),(13,1,'default_billing',NULL,'customer/customer_attribute_backend_billing','int',NULL,NULL,'text','Default Billing Address',NULL,NULL,0,0,NULL,0,NULL),(14,1,'default_shipping',NULL,'customer/customer_attribute_backend_shipping','int',NULL,NULL,'text','Default Shipping Address',NULL,NULL,0,0,NULL,0,NULL),(15,1,'taxvat',NULL,NULL,'varchar',NULL,NULL,'text','Tax/VAT Number',NULL,NULL,0,0,NULL,0,NULL),(16,1,'confirmation',NULL,NULL,'varchar',NULL,NULL,'text','Is Confirmed',NULL,NULL,0,0,NULL,0,NULL),(17,1,'created_at',NULL,NULL,'static',NULL,NULL,'datetime','Created At',NULL,NULL,0,0,NULL,0,NULL),(18,1,'gender',NULL,NULL,'int',NULL,NULL,'select','Gender',NULL,'eav/entity_attribute_source_table',0,0,NULL,0,NULL),(19,2,'prefix',NULL,NULL,'varchar',NULL,NULL,'text','Prefix',NULL,NULL,0,0,NULL,0,NULL),(20,2,'firstname',NULL,NULL,'varchar',NULL,NULL,'text','First Name',NULL,NULL,1,0,NULL,0,NULL),(21,2,'middlename',NULL,NULL,'varchar',NULL,NULL,'text','Middle Name/Initial',NULL,NULL,0,0,NULL,0,NULL),(22,2,'lastname',NULL,NULL,'varchar',NULL,NULL,'text','Last Name',NULL,NULL,1,0,NULL,0,NULL),(23,2,'suffix',NULL,NULL,'varchar',NULL,NULL,'text','Suffix',NULL,NULL,0,0,NULL,0,NULL),(24,2,'company',NULL,NULL,'varchar',NULL,NULL,'text','Company',NULL,NULL,0,0,NULL,0,NULL),(25,2,'street',NULL,'customer/entity_address_attribute_backend_street','text',NULL,NULL,'multiline','Street Address',NULL,NULL,1,0,NULL,0,NULL),(26,2,'city',NULL,NULL,'varchar',NULL,NULL,'text','City',NULL,NULL,1,0,NULL,0,NULL),(27,2,'country_id',NULL,NULL,'varchar',NULL,NULL,'select','Country',NULL,'customer/entity_address_attribute_source_country',1,0,NULL,0,NULL),(28,2,'region',NULL,'customer/entity_address_attribute_backend_region','varchar',NULL,NULL,'text','State/Province',NULL,NULL,0,0,NULL,0,NULL),(29,2,'region_id',NULL,NULL,'int',NULL,NULL,'hidden','State/Province',NULL,'customer/entity_address_attribute_source_region',0,0,NULL,0,NULL),(30,2,'postcode',NULL,NULL,'varchar',NULL,NULL,'text','Zip/Postal Code',NULL,NULL,1,0,NULL,0,NULL),(31,2,'telephone',NULL,NULL,'varchar',NULL,NULL,'text','Telephone',NULL,NULL,1,0,NULL,0,NULL),(32,2,'fax',NULL,NULL,'varchar',NULL,NULL,'text','Fax',NULL,NULL,0,0,NULL,0,NULL),(33,1,'rp_token',NULL,NULL,'varchar',NULL,NULL,'hidden',NULL,NULL,NULL,0,0,NULL,0,NULL),(34,1,'rp_token_created_at',NULL,NULL,'datetime',NULL,NULL,'date',NULL,NULL,NULL,0,0,NULL,0,NULL),(35,1,'disable_auto_group_change',NULL,'customer/attribute_backend_data_boolean','static',NULL,NULL,'boolean','Disable Automatic Group Change Based on VAT ID',NULL,NULL,0,0,NULL,0,NULL),(36,2,'vat_id',NULL,NULL,'varchar',NULL,NULL,'text','VAT number',NULL,NULL,0,0,NULL,0,NULL),(37,2,'vat_is_valid',NULL,NULL,'int',NULL,NULL,'text','VAT number validity',NULL,NULL,0,0,NULL,0,NULL),(38,2,'vat_request_id',NULL,NULL,'varchar',NULL,NULL,'text','VAT number validation request ID',NULL,NULL,0,0,NULL,0,NULL),(39,2,'vat_request_date',NULL,NULL,'varchar',NULL,NULL,'text','VAT number validation request date',NULL,NULL,0,0,NULL,0,NULL),(40,2,'vat_request_success',NULL,NULL,'int',NULL,NULL,'text','VAT number validation request success',NULL,NULL,0,0,NULL,0,NULL),(41,3,'name',NULL,NULL,'varchar',NULL,NULL,'text','Name',NULL,NULL,1,0,NULL,0,NULL),(42,3,'is_active',NULL,NULL,'int',NULL,NULL,'select','Is Active',NULL,'eav/entity_attribute_source_boolean',1,0,NULL,0,NULL),(43,3,'url_key',NULL,'catalog/category_attribute_backend_urlkey','varchar',NULL,NULL,'text','URL Key',NULL,NULL,0,0,NULL,0,NULL),(44,3,'description',NULL,NULL,'text',NULL,NULL,'textarea','Description',NULL,NULL,0,0,NULL,0,NULL),(45,3,'image',NULL,'catalog/category_attribute_backend_image','varchar',NULL,NULL,'image','Image',NULL,NULL,0,0,NULL,0,NULL),(46,3,'meta_title',NULL,NULL,'varchar',NULL,NULL,'text','Page Title',NULL,NULL,0,0,NULL,0,NULL),(47,3,'meta_keywords',NULL,NULL,'text',NULL,NULL,'textarea','Meta Keywords',NULL,NULL,0,0,NULL,0,NULL),(48,3,'meta_description',NULL,NULL,'text',NULL,NULL,'textarea','Meta Description',NULL,NULL,0,0,NULL,0,NULL),(49,3,'display_mode',NULL,NULL,'varchar',NULL,NULL,'select','Display Mode',NULL,'catalog/category_attribute_source_mode',0,0,NULL,0,NULL),(50,3,'landing_page',NULL,NULL,'int',NULL,NULL,'select','CMS Block',NULL,'catalog/category_attribute_source_page',0,0,NULL,0,NULL),(51,3,'is_anchor',NULL,NULL,'int',NULL,NULL,'select','Is Anchor',NULL,'eav/entity_attribute_source_boolean',0,0,NULL,0,NULL),(52,3,'path',NULL,NULL,'static',NULL,NULL,'text','Path',NULL,NULL,0,0,NULL,0,NULL),(53,3,'position',NULL,NULL,'static',NULL,NULL,'text','Position',NULL,NULL,0,0,NULL,0,NULL),(54,3,'all_children',NULL,NULL,'text',NULL,NULL,'text',NULL,NULL,NULL,0,0,NULL,0,NULL),(55,3,'path_in_store',NULL,NULL,'text',NULL,NULL,'text',NULL,NULL,NULL,0,0,NULL,0,NULL),(56,3,'children',NULL,NULL,'text',NULL,NULL,'text',NULL,NULL,NULL,0,0,NULL,0,NULL),(57,3,'url_path',NULL,NULL,'varchar',NULL,NULL,'text',NULL,NULL,NULL,0,0,NULL,0,NULL),(58,3,'custom_design',NULL,NULL,'varchar',NULL,NULL,'select','Custom Design',NULL,'core/design_source_design',0,0,NULL,0,NULL),(59,3,'custom_design_from',NULL,'eav/entity_attribute_backend_datetime','datetime',NULL,NULL,'date','Active From',NULL,NULL,0,0,NULL,0,NULL),(60,3,'custom_design_to',NULL,'eav/entity_attribute_backend_datetime','datetime',NULL,NULL,'date','Active To',NULL,NULL,0,0,NULL,0,NULL),(61,3,'page_layout',NULL,NULL,'varchar',NULL,NULL,'select','Page Layout',NULL,'catalog/category_attribute_source_layout',0,0,NULL,0,NULL),(62,3,'custom_layout_update',NULL,'catalog/attribute_backend_customlayoutupdate','text',NULL,NULL,'textarea','Custom Layout Update',NULL,NULL,0,0,NULL,0,NULL),(63,3,'level',NULL,NULL,'static',NULL,NULL,'text','Level',NULL,NULL,0,0,NULL,0,NULL),(64,3,'children_count',NULL,NULL,'static',NULL,NULL,'text','Children Count',NULL,NULL,0,0,NULL,0,NULL),(65,3,'available_sort_by',NULL,'catalog/category_attribute_backend_sortby','text',NULL,NULL,'multiselect','Available Product Listing Sort By',NULL,'catalog/category_attribute_source_sortby',1,0,NULL,0,NULL),(66,3,'default_sort_by',NULL,'catalog/category_attribute_backend_sortby','varchar',NULL,NULL,'select','Default Product Listing Sort By',NULL,'catalog/category_attribute_source_sortby',1,0,NULL,0,NULL),(67,3,'include_in_menu',NULL,NULL,'int',NULL,NULL,'select','Include in Navigation Menu',NULL,'eav/entity_attribute_source_boolean',1,0,'1',0,NULL),(68,3,'custom_use_parent_settings',NULL,NULL,'int',NULL,NULL,'select','Use Parent Category Settings',NULL,'eav/entity_attribute_source_boolean',0,0,NULL,0,NULL),(69,3,'custom_apply_to_products',NULL,NULL,'int',NULL,NULL,'select','Apply To Products',NULL,'eav/entity_attribute_source_boolean',0,0,NULL,0,NULL),(70,3,'filter_price_range',NULL,NULL,'decimal',NULL,NULL,'text','Layered Navigation Price Step',NULL,NULL,0,0,NULL,0,NULL),(71,4,'name',NULL,NULL,'varchar',NULL,NULL,'text','Name',NULL,NULL,1,0,NULL,0,NULL),(72,4,'description',NULL,NULL,'text',NULL,NULL,'textarea','Description',NULL,NULL,1,0,NULL,0,NULL),(73,4,'short_description',NULL,NULL,'text',NULL,NULL,'textarea','Short Description',NULL,NULL,1,0,NULL,0,NULL),(74,4,'sku',NULL,'catalog/product_attribute_backend_sku','static',NULL,NULL,'text','SKU',NULL,NULL,1,0,NULL,1,NULL),(75,4,'price',NULL,'catalog/product_attribute_backend_price','decimal',NULL,NULL,'price','Price',NULL,NULL,1,0,NULL,0,NULL),(76,4,'special_price',NULL,'catalog/product_attribute_backend_price','decimal',NULL,NULL,'price','Special Price',NULL,NULL,0,0,NULL,0,NULL),(77,4,'special_from_date',NULL,'catalog/product_attribute_backend_startdate_specialprice','datetime',NULL,NULL,'date','Special Price From Date',NULL,NULL,0,0,NULL,0,NULL),(78,4,'special_to_date',NULL,'eav/entity_attribute_backend_datetime','datetime',NULL,NULL,'date','Special Price To Date',NULL,NULL,0,0,NULL,0,NULL),(79,4,'cost',NULL,'catalog/product_attribute_backend_price','decimal',NULL,NULL,'price','Cost',NULL,NULL,0,1,NULL,0,NULL),(80,4,'weight',NULL,NULL,'decimal',NULL,NULL,'weight','Weight',NULL,NULL,1,0,NULL,0,NULL),(81,4,'manufacturer',NULL,NULL,'int',NULL,NULL,'select','Manufacturer',NULL,NULL,0,1,NULL,0,NULL),(82,4,'meta_title',NULL,NULL,'varchar',NULL,NULL,'text','Meta Title',NULL,NULL,0,0,NULL,0,NULL),(83,4,'meta_keyword',NULL,NULL,'text',NULL,NULL,'textarea','Meta Keywords',NULL,NULL,0,0,NULL,0,NULL),(84,4,'meta_description',NULL,NULL,'varchar',NULL,NULL,'textarea','Meta Description',NULL,NULL,0,0,NULL,0,'Maximum 255 chars'),(85,4,'image',NULL,NULL,'varchar',NULL,'catalog/product_attribute_frontend_image','media_image','Base Image',NULL,NULL,0,0,NULL,0,NULL),(86,4,'small_image',NULL,NULL,'varchar',NULL,'catalog/product_attribute_frontend_image','media_image','Small Image',NULL,NULL,0,0,NULL,0,NULL),(87,4,'thumbnail',NULL,NULL,'varchar',NULL,'catalog/product_attribute_frontend_image','media_image','Thumbnail',NULL,NULL,0,0,NULL,0,NULL),(88,4,'media_gallery',NULL,'catalog/product_attribute_backend_media','varchar',NULL,NULL,'gallery','Media Gallery',NULL,NULL,0,0,NULL,0,NULL),(89,4,'old_id',NULL,NULL,'int',NULL,NULL,'text',NULL,NULL,NULL,0,0,NULL,0,NULL),(90,4,'group_price',NULL,'catalog/product_attribute_backend_groupprice','decimal',NULL,NULL,'text','Group Price',NULL,NULL,0,0,NULL,0,NULL),(91,4,'tier_price',NULL,'catalog/product_attribute_backend_tierprice','decimal',NULL,NULL,'text','Tier Price',NULL,NULL,0,0,NULL,0,NULL),(92,4,'color',NULL,NULL,'int',NULL,NULL,'select','Color',NULL,NULL,0,1,NULL,0,NULL),(93,4,'news_from_date',NULL,'catalog/product_attribute_backend_startdate','datetime',NULL,NULL,'date','Set Product as New from Date',NULL,NULL,0,0,NULL,0,NULL),(94,4,'news_to_date',NULL,'eav/entity_attribute_backend_datetime','datetime',NULL,NULL,'date','Set Product as New to Date',NULL,NULL,0,0,NULL,0,NULL),(95,4,'gallery',NULL,NULL,'varchar',NULL,NULL,'gallery','Image Gallery',NULL,NULL,0,0,NULL,0,NULL),(96,4,'status',NULL,NULL,'int',NULL,NULL,'select','Status',NULL,'catalog/product_status',1,0,NULL,0,NULL),(97,4,'url_key',NULL,'catalog/product_attribute_backend_urlkey','varchar',NULL,NULL,'text','URL Key',NULL,NULL,0,0,NULL,0,NULL),(98,4,'url_path',NULL,NULL,'varchar',NULL,NULL,'text',NULL,NULL,NULL,0,0,NULL,0,NULL),(99,4,'minimal_price',NULL,NULL,'decimal',NULL,NULL,'price','Minimal Price',NULL,NULL,0,0,NULL,0,NULL),(100,4,'is_recurring',NULL,NULL,'int',NULL,NULL,'select','Enable Recurring Profile',NULL,'eav/entity_attribute_source_boolean',0,0,NULL,0,'Products with recurring profile participate in catalog as nominal items.'),(101,4,'recurring_profile',NULL,'catalog/product_attribute_backend_recurring','text',NULL,NULL,'text','Recurring Payment Profile',NULL,NULL,0,0,NULL,0,NULL),(102,4,'visibility',NULL,NULL,'int',NULL,NULL,'select','Visibility',NULL,'catalog/product_visibility',1,0,'4',0,NULL),(103,4,'custom_design',NULL,NULL,'varchar',NULL,NULL,'select','Custom Design',NULL,'core/design_source_design',0,0,NULL,0,NULL),(104,4,'custom_design_from',NULL,'catalog/product_attribute_backend_startdate','datetime',NULL,NULL,'date','Active From',NULL,NULL,0,0,NULL,0,NULL),(105,4,'custom_design_to',NULL,'eav/entity_attribute_backend_datetime','datetime',NULL,NULL,'date','Active To',NULL,NULL,0,0,NULL,0,NULL),(106,4,'custom_layout_update',NULL,'catalog/attribute_backend_customlayoutupdate','text',NULL,NULL,'textarea','Custom Layout Update',NULL,NULL,0,0,NULL,0,NULL),(107,4,'page_layout',NULL,NULL,'varchar',NULL,NULL,'select','Page Layout',NULL,'catalog/product_attribute_source_layout',0,0,NULL,0,NULL),(108,4,'category_ids',NULL,NULL,'static',NULL,NULL,'text',NULL,NULL,NULL,0,0,NULL,0,NULL),(109,4,'options_container',NULL,NULL,'varchar',NULL,NULL,'select','Display Product Options In',NULL,'catalog/entity_product_attribute_design_options_container',0,0,'container1',0,NULL),(110,4,'required_options',NULL,NULL,'static',NULL,NULL,'text',NULL,NULL,NULL,0,0,NULL,0,NULL),(111,4,'has_options',NULL,NULL,'static',NULL,NULL,'text',NULL,NULL,NULL,0,0,NULL,0,NULL),(112,4,'image_label',NULL,NULL,'varchar',NULL,NULL,'text','Image Label',NULL,NULL,0,0,NULL,0,NULL),(113,4,'small_image_label',NULL,NULL,'varchar',NULL,NULL,'text','Small Image Label',NULL,NULL,0,0,NULL,0,NULL),(114,4,'thumbnail_label',NULL,NULL,'varchar',NULL,NULL,'text','Thumbnail Label',NULL,NULL,0,0,NULL,0,NULL),(115,4,'created_at',NULL,'eav/entity_attribute_backend_time_created','static',NULL,NULL,'text',NULL,NULL,NULL,1,0,NULL,0,NULL),(116,4,'updated_at',NULL,'eav/entity_attribute_backend_time_updated','static',NULL,NULL,'text',NULL,NULL,NULL,1,0,NULL,0,NULL),(117,4,'country_of_manufacture',NULL,NULL,'varchar',NULL,NULL,'select','Country of Manufacture',NULL,'catalog/product_attribute_source_countryofmanufacture',0,0,NULL,0,NULL),(118,4,'msrp_enabled',NULL,'catalog/product_attribute_backend_msrp','varchar',NULL,NULL,'select','Apply MAP',NULL,'catalog/product_attribute_source_msrp_type_enabled',0,0,'2',0,NULL),(119,4,'msrp_display_actual_price_type',NULL,'catalog/product_attribute_backend_boolean','varchar',NULL,NULL,'select','Display Actual Price',NULL,'catalog/product_attribute_source_msrp_type_price',0,0,'4',0,NULL),(120,4,'msrp',NULL,'catalog/product_attribute_backend_price','decimal',NULL,NULL,'price','Manufacturer\'s Suggested Retail Price',NULL,NULL,0,0,NULL,0,NULL),(121,4,'tax_class_id',NULL,NULL,'int',NULL,NULL,'select','Tax Class',NULL,'tax/class_source_product',1,0,NULL,0,NULL),(122,4,'gift_message_available',NULL,'catalog/product_attribute_backend_boolean','varchar',NULL,NULL,'select','Allow Gift Message',NULL,'eav/entity_attribute_source_boolean',0,0,NULL,0,NULL),(123,4,'price_type',NULL,NULL,'int',NULL,NULL,NULL,NULL,NULL,NULL,1,0,NULL,0,NULL),(124,4,'sku_type',NULL,NULL,'int',NULL,NULL,NULL,NULL,NULL,NULL,1,0,NULL,0,NULL),(125,4,'weight_type',NULL,NULL,'int',NULL,NULL,NULL,NULL,NULL,NULL,1,0,NULL,0,NULL),(126,4,'price_view',NULL,NULL,'int',NULL,NULL,'select','Price View',NULL,'bundle/product_attribute_source_price_view',1,0,NULL,0,NULL),(127,4,'shipment_type',NULL,NULL,'int',NULL,NULL,NULL,'Shipment',NULL,NULL,1,0,NULL,0,NULL),(128,4,'links_purchased_separately',NULL,NULL,'int',NULL,NULL,NULL,'Links can be purchased separately',NULL,NULL,1,0,NULL,0,NULL),(129,4,'samples_title',NULL,NULL,'varchar',NULL,NULL,NULL,'Samples title',NULL,NULL,1,0,NULL,0,NULL),(130,4,'links_title',NULL,NULL,'varchar',NULL,NULL,NULL,'Links title',NULL,NULL,1,0,NULL,0,NULL),(131,4,'links_exist',NULL,NULL,'int',NULL,NULL,NULL,NULL,NULL,NULL,0,0,'0',0,NULL),(132,3,'umm_cat_block_right',NULL,NULL,'text',NULL,NULL,'textarea','Block Right',NULL,NULL,0,1,NULL,0,'This field is applicable only for top-level categories.'),(133,3,'umm_cat_block_proportions',NULL,NULL,'varchar',NULL,NULL,'select','Proportions: Subcategories / Block Right',NULL,'ultramegamenu/category_attribute_source_block_proportions',0,1,NULL,0,'Proportions between block of subcategories and Block Right. This field is applicable only for top-level categories.'),(134,3,'umm_cat_block_top',NULL,NULL,'text',NULL,NULL,'textarea','Block Top',NULL,NULL,0,1,NULL,0,NULL),(135,3,'umm_cat_block_bottom',NULL,NULL,'text',NULL,NULL,'textarea','Block Bottom',NULL,NULL,0,1,NULL,0,NULL),(136,3,'umm_cat_label',NULL,NULL,'varchar',NULL,NULL,'select','Category Label',NULL,'ultramegamenu/category_attribute_source_categorylabel',0,1,NULL,0,'Labels have to be defined in menu settings');
/*!40000 ALTER TABLE `mag_eav_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_eav_attribute_group`
--

DROP TABLE IF EXISTS `mag_eav_attribute_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_eav_attribute_group` (
  `attribute_group_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Attribute Group Id',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set Id',
  `attribute_group_name` varchar(255) DEFAULT NULL COMMENT 'Attribute Group Name',
  `sort_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `default_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Default Id',
  PRIMARY KEY (`attribute_group_id`),
  UNIQUE KEY `UNQ_MAG_EAV_ATTR_GROUP_ATTR_SET_ID_ATTR_GROUP_NAME` (`attribute_set_id`,`attribute_group_name`),
  KEY `IDX_MAG_EAV_ATTRIBUTE_GROUP_ATTRIBUTE_SET_ID_SORT_ORDER` (`attribute_set_id`,`sort_order`),
  CONSTRAINT `FK_MAG_EAV_ATTR_GROUP_ATTR_SET_ID_MAG_EAV_ATTR_SET_ATTR_SET_ID` FOREIGN KEY (`attribute_set_id`) REFERENCES `mag_eav_attribute_set` (`attribute_set_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='Eav Attribute Group';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_eav_attribute_group`
--

LOCK TABLES `mag_eav_attribute_group` WRITE;
/*!40000 ALTER TABLE `mag_eav_attribute_group` DISABLE KEYS */;
INSERT INTO `mag_eav_attribute_group` VALUES (1,1,'General',1,1),(2,2,'General',1,1),(3,3,'General',10,1),(4,3,'General Information',2,0),(5,3,'Display Settings',20,0),(6,3,'Custom Design',30,0),(7,4,'General',1,1),(8,4,'Prices',2,0),(9,4,'Meta Information',3,0),(10,4,'Images',4,0),(11,4,'Recurring Profile',5,0),(12,4,'Design',6,0),(13,5,'General',1,1),(14,6,'General',1,1),(15,7,'General',1,1),(16,8,'General',1,1),(17,4,'Gift Options',7,0),(18,3,'Menu',31,0);
/*!40000 ALTER TABLE `mag_eav_attribute_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_eav_attribute_label`
--

DROP TABLE IF EXISTS `mag_eav_attribute_label`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_eav_attribute_label` (
  `attribute_label_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Attribute Label Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`attribute_label_id`),
  KEY `IDX_MAG_EAV_ATTRIBUTE_LABEL_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MAG_EAV_ATTRIBUTE_LABEL_STORE_ID` (`store_id`),
  KEY `IDX_MAG_EAV_ATTRIBUTE_LABEL_ATTRIBUTE_ID_STORE_ID` (`attribute_id`,`store_id`),
  CONSTRAINT `FK_MAG_EAV_ATTRIBUTE_LABEL_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_EAV_ATTR_LBL_ATTR_ID_MAG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mag_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Attribute Label';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_eav_attribute_label`
--

LOCK TABLES `mag_eav_attribute_label` WRITE;
/*!40000 ALTER TABLE `mag_eav_attribute_label` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_eav_attribute_label` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_eav_attribute_option`
--

DROP TABLE IF EXISTS `mag_eav_attribute_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_eav_attribute_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `sort_order` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`option_id`),
  KEY `IDX_MAG_EAV_ATTRIBUTE_OPTION_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `FK_MAG_EAV_ATTR_OPT_ATTR_ID_MAG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mag_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Eav Attribute Option';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_eav_attribute_option`
--

LOCK TABLES `mag_eav_attribute_option` WRITE;
/*!40000 ALTER TABLE `mag_eav_attribute_option` DISABLE KEYS */;
INSERT INTO `mag_eav_attribute_option` VALUES (1,18,0),(2,18,1);
/*!40000 ALTER TABLE `mag_eav_attribute_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_eav_attribute_option_value`
--

DROP TABLE IF EXISTS `mag_eav_attribute_option_value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_eav_attribute_option_value` (
  `value_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Option Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `value` varchar(255) DEFAULT NULL COMMENT 'Value',
  PRIMARY KEY (`value_id`),
  KEY `IDX_MAG_EAV_ATTRIBUTE_OPTION_VALUE_OPTION_ID` (`option_id`),
  KEY `IDX_MAG_EAV_ATTRIBUTE_OPTION_VALUE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MAG_EAV_ATTR_OPT_VAL_OPT_ID_MAG_EAV_ATTR_OPT_OPT_ID` FOREIGN KEY (`option_id`) REFERENCES `mag_eav_attribute_option` (`option_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_EAV_ATTR_OPT_VAL_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Eav Attribute Option Value';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_eav_attribute_option_value`
--

LOCK TABLES `mag_eav_attribute_option_value` WRITE;
/*!40000 ALTER TABLE `mag_eav_attribute_option_value` DISABLE KEYS */;
INSERT INTO `mag_eav_attribute_option_value` VALUES (1,1,0,'Male'),(2,2,0,'Female');
/*!40000 ALTER TABLE `mag_eav_attribute_option_value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_eav_attribute_set`
--

DROP TABLE IF EXISTS `mag_eav_attribute_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_eav_attribute_set` (
  `attribute_set_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Attribute Set Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_set_name` varchar(255) DEFAULT NULL COMMENT 'Attribute Set Name',
  `sort_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`attribute_set_id`),
  UNIQUE KEY `UNQ_MAG_EAV_ATTRIBUTE_SET_ENTITY_TYPE_ID_ATTRIBUTE_SET_NAME` (`entity_type_id`,`attribute_set_name`),
  KEY `IDX_MAG_EAV_ATTRIBUTE_SET_ENTITY_TYPE_ID_SORT_ORDER` (`entity_type_id`,`sort_order`),
  CONSTRAINT `FK_MAG_EAV_ATTR_SET_ENTT_TYPE_ID_MAG_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `mag_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='Eav Attribute Set';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_eav_attribute_set`
--

LOCK TABLES `mag_eav_attribute_set` WRITE;
/*!40000 ALTER TABLE `mag_eav_attribute_set` DISABLE KEYS */;
INSERT INTO `mag_eav_attribute_set` VALUES (1,1,'Default',1),(2,2,'Default',1),(3,3,'Default',1),(4,4,'Default',1),(5,5,'Default',1),(6,6,'Default',1),(7,7,'Default',1),(8,8,'Default',1);
/*!40000 ALTER TABLE `mag_eav_attribute_set` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_eav_entity`
--

DROP TABLE IF EXISTS `mag_eav_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_eav_entity` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set Id',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Parent Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `is_active` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Defines Is Entity Active',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_MAG_EAV_ENTITY_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_MAG_EAV_ENTITY_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MAG_EAV_ENTITY_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_EAV_ENTT_ENTT_TYPE_ID_MAG_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `mag_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_eav_entity`
--

LOCK TABLES `mag_eav_entity` WRITE;
/*!40000 ALTER TABLE `mag_eav_entity` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_eav_entity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_eav_entity_attribute`
--

DROP TABLE IF EXISTS `mag_eav_entity_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_eav_entity_attribute` (
  `entity_attribute_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Attribute Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Set Id',
  `attribute_group_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Group Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `sort_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`entity_attribute_id`),
  UNIQUE KEY `UNQ_MAG_EAV_ENTITY_ATTRIBUTE_ATTRIBUTE_SET_ID_ATTRIBUTE_ID` (`attribute_set_id`,`attribute_id`),
  UNIQUE KEY `UNQ_MAG_EAV_ENTITY_ATTRIBUTE_ATTRIBUTE_GROUP_ID_ATTRIBUTE_ID` (`attribute_group_id`,`attribute_id`),
  KEY `IDX_MAG_EAV_ENTITY_ATTRIBUTE_ATTRIBUTE_SET_ID_SORT_ORDER` (`attribute_set_id`,`sort_order`),
  KEY `IDX_MAG_EAV_ENTITY_ATTRIBUTE_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `FK_B7BA2D1CE88E624B82B4B81DA340FF04` FOREIGN KEY (`attribute_group_id`) REFERENCES `mag_eav_attribute_group` (`attribute_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_EAV_ENTT_ATTR_ATTR_ID_MAG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mag_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=135 DEFAULT CHARSET=utf8 COMMENT='Eav Entity Attributes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_eav_entity_attribute`
--

LOCK TABLES `mag_eav_entity_attribute` WRITE;
/*!40000 ALTER TABLE `mag_eav_entity_attribute` DISABLE KEYS */;
INSERT INTO `mag_eav_entity_attribute` VALUES (1,1,1,1,1,10),(2,1,1,1,2,0),(3,1,1,1,3,20),(4,1,1,1,4,30),(5,1,1,1,5,40),(6,1,1,1,6,50),(7,1,1,1,7,60),(8,1,1,1,8,70),(9,1,1,1,9,80),(10,1,1,1,10,25),(11,1,1,1,11,90),(12,1,1,1,12,0),(13,1,1,1,13,0),(14,1,1,1,14,0),(15,1,1,1,15,100),(16,1,1,1,16,0),(17,1,1,1,17,86),(18,1,1,1,18,110),(19,2,2,2,19,10),(20,2,2,2,20,20),(21,2,2,2,21,30),(22,2,2,2,22,40),(23,2,2,2,23,50),(24,2,2,2,24,60),(25,2,2,2,25,70),(26,2,2,2,26,80),(27,2,2,2,27,90),(28,2,2,2,28,100),(29,2,2,2,29,100),(30,2,2,2,30,110),(31,2,2,2,31,120),(32,2,2,2,32,130),(33,1,1,1,33,111),(34,1,1,1,34,112),(35,1,1,1,35,28),(36,2,2,2,36,140),(37,2,2,2,37,132),(38,2,2,2,38,133),(39,2,2,2,39,134),(40,2,2,2,40,135),(41,3,3,4,41,1),(42,3,3,4,42,2),(43,3,3,4,43,3),(44,3,3,4,44,4),(45,3,3,4,45,5),(46,3,3,4,46,6),(47,3,3,4,47,7),(48,3,3,4,48,8),(49,3,3,5,49,10),(50,3,3,5,50,20),(51,3,3,5,51,30),(52,3,3,4,52,12),(53,3,3,4,53,13),(54,3,3,4,54,14),(55,3,3,4,55,15),(56,3,3,4,56,16),(57,3,3,4,57,17),(58,3,3,6,58,10),(59,3,3,6,59,30),(60,3,3,6,60,40),(61,3,3,6,61,50),(62,3,3,6,62,60),(63,3,3,4,63,24),(64,3,3,4,64,25),(65,3,3,5,65,40),(66,3,3,5,66,50),(67,3,3,4,67,10),(68,3,3,6,68,5),(69,3,3,6,69,6),(70,3,3,5,70,51),(71,4,4,7,71,1),(72,4,4,7,72,2),(73,4,4,7,73,3),(74,4,4,7,74,4),(75,4,4,8,75,1),(76,4,4,8,76,3),(77,4,4,8,77,4),(78,4,4,8,78,5),(79,4,4,8,79,6),(80,4,4,7,80,5),(81,4,4,9,82,1),(82,4,4,9,83,2),(83,4,4,9,84,3),(84,4,4,10,85,1),(85,4,4,10,86,2),(86,4,4,10,87,3),(87,4,4,10,88,4),(88,4,4,7,89,6),(89,4,4,8,90,2),(90,4,4,8,91,7),(91,4,4,7,93,7),(92,4,4,7,94,8),(93,4,4,10,95,5),(94,4,4,7,96,9),(95,4,4,7,97,10),(96,4,4,7,98,11),(97,4,4,8,99,8),(98,4,4,11,100,1),(99,4,4,11,101,2),(100,4,4,7,102,12),(101,4,4,12,103,1),(102,4,4,12,104,2),(103,4,4,12,105,3),(104,4,4,12,106,4),(105,4,4,12,107,5),(106,4,4,7,108,13),(107,4,4,12,109,6),(108,4,4,7,110,14),(109,4,4,7,111,15),(110,4,4,7,112,16),(111,4,4,7,113,17),(112,4,4,7,114,18),(113,4,4,7,115,19),(114,4,4,7,116,20),(115,4,4,7,117,21),(116,4,4,8,118,9),(117,4,4,8,119,10),(118,4,4,8,120,11),(119,4,4,8,121,12),(120,4,4,17,122,1),(121,4,4,7,123,22),(122,4,4,7,124,23),(123,4,4,7,125,24),(124,4,4,8,126,13),(125,4,4,7,127,25),(126,4,4,7,128,26),(127,4,4,7,129,27),(128,4,4,7,130,28),(129,4,4,7,131,29),(130,3,3,18,132,1),(131,3,3,18,133,2),(132,3,3,18,134,3),(133,3,3,18,135,4),(134,3,3,18,136,5);
/*!40000 ALTER TABLE `mag_eav_entity_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_eav_entity_datetime`
--

DROP TABLE IF EXISTS `mag_eav_entity_datetime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_eav_entity_datetime` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Attribute Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MAG_EAV_ENTITY_DATETIME_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_MAG_EAV_ENTITY_DATETIME_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_MAG_EAV_ENTITY_DATETIME_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MAG_EAV_ENTITY_DATETIME_STORE_ID` (`store_id`),
  KEY `IDX_MAG_EAV_ENTITY_DATETIME_ENTITY_ID` (`entity_id`),
  KEY `IDX_MAG_EAV_ENTITY_DATETIME_ATTRIBUTE_ID_VALUE` (`attribute_id`,`value`),
  KEY `IDX_MAG_EAV_ENTITY_DATETIME_ENTITY_TYPE_ID_VALUE` (`entity_type_id`,`value`),
  CONSTRAINT `FK_4B00A4386AE0A7FD6282969F9FF2DC57` FOREIGN KEY (`entity_type_id`) REFERENCES `mag_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_EAV_ENTITY_DATETIME_ENTITY_ID_MAG_EAV_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `mag_eav_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_EAV_ENTITY_DATETIME_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Value Prefix';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_eav_entity_datetime`
--

LOCK TABLES `mag_eav_entity_datetime` WRITE;
/*!40000 ALTER TABLE `mag_eav_entity_datetime` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_eav_entity_datetime` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_eav_entity_decimal`
--

DROP TABLE IF EXISTS `mag_eav_entity_decimal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_eav_entity_decimal` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Attribute Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MAG_EAV_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_MAG_EAV_ENTITY_DECIMAL_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_MAG_EAV_ENTITY_DECIMAL_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MAG_EAV_ENTITY_DECIMAL_STORE_ID` (`store_id`),
  KEY `IDX_MAG_EAV_ENTITY_DECIMAL_ENTITY_ID` (`entity_id`),
  KEY `IDX_MAG_EAV_ENTITY_DECIMAL_ATTRIBUTE_ID_VALUE` (`attribute_id`,`value`),
  KEY `IDX_MAG_EAV_ENTITY_DECIMAL_ENTITY_TYPE_ID_VALUE` (`entity_type_id`,`value`),
  CONSTRAINT `FK_MAG_EAV_ENTITY_DECIMAL_ENTITY_ID_MAG_EAV_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `mag_eav_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_EAV_ENTITY_DECIMAL_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_EAV_ENTT_DEC_ENTT_TYPE_ID_MAG_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `mag_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Value Prefix';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_eav_entity_decimal`
--

LOCK TABLES `mag_eav_entity_decimal` WRITE;
/*!40000 ALTER TABLE `mag_eav_entity_decimal` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_eav_entity_decimal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_eav_entity_int`
--

DROP TABLE IF EXISTS `mag_eav_entity_int`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_eav_entity_int` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` int(11) NOT NULL DEFAULT '0' COMMENT 'Attribute Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MAG_EAV_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_MAG_EAV_ENTITY_INT_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_MAG_EAV_ENTITY_INT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MAG_EAV_ENTITY_INT_STORE_ID` (`store_id`),
  KEY `IDX_MAG_EAV_ENTITY_INT_ENTITY_ID` (`entity_id`),
  KEY `IDX_MAG_EAV_ENTITY_INT_ATTRIBUTE_ID_VALUE` (`attribute_id`,`value`),
  KEY `IDX_MAG_EAV_ENTITY_INT_ENTITY_TYPE_ID_VALUE` (`entity_type_id`,`value`),
  CONSTRAINT `FK_MAG_EAV_ENTITY_INT_ENTITY_ID_MAG_EAV_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `mag_eav_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_EAV_ENTITY_INT_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_EAV_ENTT_INT_ENTT_TYPE_ID_MAG_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `mag_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Value Prefix';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_eav_entity_int`
--

LOCK TABLES `mag_eav_entity_int` WRITE;
/*!40000 ALTER TABLE `mag_eav_entity_int` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_eav_entity_int` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_eav_entity_store`
--

DROP TABLE IF EXISTS `mag_eav_entity_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_eav_entity_store` (
  `entity_store_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Store Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `increment_prefix` varchar(20) DEFAULT NULL COMMENT 'Increment Prefix',
  `increment_last_id` varchar(50) DEFAULT NULL COMMENT 'Last Incremented Id',
  PRIMARY KEY (`entity_store_id`),
  KEY `IDX_MAG_EAV_ENTITY_STORE_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_MAG_EAV_ENTITY_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_DE377A73096F0175E52114FA40901AA4` FOREIGN KEY (`entity_type_id`) REFERENCES `mag_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_EAV_ENTITY_STORE_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Store';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_eav_entity_store`
--

LOCK TABLES `mag_eav_entity_store` WRITE;
/*!40000 ALTER TABLE `mag_eav_entity_store` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_eav_entity_store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_eav_entity_text`
--

DROP TABLE IF EXISTS `mag_eav_entity_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_eav_entity_text` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` text NOT NULL COMMENT 'Attribute Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MAG_EAV_ENTITY_TEXT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_MAG_EAV_ENTITY_TEXT_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_MAG_EAV_ENTITY_TEXT_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MAG_EAV_ENTITY_TEXT_STORE_ID` (`store_id`),
  KEY `IDX_MAG_EAV_ENTITY_TEXT_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_MAG_EAV_ENTITY_TEXT_ENTITY_ID_MAG_EAV_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `mag_eav_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_EAV_ENTITY_TEXT_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_EAV_ENTT_TEXT_ENTT_TYPE_ID_MAG_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `mag_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Value Prefix';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_eav_entity_text`
--

LOCK TABLES `mag_eav_entity_text` WRITE;
/*!40000 ALTER TABLE `mag_eav_entity_text` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_eav_entity_text` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_eav_entity_type`
--

DROP TABLE IF EXISTS `mag_eav_entity_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_eav_entity_type` (
  `entity_type_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Type Id',
  `entity_type_code` varchar(50) NOT NULL COMMENT 'Entity Type Code',
  `entity_model` varchar(255) NOT NULL COMMENT 'Entity Model',
  `attribute_model` varchar(255) DEFAULT NULL COMMENT 'Attribute Model',
  `entity_table` varchar(255) DEFAULT NULL COMMENT 'Entity Table',
  `value_table_prefix` varchar(255) DEFAULT NULL COMMENT 'Value Table Prefix',
  `entity_id_field` varchar(255) DEFAULT NULL COMMENT 'Entity Id Field',
  `is_data_sharing` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Defines Is Data Sharing',
  `data_sharing_key` varchar(100) DEFAULT 'default' COMMENT 'Data Sharing Key',
  `default_attribute_set_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Default Attribute Set Id',
  `increment_model` varchar(255) DEFAULT '' COMMENT 'Increment Model',
  `increment_per_store` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Increment Per Store',
  `increment_pad_length` smallint(5) unsigned NOT NULL DEFAULT '8' COMMENT 'Increment Pad Length',
  `increment_pad_char` varchar(1) NOT NULL DEFAULT '0' COMMENT 'Increment Pad Char',
  `additional_attribute_table` varchar(255) DEFAULT '' COMMENT 'Additional Attribute Table',
  `entity_attribute_collection` varchar(255) DEFAULT NULL COMMENT 'Entity Attribute Collection',
  PRIMARY KEY (`entity_type_id`),
  KEY `IDX_MAG_EAV_ENTITY_TYPE_ENTITY_TYPE_CODE` (`entity_type_code`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='Eav Entity Type';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_eav_entity_type`
--

LOCK TABLES `mag_eav_entity_type` WRITE;
/*!40000 ALTER TABLE `mag_eav_entity_type` DISABLE KEYS */;
INSERT INTO `mag_eav_entity_type` VALUES (1,'customer','customer/customer','customer/attribute','customer/entity',NULL,NULL,1,'default',1,'eav/entity_increment_numeric',0,8,'0','customer/eav_attribute','customer/attribute_collection'),(2,'customer_address','customer/address','customer/attribute','customer/address_entity',NULL,NULL,1,'default',2,NULL,0,8,'0','customer/eav_attribute','customer/address_attribute_collection'),(3,'catalog_category','catalog/category','catalog/resource_eav_attribute','catalog/category',NULL,NULL,1,'default',3,NULL,0,8,'0','catalog/eav_attribute','catalog/category_attribute_collection'),(4,'catalog_product','catalog/product','catalog/resource_eav_attribute','catalog/product',NULL,NULL,1,'default',4,NULL,0,8,'0','catalog/eav_attribute','catalog/product_attribute_collection'),(5,'order','sales/order',NULL,'sales/order',NULL,NULL,1,'default',0,'eav/entity_increment_numeric',1,8,'0',NULL,NULL),(6,'invoice','sales/order_invoice',NULL,'sales/invoice',NULL,NULL,1,'default',0,'eav/entity_increment_numeric',1,8,'0',NULL,NULL),(7,'creditmemo','sales/order_creditmemo',NULL,'sales/creditmemo',NULL,NULL,1,'default',0,'eav/entity_increment_numeric',1,8,'0',NULL,NULL),(8,'shipment','sales/order_shipment',NULL,'sales/shipment',NULL,NULL,1,'default',0,'eav/entity_increment_numeric',1,8,'0',NULL,NULL);
/*!40000 ALTER TABLE `mag_eav_entity_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_eav_entity_varchar`
--

DROP TABLE IF EXISTS `mag_eav_entity_varchar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_eav_entity_varchar` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `entity_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Type Id',
  `attribute_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Attribute Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `value` varchar(255) DEFAULT NULL COMMENT 'Attribute Value',
  PRIMARY KEY (`value_id`),
  UNIQUE KEY `UNQ_MAG_EAV_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` (`entity_id`,`attribute_id`,`store_id`),
  KEY `IDX_MAG_EAV_ENTITY_VARCHAR_ENTITY_TYPE_ID` (`entity_type_id`),
  KEY `IDX_MAG_EAV_ENTITY_VARCHAR_ATTRIBUTE_ID` (`attribute_id`),
  KEY `IDX_MAG_EAV_ENTITY_VARCHAR_STORE_ID` (`store_id`),
  KEY `IDX_MAG_EAV_ENTITY_VARCHAR_ENTITY_ID` (`entity_id`),
  KEY `IDX_MAG_EAV_ENTITY_VARCHAR_ATTRIBUTE_ID_VALUE` (`attribute_id`,`value`),
  KEY `IDX_MAG_EAV_ENTITY_VARCHAR_ENTITY_TYPE_ID_VALUE` (`entity_type_id`,`value`),
  CONSTRAINT `FK_MAG_EAV_ENTITY_VARCHAR_ENTITY_ID_MAG_EAV_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `mag_eav_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_EAV_ENTITY_VARCHAR_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_EAV_ENTT_VCHR_ENTT_TYPE_ID_MAG_EAV_ENTT_TYPE_ENTT_TYPE_ID` FOREIGN KEY (`entity_type_id`) REFERENCES `mag_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Entity Value Prefix';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_eav_entity_varchar`
--

LOCK TABLES `mag_eav_entity_varchar` WRITE;
/*!40000 ALTER TABLE `mag_eav_entity_varchar` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_eav_entity_varchar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_eav_form_element`
--

DROP TABLE IF EXISTS `mag_eav_form_element`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_eav_form_element` (
  `element_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Element Id',
  `type_id` smallint(5) unsigned NOT NULL COMMENT 'Type Id',
  `fieldset_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Fieldset Id',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  `sort_order` int(11) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`element_id`),
  UNIQUE KEY `UNQ_MAG_EAV_FORM_ELEMENT_TYPE_ID_ATTRIBUTE_ID` (`type_id`,`attribute_id`),
  KEY `IDX_MAG_EAV_FORM_ELEMENT_TYPE_ID` (`type_id`),
  KEY `IDX_MAG_EAV_FORM_ELEMENT_FIELDSET_ID` (`fieldset_id`),
  KEY `IDX_MAG_EAV_FORM_ELEMENT_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `FK_MAG_EAV_FORM_ELEMENT_TYPE_ID_MAG_EAV_FORM_TYPE_TYPE_ID` FOREIGN KEY (`type_id`) REFERENCES `mag_eav_form_type` (`type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_EAV_FORM_ELM_ATTR_ID_MAG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mag_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_EAV_FORM_ELM_FSET_ID_MAG_EAV_FORM_FSET_FSET_ID` FOREIGN KEY (`fieldset_id`) REFERENCES `mag_eav_form_fieldset` (`fieldset_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 COMMENT='Eav Form Element';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_eav_form_element`
--

LOCK TABLES `mag_eav_form_element` WRITE;
/*!40000 ALTER TABLE `mag_eav_form_element` DISABLE KEYS */;
INSERT INTO `mag_eav_form_element` VALUES (1,1,NULL,20,0),(2,1,NULL,22,1),(3,1,NULL,24,2),(4,1,NULL,9,3),(5,1,NULL,25,4),(6,1,NULL,26,5),(7,1,NULL,28,6),(8,1,NULL,30,7),(9,1,NULL,27,8),(10,1,NULL,31,9),(11,1,NULL,32,10),(12,2,NULL,20,0),(13,2,NULL,22,1),(14,2,NULL,24,2),(15,2,NULL,9,3),(16,2,NULL,25,4),(17,2,NULL,26,5),(18,2,NULL,28,6),(19,2,NULL,30,7),(20,2,NULL,27,8),(21,2,NULL,31,9),(22,2,NULL,32,10),(23,3,NULL,20,0),(24,3,NULL,22,1),(25,3,NULL,24,2),(26,3,NULL,25,3),(27,3,NULL,26,4),(28,3,NULL,28,5),(29,3,NULL,30,6),(30,3,NULL,27,7),(31,3,NULL,31,8),(32,3,NULL,32,9),(33,4,NULL,20,0),(34,4,NULL,22,1),(35,4,NULL,24,2),(36,4,NULL,25,3),(37,4,NULL,26,4),(38,4,NULL,28,5),(39,4,NULL,30,6),(40,4,NULL,27,7),(41,4,NULL,31,8),(42,4,NULL,32,9),(43,5,1,5,0),(44,5,1,7,1),(45,5,1,9,2),(46,5,2,24,0),(47,5,2,31,1),(48,5,2,25,2),(49,5,2,26,3),(50,5,2,28,4),(51,5,2,30,5),(52,5,2,27,6);
/*!40000 ALTER TABLE `mag_eav_form_element` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_eav_form_fieldset`
--

DROP TABLE IF EXISTS `mag_eav_form_fieldset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_eav_form_fieldset` (
  `fieldset_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Fieldset Id',
  `type_id` smallint(5) unsigned NOT NULL COMMENT 'Type Id',
  `code` varchar(64) NOT NULL COMMENT 'Code',
  `sort_order` int(11) NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  PRIMARY KEY (`fieldset_id`),
  UNIQUE KEY `UNQ_MAG_EAV_FORM_FIELDSET_TYPE_ID_CODE` (`type_id`,`code`),
  KEY `IDX_MAG_EAV_FORM_FIELDSET_TYPE_ID` (`type_id`),
  CONSTRAINT `FK_MAG_EAV_FORM_FIELDSET_TYPE_ID_MAG_EAV_FORM_TYPE_TYPE_ID` FOREIGN KEY (`type_id`) REFERENCES `mag_eav_form_type` (`type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Eav Form Fieldset';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_eav_form_fieldset`
--

LOCK TABLES `mag_eav_form_fieldset` WRITE;
/*!40000 ALTER TABLE `mag_eav_form_fieldset` DISABLE KEYS */;
INSERT INTO `mag_eav_form_fieldset` VALUES (1,5,'general',1),(2,5,'address',2);
/*!40000 ALTER TABLE `mag_eav_form_fieldset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_eav_form_fieldset_label`
--

DROP TABLE IF EXISTS `mag_eav_form_fieldset_label`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_eav_form_fieldset_label` (
  `fieldset_id` smallint(5) unsigned NOT NULL COMMENT 'Fieldset Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `label` varchar(255) NOT NULL COMMENT 'Label',
  PRIMARY KEY (`fieldset_id`,`store_id`),
  KEY `IDX_MAG_EAV_FORM_FIELDSET_LABEL_FIELDSET_ID` (`fieldset_id`),
  KEY `IDX_MAG_EAV_FORM_FIELDSET_LABEL_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MAG_EAV_FORM_FIELDSET_LABEL_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_EAV_FORM_FSET_LBL_FSET_ID_MAG_EAV_FORM_FSET_FSET_ID` FOREIGN KEY (`fieldset_id`) REFERENCES `mag_eav_form_fieldset` (`fieldset_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Form Fieldset Label';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_eav_form_fieldset_label`
--

LOCK TABLES `mag_eav_form_fieldset_label` WRITE;
/*!40000 ALTER TABLE `mag_eav_form_fieldset_label` DISABLE KEYS */;
INSERT INTO `mag_eav_form_fieldset_label` VALUES (1,0,'Personal Information'),(2,0,'Address Information');
/*!40000 ALTER TABLE `mag_eav_form_fieldset_label` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_eav_form_type`
--

DROP TABLE IF EXISTS `mag_eav_form_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_eav_form_type` (
  `type_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Type Id',
  `code` varchar(64) NOT NULL COMMENT 'Code',
  `label` varchar(255) NOT NULL COMMENT 'Label',
  `is_system` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is System',
  `theme` varchar(64) DEFAULT NULL COMMENT 'Theme',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  PRIMARY KEY (`type_id`),
  UNIQUE KEY `UNQ_MAG_EAV_FORM_TYPE_CODE_THEME_STORE_ID` (`code`,`theme`,`store_id`),
  KEY `IDX_MAG_EAV_FORM_TYPE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MAG_EAV_FORM_TYPE_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='Eav Form Type';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_eav_form_type`
--

LOCK TABLES `mag_eav_form_type` WRITE;
/*!40000 ALTER TABLE `mag_eav_form_type` DISABLE KEYS */;
INSERT INTO `mag_eav_form_type` VALUES (1,'checkout_onepage_register','checkout_onepage_register',1,'',0),(2,'checkout_onepage_register_guest','checkout_onepage_register_guest',1,'',0),(3,'checkout_onepage_billing_address','checkout_onepage_billing_address',1,'',0),(4,'checkout_onepage_shipping_address','checkout_onepage_shipping_address',1,'',0),(5,'checkout_multishipping_register','checkout_multishipping_register',1,'',0);
/*!40000 ALTER TABLE `mag_eav_form_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_eav_form_type_entity`
--

DROP TABLE IF EXISTS `mag_eav_form_type_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_eav_form_type_entity` (
  `type_id` smallint(5) unsigned NOT NULL COMMENT 'Type Id',
  `entity_type_id` smallint(5) unsigned NOT NULL COMMENT 'Entity Type Id',
  PRIMARY KEY (`type_id`,`entity_type_id`),
  KEY `IDX_MAG_EAV_FORM_TYPE_ENTITY_ENTITY_TYPE_ID` (`entity_type_id`),
  CONSTRAINT `FK_D8FA32D81FA9D19180F2214A43BF5CA5` FOREIGN KEY (`entity_type_id`) REFERENCES `mag_eav_entity_type` (`entity_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_EAV_FORM_TYPE_ENTITY_TYPE_ID_MAG_EAV_FORM_TYPE_TYPE_ID` FOREIGN KEY (`type_id`) REFERENCES `mag_eav_form_type` (`type_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Eav Form Type Entity';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_eav_form_type_entity`
--

LOCK TABLES `mag_eav_form_type_entity` WRITE;
/*!40000 ALTER TABLE `mag_eav_form_type_entity` DISABLE KEYS */;
INSERT INTO `mag_eav_form_type_entity` VALUES (1,1),(2,1),(5,1),(1,2),(2,2),(3,2),(4,2),(5,2);
/*!40000 ALTER TABLE `mag_eav_form_type_entity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_gift_message`
--

DROP TABLE IF EXISTS `mag_gift_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_gift_message` (
  `gift_message_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'GiftMessage Id',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer id',
  `sender` varchar(255) DEFAULT NULL COMMENT 'Sender',
  `recipient` varchar(255) DEFAULT NULL COMMENT 'Recipient',
  `message` text COMMENT 'Message',
  PRIMARY KEY (`gift_message_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Gift Message';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_gift_message`
--

LOCK TABLES `mag_gift_message` WRITE;
/*!40000 ALTER TABLE `mag_gift_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_gift_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_importexport_importdata`
--

DROP TABLE IF EXISTS `mag_importexport_importdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_importexport_importdata` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `entity` varchar(50) NOT NULL COMMENT 'Entity',
  `behavior` varchar(10) NOT NULL DEFAULT 'append' COMMENT 'Behavior',
  `data` longtext COMMENT 'Data',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Import Data Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_importexport_importdata`
--

LOCK TABLES `mag_importexport_importdata` WRITE;
/*!40000 ALTER TABLE `mag_importexport_importdata` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_importexport_importdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_index_event`
--

DROP TABLE IF EXISTS `mag_index_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_index_event` (
  `event_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Event Id',
  `type` varchar(64) NOT NULL COMMENT 'Type',
  `entity` varchar(64) NOT NULL COMMENT 'Entity',
  `entity_pk` bigint(20) DEFAULT NULL COMMENT 'Entity Primary Key',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Creation Time',
  `old_data` mediumtext COMMENT 'Old Data',
  `new_data` mediumtext COMMENT 'New Data',
  PRIMARY KEY (`event_id`),
  UNIQUE KEY `UNQ_MAG_INDEX_EVENT_TYPE_ENTITY_ENTITY_PK` (`type`,`entity`,`entity_pk`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Index Event';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_index_event`
--

LOCK TABLES `mag_index_event` WRITE;
/*!40000 ALTER TABLE `mag_index_event` DISABLE KEYS */;
INSERT INTO `mag_index_event` VALUES (1,'save','catalog_category',1,'2015-02-19 08:09:23',NULL,'a:5:{s:35:\"cataloginventory_stock_match_result\";b:0;s:34:\"catalog_product_price_match_result\";b:0;s:24:\"catalog_url_match_result\";b:1;s:37:\"catalog_category_product_match_result\";b:1;s:35:\"catalogsearch_fulltext_match_result\";b:1;}'),(2,'save','catalog_category',2,'2015-02-19 08:09:23',NULL,'a:5:{s:35:\"cataloginventory_stock_match_result\";b:0;s:34:\"catalog_product_price_match_result\";b:0;s:24:\"catalog_url_match_result\";b:1;s:37:\"catalog_category_product_match_result\";b:1;s:35:\"catalogsearch_fulltext_match_result\";b:1;}');
/*!40000 ALTER TABLE `mag_index_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_index_process`
--

DROP TABLE IF EXISTS `mag_index_process`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_index_process` (
  `process_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Process Id',
  `indexer_code` varchar(32) NOT NULL COMMENT 'Indexer Code',
  `status` varchar(15) NOT NULL DEFAULT 'pending' COMMENT 'Status',
  `started_at` timestamp NULL DEFAULT NULL COMMENT 'Started At',
  `ended_at` timestamp NULL DEFAULT NULL COMMENT 'Ended At',
  `mode` varchar(9) NOT NULL DEFAULT 'real_time' COMMENT 'Mode',
  PRIMARY KEY (`process_id`),
  UNIQUE KEY `UNQ_MAG_INDEX_PROCESS_INDEXER_CODE` (`indexer_code`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='Index Process';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_index_process`
--

LOCK TABLES `mag_index_process` WRITE;
/*!40000 ALTER TABLE `mag_index_process` DISABLE KEYS */;
INSERT INTO `mag_index_process` VALUES (1,'catalog_product_attribute','require_reindex',NULL,NULL,'real_time'),(2,'catalog_product_price','require_reindex',NULL,NULL,'real_time'),(3,'catalog_url','require_reindex','2015-02-19 08:09:23','2015-02-19 08:09:23','real_time'),(4,'catalog_product_flat','require_reindex',NULL,NULL,'real_time'),(5,'catalog_category_flat','require_reindex',NULL,NULL,'real_time'),(6,'catalog_category_product','require_reindex','2015-02-19 08:09:23','2015-02-19 08:09:23','real_time'),(7,'catalogsearch_fulltext','require_reindex','2015-02-19 08:09:23','2015-02-19 08:09:23','real_time'),(8,'cataloginventory_stock','require_reindex',NULL,NULL,'real_time'),(9,'tag_summary','require_reindex',NULL,NULL,'real_time');
/*!40000 ALTER TABLE `mag_index_process` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_index_process_event`
--

DROP TABLE IF EXISTS `mag_index_process_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_index_process_event` (
  `process_id` int(10) unsigned NOT NULL COMMENT 'Process Id',
  `event_id` bigint(20) unsigned NOT NULL COMMENT 'Event Id',
  `status` varchar(7) NOT NULL DEFAULT 'new' COMMENT 'Status',
  PRIMARY KEY (`process_id`,`event_id`),
  KEY `IDX_MAG_INDEX_PROCESS_EVENT_EVENT_ID` (`event_id`),
  CONSTRAINT `FK_MAG_IDX_PROCESS_EVENT_PROCESS_ID_MAG_IDX_PROCESS_PROCESS_ID` FOREIGN KEY (`process_id`) REFERENCES `mag_index_process` (`process_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_INDEX_PROCESS_EVENT_EVENT_ID_MAG_INDEX_EVENT_EVENT_ID` FOREIGN KEY (`event_id`) REFERENCES `mag_index_event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Index Process Event';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_index_process_event`
--

LOCK TABLES `mag_index_process_event` WRITE;
/*!40000 ALTER TABLE `mag_index_process_event` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_index_process_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_log_customer`
--

DROP TABLE IF EXISTS `mag_log_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_log_customer` (
  `log_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Log ID',
  `visitor_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Visitor ID',
  `customer_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Customer ID',
  `login_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Login Time',
  `logout_at` timestamp NULL DEFAULT NULL COMMENT 'Logout Time',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  PRIMARY KEY (`log_id`),
  KEY `IDX_MAG_LOG_CUSTOMER_VISITOR_ID` (`visitor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Log Customers Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_log_customer`
--

LOCK TABLES `mag_log_customer` WRITE;
/*!40000 ALTER TABLE `mag_log_customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_log_customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_log_quote`
--

DROP TABLE IF EXISTS `mag_log_quote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_log_quote` (
  `quote_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quote ID',
  `visitor_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Visitor ID',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Creation Time',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT 'Deletion Time',
  PRIMARY KEY (`quote_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Log Quotes Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_log_quote`
--

LOCK TABLES `mag_log_quote` WRITE;
/*!40000 ALTER TABLE `mag_log_quote` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_log_quote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_log_summary`
--

DROP TABLE IF EXISTS `mag_log_summary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_log_summary` (
  `summary_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Summary ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  `type_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Type ID',
  `visitor_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Visitor Count',
  `customer_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Customer Count',
  `add_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Date',
  PRIMARY KEY (`summary_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Log Summary Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_log_summary`
--

LOCK TABLES `mag_log_summary` WRITE;
/*!40000 ALTER TABLE `mag_log_summary` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_log_summary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_log_summary_type`
--

DROP TABLE IF EXISTS `mag_log_summary_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_log_summary_type` (
  `type_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Type ID',
  `type_code` varchar(64) DEFAULT NULL COMMENT 'Type Code',
  `period` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Period',
  `period_type` varchar(6) NOT NULL DEFAULT 'MINUTE' COMMENT 'Period Type',
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Log Summary Types Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_log_summary_type`
--

LOCK TABLES `mag_log_summary_type` WRITE;
/*!40000 ALTER TABLE `mag_log_summary_type` DISABLE KEYS */;
INSERT INTO `mag_log_summary_type` VALUES (1,'hour',1,'HOUR'),(2,'day',1,'DAY');
/*!40000 ALTER TABLE `mag_log_summary_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_log_url`
--

DROP TABLE IF EXISTS `mag_log_url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_log_url` (
  `url_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'URL ID',
  `visitor_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Visitor ID',
  `visit_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Visit Time',
  KEY `IDX_MAG_LOG_URL_VISITOR_ID` (`visitor_id`),
  KEY `url_id` (`url_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Log URL Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_log_url`
--

LOCK TABLES `mag_log_url` WRITE;
/*!40000 ALTER TABLE `mag_log_url` DISABLE KEYS */;
INSERT INTO `mag_log_url` VALUES (1,1,'2015-02-19 08:11:40'),(2,1,'2015-02-19 08:29:04'),(3,1,'2015-02-19 08:30:01'),(4,1,'2015-02-19 08:31:47'),(5,2,'2015-02-19 08:59:47'),(6,3,'2015-02-19 09:21:21'),(7,3,'2015-02-19 09:23:26');
/*!40000 ALTER TABLE `mag_log_url` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_log_url_info`
--

DROP TABLE IF EXISTS `mag_log_url_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_log_url_info` (
  `url_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'URL ID',
  `url` varchar(255) DEFAULT NULL COMMENT 'URL',
  `referer` varchar(255) DEFAULT NULL COMMENT 'Referrer',
  PRIMARY KEY (`url_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='Log URL Info Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_log_url_info`
--

LOCK TABLES `mag_log_url_info` WRITE;
/*!40000 ALTER TABLE `mag_log_url_info` DISABLE KEYS */;
INSERT INTO `mag_log_url_info` VALUES (1,'http://magento.loc/index.php/','http://magento.loc/index.php/install/wizard/end/'),(2,'http://magento.loc/index.php/','http://magento.loc/index.php/install/wizard/end/'),(3,'http://magento.loc/index.php/','http://magento.loc/index.php/install/wizard/end/'),(4,'http://magento.loc/index.php/','http://magento.loc/index.php/install/wizard/end/'),(5,'http://magento.dev/',NULL),(6,'http://magento.dev/',NULL),(7,'http://magento.dev/',NULL);
/*!40000 ALTER TABLE `mag_log_url_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_log_visitor`
--

DROP TABLE IF EXISTS `mag_log_visitor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_log_visitor` (
  `visitor_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Visitor ID',
  `session_id` varchar(64) DEFAULT NULL COMMENT 'Session ID',
  `first_visit_at` timestamp NULL DEFAULT NULL COMMENT 'First Visit Time',
  `last_visit_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Last Visit Time',
  `last_url_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Last URL ID',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store ID',
  PRIMARY KEY (`visitor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Log Visitors Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_log_visitor`
--

LOCK TABLES `mag_log_visitor` WRITE;
/*!40000 ALTER TABLE `mag_log_visitor` DISABLE KEYS */;
INSERT INTO `mag_log_visitor` VALUES (1,'6eace4lvm9ijcstn7hrgmdtk82','2015-02-19 08:11:39','2015-02-19 08:31:47',4,1),(2,'e23lsqchaag7d8d22lmkq61ba6','2015-02-19 08:59:43','2015-02-19 08:59:47',5,1),(3,'7tq6vmshv1ltebum7tm9g2dtb4','2015-02-19 09:21:19','2015-02-19 09:23:26',7,1);
/*!40000 ALTER TABLE `mag_log_visitor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_log_visitor_info`
--

DROP TABLE IF EXISTS `mag_log_visitor_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_log_visitor_info` (
  `visitor_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Visitor ID',
  `http_referer` varchar(255) DEFAULT NULL COMMENT 'HTTP Referrer',
  `http_user_agent` varchar(255) DEFAULT NULL COMMENT 'HTTP User-Agent',
  `http_accept_charset` varchar(255) DEFAULT NULL COMMENT 'HTTP Accept-Charset',
  `http_accept_language` varchar(255) DEFAULT NULL COMMENT 'HTTP Accept-Language',
  `server_addr` bigint(20) DEFAULT NULL COMMENT 'Server Address',
  `remote_addr` bigint(20) DEFAULT NULL COMMENT 'Remote Address',
  PRIMARY KEY (`visitor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Log Visitor Info Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_log_visitor_info`
--

LOCK TABLES `mag_log_visitor_info` WRITE;
/*!40000 ALTER TABLE `mag_log_visitor_info` DISABLE KEYS */;
INSERT INTO `mag_log_visitor_info` VALUES (1,'http://magento.loc/index.php/install/wizard/end/','Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36',NULL,'ru,en-US;q=0.8,en;q=0.6',2130706433,2130706433),(2,NULL,'Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36',NULL,'ru,en-US;q=0.8,en;q=0.6',2130706433,2130706433),(3,NULL,'Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.111 Safari/537.36',NULL,'ru-RU,ru;q=0.8,en-US;q=0.6,en;q=0.4',2130706433,2130706433);
/*!40000 ALTER TABLE `mag_log_visitor_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_log_visitor_online`
--

DROP TABLE IF EXISTS `mag_log_visitor_online`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_log_visitor_online` (
  `visitor_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Visitor ID',
  `visitor_type` varchar(1) NOT NULL COMMENT 'Visitor Type',
  `remote_addr` bigint(20) NOT NULL COMMENT 'Remote Address',
  `first_visit_at` timestamp NULL DEFAULT NULL COMMENT 'First Visit Time',
  `last_visit_at` timestamp NULL DEFAULT NULL COMMENT 'Last Visit Time',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer ID',
  `last_url` varchar(255) DEFAULT NULL COMMENT 'Last URL',
  PRIMARY KEY (`visitor_id`),
  KEY `IDX_MAG_LOG_VISITOR_ONLINE_VISITOR_TYPE` (`visitor_type`),
  KEY `IDX_MAG_LOG_VISITOR_ONLINE_FIRST_VISIT_AT_LAST_VISIT_AT` (`first_visit_at`,`last_visit_at`),
  KEY `IDX_MAG_LOG_VISITOR_ONLINE_CUSTOMER_ID` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Log Visitor Online Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_log_visitor_online`
--

LOCK TABLES `mag_log_visitor_online` WRITE;
/*!40000 ALTER TABLE `mag_log_visitor_online` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_log_visitor_online` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_newsletter_problem`
--

DROP TABLE IF EXISTS `mag_newsletter_problem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_newsletter_problem` (
  `problem_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Problem Id',
  `subscriber_id` int(10) unsigned DEFAULT NULL COMMENT 'Subscriber Id',
  `queue_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Queue Id',
  `problem_error_code` int(10) unsigned DEFAULT '0' COMMENT 'Problem Error Code',
  `problem_error_text` varchar(200) DEFAULT NULL COMMENT 'Problem Error Text',
  PRIMARY KEY (`problem_id`),
  KEY `IDX_MAG_NEWSLETTER_PROBLEM_SUBSCRIBER_ID` (`subscriber_id`),
  KEY `IDX_MAG_NEWSLETTER_PROBLEM_QUEUE_ID` (`queue_id`),
  CONSTRAINT `FK_6B6E6FCEE66E8B48C01AC342F1DC9AEE` FOREIGN KEY (`subscriber_id`) REFERENCES `mag_newsletter_subscriber` (`subscriber_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_NEWSLETTER_PROBLEM_QUEUE_ID_MAG_NEWSLETTER_QUEUE_QUEUE_ID` FOREIGN KEY (`queue_id`) REFERENCES `mag_newsletter_queue` (`queue_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Newsletter Problems';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_newsletter_problem`
--

LOCK TABLES `mag_newsletter_problem` WRITE;
/*!40000 ALTER TABLE `mag_newsletter_problem` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_newsletter_problem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_newsletter_queue`
--

DROP TABLE IF EXISTS `mag_newsletter_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_newsletter_queue` (
  `queue_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Queue Id',
  `template_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Template Id',
  `newsletter_type` int(11) DEFAULT NULL COMMENT 'Newsletter Type',
  `newsletter_text` text COMMENT 'Newsletter Text',
  `newsletter_styles` text COMMENT 'Newsletter Styles',
  `newsletter_subject` varchar(200) DEFAULT NULL COMMENT 'Newsletter Subject',
  `newsletter_sender_name` varchar(200) DEFAULT NULL COMMENT 'Newsletter Sender Name',
  `newsletter_sender_email` varchar(200) DEFAULT NULL COMMENT 'Newsletter Sender Email',
  `queue_status` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Queue Status',
  `queue_start_at` timestamp NULL DEFAULT NULL COMMENT 'Queue Start At',
  `queue_finish_at` timestamp NULL DEFAULT NULL COMMENT 'Queue Finish At',
  PRIMARY KEY (`queue_id`),
  KEY `IDX_MAG_NEWSLETTER_QUEUE_TEMPLATE_ID` (`template_id`),
  CONSTRAINT `FK_MAG_NLTTR_QUEUE_TEMPLATE_ID_MAG_NLTTR_TEMPLATE_TEMPLATE_ID` FOREIGN KEY (`template_id`) REFERENCES `mag_newsletter_template` (`template_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Newsletter Queue';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_newsletter_queue`
--

LOCK TABLES `mag_newsletter_queue` WRITE;
/*!40000 ALTER TABLE `mag_newsletter_queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_newsletter_queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_newsletter_queue_link`
--

DROP TABLE IF EXISTS `mag_newsletter_queue_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_newsletter_queue_link` (
  `queue_link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Queue Link Id',
  `queue_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Queue Id',
  `subscriber_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Subscriber Id',
  `letter_sent_at` timestamp NULL DEFAULT NULL COMMENT 'Letter Sent At',
  PRIMARY KEY (`queue_link_id`),
  KEY `IDX_MAG_NEWSLETTER_QUEUE_LINK_SUBSCRIBER_ID` (`subscriber_id`),
  KEY `IDX_MAG_NEWSLETTER_QUEUE_LINK_QUEUE_ID` (`queue_id`),
  KEY `IDX_MAG_NEWSLETTER_QUEUE_LINK_QUEUE_ID_LETTER_SENT_AT` (`queue_id`,`letter_sent_at`),
  CONSTRAINT `FK_F6C2CF4EAAF12BB256A097EB23CFD16C` FOREIGN KEY (`subscriber_id`) REFERENCES `mag_newsletter_subscriber` (`subscriber_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_NLTTR_QUEUE_LNK_QUEUE_ID_MAG_NLTTR_QUEUE_QUEUE_ID` FOREIGN KEY (`queue_id`) REFERENCES `mag_newsletter_queue` (`queue_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Newsletter Queue Link';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_newsletter_queue_link`
--

LOCK TABLES `mag_newsletter_queue_link` WRITE;
/*!40000 ALTER TABLE `mag_newsletter_queue_link` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_newsletter_queue_link` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_newsletter_queue_store_link`
--

DROP TABLE IF EXISTS `mag_newsletter_queue_store_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_newsletter_queue_store_link` (
  `queue_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Queue Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  PRIMARY KEY (`queue_id`,`store_id`),
  KEY `IDX_MAG_NEWSLETTER_QUEUE_STORE_LINK_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MAG_NLTTR_QUEUE_STORE_LNK_QUEUE_ID_MAG_NLTTR_QUEUE_QUEUE_ID` FOREIGN KEY (`queue_id`) REFERENCES `mag_newsletter_queue` (`queue_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_NLTTR_QUEUE_STORE_LNK_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Newsletter Queue Store Link';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_newsletter_queue_store_link`
--

LOCK TABLES `mag_newsletter_queue_store_link` WRITE;
/*!40000 ALTER TABLE `mag_newsletter_queue_store_link` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_newsletter_queue_store_link` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_newsletter_subscriber`
--

DROP TABLE IF EXISTS `mag_newsletter_subscriber`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_newsletter_subscriber` (
  `subscriber_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Subscriber Id',
  `store_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Store Id',
  `change_status_at` timestamp NULL DEFAULT NULL COMMENT 'Change Status At',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Id',
  `subscriber_email` varchar(150) DEFAULT NULL COMMENT 'Subscriber Email',
  `subscriber_status` int(11) NOT NULL DEFAULT '0' COMMENT 'Subscriber Status',
  `subscriber_confirm_code` varchar(32) DEFAULT 'NULL' COMMENT 'Subscriber Confirm Code',
  PRIMARY KEY (`subscriber_id`),
  KEY `IDX_MAG_NEWSLETTER_SUBSCRIBER_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_MAG_NEWSLETTER_SUBSCRIBER_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MAG_NEWSLETTER_SUBSCRIBER_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Newsletter Subscriber';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_newsletter_subscriber`
--

LOCK TABLES `mag_newsletter_subscriber` WRITE;
/*!40000 ALTER TABLE `mag_newsletter_subscriber` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_newsletter_subscriber` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_newsletter_template`
--

DROP TABLE IF EXISTS `mag_newsletter_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_newsletter_template` (
  `template_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Template Id',
  `template_code` varchar(150) DEFAULT NULL COMMENT 'Template Code',
  `template_text` text COMMENT 'Template Text',
  `template_text_preprocessed` text COMMENT 'Template Text Preprocessed',
  `template_styles` text COMMENT 'Template Styles',
  `template_type` int(10) unsigned DEFAULT NULL COMMENT 'Template Type',
  `template_subject` varchar(200) DEFAULT NULL COMMENT 'Template Subject',
  `template_sender_name` varchar(200) DEFAULT NULL COMMENT 'Template Sender Name',
  `template_sender_email` varchar(200) DEFAULT NULL COMMENT 'Template Sender Email',
  `template_actual` smallint(5) unsigned DEFAULT '1' COMMENT 'Template Actual',
  `added_at` timestamp NULL DEFAULT NULL COMMENT 'Added At',
  `modified_at` timestamp NULL DEFAULT NULL COMMENT 'Modified At',
  PRIMARY KEY (`template_id`),
  KEY `IDX_MAG_NEWSLETTER_TEMPLATE_TEMPLATE_ACTUAL` (`template_actual`),
  KEY `IDX_MAG_NEWSLETTER_TEMPLATE_ADDED_AT` (`added_at`),
  KEY `IDX_MAG_NEWSLETTER_TEMPLATE_MODIFIED_AT` (`modified_at`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Newsletter Template';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_newsletter_template`
--

LOCK TABLES `mag_newsletter_template` WRITE;
/*!40000 ALTER TABLE `mag_newsletter_template` DISABLE KEYS */;
INSERT INTO `mag_newsletter_template` VALUES (1,'Example Newsletter Template','{{template config_path=\"design/email/header\"}}\n{{inlinecss file=\"email-inline.css\"}}\n\n<table cellpadding=\"0\" cellspacing=\"0\" border=\"0\">\n<tr>\n    <td class=\"full\">\n        <table class=\"columns\">\n            <tr>\n                <td class=\"email-heading\">\n                    <h1>Welcome</h1>\n                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit,\n                    sed do eiusmod tempor incididunt ut labore et.</p>\n                </td>\n                <td class=\"store-info\">\n                    <h4>Contact Us</h4>\n                    <p>\n                        {{depend store_phone}}\n                        <b>Call Us:</b>\n                        <a href=\"tel:{{var phone}}\">{{var store_phone}}</a><br>\n                        {{/depend}}\n                        {{depend store_hours}}\n                        <span class=\"no-link\">{{var store_hours}}</span><br>\n                        {{/depend}}\n                        {{depend store_email}}\n                        <b>Email:</b> <a href=\"mailto:{{var store_email}}\">{{var store_email}}</a>\n                        {{/depend}}\n                    </p>\n                </td>\n            </tr>\n        </table>\n    </td>\n</tr>\n<tr>\n    <td class=\"full\">\n        <table class=\"columns\">\n            <tr>\n                <td>\n                    <img width=\"600\" src=\"http://placehold.it/600x200\" class=\"main-image\">\n                </td>\n                <td class=\"expander\"></td>\n            </tr>\n        </table>\n        <table class=\"columns\">\n            <tr>\n                <td class=\"panel\">\n                    <p>Phasellus dictum sapien a neque luctus cursus. Pellentesque sem dolor, fringilla et pharetra\n                    vitae. <a href=\"#\">Click it! &raquo;</a></p>\n                </td>\n                <td class=\"expander\"></td>\n            </tr>\n        </table>\n    </td>\n</tr>\n<tr>\n    <td>\n        <table class=\"row\">\n            <tr>\n                <td class=\"half left wrapper\">\n                    <table class=\"columns\">\n                        <tr>\n                            <td>\n                                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor\n                                incididunt ut labore et. Lorem ipsum dolor sit amet, consectetur adipisicing elit,\n                                sed do eiusmod tempor incididunt ut labore et. Lorem ipsum dolor sit amet.</p>\n                                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor\n                                incididunt ut labore et. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed\n                                do eiusmod tempor incididunt ut labore et. Lorem ipsum dolor sit amet.</p>\n                                <table class=\"button\">\n                                    <tr>\n                                        <td>\n                                            <a href=\"#\">Click Me!</a>\n                                        </td>\n                                    </tr>\n                                </table>\n                            </td>\n                            <td class=\"expander\"></td>\n                        </tr>\n                    </table>\n                </td>\n                <td class=\"half right wrapper last\">\n                    <table class=\"columns\">\n                        <tr>\n                            <td class=\"panel sidebar-links\">\n                                <h6>Header Thing</h6>\n                                <p>Sub-head or something</p>\n                                <table>\n                                    <tr>\n                                        <td>\n                                            <p><a href=\"#\">Just a Plain Link &raquo;</a></p>\n                                        </td>\n                                    </tr>\n                                    <tr>\n                                        <td>\n                                            <hr/>\n                                        </td>\n                                    </tr>\n                                    <tr>\n                                        <td>\n                                            <p><a href=\"#\">Just a Plain Link &raquo;</a></p>\n                                        </td>\n                                    </tr>\n                                    <tr>\n                                        <td>\n                                            <hr/>\n                                        </td>\n                                    </tr>\n                                    <tr>\n                                        <td>\n                                            <p><a href=\"#\">Just a Plain Link &raquo;</a></p>\n                                        </td>\n                                    </tr>\n                                    <tr>\n                                        <td>\n                                            <hr/>\n                                        </td>\n                                    </tr>\n                                    <tr>\n                                        <td>\n                                            <p><a href=\"#\">Just a Plain Link &raquo;</a></p>\n                                        </td>\n                                    </tr>\n                                    <tr>\n                                        <td>\n                                            <hr/>\n                                        </td>\n                                    </tr>\n                                    <tr>\n                                        <td>\n                                            <p><a href=\"#\">Just a Plain Link &raquo;</a></p>\n                                        </td>\n                                    </tr>\n                                    <tr>\n                                        <td>\n                                            <hr/>\n                                        </td>\n                                    </tr>\n                                    <tr>\n                                        <td>\n                                            <p><a href=\"#\">Just a Plain Link &raquo;</a></p>\n                                        </td>\n                                    </tr>\n                                    <tr>\n                                        <td>\n                                            <hr/>\n                                        </td>\n                                    </tr>\n                                    <tr>\n                                        <td>\n                                            <p><a href=\"#\">Just a Plain Link &raquo;</a></p>\n                                        </td>\n                                    </tr>\n                                    <tr><td>&nbsp;</td></tr>\n                                </table>\n                            </td>\n                            <td class=\"expander\"></td>\n                        </tr>\n                    </table>\n                    <br>\n                    <table class=\"columns\">\n                        <tr>\n                            <td class=\"panel\">\n                                <h6>Connect With Us:</h6>\n                                <table class=\"social-button facebook\">\n                                    <tr>\n                                        <td>\n                                            <a href=\"#\">Facebook</a>\n                                        </td>\n                                    </tr>\n                                </table>\n                                <hr>\n                                <table class=\"social-button twitter\">\n                                    <tr>\n                                        <td>\n                                            <a href=\"#\">Twitter</a>\n                                        </td>\n                                    </tr>\n                                </table>\n                                <hr>\n                                <table class=\"social-button google-plus\">\n                                    <tr>\n                                        <td>\n                                            <a href=\"#\">Google +</a>\n                                        </td>\n                                    </tr>\n                                </table>\n                                <br>\n                                <h6>Contact Info:</h6>\n                                {{depend store_phone}}\n                                <p>\n                                    <b>Call Us:</b>\n                                    <a href=\"tel:{{var phone}}\">{{var store_phone}}</a>\n                                </p>\n                                {{/depend}}\n                                {{depend store_hours}}\n                                <p><span class=\"no-link\">{{var store_hours}}</span><br></p>\n                                {{/depend}}\n                                {{depend store_email}}\n                                <p><b>Email:</b> <a href=\"mailto:{{var store_email}}\">{{var store_email}}</a></p>\n                                {{/depend}}\n                            </td>\n                            <td class=\"expander\"></td>\n                        </tr>\n                    </table>\n                </td>\n            </tr>\n        </table>\n        <table class=\"row\">\n            <tr>\n                <td class=\"full wrapper\">\n                    {{block type=\"catalog/product_new\" template=\"email/catalog/product/new.phtml\" products_count=\"4\"\n                    column_count=\"4\" }}\n                </td>\n            </tr>\n        </table>\n        <table class=\"row\">\n            <tr>\n                <td class=\"full wrapper last\">\n                    <table class=\"columns\">\n                        <tr>\n                            <td align=\"center\">\n                                <center>\n                                    <p><a href=\"#\">Terms</a> | <a href=\"#\">Privacy</a> | <a href=\"#\">Unsubscribe</a></p>\n                                </center>\n                            </td>\n                            <td class=\"expander\"></td>\n                        </tr>\n                    </table>\n                </td>\n            </tr>\n        </table>\n    </td>\n</tr>\n</table>\n\n{{template config_path=\"design/email/footer\"}}',NULL,NULL,2,'Example Subject','Owner','owner@example.com',1,'2015-02-19 08:09:25','2015-02-19 08:09:25');
/*!40000 ALTER TABLE `mag_newsletter_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_oauth_consumer`
--

DROP TABLE IF EXISTS `mag_oauth_consumer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_oauth_consumer` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `name` varchar(255) NOT NULL COMMENT 'Name of consumer',
  `key` varchar(32) NOT NULL COMMENT 'Key code',
  `secret` varchar(32) NOT NULL COMMENT 'Secret code',
  `callback_url` varchar(255) DEFAULT NULL COMMENT 'Callback URL',
  `rejected_callback_url` varchar(255) NOT NULL COMMENT 'Rejected callback URL',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_MAG_MAG_OAUTH_CONSUMER_KEY` (`key`),
  UNIQUE KEY `UNQ_MAG_MAG_OAUTH_CONSUMER_SECRET` (`secret`),
  KEY `IDX_MAG_OAUTH_CONSUMER_CREATED_AT` (`created_at`),
  KEY `IDX_MAG_OAUTH_CONSUMER_UPDATED_AT` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='OAuth Consumers';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_oauth_consumer`
--

LOCK TABLES `mag_oauth_consumer` WRITE;
/*!40000 ALTER TABLE `mag_oauth_consumer` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_oauth_consumer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_oauth_nonce`
--

DROP TABLE IF EXISTS `mag_oauth_nonce`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_oauth_nonce` (
  `nonce` varchar(32) NOT NULL COMMENT 'Nonce String',
  `timestamp` int(10) unsigned NOT NULL COMMENT 'Nonce Timestamp',
  UNIQUE KEY `UNQ_MAG_MAG_OAUTH_NONCE_NONCE` (`nonce`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='mag_oauth_nonce';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_oauth_nonce`
--

LOCK TABLES `mag_oauth_nonce` WRITE;
/*!40000 ALTER TABLE `mag_oauth_nonce` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_oauth_nonce` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_oauth_token`
--

DROP TABLE IF EXISTS `mag_oauth_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_oauth_token` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity ID',
  `consumer_id` int(10) unsigned NOT NULL COMMENT 'Consumer ID',
  `admin_id` int(10) unsigned DEFAULT NULL COMMENT 'Admin user ID',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer user ID',
  `type` varchar(16) NOT NULL COMMENT 'Token Type',
  `token` varchar(32) NOT NULL COMMENT 'Token',
  `secret` varchar(32) NOT NULL COMMENT 'Token Secret',
  `verifier` varchar(32) DEFAULT NULL COMMENT 'Token Verifier',
  `callback_url` varchar(255) NOT NULL COMMENT 'Token Callback URL',
  `revoked` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Token revoked',
  `authorized` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Token authorized',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Token creation timestamp',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_MAG_MAG_OAUTH_TOKEN_TOKEN` (`token`),
  KEY `IDX_MAG_MAG_OAUTH_TOKEN_CONSUMER_ID` (`consumer_id`),
  KEY `FK_MAG_OAUTH_TOKEN_ADMIN_ID_MAG_MAG_ADMIN_USER_USER_ID` (`admin_id`),
  KEY `FK_MAG_OAUTH_TOKEN_CUSTOMER_ID_MAG_MAG_CUSTOMER_ENTITY_ENTITY_ID` (`customer_id`),
  CONSTRAINT `FK_MAG_OAUTH_TOKEN_ADMIN_ID_MAG_MAG_ADMIN_USER_USER_ID` FOREIGN KEY (`admin_id`) REFERENCES `mag_admin_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_OAUTH_TOKEN_CONSUMER_ID_MAG_OAUTH_CONSUMER_ENTITY_ID` FOREIGN KEY (`consumer_id`) REFERENCES `mag_oauth_consumer` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_OAUTH_TOKEN_CUSTOMER_ID_MAG_MAG_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `mag_customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='OAuth Tokens';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_oauth_token`
--

LOCK TABLES `mag_oauth_token` WRITE;
/*!40000 ALTER TABLE `mag_oauth_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_oauth_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_paypal_cert`
--

DROP TABLE IF EXISTS `mag_paypal_cert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_paypal_cert` (
  `cert_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Cert Id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `content` text COMMENT 'Content',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  PRIMARY KEY (`cert_id`),
  KEY `IDX_MAG_PAYPAL_CERT_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_MAG_PAYPAL_CERT_WEBSITE_ID_MAG_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `mag_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Paypal Certificate Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_paypal_cert`
--

LOCK TABLES `mag_paypal_cert` WRITE;
/*!40000 ALTER TABLE `mag_paypal_cert` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_paypal_cert` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_paypal_payment_transaction`
--

DROP TABLE IF EXISTS `mag_paypal_payment_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_paypal_payment_transaction` (
  `transaction_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `txn_id` varchar(100) DEFAULT NULL COMMENT 'Txn Id',
  `additional_information` blob COMMENT 'Additional Information',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  PRIMARY KEY (`transaction_id`),
  UNIQUE KEY `UNQ_MAG_PAYPAL_PAYMENT_TRANSACTION_TXN_ID` (`txn_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='PayPal Payflow Link Payment Transaction';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_paypal_payment_transaction`
--

LOCK TABLES `mag_paypal_payment_transaction` WRITE;
/*!40000 ALTER TABLE `mag_paypal_payment_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_paypal_payment_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_paypal_settlement_report`
--

DROP TABLE IF EXISTS `mag_paypal_settlement_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_paypal_settlement_report` (
  `report_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Report Id',
  `report_date` timestamp NULL DEFAULT NULL COMMENT 'Report Date',
  `account_id` varchar(64) DEFAULT NULL COMMENT 'Account Id',
  `filename` varchar(24) DEFAULT NULL COMMENT 'Filename',
  `last_modified` timestamp NULL DEFAULT NULL COMMENT 'Last Modified',
  PRIMARY KEY (`report_id`),
  UNIQUE KEY `UNQ_MAG_PAYPAL_SETTLEMENT_REPORT_REPORT_DATE_ACCOUNT_ID` (`report_date`,`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Paypal Settlement Report Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_paypal_settlement_report`
--

LOCK TABLES `mag_paypal_settlement_report` WRITE;
/*!40000 ALTER TABLE `mag_paypal_settlement_report` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_paypal_settlement_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_paypal_settlement_report_row`
--

DROP TABLE IF EXISTS `mag_paypal_settlement_report_row`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_paypal_settlement_report_row` (
  `row_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Row Id',
  `report_id` int(10) unsigned NOT NULL COMMENT 'Report Id',
  `transaction_id` varchar(19) DEFAULT NULL COMMENT 'Transaction Id',
  `invoice_id` varchar(127) DEFAULT NULL COMMENT 'Invoice Id',
  `paypal_reference_id` varchar(19) DEFAULT NULL COMMENT 'Paypal Reference Id',
  `paypal_reference_id_type` varchar(3) DEFAULT NULL COMMENT 'Paypal Reference Id Type',
  `transaction_event_code` varchar(5) DEFAULT NULL COMMENT 'Transaction Event Code',
  `transaction_initiation_date` timestamp NULL DEFAULT NULL COMMENT 'Transaction Initiation Date',
  `transaction_completion_date` timestamp NULL DEFAULT NULL COMMENT 'Transaction Completion Date',
  `transaction_debit_or_credit` varchar(2) NOT NULL DEFAULT 'CR' COMMENT 'Transaction Debit Or Credit',
  `gross_transaction_amount` decimal(20,6) NOT NULL DEFAULT '0.000000' COMMENT 'Gross Transaction Amount',
  `gross_transaction_currency` varchar(3) DEFAULT '' COMMENT 'Gross Transaction Currency',
  `fee_debit_or_credit` varchar(2) DEFAULT NULL COMMENT 'Fee Debit Or Credit',
  `fee_amount` decimal(20,6) NOT NULL DEFAULT '0.000000' COMMENT 'Fee Amount',
  `fee_currency` varchar(3) DEFAULT NULL COMMENT 'Fee Currency',
  `custom_field` varchar(255) DEFAULT NULL COMMENT 'Custom Field',
  `consumer_id` varchar(127) DEFAULT NULL COMMENT 'Consumer Id',
  `payment_tracking_id` varchar(255) DEFAULT NULL COMMENT 'Payment Tracking ID',
  `store_id` varchar(50) DEFAULT NULL COMMENT 'Store ID',
  PRIMARY KEY (`row_id`),
  KEY `IDX_MAG_PAYPAL_SETTLEMENT_REPORT_ROW_REPORT_ID` (`report_id`),
  CONSTRAINT `FK_E49AD63BCD772B54750520C10BE8FA0E` FOREIGN KEY (`report_id`) REFERENCES `mag_paypal_settlement_report` (`report_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Paypal Settlement Report Row Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_paypal_settlement_report_row`
--

LOCK TABLES `mag_paypal_settlement_report_row` WRITE;
/*!40000 ALTER TABLE `mag_paypal_settlement_report_row` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_paypal_settlement_report_row` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_persistent_session`
--

DROP TABLE IF EXISTS `mag_persistent_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_persistent_session` (
  `persistent_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Session id',
  `key` varchar(50) NOT NULL COMMENT 'Unique cookie key',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website ID',
  `info` text COMMENT 'Session Data',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  PRIMARY KEY (`persistent_id`),
  UNIQUE KEY `IDX_MAG_PERSISTENT_SESSION_KEY` (`key`),
  UNIQUE KEY `IDX_MAG_PERSISTENT_SESSION_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_MAG_PERSISTENT_SESSION_UPDATED_AT` (`updated_at`),
  KEY `FK_MAG_PERSISTENT_SESSION_WEBSITE_ID_MAG_CORE_WEBSITE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_MAG_PERSISTENT_SESSION_WEBSITE_ID_MAG_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `mag_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_MAG_PERSISTENT_SESS_CSTR_ID_MAG_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `mag_customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Persistent Session';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_persistent_session`
--

LOCK TABLES `mag_persistent_session` WRITE;
/*!40000 ALTER TABLE `mag_persistent_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_persistent_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_poll`
--

DROP TABLE IF EXISTS `mag_poll`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_poll` (
  `poll_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Poll Id',
  `poll_title` varchar(255) DEFAULT NULL COMMENT 'Poll title',
  `votes_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Votes Count',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store id',
  `date_posted` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Date posted',
  `date_closed` timestamp NULL DEFAULT NULL COMMENT 'Date closed',
  `active` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Is active',
  `closed` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is closed',
  `answers_display` smallint(6) DEFAULT NULL COMMENT 'Answers display',
  PRIMARY KEY (`poll_id`),
  KEY `IDX_MAG_POLL_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MAG_POLL_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Poll';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_poll`
--

LOCK TABLES `mag_poll` WRITE;
/*!40000 ALTER TABLE `mag_poll` DISABLE KEYS */;
INSERT INTO `mag_poll` VALUES (1,'What is your favorite color',7,0,'2015-02-19 08:09:24',NULL,1,0,NULL);
/*!40000 ALTER TABLE `mag_poll` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_poll_answer`
--

DROP TABLE IF EXISTS `mag_poll_answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_poll_answer` (
  `answer_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Answer Id',
  `poll_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Poll Id',
  `answer_title` varchar(255) DEFAULT NULL COMMENT 'Answer title',
  `votes_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Votes Count',
  `answer_order` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Answers display',
  PRIMARY KEY (`answer_id`),
  KEY `IDX_MAG_POLL_ANSWER_POLL_ID` (`poll_id`),
  CONSTRAINT `FK_MAG_POLL_ANSWER_POLL_ID_MAG_POLL_POLL_ID` FOREIGN KEY (`poll_id`) REFERENCES `mag_poll` (`poll_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Poll Answers';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_poll_answer`
--

LOCK TABLES `mag_poll_answer` WRITE;
/*!40000 ALTER TABLE `mag_poll_answer` DISABLE KEYS */;
INSERT INTO `mag_poll_answer` VALUES (1,1,'Green',4,0),(2,1,'Red',1,0),(3,1,'Black',0,0),(4,1,'Magenta',2,0);
/*!40000 ALTER TABLE `mag_poll_answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_poll_store`
--

DROP TABLE IF EXISTS `mag_poll_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_poll_store` (
  `poll_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Poll Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store id',
  PRIMARY KEY (`poll_id`,`store_id`),
  KEY `IDX_MAG_POLL_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MAG_POLL_STORE_POLL_ID_MAG_POLL_POLL_ID` FOREIGN KEY (`poll_id`) REFERENCES `mag_poll` (`poll_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_POLL_STORE_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Poll Store';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_poll_store`
--

LOCK TABLES `mag_poll_store` WRITE;
/*!40000 ALTER TABLE `mag_poll_store` DISABLE KEYS */;
INSERT INTO `mag_poll_store` VALUES (1,1);
/*!40000 ALTER TABLE `mag_poll_store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_poll_vote`
--

DROP TABLE IF EXISTS `mag_poll_vote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_poll_vote` (
  `vote_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Vote Id',
  `poll_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Poll Id',
  `poll_answer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Poll answer id',
  `ip_address` bigint(20) DEFAULT NULL COMMENT 'Poll answer id',
  `customer_id` int(11) DEFAULT NULL COMMENT 'Customer id',
  `vote_time` timestamp NULL DEFAULT NULL COMMENT 'Date closed',
  PRIMARY KEY (`vote_id`),
  KEY `IDX_MAG_POLL_VOTE_POLL_ANSWER_ID` (`poll_answer_id`),
  CONSTRAINT `FK_MAG_POLL_VOTE_POLL_ANSWER_ID_MAG_POLL_ANSWER_ANSWER_ID` FOREIGN KEY (`poll_answer_id`) REFERENCES `mag_poll_answer` (`answer_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Poll Vote';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_poll_vote`
--

LOCK TABLES `mag_poll_vote` WRITE;
/*!40000 ALTER TABLE `mag_poll_vote` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_poll_vote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_product_alert_price`
--

DROP TABLE IF EXISTS `mag_product_alert_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_product_alert_price` (
  `alert_price_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Product alert price id',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer id',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product id',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price amount',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website id',
  `add_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Product alert add date',
  `last_send_date` timestamp NULL DEFAULT NULL COMMENT 'Product alert last send date',
  `send_count` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Product alert send count',
  `status` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Product alert status',
  PRIMARY KEY (`alert_price_id`),
  KEY `IDX_MAG_PRODUCT_ALERT_PRICE_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_MAG_PRODUCT_ALERT_PRICE_PRODUCT_ID` (`product_id`),
  KEY `IDX_MAG_PRODUCT_ALERT_PRICE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_MAG_PRD_ALERT_PRICE_CSTR_ID_MAG_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `mag_customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_PRD_ALERT_PRICE_PRD_ID_MAG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_PRD_ALERT_PRICE_WS_ID_MAG_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `mag_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Product Alert Price';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_product_alert_price`
--

LOCK TABLES `mag_product_alert_price` WRITE;
/*!40000 ALTER TABLE `mag_product_alert_price` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_product_alert_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_product_alert_stock`
--

DROP TABLE IF EXISTS `mag_product_alert_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_product_alert_stock` (
  `alert_stock_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Product alert stock id',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer id',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website id',
  `add_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Product alert add date',
  `send_date` timestamp NULL DEFAULT NULL COMMENT 'Product alert send date',
  `send_count` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Send Count',
  `status` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Product alert status',
  PRIMARY KEY (`alert_stock_id`),
  KEY `IDX_MAG_PRODUCT_ALERT_STOCK_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_MAG_PRODUCT_ALERT_STOCK_PRODUCT_ID` (`product_id`),
  KEY `IDX_MAG_PRODUCT_ALERT_STOCK_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_MAG_PRD_ALERT_STOCK_CSTR_ID_MAG_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `mag_customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_PRD_ALERT_STOCK_PRD_ID_MAG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_PRD_ALERT_STOCK_WS_ID_MAG_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `mag_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Product Alert Stock';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_product_alert_stock`
--

LOCK TABLES `mag_product_alert_stock` WRITE;
/*!40000 ALTER TABLE `mag_product_alert_stock` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_product_alert_stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_rating`
--

DROP TABLE IF EXISTS `mag_rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_rating` (
  `rating_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rating Id',
  `entity_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `rating_code` varchar(64) NOT NULL COMMENT 'Rating Code',
  `position` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Position On Frontend',
  PRIMARY KEY (`rating_id`),
  UNIQUE KEY `UNQ_MAG_RATING_RATING_CODE` (`rating_code`),
  KEY `IDX_MAG_RATING_ENTITY_ID` (`entity_id`),
  CONSTRAINT `FK_MAG_RATING_ENTITY_ID_MAG_RATING_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `mag_rating_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Ratings';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_rating`
--

LOCK TABLES `mag_rating` WRITE;
/*!40000 ALTER TABLE `mag_rating` DISABLE KEYS */;
INSERT INTO `mag_rating` VALUES (1,1,'Quality',0),(2,1,'Value',0),(3,1,'Price',0);
/*!40000 ALTER TABLE `mag_rating` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_rating_entity`
--

DROP TABLE IF EXISTS `mag_rating_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_rating_entity` (
  `entity_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `entity_code` varchar(64) NOT NULL COMMENT 'Entity Code',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_MAG_RATING_ENTITY_ENTITY_CODE` (`entity_code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Rating entities';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_rating_entity`
--

LOCK TABLES `mag_rating_entity` WRITE;
/*!40000 ALTER TABLE `mag_rating_entity` DISABLE KEYS */;
INSERT INTO `mag_rating_entity` VALUES (1,'product'),(2,'product_review'),(3,'review');
/*!40000 ALTER TABLE `mag_rating_entity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_rating_option`
--

DROP TABLE IF EXISTS `mag_rating_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_rating_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rating Option Id',
  `rating_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Id',
  `code` varchar(32) NOT NULL COMMENT 'Rating Option Code',
  `value` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Option Value',
  `position` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Ration option position on frontend',
  PRIMARY KEY (`option_id`),
  KEY `IDX_MAG_RATING_OPTION_RATING_ID` (`rating_id`),
  CONSTRAINT `FK_MAG_RATING_OPTION_RATING_ID_MAG_RATING_RATING_ID` FOREIGN KEY (`rating_id`) REFERENCES `mag_rating` (`rating_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='Rating options';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_rating_option`
--

LOCK TABLES `mag_rating_option` WRITE;
/*!40000 ALTER TABLE `mag_rating_option` DISABLE KEYS */;
INSERT INTO `mag_rating_option` VALUES (1,1,'1',1,1),(2,1,'2',2,2),(3,1,'3',3,3),(4,1,'4',4,4),(5,1,'5',5,5),(6,2,'1',1,1),(7,2,'2',2,2),(8,2,'3',3,3),(9,2,'4',4,4),(10,2,'5',5,5),(11,3,'1',1,1),(12,3,'2',2,2),(13,3,'3',3,3),(14,3,'4',4,4),(15,3,'5',5,5);
/*!40000 ALTER TABLE `mag_rating_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_rating_option_vote`
--

DROP TABLE IF EXISTS `mag_rating_option_vote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_rating_option_vote` (
  `vote_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Vote id',
  `option_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Vote option id',
  `remote_ip` varchar(16) NOT NULL COMMENT 'Customer IP',
  `remote_ip_long` bigint(20) NOT NULL DEFAULT '0' COMMENT 'Customer IP converted to long integer format',
  `customer_id` int(10) unsigned DEFAULT '0' COMMENT 'Customer Id',
  `entity_pk_value` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Product id',
  `rating_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating id',
  `review_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Review id',
  `percent` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Percent amount',
  `value` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Vote option value',
  PRIMARY KEY (`vote_id`),
  KEY `IDX_MAG_RATING_OPTION_VOTE_OPTION_ID` (`option_id`),
  KEY `FK_MAG_RATING_OPTION_VOTE_REVIEW_ID_MAG_REVIEW_REVIEW_ID` (`review_id`),
  CONSTRAINT `FK_MAG_RATING_OPTION_VOTE_OPTION_ID_MAG_RATING_OPTION_OPTION_ID` FOREIGN KEY (`option_id`) REFERENCES `mag_rating_option` (`option_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_RATING_OPTION_VOTE_REVIEW_ID_MAG_REVIEW_REVIEW_ID` FOREIGN KEY (`review_id`) REFERENCES `mag_review` (`review_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Rating option values';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_rating_option_vote`
--

LOCK TABLES `mag_rating_option_vote` WRITE;
/*!40000 ALTER TABLE `mag_rating_option_vote` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_rating_option_vote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_rating_option_vote_aggregated`
--

DROP TABLE IF EXISTS `mag_rating_option_vote_aggregated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_rating_option_vote_aggregated` (
  `primary_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Vote aggregation id',
  `rating_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating id',
  `entity_pk_value` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Product id',
  `vote_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Vote dty',
  `vote_value_sum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'General vote sum',
  `percent` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Vote percent',
  `percent_approved` smallint(6) DEFAULT '0' COMMENT 'Vote percent approved by admin',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  PRIMARY KEY (`primary_id`),
  KEY `IDX_MAG_RATING_OPTION_VOTE_AGGREGATED_RATING_ID` (`rating_id`),
  KEY `IDX_MAG_RATING_OPTION_VOTE_AGGREGATED_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MAG_RATING_OPT_VOTE_AGGRED_RATING_ID_MAG_RATING_RATING_ID` FOREIGN KEY (`rating_id`) REFERENCES `mag_rating` (`rating_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_RATING_OPT_VOTE_AGGRED_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Rating vote aggregated';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_rating_option_vote_aggregated`
--

LOCK TABLES `mag_rating_option_vote_aggregated` WRITE;
/*!40000 ALTER TABLE `mag_rating_option_vote_aggregated` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_rating_option_vote_aggregated` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_rating_store`
--

DROP TABLE IF EXISTS `mag_rating_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_rating_store` (
  `rating_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store id',
  PRIMARY KEY (`rating_id`,`store_id`),
  KEY `IDX_MAG_RATING_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MAG_RATING_STORE_RATING_ID_MAG_RATING_RATING_ID` FOREIGN KEY (`rating_id`) REFERENCES `mag_rating` (`rating_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_MAG_RATING_STORE_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Rating Store';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_rating_store`
--

LOCK TABLES `mag_rating_store` WRITE;
/*!40000 ALTER TABLE `mag_rating_store` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_rating_store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_rating_title`
--

DROP TABLE IF EXISTS `mag_rating_title`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_rating_title` (
  `rating_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `value` varchar(255) NOT NULL COMMENT 'Rating Label',
  PRIMARY KEY (`rating_id`,`store_id`),
  KEY `IDX_MAG_RATING_TITLE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MAG_RATING_TITLE_RATING_ID_MAG_RATING_RATING_ID` FOREIGN KEY (`rating_id`) REFERENCES `mag_rating` (`rating_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_RATING_TITLE_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Rating Title';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_rating_title`
--

LOCK TABLES `mag_rating_title` WRITE;
/*!40000 ALTER TABLE `mag_rating_title` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_rating_title` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_report_compared_product_index`
--

DROP TABLE IF EXISTS `mag_report_compared_product_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_report_compared_product_index` (
  `index_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Index Id',
  `visitor_id` int(10) unsigned DEFAULT NULL COMMENT 'Visitor Id',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `added_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Added At',
  PRIMARY KEY (`index_id`),
  UNIQUE KEY `UNQ_MAG_REPORT_COMPARED_PRODUCT_INDEX_VISITOR_ID_PRODUCT_ID` (`visitor_id`,`product_id`),
  UNIQUE KEY `UNQ_MAG_REPORT_COMPARED_PRODUCT_INDEX_CUSTOMER_ID_PRODUCT_ID` (`customer_id`,`product_id`),
  KEY `IDX_MAG_REPORT_COMPARED_PRODUCT_INDEX_STORE_ID` (`store_id`),
  KEY `IDX_MAG_REPORT_COMPARED_PRODUCT_INDEX_ADDED_AT` (`added_at`),
  KEY `IDX_MAG_REPORT_COMPARED_PRODUCT_INDEX_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_MAG_REPORT_CMPD_PRD_IDX_CSTR_ID_MAG_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `mag_customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_REPORT_CMPD_PRD_IDX_PRD_ID_MAG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_REPORT_CMPD_PRD_IDX_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Reports Compared Product Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_report_compared_product_index`
--

LOCK TABLES `mag_report_compared_product_index` WRITE;
/*!40000 ALTER TABLE `mag_report_compared_product_index` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_report_compared_product_index` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_report_event`
--

DROP TABLE IF EXISTS `mag_report_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_report_event` (
  `event_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Event Id',
  `logged_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Logged At',
  `event_type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Event Type Id',
  `object_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Object Id',
  `subject_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Subject Id',
  `subtype` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Subtype',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  PRIMARY KEY (`event_id`),
  KEY `IDX_MAG_REPORT_EVENT_EVENT_TYPE_ID` (`event_type_id`),
  KEY `IDX_MAG_REPORT_EVENT_SUBJECT_ID` (`subject_id`),
  KEY `IDX_MAG_REPORT_EVENT_OBJECT_ID` (`object_id`),
  KEY `IDX_MAG_REPORT_EVENT_SUBTYPE` (`subtype`),
  KEY `IDX_MAG_REPORT_EVENT_STORE_ID` (`store_id`),
  CONSTRAINT `FK_CD7282AACFC0B2818023534837F1377C` FOREIGN KEY (`event_type_id`) REFERENCES `mag_report_event_types` (`event_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_REPORT_EVENT_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Reports Event Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_report_event`
--

LOCK TABLES `mag_report_event` WRITE;
/*!40000 ALTER TABLE `mag_report_event` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_report_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_report_event_types`
--

DROP TABLE IF EXISTS `mag_report_event_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_report_event_types` (
  `event_type_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Event Type Id',
  `event_name` varchar(64) NOT NULL COMMENT 'Event Name',
  `customer_login` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Login',
  PRIMARY KEY (`event_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='Reports Event Type Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_report_event_types`
--

LOCK TABLES `mag_report_event_types` WRITE;
/*!40000 ALTER TABLE `mag_report_event_types` DISABLE KEYS */;
INSERT INTO `mag_report_event_types` VALUES (1,'catalog_product_view',0),(2,'sendfriend_product',0),(3,'catalog_product_compare_add_product',0),(4,'checkout_cart_add_product',0),(5,'wishlist_add_product',0),(6,'wishlist_share',0);
/*!40000 ALTER TABLE `mag_report_event_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_report_viewed_product_aggregated_daily`
--

DROP TABLE IF EXISTS `mag_report_viewed_product_aggregated_daily`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_report_viewed_product_aggregated_daily` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `views_num` int(11) NOT NULL DEFAULT '0' COMMENT 'Number of Views',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_MAG_REPORT_VIEWED_PRD_AGGRED_DAILY_PERIOD_STORE_ID_PRD_ID` (`period`,`store_id`,`product_id`),
  KEY `IDX_MAG_REPORT_VIEWED_PRODUCT_AGGREGATED_DAILY_STORE_ID` (`store_id`),
  KEY `IDX_MAG_REPORT_VIEWED_PRODUCT_AGGREGATED_DAILY_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_198D9894903FA06A5FAFF81D63460DF1` FOREIGN KEY (`product_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_7E1BDE0730EB27C89F7456F049F6E164` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Most Viewed Products Aggregated Daily';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_report_viewed_product_aggregated_daily`
--

LOCK TABLES `mag_report_viewed_product_aggregated_daily` WRITE;
/*!40000 ALTER TABLE `mag_report_viewed_product_aggregated_daily` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_report_viewed_product_aggregated_daily` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_report_viewed_product_aggregated_monthly`
--

DROP TABLE IF EXISTS `mag_report_viewed_product_aggregated_monthly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_report_viewed_product_aggregated_monthly` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `views_num` int(11) NOT NULL DEFAULT '0' COMMENT 'Number of Views',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_MAG_REPORT_VIEWED_PRD_AGGRED_MONTHLY_PERIOD_STORE_ID_PRD_ID` (`period`,`store_id`,`product_id`),
  KEY `IDX_MAG_REPORT_VIEWED_PRODUCT_AGGREGATED_MONTHLY_STORE_ID` (`store_id`),
  KEY `IDX_MAG_REPORT_VIEWED_PRODUCT_AGGREGATED_MONTHLY_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_587A8215328EFE323BE4E10BF0E57687` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_90DC0D21A99B7605EC2E6705B6B29D9B` FOREIGN KEY (`product_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Most Viewed Products Aggregated Monthly';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_report_viewed_product_aggregated_monthly`
--

LOCK TABLES `mag_report_viewed_product_aggregated_monthly` WRITE;
/*!40000 ALTER TABLE `mag_report_viewed_product_aggregated_monthly` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_report_viewed_product_aggregated_monthly` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_report_viewed_product_aggregated_yearly`
--

DROP TABLE IF EXISTS `mag_report_viewed_product_aggregated_yearly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_report_viewed_product_aggregated_yearly` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `views_num` int(11) NOT NULL DEFAULT '0' COMMENT 'Number of Views',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_MAG_REPORT_VIEWED_PRD_AGGRED_YEARLY_PERIOD_STORE_ID_PRD_ID` (`period`,`store_id`,`product_id`),
  KEY `IDX_MAG_REPORT_VIEWED_PRODUCT_AGGREGATED_YEARLY_STORE_ID` (`store_id`),
  KEY `IDX_MAG_REPORT_VIEWED_PRODUCT_AGGREGATED_YEARLY_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_280B2C9FFF13E26C536F562B8E8C3704` FOREIGN KEY (`product_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_F6F94CA90F5C8C6B7FAFA01AC0C16FEF` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Most Viewed Products Aggregated Yearly';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_report_viewed_product_aggregated_yearly`
--

LOCK TABLES `mag_report_viewed_product_aggregated_yearly` WRITE;
/*!40000 ALTER TABLE `mag_report_viewed_product_aggregated_yearly` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_report_viewed_product_aggregated_yearly` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_report_viewed_product_index`
--

DROP TABLE IF EXISTS `mag_report_viewed_product_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_report_viewed_product_index` (
  `index_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Index Id',
  `visitor_id` int(10) unsigned DEFAULT NULL COMMENT 'Visitor Id',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `added_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Added At',
  PRIMARY KEY (`index_id`),
  UNIQUE KEY `UNQ_MAG_REPORT_VIEWED_PRODUCT_INDEX_VISITOR_ID_PRODUCT_ID` (`visitor_id`,`product_id`),
  UNIQUE KEY `UNQ_MAG_REPORT_VIEWED_PRODUCT_INDEX_CUSTOMER_ID_PRODUCT_ID` (`customer_id`,`product_id`),
  KEY `IDX_MAG_REPORT_VIEWED_PRODUCT_INDEX_STORE_ID` (`store_id`),
  KEY `IDX_MAG_REPORT_VIEWED_PRODUCT_INDEX_ADDED_AT` (`added_at`),
  KEY `IDX_MAG_REPORT_VIEWED_PRODUCT_INDEX_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_MAG_REPORT_VIEWED_PRD_IDX_CSTR_ID_MAG_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `mag_customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_REPORT_VIEWED_PRD_IDX_PRD_ID_MAG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_REPORT_VIEWED_PRD_IDX_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Reports Viewed Product Index Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_report_viewed_product_index`
--

LOCK TABLES `mag_report_viewed_product_index` WRITE;
/*!40000 ALTER TABLE `mag_report_viewed_product_index` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_report_viewed_product_index` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_review`
--

DROP TABLE IF EXISTS `mag_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_review` (
  `review_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Review id',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Review create date',
  `entity_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity id',
  `entity_pk_value` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product id',
  `status_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Status code',
  PRIMARY KEY (`review_id`),
  KEY `IDX_MAG_REVIEW_ENTITY_ID` (`entity_id`),
  KEY `IDX_MAG_REVIEW_STATUS_ID` (`status_id`),
  KEY `IDX_MAG_REVIEW_ENTITY_PK_VALUE` (`entity_pk_value`),
  CONSTRAINT `FK_MAG_REVIEW_ENTITY_ID_MAG_REVIEW_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `mag_review_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_REVIEW_STATUS_ID_MAG_REVIEW_STATUS_STATUS_ID` FOREIGN KEY (`status_id`) REFERENCES `mag_review_status` (`status_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Review base information';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_review`
--

LOCK TABLES `mag_review` WRITE;
/*!40000 ALTER TABLE `mag_review` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_review_detail`
--

DROP TABLE IF EXISTS `mag_review_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_review_detail` (
  `detail_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Review detail id',
  `review_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Review id',
  `store_id` smallint(5) unsigned DEFAULT '0' COMMENT 'Store id',
  `title` varchar(255) NOT NULL COMMENT 'Title',
  `detail` text NOT NULL COMMENT 'Detail description',
  `nickname` varchar(128) NOT NULL COMMENT 'User nickname',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  PRIMARY KEY (`detail_id`),
  KEY `IDX_MAG_REVIEW_DETAIL_REVIEW_ID` (`review_id`),
  KEY `IDX_MAG_REVIEW_DETAIL_STORE_ID` (`store_id`),
  KEY `IDX_MAG_REVIEW_DETAIL_CUSTOMER_ID` (`customer_id`),
  CONSTRAINT `FK_MAG_REVIEW_DETAIL_CUSTOMER_ID_MAG_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `mag_customer_entity` (`entity_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_REVIEW_DETAIL_REVIEW_ID_MAG_REVIEW_REVIEW_ID` FOREIGN KEY (`review_id`) REFERENCES `mag_review` (`review_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_REVIEW_DETAIL_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Review detail information';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_review_detail`
--

LOCK TABLES `mag_review_detail` WRITE;
/*!40000 ALTER TABLE `mag_review_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_review_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_review_entity`
--

DROP TABLE IF EXISTS `mag_review_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_review_entity` (
  `entity_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Review entity id',
  `entity_code` varchar(32) NOT NULL COMMENT 'Review entity code',
  PRIMARY KEY (`entity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Review entities';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_review_entity`
--

LOCK TABLES `mag_review_entity` WRITE;
/*!40000 ALTER TABLE `mag_review_entity` DISABLE KEYS */;
INSERT INTO `mag_review_entity` VALUES (1,'product'),(2,'customer'),(3,'category');
/*!40000 ALTER TABLE `mag_review_entity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_review_entity_summary`
--

DROP TABLE IF EXISTS `mag_review_entity_summary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_review_entity_summary` (
  `primary_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Summary review entity id',
  `entity_pk_value` bigint(20) NOT NULL DEFAULT '0' COMMENT 'Product id',
  `entity_type` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Entity type id',
  `reviews_count` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Qty of reviews',
  `rating_summary` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Summarized rating',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store id',
  PRIMARY KEY (`primary_id`),
  KEY `IDX_MAG_REVIEW_ENTITY_SUMMARY_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MAG_REVIEW_ENTITY_SUMMARY_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Review aggregates';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_review_entity_summary`
--

LOCK TABLES `mag_review_entity_summary` WRITE;
/*!40000 ALTER TABLE `mag_review_entity_summary` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_review_entity_summary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_review_status`
--

DROP TABLE IF EXISTS `mag_review_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_review_status` (
  `status_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Status id',
  `status_code` varchar(32) NOT NULL COMMENT 'Status code',
  PRIMARY KEY (`status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Review statuses';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_review_status`
--

LOCK TABLES `mag_review_status` WRITE;
/*!40000 ALTER TABLE `mag_review_status` DISABLE KEYS */;
INSERT INTO `mag_review_status` VALUES (1,'Approved'),(2,'Pending'),(3,'Not Approved');
/*!40000 ALTER TABLE `mag_review_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_review_store`
--

DROP TABLE IF EXISTS `mag_review_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_review_store` (
  `review_id` bigint(20) unsigned NOT NULL COMMENT 'Review Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  PRIMARY KEY (`review_id`,`store_id`),
  KEY `IDX_MAG_REVIEW_STORE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MAG_REVIEW_STORE_REVIEW_ID_MAG_REVIEW_REVIEW_ID` FOREIGN KEY (`review_id`) REFERENCES `mag_review` (`review_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_REVIEW_STORE_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Review Store';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_review_store`
--

LOCK TABLES `mag_review_store` WRITE;
/*!40000 ALTER TABLE `mag_review_store` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_review_store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sales_bestsellers_aggregated_daily`
--

DROP TABLE IF EXISTS `mag_sales_bestsellers_aggregated_daily`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sales_bestsellers_aggregated_daily` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `qty_ordered` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty Ordered',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_MAG_SALES_BESTSELLERS_AGGRED_DAILY_PERIOD_STORE_ID_PRD_ID` (`period`,`store_id`,`product_id`),
  KEY `IDX_MAG_SALES_BESTSELLERS_AGGREGATED_DAILY_STORE_ID` (`store_id`),
  KEY `IDX_MAG_SALES_BESTSELLERS_AGGREGATED_DAILY_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_BC0BEE8C1794D5D078C4E70626AE4A65` FOREIGN KEY (`product_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_BD757E14E546158F9258C78DCDBA2418` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Bestsellers Aggregated Daily';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sales_bestsellers_aggregated_daily`
--

LOCK TABLES `mag_sales_bestsellers_aggregated_daily` WRITE;
/*!40000 ALTER TABLE `mag_sales_bestsellers_aggregated_daily` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_sales_bestsellers_aggregated_daily` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sales_bestsellers_aggregated_monthly`
--

DROP TABLE IF EXISTS `mag_sales_bestsellers_aggregated_monthly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sales_bestsellers_aggregated_monthly` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `qty_ordered` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty Ordered',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_MAG_SALES_BESTSELLERS_AGGRED_MONTHLY_PERIOD_STORE_ID_PRD_ID` (`period`,`store_id`,`product_id`),
  KEY `IDX_MAG_SALES_BESTSELLERS_AGGREGATED_MONTHLY_STORE_ID` (`store_id`),
  KEY `IDX_MAG_SALES_BESTSELLERS_AGGREGATED_MONTHLY_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_A84B01AB1D0E1D67E0B6EC4A39B623E2` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_E1B11260C0BDCDFCEDF540E7ECB36721` FOREIGN KEY (`product_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Bestsellers Aggregated Monthly';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sales_bestsellers_aggregated_monthly`
--

LOCK TABLES `mag_sales_bestsellers_aggregated_monthly` WRITE;
/*!40000 ALTER TABLE `mag_sales_bestsellers_aggregated_monthly` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_sales_bestsellers_aggregated_monthly` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sales_bestsellers_aggregated_yearly`
--

DROP TABLE IF EXISTS `mag_sales_bestsellers_aggregated_yearly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sales_bestsellers_aggregated_yearly` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_name` varchar(255) DEFAULT NULL COMMENT 'Product Name',
  `product_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Product Price',
  `qty_ordered` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty Ordered',
  `rating_pos` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Rating Pos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_MAG_SALES_BESTSELLERS_AGGRED_YEARLY_PERIOD_STORE_ID_PRD_ID` (`period`,`store_id`,`product_id`),
  KEY `IDX_MAG_SALES_BESTSELLERS_AGGREGATED_YEARLY_STORE_ID` (`store_id`),
  KEY `IDX_MAG_SALES_BESTSELLERS_AGGREGATED_YEARLY_PRODUCT_ID` (`product_id`),
  CONSTRAINT `FK_A6FED2D4C53C604DAEAF35EF2CAC27F8` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_B74DCF45F322D5DBF5ABF939CE4BCE8B` FOREIGN KEY (`product_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Bestsellers Aggregated Yearly';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sales_bestsellers_aggregated_yearly`
--

LOCK TABLES `mag_sales_bestsellers_aggregated_yearly` WRITE;
/*!40000 ALTER TABLE `mag_sales_bestsellers_aggregated_yearly` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_sales_bestsellers_aggregated_yearly` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sales_billing_agreement`
--

DROP TABLE IF EXISTS `mag_sales_billing_agreement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sales_billing_agreement` (
  `agreement_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Agreement Id',
  `customer_id` int(10) unsigned NOT NULL COMMENT 'Customer Id',
  `method_code` varchar(32) NOT NULL COMMENT 'Method Code',
  `reference_id` varchar(32) NOT NULL COMMENT 'Reference Id',
  `status` varchar(20) NOT NULL COMMENT 'Status',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `agreement_label` varchar(255) DEFAULT NULL COMMENT 'Agreement Label',
  PRIMARY KEY (`agreement_id`),
  KEY `IDX_MAG_SALES_BILLING_AGREEMENT_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_MAG_SALES_BILLING_AGREEMENT_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MAG_SALES_BILLING_AGREEMENT_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_SALES_BILLING_AGRT_CSTR_ID_MAG_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `mag_customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Billing Agreement';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sales_billing_agreement`
--

LOCK TABLES `mag_sales_billing_agreement` WRITE;
/*!40000 ALTER TABLE `mag_sales_billing_agreement` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_sales_billing_agreement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sales_billing_agreement_order`
--

DROP TABLE IF EXISTS `mag_sales_billing_agreement_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sales_billing_agreement_order` (
  `agreement_id` int(10) unsigned NOT NULL COMMENT 'Agreement Id',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  PRIMARY KEY (`agreement_id`,`order_id`),
  KEY `IDX_MAG_SALES_BILLING_AGREEMENT_ORDER_ORDER_ID` (`order_id`),
  CONSTRAINT `FK_1157A4214640EEFF0A548A83FC490676` FOREIGN KEY (`agreement_id`) REFERENCES `mag_sales_billing_agreement` (`agreement_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_86962F5903C81E133BAE3D172B83FEEA` FOREIGN KEY (`order_id`) REFERENCES `mag_sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Billing Agreement Order';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sales_billing_agreement_order`
--

LOCK TABLES `mag_sales_billing_agreement_order` WRITE;
/*!40000 ALTER TABLE `mag_sales_billing_agreement_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_sales_billing_agreement_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sales_flat_creditmemo`
--

DROP TABLE IF EXISTS `mag_sales_flat_creditmemo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sales_flat_creditmemo` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `adjustment_positive` decimal(12,4) DEFAULT NULL COMMENT 'Adjustment Positive',
  `base_shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Tax Amount',
  `store_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Order Rate',
  `base_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Amount',
  `base_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Order Rate',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `base_adjustment_negative` decimal(12,4) DEFAULT NULL COMMENT 'Base Adjustment Negative',
  `base_subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Incl Tax',
  `shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Amount',
  `subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Incl Tax',
  `adjustment_negative` decimal(12,4) DEFAULT NULL COMMENT 'Adjustment Negative',
  `base_shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Amount',
  `store_to_base_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Base Rate',
  `base_to_global_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Global Rate',
  `base_adjustment` decimal(12,4) DEFAULT NULL COMMENT 'Base Adjustment',
  `base_subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal',
  `discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Amount',
  `subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal',
  `adjustment` decimal(12,4) DEFAULT NULL COMMENT 'Adjustment',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `base_adjustment_positive` decimal(12,4) DEFAULT NULL COMMENT 'Base Adjustment Positive',
  `base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Amount',
  `shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Tax Amount',
  `tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Amount',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `email_sent` smallint(5) unsigned DEFAULT NULL COMMENT 'Email Sent',
  `creditmemo_status` int(11) DEFAULT NULL COMMENT 'Creditmemo Status',
  `state` int(11) DEFAULT NULL COMMENT 'State',
  `shipping_address_id` int(11) DEFAULT NULL COMMENT 'Shipping Address Id',
  `billing_address_id` int(11) DEFAULT NULL COMMENT 'Billing Address Id',
  `invoice_id` int(11) DEFAULT NULL COMMENT 'Invoice Id',
  `store_currency_code` varchar(3) DEFAULT NULL COMMENT 'Store Currency Code',
  `order_currency_code` varchar(3) DEFAULT NULL COMMENT 'Order Currency Code',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `global_currency_code` varchar(3) DEFAULT NULL COMMENT 'Global Currency Code',
  `transaction_id` varchar(255) DEFAULT NULL COMMENT 'Transaction Id',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `shipping_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Hidden Tax Amount',
  `base_shipping_hidden_tax_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Hidden Tax Amount',
  `shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Incl Tax',
  `base_shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Incl Tax',
  `discount_description` varchar(255) DEFAULT NULL COMMENT 'Discount Description',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_MAG_SALES_FLAT_CREDITMEMO_INCREMENT_ID` (`increment_id`),
  KEY `IDX_MAG_SALES_FLAT_CREDITMEMO_STORE_ID` (`store_id`),
  KEY `IDX_MAG_SALES_FLAT_CREDITMEMO_ORDER_ID` (`order_id`),
  KEY `IDX_MAG_SALES_FLAT_CREDITMEMO_CREDITMEMO_STATUS` (`creditmemo_status`),
  KEY `IDX_MAG_SALES_FLAT_CREDITMEMO_STATE` (`state`),
  KEY `IDX_MAG_SALES_FLAT_CREDITMEMO_CREATED_AT` (`created_at`),
  CONSTRAINT `FK_13C197FD390B976EFB1550B0517D8FAA` FOREIGN KEY (`order_id`) REFERENCES `mag_sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_SALES_FLAT_CREDITMEMO_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Creditmemo';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sales_flat_creditmemo`
--

LOCK TABLES `mag_sales_flat_creditmemo` WRITE;
/*!40000 ALTER TABLE `mag_sales_flat_creditmemo` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_sales_flat_creditmemo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sales_flat_creditmemo_comment`
--

DROP TABLE IF EXISTS `mag_sales_flat_creditmemo_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sales_flat_creditmemo_comment` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `is_customer_notified` int(11) DEFAULT NULL COMMENT 'Is Customer Notified',
  `is_visible_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible On Front',
  `comment` text COMMENT 'Comment',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_MAG_SALES_FLAT_CREDITMEMO_COMMENT_CREATED_AT` (`created_at`),
  KEY `IDX_MAG_SALES_FLAT_CREDITMEMO_COMMENT_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_A37524C607DF745EAC837D73009A3B74` FOREIGN KEY (`parent_id`) REFERENCES `mag_sales_flat_creditmemo` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Creditmemo Comment';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sales_flat_creditmemo_comment`
--

LOCK TABLES `mag_sales_flat_creditmemo_comment` WRITE;
/*!40000 ALTER TABLE `mag_sales_flat_creditmemo_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_sales_flat_creditmemo_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sales_flat_creditmemo_grid`
--

DROP TABLE IF EXISTS `mag_sales_flat_creditmemo_grid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sales_flat_creditmemo_grid` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `store_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Order Rate',
  `base_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Order Rate',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `store_to_base_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Base Rate',
  `base_to_global_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Global Rate',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `creditmemo_status` int(11) DEFAULT NULL COMMENT 'Creditmemo Status',
  `state` int(11) DEFAULT NULL COMMENT 'State',
  `invoice_id` int(11) DEFAULT NULL COMMENT 'Invoice Id',
  `store_currency_code` varchar(3) DEFAULT NULL COMMENT 'Store Currency Code',
  `order_currency_code` varchar(3) DEFAULT NULL COMMENT 'Order Currency Code',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `global_currency_code` varchar(3) DEFAULT NULL COMMENT 'Global Currency Code',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `order_increment_id` varchar(50) DEFAULT NULL COMMENT 'Order Increment Id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `order_created_at` timestamp NULL DEFAULT NULL COMMENT 'Order Created At',
  `billing_name` varchar(255) DEFAULT NULL COMMENT 'Billing Name',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_MAG_SALES_FLAT_CREDITMEMO_GRID_INCREMENT_ID` (`increment_id`),
  KEY `IDX_MAG_SALES_FLAT_CREDITMEMO_GRID_STORE_ID` (`store_id`),
  KEY `IDX_MAG_SALES_FLAT_CREDITMEMO_GRID_GRAND_TOTAL` (`grand_total`),
  KEY `IDX_MAG_SALES_FLAT_CREDITMEMO_GRID_BASE_GRAND_TOTAL` (`base_grand_total`),
  KEY `IDX_MAG_SALES_FLAT_CREDITMEMO_GRID_ORDER_ID` (`order_id`),
  KEY `IDX_MAG_SALES_FLAT_CREDITMEMO_GRID_CREDITMEMO_STATUS` (`creditmemo_status`),
  KEY `IDX_MAG_SALES_FLAT_CREDITMEMO_GRID_STATE` (`state`),
  KEY `IDX_MAG_SALES_FLAT_CREDITMEMO_GRID_ORDER_INCREMENT_ID` (`order_increment_id`),
  KEY `IDX_MAG_SALES_FLAT_CREDITMEMO_GRID_CREATED_AT` (`created_at`),
  KEY `IDX_MAG_SALES_FLAT_CREDITMEMO_GRID_ORDER_CREATED_AT` (`order_created_at`),
  KEY `IDX_MAG_SALES_FLAT_CREDITMEMO_GRID_BILLING_NAME` (`billing_name`),
  CONSTRAINT `FK_A9A4DF15FC0EEBAD59A8E683AB40CF84` FOREIGN KEY (`entity_id`) REFERENCES `mag_sales_flat_creditmemo` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_F5AD76672F647533EC846EEF6696BC6A` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Creditmemo Grid';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sales_flat_creditmemo_grid`
--

LOCK TABLES `mag_sales_flat_creditmemo_grid` WRITE;
/*!40000 ALTER TABLE `mag_sales_flat_creditmemo_grid` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_sales_flat_creditmemo_grid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sales_flat_creditmemo_item`
--

DROP TABLE IF EXISTS `mag_sales_flat_creditmemo_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sales_flat_creditmemo_item` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `base_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Price',
  `tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Amount',
  `base_row_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total',
  `discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Amount',
  `row_total` decimal(12,4) DEFAULT NULL COMMENT 'Row Total',
  `base_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Amount',
  `price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Price Incl Tax',
  `base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Amount',
  `base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Price Incl Tax',
  `qty` decimal(12,4) DEFAULT NULL COMMENT 'Qty',
  `base_cost` decimal(12,4) DEFAULT NULL COMMENT 'Base Cost',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `base_row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total Incl Tax',
  `row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Row Total Incl Tax',
  `product_id` int(11) DEFAULT NULL COMMENT 'Product Id',
  `order_item_id` int(11) DEFAULT NULL COMMENT 'Order Item Id',
  `additional_data` text COMMENT 'Additional Data',
  `description` text COMMENT 'Description',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Disposition',
  `weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Row Disposition',
  `base_weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Disposition',
  `base_weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Row Disposition',
  `weee_tax_applied` text COMMENT 'Weee Tax Applied',
  `base_weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Amount',
  `base_weee_tax_applied_row_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Row Amnt',
  `weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Amount',
  `weee_tax_applied_row_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Row Amount',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_MAG_SALES_FLAT_CREDITMEMO_ITEM_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_96446D55E48E0A97C42DE2DE92987E16` FOREIGN KEY (`parent_id`) REFERENCES `mag_sales_flat_creditmemo` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Creditmemo Item';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sales_flat_creditmemo_item`
--

LOCK TABLES `mag_sales_flat_creditmemo_item` WRITE;
/*!40000 ALTER TABLE `mag_sales_flat_creditmemo_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_sales_flat_creditmemo_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sales_flat_invoice`
--

DROP TABLE IF EXISTS `mag_sales_flat_invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sales_flat_invoice` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Tax Amount',
  `tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Amount',
  `base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Amount',
  `store_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Order Rate',
  `base_shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Tax Amount',
  `base_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Amount',
  `base_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Order Rate',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Amount',
  `subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Incl Tax',
  `base_subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Incl Tax',
  `store_to_base_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Base Rate',
  `base_shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Amount',
  `total_qty` decimal(12,4) DEFAULT NULL COMMENT 'Total Qty',
  `base_to_global_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Global Rate',
  `subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal',
  `base_subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal',
  `discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Amount',
  `billing_address_id` int(11) DEFAULT NULL COMMENT 'Billing Address Id',
  `is_used_for_refund` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Used For Refund',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `email_sent` smallint(5) unsigned DEFAULT NULL COMMENT 'Email Sent',
  `can_void_flag` smallint(5) unsigned DEFAULT NULL COMMENT 'Can Void Flag',
  `state` int(11) DEFAULT NULL COMMENT 'State',
  `shipping_address_id` int(11) DEFAULT NULL COMMENT 'Shipping Address Id',
  `store_currency_code` varchar(3) DEFAULT NULL COMMENT 'Store Currency Code',
  `transaction_id` varchar(255) DEFAULT NULL COMMENT 'Transaction Id',
  `order_currency_code` varchar(3) DEFAULT NULL COMMENT 'Order Currency Code',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `global_currency_code` varchar(3) DEFAULT NULL COMMENT 'Global Currency Code',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `shipping_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Hidden Tax Amount',
  `base_shipping_hidden_tax_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Hidden Tax Amount',
  `shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Incl Tax',
  `base_shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Incl Tax',
  `base_total_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Refunded',
  `discount_description` varchar(255) DEFAULT NULL COMMENT 'Discount Description',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_MAG_SALES_FLAT_INVOICE_INCREMENT_ID` (`increment_id`),
  KEY `IDX_MAG_SALES_FLAT_INVOICE_STORE_ID` (`store_id`),
  KEY `IDX_MAG_SALES_FLAT_INVOICE_GRAND_TOTAL` (`grand_total`),
  KEY `IDX_MAG_SALES_FLAT_INVOICE_ORDER_ID` (`order_id`),
  KEY `IDX_MAG_SALES_FLAT_INVOICE_STATE` (`state`),
  KEY `IDX_MAG_SALES_FLAT_INVOICE_CREATED_AT` (`created_at`),
  CONSTRAINT `FK_MAG_SALES_FLAT_INVOICE_ORDER_ID_MAG_SALES_FLAT_ORDER_ENTT_ID` FOREIGN KEY (`order_id`) REFERENCES `mag_sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_SALES_FLAT_INVOICE_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Invoice';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sales_flat_invoice`
--

LOCK TABLES `mag_sales_flat_invoice` WRITE;
/*!40000 ALTER TABLE `mag_sales_flat_invoice` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_sales_flat_invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sales_flat_invoice_comment`
--

DROP TABLE IF EXISTS `mag_sales_flat_invoice_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sales_flat_invoice_comment` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `is_customer_notified` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Customer Notified',
  `is_visible_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible On Front',
  `comment` text COMMENT 'Comment',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_MAG_SALES_FLAT_INVOICE_COMMENT_CREATED_AT` (`created_at`),
  KEY `IDX_MAG_SALES_FLAT_INVOICE_COMMENT_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_6E8F3A4A5F58A787739E4C752A41C5AA` FOREIGN KEY (`parent_id`) REFERENCES `mag_sales_flat_invoice` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Invoice Comment';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sales_flat_invoice_comment`
--

LOCK TABLES `mag_sales_flat_invoice_comment` WRITE;
/*!40000 ALTER TABLE `mag_sales_flat_invoice_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_sales_flat_invoice_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sales_flat_invoice_grid`
--

DROP TABLE IF EXISTS `mag_sales_flat_invoice_grid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sales_flat_invoice_grid` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `state` int(11) DEFAULT NULL COMMENT 'State',
  `store_currency_code` varchar(3) DEFAULT NULL COMMENT 'Store Currency Code',
  `order_currency_code` varchar(3) DEFAULT NULL COMMENT 'Order Currency Code',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `global_currency_code` varchar(3) DEFAULT NULL COMMENT 'Global Currency Code',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `order_increment_id` varchar(50) DEFAULT NULL COMMENT 'Order Increment Id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `order_created_at` timestamp NULL DEFAULT NULL COMMENT 'Order Created At',
  `billing_name` varchar(255) DEFAULT NULL COMMENT 'Billing Name',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_MAG_SALES_FLAT_INVOICE_GRID_INCREMENT_ID` (`increment_id`),
  KEY `IDX_MAG_SALES_FLAT_INVOICE_GRID_STORE_ID` (`store_id`),
  KEY `IDX_MAG_SALES_FLAT_INVOICE_GRID_GRAND_TOTAL` (`grand_total`),
  KEY `IDX_MAG_SALES_FLAT_INVOICE_GRID_ORDER_ID` (`order_id`),
  KEY `IDX_MAG_SALES_FLAT_INVOICE_GRID_STATE` (`state`),
  KEY `IDX_MAG_SALES_FLAT_INVOICE_GRID_ORDER_INCREMENT_ID` (`order_increment_id`),
  KEY `IDX_MAG_SALES_FLAT_INVOICE_GRID_CREATED_AT` (`created_at`),
  KEY `IDX_MAG_SALES_FLAT_INVOICE_GRID_ORDER_CREATED_AT` (`order_created_at`),
  KEY `IDX_MAG_SALES_FLAT_INVOICE_GRID_BILLING_NAME` (`billing_name`),
  CONSTRAINT `FK_E56743F2C2B90AD31421361A32D94E0A` FOREIGN KEY (`entity_id`) REFERENCES `mag_sales_flat_invoice` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_SALES_FLAT_INVOICE_GRID_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Invoice Grid';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sales_flat_invoice_grid`
--

LOCK TABLES `mag_sales_flat_invoice_grid` WRITE;
/*!40000 ALTER TABLE `mag_sales_flat_invoice_grid` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_sales_flat_invoice_grid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sales_flat_invoice_item`
--

DROP TABLE IF EXISTS `mag_sales_flat_invoice_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sales_flat_invoice_item` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `base_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Price',
  `tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Amount',
  `base_row_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total',
  `discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Amount',
  `row_total` decimal(12,4) DEFAULT NULL COMMENT 'Row Total',
  `base_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Amount',
  `price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Price Incl Tax',
  `base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Amount',
  `base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Price Incl Tax',
  `qty` decimal(12,4) DEFAULT NULL COMMENT 'Qty',
  `base_cost` decimal(12,4) DEFAULT NULL COMMENT 'Base Cost',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `base_row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total Incl Tax',
  `row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Row Total Incl Tax',
  `product_id` int(11) DEFAULT NULL COMMENT 'Product Id',
  `order_item_id` int(11) DEFAULT NULL COMMENT 'Order Item Id',
  `additional_data` text COMMENT 'Additional Data',
  `description` text COMMENT 'Description',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `base_weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Amount',
  `base_weee_tax_applied_row_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Row Amnt',
  `weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Amount',
  `weee_tax_applied_row_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Row Amount',
  `weee_tax_applied` text COMMENT 'Weee Tax Applied',
  `weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Disposition',
  `weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Row Disposition',
  `base_weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Disposition',
  `base_weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Row Disposition',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_MAG_SALES_FLAT_INVOICE_ITEM_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_5C110ACFADBD63E1902361691EB8F6AE` FOREIGN KEY (`parent_id`) REFERENCES `mag_sales_flat_invoice` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Invoice Item';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sales_flat_invoice_item`
--

LOCK TABLES `mag_sales_flat_invoice_item` WRITE;
/*!40000 ALTER TABLE `mag_sales_flat_invoice_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_sales_flat_invoice_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sales_flat_order`
--

DROP TABLE IF EXISTS `mag_sales_flat_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sales_flat_order` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `state` varchar(32) DEFAULT NULL COMMENT 'State',
  `status` varchar(32) DEFAULT NULL COMMENT 'Status',
  `coupon_code` varchar(255) DEFAULT NULL COMMENT 'Coupon Code',
  `protect_code` varchar(255) DEFAULT NULL COMMENT 'Protect Code',
  `shipping_description` varchar(255) DEFAULT NULL COMMENT 'Shipping Description',
  `is_virtual` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Virtual',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `base_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Amount',
  `base_discount_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Canceled',
  `base_discount_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Invoiced',
  `base_discount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Refunded',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `base_shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Amount',
  `base_shipping_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Canceled',
  `base_shipping_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Invoiced',
  `base_shipping_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Refunded',
  `base_shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Tax Amount',
  `base_shipping_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Tax Refunded',
  `base_subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal',
  `base_subtotal_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Canceled',
  `base_subtotal_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Invoiced',
  `base_subtotal_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Refunded',
  `base_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Amount',
  `base_tax_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Canceled',
  `base_tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Invoiced',
  `base_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Refunded',
  `base_to_global_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Global Rate',
  `base_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Order Rate',
  `base_total_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Canceled',
  `base_total_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Invoiced',
  `base_total_invoiced_cost` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Invoiced Cost',
  `base_total_offline_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Offline Refunded',
  `base_total_online_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Online Refunded',
  `base_total_paid` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Paid',
  `base_total_qty_ordered` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Qty Ordered',
  `base_total_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Refunded',
  `discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Discount Amount',
  `discount_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Discount Canceled',
  `discount_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Discount Invoiced',
  `discount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Discount Refunded',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Amount',
  `shipping_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Canceled',
  `shipping_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Invoiced',
  `shipping_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Refunded',
  `shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Tax Amount',
  `shipping_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Tax Refunded',
  `store_to_base_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Base Rate',
  `store_to_order_rate` decimal(12,4) DEFAULT NULL COMMENT 'Store To Order Rate',
  `subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal',
  `subtotal_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Canceled',
  `subtotal_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Invoiced',
  `subtotal_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Refunded',
  `tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Amount',
  `tax_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Tax Canceled',
  `tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Tax Invoiced',
  `tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Tax Refunded',
  `total_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Total Canceled',
  `total_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Total Invoiced',
  `total_offline_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Total Offline Refunded',
  `total_online_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Total Online Refunded',
  `total_paid` decimal(12,4) DEFAULT NULL COMMENT 'Total Paid',
  `total_qty_ordered` decimal(12,4) DEFAULT NULL COMMENT 'Total Qty Ordered',
  `total_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Total Refunded',
  `can_ship_partially` smallint(5) unsigned DEFAULT NULL COMMENT 'Can Ship Partially',
  `can_ship_partially_item` smallint(5) unsigned DEFAULT NULL COMMENT 'Can Ship Partially Item',
  `customer_is_guest` smallint(5) unsigned DEFAULT NULL COMMENT 'Customer Is Guest',
  `customer_note_notify` smallint(5) unsigned DEFAULT NULL COMMENT 'Customer Note Notify',
  `billing_address_id` int(11) DEFAULT NULL COMMENT 'Billing Address Id',
  `customer_group_id` smallint(6) DEFAULT NULL COMMENT 'Customer Group Id',
  `edit_increment` int(11) DEFAULT NULL COMMENT 'Edit Increment',
  `email_sent` smallint(5) unsigned DEFAULT NULL COMMENT 'Email Sent',
  `forced_shipment_with_invoice` smallint(5) unsigned DEFAULT NULL COMMENT 'Forced Do Shipment With Invoice',
  `payment_auth_expiration` int(11) DEFAULT NULL COMMENT 'Payment Authorization Expiration',
  `quote_address_id` int(11) DEFAULT NULL COMMENT 'Quote Address Id',
  `quote_id` int(11) DEFAULT NULL COMMENT 'Quote Id',
  `shipping_address_id` int(11) DEFAULT NULL COMMENT 'Shipping Address Id',
  `adjustment_negative` decimal(12,4) DEFAULT NULL COMMENT 'Adjustment Negative',
  `adjustment_positive` decimal(12,4) DEFAULT NULL COMMENT 'Adjustment Positive',
  `base_adjustment_negative` decimal(12,4) DEFAULT NULL COMMENT 'Base Adjustment Negative',
  `base_adjustment_positive` decimal(12,4) DEFAULT NULL COMMENT 'Base Adjustment Positive',
  `base_shipping_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Discount Amount',
  `base_subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Incl Tax',
  `base_total_due` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Due',
  `payment_authorization_amount` decimal(12,4) DEFAULT NULL COMMENT 'Payment Authorization Amount',
  `shipping_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Discount Amount',
  `subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Incl Tax',
  `total_due` decimal(12,4) DEFAULT NULL COMMENT 'Total Due',
  `weight` decimal(12,4) DEFAULT NULL COMMENT 'Weight',
  `customer_dob` datetime DEFAULT NULL COMMENT 'Customer Dob',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `applied_rule_ids` varchar(255) DEFAULT NULL COMMENT 'Applied Rule Ids',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `customer_email` varchar(255) DEFAULT NULL COMMENT 'Customer Email',
  `customer_firstname` varchar(255) DEFAULT NULL COMMENT 'Customer Firstname',
  `customer_lastname` varchar(255) DEFAULT NULL COMMENT 'Customer Lastname',
  `customer_middlename` varchar(255) DEFAULT NULL COMMENT 'Customer Middlename',
  `customer_prefix` varchar(255) DEFAULT NULL COMMENT 'Customer Prefix',
  `customer_suffix` varchar(255) DEFAULT NULL COMMENT 'Customer Suffix',
  `customer_taxvat` varchar(255) DEFAULT NULL COMMENT 'Customer Taxvat',
  `discount_description` varchar(255) DEFAULT NULL COMMENT 'Discount Description',
  `ext_customer_id` varchar(255) DEFAULT NULL COMMENT 'Ext Customer Id',
  `ext_order_id` varchar(255) DEFAULT NULL COMMENT 'Ext Order Id',
  `global_currency_code` varchar(3) DEFAULT NULL COMMENT 'Global Currency Code',
  `hold_before_state` varchar(255) DEFAULT NULL COMMENT 'Hold Before State',
  `hold_before_status` varchar(255) DEFAULT NULL COMMENT 'Hold Before Status',
  `order_currency_code` varchar(255) DEFAULT NULL COMMENT 'Order Currency Code',
  `original_increment_id` varchar(50) DEFAULT NULL COMMENT 'Original Increment Id',
  `relation_child_id` varchar(32) DEFAULT NULL COMMENT 'Relation Child Id',
  `relation_child_real_id` varchar(32) DEFAULT NULL COMMENT 'Relation Child Real Id',
  `relation_parent_id` varchar(32) DEFAULT NULL COMMENT 'Relation Parent Id',
  `relation_parent_real_id` varchar(32) DEFAULT NULL COMMENT 'Relation Parent Real Id',
  `remote_ip` varchar(255) DEFAULT NULL COMMENT 'Remote Ip',
  `shipping_method` varchar(255) DEFAULT NULL COMMENT 'Shipping Method',
  `store_currency_code` varchar(3) DEFAULT NULL COMMENT 'Store Currency Code',
  `store_name` varchar(255) DEFAULT NULL COMMENT 'Store Name',
  `x_forwarded_for` varchar(255) DEFAULT NULL COMMENT 'X Forwarded For',
  `customer_note` text COMMENT 'Customer Note',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `total_item_count` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Total Item Count',
  `customer_gender` int(11) DEFAULT NULL COMMENT 'Customer Gender',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `shipping_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Hidden Tax Amount',
  `base_shipping_hidden_tax_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Hidden Tax Amount',
  `hidden_tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Invoiced',
  `base_hidden_tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Invoiced',
  `hidden_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Refunded',
  `base_hidden_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Refunded',
  `shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Incl Tax',
  `base_shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Incl Tax',
  `coupon_rule_name` varchar(255) DEFAULT NULL COMMENT 'Coupon Sales Rule Name',
  `paypal_ipn_customer_notified` int(11) DEFAULT '0' COMMENT 'Paypal Ipn Customer Notified',
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_MAG_SALES_FLAT_ORDER_INCREMENT_ID` (`increment_id`),
  KEY `IDX_MAG_SALES_FLAT_ORDER_STATUS` (`status`),
  KEY `IDX_MAG_SALES_FLAT_ORDER_STATE` (`state`),
  KEY `IDX_MAG_SALES_FLAT_ORDER_STORE_ID` (`store_id`),
  KEY `IDX_MAG_SALES_FLAT_ORDER_CREATED_AT` (`created_at`),
  KEY `IDX_MAG_SALES_FLAT_ORDER_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_MAG_SALES_FLAT_ORDER_EXT_ORDER_ID` (`ext_order_id`),
  KEY `IDX_MAG_SALES_FLAT_ORDER_QUOTE_ID` (`quote_id`),
  KEY `IDX_MAG_SALES_FLAT_ORDER_UPDATED_AT` (`updated_at`),
  CONSTRAINT `FK_MAG_SALES_FLAT_ORDER_CSTR_ID_MAG_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `mag_customer_entity` (`entity_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_SALES_FLAT_ORDER_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sales_flat_order`
--

LOCK TABLES `mag_sales_flat_order` WRITE;
/*!40000 ALTER TABLE `mag_sales_flat_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_sales_flat_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sales_flat_order_address`
--

DROP TABLE IF EXISTS `mag_sales_flat_order_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sales_flat_order_address` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Id',
  `customer_address_id` int(11) DEFAULT NULL COMMENT 'Customer Address Id',
  `quote_address_id` int(11) DEFAULT NULL COMMENT 'Quote Address Id',
  `region_id` int(11) DEFAULT NULL COMMENT 'Region Id',
  `customer_id` int(11) DEFAULT NULL COMMENT 'Customer Id',
  `fax` varchar(255) DEFAULT NULL COMMENT 'Fax',
  `region` varchar(255) DEFAULT NULL COMMENT 'Region',
  `postcode` varchar(255) DEFAULT NULL COMMENT 'Postcode',
  `lastname` varchar(255) DEFAULT NULL COMMENT 'Lastname',
  `street` varchar(255) DEFAULT NULL COMMENT 'Street',
  `city` varchar(255) DEFAULT NULL COMMENT 'City',
  `email` varchar(255) DEFAULT NULL COMMENT 'Email',
  `telephone` varchar(255) DEFAULT NULL COMMENT 'Telephone',
  `country_id` varchar(2) DEFAULT NULL COMMENT 'Country Id',
  `firstname` varchar(255) DEFAULT NULL COMMENT 'Firstname',
  `address_type` varchar(255) DEFAULT NULL COMMENT 'Address Type',
  `prefix` varchar(255) DEFAULT NULL COMMENT 'Prefix',
  `middlename` varchar(255) DEFAULT NULL COMMENT 'Middlename',
  `suffix` varchar(255) DEFAULT NULL COMMENT 'Suffix',
  `company` varchar(255) DEFAULT NULL COMMENT 'Company',
  `vat_id` text COMMENT 'Vat Id',
  `vat_is_valid` smallint(6) DEFAULT NULL COMMENT 'Vat Is Valid',
  `vat_request_id` text COMMENT 'Vat Request Id',
  `vat_request_date` text COMMENT 'Vat Request Date',
  `vat_request_success` smallint(6) DEFAULT NULL COMMENT 'Vat Request Success',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_MAG_SALES_FLAT_ORDER_ADDRESS_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_E947C1A50CB58071F6D987BC86C3103B` FOREIGN KEY (`parent_id`) REFERENCES `mag_sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order Address';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sales_flat_order_address`
--

LOCK TABLES `mag_sales_flat_order_address` WRITE;
/*!40000 ALTER TABLE `mag_sales_flat_order_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_sales_flat_order_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sales_flat_order_grid`
--

DROP TABLE IF EXISTS `mag_sales_flat_order_grid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sales_flat_order_grid` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `status` varchar(32) DEFAULT NULL COMMENT 'Status',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `store_name` varchar(255) DEFAULT NULL COMMENT 'Store Name',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `base_grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Base Grand Total',
  `base_total_paid` decimal(12,4) DEFAULT NULL COMMENT 'Base Total Paid',
  `grand_total` decimal(12,4) DEFAULT NULL COMMENT 'Grand Total',
  `total_paid` decimal(12,4) DEFAULT NULL COMMENT 'Total Paid',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `base_currency_code` varchar(3) DEFAULT NULL COMMENT 'Base Currency Code',
  `order_currency_code` varchar(255) DEFAULT NULL COMMENT 'Order Currency Code',
  `shipping_name` varchar(255) DEFAULT NULL COMMENT 'Shipping Name',
  `billing_name` varchar(255) DEFAULT NULL COMMENT 'Billing Name',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_MAG_SALES_FLAT_ORDER_GRID_INCREMENT_ID` (`increment_id`),
  KEY `IDX_MAG_SALES_FLAT_ORDER_GRID_STATUS` (`status`),
  KEY `IDX_MAG_SALES_FLAT_ORDER_GRID_STORE_ID` (`store_id`),
  KEY `IDX_MAG_SALES_FLAT_ORDER_GRID_BASE_GRAND_TOTAL` (`base_grand_total`),
  KEY `IDX_MAG_SALES_FLAT_ORDER_GRID_BASE_TOTAL_PAID` (`base_total_paid`),
  KEY `IDX_MAG_SALES_FLAT_ORDER_GRID_GRAND_TOTAL` (`grand_total`),
  KEY `IDX_MAG_SALES_FLAT_ORDER_GRID_TOTAL_PAID` (`total_paid`),
  KEY `IDX_MAG_SALES_FLAT_ORDER_GRID_SHIPPING_NAME` (`shipping_name`),
  KEY `IDX_MAG_SALES_FLAT_ORDER_GRID_BILLING_NAME` (`billing_name`),
  KEY `IDX_MAG_SALES_FLAT_ORDER_GRID_CREATED_AT` (`created_at`),
  KEY `IDX_MAG_SALES_FLAT_ORDER_GRID_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_MAG_SALES_FLAT_ORDER_GRID_UPDATED_AT` (`updated_at`),
  CONSTRAINT `FK_0B71A4E2281BD917D490A101307179A5` FOREIGN KEY (`entity_id`) REFERENCES `mag_sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_SALES_FLAT_ORDER_GRID_CSTR_ID_MAG_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `mag_customer_entity` (`entity_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_SALES_FLAT_ORDER_GRID_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order Grid';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sales_flat_order_grid`
--

LOCK TABLES `mag_sales_flat_order_grid` WRITE;
/*!40000 ALTER TABLE `mag_sales_flat_order_grid` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_sales_flat_order_grid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sales_flat_order_item`
--

DROP TABLE IF EXISTS `mag_sales_flat_order_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sales_flat_order_item` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Item Id',
  `order_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Order Id',
  `parent_item_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Item Id',
  `quote_item_id` int(10) unsigned DEFAULT NULL COMMENT 'Quote Item Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `product_type` varchar(255) DEFAULT NULL COMMENT 'Product Type',
  `product_options` text COMMENT 'Product Options',
  `weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Weight',
  `is_virtual` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Virtual',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `description` text COMMENT 'Description',
  `applied_rule_ids` text COMMENT 'Applied Rule Ids',
  `additional_data` text COMMENT 'Additional Data',
  `free_shipping` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Free Shipping',
  `is_qty_decimal` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Qty Decimal',
  `no_discount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'No Discount',
  `qty_backordered` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Backordered',
  `qty_canceled` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Canceled',
  `qty_invoiced` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Invoiced',
  `qty_ordered` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Ordered',
  `qty_refunded` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Refunded',
  `qty_shipped` decimal(12,4) DEFAULT '0.0000' COMMENT 'Qty Shipped',
  `base_cost` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Cost',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `base_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Price',
  `original_price` decimal(12,4) DEFAULT NULL COMMENT 'Original Price',
  `base_original_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Original Price',
  `tax_percent` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Percent',
  `tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Amount',
  `base_tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Tax Amount',
  `tax_invoiced` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Invoiced',
  `base_tax_invoiced` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Tax Invoiced',
  `discount_percent` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Percent',
  `discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Amount',
  `base_discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Discount Amount',
  `discount_invoiced` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Invoiced',
  `base_discount_invoiced` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Discount Invoiced',
  `amount_refunded` decimal(12,4) DEFAULT '0.0000' COMMENT 'Amount Refunded',
  `base_amount_refunded` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Amount Refunded',
  `row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Row Total',
  `base_row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Row Total',
  `row_invoiced` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Row Invoiced',
  `base_row_invoiced` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Row Invoiced',
  `row_weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Row Weight',
  `base_tax_before_discount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Before Discount',
  `tax_before_discount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Before Discount',
  `ext_order_item_id` varchar(255) DEFAULT NULL COMMENT 'Ext Order Item Id',
  `locked_do_invoice` smallint(5) unsigned DEFAULT NULL COMMENT 'Locked Do Invoice',
  `locked_do_ship` smallint(5) unsigned DEFAULT NULL COMMENT 'Locked Do Ship',
  `price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Price Incl Tax',
  `base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Price Incl Tax',
  `row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Row Total Incl Tax',
  `base_row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total Incl Tax',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `hidden_tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Invoiced',
  `base_hidden_tax_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Invoiced',
  `hidden_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Refunded',
  `base_hidden_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Refunded',
  `is_nominal` int(11) NOT NULL DEFAULT '0' COMMENT 'Is Nominal',
  `tax_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Tax Canceled',
  `hidden_tax_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Canceled',
  `tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Tax Refunded',
  `base_tax_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Refunded',
  `discount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Discount Refunded',
  `base_discount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Discount Refunded',
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  `gift_message_available` int(11) DEFAULT NULL COMMENT 'Gift Message Available',
  `base_weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Amount',
  `base_weee_tax_applied_row_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Row Amnt',
  `weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Amount',
  `weee_tax_applied_row_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Row Amount',
  `weee_tax_applied` text COMMENT 'Weee Tax Applied',
  `weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Disposition',
  `weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Row Disposition',
  `base_weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Disposition',
  `base_weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Row Disposition',
  PRIMARY KEY (`item_id`),
  KEY `IDX_MAG_SALES_FLAT_ORDER_ITEM_ORDER_ID` (`order_id`),
  KEY `IDX_MAG_SALES_FLAT_ORDER_ITEM_STORE_ID` (`store_id`),
  CONSTRAINT `FK_105F96B67876BFA574EB7C06C9B98D47` FOREIGN KEY (`order_id`) REFERENCES `mag_sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_SALES_FLAT_ORDER_ITEM_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order Item';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sales_flat_order_item`
--

LOCK TABLES `mag_sales_flat_order_item` WRITE;
/*!40000 ALTER TABLE `mag_sales_flat_order_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_sales_flat_order_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sales_flat_order_payment`
--

DROP TABLE IF EXISTS `mag_sales_flat_order_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sales_flat_order_payment` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `base_shipping_captured` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Captured',
  `shipping_captured` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Captured',
  `amount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Amount Refunded',
  `base_amount_paid` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Paid',
  `amount_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Amount Canceled',
  `base_amount_authorized` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Authorized',
  `base_amount_paid_online` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Paid Online',
  `base_amount_refunded_online` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Refunded Online',
  `base_shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Amount',
  `shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Amount',
  `amount_paid` decimal(12,4) DEFAULT NULL COMMENT 'Amount Paid',
  `amount_authorized` decimal(12,4) DEFAULT NULL COMMENT 'Amount Authorized',
  `base_amount_ordered` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Ordered',
  `base_shipping_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Refunded',
  `shipping_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Refunded',
  `base_amount_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Refunded',
  `amount_ordered` decimal(12,4) DEFAULT NULL COMMENT 'Amount Ordered',
  `base_amount_canceled` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount Canceled',
  `quote_payment_id` int(11) DEFAULT NULL COMMENT 'Quote Payment Id',
  `additional_data` text COMMENT 'Additional Data',
  `cc_exp_month` varchar(255) DEFAULT NULL COMMENT 'Cc Exp Month',
  `cc_ss_start_year` varchar(255) DEFAULT NULL COMMENT 'Cc Ss Start Year',
  `echeck_bank_name` varchar(255) DEFAULT NULL COMMENT 'Echeck Bank Name',
  `method` varchar(255) DEFAULT NULL COMMENT 'Method',
  `cc_debug_request_body` varchar(255) DEFAULT NULL COMMENT 'Cc Debug Request Body',
  `cc_secure_verify` varchar(255) DEFAULT NULL COMMENT 'Cc Secure Verify',
  `protection_eligibility` varchar(255) DEFAULT NULL COMMENT 'Protection Eligibility',
  `cc_approval` varchar(255) DEFAULT NULL COMMENT 'Cc Approval',
  `cc_last4` varchar(255) DEFAULT NULL COMMENT 'Cc Last4',
  `cc_status_description` varchar(255) DEFAULT NULL COMMENT 'Cc Status Description',
  `echeck_type` varchar(255) DEFAULT NULL COMMENT 'Echeck Type',
  `cc_debug_response_serialized` varchar(255) DEFAULT NULL COMMENT 'Cc Debug Response Serialized',
  `cc_ss_start_month` varchar(255) DEFAULT NULL COMMENT 'Cc Ss Start Month',
  `echeck_account_type` varchar(255) DEFAULT NULL COMMENT 'Echeck Account Type',
  `last_trans_id` varchar(255) DEFAULT NULL COMMENT 'Last Trans Id',
  `cc_cid_status` varchar(255) DEFAULT NULL COMMENT 'Cc Cid Status',
  `cc_owner` varchar(255) DEFAULT NULL COMMENT 'Cc Owner',
  `cc_type` varchar(255) DEFAULT NULL COMMENT 'Cc Type',
  `po_number` varchar(255) DEFAULT NULL COMMENT 'Po Number',
  `cc_exp_year` varchar(255) DEFAULT NULL COMMENT 'Cc Exp Year',
  `cc_status` varchar(255) DEFAULT NULL COMMENT 'Cc Status',
  `echeck_routing_number` varchar(255) DEFAULT NULL COMMENT 'Echeck Routing Number',
  `account_status` varchar(255) DEFAULT NULL COMMENT 'Account Status',
  `anet_trans_method` varchar(255) DEFAULT NULL COMMENT 'Anet Trans Method',
  `cc_debug_response_body` varchar(255) DEFAULT NULL COMMENT 'Cc Debug Response Body',
  `cc_ss_issue` varchar(255) DEFAULT NULL COMMENT 'Cc Ss Issue',
  `echeck_account_name` varchar(255) DEFAULT NULL COMMENT 'Echeck Account Name',
  `cc_avs_status` varchar(255) DEFAULT NULL COMMENT 'Cc Avs Status',
  `cc_number_enc` varchar(255) DEFAULT NULL COMMENT 'Cc Number Enc',
  `cc_trans_id` varchar(255) DEFAULT NULL COMMENT 'Cc Trans Id',
  `paybox_request_number` varchar(255) DEFAULT NULL COMMENT 'Paybox Request Number',
  `address_status` varchar(255) DEFAULT NULL COMMENT 'Address Status',
  `additional_information` text COMMENT 'Additional Information',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_MAG_SALES_FLAT_ORDER_PAYMENT_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_F905A645841516C85570C0C022522C65` FOREIGN KEY (`parent_id`) REFERENCES `mag_sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order Payment';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sales_flat_order_payment`
--

LOCK TABLES `mag_sales_flat_order_payment` WRITE;
/*!40000 ALTER TABLE `mag_sales_flat_order_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_sales_flat_order_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sales_flat_order_status_history`
--

DROP TABLE IF EXISTS `mag_sales_flat_order_status_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sales_flat_order_status_history` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `is_customer_notified` int(11) DEFAULT NULL COMMENT 'Is Customer Notified',
  `is_visible_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible On Front',
  `comment` text COMMENT 'Comment',
  `status` varchar(32) DEFAULT NULL COMMENT 'Status',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `entity_name` varchar(32) DEFAULT NULL COMMENT 'Shows what entity history is bind to.',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_MAG_SALES_FLAT_ORDER_STATUS_HISTORY_PARENT_ID` (`parent_id`),
  KEY `IDX_MAG_SALES_FLAT_ORDER_STATUS_HISTORY_CREATED_AT` (`created_at`),
  CONSTRAINT `FK_9A5C8477A3D4B3B19179014A4DEB41EF` FOREIGN KEY (`parent_id`) REFERENCES `mag_sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Order Status History';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sales_flat_order_status_history`
--

LOCK TABLES `mag_sales_flat_order_status_history` WRITE;
/*!40000 ALTER TABLE `mag_sales_flat_order_status_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_sales_flat_order_status_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sales_flat_quote`
--

DROP TABLE IF EXISTS `mag_sales_flat_quote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sales_flat_quote` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `converted_at` timestamp NULL DEFAULT NULL COMMENT 'Converted At',
  `is_active` smallint(5) unsigned DEFAULT '1' COMMENT 'Is Active',
  `is_virtual` smallint(5) unsigned DEFAULT '0' COMMENT 'Is Virtual',
  `is_multi_shipping` smallint(5) unsigned DEFAULT '0' COMMENT 'Is Multi Shipping',
  `items_count` int(10) unsigned DEFAULT '0' COMMENT 'Items Count',
  `items_qty` decimal(12,4) DEFAULT '0.0000' COMMENT 'Items Qty',
  `orig_order_id` int(10) unsigned DEFAULT '0' COMMENT 'Orig Order Id',
  `store_to_base_rate` decimal(12,4) DEFAULT '0.0000' COMMENT 'Store To Base Rate',
  `store_to_quote_rate` decimal(12,4) DEFAULT '0.0000' COMMENT 'Store To Quote Rate',
  `base_currency_code` varchar(255) DEFAULT NULL COMMENT 'Base Currency Code',
  `store_currency_code` varchar(255) DEFAULT NULL COMMENT 'Store Currency Code',
  `quote_currency_code` varchar(255) DEFAULT NULL COMMENT 'Quote Currency Code',
  `grand_total` decimal(12,4) DEFAULT '0.0000' COMMENT 'Grand Total',
  `base_grand_total` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Grand Total',
  `checkout_method` varchar(255) DEFAULT NULL COMMENT 'Checkout Method',
  `customer_id` int(10) unsigned DEFAULT '0' COMMENT 'Customer Id',
  `customer_tax_class_id` int(10) unsigned DEFAULT '0' COMMENT 'Customer Tax Class Id',
  `customer_group_id` int(10) unsigned DEFAULT '0' COMMENT 'Customer Group Id',
  `customer_email` varchar(255) DEFAULT NULL COMMENT 'Customer Email',
  `customer_prefix` varchar(40) DEFAULT NULL COMMENT 'Customer Prefix',
  `customer_firstname` varchar(255) DEFAULT NULL COMMENT 'Customer Firstname',
  `customer_middlename` varchar(40) DEFAULT NULL COMMENT 'Customer Middlename',
  `customer_lastname` varchar(255) DEFAULT NULL COMMENT 'Customer Lastname',
  `customer_suffix` varchar(40) DEFAULT NULL COMMENT 'Customer Suffix',
  `customer_dob` datetime DEFAULT NULL COMMENT 'Customer Dob',
  `customer_note` varchar(255) DEFAULT NULL COMMENT 'Customer Note',
  `customer_note_notify` smallint(5) unsigned DEFAULT '1' COMMENT 'Customer Note Notify',
  `customer_is_guest` smallint(5) unsigned DEFAULT '0' COMMENT 'Customer Is Guest',
  `remote_ip` varchar(32) DEFAULT NULL COMMENT 'Remote Ip',
  `applied_rule_ids` varchar(255) DEFAULT NULL COMMENT 'Applied Rule Ids',
  `reserved_order_id` varchar(64) DEFAULT NULL COMMENT 'Reserved Order Id',
  `password_hash` varchar(255) DEFAULT NULL COMMENT 'Password Hash',
  `coupon_code` varchar(255) DEFAULT NULL COMMENT 'Coupon Code',
  `global_currency_code` varchar(255) DEFAULT NULL COMMENT 'Global Currency Code',
  `base_to_global_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Global Rate',
  `base_to_quote_rate` decimal(12,4) DEFAULT NULL COMMENT 'Base To Quote Rate',
  `customer_taxvat` varchar(255) DEFAULT NULL COMMENT 'Customer Taxvat',
  `customer_gender` varchar(255) DEFAULT NULL COMMENT 'Customer Gender',
  `subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal',
  `base_subtotal` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal',
  `subtotal_with_discount` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal With Discount',
  `base_subtotal_with_discount` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal With Discount',
  `is_changed` int(10) unsigned DEFAULT NULL COMMENT 'Is Changed',
  `trigger_recollect` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Trigger Recollect',
  `ext_shipping_info` text COMMENT 'Ext Shipping Info',
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  `is_persistent` smallint(5) unsigned DEFAULT '0' COMMENT 'Is Quote Persistent',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_MAG_SALES_FLAT_QUOTE_CUSTOMER_ID_STORE_ID_IS_ACTIVE` (`customer_id`,`store_id`,`is_active`),
  KEY `IDX_MAG_SALES_FLAT_QUOTE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MAG_SALES_FLAT_QUOTE_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sales_flat_quote`
--

LOCK TABLES `mag_sales_flat_quote` WRITE;
/*!40000 ALTER TABLE `mag_sales_flat_quote` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_sales_flat_quote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sales_flat_quote_address`
--

DROP TABLE IF EXISTS `mag_sales_flat_quote_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sales_flat_quote_address` (
  `address_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Address Id',
  `quote_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quote Id',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `save_in_address_book` smallint(6) DEFAULT '0' COMMENT 'Save In Address Book',
  `customer_address_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Address Id',
  `address_type` varchar(255) DEFAULT NULL COMMENT 'Address Type',
  `email` varchar(255) DEFAULT NULL COMMENT 'Email',
  `prefix` varchar(40) DEFAULT NULL COMMENT 'Prefix',
  `firstname` varchar(255) DEFAULT NULL COMMENT 'Firstname',
  `middlename` varchar(40) DEFAULT NULL COMMENT 'Middlename',
  `lastname` varchar(255) DEFAULT NULL COMMENT 'Lastname',
  `suffix` varchar(40) DEFAULT NULL COMMENT 'Suffix',
  `company` varchar(255) DEFAULT NULL COMMENT 'Company',
  `street` varchar(255) DEFAULT NULL COMMENT 'Street',
  `city` varchar(255) DEFAULT NULL COMMENT 'City',
  `region` varchar(255) DEFAULT NULL COMMENT 'Region',
  `region_id` int(10) unsigned DEFAULT NULL COMMENT 'Region Id',
  `postcode` varchar(255) DEFAULT NULL COMMENT 'Postcode',
  `country_id` varchar(255) DEFAULT NULL COMMENT 'Country Id',
  `telephone` varchar(255) DEFAULT NULL COMMENT 'Telephone',
  `fax` varchar(255) DEFAULT NULL COMMENT 'Fax',
  `same_as_billing` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Same As Billing',
  `free_shipping` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Free Shipping',
  `collect_shipping_rates` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Collect Shipping Rates',
  `shipping_method` varchar(255) DEFAULT NULL COMMENT 'Shipping Method',
  `shipping_description` varchar(255) DEFAULT NULL COMMENT 'Shipping Description',
  `weight` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Weight',
  `subtotal` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal',
  `base_subtotal` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Subtotal',
  `subtotal_with_discount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Subtotal With Discount',
  `base_subtotal_with_discount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Subtotal With Discount',
  `tax_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Tax Amount',
  `base_tax_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Tax Amount',
  `shipping_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Shipping Amount',
  `base_shipping_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Shipping Amount',
  `shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Tax Amount',
  `base_shipping_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Tax Amount',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount',
  `base_discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Discount Amount',
  `grand_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Grand Total',
  `base_grand_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Grand Total',
  `customer_notes` text COMMENT 'Customer Notes',
  `applied_taxes` text COMMENT 'Applied Taxes',
  `discount_description` varchar(255) DEFAULT NULL COMMENT 'Discount Description',
  `shipping_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Discount Amount',
  `base_shipping_discount_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Discount Amount',
  `subtotal_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Subtotal Incl Tax',
  `base_subtotal_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Subtotal Total Incl Tax',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `shipping_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Hidden Tax Amount',
  `base_shipping_hidden_tax_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Hidden Tax Amount',
  `shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Incl Tax',
  `base_shipping_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Shipping Incl Tax',
  `vat_id` text COMMENT 'Vat Id',
  `vat_is_valid` smallint(6) DEFAULT NULL COMMENT 'Vat Is Valid',
  `vat_request_id` text COMMENT 'Vat Request Id',
  `vat_request_date` text COMMENT 'Vat Request Date',
  `vat_request_success` smallint(6) DEFAULT NULL COMMENT 'Vat Request Success',
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  PRIMARY KEY (`address_id`),
  KEY `IDX_MAG_SALES_FLAT_QUOTE_ADDRESS_QUOTE_ID` (`quote_id`),
  CONSTRAINT `FK_CB9D76577B89679077ED1BE1CB1D1AF9` FOREIGN KEY (`quote_id`) REFERENCES `mag_sales_flat_quote` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Address';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sales_flat_quote_address`
--

LOCK TABLES `mag_sales_flat_quote_address` WRITE;
/*!40000 ALTER TABLE `mag_sales_flat_quote_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_sales_flat_quote_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sales_flat_quote_address_item`
--

DROP TABLE IF EXISTS `mag_sales_flat_quote_address_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sales_flat_quote_address_item` (
  `address_item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Address Item Id',
  `parent_item_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Item Id',
  `quote_address_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quote Address Id',
  `quote_item_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quote Item Id',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `applied_rule_ids` text COMMENT 'Applied Rule Ids',
  `additional_data` text COMMENT 'Additional Data',
  `weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Weight',
  `qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty',
  `discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Amount',
  `tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Amount',
  `row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Row Total',
  `base_row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Row Total',
  `row_total_with_discount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Row Total With Discount',
  `base_discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Discount Amount',
  `base_tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Tax Amount',
  `row_weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Row Weight',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `super_product_id` int(10) unsigned DEFAULT NULL COMMENT 'Super Product Id',
  `parent_product_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Product Id',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  `image` varchar(255) DEFAULT NULL COMMENT 'Image',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `description` text COMMENT 'Description',
  `free_shipping` int(10) unsigned DEFAULT NULL COMMENT 'Free Shipping',
  `is_qty_decimal` int(10) unsigned DEFAULT NULL COMMENT 'Is Qty Decimal',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `discount_percent` decimal(12,4) DEFAULT NULL COMMENT 'Discount Percent',
  `no_discount` int(10) unsigned DEFAULT NULL COMMENT 'No Discount',
  `tax_percent` decimal(12,4) DEFAULT NULL COMMENT 'Tax Percent',
  `base_price` decimal(12,4) DEFAULT NULL COMMENT 'Base Price',
  `base_cost` decimal(12,4) DEFAULT NULL COMMENT 'Base Cost',
  `price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Price Incl Tax',
  `base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Price Incl Tax',
  `row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Row Total Incl Tax',
  `base_row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total Incl Tax',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  PRIMARY KEY (`address_item_id`),
  KEY `IDX_MAG_SALES_FLAT_QUOTE_ADDRESS_ITEM_QUOTE_ADDRESS_ID` (`quote_address_id`),
  KEY `IDX_MAG_SALES_FLAT_QUOTE_ADDRESS_ITEM_PARENT_ITEM_ID` (`parent_item_id`),
  KEY `IDX_MAG_SALES_FLAT_QUOTE_ADDRESS_ITEM_QUOTE_ITEM_ID` (`quote_item_id`),
  CONSTRAINT `FK_2F867C10C8444FDFBA043B6341EEC111` FOREIGN KEY (`quote_item_id`) REFERENCES `mag_sales_flat_quote_item` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_524DA1D4D84BA7398593A932A342AD3B` FOREIGN KEY (`parent_item_id`) REFERENCES `mag_sales_flat_quote_address_item` (`address_item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_A2718638148D8427A6F5DB6B65B9AC23` FOREIGN KEY (`quote_address_id`) REFERENCES `mag_sales_flat_quote_address` (`address_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Address Item';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sales_flat_quote_address_item`
--

LOCK TABLES `mag_sales_flat_quote_address_item` WRITE;
/*!40000 ALTER TABLE `mag_sales_flat_quote_address_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_sales_flat_quote_address_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sales_flat_quote_item`
--

DROP TABLE IF EXISTS `mag_sales_flat_quote_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sales_flat_quote_item` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Item Id',
  `quote_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quote Id',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT 'Product Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `parent_item_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Item Id',
  `is_virtual` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Virtual',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `description` text COMMENT 'Description',
  `applied_rule_ids` text COMMENT 'Applied Rule Ids',
  `additional_data` text COMMENT 'Additional Data',
  `free_shipping` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Free Shipping',
  `is_qty_decimal` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Qty Decimal',
  `no_discount` smallint(5) unsigned DEFAULT '0' COMMENT 'No Discount',
  `weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Weight',
  `qty` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Qty',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `base_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Price',
  `custom_price` decimal(12,4) DEFAULT NULL COMMENT 'Custom Price',
  `discount_percent` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Percent',
  `discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Discount Amount',
  `base_discount_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Discount Amount',
  `tax_percent` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Percent',
  `tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Tax Amount',
  `base_tax_amount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Base Tax Amount',
  `row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Row Total',
  `base_row_total` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Base Row Total',
  `row_total_with_discount` decimal(12,4) DEFAULT '0.0000' COMMENT 'Row Total With Discount',
  `row_weight` decimal(12,4) DEFAULT '0.0000' COMMENT 'Row Weight',
  `product_type` varchar(255) DEFAULT NULL COMMENT 'Product Type',
  `base_tax_before_discount` decimal(12,4) DEFAULT NULL COMMENT 'Base Tax Before Discount',
  `tax_before_discount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Before Discount',
  `original_custom_price` decimal(12,4) DEFAULT NULL COMMENT 'Original Custom Price',
  `redirect_url` varchar(255) DEFAULT NULL COMMENT 'Redirect Url',
  `base_cost` decimal(12,4) DEFAULT NULL COMMENT 'Base Cost',
  `price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Price Incl Tax',
  `base_price_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Price Incl Tax',
  `row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Row Total Incl Tax',
  `base_row_total_incl_tax` decimal(12,4) DEFAULT NULL COMMENT 'Base Row Total Incl Tax',
  `hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Hidden Tax Amount',
  `base_hidden_tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Hidden Tax Amount',
  `gift_message_id` int(11) DEFAULT NULL COMMENT 'Gift Message Id',
  `weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Disposition',
  `weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Row Disposition',
  `base_weee_tax_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Disposition',
  `base_weee_tax_row_disposition` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Row Disposition',
  `weee_tax_applied` text COMMENT 'Weee Tax Applied',
  `weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Amount',
  `weee_tax_applied_row_amount` decimal(12,4) DEFAULT NULL COMMENT 'Weee Tax Applied Row Amount',
  `base_weee_tax_applied_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Amount',
  `base_weee_tax_applied_row_amnt` decimal(12,4) DEFAULT NULL COMMENT 'Base Weee Tax Applied Row Amnt',
  PRIMARY KEY (`item_id`),
  KEY `IDX_MAG_SALES_FLAT_QUOTE_ITEM_PARENT_ITEM_ID` (`parent_item_id`),
  KEY `IDX_MAG_SALES_FLAT_QUOTE_ITEM_PRODUCT_ID` (`product_id`),
  KEY `IDX_MAG_SALES_FLAT_QUOTE_ITEM_QUOTE_ID` (`quote_id`),
  KEY `IDX_MAG_SALES_FLAT_QUOTE_ITEM_STORE_ID` (`store_id`),
  CONSTRAINT `FK_27D14FA73E928FC0C5A90144285FA51E` FOREIGN KEY (`quote_id`) REFERENCES `mag_sales_flat_quote` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_7E1BD227E84E8D172A9530CD0B6331CB` FOREIGN KEY (`parent_item_id`) REFERENCES `mag_sales_flat_quote_item` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_SALES_FLAT_QUOTE_ITEM_PRD_ID_MAG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_SALES_FLAT_QUOTE_ITEM_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Item';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sales_flat_quote_item`
--

LOCK TABLES `mag_sales_flat_quote_item` WRITE;
/*!40000 ALTER TABLE `mag_sales_flat_quote_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_sales_flat_quote_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sales_flat_quote_item_option`
--

DROP TABLE IF EXISTS `mag_sales_flat_quote_item_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sales_flat_quote_item_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Id',
  `item_id` int(10) unsigned NOT NULL COMMENT 'Item Id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `value` text COMMENT 'Value',
  PRIMARY KEY (`option_id`),
  KEY `IDX_MAG_SALES_FLAT_QUOTE_ITEM_OPTION_ITEM_ID` (`item_id`),
  CONSTRAINT `FK_2F07C2273DBA01F346A698B91CF6228F` FOREIGN KEY (`item_id`) REFERENCES `mag_sales_flat_quote_item` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Item Option';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sales_flat_quote_item_option`
--

LOCK TABLES `mag_sales_flat_quote_item_option` WRITE;
/*!40000 ALTER TABLE `mag_sales_flat_quote_item_option` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_sales_flat_quote_item_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sales_flat_quote_payment`
--

DROP TABLE IF EXISTS `mag_sales_flat_quote_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sales_flat_quote_payment` (
  `payment_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Payment Id',
  `quote_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quote Id',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `method` varchar(255) DEFAULT NULL COMMENT 'Method',
  `cc_type` varchar(255) DEFAULT NULL COMMENT 'Cc Type',
  `cc_number_enc` varchar(255) DEFAULT NULL COMMENT 'Cc Number Enc',
  `cc_last4` varchar(255) DEFAULT NULL COMMENT 'Cc Last4',
  `cc_cid_enc` varchar(255) DEFAULT NULL COMMENT 'Cc Cid Enc',
  `cc_owner` varchar(255) DEFAULT NULL COMMENT 'Cc Owner',
  `cc_exp_month` smallint(5) unsigned DEFAULT '0' COMMENT 'Cc Exp Month',
  `cc_exp_year` smallint(5) unsigned DEFAULT '0' COMMENT 'Cc Exp Year',
  `cc_ss_owner` varchar(255) DEFAULT NULL COMMENT 'Cc Ss Owner',
  `cc_ss_start_month` smallint(5) unsigned DEFAULT '0' COMMENT 'Cc Ss Start Month',
  `cc_ss_start_year` smallint(5) unsigned DEFAULT '0' COMMENT 'Cc Ss Start Year',
  `po_number` varchar(255) DEFAULT NULL COMMENT 'Po Number',
  `additional_data` text COMMENT 'Additional Data',
  `cc_ss_issue` varchar(255) DEFAULT NULL COMMENT 'Cc Ss Issue',
  `additional_information` text COMMENT 'Additional Information',
  `paypal_payer_id` varchar(255) DEFAULT NULL COMMENT 'Paypal Payer Id',
  `paypal_payer_status` varchar(255) DEFAULT NULL COMMENT 'Paypal Payer Status',
  `paypal_correlation_id` varchar(255) DEFAULT NULL COMMENT 'Paypal Correlation Id',
  PRIMARY KEY (`payment_id`),
  KEY `IDX_MAG_SALES_FLAT_QUOTE_PAYMENT_QUOTE_ID` (`quote_id`),
  CONSTRAINT `FK_D7B573C1D31228072B827338D1525813` FOREIGN KEY (`quote_id`) REFERENCES `mag_sales_flat_quote` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Payment';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sales_flat_quote_payment`
--

LOCK TABLES `mag_sales_flat_quote_payment` WRITE;
/*!40000 ALTER TABLE `mag_sales_flat_quote_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_sales_flat_quote_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sales_flat_quote_shipping_rate`
--

DROP TABLE IF EXISTS `mag_sales_flat_quote_shipping_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sales_flat_quote_shipping_rate` (
  `rate_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rate Id',
  `address_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Address Id',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Created At',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Updated At',
  `carrier` varchar(255) DEFAULT NULL COMMENT 'Carrier',
  `carrier_title` varchar(255) DEFAULT NULL COMMENT 'Carrier Title',
  `code` varchar(255) DEFAULT NULL COMMENT 'Code',
  `method` varchar(255) DEFAULT NULL COMMENT 'Method',
  `method_description` text COMMENT 'Method Description',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `error_message` text COMMENT 'Error Message',
  `method_title` text COMMENT 'Method Title',
  PRIMARY KEY (`rate_id`),
  KEY `IDX_MAG_SALES_FLAT_QUOTE_SHIPPING_RATE_ADDRESS_ID` (`address_id`),
  CONSTRAINT `FK_7AD42C5402F6E086C3230865A7E6110D` FOREIGN KEY (`address_id`) REFERENCES `mag_sales_flat_quote_address` (`address_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Quote Shipping Rate';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sales_flat_quote_shipping_rate`
--

LOCK TABLES `mag_sales_flat_quote_shipping_rate` WRITE;
/*!40000 ALTER TABLE `mag_sales_flat_quote_shipping_rate` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_sales_flat_quote_shipping_rate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sales_flat_shipment`
--

DROP TABLE IF EXISTS `mag_sales_flat_shipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sales_flat_shipment` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `total_weight` decimal(12,4) DEFAULT NULL COMMENT 'Total Weight',
  `total_qty` decimal(12,4) DEFAULT NULL COMMENT 'Total Qty',
  `email_sent` smallint(5) unsigned DEFAULT NULL COMMENT 'Email Sent',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `customer_id` int(11) DEFAULT NULL COMMENT 'Customer Id',
  `shipping_address_id` int(11) DEFAULT NULL COMMENT 'Shipping Address Id',
  `billing_address_id` int(11) DEFAULT NULL COMMENT 'Billing Address Id',
  `shipment_status` int(11) DEFAULT NULL COMMENT 'Shipment Status',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `packages` text COMMENT 'Packed Products in Packages',
  `shipping_label` mediumblob COMMENT 'Shipping Label Content',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_MAG_SALES_FLAT_SHIPMENT_INCREMENT_ID` (`increment_id`),
  KEY `IDX_MAG_SALES_FLAT_SHIPMENT_STORE_ID` (`store_id`),
  KEY `IDX_MAG_SALES_FLAT_SHIPMENT_TOTAL_QTY` (`total_qty`),
  KEY `IDX_MAG_SALES_FLAT_SHIPMENT_ORDER_ID` (`order_id`),
  KEY `IDX_MAG_SALES_FLAT_SHIPMENT_CREATED_AT` (`created_at`),
  KEY `IDX_MAG_SALES_FLAT_SHIPMENT_UPDATED_AT` (`updated_at`),
  CONSTRAINT `FK_MAG_SALES_FLAT_SHIPMENT_ORDER_ID_MAG_SALES_FLAT_ORDER_ENTT_ID` FOREIGN KEY (`order_id`) REFERENCES `mag_sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_SALES_FLAT_SHIPMENT_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Shipment';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sales_flat_shipment`
--

LOCK TABLES `mag_sales_flat_shipment` WRITE;
/*!40000 ALTER TABLE `mag_sales_flat_shipment` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_sales_flat_shipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sales_flat_shipment_comment`
--

DROP TABLE IF EXISTS `mag_sales_flat_shipment_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sales_flat_shipment_comment` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `is_customer_notified` int(11) DEFAULT NULL COMMENT 'Is Customer Notified',
  `is_visible_on_front` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Visible On Front',
  `comment` text COMMENT 'Comment',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_MAG_SALES_FLAT_SHIPMENT_COMMENT_CREATED_AT` (`created_at`),
  KEY `IDX_MAG_SALES_FLAT_SHIPMENT_COMMENT_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_D4BF791BE2805E0BD66DE56620B0E8AF` FOREIGN KEY (`parent_id`) REFERENCES `mag_sales_flat_shipment` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Shipment Comment';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sales_flat_shipment_comment`
--

LOCK TABLES `mag_sales_flat_shipment_comment` WRITE;
/*!40000 ALTER TABLE `mag_sales_flat_shipment_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_sales_flat_shipment_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sales_flat_shipment_grid`
--

DROP TABLE IF EXISTS `mag_sales_flat_shipment_grid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sales_flat_shipment_grid` (
  `entity_id` int(10) unsigned NOT NULL COMMENT 'Entity Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `total_qty` decimal(12,4) DEFAULT NULL COMMENT 'Total Qty',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `shipment_status` int(11) DEFAULT NULL COMMENT 'Shipment Status',
  `increment_id` varchar(50) DEFAULT NULL COMMENT 'Increment Id',
  `order_increment_id` varchar(50) DEFAULT NULL COMMENT 'Order Increment Id',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `order_created_at` timestamp NULL DEFAULT NULL COMMENT 'Order Created At',
  `shipping_name` varchar(255) DEFAULT NULL COMMENT 'Shipping Name',
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `UNQ_MAG_SALES_FLAT_SHIPMENT_GRID_INCREMENT_ID` (`increment_id`),
  KEY `IDX_MAG_SALES_FLAT_SHIPMENT_GRID_STORE_ID` (`store_id`),
  KEY `IDX_MAG_SALES_FLAT_SHIPMENT_GRID_TOTAL_QTY` (`total_qty`),
  KEY `IDX_MAG_SALES_FLAT_SHIPMENT_GRID_ORDER_ID` (`order_id`),
  KEY `IDX_MAG_SALES_FLAT_SHIPMENT_GRID_SHIPMENT_STATUS` (`shipment_status`),
  KEY `IDX_MAG_SALES_FLAT_SHIPMENT_GRID_ORDER_INCREMENT_ID` (`order_increment_id`),
  KEY `IDX_MAG_SALES_FLAT_SHIPMENT_GRID_CREATED_AT` (`created_at`),
  KEY `IDX_MAG_SALES_FLAT_SHIPMENT_GRID_ORDER_CREATED_AT` (`order_created_at`),
  KEY `IDX_MAG_SALES_FLAT_SHIPMENT_GRID_SHIPPING_NAME` (`shipping_name`),
  CONSTRAINT `FK_0ED89856D50622BF389743C1E2B34694` FOREIGN KEY (`entity_id`) REFERENCES `mag_sales_flat_shipment` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_SALES_FLAT_SHIPMENT_GRID_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Shipment Grid';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sales_flat_shipment_grid`
--

LOCK TABLES `mag_sales_flat_shipment_grid` WRITE;
/*!40000 ALTER TABLE `mag_sales_flat_shipment_grid` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_sales_flat_shipment_grid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sales_flat_shipment_item`
--

DROP TABLE IF EXISTS `mag_sales_flat_shipment_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sales_flat_shipment_item` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `row_total` decimal(12,4) DEFAULT NULL COMMENT 'Row Total',
  `price` decimal(12,4) DEFAULT NULL COMMENT 'Price',
  `weight` decimal(12,4) DEFAULT NULL COMMENT 'Weight',
  `qty` decimal(12,4) DEFAULT NULL COMMENT 'Qty',
  `product_id` int(11) DEFAULT NULL COMMENT 'Product Id',
  `order_item_id` int(11) DEFAULT NULL COMMENT 'Order Item Id',
  `additional_data` text COMMENT 'Additional Data',
  `description` text COMMENT 'Description',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `sku` varchar(255) DEFAULT NULL COMMENT 'Sku',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_MAG_SALES_FLAT_SHIPMENT_ITEM_PARENT_ID` (`parent_id`),
  CONSTRAINT `FK_290E5DD6F4F3B8FD0286C0E8C76CB2D1` FOREIGN KEY (`parent_id`) REFERENCES `mag_sales_flat_shipment` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Shipment Item';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sales_flat_shipment_item`
--

LOCK TABLES `mag_sales_flat_shipment_item` WRITE;
/*!40000 ALTER TABLE `mag_sales_flat_shipment_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_sales_flat_shipment_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sales_flat_shipment_track`
--

DROP TABLE IF EXISTS `mag_sales_flat_shipment_track`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sales_flat_shipment_track` (
  `entity_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Entity Id',
  `parent_id` int(10) unsigned NOT NULL COMMENT 'Parent Id',
  `weight` decimal(12,4) DEFAULT NULL COMMENT 'Weight',
  `qty` decimal(12,4) DEFAULT NULL COMMENT 'Qty',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `track_number` text COMMENT 'Number',
  `description` text COMMENT 'Description',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  `carrier_code` varchar(32) DEFAULT NULL COMMENT 'Carrier Code',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  PRIMARY KEY (`entity_id`),
  KEY `IDX_MAG_SALES_FLAT_SHIPMENT_TRACK_PARENT_ID` (`parent_id`),
  KEY `IDX_MAG_SALES_FLAT_SHIPMENT_TRACK_ORDER_ID` (`order_id`),
  KEY `IDX_MAG_SALES_FLAT_SHIPMENT_TRACK_CREATED_AT` (`created_at`),
  CONSTRAINT `FK_8A99BF7DBD2FA27F132154B095566154` FOREIGN KEY (`parent_id`) REFERENCES `mag_sales_flat_shipment` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Flat Shipment Track';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sales_flat_shipment_track`
--

LOCK TABLES `mag_sales_flat_shipment_track` WRITE;
/*!40000 ALTER TABLE `mag_sales_flat_shipment_track` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_sales_flat_shipment_track` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sales_invoiced_aggregated`
--

DROP TABLE IF EXISTS `mag_sales_invoiced_aggregated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sales_invoiced_aggregated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `orders_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Orders Invoiced',
  `invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced',
  `invoiced_captured` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced Captured',
  `invoiced_not_captured` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced Not Captured',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_MAG_SALES_INVOICED_AGGREGATED_PERIOD_STORE_ID_ORDER_STATUS` (`period`,`store_id`,`order_status`),
  KEY `IDX_MAG_SALES_INVOICED_AGGREGATED_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MAG_SALES_INVOICED_AGGRED_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Invoiced Aggregated';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sales_invoiced_aggregated`
--

LOCK TABLES `mag_sales_invoiced_aggregated` WRITE;
/*!40000 ALTER TABLE `mag_sales_invoiced_aggregated` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_sales_invoiced_aggregated` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sales_invoiced_aggregated_order`
--

DROP TABLE IF EXISTS `mag_sales_invoiced_aggregated_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sales_invoiced_aggregated_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) NOT NULL DEFAULT '' COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `orders_invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Orders Invoiced',
  `invoiced` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced',
  `invoiced_captured` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced Captured',
  `invoiced_not_captured` decimal(12,4) DEFAULT NULL COMMENT 'Invoiced Not Captured',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_MAG_SALES_INVOICED_AGGRED_ORDER_PERIOD_STORE_ID_ORDER_STS` (`period`,`store_id`,`order_status`),
  KEY `IDX_MAG_SALES_INVOICED_AGGREGATED_ORDER_STORE_ID` (`store_id`),
  CONSTRAINT `FK_C53373DE8B1206B8F90BF9C0280495C4` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Invoiced Aggregated Order';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sales_invoiced_aggregated_order`
--

LOCK TABLES `mag_sales_invoiced_aggregated_order` WRITE;
/*!40000 ALTER TABLE `mag_sales_invoiced_aggregated_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_sales_invoiced_aggregated_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sales_order_aggregated_created`
--

DROP TABLE IF EXISTS `mag_sales_order_aggregated_created`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sales_order_aggregated_created` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) NOT NULL DEFAULT '' COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `total_qty_ordered` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Qty Ordered',
  `total_qty_invoiced` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Qty Invoiced',
  `total_income_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Income Amount',
  `total_revenue_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Revenue Amount',
  `total_profit_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Profit Amount',
  `total_invoiced_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Invoiced Amount',
  `total_canceled_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Canceled Amount',
  `total_paid_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Paid Amount',
  `total_refunded_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Refunded Amount',
  `total_tax_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Tax Amount',
  `total_tax_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Tax Amount Actual',
  `total_shipping_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Shipping Amount',
  `total_shipping_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Shipping Amount Actual',
  `total_discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Discount Amount',
  `total_discount_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Discount Amount Actual',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_MAG_SALES_ORDER_AGGRED_CREATED_PERIOD_STORE_ID_ORDER_STS` (`period`,`store_id`,`order_status`),
  KEY `IDX_MAG_SALES_ORDER_AGGREGATED_CREATED_STORE_ID` (`store_id`),
  CONSTRAINT `FK_86A2FEDEA4B068D80EDD4B4D87B23220` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Aggregated Created';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sales_order_aggregated_created`
--

LOCK TABLES `mag_sales_order_aggregated_created` WRITE;
/*!40000 ALTER TABLE `mag_sales_order_aggregated_created` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_sales_order_aggregated_created` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sales_order_aggregated_updated`
--

DROP TABLE IF EXISTS `mag_sales_order_aggregated_updated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sales_order_aggregated_updated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) NOT NULL COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `total_qty_ordered` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Qty Ordered',
  `total_qty_invoiced` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Qty Invoiced',
  `total_income_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Income Amount',
  `total_revenue_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Revenue Amount',
  `total_profit_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Profit Amount',
  `total_invoiced_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Invoiced Amount',
  `total_canceled_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Canceled Amount',
  `total_paid_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Paid Amount',
  `total_refunded_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Refunded Amount',
  `total_tax_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Tax Amount',
  `total_tax_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Tax Amount Actual',
  `total_shipping_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Shipping Amount',
  `total_shipping_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Shipping Amount Actual',
  `total_discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Discount Amount',
  `total_discount_amount_actual` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Total Discount Amount Actual',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_MAG_SALES_ORDER_AGGRED_UPDATED_PERIOD_STORE_ID_ORDER_STS` (`period`,`store_id`,`order_status`),
  KEY `IDX_MAG_SALES_ORDER_AGGREGATED_UPDATED_STORE_ID` (`store_id`),
  CONSTRAINT `FK_B6C994D3948C239D89052745CF55F00C` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Mag Sales Order Aggregated Updated';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sales_order_aggregated_updated`
--

LOCK TABLES `mag_sales_order_aggregated_updated` WRITE;
/*!40000 ALTER TABLE `mag_sales_order_aggregated_updated` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_sales_order_aggregated_updated` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sales_order_status`
--

DROP TABLE IF EXISTS `mag_sales_order_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sales_order_status` (
  `status` varchar(32) NOT NULL COMMENT 'Status',
  `label` varchar(128) NOT NULL COMMENT 'Label',
  PRIMARY KEY (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Status Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sales_order_status`
--

LOCK TABLES `mag_sales_order_status` WRITE;
/*!40000 ALTER TABLE `mag_sales_order_status` DISABLE KEYS */;
INSERT INTO `mag_sales_order_status` VALUES ('canceled','Canceled'),('closed','Closed'),('complete','Complete'),('fraud','Suspected Fraud'),('holded','On Hold'),('payment_review','Payment Review'),('paypal_canceled_reversal','PayPal Canceled Reversal'),('paypal_reversed','PayPal Reversed'),('pending','Pending'),('pending_payment','Pending Payment'),('pending_paypal','Pending PayPal'),('processing','Processing');
/*!40000 ALTER TABLE `mag_sales_order_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sales_order_status_label`
--

DROP TABLE IF EXISTS `mag_sales_order_status_label`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sales_order_status_label` (
  `status` varchar(32) NOT NULL COMMENT 'Status',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `label` varchar(128) NOT NULL COMMENT 'Label',
  PRIMARY KEY (`status`,`store_id`),
  KEY `IDX_MAG_SALES_ORDER_STATUS_LABEL_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MAG_SALES_ORDER_STATUS_LABEL_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_SALES_ORDER_STS_LBL_STS_MAG_SALES_ORDER_STS_STS` FOREIGN KEY (`status`) REFERENCES `mag_sales_order_status` (`status`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Status Label Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sales_order_status_label`
--

LOCK TABLES `mag_sales_order_status_label` WRITE;
/*!40000 ALTER TABLE `mag_sales_order_status_label` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_sales_order_status_label` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sales_order_status_state`
--

DROP TABLE IF EXISTS `mag_sales_order_status_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sales_order_status_state` (
  `status` varchar(32) NOT NULL COMMENT 'Status',
  `state` varchar(32) NOT NULL COMMENT 'Label',
  `is_default` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Is Default',
  PRIMARY KEY (`status`,`state`),
  CONSTRAINT `FK_MAG_SALES_ORDER_STS_STATE_STS_MAG_SALES_ORDER_STS_STS` FOREIGN KEY (`status`) REFERENCES `mag_sales_order_status` (`status`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Status Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sales_order_status_state`
--

LOCK TABLES `mag_sales_order_status_state` WRITE;
/*!40000 ALTER TABLE `mag_sales_order_status_state` DISABLE KEYS */;
INSERT INTO `mag_sales_order_status_state` VALUES ('canceled','canceled',1),('closed','closed',1),('complete','complete',1),('fraud','payment_review',0),('holded','holded',1),('payment_review','payment_review',1),('pending','new',1),('pending_payment','pending_payment',1),('processing','processing',1);
/*!40000 ALTER TABLE `mag_sales_order_status_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sales_order_tax`
--

DROP TABLE IF EXISTS `mag_sales_order_tax`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sales_order_tax` (
  `tax_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Tax Id',
  `order_id` int(10) unsigned NOT NULL COMMENT 'Order Id',
  `code` varchar(255) DEFAULT NULL COMMENT 'Code',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title',
  `percent` decimal(12,4) DEFAULT NULL COMMENT 'Percent',
  `amount` decimal(12,4) DEFAULT NULL COMMENT 'Amount',
  `priority` int(11) NOT NULL COMMENT 'Priority',
  `position` int(11) NOT NULL COMMENT 'Position',
  `base_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Amount',
  `process` smallint(6) NOT NULL COMMENT 'Process',
  `base_real_amount` decimal(12,4) DEFAULT NULL COMMENT 'Base Real Amount',
  `hidden` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Hidden',
  PRIMARY KEY (`tax_id`),
  KEY `IDX_MAG_SALES_ORDER_TAX_ORDER_ID_PRIORITY_POSITION` (`order_id`,`priority`,`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Tax Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sales_order_tax`
--

LOCK TABLES `mag_sales_order_tax` WRITE;
/*!40000 ALTER TABLE `mag_sales_order_tax` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_sales_order_tax` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sales_order_tax_item`
--

DROP TABLE IF EXISTS `mag_sales_order_tax_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sales_order_tax_item` (
  `tax_item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Tax Item Id',
  `tax_id` int(10) unsigned NOT NULL COMMENT 'Tax Id',
  `item_id` int(10) unsigned NOT NULL COMMENT 'Item Id',
  `tax_percent` decimal(12,4) NOT NULL COMMENT 'Real Tax Percent For Item',
  PRIMARY KEY (`tax_item_id`),
  UNIQUE KEY `UNQ_MAG_SALES_ORDER_TAX_ITEM_TAX_ID_ITEM_ID` (`tax_id`,`item_id`),
  KEY `IDX_MAG_SALES_ORDER_TAX_ITEM_TAX_ID` (`tax_id`),
  KEY `IDX_MAG_SALES_ORDER_TAX_ITEM_ITEM_ID` (`item_id`),
  CONSTRAINT `FK_9D1DB7B1E60A465CE7CD9A59EE98220A` FOREIGN KEY (`item_id`) REFERENCES `mag_sales_flat_order_item` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_SALES_ORDER_TAX_ITEM_TAX_ID_MAG_SALES_ORDER_TAX_TAX_ID` FOREIGN KEY (`tax_id`) REFERENCES `mag_sales_order_tax` (`tax_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Order Tax Item';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sales_order_tax_item`
--

LOCK TABLES `mag_sales_order_tax_item` WRITE;
/*!40000 ALTER TABLE `mag_sales_order_tax_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_sales_order_tax_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sales_payment_transaction`
--

DROP TABLE IF EXISTS `mag_sales_payment_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sales_payment_transaction` (
  `transaction_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Transaction Id',
  `parent_id` int(10) unsigned DEFAULT NULL COMMENT 'Parent Id',
  `order_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Order Id',
  `payment_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Payment Id',
  `txn_id` varchar(100) DEFAULT NULL COMMENT 'Txn Id',
  `parent_txn_id` varchar(100) DEFAULT NULL COMMENT 'Parent Txn Id',
  `txn_type` varchar(15) DEFAULT NULL COMMENT 'Txn Type',
  `is_closed` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Closed',
  `additional_information` blob COMMENT 'Additional Information',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  PRIMARY KEY (`transaction_id`),
  UNIQUE KEY `UNQ_MAG_SALES_PAYMENT_TRANSACTION_ORDER_ID_PAYMENT_ID_TXN_ID` (`order_id`,`payment_id`,`txn_id`),
  KEY `IDX_MAG_SALES_PAYMENT_TRANSACTION_ORDER_ID` (`order_id`),
  KEY `IDX_MAG_SALES_PAYMENT_TRANSACTION_PARENT_ID` (`parent_id`),
  KEY `IDX_MAG_SALES_PAYMENT_TRANSACTION_PAYMENT_ID` (`payment_id`),
  CONSTRAINT `FK_22866ABA1525C788C1CE1A3AD451B1FB` FOREIGN KEY (`payment_id`) REFERENCES `mag_sales_flat_order_payment` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_83C882629A60B83C41716347CC67DE33` FOREIGN KEY (`parent_id`) REFERENCES `mag_sales_payment_transaction` (`transaction_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_A0DC81B4BFF1B0778011835E57B6A899` FOREIGN KEY (`order_id`) REFERENCES `mag_sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Payment Transaction';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sales_payment_transaction`
--

LOCK TABLES `mag_sales_payment_transaction` WRITE;
/*!40000 ALTER TABLE `mag_sales_payment_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_sales_payment_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sales_recurring_profile`
--

DROP TABLE IF EXISTS `mag_sales_recurring_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sales_recurring_profile` (
  `profile_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Profile Id',
  `state` varchar(20) NOT NULL COMMENT 'State',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `method_code` varchar(32) NOT NULL COMMENT 'Method Code',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Created At',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Updated At',
  `reference_id` varchar(32) DEFAULT NULL COMMENT 'Reference Id',
  `subscriber_name` varchar(150) DEFAULT NULL COMMENT 'Subscriber Name',
  `start_datetime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Start Datetime',
  `internal_reference_id` varchar(42) NOT NULL COMMENT 'Internal Reference Id',
  `schedule_description` varchar(255) NOT NULL COMMENT 'Schedule Description',
  `suspension_threshold` smallint(5) unsigned DEFAULT NULL COMMENT 'Suspension Threshold',
  `bill_failed_later` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Bill Failed Later',
  `period_unit` varchar(20) NOT NULL COMMENT 'Period Unit',
  `period_frequency` smallint(5) unsigned DEFAULT NULL COMMENT 'Period Frequency',
  `period_max_cycles` smallint(5) unsigned DEFAULT NULL COMMENT 'Period Max Cycles',
  `billing_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Billing Amount',
  `trial_period_unit` varchar(20) DEFAULT NULL COMMENT 'Trial Period Unit',
  `trial_period_frequency` smallint(5) unsigned DEFAULT NULL COMMENT 'Trial Period Frequency',
  `trial_period_max_cycles` smallint(5) unsigned DEFAULT NULL COMMENT 'Trial Period Max Cycles',
  `trial_billing_amount` text COMMENT 'Trial Billing Amount',
  `currency_code` varchar(3) NOT NULL COMMENT 'Currency Code',
  `shipping_amount` decimal(12,4) DEFAULT NULL COMMENT 'Shipping Amount',
  `tax_amount` decimal(12,4) DEFAULT NULL COMMENT 'Tax Amount',
  `init_amount` decimal(12,4) DEFAULT NULL COMMENT 'Init Amount',
  `init_may_fail` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Init May Fail',
  `order_info` text NOT NULL COMMENT 'Order Info',
  `order_item_info` text NOT NULL COMMENT 'Order Item Info',
  `billing_address_info` text NOT NULL COMMENT 'Billing Address Info',
  `shipping_address_info` text COMMENT 'Shipping Address Info',
  `profile_vendor_info` text COMMENT 'Profile Vendor Info',
  `additional_info` text COMMENT 'Additional Info',
  PRIMARY KEY (`profile_id`),
  UNIQUE KEY `UNQ_MAG_SALES_RECURRING_PROFILE_INTERNAL_REFERENCE_ID` (`internal_reference_id`),
  KEY `IDX_MAG_SALES_RECURRING_PROFILE_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_MAG_SALES_RECURRING_PROFILE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MAG_SALES_RECURRING_PROFILE_CSTR_ID_MAG_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `mag_customer_entity` (`entity_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_SALES_RECURRING_PROFILE_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Recurring Profile';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sales_recurring_profile`
--

LOCK TABLES `mag_sales_recurring_profile` WRITE;
/*!40000 ALTER TABLE `mag_sales_recurring_profile` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_sales_recurring_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sales_recurring_profile_order`
--

DROP TABLE IF EXISTS `mag_sales_recurring_profile_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sales_recurring_profile_order` (
  `link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Link Id',
  `profile_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Profile Id',
  `order_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Order Id',
  PRIMARY KEY (`link_id`),
  UNIQUE KEY `UNQ_MAG_SALES_RECURRING_PROFILE_ORDER_PROFILE_ID_ORDER_ID` (`profile_id`,`order_id`),
  KEY `IDX_MAG_SALES_RECURRING_PROFILE_ORDER_ORDER_ID` (`order_id`),
  CONSTRAINT `FK_DB657406925B4C88CB1AE2A177393B73` FOREIGN KEY (`order_id`) REFERENCES `mag_sales_flat_order` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_F4D9AD248B8E4DC68A0953D3C6357A9F` FOREIGN KEY (`profile_id`) REFERENCES `mag_sales_recurring_profile` (`profile_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Recurring Profile Order';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sales_recurring_profile_order`
--

LOCK TABLES `mag_sales_recurring_profile_order` WRITE;
/*!40000 ALTER TABLE `mag_sales_recurring_profile_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_sales_recurring_profile_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sales_refunded_aggregated`
--

DROP TABLE IF EXISTS `mag_sales_refunded_aggregated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sales_refunded_aggregated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) NOT NULL DEFAULT '' COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `refunded` decimal(12,4) DEFAULT NULL COMMENT 'Refunded',
  `online_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Online Refunded',
  `offline_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Offline Refunded',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_MAG_SALES_REFUNDED_AGGREGATED_PERIOD_STORE_ID_ORDER_STATUS` (`period`,`store_id`,`order_status`),
  KEY `IDX_MAG_SALES_REFUNDED_AGGREGATED_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MAG_SALES_REFUNDED_AGGRED_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Refunded Aggregated';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sales_refunded_aggregated`
--

LOCK TABLES `mag_sales_refunded_aggregated` WRITE;
/*!40000 ALTER TABLE `mag_sales_refunded_aggregated` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_sales_refunded_aggregated` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sales_refunded_aggregated_order`
--

DROP TABLE IF EXISTS `mag_sales_refunded_aggregated_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sales_refunded_aggregated_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `refunded` decimal(12,4) DEFAULT NULL COMMENT 'Refunded',
  `online_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Online Refunded',
  `offline_refunded` decimal(12,4) DEFAULT NULL COMMENT 'Offline Refunded',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNQ_MAG_SALES_REFUNDED_AGGRED_ORDER_PERIOD_STORE_ID_ORDER_STS` (`period`,`store_id`,`order_status`),
  KEY `IDX_MAG_SALES_REFUNDED_AGGREGATED_ORDER_STORE_ID` (`store_id`),
  CONSTRAINT `FK_650F0BA53EEF98C9456C8E28AD5315E8` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Refunded Aggregated Order';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sales_refunded_aggregated_order`
--

LOCK TABLES `mag_sales_refunded_aggregated_order` WRITE;
/*!40000 ALTER TABLE `mag_sales_refunded_aggregated_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_sales_refunded_aggregated_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sales_shipping_aggregated`
--

DROP TABLE IF EXISTS `mag_sales_shipping_aggregated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sales_shipping_aggregated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `shipping_description` varchar(255) DEFAULT NULL COMMENT 'Shipping Description',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `total_shipping` decimal(12,4) DEFAULT NULL COMMENT 'Total Shipping',
  `total_shipping_actual` decimal(12,4) DEFAULT NULL COMMENT 'Total Shipping Actual',
  PRIMARY KEY (`id`),
  UNIQUE KEY `FF4EA99FA86E304F87753FCC33BDE253` (`period`,`store_id`,`order_status`,`shipping_description`),
  KEY `IDX_MAG_SALES_SHIPPING_AGGREGATED_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MAG_SALES_SHPP_AGGRED_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Shipping Aggregated';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sales_shipping_aggregated`
--

LOCK TABLES `mag_sales_shipping_aggregated` WRITE;
/*!40000 ALTER TABLE `mag_sales_shipping_aggregated` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_sales_shipping_aggregated` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sales_shipping_aggregated_order`
--

DROP TABLE IF EXISTS `mag_sales_shipping_aggregated_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sales_shipping_aggregated_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `order_status` varchar(50) DEFAULT NULL COMMENT 'Order Status',
  `shipping_description` varchar(255) DEFAULT NULL COMMENT 'Shipping Description',
  `orders_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `total_shipping` decimal(12,4) DEFAULT NULL COMMENT 'Total Shipping',
  `total_shipping_actual` decimal(12,4) DEFAULT NULL COMMENT 'Total Shipping Actual',
  PRIMARY KEY (`id`),
  UNIQUE KEY `BF22992F70E3676ED88B598FD9C4B7CB` (`period`,`store_id`,`order_status`,`shipping_description`),
  KEY `IDX_MAG_SALES_SHIPPING_AGGREGATED_ORDER_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MAG_SALES_SHPP_AGGRED_ORDER_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Shipping Aggregated Order';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sales_shipping_aggregated_order`
--

LOCK TABLES `mag_sales_shipping_aggregated_order` WRITE;
/*!40000 ALTER TABLE `mag_sales_shipping_aggregated_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_sales_shipping_aggregated_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_salesrule`
--

DROP TABLE IF EXISTS `mag_salesrule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_salesrule` (
  `rule_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rule Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `description` text COMMENT 'Description',
  `from_date` date DEFAULT NULL,
  `to_date` date DEFAULT NULL,
  `uses_per_customer` int(11) NOT NULL DEFAULT '0' COMMENT 'Uses Per Customer',
  `is_active` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is Active',
  `conditions_serialized` mediumtext COMMENT 'Conditions Serialized',
  `actions_serialized` mediumtext COMMENT 'Actions Serialized',
  `stop_rules_processing` smallint(6) NOT NULL DEFAULT '1' COMMENT 'Stop Rules Processing',
  `is_advanced` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Is Advanced',
  `product_ids` text COMMENT 'Product Ids',
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort Order',
  `simple_action` varchar(32) DEFAULT NULL COMMENT 'Simple Action',
  `discount_amount` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Discount Amount',
  `discount_qty` decimal(12,4) DEFAULT NULL COMMENT 'Discount Qty',
  `discount_step` int(10) unsigned NOT NULL COMMENT 'Discount Step',
  `simple_free_shipping` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Simple Free Shipping',
  `apply_to_shipping` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Apply To Shipping',
  `times_used` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Times Used',
  `is_rss` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Is Rss',
  `coupon_type` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Coupon Type',
  `use_auto_generation` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Use Auto Generation',
  `uses_per_coupon` int(11) NOT NULL DEFAULT '0' COMMENT 'Uses Per Coupon',
  PRIMARY KEY (`rule_id`),
  KEY `IDX_MAG_SALESRULE_IS_ACTIVE_SORT_ORDER_TO_DATE_FROM_DATE` (`is_active`,`sort_order`,`to_date`,`from_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Salesrule';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_salesrule`
--

LOCK TABLES `mag_salesrule` WRITE;
/*!40000 ALTER TABLE `mag_salesrule` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_salesrule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_salesrule_coupon`
--

DROP TABLE IF EXISTS `mag_salesrule_coupon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_salesrule_coupon` (
  `coupon_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Coupon Id',
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `code` varchar(255) DEFAULT NULL COMMENT 'Code',
  `usage_limit` int(10) unsigned DEFAULT NULL COMMENT 'Usage Limit',
  `usage_per_customer` int(10) unsigned DEFAULT NULL COMMENT 'Usage Per Customer',
  `times_used` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Times Used',
  `expiration_date` timestamp NULL DEFAULT NULL COMMENT 'Expiration Date',
  `is_primary` smallint(5) unsigned DEFAULT NULL COMMENT 'Is Primary',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Coupon Code Creation Date',
  `type` smallint(6) DEFAULT '0' COMMENT 'Coupon Code Type',
  PRIMARY KEY (`coupon_id`),
  UNIQUE KEY `UNQ_MAG_SALESRULE_COUPON_CODE` (`code`),
  UNIQUE KEY `UNQ_MAG_SALESRULE_COUPON_RULE_ID_IS_PRIMARY` (`rule_id`,`is_primary`),
  KEY `IDX_MAG_SALESRULE_COUPON_RULE_ID` (`rule_id`),
  CONSTRAINT `FK_MAG_SALESRULE_COUPON_RULE_ID_MAG_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `mag_salesrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Salesrule Coupon';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_salesrule_coupon`
--

LOCK TABLES `mag_salesrule_coupon` WRITE;
/*!40000 ALTER TABLE `mag_salesrule_coupon` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_salesrule_coupon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_salesrule_coupon_usage`
--

DROP TABLE IF EXISTS `mag_salesrule_coupon_usage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_salesrule_coupon_usage` (
  `coupon_id` int(10) unsigned NOT NULL COMMENT 'Coupon Id',
  `customer_id` int(10) unsigned NOT NULL COMMENT 'Customer Id',
  `times_used` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Times Used',
  PRIMARY KEY (`coupon_id`,`customer_id`),
  KEY `IDX_MAG_SALESRULE_COUPON_USAGE_COUPON_ID` (`coupon_id`),
  KEY `IDX_MAG_SALESRULE_COUPON_USAGE_CUSTOMER_ID` (`customer_id`),
  CONSTRAINT `FK_409742C41859CF0C7DCAAED99C01E6DB` FOREIGN KEY (`coupon_id`) REFERENCES `mag_salesrule_coupon` (`coupon_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_SALESRULE_COUPON_USAGE_CSTR_ID_MAG_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `mag_customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Salesrule Coupon Usage';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_salesrule_coupon_usage`
--

LOCK TABLES `mag_salesrule_coupon_usage` WRITE;
/*!40000 ALTER TABLE `mag_salesrule_coupon_usage` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_salesrule_coupon_usage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_salesrule_customer`
--

DROP TABLE IF EXISTS `mag_salesrule_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_salesrule_customer` (
  `rule_customer_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Rule Customer Id',
  `rule_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Rule Id',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer Id',
  `times_used` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Times Used',
  PRIMARY KEY (`rule_customer_id`),
  KEY `IDX_MAG_SALESRULE_CUSTOMER_RULE_ID_CUSTOMER_ID` (`rule_id`,`customer_id`),
  KEY `IDX_MAG_SALESRULE_CUSTOMER_CUSTOMER_ID_RULE_ID` (`customer_id`,`rule_id`),
  CONSTRAINT `FK_MAG_SALESRULE_CSTR_CSTR_ID_MAG_CSTR_ENTT_ENTT_ID` FOREIGN KEY (`customer_id`) REFERENCES `mag_customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_SALESRULE_CUSTOMER_RULE_ID_MAG_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `mag_salesrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Salesrule Customer';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_salesrule_customer`
--

LOCK TABLES `mag_salesrule_customer` WRITE;
/*!40000 ALTER TABLE `mag_salesrule_customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_salesrule_customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_salesrule_customer_group`
--

DROP TABLE IF EXISTS `mag_salesrule_customer_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_salesrule_customer_group` (
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  PRIMARY KEY (`rule_id`,`customer_group_id`),
  KEY `IDX_MAG_SALESRULE_CUSTOMER_GROUP_RULE_ID` (`rule_id`),
  KEY `IDX_MAG_SALESRULE_CUSTOMER_GROUP_CUSTOMER_GROUP_ID` (`customer_group_id`),
  CONSTRAINT `FK_3682C99FABC384908DBFEFAA53F89719` FOREIGN KEY (`customer_group_id`) REFERENCES `mag_customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_SALESRULE_CUSTOMER_GROUP_RULE_ID_MAG_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `mag_salesrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Rules To Customer Groups Relations';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_salesrule_customer_group`
--

LOCK TABLES `mag_salesrule_customer_group` WRITE;
/*!40000 ALTER TABLE `mag_salesrule_customer_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_salesrule_customer_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_salesrule_label`
--

DROP TABLE IF EXISTS `mag_salesrule_label`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_salesrule_label` (
  `label_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Label Id',
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `label` varchar(255) DEFAULT NULL COMMENT 'Label',
  PRIMARY KEY (`label_id`),
  UNIQUE KEY `UNQ_MAG_SALESRULE_LABEL_RULE_ID_STORE_ID` (`rule_id`,`store_id`),
  KEY `IDX_MAG_SALESRULE_LABEL_STORE_ID` (`store_id`),
  KEY `IDX_MAG_SALESRULE_LABEL_RULE_ID` (`rule_id`),
  CONSTRAINT `FK_MAG_SALESRULE_LABEL_RULE_ID_MAG_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `mag_salesrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_SALESRULE_LABEL_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Salesrule Label';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_salesrule_label`
--

LOCK TABLES `mag_salesrule_label` WRITE;
/*!40000 ALTER TABLE `mag_salesrule_label` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_salesrule_label` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_salesrule_product_attribute`
--

DROP TABLE IF EXISTS `mag_salesrule_product_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_salesrule_product_attribute` (
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  PRIMARY KEY (`rule_id`,`website_id`,`customer_group_id`,`attribute_id`),
  KEY `IDX_MAG_SALESRULE_PRODUCT_ATTRIBUTE_WEBSITE_ID` (`website_id`),
  KEY `IDX_MAG_SALESRULE_PRODUCT_ATTRIBUTE_CUSTOMER_GROUP_ID` (`customer_group_id`),
  KEY `IDX_MAG_SALESRULE_PRODUCT_ATTRIBUTE_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `FK_BDA140E8838BBABEA3AC2C023811C382` FOREIGN KEY (`customer_group_id`) REFERENCES `mag_customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_MAG_SALESRULE_PRD_ATTR_ATTR_ID_MAG_EAV_ATTR_ATTR_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mag_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_MAG_SALESRULE_PRD_ATTR_WS_ID_MAG_CORE_WS_WS_ID` FOREIGN KEY (`website_id`) REFERENCES `mag_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_MAG_SALESRULE_PRODUCT_ATTRIBUTE_RULE_ID_MAG_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `mag_salesrule` (`rule_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Salesrule Product Attribute';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_salesrule_product_attribute`
--

LOCK TABLES `mag_salesrule_product_attribute` WRITE;
/*!40000 ALTER TABLE `mag_salesrule_product_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_salesrule_product_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_salesrule_website`
--

DROP TABLE IF EXISTS `mag_salesrule_website`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_salesrule_website` (
  `rule_id` int(10) unsigned NOT NULL COMMENT 'Rule Id',
  `website_id` smallint(5) unsigned NOT NULL COMMENT 'Website Id',
  PRIMARY KEY (`rule_id`,`website_id`),
  KEY `IDX_MAG_SALESRULE_WEBSITE_RULE_ID` (`rule_id`),
  KEY `IDX_MAG_SALESRULE_WEBSITE_WEBSITE_ID` (`website_id`),
  CONSTRAINT `FK_MAG_SALESRULE_WEBSITE_RULE_ID_MAG_SALESRULE_RULE_ID` FOREIGN KEY (`rule_id`) REFERENCES `mag_salesrule` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_SALESRULE_WEBSITE_WEBSITE_ID_MAG_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `mag_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sales Rules To Websites Relations';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_salesrule_website`
--

LOCK TABLES `mag_salesrule_website` WRITE;
/*!40000 ALTER TABLE `mag_salesrule_website` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_salesrule_website` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sendfriend_log`
--

DROP TABLE IF EXISTS `mag_sendfriend_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sendfriend_log` (
  `log_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Log ID',
  `ip` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer IP address',
  `time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Log time',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website ID',
  PRIMARY KEY (`log_id`),
  KEY `IDX_MAG_SENDFRIEND_LOG_IP` (`ip`),
  KEY `IDX_MAG_SENDFRIEND_LOG_TIME` (`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Send to friend function log storage table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sendfriend_log`
--

LOCK TABLES `mag_sendfriend_log` WRITE;
/*!40000 ALTER TABLE `mag_sendfriend_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_sendfriend_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_shipping_tablerate`
--

DROP TABLE IF EXISTS `mag_shipping_tablerate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_shipping_tablerate` (
  `pk` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
  `website_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `dest_country_id` varchar(4) NOT NULL DEFAULT '0' COMMENT 'Destination coutry ISO/2 or ISO/3 code',
  `dest_region_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Destination Region Id',
  `dest_zip` varchar(10) NOT NULL DEFAULT '*' COMMENT 'Destination Post Code (Zip)',
  `condition_name` varchar(20) NOT NULL COMMENT 'Rate Condition name',
  `condition_value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Rate condition value',
  `price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Price',
  `cost` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Cost',
  PRIMARY KEY (`pk`),
  UNIQUE KEY `FE0EB736C2969C420B55D9E8DA2105A4` (`website_id`,`dest_country_id`,`dest_region_id`,`dest_zip`,`condition_name`,`condition_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Shipping Tablerate';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_shipping_tablerate`
--

LOCK TABLES `mag_shipping_tablerate` WRITE;
/*!40000 ALTER TABLE `mag_shipping_tablerate` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_shipping_tablerate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_sitemap`
--

DROP TABLE IF EXISTS `mag_sitemap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_sitemap` (
  `sitemap_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Sitemap Id',
  `sitemap_type` varchar(32) DEFAULT NULL COMMENT 'Sitemap Type',
  `sitemap_filename` varchar(32) DEFAULT NULL COMMENT 'Sitemap Filename',
  `sitemap_path` varchar(255) DEFAULT NULL COMMENT 'Sitemap Path',
  `sitemap_time` timestamp NULL DEFAULT NULL COMMENT 'Sitemap Time',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store id',
  PRIMARY KEY (`sitemap_id`),
  KEY `IDX_MAG_SITEMAP_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MAG_SITEMAP_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Google Sitemap';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_sitemap`
--

LOCK TABLES `mag_sitemap` WRITE;
/*!40000 ALTER TABLE `mag_sitemap` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_sitemap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_tag`
--

DROP TABLE IF EXISTS `mag_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_tag` (
  `tag_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Tag Id',
  `name` varchar(255) DEFAULT NULL COMMENT 'Name',
  `status` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Status',
  `first_customer_id` int(10) unsigned DEFAULT NULL COMMENT 'First Customer Id',
  `first_store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'First Store Id',
  PRIMARY KEY (`tag_id`),
  KEY `FK_MAG_TAG_FIRST_CUSTOMER_ID_MAG_CUSTOMER_ENTITY_ENTITY_ID` (`first_customer_id`),
  KEY `FK_MAG_TAG_FIRST_STORE_ID_MAG_CORE_STORE_STORE_ID` (`first_store_id`),
  CONSTRAINT `FK_MAG_TAG_FIRST_CUSTOMER_ID_MAG_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`first_customer_id`) REFERENCES `mag_customer_entity` (`entity_id`) ON DELETE SET NULL ON UPDATE NO ACTION,
  CONSTRAINT `FK_MAG_TAG_FIRST_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`first_store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tag';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_tag`
--

LOCK TABLES `mag_tag` WRITE;
/*!40000 ALTER TABLE `mag_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_tag_properties`
--

DROP TABLE IF EXISTS `mag_tag_properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_tag_properties` (
  `tag_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Tag Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `base_popularity` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Base Popularity',
  PRIMARY KEY (`tag_id`,`store_id`),
  KEY `IDX_MAG_TAG_PROPERTIES_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MAG_TAG_PROPERTIES_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_TAG_PROPERTIES_TAG_ID_MAG_TAG_TAG_ID` FOREIGN KEY (`tag_id`) REFERENCES `mag_tag` (`tag_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tag Properties';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_tag_properties`
--

LOCK TABLES `mag_tag_properties` WRITE;
/*!40000 ALTER TABLE `mag_tag_properties` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_tag_properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_tag_relation`
--

DROP TABLE IF EXISTS `mag_tag_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_tag_relation` (
  `tag_relation_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Tag Relation Id',
  `tag_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Tag Id',
  `customer_id` int(10) unsigned DEFAULT NULL COMMENT 'Customer Id',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Store Id',
  `active` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT 'Active',
  `created_at` timestamp NULL DEFAULT NULL COMMENT 'Created At',
  PRIMARY KEY (`tag_relation_id`),
  UNIQUE KEY `UNQ_MAG_TAG_RELATION_TAG_ID_CUSTOMER_ID_PRODUCT_ID_STORE_ID` (`tag_id`,`customer_id`,`product_id`,`store_id`),
  KEY `IDX_MAG_TAG_RELATION_PRODUCT_ID` (`product_id`),
  KEY `IDX_MAG_TAG_RELATION_TAG_ID` (`tag_id`),
  KEY `IDX_MAG_TAG_RELATION_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_MAG_TAG_RELATION_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MAG_TAG_RELATION_CUSTOMER_ID_MAG_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `mag_customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_TAG_RELATION_PRD_ID_MAG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_TAG_RELATION_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_TAG_RELATION_TAG_ID_MAG_TAG_TAG_ID` FOREIGN KEY (`tag_id`) REFERENCES `mag_tag` (`tag_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tag Relation';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_tag_relation`
--

LOCK TABLES `mag_tag_relation` WRITE;
/*!40000 ALTER TABLE `mag_tag_relation` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_tag_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_tag_summary`
--

DROP TABLE IF EXISTS `mag_tag_summary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_tag_summary` (
  `tag_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Tag Id',
  `store_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Store Id',
  `customers` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customers',
  `products` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Products',
  `uses` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Uses',
  `historical_uses` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Historical Uses',
  `popularity` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Popularity',
  `base_popularity` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Base Popularity',
  PRIMARY KEY (`tag_id`,`store_id`),
  KEY `IDX_MAG_TAG_SUMMARY_STORE_ID` (`store_id`),
  KEY `IDX_MAG_TAG_SUMMARY_TAG_ID` (`tag_id`),
  CONSTRAINT `FK_MAG_TAG_SUMMARY_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_TAG_SUMMARY_TAG_ID_MAG_TAG_TAG_ID` FOREIGN KEY (`tag_id`) REFERENCES `mag_tag` (`tag_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tag Summary';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_tag_summary`
--

LOCK TABLES `mag_tag_summary` WRITE;
/*!40000 ALTER TABLE `mag_tag_summary` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_tag_summary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_tax_calculation`
--

DROP TABLE IF EXISTS `mag_tax_calculation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_tax_calculation` (
  `tax_calculation_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Tax Calculation Id',
  `tax_calculation_rate_id` int(11) NOT NULL COMMENT 'Tax Calculation Rate Id',
  `tax_calculation_rule_id` int(11) NOT NULL COMMENT 'Tax Calculation Rule Id',
  `customer_tax_class_id` smallint(6) NOT NULL COMMENT 'Customer Tax Class Id',
  `product_tax_class_id` smallint(6) NOT NULL COMMENT 'Product Tax Class Id',
  PRIMARY KEY (`tax_calculation_id`),
  KEY `IDX_MAG_TAX_CALCULATION_TAX_CALCULATION_RULE_ID` (`tax_calculation_rule_id`),
  KEY `IDX_MAG_TAX_CALCULATION_TAX_CALCULATION_RATE_ID` (`tax_calculation_rate_id`),
  KEY `IDX_MAG_TAX_CALCULATION_CUSTOMER_TAX_CLASS_ID` (`customer_tax_class_id`),
  KEY `IDX_MAG_TAX_CALCULATION_PRODUCT_TAX_CLASS_ID` (`product_tax_class_id`),
  KEY `22FC82DD32D7B76D5D50F812A67D4D29` (`tax_calculation_rate_id`,`customer_tax_class_id`,`product_tax_class_id`),
  CONSTRAINT `FK_B1B53D4F42D0F6631341E6EF3C20E4E9` FOREIGN KEY (`tax_calculation_rate_id`) REFERENCES `mag_tax_calculation_rate` (`tax_calculation_rate_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_BC6E0CE5339865BF069F08382817052F` FOREIGN KEY (`tax_calculation_rule_id`) REFERENCES `mag_tax_calculation_rule` (`tax_calculation_rule_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_TAX_CALC_CSTR_TAX_CLASS_ID_MAG_TAX_CLASS_CLASS_ID` FOREIGN KEY (`customer_tax_class_id`) REFERENCES `mag_tax_class` (`class_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_TAX_CALC_PRD_TAX_CLASS_ID_MAG_TAX_CLASS_CLASS_ID` FOREIGN KEY (`product_tax_class_id`) REFERENCES `mag_tax_class` (`class_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Tax Calculation';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_tax_calculation`
--

LOCK TABLES `mag_tax_calculation` WRITE;
/*!40000 ALTER TABLE `mag_tax_calculation` DISABLE KEYS */;
INSERT INTO `mag_tax_calculation` VALUES (1,1,1,3,2),(2,2,1,3,2);
/*!40000 ALTER TABLE `mag_tax_calculation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_tax_calculation_rate`
--

DROP TABLE IF EXISTS `mag_tax_calculation_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_tax_calculation_rate` (
  `tax_calculation_rate_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Tax Calculation Rate Id',
  `tax_country_id` varchar(2) NOT NULL COMMENT 'Tax Country Id',
  `tax_region_id` int(11) NOT NULL COMMENT 'Tax Region Id',
  `tax_postcode` varchar(21) DEFAULT NULL COMMENT 'Tax Postcode',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `rate` decimal(12,4) NOT NULL COMMENT 'Rate',
  `zip_is_range` smallint(6) DEFAULT NULL COMMENT 'Zip Is Range',
  `zip_from` int(10) unsigned DEFAULT NULL COMMENT 'Zip From',
  `zip_to` int(10) unsigned DEFAULT NULL COMMENT 'Zip To',
  PRIMARY KEY (`tax_calculation_rate_id`),
  KEY `IDX_MAG_TAX_CALC_RATE_TAX_COUNTRY_ID_TAX_REGION_ID_TAX_POSTCODE` (`tax_country_id`,`tax_region_id`,`tax_postcode`),
  KEY `IDX_MAG_TAX_CALCULATION_RATE_CODE` (`code`),
  KEY `8AA692F6206661EB47544C5376C8E384` (`tax_calculation_rate_id`,`tax_country_id`,`tax_region_id`,`zip_is_range`,`tax_postcode`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Tax Calculation Rate';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_tax_calculation_rate`
--

LOCK TABLES `mag_tax_calculation_rate` WRITE;
/*!40000 ALTER TABLE `mag_tax_calculation_rate` DISABLE KEYS */;
INSERT INTO `mag_tax_calculation_rate` VALUES (1,'US',12,'*','US-CA-*-Rate 1',8.2500,NULL,NULL,NULL),(2,'US',43,'*','US-NY-*-Rate 1',8.3750,NULL,NULL,NULL);
/*!40000 ALTER TABLE `mag_tax_calculation_rate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_tax_calculation_rate_title`
--

DROP TABLE IF EXISTS `mag_tax_calculation_rate_title`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_tax_calculation_rate_title` (
  `tax_calculation_rate_title_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Tax Calculation Rate Title Id',
  `tax_calculation_rate_id` int(11) NOT NULL COMMENT 'Tax Calculation Rate Id',
  `store_id` smallint(5) unsigned NOT NULL COMMENT 'Store Id',
  `value` varchar(255) NOT NULL COMMENT 'Value',
  PRIMARY KEY (`tax_calculation_rate_title_id`),
  KEY `IDX_MAG_TAX_CALC_RATE_TTL_TAX_CALC_RATE_ID_STORE_ID` (`tax_calculation_rate_id`,`store_id`),
  KEY `IDX_MAG_TAX_CALCULATION_RATE_TITLE_TAX_CALCULATION_RATE_ID` (`tax_calculation_rate_id`),
  KEY `IDX_MAG_TAX_CALCULATION_RATE_TITLE_STORE_ID` (`store_id`),
  CONSTRAINT `FK_AEE53BFCA12CC4D9BC99FE53D9218A03` FOREIGN KEY (`tax_calculation_rate_id`) REFERENCES `mag_tax_calculation_rate` (`tax_calculation_rate_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_TAX_CALC_RATE_TTL_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tax Calculation Rate Title';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_tax_calculation_rate_title`
--

LOCK TABLES `mag_tax_calculation_rate_title` WRITE;
/*!40000 ALTER TABLE `mag_tax_calculation_rate_title` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_tax_calculation_rate_title` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_tax_calculation_rule`
--

DROP TABLE IF EXISTS `mag_tax_calculation_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_tax_calculation_rule` (
  `tax_calculation_rule_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Tax Calculation Rule Id',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `priority` int(11) NOT NULL COMMENT 'Priority',
  `position` int(11) NOT NULL COMMENT 'Position',
  `calculate_subtotal` int(11) NOT NULL COMMENT 'Calculate off subtotal option',
  PRIMARY KEY (`tax_calculation_rule_id`),
  KEY `IDX_MAG_TAX_CALC_RULE_PRIORITY_POSITION_TAX_CALC_RULE_ID` (`priority`,`position`,`tax_calculation_rule_id`),
  KEY `IDX_MAG_TAX_CALCULATION_RULE_CODE` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Tax Calculation Rule';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_tax_calculation_rule`
--

LOCK TABLES `mag_tax_calculation_rule` WRITE;
/*!40000 ALTER TABLE `mag_tax_calculation_rule` DISABLE KEYS */;
INSERT INTO `mag_tax_calculation_rule` VALUES (1,'Retail Customer-Taxable Goods-Rate 1',1,1,0);
/*!40000 ALTER TABLE `mag_tax_calculation_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_tax_class`
--

DROP TABLE IF EXISTS `mag_tax_class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_tax_class` (
  `class_id` smallint(6) NOT NULL AUTO_INCREMENT COMMENT 'Class Id',
  `class_name` varchar(255) NOT NULL COMMENT 'Class Name',
  `class_type` varchar(8) NOT NULL DEFAULT 'CUSTOMER' COMMENT 'Class Type',
  PRIMARY KEY (`class_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Tax Class';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_tax_class`
--

LOCK TABLES `mag_tax_class` WRITE;
/*!40000 ALTER TABLE `mag_tax_class` DISABLE KEYS */;
INSERT INTO `mag_tax_class` VALUES (2,'Taxable Goods','PRODUCT'),(3,'Retail Customer','CUSTOMER'),(4,'Shipping','PRODUCT');
/*!40000 ALTER TABLE `mag_tax_class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_tax_order_aggregated_created`
--

DROP TABLE IF EXISTS `mag_tax_order_aggregated_created`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_tax_order_aggregated_created` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `order_status` varchar(50) NOT NULL COMMENT 'Order Status',
  `percent` float DEFAULT NULL COMMENT 'Percent',
  `orders_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `tax_base_amount_sum` float DEFAULT NULL COMMENT 'Tax Base Amount Sum',
  PRIMARY KEY (`id`),
  UNIQUE KEY `DBE74197532ABC876D4C9767C397BAB3` (`period`,`store_id`,`code`,`percent`,`order_status`),
  KEY `IDX_MAG_TAX_ORDER_AGGREGATED_CREATED_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MAG_TAX_ORDER_AGGRED_CREATED_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tax Order Aggregation';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_tax_order_aggregated_created`
--

LOCK TABLES `mag_tax_order_aggregated_created` WRITE;
/*!40000 ALTER TABLE `mag_tax_order_aggregated_created` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_tax_order_aggregated_created` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_tax_order_aggregated_updated`
--

DROP TABLE IF EXISTS `mag_tax_order_aggregated_updated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_tax_order_aggregated_updated` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `period` date DEFAULT NULL COMMENT 'Period',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store Id',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `order_status` varchar(50) NOT NULL COMMENT 'Order Status',
  `percent` float DEFAULT NULL COMMENT 'Percent',
  `orders_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Orders Count',
  `tax_base_amount_sum` float DEFAULT NULL COMMENT 'Tax Base Amount Sum',
  PRIMARY KEY (`id`),
  UNIQUE KEY `532D6AEB0972F91189DB2518580CB7AD` (`period`,`store_id`,`code`,`percent`,`order_status`),
  KEY `IDX_MAG_TAX_ORDER_AGGREGATED_UPDATED_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MAG_TAX_ORDER_AGGRED_UPDATED_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Mag Tax Order Aggregated Updated';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_tax_order_aggregated_updated`
--

LOCK TABLES `mag_tax_order_aggregated_updated` WRITE;
/*!40000 ALTER TABLE `mag_tax_order_aggregated_updated` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_tax_order_aggregated_updated` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_weee_discount`
--

DROP TABLE IF EXISTS `mag_weee_discount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_weee_discount` (
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `customer_group_id` smallint(5) unsigned NOT NULL COMMENT 'Customer Group Id',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  KEY `IDX_MAG_WEEE_DISCOUNT_WEBSITE_ID` (`website_id`),
  KEY `IDX_MAG_WEEE_DISCOUNT_ENTITY_ID` (`entity_id`),
  KEY `IDX_MAG_WEEE_DISCOUNT_CUSTOMER_GROUP_ID` (`customer_group_id`),
  CONSTRAINT `FK_MAG_WEEE_DISCOUNT_CSTR_GROUP_ID_MAG_CSTR_GROUP_CSTR_GROUP_ID` FOREIGN KEY (`customer_group_id`) REFERENCES `mag_customer_group` (`customer_group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_WEEE_DISCOUNT_ENTT_ID_MAG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`entity_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_WEEE_DISCOUNT_WEBSITE_ID_MAG_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `mag_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Weee Discount';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_weee_discount`
--

LOCK TABLES `mag_weee_discount` WRITE;
/*!40000 ALTER TABLE `mag_weee_discount` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_weee_discount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_weee_tax`
--

DROP TABLE IF EXISTS `mag_weee_tax`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_weee_tax` (
  `value_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Value Id',
  `website_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Website Id',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity Id',
  `country` varchar(2) DEFAULT NULL COMMENT 'Country',
  `value` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT 'Value',
  `state` varchar(255) NOT NULL DEFAULT '*' COMMENT 'State',
  `attribute_id` smallint(5) unsigned NOT NULL COMMENT 'Attribute Id',
  `entity_type_id` smallint(5) unsigned NOT NULL COMMENT 'Entity Type Id',
  PRIMARY KEY (`value_id`),
  KEY `IDX_MAG_WEEE_TAX_WEBSITE_ID` (`website_id`),
  KEY `IDX_MAG_WEEE_TAX_ENTITY_ID` (`entity_id`),
  KEY `IDX_MAG_WEEE_TAX_COUNTRY` (`country`),
  KEY `IDX_MAG_WEEE_TAX_ATTRIBUTE_ID` (`attribute_id`),
  CONSTRAINT `FK_MAG_WEEE_TAX_ATTRIBUTE_ID_MAG_EAV_ATTRIBUTE_ATTRIBUTE_ID` FOREIGN KEY (`attribute_id`) REFERENCES `mag_eav_attribute` (`attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_WEEE_TAX_COUNTRY_MAG_DIRECTORY_COUNTRY_COUNTRY_ID` FOREIGN KEY (`country`) REFERENCES `mag_directory_country` (`country_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_WEEE_TAX_ENTITY_ID_MAG_CATALOG_PRODUCT_ENTITY_ENTITY_ID` FOREIGN KEY (`entity_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_WEEE_TAX_WEBSITE_ID_MAG_CORE_WEBSITE_WEBSITE_ID` FOREIGN KEY (`website_id`) REFERENCES `mag_core_website` (`website_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Weee Tax';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_weee_tax`
--

LOCK TABLES `mag_weee_tax` WRITE;
/*!40000 ALTER TABLE `mag_weee_tax` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_weee_tax` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_widget`
--

DROP TABLE IF EXISTS `mag_widget`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_widget` (
  `widget_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Widget Id',
  `widget_code` varchar(255) DEFAULT NULL COMMENT 'Widget code for template directive',
  `widget_type` varchar(255) DEFAULT NULL COMMENT 'Widget Type',
  `parameters` text COMMENT 'Parameters',
  PRIMARY KEY (`widget_id`),
  KEY `IDX_MAG_WIDGET_WIDGET_CODE` (`widget_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Preconfigured Widgets';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_widget`
--

LOCK TABLES `mag_widget` WRITE;
/*!40000 ALTER TABLE `mag_widget` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_widget` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_widget_instance`
--

DROP TABLE IF EXISTS `mag_widget_instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_widget_instance` (
  `instance_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Instance Id',
  `instance_type` varchar(255) DEFAULT NULL COMMENT 'Instance Type',
  `package_theme` varchar(255) DEFAULT NULL COMMENT 'Package Theme',
  `title` varchar(255) DEFAULT NULL COMMENT 'Widget Title',
  `store_ids` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Store ids',
  `widget_parameters` text COMMENT 'Widget parameters',
  `sort_order` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Sort order',
  PRIMARY KEY (`instance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Instances of Widget for Package Theme';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_widget_instance`
--

LOCK TABLES `mag_widget_instance` WRITE;
/*!40000 ALTER TABLE `mag_widget_instance` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_widget_instance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_widget_instance_page`
--

DROP TABLE IF EXISTS `mag_widget_instance_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_widget_instance_page` (
  `page_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Page Id',
  `instance_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Instance Id',
  `page_group` varchar(25) DEFAULT NULL COMMENT 'Block Group Type',
  `layout_handle` varchar(255) DEFAULT NULL COMMENT 'Layout Handle',
  `block_reference` varchar(255) DEFAULT NULL COMMENT 'Block Reference',
  `page_for` varchar(25) DEFAULT NULL COMMENT 'For instance entities',
  `entities` text COMMENT 'Catalog entities (comma separated)',
  `page_template` varchar(255) DEFAULT NULL COMMENT 'Path to widget template',
  PRIMARY KEY (`page_id`),
  KEY `IDX_MAG_WIDGET_INSTANCE_PAGE_INSTANCE_ID` (`instance_id`),
  CONSTRAINT `FK_AAF241D7F1989EA659553716A071D537` FOREIGN KEY (`instance_id`) REFERENCES `mag_widget_instance` (`instance_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Instance of Widget on Page';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_widget_instance_page`
--

LOCK TABLES `mag_widget_instance_page` WRITE;
/*!40000 ALTER TABLE `mag_widget_instance_page` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_widget_instance_page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_widget_instance_page_layout`
--

DROP TABLE IF EXISTS `mag_widget_instance_page_layout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_widget_instance_page_layout` (
  `page_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Page Id',
  `layout_update_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Layout Update Id',
  UNIQUE KEY `UNQ_MAG_WIDGET_INSTANCE_PAGE_LAYOUT_LAYOUT_UPDATE_ID_PAGE_ID` (`layout_update_id`,`page_id`),
  KEY `IDX_MAG_WIDGET_INSTANCE_PAGE_LAYOUT_PAGE_ID` (`page_id`),
  KEY `IDX_MAG_WIDGET_INSTANCE_PAGE_LAYOUT_LAYOUT_UPDATE_ID` (`layout_update_id`),
  CONSTRAINT `FK_44FB869770F955E4DE0F6369373F1998` FOREIGN KEY (`layout_update_id`) REFERENCES `mag_core_layout_update` (`layout_update_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_621288E51A169FD8D4F9D9C81ADBA335` FOREIGN KEY (`page_id`) REFERENCES `mag_widget_instance_page` (`page_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Layout updates';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_widget_instance_page_layout`
--

LOCK TABLES `mag_widget_instance_page_layout` WRITE;
/*!40000 ALTER TABLE `mag_widget_instance_page_layout` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_widget_instance_page_layout` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_wishlist`
--

DROP TABLE IF EXISTS `mag_wishlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_wishlist` (
  `wishlist_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Wishlist ID',
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Customer ID',
  `shared` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Sharing flag (0 or 1)',
  `sharing_code` varchar(32) DEFAULT NULL COMMENT 'Sharing encrypted code',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'Last updated date',
  PRIMARY KEY (`wishlist_id`),
  UNIQUE KEY `UNQ_MAG_WISHLIST_CUSTOMER_ID` (`customer_id`),
  KEY `IDX_MAG_WISHLIST_SHARED` (`shared`),
  CONSTRAINT `FK_MAG_WISHLIST_CUSTOMER_ID_MAG_CUSTOMER_ENTITY_ENTITY_ID` FOREIGN KEY (`customer_id`) REFERENCES `mag_customer_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Wishlist main Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_wishlist`
--

LOCK TABLES `mag_wishlist` WRITE;
/*!40000 ALTER TABLE `mag_wishlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_wishlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_wishlist_item`
--

DROP TABLE IF EXISTS `mag_wishlist_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_wishlist_item` (
  `wishlist_item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Wishlist item ID',
  `wishlist_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Wishlist ID',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Product ID',
  `store_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Store ID',
  `added_at` timestamp NULL DEFAULT NULL COMMENT 'Add date and time',
  `description` text COMMENT 'Short description of wish list item',
  `qty` decimal(12,4) NOT NULL COMMENT 'Qty',
  PRIMARY KEY (`wishlist_item_id`),
  KEY `IDX_MAG_WISHLIST_ITEM_WISHLIST_ID` (`wishlist_id`),
  KEY `IDX_MAG_WISHLIST_ITEM_PRODUCT_ID` (`product_id`),
  KEY `IDX_MAG_WISHLIST_ITEM_STORE_ID` (`store_id`),
  CONSTRAINT `FK_MAG_WISHLIST_ITEM_PRD_ID_MAG_CAT_PRD_ENTT_ENTT_ID` FOREIGN KEY (`product_id`) REFERENCES `mag_catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_WISHLIST_ITEM_STORE_ID_MAG_CORE_STORE_STORE_ID` FOREIGN KEY (`store_id`) REFERENCES `mag_core_store` (`store_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_MAG_WISHLIST_ITEM_WISHLIST_ID_MAG_WISHLIST_WISHLIST_ID` FOREIGN KEY (`wishlist_id`) REFERENCES `mag_wishlist` (`wishlist_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Wishlist items';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_wishlist_item`
--

LOCK TABLES `mag_wishlist_item` WRITE;
/*!40000 ALTER TABLE `mag_wishlist_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_wishlist_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mag_wishlist_item_option`
--

DROP TABLE IF EXISTS `mag_wishlist_item_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mag_wishlist_item_option` (
  `option_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Option Id',
  `wishlist_item_id` int(10) unsigned NOT NULL COMMENT 'Wishlist Item Id',
  `product_id` int(10) unsigned NOT NULL COMMENT 'Product Id',
  `code` varchar(255) NOT NULL COMMENT 'Code',
  `value` text COMMENT 'Value',
  PRIMARY KEY (`option_id`),
  KEY `FK_27BE17FF030FB5795234A0DABA120736` (`wishlist_item_id`),
  CONSTRAINT `FK_27BE17FF030FB5795234A0DABA120736` FOREIGN KEY (`wishlist_item_id`) REFERENCES `mag_wishlist_item` (`wishlist_item_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Wishlist Item Option Table';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mag_wishlist_item_option`
--

LOCK TABLES `mag_wishlist_item_option` WRITE;
/*!40000 ALTER TABLE `mag_wishlist_item_option` DISABLE KEYS */;
/*!40000 ALTER TABLE `mag_wishlist_item_option` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-02-19 19:45:13
