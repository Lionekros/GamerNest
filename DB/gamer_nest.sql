-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 14, 2023 at 08:38 PM
-- Server version: 8.0.31
-- PHP Version: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gamer_nest`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateArticle` (IN `pHeadline` VARCHAR(255), IN `pSummary` TEXT, IN `pBody` MEDIUMTEXT, IN `pCover` VARCHAR(255), IN `pIsPublished` TINYINT, IN `pCreatedDate` VARCHAR(19), IN `pUpdatedDate` VARCHAR(19), IN `pIdAuthor` INT, IN `pLanguage` CHAR(3), IN `pIdGame` TEXT)   BEGIN
  -- Drop the temporary table if it already exists
  DROP TEMPORARY TABLE IF EXISTS temp_game_ids;
  
  -- Create a temporary table to store the list of game ids
  CREATE TEMPORARY TABLE temp_game_ids (
    id INT NOT NULL
  );
  
  -- Insert the game ids into the temporary table
  SET @sql = CONCAT('INSERT INTO temp_game_ids (id) VALUES (', REPLACE(pIdGame, ',', '), ('), ')');
  PREPARE stmt FROM @sql;
  EXECUTE stmt;
  
  -- Insert the article into the article table
  INSERT INTO article(headline, summary, body, cover, isPublished, createdDate, updatedDate, idAuthor, language)
  VALUES (pHeadline, pSummary, pBody, pCover, pIsPublished, pCreatedDate, pUpdatedDate, pIdAuthor, pLanguage);
  
  -- Get the id of the newly inserted article
  SET @article_id = LAST_INSERT_ID();
  
  -- Insert the game-article associations into the game_article table
  INSERT INTO game_article(idArticle, idGame)
  SELECT @article_id, id
  FROM temp_game_ids;
  
  -- Drop the temporary table
  DROP TEMPORARY TABLE IF EXISTS temp_game_ids;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateAuthor` (IN `pName` VARCHAR(45), IN `pFirstLastName` VARCHAR(45), IN `pSecondLastName` VARCHAR(45), IN `pPassword` VARCHAR(255), IN `pEmail` VARCHAR(255), IN `pPhone` VARCHAR(20), IN `pDescription` TEXT, IN `pAvatar` VARCHAR(255), IN `pPreferedLanguage` CHAR(3), IN `pIsAdmin` TINYINT, IN `pCanPublish` TINYINT, IN `pIsActive` TINYINT, IN `pBirthday` VARCHAR(10), IN `pStartDate` VARCHAR(10), IN `pEndDate` VARCHAR(10))   BEGIN
    INSERT INTO `author` (
        `name`,
        `firstLastName`,
        `secondLastName`,
        `password`,
        `email`,
        `phone`,
        `description`,
        `avatar`,
        `preferedLanguage`,
        `isAdmin`,
        `canPublish`,
        `isActive`,
        `birthday`,
        `startDate`,
        `endDate`
    )
    VALUES (
        pName,
        pFirstLastName,
        pSecondLastName,
        pPassword,
        pEmail,
        pPhone,
        pDescription,
        pAvatar,
        pPreferedLanguage,
        pIsAdmin,
        pCanPublish,
        pIsActive,
        pBirthday,
        pStartDate,
        pEndDate
    );
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateCategory` (IN `pName` VARCHAR(255))   BEGIN
    INSERT INTO `category` (`name`) VALUES (pName);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateDev` (IN `pName` VARCHAR(45))   BEGIN
  INSERT INTO `dev` (`name`)
  VALUES (pName);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateGenre` (IN `pName` VARCHAR(45), IN `pLanguage` CHAR(3))   BEGIN
  INSERT INTO `genre` (`name`, `language`)
  VALUES (pName, pLanguage);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateLanguage` (IN `pName` VARCHAR(45), IN `pLanguage` CHAR(3))   BEGIN
  INSERT INTO `language` (`name`, `language`)
  VALUES (pName, pLanguage);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CreatePlatform` (IN `pName` VARCHAR(45), IN `pIcon` VARCHAR(255))   BEGIN
  INSERT INTO `platform` (`name`, `icon`)
  VALUES (pName, pIcon);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CreatePlayerType` (IN `pName` VARCHAR(45), IN `pLanguage` CHAR(3))   BEGIN
  INSERT INTO `player_type` (`name`, `language`)
  VALUES (pName, pLanguage);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CreatePublisher` (IN `pName` VARCHAR(45))   BEGIN
  INSERT INTO `publisher` (`name`)
  VALUES (pName);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateUser` (IN `pUsername` VARCHAR(45), IN `pPassword` VARCHAR(255), IN `pEmail` VARCHAR(255), IN `pAvatar` VARCHAR(255), IN `pPreferedLanguage` CHAR(3), IN `pBirthday` VARCHAR(10), IN `pCreationDate` VARCHAR(10))   BEGIN
    INSERT INTO `user` (
        `username`,
        `password`,
        `email`,
        `avatar`,
        `preferedLanguage`,
        `birthday`,
        `creationDate`
    ) VALUES (
        pUsername,
        pPassword,
        pEmail,
        pAvatar,
        pPreferedLanguage,
        pBirthday,
        pCreationDate
    );
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateWebLanguage` (IN `pId` CHAR(3), IN `pName` VARCHAR(255), IN `pIcon` VARCHAR(255))   BEGIN
  INSERT INTO web_language(id, name, icon)
  VALUES(pId, pName, pIcon);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateWebText` (IN `pTitle` VARCHAR(255), IN `pText` TEXT, IN `pIdCategory` INT, IN `pLanguage` CHAR(3))   BEGIN
  INSERT INTO `web_text` (`title`, `text`, `idCategory`, `language`)
  VALUES (pTitle, pText, pIdCategory, pLanguage);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteArticle` (IN `pId` BIGINT)   BEGIN
  DELETE FROM game_article WHERE idArticle = pId;
  DELETE FROM article WHERE id = pId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteAuthor` (IN `pId` INT)   BEGIN
    DELETE FROM `author`
    WHERE `id` = pId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteCategory` (IN `pId` INT)   BEGIN
    DELETE FROM `category` WHERE `id` = pId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteDev` (IN `pId` INT)   BEGIN
  DELETE FROM `dev`
  WHERE `id` = pId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteGenre` (IN `pId` INT)   BEGIN
  DELETE FROM `genre`
  WHERE `id` = pId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteLanguage` (IN `pId` INT)   BEGIN
  DELETE FROM `language`
  WHERE `id` = pId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeletePlatform` (IN `pId` INT)   BEGIN
  DELETE FROM `platform`
  WHERE `id` = pId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeletePlayerType` (IN `pId` INT)   BEGIN
  DELETE FROM `player_type`
  WHERE `id` = pId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeletePublisher` (IN `pId` INT)   BEGIN
  DELETE FROM `publisher`
  WHERE `id` = pId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteUser` (IN `pId` BIGINT)   BEGIN
    DELETE FROM `user`
    WHERE `id` = pId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteWebLanguage` (IN `pId` CHAR(3))   BEGIN
  DELETE FROM web_language
  WHERE id = pId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteWebText` (IN `pId` INT)   BEGIN
  DELETE FROM `web_text`
  WHERE `id` = pId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateArticle` (IN `pId` BIGINT, IN `pHeadline` VARCHAR(255), IN `pSummary` TEXT, IN `pBody` MEDIUMTEXT, IN `pCover` VARCHAR(255), IN `pIsPublished` TINYINT, IN `pCreatedDate` VARCHAR(19), IN `pUpdatedDate` VARCHAR(19), IN `pIdAuthor` INT, IN `pLanguage` CHAR(3), IN `pIdGame` TEXT)   BEGIN
  
  -- Update the article in the article table
  UPDATE article
  SET 
    headline = pHeadline,
    summary = pSummary,
    body = pBody,
    isPublished = pIsPublished,
    createdDate = pCreatedDate,
    updatedDate = pUpdatedDate,
    idAuthor = pIdAuthor,
    language = pLanguage,
     `cover` = IFNULL(NULLIF(pCover, ''), `cover`)
  WHERE id = pId;
  
  -- Delete all game-article associations for the given article
  DELETE FROM game_article WHERE idArticle = pId;
  
  -- Drop the temporary table if it already exists
  DROP TEMPORARY TABLE IF EXISTS temp_game_ids;
  
  -- Create a temporary table to store the list of game ids
  CREATE TEMPORARY TABLE temp_game_ids (
    id INT NOT NULL
  );
  
  -- Insert the game ids into the temporary table
  SET @sql = CONCAT('INSERT INTO temp_game_ids (id) VALUES (', REPLACE(pIdGame, ',', '), ('), ')');
  PREPARE stmt FROM @sql;
  EXECUTE stmt;
  
  -- Insert the game-article associations into the game_article table
  INSERT INTO game_article(idArticle, idGame)
  SELECT pId, id
  FROM temp_game_ids;
  
  -- Drop the temporary table
  DROP TEMPORARY TABLE IF EXISTS temp_game_ids;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateAuthor` (IN `pId` INT, IN `pName` VARCHAR(45), IN `pFirstLastName` VARCHAR(45), IN `pSecondLastName` VARCHAR(45), IN `pPassword` VARCHAR(255), IN `pEmail` VARCHAR(255), IN `pPhone` VARCHAR(20), IN `pDescription` TEXT, IN `pAvatar` VARCHAR(255), IN `pPreferedLanguage` CHAR(3), IN `pIsAdmin` TINYINT, IN `pCanPublish` TINYINT, IN `pIsActive` TINYINT, IN `pBirthday` VARCHAR(10), IN `pStartDate` VARCHAR(10), IN `pEndDate` VARCHAR(10))   BEGIN
    UPDATE `author`
    SET
        `name` = pName,
        `firstLastName` = pFirstLastName,
        `secondLastName` = pSecondLastName,
        `password` = IFNULL(NULLIF(pPassword, ''), `password`),
        `email` = pEmail,
        `phone` = pPhone,
        `description` = pDescription,
        `avatar` = IFNULL(NULLIF(pAvatar, ''), `avatar`),
        `preferedLanguage` = pPreferedLanguage,
        `isAdmin` = pIsAdmin,
        `canPublish` = pCanPublish,
        `isActive` = pIsActive,
        `birthday` = pBirthday,
        `startDate` = pStartDate,
        `endDate` = pEndDate
    WHERE
        `id` = pId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateCategory` (IN `pId` INT, IN `pName` VARCHAR(255))   BEGIN
    UPDATE `category` SET `name` = pName WHERE `id` = pId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateDev` (IN `pId` INT, IN `pName` VARCHAR(45))   BEGIN
  UPDATE `dev`
  SET `name` = pName
  WHERE `id` = pId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateGenre` (IN `pId` INT, IN `pName` VARCHAR(45), IN `pLanguage` CHAR(3))   BEGIN
  UPDATE `genre`
  SET `name` = pName,
      `language` = pLanguage
  WHERE `id` = pId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateLanguage` (IN `pId` INT, IN `pName` VARCHAR(45), IN `pLanguage` CHAR(3))   BEGIN
  UPDATE `language`
  SET `name` = pName,
      `language` = pLanguage
  WHERE `id` = pId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdatePlatform` (IN `pId` INT, IN `pName` VARCHAR(45), IN `pIcon` VARCHAR(255))   BEGIN
  UPDATE `platform`
  SET `name` = pName,
      `icon` = pIcon
  WHERE `id` = pId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdatePlayerType` (IN `pId` INT, IN `pName` VARCHAR(45), IN `pLanguage` CHAR(3))   BEGIN
  UPDATE `player_type`
  SET `name` = pName,
      `language` = pLanguage
  WHERE `id` = pId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdatePublisher` (IN `pId` INT, IN `pName` VARCHAR(45))   BEGIN
  UPDATE `publisher`
  SET `name` = pName
  WHERE `id` = pId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateUser` (IN `pId` INT, IN `pUsername` VARCHAR(45), IN `pPassword` VARCHAR(255), IN `pEmail` VARCHAR(255), IN `pAvatar` VARCHAR(255), IN `pPreferedLanguage` CHAR(3), IN `pBirthday` VARCHAR(10), IN `pCreationDate` VARCHAR(10))   BEGIN
    UPDATE `user`
    SET
        `username` = pUsername,
        `password` = IFNULL(NULLIF(pPassword, ''), `password`),
        `email` = pEmail,
        `avatar` = IFNULL(NULLIF(pAvatar, ''), `avatar`),
        `preferedLanguage` = pPreferedLanguage,
        `birthday` = pBirthday,
        `creationDate` = pCreationDate
    WHERE
        `id` = pId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateWebLanguage` (IN `pId` CHAR(3), IN `pName` VARCHAR(255), IN `pIcon` VARCHAR(255))   BEGIN
  UPDATE web_language
  SET name = pName,
      icon = pIcon
  WHERE id = pId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateWebText` (IN `pId` INT, IN `pTitle` VARCHAR(255), IN `pText` TEXT, IN `pIdCategory` INT, IN `pLanguage` CHAR(3))   BEGIN
  UPDATE `web_text`
  SET `title` = pTitle,
      `text` = pText,
      `idCategory` = pIdCategory,
      `language` = pLanguage
  WHERE `id` = pId;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `article`
--

CREATE TABLE `article` (
  `id` bigint NOT NULL,
  `headline` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `summary` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `body` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `cover` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `isPublished` tinyint NOT NULL,
  `createdDate` varchar(19) COLLATE utf8mb3_bin NOT NULL,
  `updatedDate` varchar(19) COLLATE utf8mb3_bin DEFAULT NULL,
  `idAuthor` int NOT NULL,
  `language` char(3) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

--
-- Dumping data for table `article`
--

INSERT INTO `article` (`id`, `headline`, `summary`, `body`, `cover`, `isPublished`, `createdDate`, `updatedDate`, `idAuthor`, `language`) VALUES
(9, 'Headline1', 'Summary1', 'Body1', '/img/Cover/Article/Default.png', 0, '2023-05-12 13:04:10', NULL, 10, 'ESP'),
(10, 'Headline2', 'Summary2', 'Body2', '/img/Cover/Article/Default.png', 1, '2023-05-12 13:04:10', NULL, 12, 'ENG'),
(11, 'Headline3', 'Summary3', 'Body3', '/img/Cover/Article/Default.png', 0, '2023-05-12 13:04:10', NULL, 12, 'ESP'),
(12, 'Headline4', 'Summary4', 'Body4', '/img/Cover/Article/Default.png', 0, '2023-05-12 13:04:10', NULL, 13, 'ESP'),
(13, 'Headline5', 'Summary5', 'Body5', '/img/Cover/Article/Default.png', 1, '2023-05-12 13:04:10', NULL, 15, 'ENG'),
(14, 'Headline6', 'Summary6', 'Body6', '/img/Cover/Article/Default.png', 1, '2023-05-12 13:04:10', NULL, 16, 'ESP'),
(15, 'Headline7', 'Summary7', 'Body7', '/img/Cover/Article/Default.png', 1, '2023-05-12 13:04:10', NULL, 10, 'ESP'),
(16, 'Headline8', 'Summary8', 'Body8', '/img/Cover/Article/Default.png', 0, '2023-05-12 13:04:10', NULL, 10, 'ENG'),
(31, 'AAAAAA', '<p>asdasd</p>', '<p>asdasd</p>', '/img/Cover/Article/cover_31.webp', 0, '2023-05-14 22:31:48', NULL, 10, 'ENG');

-- --------------------------------------------------------

--
-- Table structure for table `author`
--

CREATE TABLE `author` (
  `id` int NOT NULL,
  `name` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `firstLastName` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `secondLastName` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin,
  `avatar` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `preferedLanguage` char(3) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `isAdmin` tinyint NOT NULL DEFAULT '0',
  `canPublish` tinyint NOT NULL DEFAULT '0',
  `isActive` tinyint NOT NULL DEFAULT '1',
  `birthday` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `startDate` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `endDate` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

--
-- Dumping data for table `author`
--

INSERT INTO `author` (`id`, `name`, `firstLastName`, `secondLastName`, `password`, `email`, `phone`, `description`, `avatar`, `preferedLanguage`, `isAdmin`, `canPublish`, `isActive`, `birthday`, `startDate`, `endDate`) VALUES
(10, 'Cristina', 'Carbonell', 'Matamoros', '$2a$12$MZ8Yv12l3gj/C.6i0B.S6OZErlbW1AondFJtxHAkaAf.VNW1RZbN6', 'cristicarmat2@gmail.com', '965878965', '<p>AAAAAAAAA AAAAA A A A AAAAAAA AAAAAAAAA A AAAA A AAAAA A AA A A A A AA A A</p>', '/img/Avatar/Author/avatar_10.jpeg', 'ENG', 1, 1, 1, '2023-04-21', '2023-04-21', NULL),
(12, 'Lidia', 'Echuaca', NULL, '$2a$12$MZ8Yv12l3gj/C.6i0B.S6OZErlbW1AondFJtxHAkaAf.VNW1RZbN6', 'lidia@gmail.com', '587698569', '<p>si leeis esto es un mensaje de ayuda cristiana me tiene secuestrada soy una esclava auxilio &aacute;NGEL</p>', '/img/Avatar/Author/avatar_12.jpg', 'ESP', 0, 1, 1, '2023-05-14', '2023-05-14', NULL),
(13, 'Edu', 'Carbonell', 'Matamoros', '$2a$11$kfB1lJy5FsriRzPP659oqOPJv2UnZcPt0bes1Fe.b53YuRZ9XN5su', 'edu@gmail.com', '546896523', '<p>Pechuga</p>', '/img/Avatar/Author/avatar_0.jpeg', 'ESP', 0, 1, 1, '2008-10-11', '2023-04-21', NULL),
(14, 'Ángel', 'Sánchez', 'Pastor', '$2a$11$tbjLxSXUXautTqagVujdm.C2uT0rcPFiK7npcQG3Hd0sZmMluRAWG', 'asp@gmail.com', '123456789', '<p>Me gustan las calculadoras y el Horizon. Tengo el record de hu&iacute;das de DAW.</p>', '/img/Avatar/Author/avatar_0.png', 'ESP', 1, 1, 1, '2023-04-22', '2023-04-22', NULL),
(15, 'Adrián', 'Pérez', NULL, '$2a$11$Vhafab1MeBJiNnAKe.n/iuYq4zNVjyRa559Gv0rhxhpmC39ILv7Ge', 'adrianperez@gmail.com', '456137788', '<p>&iquest;Spiderman o Espaiderman?</p>', '/img/Avatar/Author/avatar_15.jpeg', 'ESP', 0, 0, 0, '2023-04-22', '2023-04-22', NULL),
(16, 'Raquel', 'Pomares', 'Bleda', '123456', 'raquel@gmail.com', '41257968', '<p>Cristina, &iquest;que haces metiendome en esta p&aacute;gina de <strong>mierdaaa?</strong></p>', '/img/Avatar/Author/avatar_16.jpg', 'ENG', 0, 0, 1, '2023-04-23', '2023-04-23', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `name`) VALUES
(3, 'Admin'),
(5, 'AdminArticle'),
(6, 'AdminAuthor'),
(7, 'AdminDev'),
(8, 'AdminGame'),
(9, 'AdminGenre'),
(10, 'AdminLanguage'),
(11, 'AdminWebLanguage'),
(12, 'AdminPlatform'),
(13, 'AdminPlayerType'),
(14, 'AdminPublisher'),
(15, 'AdminUser'),
(16, 'Login'),
(17, 'Messages'),
(19, 'AdminAuthorForm'),
(20, 'AdminWebLanguageForm'),
(21, 'AdminCategory'),
(22, 'AdminCategoryForm'),
(25, 'AdminText'),
(26, 'AdminTextForm'),
(27, 'AdminPlayerTypeForm'),
(29, 'AdminLanguageForm'),
(30, 'AdminGenreForm'),
(31, 'AdminDevForm'),
(32, 'AdminPublisherForm'),
(33, 'AdminPlatformForm'),
(34, 'AdminUserForm'),
(35, 'AdminArticleForm');

-- --------------------------------------------------------

--
-- Table structure for table `dev`
--

CREATE TABLE `dev` (
  `id` int NOT NULL,
  `name` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

--
-- Dumping data for table `dev`
--

INSERT INTO `dev` (`id`, `name`) VALUES
(1, 'Rockstar Games'),
(2, 'Ubisoft'),
(3, 'Blizzard Entertainment'),
(4, 'Square Enix'),
(5, 'Electronic Arts'),
(6, 'CD Projekt Red'),
(7, 'Naughty Dog'),
(8, 'Capcom'),
(9, 'Bethesda Game Studios'),
(10, 'Nintendo');

-- --------------------------------------------------------

--
-- Table structure for table `game`
--

CREATE TABLE `game` (
  `id` bigint NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `subtitle` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `language` char(3) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `cover` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `releaseDate` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `totalScore` tinyint NOT NULL DEFAULT '0',
  `isFav` tinyint NOT NULL DEFAULT '0',
  `idDev` int NOT NULL,
  `idPlatform` int NOT NULL,
  `idPublisher` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

--
-- Dumping data for table `game`
--

INSERT INTO `game` (`id`, `title`, `subtitle`, `description`, `language`, `cover`, `releaseDate`, `totalScore`, `isFav`, `idDev`, `idPlatform`, `idPublisher`) VALUES
(1, 'Game 1', 'Subtitle 1', 'Description 1', 'ENG', '/img/Cover/Game/Default.png', '2023-05-12', 0, 0, 1, 2, 1),
(2, 'Game 2', 'Subtitle 2', 'Description 2', 'ESP', '/img/Cover/Game/Default.png', '2023-05-12', 0, 0, 2, 1, 1),
(3, 'Game 3', 'Subtitle 3', 'Description 3', 'ENG', '/img/Cover/Game/Default.png', '2023-05-12', 0, 0, 3, 2, 1),
(4, 'Game 4', 'Subtitle 4', 'Description 4', 'ESP', '/img/Cover/Game/Default.png', '2023-05-12', 0, 0, 1, 3, 1),
(5, 'Game 5', 'Subtitle 5', 'Description 5', 'ENG', '/img/Cover/Game/Default.png', '2023-05-12', 0, 0, 2, 1, 1),
(6, 'Game 6', 'Subtitle 6', 'Description 6', 'ESP', '/img/Cover/Game/Default.png', '2023-05-12', 0, 0, 3, 2, 1),
(7, 'Game 7', 'Subtitle 7', 'Description 7', 'ENG', '/img/Cover/Game/Default.png', '2023-05-12', 0, 0, 1, 2, 1),
(8, 'Game 8', 'Subtitle 8', 'Description 8', 'ESP', '/img/Cover/Game/Default.png', '2023-05-12', 0, 0, 2, 1, 1),
(9, 'Game 9', 'Subtitle 9', 'Description 9', 'ENG', '/img/Cover/Game/Default.png', '2023-05-12', 0, 0, 3, 2, 1),
(10, 'Game 10', 'Subtitle 10', 'Description 10', 'ESP', '/img/Cover/Game/Default.png', '2023-05-12', 0, 0, 1, 3, 1);

-- --------------------------------------------------------

--
-- Table structure for table `game_article`
--

CREATE TABLE `game_article` (
  `idGame` bigint NOT NULL,
  `idArticle` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

--
-- Dumping data for table `game_article`
--

INSERT INTO `game_article` (`idGame`, `idArticle`) VALUES
(3, 31),
(7, 31);

-- --------------------------------------------------------

--
-- Table structure for table `game_genre`
--

CREATE TABLE `game_genre` (
  `idGame` bigint NOT NULL,
  `idGenre` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

-- --------------------------------------------------------

--
-- Table structure for table `game_language`
--

CREATE TABLE `game_language` (
  `idGame` bigint NOT NULL,
  `idLanguage` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

-- --------------------------------------------------------

--
-- Table structure for table `game_player_type`
--

CREATE TABLE `game_player_type` (
  `idGame` bigint NOT NULL,
  `idPlayerType` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

-- --------------------------------------------------------

--
-- Table structure for table `genre`
--

CREATE TABLE `genre` (
  `id` int NOT NULL,
  `name` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `language` char(3) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

--
-- Dumping data for table `genre`
--

INSERT INTO `genre` (`id`, `name`, `language`) VALUES
(1, 'Action', 'ENG'),
(2, 'Acción', 'ESP'),
(3, 'Adventure', 'ENG'),
(4, 'Aventura', 'ESP'),
(5, 'Role-playing', 'ENG'),
(6, 'Role-playing', 'ESP'),
(7, 'Simulation', 'ENG'),
(8, 'Simulación', 'ESP'),
(9, 'Strategy', 'ENG'),
(10, 'Estrategia', 'ESP'),
(11, 'Sports', 'ENG'),
(12, 'Deportes', 'ESP'),
(13, 'Racing', 'ENG'),
(14, 'Carreras', 'ESP'),
(15, 'Fighting', 'ENG'),
(16, 'Lucha', 'ESP'),
(17, 'Puzzle', 'ENG'),
(18, 'Puzzle', 'ESP'),
(19, 'Shooter', 'ENG'),
(20, 'Disparos', 'ESP');

-- --------------------------------------------------------

--
-- Table structure for table `language`
--

CREATE TABLE `language` (
  `id` int NOT NULL,
  `name` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `language` char(3) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

--
-- Dumping data for table `language`
--

INSERT INTO `language` (`id`, `name`, `language`) VALUES
(1, 'Español', 'ESP'),
(4, 'Spanish', 'ENG'),
(5, 'Inglés', 'ESP'),
(6, 'English', 'ENG');

-- --------------------------------------------------------

--
-- Table structure for table `platform`
--

CREATE TABLE `platform` (
  `id` int NOT NULL,
  `name` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

--
-- Dumping data for table `platform`
--

INSERT INTO `platform` (`id`, `name`, `icon`) VALUES
(1, 'PlayStation 5', '<i class=\"fa-brands fa-playstation\"></i>'),
(2, 'Xbox Series X', '<i class=\"fa-brands fa-xbox\"></i>'),
(3, 'Nintendo Switch', '<i class=\"fa-solid fa-n\"></i>'),
(4, 'PlayStation 4', '<i class=\"fa-brands fa-playstation\"></i>'),
(5, 'Xbox One', '<i class=\"fa-brands fa-xbox\"></i>'),
(6, 'PC', '<i class=\"fa-brands fa-windows\"></i>'),
(7, 'Mac', '<i class=\"fa-brands fa-apple\"></i>'),
(8, 'Linux', '<i class=\"fa-brands fa-linux\"></i>'),
(9, 'Android', '<i class=\"fa-brands fa-android\"></i>'),
(10, 'PlayStation 3', '<i class=\"fa-brands fa-playstation\"></i>'),
(11, 'Xbox 360', '<i class=\"fa-brands fa-xbox\"></i>'),
(12, 'Nintendo Wii', '<i class=\"fa-solid fa-n\"></i>'),
(13, 'IOS', '<i class=\"fa-brands fa-app-store-ios\"></i>');

-- --------------------------------------------------------

--
-- Table structure for table `player_type`
--

CREATE TABLE `player_type` (
  `id` int NOT NULL,
  `name` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `language` char(3) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

--
-- Dumping data for table `player_type`
--

INSERT INTO `player_type` (`id`, `name`, `language`) VALUES
(1, 'Singleplayer', 'ENG'),
(2, 'Cooperative', 'ENG'),
(3, 'Multiplayer', 'ENG'),
(4, 'Un Jugador', 'ESP'),
(5, 'Multijugador', 'ESP'),
(6, 'Cooperativo', 'ESP');

-- --------------------------------------------------------

--
-- Table structure for table `publisher`
--

CREATE TABLE `publisher` (
  `id` int NOT NULL,
  `name` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

--
-- Dumping data for table `publisher`
--

INSERT INTO `publisher` (`id`, `name`) VALUES
(1, 'Rockstar Games');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` bigint NOT NULL,
  `username` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT '/img/Avatar/User/Default.png',
  `preferedLanguage` char(3) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `birthday` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `creationDate` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `email`, `avatar`, `preferedLanguage`, `birthday`, `creationDate`) VALUES
(1, 'user1', '$2a$12$MZ8Yv12l3gj/C.6i0B.S6OZErlbW1AondFJtxHAkaAf.VNW1RZbN6', 'user1@email.com', '/img/Avatar/User/Default.png', 'ENG', '1991-02-03', '2021-10-10'),
(2, 'user2', '$2a$12$MZ8Yv12l3gj/C.6i0B.S6OZErlbW1AondFJtxHAkaAf.VNW1RZbN6', 'user2@email.com', '/img/Avatar/User/Default.png', 'ESP', '1992-03-04', '2021-08-22'),
(3, 'user3', '$2a$12$MZ8Yv12l3gj/C.6i0B.S6OZErlbW1AondFJtxHAkaAf.VNW1RZbN6', 'user3@email.com', '/img/Avatar/User/Default.png', 'ENG', '1993-04-05', '2022-01-05'),
(4, 'user4', '$2a$12$MZ8Yv12l3gj/C.6i0B.S6OZErlbW1AondFJtxHAkaAf.VNW1RZbN6', 'user4@email.com', '/img/Avatar/User/Default.png', 'ESP', '1994-05-06', '2022-03-17'),
(5, 'user5', '$2a$12$MZ8Yv12l3gj/C.6i0B.S6OZErlbW1AondFJtxHAkaAf.VNW1RZbN6', 'user5@email.com', '/img/Avatar/User/Default.png', 'ENG', '1995-06-07', '2021-11-29'),
(6, 'user6', '$2a$12$MZ8Yv12l3gj/C.6i0B.S6OZErlbW1AondFJtxHAkaAf.VNW1RZbN6', 'user6@email.com', '/img/Avatar/User/Default.png', 'ESP', '1996-07-08', '2022-04-23'),
(7, 'user77', '$2a$12$MZ8Yv12l3gj/C.6i0B.S6OZErlbW1AondFJtxHAkaAf.VNW1RZbN6', 'user7@email.com', '/img/Avatar/User/Default.png', 'ENG', '2023-05-14', ''),
(8, 'user8', '$2a$12$MZ8Yv12l3gj/C.6i0B.S6OZErlbW1AondFJtxHAkaAf.VNW1RZbN6', 'user8@email.com', '/img/Avatar/User/Default.png', 'ESP', '1998-09-10', '2023-01-11');

-- --------------------------------------------------------

--
-- Table structure for table `user_fav_game`
--

CREATE TABLE `user_fav_game` (
  `idUser` bigint NOT NULL,
  `idGame` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

--
-- Dumping data for table `user_fav_game`
--

INSERT INTO `user_fav_game` (`idUser`, `idGame`) VALUES
(1, 1),
(1, 5),
(1, 8),
(2, 1),
(2, 2),
(3, 3),
(5, 3);

-- --------------------------------------------------------

--
-- Table structure for table `user_score_game`
--

CREATE TABLE `user_score_game` (
  `idUser` bigint NOT NULL,
  `idGame` bigint NOT NULL,
  `score` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

--
-- Dumping data for table `user_score_game`
--

INSERT INTO `user_score_game` (`idUser`, `idGame`, `score`) VALUES
(1, 1, 1),
(1, 2, 5),
(2, 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `web_language`
--

CREATE TABLE `web_language` (
  `id` char(3) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

--
-- Dumping data for table `web_language`
--

INSERT INTO `web_language` (`id`, `name`, `icon`) VALUES
('ENG', 'English', '<span class=\"fi fi-gb fis\"></span>'),
('ESP', 'Spanish', '<span class=\"fi fi-es fis\"></span>');

-- --------------------------------------------------------

--
-- Table structure for table `web_text`
--

CREATE TABLE `web_text` (
  `id` int NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `text` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `idCategory` int NOT NULL,
  `language` char(3) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL DEFAULT 'ENG'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

--
-- Dumping data for table `web_text`
--

INSERT INTO `web_text` (`id`, `title`, `text`, `idCategory`, `language`) VALUES
(1, 'AdminLoginTitle', 'Admin Log In', 16, 'ENG'),
(2, 'AdminLoginTitle', 'Acceso Administrador', 16, 'ESP'),
(3, 'AdminLoginEmail', 'Email', 16, 'ENG'),
(4, 'AdminLoginEmail', 'Correo', 16, 'ESP'),
(5, 'AdminLoginPassword', 'Password', 16, 'ENG'),
(6, 'AdminLoginPassword', 'Contraseña', 16, 'ESP'),
(7, 'AdminLoginButtonAccess', 'Log In', 16, 'ENG'),
(8, 'AdminLoginButtonAccess', 'Acceder', 16, 'ESP'),
(9, 'AdminLoginButtonReturn', 'Return', 16, 'ENG'),
(10, 'AdminLoginButtonReturn', 'Volver', 16, 'ESP'),
(11, 'EmailExist', 'Email already Exist', 17, 'ENG'),
(12, 'EmailExist', 'El Email ya existe', 17, 'ESP'),
(13, 'IncorrectEmailOrPassword', 'Incorrect Email or Password', 17, 'ENG'),
(14, 'IncorrectEmailOrPassword', 'Email o contraseña incorrectos', 17, 'ESP'),
(15, 'FillAllData', 'Fill all required data', 17, 'ENG'),
(16, 'FillAllData', 'Rellena todos los campos', 17, 'ESP'),
(17, 'ErrorOccurred', 'An error occurred, try again later', 17, 'ENG'),
(18, 'ErrorOccurred', 'Ha ocurrido un error, por favor intente de nuevo más tarde', 17, 'ESP'),
(19, 'PhoneExist', 'Phone already exist', 17, 'ENG'),
(20, 'PhoneExist', 'Teléfono ya existe', 17, 'ESP'),
(21, 'InvalidPassword', 'Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, one digit, and one symbol (@$!%*?&.)', 17, 'ENG'),
(22, 'InvalidPassword', 'La contraseña debe tener al menos 8 caracteres y contener al menos una letra mayúscula, una letra minúscula, un dígito y un símbolo (@$!%*?&.)', 17, 'ESP'),
(23, 'MismatchPasswords', 'Passwords don\'t match', 17, 'ENG'),
(24, 'MismatchPasswords', 'Las contraseñas no coinciden', 17, 'ESP'),
(25, 'ErrorOldPassword', 'Incorrect Old Password', 17, 'ENG'),
(26, 'ErrorOldPassword', 'Contraseña vieja incorrecta', 17, 'ESP'),
(27, 'Welcome', 'Welcome', 3, 'ENG'),
(28, 'Welcome', 'Bienvenid@', 3, 'ESP'),
(29, 'UserNotActive', 'Your user is not active, please contact an administrator', 17, 'ENG'),
(30, 'UserNotActive', 'Su usuario se encuentra inactivo, por favor contacte con un administrador', 17, 'ESP'),
(31, 'Description', 'This is the Author tab. all registered authors information will be displayed here. Recomended 80% zoom', 6, 'ENG'),
(32, 'Description', 'Esta es la pestaña de Autores. Aquí se mostrará la información de todos los autores registrados. Se recomienda un zoom del 80%', 6, 'ESP'),
(33, 'FilterTitle', 'Filters', 6, 'ENG'),
(34, 'FilterTitle', 'Filtros', 6, 'ESP'),
(35, 'fOrderBy', 'Order By', 6, 'ENG'),
(36, 'fOrderBy', 'Ordenar por', 6, 'ESP'),
(37, 'fSearchId', 'Search By ID', 6, 'ENG'),
(38, 'fSearchId', 'Buscar por ID', 6, 'ESP'),
(39, 'fSearchName', 'Search By Name', 6, 'ENG'),
(40, 'fSearchName', 'Buscar Por Nombre', 6, 'ESP'),
(41, 'fSearchLastName', 'Search By Last Name', 6, 'ENG'),
(42, 'fSearchLastName', 'Buscar Por Primer Apellido', 6, 'ESP'),
(43, 'fSearchSecondLastName', 'Search By Second Last Name', 6, 'ENG'),
(44, 'fSearchSecondLastName', 'Buscar Por Segundo Apellido', 6, 'ESP'),
(45, 'fSearchEmail', 'Search By Email', 6, 'ENG'),
(46, 'fSearchEmail', 'Buscar Por Email', 6, 'ESP'),
(47, 'fIsAdmin', 'Is Admin', 6, 'ENG'),
(48, 'fIsAdmin', 'Es Admin', 6, 'ESP'),
(49, 'fIsActive', 'Is Active', 6, 'ENG'),
(50, 'fIsActive', 'Está Activo', 6, 'ESP'),
(51, 'ButtonFilter', 'Filter', 6, 'ENG'),
(52, 'ButtonFilter', 'Filtrar', 6, 'ESP'),
(53, 'ButtonNew', 'New', 6, 'ENG'),
(54, 'ButtonNew', 'Nuevo', 6, 'ESP'),
(55, 'ButtonNext', 'Next', 6, 'ENG'),
(56, 'ButtonNext', 'Siguiente', 6, 'ESP'),
(57, 'ButtonPrevious', 'Previous', 6, 'ENG'),
(58, 'ButtonPrevious', 'Anterior', 6, 'ESP'),
(59, 'Actions', 'Actions', 6, 'ENG'),
(60, 'Actions', 'Acciones', 6, 'ESP'),
(61, 'Page', 'Page', 6, 'ENG'),
(62, 'Page', 'Página', 6, 'ESP'),
(63, 'Of', 'of', 6, 'ENG'),
(64, 'Of', 'de', 6, 'ESP'),
(65, 'Outof', 'out of', 6, 'ENG'),
(66, 'Outof', 'de', 6, 'ESP'),
(67, 'NoData', 'No data found', 6, 'ENG'),
(68, 'NoData', 'No se encontraron datos', 6, 'ESP'),
(69, 'TitleCreate', 'Create', 19, 'ENG'),
(70, 'TitleCreate', 'Crear', 19, 'ESP'),
(71, 'TitleUpdate', 'Update', 19, 'ENG'),
(72, 'TitleUpdate', 'Actualizar', 19, 'ESP'),
(73, 'ButtonCreate', 'Create', 19, 'ENG'),
(74, 'ButtonCreate', 'Crear', 19, 'ESP'),
(75, 'ButtonUpdate', 'Update', 19, 'ENG'),
(76, 'ButtonUpdate', 'Actualizar', 19, 'ESP'),
(77, 'OldPassword', 'Old Password', 19, 'ENG'),
(78, 'OldPassword', 'Contraseña Antigua', 19, 'ESP'),
(79, 'NewPassword', 'New Password', 19, 'ENG'),
(80, 'NewPassword', 'Nueva Contraseña', 19, 'ESP'),
(81, 'ConfirmPassword', 'Old Password', 19, 'ENG'),
(82, 'ConfirmPassword', 'Confirmar Contraseña', 19, 'ESP'),
(83, 'Description', 'Description', 19, 'ENG'),
(84, 'Description', 'Descripción', 19, 'ESP'),
(85, 'PreferedLanguage', 'Preferred Language', 19, 'ENG'),
(86, 'PreferedLanguage', 'Idioma Preferido', 19, 'ESP'),
(87, 'Description', 'This is the page Language tab. all the pages languages will be displayed here', 11, 'ENG'),
(88, 'Description', 'Esta es la pestaña de idiomas de la web. Aquí se mostrará la información de todos los idiomas disponibles en la web', 11, 'ESP'),
(89, 'FilterTitle', 'Filters', 11, 'ENG'),
(90, 'FilterTitle', 'Filtros', 11, 'ESP'),
(91, 'fOrderBy', 'Order By', 11, 'ENG'),
(92, 'fOrderBy', 'Ordenar por', 11, 'ESP'),
(93, 'fSearchId', 'Search By ID', 11, 'ENG'),
(94, 'fSearchId', 'Buscar por ID', 11, 'ESP'),
(95, 'fSearchName', 'Search By Name', 11, 'ENG'),
(96, 'fSearchName', 'Buscar Por Nombre', 11, 'ESP'),
(97, 'ButtonFilter', 'Filter', 11, 'ENG'),
(98, 'ButtonFilter', 'Filtrar', 11, 'ESP'),
(99, 'ButtonNew', 'New', 11, 'ENG'),
(100, 'ButtonNew', 'Nuevo', 11, 'ESP'),
(101, 'ButtonNext', 'Next', 11, 'ENG'),
(102, 'ButtonNext', 'Siguiente', 11, 'ESP'),
(103, 'ButtonPrevious', 'Previous', 11, 'ENG'),
(104, 'ButtonPrevious', 'Anterior', 11, 'ESP'),
(105, 'Actions', 'Actions', 11, 'ENG'),
(106, 'Actions', 'Acciones', 11, 'ESP'),
(107, 'Page', 'Page', 11, 'ENG'),
(108, 'Page', 'Página', 11, 'ESP'),
(109, 'Of', 'of', 11, 'ENG'),
(110, 'Of', 'de', 11, 'ESP'),
(111, 'Outof', 'out of', 11, 'ENG'),
(112, 'Outof', 'de', 11, 'ESP'),
(113, 'NoData', 'No data found', 11, 'ENG'),
(114, 'NoData', 'No se encontraron datos', 11, 'ESP'),
(115, 'TitleCreate', 'Create', 20, 'ENG'),
(116, 'TitleCreate', 'Crear', 20, 'ESP'),
(117, 'TitleUpdate', 'Update', 20, 'ENG'),
(118, 'TitleUpdate', 'Actualizar', 20, 'ESP'),
(119, 'ButtonCreate', 'Create', 20, 'ENG'),
(120, 'ButtonCreate', 'Crear', 20, 'ESP'),
(121, 'ButtonUpdate', 'Update', 20, 'ENG'),
(122, 'ButtonUpdate', 'Actualizar', 20, 'ESP'),
(123, 'ModalTitle', 'Confirmation', 6, 'ENG'),
(124, 'ModalTitle', 'Confirmación', 6, 'ESP'),
(125, 'ModalText', 'Are you sure you want to delete this row with id', 6, 'ENG'),
(126, 'ModalText', '¿Estas seguro de que quieres eliminar la fila con el id', 6, 'ESP'),
(127, 'ModalButtonDelete', 'Delete', 6, 'ENG'),
(128, 'ModalButtonDelete', 'Eliminar', 6, 'ESP'),
(129, 'ModalButtonCancelar', 'Cancel', 6, 'ENG'),
(130, 'ModalButtonCancelar', 'Cancelar', 6, 'ESP'),
(131, 'ModalTitle', 'Confirmation', 11, 'ENG'),
(132, 'ModalTitle', 'Confirmación', 11, 'ESP'),
(133, 'ModalText', 'Are you sure you want to delete this row with id', 11, 'ENG'),
(134, 'ModalText', '¿Estas seguro de que quieres eliminar la fila con el id', 11, 'ESP'),
(135, 'ModalButtonDelete', 'Delete', 11, 'ENG'),
(136, 'ModalButtonDelete', 'Eliminar', 11, 'ESP'),
(137, 'ModalButtonCancelar', 'Cancel', 11, 'ENG'),
(138, 'ModalButtonCancelar', 'Cancelar', 11, 'ESP'),
(139, 'Description', 'This is the Category tab. all categories for the web text information will be displayed here', 21, 'ENG'),
(140, 'Description', 'Esta es la pestaña de Categorías. Aquí se mostrará la información de todas las categorías del texto de la web. ', 21, 'ESP'),
(141, 'FilterTitle', 'Filters', 21, 'ENG'),
(142, 'FilterTitle', 'Filtros', 21, 'ESP'),
(143, 'fOrderBy', 'Order By', 21, 'ENG'),
(144, 'fOrderBy', 'Ordenar por', 21, 'ESP'),
(145, 'fSearchId', 'Search By ID', 21, 'ENG'),
(146, 'fSearchId', 'Buscar por ID', 21, 'ESP'),
(147, 'fSearchName', 'Search By Name', 21, 'ENG'),
(148, 'ButtonFilter', 'Filter', 21, 'ENG'),
(149, 'ButtonFilter', 'Filtrar', 21, 'ESP'),
(150, 'ButtonNew', 'New', 21, 'ENG'),
(151, 'ButtonNew', 'Nuevo', 21, 'ESP'),
(152, 'ButtonNext', 'Next', 21, 'ENG'),
(153, 'ButtonNext', 'Siguiente', 21, 'ESP'),
(154, 'ButtonPrevious', 'Previous', 21, 'ENG'),
(155, 'ButtonPrevious', 'Anterior', 21, 'ESP'),
(156, 'Actions', 'Actions', 21, 'ENG'),
(157, 'Actions', 'Acciones', 21, 'ESP'),
(158, 'Page', 'Page', 21, 'ENG'),
(159, 'Page', 'Página', 21, 'ESP'),
(160, 'Of', 'of', 21, 'ENG'),
(161, 'Of', 'de', 21, 'ESP'),
(162, 'Outof', 'out of', 21, 'ENG'),
(163, 'Outof', 'de', 21, 'ESP'),
(164, 'NoData', 'No data found', 21, 'ENG'),
(165, 'NoData', 'No se encontraron datos', 21, 'ESP'),
(166, 'TitleCreate', 'Create', 22, 'ENG'),
(167, 'TitleCreate', 'Crear', 22, 'ESP'),
(168, 'TitleUpdate', 'Update', 22, 'ENG'),
(169, 'TitleUpdate', 'Actualizar', 22, 'ESP'),
(170, 'ButtonCreate', 'Create', 22, 'ENG'),
(171, 'ButtonCreate', 'Crear', 22, 'ESP'),
(172, 'ButtonUpdate', 'Update', 22, 'ENG'),
(173, 'ButtonUpdate', 'Actualizar', 22, 'ESP'),
(174, 'ModalTitle', 'Confirmation', 21, 'ENG'),
(175, 'ModalTitle', 'Confirmación', 21, 'ESP'),
(176, 'ModalText', 'Are you sure you want to delete this row with id', 21, 'ENG'),
(177, 'ModalText', '¿Estas seguro de que quieres eliminar la fila con el id', 21, 'ESP'),
(178, 'ModalButtonDelete', 'Delete', 21, 'ENG'),
(179, 'ModalButtonDelete', 'Eliminar', 21, 'ESP'),
(180, 'ModalButtonCancelar', 'Cancel', 21, 'ENG'),
(181, 'ModalButtonCancelar', 'Cancelar', 21, 'ESP'),
(182, 'fSearchName', 'Buscar por Nombre', 21, 'ESP'),
(183, 'Description', 'This is the Web Text tab. all texts for the web text information will be displayed here', 25, 'ENG'),
(184, 'Description', 'Esta es la pestaña de Texto. Aquí se mostrará la información de todo el texto de la web. ', 25, 'ESP'),
(185, 'FilterTitle', 'Filters', 25, 'ENG'),
(186, 'FilterTitle', 'Filtros', 25, 'ESP'),
(187, 'fOrderBy', 'Order By', 25, 'ENG'),
(188, 'fOrderBy', 'Ordenar por', 25, 'ESP'),
(189, 'fSearchId', 'Search By ID', 25, 'ENG'),
(190, 'fSearchId', 'Buscar por ID', 25, 'ESP'),
(191, 'fSearchTitle', 'Search By Title', 25, 'ENG'),
(192, 'fSearchTitle', 'Buscar por Título', 25, 'ESP'),
(193, 'fSearchText', 'Search By Text', 25, 'ENG'),
(194, 'fSearchText', 'Buscar por Texto', 25, 'ESP'),
(195, 'fSearchCategory', 'Search By Category', 25, 'ENG'),
(196, 'fSearchCategory', 'Buscar por Categoría', 25, 'ESP'),
(197, 'fSearchLanguage', 'Search By Language', 25, 'ENG'),
(198, 'fSearchLanguage', 'Buscar por Idioma', 25, 'ESP'),
(199, 'ButtonFilter', 'Filter', 25, 'ENG'),
(200, 'ButtonFilter', 'Filtrar', 25, 'ESP'),
(201, 'ButtonNew', 'New', 25, 'ENG'),
(202, 'ButtonNew', 'Nuevo', 25, 'ESP'),
(203, 'ButtonNext', 'Next', 25, 'ENG'),
(204, 'ButtonNext', 'Siguiente', 25, 'ESP'),
(205, 'ButtonPrevious', 'Previous', 25, 'ENG'),
(206, 'ButtonPrevious', 'Anterior', 25, 'ESP'),
(207, 'Actions', 'Actions', 25, 'ENG'),
(208, 'Actions', 'Acciones', 25, 'ESP'),
(209, 'Page', 'Page', 25, 'ENG'),
(210, 'Page', 'Página', 25, 'ESP'),
(211, 'Of', 'of', 25, 'ENG'),
(212, 'Of', 'de', 25, 'ESP'),
(213, 'Outof', 'out of', 25, 'ENG'),
(214, 'Outof', 'de', 25, 'ESP'),
(215, 'NoData', 'No data found', 25, 'ENG'),
(216, 'NoData', 'No se encontraron datos', 25, 'ESP'),
(217, 'TitleCreate', 'Create', 26, 'ENG'),
(218, 'TitleCreate', 'Crear', 26, 'ESP'),
(219, 'TitleUpdate', 'Update', 26, 'ENG'),
(220, 'TitleUpdate', 'Actualizar', 26, 'ESP'),
(221, 'ButtonCreate', 'Create', 26, 'ENG'),
(222, 'ButtonCreate', 'Crear', 26, 'ESP'),
(223, 'ButtonUpdate', 'Update', 26, 'ENG'),
(224, 'ButtonUpdate', 'Actualizar', 26, 'ESP'),
(225, 'ModalTitle', 'Confirmation', 25, 'ENG'),
(226, 'ModalTitle', 'Confirmación', 25, 'ESP'),
(227, 'ModalText', 'Are you sure you want to delete this row with id', 25, 'ENG'),
(228, 'ModalText', '¿Estas seguro de que quieres eliminar la fila con el id', 25, 'ESP'),
(229, 'ModalButtonDelete', 'Delete', 25, 'ENG'),
(230, 'ModalButtonDelete', 'Eliminar', 25, 'ESP'),
(231, 'ModalButtonCancelar', 'Cancel', 25, 'ENG'),
(232, 'ModalButtonCancelar', 'Cancelar', 25, 'ESP'),
(242, 'Description', 'This is the Player Types  tab. all player types information will be displayed here. Remember to create both English and Spanish player type', 13, 'ENG'),
(243, 'Description', 'Esta es la pestaña de Tipos de jugador. Aquí se mostrará la información de los tipos de juego. Recuerda crear tanto el tipo en inglés como en español,. ', 13, 'ESP'),
(244, 'FilterTitle', 'Filters', 13, 'ENG'),
(245, 'FilterTitle', 'Filtros', 13, 'ESP'),
(246, 'fOrderBy', 'Order By', 13, 'ENG'),
(247, 'fOrderBy', 'Ordenar por', 13, 'ESP'),
(248, 'fSearchId', 'Search By ID', 13, 'ENG'),
(249, 'fSearchId', 'Buscar por ID', 13, 'ESP'),
(250, 'fSearchName', 'Search By Name', 13, 'ENG'),
(251, 'fSearchName', 'Buscar por Nombre', 13, 'ESP'),
(252, 'fSearchLanguage', 'Search By Language', 13, 'ENG'),
(253, 'fSearchLanguage', 'Buscar por Idioma', 13, 'ESP'),
(254, 'ButtonFilter', 'Filter', 13, 'ENG'),
(255, 'ButtonFilter', 'Filtrar', 13, 'ESP'),
(256, 'ButtonNew', 'New', 13, 'ENG'),
(257, 'ButtonNew', 'Nuevo', 13, 'ESP'),
(258, 'ButtonNext', 'Next', 13, 'ENG'),
(259, 'ButtonNext', 'Siguiente', 13, 'ESP'),
(260, 'ButtonPrevious', 'Previous', 13, 'ENG'),
(261, 'ButtonPrevious', 'Anterior', 13, 'ESP'),
(262, 'Actions', 'Actions', 13, 'ENG'),
(263, 'Actions', 'Acciones', 13, 'ESP'),
(264, 'Page', 'Page', 13, 'ENG'),
(265, 'Page', 'Página', 13, 'ESP'),
(266, 'Of', 'of', 13, 'ENG'),
(267, 'Of', 'de', 13, 'ESP'),
(268, 'Outof', 'out of', 13, 'ENG'),
(269, 'Outof', 'de', 13, 'ESP'),
(270, 'NoData', 'No data found', 13, 'ENG'),
(271, 'NoData', 'No se encontraron datos', 13, 'ESP'),
(272, 'ModalTitle', 'Confirmation', 13, 'ENG'),
(273, 'ModalTitle', 'Confirmación', 13, 'ESP'),
(274, 'ModalText', 'Are you sure you want to delete this row with id', 13, 'ENG'),
(275, 'ModalText', '¿Estas seguro de que quieres eliminar la fila con el id', 13, 'ESP'),
(276, 'ModalButtonDelete', 'Delete', 13, 'ENG'),
(277, 'ModalButtonDelete', 'Eliminar', 13, 'ESP'),
(278, 'ModalButtonCancelar', 'Cancel', 13, 'ENG'),
(279, 'ModalButtonCancelar', 'Cancelar', 13, 'ESP'),
(280, 'TitleCreate', 'Create', 27, 'ENG'),
(281, 'TitleCreate', 'Crear', 27, 'ESP'),
(282, 'TitleUpdate', 'Update', 27, 'ENG'),
(283, 'TitleUpdate', 'Actualizar', 27, 'ESP'),
(284, 'ButtonCreate', 'Create', 27, 'ENG'),
(285, 'ButtonCreate', 'Crear', 27, 'ESP'),
(286, 'ButtonUpdate', 'Update', 27, 'ENG'),
(287, 'ButtonUpdate', 'Actualizar', 27, 'ESP'),
(289, 'Description', 'This is the Language (Games)  tab. all game\'s possible languages information will be displayed here. Remember to create both English and Spanish', 10, 'ENG'),
(290, 'Description', 'Esta es la pestaña de Idiomas. Aquí se mostrará la información de los idiomas disponibles en los juegos. Recuerda crear tanto en inglés como en español,. ', 10, 'ESP'),
(291, 'FilterTitle', 'Filters', 10, 'ENG'),
(292, 'FilterTitle', 'Filtros', 10, 'ESP'),
(293, 'fOrderBy', 'Order By', 10, 'ENG'),
(294, 'fOrderBy', 'Ordenar por', 10, 'ESP'),
(295, 'fSearchId', 'Search By ID', 10, 'ENG'),
(296, 'fSearchId', 'Buscar por ID', 10, 'ESP'),
(297, 'fSearchName', 'Search By Name', 10, 'ENG'),
(298, 'fSearchName', 'Buscar por Nombre', 10, 'ESP'),
(299, 'fSearchLanguage', 'Search By Language', 10, 'ENG'),
(300, 'fSearchLanguage', 'Buscar por Idioma', 10, 'ESP'),
(301, 'ButtonFilter', 'Filter', 10, 'ENG'),
(302, 'ButtonFilter', 'Filtrar', 10, 'ESP'),
(303, 'ButtonNew', 'New', 10, 'ENG'),
(304, 'ButtonNew', 'Nuevo', 10, 'ESP'),
(305, 'ButtonNext', 'Next', 10, 'ENG'),
(306, 'ButtonNext', 'Siguiente', 10, 'ESP'),
(307, 'ButtonPrevious', 'Previous', 10, 'ENG'),
(308, 'ButtonPrevious', 'Anterior', 10, 'ESP'),
(309, 'Actions', 'Actions', 10, 'ENG'),
(310, 'Actions', 'Acciones', 10, 'ESP'),
(311, 'Page', 'Page', 10, 'ENG'),
(312, 'Page', 'Página', 10, 'ESP'),
(313, 'Of', 'of', 10, 'ENG'),
(314, 'Of', 'de', 10, 'ESP'),
(315, 'Outof', 'out of', 10, 'ENG'),
(316, 'Outof', 'de', 10, 'ESP'),
(317, 'NoData', 'No data found', 10, 'ENG'),
(318, 'NoData', 'No se encontraron datos', 10, 'ESP'),
(319, 'ModalTitle', 'Confirmation', 10, 'ENG'),
(320, 'ModalTitle', 'Confirmación', 10, 'ESP'),
(321, 'ModalText', 'Are you sure you want to delete this row with id', 10, 'ENG'),
(322, 'ModalText', '¿Estas seguro de que quieres eliminar la fila con el id', 10, 'ESP'),
(323, 'ModalButtonDelete', 'Delete', 10, 'ENG'),
(324, 'ModalButtonDelete', 'Eliminar', 10, 'ESP'),
(325, 'ModalButtonCancelar', 'Cancel', 10, 'ENG'),
(326, 'ModalButtonCancelar', 'Cancelar', 10, 'ESP'),
(327, 'TitleCreate', 'Create', 29, 'ENG'),
(328, 'TitleCreate', 'Crear', 29, 'ESP'),
(329, 'TitleUpdate', 'Update', 29, 'ENG'),
(330, 'TitleUpdate', 'Actualizar', 29, 'ESP'),
(331, 'ButtonCreate', 'Create', 29, 'ENG'),
(332, 'ButtonCreate', 'Crear', 29, 'ESP'),
(333, 'ButtonUpdate', 'Update', 29, 'ENG'),
(334, 'ButtonUpdate', 'Actualizar', 29, 'ESP'),
(335, 'Description', 'This is the Genre  tab. all game\'s genres information will be displayed here. Remember to create both English and Spanish', 9, 'ENG'),
(336, 'Description', 'Esta es la pestaña de Generos. Aquí se mostrará la información de los generos en los juegos. Recuerda crear tanto en inglés como en español,. ', 9, 'ESP'),
(337, 'FilterTitle', 'Filters', 9, 'ENG'),
(338, 'FilterTitle', 'Filtros', 9, 'ESP'),
(339, 'fOrderBy', 'Order By', 9, 'ENG'),
(340, 'fOrderBy', 'Ordenar por', 9, 'ESP'),
(341, 'fSearchId', 'Search By ID', 9, 'ENG'),
(342, 'fSearchId', 'Buscar por ID', 9, 'ESP'),
(343, 'fSearchName', 'Search By Name', 9, 'ENG'),
(344, 'fSearchName', 'Buscar por Nombre', 9, 'ESP'),
(345, 'fSearchLanguage', 'Search By Language', 9, 'ENG'),
(346, 'fSearchLanguage', 'Buscar por Idioma', 9, 'ESP'),
(347, 'ButtonFilter', 'Filter', 9, 'ENG'),
(348, 'ButtonFilter', 'Filtrar', 9, 'ESP'),
(349, 'ButtonNew', 'New', 9, 'ENG'),
(350, 'ButtonNew', 'Nuevo', 9, 'ESP'),
(351, 'ButtonNext', 'Next', 9, 'ENG'),
(352, 'ButtonNext', 'Siguiente', 9, 'ESP'),
(353, 'ButtonPrevious', 'Previous', 9, 'ENG'),
(354, 'ButtonPrevious', 'Anterior', 9, 'ESP'),
(355, 'Actions', 'Actions', 9, 'ENG'),
(356, 'Actions', 'Acciones', 9, 'ESP'),
(357, 'Page', 'Page', 9, 'ENG'),
(358, 'Page', 'Página', 9, 'ESP'),
(359, 'Of', 'of', 9, 'ENG'),
(360, 'Of', 'de', 9, 'ESP'),
(361, 'Outof', 'out of', 9, 'ENG'),
(362, 'Outof', 'de', 9, 'ESP'),
(363, 'NoData', 'No data found', 9, 'ENG'),
(364, 'NoData', 'No se encontraron datos', 9, 'ESP'),
(365, 'ModalTitle', 'Confirmation', 9, 'ENG'),
(366, 'ModalTitle', 'Confirmación', 9, 'ESP'),
(367, 'ModalText', 'Are you sure you want to delete this row with id', 9, 'ENG'),
(368, 'ModalText', '¿Estas seguro de que quieres eliminar la fila con el id', 9, 'ESP'),
(369, 'ModalButtonDelete', 'Delete', 9, 'ENG'),
(370, 'ModalButtonDelete', 'Eliminar', 9, 'ESP'),
(371, 'ModalButtonCancelar', 'Cancel', 9, 'ENG'),
(372, 'ModalButtonCancelar', 'Cancelar', 9, 'ESP'),
(373, 'TitleCreate', 'Create', 30, 'ENG'),
(374, 'TitleCreate', 'Crear', 30, 'ESP'),
(375, 'TitleUpdate', 'Update', 30, 'ENG'),
(376, 'TitleUpdate', 'Actualizar', 30, 'ESP'),
(377, 'ButtonCreate', 'Create', 30, 'ENG'),
(378, 'ButtonCreate', 'Crear', 30, 'ESP'),
(379, 'ButtonUpdate', 'Update', 30, 'ENG'),
(380, 'ButtonUpdate', 'Actualizar', 30, 'ESP'),
(381, 'Description', 'This is the Publisher tab. all publishers information will be displayed here.', 14, 'ENG'),
(382, 'Description', 'Esta es la pestaña de Editoras. Aquí se mostrará la información de las editoras.', 14, 'ESP'),
(383, 'FilterTitle', 'Filters', 7, 'ENG'),
(384, 'FilterTitle', 'Filtros', 7, 'ESP'),
(385, 'fOrderBy', 'Order By', 7, 'ENG'),
(386, 'fOrderBy', 'Ordenar por', 7, 'ESP'),
(387, 'fSearchId', 'Search By ID', 7, 'ENG'),
(388, 'fSearchId', 'Buscar por ID', 7, 'ESP'),
(389, 'fSearchName', 'Search By Name', 7, 'ENG'),
(390, 'fSearchName', 'Buscar por Nombre', 7, 'ESP'),
(391, 'ButtonFilter', 'Filter', 7, 'ENG'),
(392, 'ButtonFilter', 'Filtrar', 7, 'ESP'),
(393, 'ButtonNew', 'New', 7, 'ENG'),
(394, 'ButtonNew', 'Nuevo', 7, 'ESP'),
(395, 'ButtonNext', 'Next', 7, 'ENG'),
(396, 'ButtonNext', 'Siguiente', 7, 'ESP'),
(397, 'ButtonPrevious', 'Previous', 7, 'ENG'),
(398, 'ButtonPrevious', 'Anterior', 7, 'ESP'),
(399, 'Actions', 'Actions', 7, 'ENG'),
(400, 'Actions', 'Acciones', 7, 'ESP'),
(401, 'Page', 'Page', 7, 'ENG'),
(402, 'Page', 'Página', 7, 'ESP'),
(403, 'Of', 'of', 7, 'ENG'),
(404, 'Of', 'de', 7, 'ESP'),
(405, 'Outof', 'out of', 7, 'ENG'),
(406, 'Outof', 'de', 7, 'ESP'),
(407, 'NoData', 'No data found', 7, 'ENG'),
(408, 'NoData', 'No se encontraron datos', 7, 'ESP'),
(409, 'ModalTitle', 'Confirmation', 7, 'ENG'),
(410, 'ModalTitle', 'Confirmación', 7, 'ESP'),
(411, 'ModalText', 'Are you sure you want to delete this row with id', 7, 'ENG'),
(412, 'ModalText', '¿Estas seguro de que quieres eliminar la fila con el id', 7, 'ESP'),
(413, 'ModalButtonDelete', 'Delete', 7, 'ENG'),
(414, 'ModalButtonDelete', 'Eliminar', 7, 'ESP'),
(415, 'ModalButtonCancelar', 'Cancel', 7, 'ENG'),
(416, 'ModalButtonCancelar', 'Cancelar', 7, 'ESP'),
(417, 'TitleCreate', 'Create', 31, 'ENG'),
(418, 'TitleCreate', 'Crear', 31, 'ESP'),
(419, 'TitleUpdate', 'Update', 31, 'ENG'),
(420, 'TitleUpdate', 'Actualizar', 31, 'ESP'),
(421, 'ButtonCreate', 'Create', 31, 'ENG'),
(422, 'ButtonCreate', 'Crear', 31, 'ESP'),
(423, 'ButtonUpdate', 'Update', 31, 'ENG'),
(424, 'ButtonUpdate', 'Actualizar', 31, 'ESP'),
(425, 'Description', 'This is the Dev  tab. all devs information will be displayed here.', 7, 'ENG'),
(426, 'Description', 'Esta es la pestaña de Desarrolladores. Aquí se mostrará la información de los desarrolladores.', 7, 'ESP'),
(427, 'FilterTitle', 'Filters', 14, 'ENG'),
(428, 'FilterTitle', 'Filtros', 14, 'ESP'),
(429, 'fOrderBy', 'Order By', 14, 'ENG'),
(430, 'fOrderBy', 'Ordenar por', 14, 'ESP'),
(431, 'fSearchId', 'Search By ID', 14, 'ENG'),
(432, 'fSearchId', 'Buscar por ID', 14, 'ESP'),
(433, 'fSearchName', 'Search By Name', 14, 'ENG'),
(434, 'fSearchName', 'Buscar por Nombre', 14, 'ESP'),
(435, 'ButtonFilter', 'Filter', 14, 'ENG'),
(436, 'ButtonFilter', 'Filtrar', 14, 'ESP'),
(437, 'ButtonNew', 'New', 14, 'ENG'),
(438, 'ButtonNew', 'Nuevo', 14, 'ESP'),
(439, 'ButtonNext', 'Next', 14, 'ENG'),
(440, 'ButtonNext', 'Siguiente', 14, 'ESP'),
(441, 'ButtonPrevious', 'Previous', 14, 'ENG'),
(442, 'ButtonPrevious', 'Anterior', 14, 'ESP'),
(443, 'Actions', 'Actions', 14, 'ENG'),
(444, 'Actions', 'Acciones', 14, 'ESP'),
(445, 'Page', 'Page', 14, 'ENG'),
(446, 'Page', 'Página', 14, 'ESP'),
(447, 'Of', 'of', 14, 'ENG'),
(448, 'Of', 'de', 14, 'ESP'),
(449, 'Outof', 'out of', 14, 'ENG'),
(450, 'Outof', 'de', 14, 'ESP'),
(451, 'NoData', 'No data found', 14, 'ENG'),
(452, 'NoData', 'No se encontraron datos', 14, 'ESP'),
(453, 'ModalTitle', 'Confirmation', 14, 'ENG'),
(454, 'ModalTitle', 'Confirmación', 14, 'ESP'),
(455, 'ModalText', 'Are you sure you want to delete this row with id', 14, 'ENG'),
(456, 'ModalText', '¿Estas seguro de que quieres eliminar la fila con el id', 14, 'ESP'),
(457, 'ModalButtonDelete', 'Delete', 14, 'ENG'),
(458, 'ModalButtonDelete', 'Eliminar', 14, 'ESP'),
(459, 'ModalButtonCancelar', 'Cancel', 14, 'ENG'),
(460, 'ModalButtonCancelar', 'Cancelar', 14, 'ESP'),
(461, 'TitleCreate', 'Create', 32, 'ENG'),
(462, 'TitleCreate', 'Crear', 32, 'ESP'),
(463, 'TitleUpdate', 'Update', 32, 'ENG'),
(464, 'TitleUpdate', 'Actualizar', 32, 'ESP'),
(465, 'ButtonCreate', 'Create', 32, 'ENG'),
(466, 'ButtonCreate', 'Crear', 32, 'ESP'),
(467, 'ButtonUpdate', 'Update', 32, 'ENG'),
(468, 'ButtonUpdate', 'Actualizar', 32, 'ESP'),
(469, 'Description', 'This is the Platform tab. all platforms information will be displayed here.', 12, 'ENG'),
(470, 'Description', 'Esta es la pestaña de las Plataformas. Aquí se mostrará la información de las Plataformas.', 12, 'ESP'),
(471, 'FilterTitle', 'Filters', 12, 'ENG'),
(472, 'FilterTitle', 'Filtros', 12, 'ESP'),
(473, 'fOrderBy', 'Order By', 12, 'ENG'),
(474, 'fOrderBy', 'Ordenar por', 12, 'ESP'),
(475, 'fSearchId', 'Search By ID', 12, 'ENG'),
(476, 'fSearchId', 'Buscar por ID', 12, 'ESP'),
(477, 'fSearchName', 'Search By Name', 12, 'ENG'),
(478, 'fSearchName', 'Buscar por Nombre', 12, 'ESP'),
(479, 'ButtonFilter', 'Filter', 12, 'ENG'),
(480, 'ButtonFilter', 'Filtrar', 12, 'ESP'),
(481, 'ButtonNew', 'New', 12, 'ENG'),
(482, 'ButtonNew', 'Nuevo', 12, 'ESP'),
(483, 'ButtonNext', 'Next', 12, 'ENG'),
(484, 'ButtonNext', 'Siguiente', 12, 'ESP'),
(485, 'ButtonPrevious', 'Previous', 12, 'ENG'),
(486, 'ButtonPrevious', 'Anterior', 12, 'ESP'),
(487, 'Actions', 'Actions', 12, 'ENG'),
(488, 'Actions', 'Acciones', 12, 'ESP'),
(489, 'Page', 'Page', 12, 'ENG'),
(490, 'Page', 'Página', 12, 'ESP'),
(491, 'Of', 'of', 12, 'ENG'),
(492, 'Of', 'de', 12, 'ESP'),
(493, 'Outof', 'out of', 12, 'ENG'),
(494, 'Outof', 'de', 12, 'ESP'),
(495, 'NoData', 'No data found', 12, 'ENG'),
(496, 'NoData', 'No se encontraron datos', 12, 'ESP'),
(497, 'ModalTitle', 'Confirmation', 12, 'ENG'),
(498, 'ModalTitle', 'Confirmación', 12, 'ESP'),
(499, 'ModalText', 'Are you sure you want to delete this row with id', 12, 'ENG'),
(500, 'ModalText', '¿Estas seguro de que quieres eliminar la fila con el id', 12, 'ESP'),
(501, 'ModalButtonDelete', 'Delete', 12, 'ENG'),
(502, 'ModalButtonDelete', 'Eliminar', 12, 'ESP'),
(503, 'ModalButtonCancelar', 'Cancel', 12, 'ENG'),
(504, 'ModalButtonCancelar', 'Cancelar', 12, 'ESP'),
(505, 'TitleCreate', 'Create', 33, 'ENG'),
(506, 'TitleCreate', 'Crear', 33, 'ESP'),
(507, 'TitleUpdate', 'Update', 33, 'ENG'),
(508, 'TitleUpdate', 'Actualizar', 33, 'ESP'),
(509, 'ButtonCreate', 'Create', 33, 'ENG'),
(510, 'ButtonCreate', 'Crear', 33, 'ESP'),
(511, 'ButtonUpdate', 'Update', 33, 'ENG'),
(512, 'ButtonUpdate', 'Actualizar', 33, 'ESP'),
(513, 'Description', 'This is the User tab. all users information will be displayed here.', 15, 'ENG'),
(514, 'Description', 'Esta es la pestaña de las Usuarios. Aquí se mostrará la información de los Usuarios.', 15, 'ESP'),
(515, 'FilterTitle', 'Filters', 15, 'ENG'),
(516, 'FilterTitle', 'Filtros', 15, 'ESP'),
(517, 'fOrderBy', 'Order By', 15, 'ENG'),
(518, 'fOrderBy', 'Ordenar por', 15, 'ESP'),
(519, 'fSearchId', 'Search By ID', 15, 'ENG'),
(520, 'fSearchId', 'Buscar por ID', 15, 'ESP'),
(521, 'fSearchUsername', 'Search By Username', 15, 'ENG'),
(522, 'fSearchUsername', 'Buscar por Alias', 15, 'ESP'),
(523, 'fSearchEmail', 'Search By Email', 15, 'ENG'),
(524, 'fSearchEmail', 'Buscar por Correo', 15, 'ESP'),
(525, 'ButtonFilter', 'Filter', 15, 'ENG'),
(526, 'ButtonFilter', 'Filtrar', 15, 'ESP'),
(527, 'ButtonNew', 'New', 15, 'ENG'),
(528, 'ButtonNew', 'Nuevo', 15, 'ESP'),
(529, 'ButtonNext', 'Next', 15, 'ENG'),
(530, 'ButtonNext', 'Siguiente', 15, 'ESP'),
(531, 'ButtonPrevious', 'Previous', 15, 'ENG'),
(532, 'ButtonPrevious', 'Anterior', 15, 'ESP'),
(533, 'Actions', 'Actions', 15, 'ENG'),
(534, 'Actions', 'Acciones', 15, 'ESP'),
(535, 'Page', 'Page', 15, 'ENG'),
(536, 'Page', 'Página', 15, 'ESP'),
(537, 'Of', 'of', 15, 'ENG'),
(538, 'Of', 'de', 15, 'ESP'),
(539, 'Outof', 'out of', 15, 'ENG'),
(540, 'Outof', 'de', 15, 'ESP'),
(541, 'NoData', 'No data found', 15, 'ENG'),
(542, 'NoData', 'No se encontraron datos', 15, 'ESP'),
(543, 'ModalTitle', 'Confirmation', 15, 'ENG'),
(544, 'ModalTitle', 'Confirmación', 15, 'ESP'),
(545, 'ModalText', 'Are you sure you want to delete this row with id', 15, 'ENG'),
(546, 'ModalText', '¿Estas seguro de que quieres eliminar la fila con el id', 15, 'ESP'),
(547, 'ModalButtonDelete', 'Delete', 15, 'ENG'),
(548, 'ModalButtonDelete', 'Eliminar', 15, 'ESP'),
(549, 'ModalButtonCancelar', 'Cancel', 15, 'ENG'),
(550, 'ModalButtonCancelar', 'Cancelar', 15, 'ESP'),
(551, 'TitleCreate', 'Create', 34, 'ENG'),
(552, 'TitleCreate', 'Crear', 34, 'ESP'),
(553, 'TitleUpdate', 'Update', 34, 'ENG'),
(554, 'TitleUpdate', 'Actualizar', 34, 'ESP'),
(555, 'ButtonCreate', 'Create', 34, 'ENG'),
(556, 'ButtonCreate', 'Crear', 34, 'ESP'),
(557, 'ButtonUpdate', 'Update', 34, 'ENG'),
(558, 'ButtonUpdate', 'Actualizar', 34, 'ESP'),
(559, 'Description', 'This is the Article tab. all the articles information will be displayed here.', 5, 'ENG'),
(560, 'Description', 'Esta es la pestaña de las Noticias. Aquí se mostrará la información de las Noticias.', 5, 'ESP'),
(561, 'FilterTitle', 'Filters', 5, 'ENG'),
(562, 'FilterTitle', 'Filtros', 5, 'ESP'),
(563, 'fOrderBy', 'Order By', 5, 'ENG'),
(564, 'fOrderBy', 'Ordenar por', 5, 'ESP'),
(565, 'fSearchId', 'Search By ID', 5, 'ENG'),
(566, 'fSearchId', 'Buscar por ID', 5, 'ESP'),
(567, 'fSearchHeadline', 'Search By Headline', 5, 'ENG'),
(568, 'fSearchHeadline', 'Buscar por Título', 5, 'ESP'),
(569, 'fSearchAuthor', 'Search By Author', 5, 'ENG'),
(570, 'fSearchAuthor', 'Buscar por Autor', 5, 'ESP'),
(571, 'fSearchIsPublished', 'is published', 5, 'ENG'),
(572, 'fSearchIsPublished', 'está published', 5, 'ESP'),
(573, 'fSearchLanguage', 'language', 5, 'ENG'),
(574, 'fSearchLanguage', 'idioma', 5, 'ESP'),
(575, 'ButtonFilter', 'Filter', 5, 'ENG'),
(576, 'ButtonFilter', 'Filtrar', 5, 'ESP'),
(577, 'ButtonNew', 'New', 5, 'ENG'),
(578, 'ButtonNew', 'Nuevo', 5, 'ESP'),
(579, 'ButtonNext', 'Next', 5, 'ENG'),
(580, 'ButtonNext', 'Siguiente', 5, 'ESP'),
(581, 'ButtonPrevious', 'Previous', 5, 'ENG'),
(582, 'ButtonPrevious', 'Anterior', 5, 'ESP'),
(583, 'Actions', 'Actions', 5, 'ENG'),
(584, 'Actions', 'Acciones', 5, 'ESP'),
(585, 'Page', 'Page', 5, 'ENG'),
(586, 'Page', 'Página', 5, 'ESP'),
(587, 'Of', 'of', 5, 'ENG'),
(588, 'Of', 'de', 5, 'ESP'),
(589, 'Outof', 'out of', 5, 'ENG'),
(590, 'Outof', 'de', 5, 'ESP'),
(591, 'NoData', 'No data found', 5, 'ENG'),
(592, 'NoData', 'No se encontraron datos', 5, 'ESP'),
(593, 'ModalTitle', 'Confirmation', 5, 'ENG'),
(594, 'ModalTitle', 'Confirmación', 5, 'ESP'),
(595, 'ModalText', 'Are you sure you want to delete this row with id', 5, 'ENG'),
(596, 'ModalText', '¿Estas seguro de que quieres eliminar la fila con el id', 5, 'ESP'),
(597, 'ModalButtonDelete', 'Delete', 5, 'ENG'),
(598, 'ModalButtonDelete', 'Eliminar', 5, 'ESP'),
(599, 'ModalButtonCancelar', 'Cancel', 5, 'ENG'),
(600, 'ModalButtonCancelar', 'Cancelar', 5, 'ESP'),
(601, 'TitleCreate', 'Create', 35, 'ENG'),
(602, 'TitleCreate', 'Crear', 35, 'ESP'),
(603, 'TitleUpdate', 'Update', 35, 'ENG'),
(604, 'TitleUpdate', 'Actualizar', 35, 'ESP'),
(605, 'ButtonCreate', 'Create', 35, 'ENG'),
(606, 'ButtonCreate', 'Crear', 35, 'ESP'),
(607, 'ButtonUpdate', 'Update', 35, 'ENG'),
(608, 'ButtonUpdate', 'Actualizar', 35, 'ESP');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `article`
--
ALTER TABLE `article`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_article_author1_idx` (`idAuthor`),
  ADD KEY `fk_article_lang` (`language`);

--
-- Indexes for table `author`
--
ALTER TABLE `author`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`),
  ADD UNIQUE KEY `phone_UNIQUE` (`phone`),
  ADD KEY `fk_author_lang` (`preferedLanguage`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dev`
--
ALTER TABLE `dev`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `game`
--
ALTER TABLE `game`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_game_publisher_idx` (`idPublisher`),
  ADD KEY `fk_game_dev1_idx` (`idDev`),
  ADD KEY `fk_game_platform1_idx` (`idPlatform`),
  ADD KEY `fk_game_lang` (`language`);

--
-- Indexes for table `game_article`
--
ALTER TABLE `game_article`
  ADD PRIMARY KEY (`idGame`,`idArticle`),
  ADD KEY `fk_game_has_article_article1_idx` (`idArticle`),
  ADD KEY `fk_game_has_article_game1_idx` (`idGame`);

--
-- Indexes for table `game_genre`
--
ALTER TABLE `game_genre`
  ADD PRIMARY KEY (`idGame`,`idGenre`),
  ADD KEY `fk_game_has_genre_genre1_idx` (`idGenre`),
  ADD KEY `fk_game_has_genre_game1_idx` (`idGame`);

--
-- Indexes for table `game_language`
--
ALTER TABLE `game_language`
  ADD PRIMARY KEY (`idGame`,`idLanguage`),
  ADD KEY `fk_game_has_language_language1_idx` (`idLanguage`),
  ADD KEY `fk_game_has_language_game1_idx` (`idGame`);

--
-- Indexes for table `game_player_type`
--
ALTER TABLE `game_player_type`
  ADD PRIMARY KEY (`idGame`,`idPlayerType`),
  ADD KEY `fk_game_has_player_type_player_type1_idx` (`idPlayerType`),
  ADD KEY `fk_game_has_player_type_game1_idx` (`idGame`);

--
-- Indexes for table `genre`
--
ALTER TABLE `genre`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_genre_lang` (`language`);

--
-- Indexes for table `language`
--
ALTER TABLE `language`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_lang_lang` (`language`);

--
-- Indexes for table `platform`
--
ALTER TABLE `platform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `player_type`
--
ALTER TABLE `player_type`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_pt_lang` (`language`);

--
-- Indexes for table `publisher`
--
ALTER TABLE `publisher`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username_UNIQUE` (`username`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`),
  ADD KEY `fk_user_lang` (`preferedLanguage`);

--
-- Indexes for table `user_fav_game`
--
ALTER TABLE `user_fav_game`
  ADD PRIMARY KEY (`idUser`,`idGame`),
  ADD KEY `fk_game_has_user_user1_idx` (`idUser`),
  ADD KEY `fk_game_has_user_game1_idx` (`idGame`);

--
-- Indexes for table `user_score_game`
--
ALTER TABLE `user_score_game`
  ADD PRIMARY KEY (`idUser`,`idGame`),
  ADD KEY `fk_user_has_game_game1_idx` (`idGame`),
  ADD KEY `fk_user_has_game_user1_idx` (`idUser`);

--
-- Indexes for table `web_language`
--
ALTER TABLE `web_language`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `lang_unique` (`name`),
  ADD UNIQUE KEY `icon_path_unique` (`icon`);

--
-- Indexes for table `web_text`
--
ALTER TABLE `web_text`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_webtext_cat` (`idCategory`),
  ADD KEY `fk_webtext_lang` (`language`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `article`
--
ALTER TABLE `article`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `author`
--
ALTER TABLE `author`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `dev`
--
ALTER TABLE `dev`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `game`
--
ALTER TABLE `game`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `genre`
--
ALTER TABLE `genre`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `language`
--
ALTER TABLE `language`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `platform`
--
ALTER TABLE `platform`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `player_type`
--
ALTER TABLE `player_type`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `publisher`
--
ALTER TABLE `publisher`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `web_text`
--
ALTER TABLE `web_text`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=609;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `article`
--
ALTER TABLE `article`
  ADD CONSTRAINT `fk_article_author1` FOREIGN KEY (`idAuthor`) REFERENCES `author` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_article_lang` FOREIGN KEY (`language`) REFERENCES `web_language` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `author`
--
ALTER TABLE `author`
  ADD CONSTRAINT `fk_author_lang` FOREIGN KEY (`preferedLanguage`) REFERENCES `web_language` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `game`
--
ALTER TABLE `game`
  ADD CONSTRAINT `fk_game_dev1` FOREIGN KEY (`idDev`) REFERENCES `dev` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_game_lang` FOREIGN KEY (`language`) REFERENCES `web_language` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_game_platform1` FOREIGN KEY (`idPlatform`) REFERENCES `platform` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_game_publisher` FOREIGN KEY (`idPublisher`) REFERENCES `publisher` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `game_article`
--
ALTER TABLE `game_article`
  ADD CONSTRAINT `fk_game_has_article_article1` FOREIGN KEY (`idArticle`) REFERENCES `article` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_game_has_article_game1` FOREIGN KEY (`idGame`) REFERENCES `game` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `game_genre`
--
ALTER TABLE `game_genre`
  ADD CONSTRAINT `fk_game_has_genre_game1` FOREIGN KEY (`idGame`) REFERENCES `game` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_game_has_genre_genre1` FOREIGN KEY (`idGenre`) REFERENCES `genre` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `game_language`
--
ALTER TABLE `game_language`
  ADD CONSTRAINT `fk_game_has_language_game1` FOREIGN KEY (`idGame`) REFERENCES `game` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_game_has_language_language1` FOREIGN KEY (`idLanguage`) REFERENCES `language` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `game_player_type`
--
ALTER TABLE `game_player_type`
  ADD CONSTRAINT `fk_game_has_player_type_game1` FOREIGN KEY (`idGame`) REFERENCES `game` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_game_has_player_type_player_type1` FOREIGN KEY (`idPlayerType`) REFERENCES `player_type` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `genre`
--
ALTER TABLE `genre`
  ADD CONSTRAINT `fk_genre_lang` FOREIGN KEY (`language`) REFERENCES `web_language` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `language`
--
ALTER TABLE `language`
  ADD CONSTRAINT `fk_lang_lang` FOREIGN KEY (`language`) REFERENCES `web_language` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `player_type`
--
ALTER TABLE `player_type`
  ADD CONSTRAINT `fk_pt_lang` FOREIGN KEY (`language`) REFERENCES `web_language` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `fk_user_lang` FOREIGN KEY (`preferedLanguage`) REFERENCES `web_language` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `user_fav_game`
--
ALTER TABLE `user_fav_game`
  ADD CONSTRAINT `fk_game_has_user_game1` FOREIGN KEY (`idGame`) REFERENCES `game` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_game_has_user_user1` FOREIGN KEY (`idUser`) REFERENCES `user` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `user_score_game`
--
ALTER TABLE `user_score_game`
  ADD CONSTRAINT `fk_user_has_game_game1` FOREIGN KEY (`idGame`) REFERENCES `game` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_user_has_game_user1` FOREIGN KEY (`idUser`) REFERENCES `user` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `web_text`
--
ALTER TABLE `web_text`
  ADD CONSTRAINT `fk_webtext_cat` FOREIGN KEY (`idCategory`) REFERENCES `category` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_webtext_lang` FOREIGN KEY (`language`) REFERENCES `web_language` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
