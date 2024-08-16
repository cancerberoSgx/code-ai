-- this is a complex db schema and the following is a code-ai prompt to generate a complex SQL query:

-- @code-ai create sql query that returns users which lastConnection is in the last 5 minutes and their photos of album 1



-- MySQL dump 10.13  Distrib 8.3.0, for macos14.2 (arm64)
--
-- Host: 127.0.0.1    Database: serengeti
-- ------------------------------------------------------
-- Server version	5.7.44

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
-- Table structure for table `activePlaces`
--

DROP TABLE IF EXISTS `activePlaces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activePlaces` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `name` text NOT NULL,
  `center` point NOT NULL,
  `radius` int(11) DEFAULT '160934',
  `status` int(11) DEFAULT '1',
  `defaultBatchSize` int(11) NOT NULL DEFAULT '15',
  `biggerBatchSize` int(11) NOT NULL DEFAULT '30',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

UNLOCK TABLES;

--
-- Table structure for table `albums`
--

DROP TABLE IF EXISTS `albums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `albums` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userId` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `public` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `albums_id_userId_index` (`id`,`userId`),
  KEY `albums_userId_index` (`userId`),
  CONSTRAINT `albumsUserId_usersUserId_FK` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1000 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `applicationSettings`
--

DROP TABLE IF EXISTS `applicationSettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `applicationSettings` (
  `id` bigint(20) NOT NULL,
  `value` varchar(1500) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `batches`
--

DROP TABLE IF EXISTS `batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `batches` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `userId` varchar(255) NOT NULL COMMENT 'batch owner',
  `suggestedId` varchar(255) NOT NULL COMMENT 'suggested user',
  `startTime` datetime NOT NULL COMMENT 'time when this batch starts',
  `suggestionSource` int(11) NOT NULL COMMENT 'who created this suggestion admin, algorithm, etc',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `manualReason` varchar(500) DEFAULT NULL,
  `manualNote` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `suggestedId` (`suggestedId`),
  CONSTRAINT `batches_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `profile` (`userId`) ON DELETE CASCADE,
  CONSTRAINT `batches_ibfk_2` FOREIGN KEY (`suggestedId`) REFERENCES `profile` (`userId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `blocks`
--

DROP TABLE IF EXISTS `blocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blocks` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userId` varchar(255) NOT NULL,
  `blocked` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `blocks_blocker_blocked_index` (`userId`,`blocked`),
  KEY `blocks_blocker_index` (`userId`),
  KEY `blocks_blocked_index` (`blocked`),
  CONSTRAINT `blocksBlocked_usersUserId_FK` FOREIGN KEY (`blocked`) REFERENCES `users` (`userId`) ON DELETE CASCADE,
  CONSTRAINT `blocksUserId_usersUserId_FK` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `configuration`
--

DROP TABLE IF EXISTS `configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `configuration` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `confVersion` varchar(255) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `iosMinimalVersion` varchar(255) NOT NULL,
  `androidMinimalVersion` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `debugLogs`
--

DROP TABLE IF EXISTS `debugLogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `debugLogs` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation time',
  `userId1` varchar(255) DEFAULT NULL,
  `userId2` varchar(255) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `favorites`
--

DROP TABLE IF EXISTS `favorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favorites` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userId` varchar(255) NOT NULL,
  `favoriteId` varchar(255) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `favoritesUserId_usersUserId_FK` (`userId`),
  KEY `favoritesFavoriteId_usersUserId_FK` (`favoriteId`),
  CONSTRAINT `favoritesFavoriteId_usersUserId_FK` FOREIGN KEY (`favoriteId`) REFERENCES `users` (`userId`) ON DELETE CASCADE,
  CONSTRAINT `favoritesUserId_usersUserId_FK` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hidden`
--

DROP TABLE IF EXISTS `hidden`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hidden` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userId` varchar(255) NOT NULL,
  `hiddenId` varchar(255) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hidden_userId_hiddenId_index` (`userId`,`hiddenId`),
  KEY `hidden_userId_index` (`userId`),
  KEY `hidden_hiddenId_index` (`hiddenId`),
  CONSTRAINT `hiddenHiddenId_usersUserId_FK` FOREIGN KEY (`hiddenId`) REFERENCES `users` (`userId`) ON DELETE CASCADE,
  CONSTRAINT `hiddenUserId_usersUserId_FK` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `images` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userId` varchar(255) NOT NULL,
  `pos` int(11) NOT NULL,
  `url` varchar(255) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '2',
  PRIMARY KEY (`id`),
  UNIQUE KEY `images_userId_pos_index` (`userId`,`pos`),
  KEY `images_userId_index` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `manualSuggestions`
--

DROP TABLE IF EXISTS `manualSuggestions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `manualSuggestions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` varchar(500) NOT NULL,
  `suggestedUserId` varchar(500) NOT NULL,
  `reason` varchar(500) NOT NULL,
  `suggestionNote` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `expirationDate` datetime NOT NULL,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `manualSuggestions_unique_key` (`userId`,`suggestedUserId`),
  KEY `suggestedUserId` (`suggestedUserId`),
  KEY `manualSuggestions_expirationDate_index` (`expirationDate`),
  CONSTRAINT `manualSuggestions_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE CASCADE,
  CONSTRAINT `manualSuggestions_ibfk_2` FOREIGN KEY (`suggestedUserId`) REFERENCES `users` (`userId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `media` (
  `id` varchar(255) NOT NULL,
  `userId` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `url` varchar(2048) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `uploadedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `takenAt` timestamp NULL DEFAULT NULL,
  `source` int(11) NOT NULL DEFAULT '0',
  `cameraRollAlbumName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`,`userId`),
  UNIQUE KEY `media_id_userId_index` (`id`,`userId`),
  KEY `media_userId_index` (`userId`),
  CONSTRAINT `mediaUserId_usersUserId_FK` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mediaAlbums`
--

DROP TABLE IF EXISTS `mediaAlbums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mediaAlbums` (
  `mediaId` varchar(255) NOT NULL,
  `userId` varchar(255) NOT NULL,
  `albumId` bigint(20) NOT NULL,
  `pos` int(11) NOT NULL,
  `lastUsage` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mediaAlbums_mediaId_userId_albumId` (`mediaId`,`userId`,`albumId`),
  KEY `mediaAlbumsAlbumId_albumsId_FK` (`albumId`),
  KEY `mediaAlbumsUserId` (`userId`),
  CONSTRAINT `mediaAlbumsAlbumId_albumsId_FK` FOREIGN KEY (`albumId`) REFERENCES `albums` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mediaAlbumsMediaIdUserId_mediaIdUserId_FK` FOREIGN KEY (`mediaId`, `userId`) REFERENCES `media` (`id`, `userId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mediaPermissions`
--

DROP TABLE IF EXISTS `mediaPermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mediaPermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `mediaAlbumId` int(11) NOT NULL,
  `targetUserId` varchar(255) NOT NULL,
  `permission` int(11) DEFAULT '0',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mediaPermissions_mediaAlbumId_targetUserId` (`mediaAlbumId`,`targetUserId`),
  KEY `targetUserId` (`targetUserId`),
  CONSTRAINT `mediaPermissions_ibfk_1` FOREIGN KEY (`mediaAlbumId`) REFERENCES `mediaAlbums` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mediaPermissions_ibfk_2` FOREIGN KEY (`targetUserId`) REFERENCES `users` (`userId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `run_on` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=146 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `moderationHistory`
--

DROP TABLE IF EXISTS `moderationHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `moderationHistory` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mediaId` varchar(255) NOT NULL,
  `moderatorId` int(11) NOT NULL,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` int(11) NOT NULL,
  `rawScore` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `moderationHistoryMediaId_mediaId_FK` (`mediaId`),
  CONSTRAINT `moderationHistoryMediaId_mediaId_FK` FOREIGN KEY (`mediaId`) REFERENCES `media` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `moderationHistoryReasons`
--

DROP TABLE IF EXISTS `moderationHistoryReasons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `moderationHistoryReasons` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `moderationHistoryId` bigint(20) NOT NULL,
  `rejectionReasonId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `moderationHistoryReasons_moderationHistoryId_FK` (`moderationHistoryId`),
  CONSTRAINT `moderationHistoryReasons_moderationHistoryId_FK` FOREIGN KEY (`moderationHistoryId`) REFERENCES `moderationHistory` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `profile`
--

DROP TABLE IF EXISTS `profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profile` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userId` varchar(255) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `about` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `birthDate` datetime NOT NULL,
  `lastConnection` timestamp NULL DEFAULT NULL,
  `location` point DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `hivStatus` varchar(255) DEFAULT NULL,
  `cigarettes` varchar(255) DEFAULT NULL,
  `twitter` varchar(255) DEFAULT NULL,
  `snapChat` varchar(255) DEFAULT NULL,
  `tikTok` varchar(255) DEFAULT NULL,
  `visiting` tinyint(1) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '3',
  `neighborhood` varchar(255) DEFAULT NULL,
  `lastHivTest` timestamp NULL DEFAULT NULL,
  `lastStiTest` timestamp NULL DEFAULT NULL,
  `covidStatus` int(11) DEFAULT NULL,
  `sexualHealthPractices` int(11) DEFAULT NULL,
  `currentIntentionWhen` int(11) DEFAULT NULL,
  `currentIntentionWhere` int(11) DEFAULT NULL,
  `currentIntentionFreeForm` text CHARACTER SET utf8mb4,
  `isComplete` tinyint(1) DEFAULT '1',
  `forceLocation` tinyint(1) DEFAULT '0',
  `contactEmail` varchar(255) DEFAULT NULL,
  `batchSize` int(11) DEFAULT '5',
  `ethnicity` bigint(20) DEFAULT NULL,
  `ethnicityAdmin` bigint(20) DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  `heightPreferenceMin` int(11) NOT NULL DEFAULT '35',
  `heightPreferenceMax` int(11) NOT NULL DEFAULT '96',
  `agePreferenceMin` int(11) NOT NULL DEFAULT '18',
  `agePreferenceMax` int(11) NOT NULL DEFAULT '100',
  `monkeyPox` int(11) DEFAULT NULL,
  `yesScore` float DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `blurPrivateContent` tinyint(1) NOT NULL DEFAULT '1',
  `selfSourceAttribution` int(11) DEFAULT NULL,
  `selfSourceAttributionDescription` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `viewApprovedProfileMessage` tinyint(1) NOT NULL DEFAULT '0',
  `locationSharingSettings` int(11) DEFAULT NULL,
  `newUserBoost` int(11) NOT NULL DEFAULT '0',
  `roomLocationSharingSettings` int(11) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userId` (`userId`),
  KEY `ethnicity_tag_FK` (`ethnicity`),
  KEY `ethnicityAdmin_tag_FK` (`ethnicityAdmin`),
  KEY `profile_idx_status_iscomplete_userid` (`status`,`isComplete`,`userId`),
  CONSTRAINT `ethnicityAdmin_tag_FK` FOREIGN KEY (`ethnicityAdmin`) REFERENCES `tags` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `ethnicity_tag_FK` FOREIGN KEY (`ethnicity`) REFERENCES `tags` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `profileUserId_usersUserId_FK` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `profileHistory`
--

DROP TABLE IF EXISTS `profileHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profileHistory` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userid` varchar(255) NOT NULL,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `field` varchar(255) NOT NULL,
  `oldValue` varchar(255) DEFAULT NULL,
  `newValue` varchar(255) DEFAULT NULL,
  `changerId` varchar(255) NOT NULL,
  `changerType` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `profileHistoryUserId_userId_FK` (`userid`),
  KEY `profilehistory_idx_field_newvalue_userid` (`field`,`newValue`,`userid`),
  CONSTRAINT `profileHistoryUserId_userId_FK` FOREIGN KEY (`userid`) REFERENCES `users` (`userId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_reasons`
--

DROP TABLE IF EXISTS `report_reasons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `report_reasons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `reviewerId` varchar(255) NOT NULL COMMENT 'user who made the review',
  `reviewedId` varchar(255) NOT NULL COMMENT 'user who was reviewed',
  `reviewType` int(11) NOT NULL COMMENT 'like, dislike',
  `reviewable` int(11) DEFAULT NULL COMMENT 'reaction: profile photo, instagram photo, tag, etc',
  `reviewText` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'reaction text',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `source` int(11) NOT NULL DEFAULT '1',
  `suggestionReason` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reviewedId` (`reviewedId`),
  KEY `reviews_idx_reviewerid_reviewedid` (`reviewerId`,`reviewedId`),
  KEY `reviewsCreatedAt` (`createdAt`),
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`reviewerId`) REFERENCES `profile` (`userId`) ON DELETE CASCADE,
  CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`reviewedId`) REFERENCES `profile` (`userId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `roomPreferenceOptions`
--

DROP TABLE IF EXISTS `roomPreferenceOptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roomPreferenceOptions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `roomRules`
--

DROP TABLE IF EXISTS `roomRules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roomRules` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(1000) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `rule` json NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `roomTypes`
--

DROP TABLE IF EXISTS `roomTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roomTypes` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(500) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `schema` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `roomRuleId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `roomTypes_roomRules_id_fk` (`roomRuleId`),
  CONSTRAINT `roomTypes_roomRules_id_fk` FOREIGN KEY (`roomRuleId`) REFERENCES `roomRules` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `roomUserPreferences`
--

DROP TABLE IF EXISTS `roomUserPreferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roomUserPreferences` (
  `roomTypeId` bigint(20) NOT NULL,
  `userId` varchar(500) NOT NULL,
  `preferences` json DEFAULT NULL,
  PRIMARY KEY (`roomTypeId`,`userId`),
  KEY `roomUserPreferences_profile_id_fk` (`userId`),
  CONSTRAINT `roomUserPreferences_profile_id_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE CASCADE,
  CONSTRAINT `roomUserPreferences_roomTypes_id_fk` FOREIGN KEY (`roomTypeId`) REFERENCES `roomTypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rooms`
--

DROP TABLE IF EXISTS `rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rooms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `type` int(11) NOT NULL,
  `name` varchar(500) NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `startDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `showDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `endDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `cleaned` tinyint(1) DEFAULT '0',
  `activePlaceId` int(11) DEFAULT NULL,
  `meetupStartDate` timestamp NULL DEFAULT NULL,
  `meetupEndDate` timestamp NULL DEFAULT NULL,
  `center` point DEFAULT NULL,
  `radius` int(11) DEFAULT NULL,
  `invitedUsers` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `activePlaceId` (`activePlaceId`),
  KEY `idx_rooms_startsDate` (`startDate`),
  KEY `idx_rooms_startsShowingDate` (`showDate`),
  KEY `idx_rooms_endsDate` (`endDate`),
  CONSTRAINT `rooms_ibfk_1` FOREIGN KEY (`activePlaceId`) REFERENCES `activePlaces` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tagCategories`
--

DROP TABLE IF EXISTS `tagCategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tagCategories` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tagSuggestions`
--

DROP TABLE IF EXISTS `tagSuggestions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tagSuggestions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `profileFieldId` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `tagId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tagSuggestions_profileFieldId` (`profileFieldId`),
  KEY `tagSuggestions_tagId` (`tagId`),
  CONSTRAINT `tagSuggestions_tagId` FOREIGN KEY (`tagId`) REFERENCES `tags` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tags` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `profileFieldId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `verified` tinyint(1) NOT NULL DEFAULT '0',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `categoryId` bigint(20) NOT NULL DEFAULT '1',
  `index` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tags_profileFieldId_name_index` (`profileFieldId`,`name`),
  KEY `tagsCategoryId_tagCaegoryId_FK` (`categoryId`),
  CONSTRAINT `tagsCategoryId_tagCaegoryId_FK` FOREIGN KEY (`categoryId`) REFERENCES `tagCategories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10000 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userNotificationsAux`
--

DROP TABLE IF EXISTS `userNotificationsAux`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userNotificationsAux` (
  `userId` varchar(255) NOT NULL,
  `type` enum('add-private-image','add-profile-image') NOT NULL,
  `resourceId` varchar(255) NOT NULL COMMENT 'resource identifier, like media.id',
  `eventCount` int(11) NOT NULL DEFAULT '1' COMMENT 'how many event ocurred for this user',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `userNotificationsAux_unique_key` (`userId`,`type`),
  CONSTRAINT `userNotificationsAux_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userSettings`
--

DROP TABLE IF EXISTS `userSettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userSettings` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userId` varchar(255) NOT NULL,
  `newBatchNotification` tinyint(1) NOT NULL DEFAULT '1',
  `messagesNotification` tinyint(1) NOT NULL DEFAULT '1',
  `newPrivatePhotosNotification` tinyint(1) NOT NULL DEFAULT '1',
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `userSettings_userId_unique` (`userId`),
  CONSTRAINT `userSettingsUserId_userId_FK` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `userId` varchar(255) NOT NULL,
  `birthDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `privacyPolicy` timestamp NULL DEFAULT NULL,
  `termsAndConditions` timestamp NULL DEFAULT NULL,
  `fcmToken` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL DEFAULT '',
  `providers` varchar(255) NOT NULL DEFAULT '',
  `creationTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `instagramStatus` int(11) NOT NULL DEFAULT '0',
  `instagramName` varchar(255) DEFAULT NULL,
  `signUpLocation` point DEFAULT NULL,
  `signUpCountry` varchar(255) DEFAULT NULL,
  `signUpState` varchar(255) DEFAULT NULL,
  `signUpCity` varchar(255) DEFAULT NULL,
  `signUpPostalCode` varchar(255) DEFAULT NULL,
  `instagramToken` varchar(255) DEFAULT NULL,
  `instagramTokenExpiration` timestamp NULL DEFAULT NULL,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deviceNotificationsEnabled` tinyint(1) NOT NULL DEFAULT '0',
  `appNotificationsEnabled` tinyint(1) NOT NULL DEFAULT '0',
  `homeLocation` point DEFAULT NULL,
  `homeNeighborhood` varchar(255) DEFAULT NULL,
  `homeCity` varchar(255) DEFAULT NULL,
  `homeCountry` varchar(255) DEFAULT NULL,
  `homeState` varchar(255) DEFAULT NULL,
  `homePostalCode` varchar(255) DEFAULT NULL,
  `referralId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `referredBy` varchar(255) DEFAULT NULL,
  `maxReferrals` int(11) DEFAULT '3',
  PRIMARY KEY (`userId`),
  KEY `referralId` (`referralId`),
  KEY `users_referredBy_userId` (`referredBy`),
  CONSTRAINT `users_referredBy_userId` FOREIGN KEY (`referredBy`) REFERENCES `users` (`userId`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usersFeatures`
--

DROP TABLE IF EXISTS `usersFeatures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usersFeatures` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `userId` varchar(255) NOT NULL COMMENT 'User who has permissions to a feature',
  `preventScreenshots` int(11) NOT NULL DEFAULT '1' COMMENT 'has the user the no-screenshot feature enabled?',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `usersResourcePermissionsUnique` (`userId`),
  CONSTRAINT `usersFeatures_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usersResourcePermissions`
--

DROP TABLE IF EXISTS `usersResourcePermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usersResourcePermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `userId` varchar(255) NOT NULL COMMENT 'Resource owner',
  `targetUserId` varchar(255) NOT NULL COMMENT 'User who has access',
  `resource` int(11) NOT NULL DEFAULT '1' COMMENT 'Permission resource, for example privateImages=1. See type UserResources',
  `permission` int(11) DEFAULT '1' COMMENT 'Permission action, 0 is default action (view). See type UserResourcesPermissionType',
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `usersResourcePermissionsUnique` (`userId`,`targetUserId`,`resource`,`permission`),
  KEY `targetUserId` (`targetUserId`),
  CONSTRAINT `usersResourcePermissions_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE CASCADE,
  CONSTRAINT `usersResourcePermissions_ibfk_2` FOREIGN KEY (`targetUserId`) REFERENCES `users` (`userId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usersRoomsEvents`
--

DROP TABLE IF EXISTS `usersRoomsEvents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usersRoomsEvents` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `userId` varchar(255) DEFAULT NULL,
  `roomId` int(11) DEFAULT NULL,
  `type` int(11) NOT NULL DEFAULT '1',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `usersRoomsEvents_roomId` (`roomId`),
  CONSTRAINT `usersRoomsEvents_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usersTags`
--

DROP TABLE IF EXISTS `usersTags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usersTags` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userId` varchar(255) NOT NULL,
  `tagId` bigint(20) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `position` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `userTagsTagId_tagsId_FK` (`tagId`),
  KEY `userstags_idx_userid_tagid` (`userId`,`tagId`),
  CONSTRAINT `userTagsTagId_tagsId_FK` FOREIGN KEY (`tagId`) REFERENCES `tags` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userTagsUserId_usersUserId_FK` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;





