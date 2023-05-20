-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 20, 2023 at 01:02 PM
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateGame` (IN `pTitle` VARCHAR(255), IN `pSubtitle` VARCHAR(255), IN `pDescription` TEXT, IN `pLanguage` CHAR(3), IN `pCover` VARCHAR(255), IN `pReleaseDate` VARCHAR(10), IN `pTotalScore` TINYINT, IN `pIsFav` TINYINT, IN `pIdDev` INT, IN `pIdPlatform` INT, IN `pIdPublisher` INT, IN `pIdGenre` TEXT, IN `pIdPlayerType` TEXT, IN `pIdLanguage` TEXT)   BEGIN
  -- Drop the temporary tables if they already exist
  DROP TEMPORARY TABLE IF EXISTS temp_genre_ids;
  DROP TEMPORARY TABLE IF EXISTS temp_player_type_ids;
  DROP TEMPORARY TABLE IF EXISTS temp_language_ids;
  
  -- Create temporary tables to store the list of genre, player type, and language ids
  CREATE TEMPORARY TABLE temp_genre_ids (
    id INT NOT NULL
  );
  
  CREATE TEMPORARY TABLE temp_player_type_ids (
    id INT NOT NULL
  );
  
  CREATE TEMPORARY TABLE temp_language_ids (
    id INT NOT NULL
  );
  
  -- Insert the genre ids into the temporary table
  SET @genre_sql = CONCAT('INSERT INTO temp_genre_ids (id) VALUES (', REPLACE(pIdGenre, ',', '), ('), ')');
  PREPARE genre_stmt FROM @genre_sql;
  EXECUTE genre_stmt;
  
  -- Insert the player type ids into the temporary table
  SET @player_type_sql = CONCAT('INSERT INTO temp_player_type_ids (id) VALUES (', REPLACE(pIdPlayerType, ',', '), ('), ')');
  PREPARE player_type_stmt FROM @player_type_sql;
  EXECUTE player_type_stmt;
  
  -- Insert the language ids into the temporary table
  SET @language_sql = CONCAT('INSERT INTO temp_language_ids (id) VALUES (', REPLACE(pIdLanguage, ',', '), ('), ')');
  PREPARE language_stmt FROM @language_sql;
  EXECUTE language_stmt;
  
  -- Insert the game into the game table
  INSERT INTO game(title, subtitle, description, language, cover, releaseDate, totalScore, isFav, idDev, idPlatform, idPublisher)
  VALUES (pTitle, pSubtitle, pDescription, pLanguage, pCover, pReleaseDate, pTotalScore, pIsFav, pIdDev, pIdPlatform, pIdPublisher);
  
  -- Get the id of the newly inserted game
  SET @game_id = LAST_INSERT_ID();
  
  -- Insert the genre-game associations into the game_genre table
  INSERT INTO game_genre(idGame, idGenre)
  SELECT @game_id, id
  FROM temp_genre_ids;
  
  -- Insert the player type-game associations into the game_player_type table
  INSERT INTO game_player_type(idGame, idPlayerType)
  SELECT @game_id, id
  FROM temp_player_type_ids;
  
  -- Insert the language-game associations into the game_language table
  INSERT INTO game_language(idGame, idLanguage)
  SELECT @game_id, id
  FROM temp_language_ids;
  
  -- Drop the temporary tables
  DROP TEMPORARY TABLE IF EXISTS temp_genre_ids;
  DROP TEMPORARY TABLE IF EXISTS temp_player_type_ids;
  DROP TEMPORARY TABLE IF EXISTS temp_language_ids;
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteGame` (IN `pId` BIGINT)   BEGIN
  DELETE FROM game_genre WHERE idGame = pId;
  DELETE FROM game_player_type WHERE idGame = pId;
  DELETE FROM game_language WHERE idGame = pId;
  DELETE FROM user_fav_game WHERE idGame = pId;
  DELETE FROM user_score_game WHERE idGame = pId;
  DELETE FROM game_article  WHERE idGame = pId;

  DELETE FROM game WHERE id = pId;
 
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteUser` (IN `pId` BIGINT)   begin
	 DELETE FROM user_fav_game  WHERE idUser = pId;
	DELETE FROM user_score_game  WHERE idUser = pId;
DELETE FROM user WHERE id = pId;
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateGame` (IN `pId` BIGINT, IN `pTitle` VARCHAR(255), IN `pSubtitle` VARCHAR(255), IN `pDescription` TEXT, IN `pLanguage` CHAR(3), IN `pCover` VARCHAR(255), IN `pReleaseDate` VARCHAR(10), IN `pTotalScore` TINYINT, IN `pIsFav` TINYINT, IN `pIdDev` INT, IN `pIdPlatform` INT, IN `pIdPublisher` INT, IN `pIdGenre` TEXT, IN `pIdPlayerType` TEXT, IN `pIdLanguage` TEXT)   BEGIN
  
  -- Update the article in the article table
  UPDATE `game`
SET `title` = pTitle,
    `subtitle` = pSubtitle,
    `description` = pDescription,
    `language` = pLanguage,
    `cover` = pCover,
    `releaseDate` = pReleaseDate,
    `totalScore` = pTotalScore,
    `isFav` = pIsFav,
    `idDev` = pIdDev,
    `idPlatform` = pIdPlatform,
    `idPublisher` = pIdPublisher
WHERE `id` = pId;

  
  -- Delete all game-article associations for the given article
  DELETE FROM game_genre WHERE idGame = pId;
  DELETE FROM game_player_type WHERE idGame = pId;
  DELETE FROM game_language WHERE idGame = pId;
  
DROP TEMPORARY TABLE IF EXISTS temp_genre_ids;
  DROP TEMPORARY TABLE IF EXISTS temp_player_type_ids;
  DROP TEMPORARY TABLE IF EXISTS temp_language_ids;
  
  -- Create temporary tables to store the list of genre, player type, and language ids
  CREATE TEMPORARY TABLE temp_genre_ids (
    id INT NOT NULL
  );
  
  CREATE TEMPORARY TABLE temp_player_type_ids (
    id INT NOT NULL
  );
  
  CREATE TEMPORARY TABLE temp_language_ids (
    id INT NOT NULL
  );
  
  
  -- Insert the genre ids into the temporary table
  SET @genre_sql = CONCAT('INSERT INTO temp_genre_ids (id) VALUES (', REPLACE(pIdGenre, ',', '), ('), ')');
  PREPARE genre_stmt FROM @genre_sql;
  EXECUTE genre_stmt;
  
  -- Insert the player type ids into the temporary table
  SET @player_type_sql = CONCAT('INSERT INTO temp_player_type_ids (id) VALUES (', REPLACE(pIdPlayerType, ',', '), ('), ')');
  PREPARE player_type_stmt FROM @player_type_sql;
  EXECUTE player_type_stmt;
  
  -- Insert the language ids into the temporary table
  SET @language_sql = CONCAT('INSERT INTO temp_language_ids (id) VALUES (', REPLACE(pIdLanguage, ',', '), ('), ')');
  PREPARE language_stmt FROM @language_sql;
  EXECUTE language_stmt;
  
 INSERT INTO game_genre(idGame, idGenre)
  SELECT pId, id
  FROM temp_genre_ids;
  
  -- Insert the player type-game associations into the game_player_type table
  INSERT INTO game_player_type(idGame, idPlayerType)
  SELECT pId, id
  FROM temp_player_type_ids;
  
  -- Insert the language-game associations into the game_language table
  INSERT INTO game_language(idGame, idLanguage)
  SELECT pId, id
  FROM temp_language_ids;
  
  -- Drop the temporary tables
  DROP TEMPORARY TABLE IF EXISTS temp_genre_ids;
  DROP TEMPORARY TABLE IF EXISTS temp_player_type_ids;
  DROP TEMPORARY TABLE IF EXISTS temp_language_ids;
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
(31, 'AAAAAA', '<p>asdasd</p>', '<p>asdasd</p>', '/img/Cover/Article/cover_31.webp', 0, '2023-05-14 22:31:48', NULL, 10, 'ENG'),
(32, 'Vampire Survivors, bienvenido a tu nueva adicción', '<div>\r\n<div>Una de las primeras sorpresas de este 2022 es el triunfo en ventas de este modesto juego de acci&oacute;n que, con muy poco, consigue que nos cueste despegar los dedos del pad.</div>\r\n</div>', '<div>\r\n<div>Que el videojuego avance t&eacute;cnicamente no est&aacute; nunca de m&aacute;s: mejores gr&aacute;ficos, presentaciones m&aacute;s espectaculares, tecnolog&iacute;a de vanguardia&hellip; es todo parte del encanto de ser testigo del avance de un medio como &eacute;ste, en el que confluyen tantos factores art&iacute;sticos, tecnol&oacute;gicos y creativos. Pero siempre conviene recordar y tener en cuenta que una buena mec&aacute;nica de juego, por simple que sea, puede ser lo &uacute;nico que necesita un t&iacute;tulo para triunfar. Tal es el caso de Vampire Survivors, una de las tempranas sensaciones de Steam en este 2022, que ya acumula decenas de miles de usuarios y una valoraci&oacute;n &ldquo;Extremadamente Positiva&rdquo; despu&eacute;s de acumular m&aacute;s de 2000 an&aacute;lisis positivos frente a una veintena negativos.</div>\r\n<br>\r\n<div>Viendo las pantallas y el tr&aacute;iler la verdad es que el juego no levanta grandes expectativas. Un sprite pobremente animado de lo que parece un cazavampiros sacado de un Castlevania se va moviendo por un cutre mapeado bidimensional mientras decenas de enemigos salen a nuestro encuentro sin otra forma de ataque que acercarse a nuestra posici&oacute;n. Ni siquiera tenemos que atacar, ya que es autom&aacute;tico, s&oacute;lo controlamos el movimiento. Es un planteamiento que ya hemos visto en numerosas ocasiones, especialmente popular en flash dada la relativa simplicidad y facilidad de manejo. El reto es simplemente sobrevivir lo m&aacute;ximo posible antes del inevitable final, aunque en el caso de Vampire Survivors lo adereza con un componente roguelite que le viene como anillo al dedo.</div>\r\n<br>\r\n<h2>&lt;h2&gt;Planteamiento simple, diversi&oacute;n sin miramientos&lt;/h2&gt;</h2>\r\n<div>Como mandan los c&aacute;nones, hay un componente de progresi&oacute;n transitorio y otro permanente. Nuestro personaje ganar&aacute; niveles durante la partida recogiendo gemas que dejan los enemigos al morir y a cada nivel se nos dar&aacute; a elegir entre diferentes mejoras y habilidades para potenciar nuestra capacidad ofensiva y defensiva. No tenemos el control de cu&aacute;ndo o d&oacute;nde atacar, as&iacute; que nuestra prioridad es conseguir una combinaci&oacute;n que nos ayude a aguantar m&aacute;s tiempo, entre numerosas opciones aleatorias que ir&aacute;n apareciendo: bolas de fuego aleatorias, cuchillos que vuelan en l&iacute;nea recta, hachas voladoras que dibujan arcos ascendentes, cruces que act&uacute;an como boomerangs, barreras de ajo que da&ntilde;an al enemigo que se acerca, biblias que giran a nuestro alrededor (s&iacute;, la influencia de Castlevania est&aacute; poco disimulada). Tambi&eacute;n hay habilidades que aumentan las prestaciones b&aacute;sicas del personaje: m&aacute;s rapidez, m&aacute;s resistencia, m&aacute;s frecuencia de ataque, m&aacute;s n&uacute;mero de proyectiles&hellip; Hay que sumar el hecho de que cada uno de los personajes seleccionables tiene ciertas habilidades innatas que se manifiestan seg&uacute;n sube niveles, por lo que es responsabilidad del jugador elegir qu&eacute; priorizar para alcanzar un resultado &oacute;ptimo.</div>\r\n<br>\r\n<h2>&lt;h2&gt;Vampire Survivor PC&lt;/h2&gt;</h2>\r\n<div>En algunas ocasiones acabaremos con combinaciones con poca sinergia que har&aacute;n imposible sobrevivir a las oleadas de creciente n&uacute;mero y dificultad, con enemigos cada vez m&aacute;s numerosos, resistentes y r&aacute;pidos. Otras veces acertaremos a encontrar una combinaci&oacute;n ganadora que har&aacute; que nuestros enemigos caigan por miles y podamos resistir la media hora m&aacute;xima que podemos aguantar antes de que la muerte misma venga a llevarnos -en ese punto toda la pantalla est&aacute; rebosante de enemigos y el mapa no se ve, s&oacute;lo nosotros en el centro rodeado de enemigos que intentan desesperadamente llegar a nuestra posici&oacute;n mientras nuestro contador de muertes crece por centenares a cada segundo, muy satisfactorio y cat&aacute;rtico-. Factores como los bonus para subir nivel o la distancia a la que podremos atraer las preciadas gemas ser&aacute;n tambi&eacute;n importantes para que podamos progresar lo bastante r&aacute;pido como para afrontar los nuevos desaf&iacute;os. El hecho de que sean las gemas y no simplemente matar lo que nos hace subir de nivel nos obliga a estar en movimiento y no limitarnos a esperar en un sitio a que vengan por nosotros, lo que le da un acertado toque de dinamismo.</div>\r\n<br>\r\n<div>La parte de progresi&oacute;n permanente est&aacute; dividida en dos factores: si conseguimos ciertos objetivos en la anterior partida, como progresar un arma a cierto nivel, podremos desbloquear nuevos complementos e incluso nuevos personajes que usar, cada uno con una particularidad. Tambi&eacute;n acumularemos oro con el que conseguir bonificaciones permanentes que nos valdr&aacute;n para cada partida y nos permitir&aacute;n tener m&aacute;s posibilidades de llegar antes y mejor al punto al que queremos llegar. El componente de &ldquo;una partida m&aacute;s&rdquo; es poderoso, ya que siempre hay combinaciones que nos apetece probar y las partidas son r&aacute;pidas, no m&aacute;s de la media hora que hay ahora mismo de l&iacute;mite, por lo que resulta muy tentador echarse otra y ver c&oacute;mo lo hacemos en esta ocasi&oacute;n.</div>\r\n<br>\r\n<h2>Bueno, (no muy) bonito y barato</h2>\r\n<div>Vampire Survivors parte de una versi&oacute;n gratuita v&iacute;a web que podemos jugar para probarlo, siendo m&aacute;s limitada que la versi&oacute;n de pago en Early Access en Steam, que vale unos 2,39&euro; ahora mismo. Por ese precio encontramos un juego con m&aacute;s opciones que el gratuito, dos tipos de mapeado y m&aacute;s armas, adem&aacute;s de la promesa del desarrollador de ir mejor&aacute;ndolo y a&ntilde;adiendo contenido. La verdad es que por el precio, las horas de entretenimiento que ofrece hasta desbloquear todo lo que tiene actualmente es una ganga que nos puede entretener horas sin darnos cuenta. No parece que el desarrollador, poncle, tenga un plan detallado de progresi&oacute;n ahora mismo (o que esperase el &eacute;xito que ha encontrado, ya puestos) , pero se est&aacute; centrando actualmente en atajar bugs, mejorar calidad de vida y ajustes para hacer la experiencia m&aacute;s satisfactoria. En definitiva, uno de esos juegos que se puede recomendar sin tapujos aunque est&eacute; en Early Access y que s&oacute;lo puede mejorar de aqu&iacute; en adelante.</div>\r\n</div>', '/img/Cover/Article/cover_32.jpg', 1, '2023-05-20 04:35:49', '2023-05-20 04:39:09', 10, 'ENG');

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
(35, 'AdminArticleForm'),
(36, 'AdminGameForm'),
(37, 'ArticlePreview');

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
  `cover` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT '/img/Cover/Game/Default.png',
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
(1, 'Gameaa 1', 'Subtitle 1', '<p>Description 1</p>', 'ENG', '', '2023-05-19', 0, 0, 1, 2, 1),
(2, 'Game 2', 'Subtitle 2', 'Description 2', 'ESP', '/img/Cover/Game/Default.png', '2023-05-12', 0, 0, 2, 1, 1),
(3, 'Game 3', 'Subtitle 3', 'Description 3', 'ENG', '/img/Cover/Game/Default.png', '2023-05-12', 0, 0, 3, 2, 1),
(4, 'Game 4', 'Subtitle 4', 'Description 4', 'ESP', '/img/Cover/Game/Default.png', '2023-05-12', 0, 0, 1, 3, 1),
(6, 'Game 6', 'Subtitle 6', 'Description 6', 'ESP', '/img/Cover/Game/Default.png', '2023-05-12', 0, 0, 3, 2, 1);

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
(3, 32);

-- --------------------------------------------------------

--
-- Table structure for table `game_genre`
--

CREATE TABLE `game_genre` (
  `idGame` bigint NOT NULL,
  `idGenre` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

--
-- Dumping data for table `game_genre`
--

INSERT INTO `game_genre` (`idGame`, `idGenre`) VALUES
(1, 1),
(2, 2),
(1, 3),
(2, 4),
(4, 4),
(4, 6),
(4, 8);

-- --------------------------------------------------------

--
-- Table structure for table `game_language`
--

CREATE TABLE `game_language` (
  `idGame` bigint NOT NULL,
  `idLanguage` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

--
-- Dumping data for table `game_language`
--

INSERT INTO `game_language` (`idGame`, `idLanguage`) VALUES
(2, 1),
(4, 1),
(1, 4),
(3, 4),
(4, 4),
(4, 5),
(1, 6),
(4, 6);

-- --------------------------------------------------------

--
-- Table structure for table `game_player_type`
--

CREATE TABLE `game_player_type` (
  `idGame` bigint NOT NULL,
  `idPlayerType` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

--
-- Dumping data for table `game_player_type`
--

INSERT INTO `game_player_type` (`idGame`, `idPlayerType`) VALUES
(1, 1),
(4, 1),
(2, 2),
(4, 2),
(3, 3),
(4, 3);

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
(572, 'fSearchIsPublished', 'está publicado', 5, 'ESP'),
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
(608, 'ButtonUpdate', 'Actualizar', 35, 'ESP'),
(609, 'Description', 'This is the Game tab. all the games information will be displayed here.', 8, 'ENG'),
(610, 'Description', 'Esta es la pestaña de Juegos Aquí se mostrará la información de laos Juegos.', 8, 'ESP'),
(611, 'FilterTitle', 'Filters', 8, 'ENG'),
(612, 'FilterTitle', 'Filtros', 8, 'ESP'),
(613, 'fOrderBy', 'Order By', 8, 'ENG'),
(614, 'fOrderBy', 'Ordenar por', 8, 'ESP'),
(615, 'fSearchId', 'Search By ID', 8, 'ENG'),
(616, 'fSearchId', 'Buscar por ID', 8, 'ESP'),
(617, 'fSearchTitle', 'Search By Title', 8, 'ENG'),
(618, 'fSearchTitle', 'Buscar por Título', 8, 'ESP'),
(619, 'fSearchSubtitle', 'Search By Subtitle', 8, 'ENG'),
(620, 'fSearchSubtitle', 'Buscar por Subtítulo', 8, 'ESP'),
(621, 'fSearchLanguage', 'language', 8, 'ENG'),
(622, 'fSearchLanguage', 'idioma', 8, 'ESP'),
(623, 'ButtonFilter', 'Filter', 8, 'ENG'),
(624, 'ButtonFilter', 'Filtrar', 8, 'ESP'),
(625, 'ButtonNew', 'New', 8, 'ENG'),
(626, 'ButtonNew', 'Nuevo', 8, 'ESP'),
(627, 'ButtonNext', 'Next', 8, 'ENG'),
(628, 'ButtonNext', 'Siguiente', 8, 'ESP'),
(629, 'ButtonPrevious', 'Previous', 8, 'ENG'),
(630, 'ButtonPrevious', 'Anterior', 8, 'ESP'),
(631, 'Actions', 'Actions', 8, 'ENG'),
(632, 'Actions', 'Acciones', 8, 'ESP'),
(633, 'Page', 'Page', 8, 'ENG'),
(634, 'Page', 'Página', 8, 'ESP'),
(635, 'Of', 'of', 8, 'ENG'),
(636, 'Of', 'de', 8, 'ESP'),
(637, 'Outof', 'out of', 8, 'ENG'),
(638, 'Outof', 'de', 8, 'ESP'),
(639, 'NoData', 'No data found', 8, 'ENG'),
(640, 'NoData', 'No se encontraron datos', 8, 'ESP'),
(641, 'ModalTitle', 'Confirmation', 8, 'ENG'),
(642, 'ModalTitle', 'Confirmación', 8, 'ESP'),
(643, 'ModalText', 'Are you sure you want to delete this row with id', 8, 'ENG'),
(644, 'ModalText', '¿Estas seguro de que quieres eliminar la fila con el id', 8, 'ESP'),
(645, 'ModalButtonDelete', 'Delete', 8, 'ENG'),
(646, 'ModalButtonDelete', 'Eliminar', 8, 'ESP'),
(647, 'ModalButtonCancelar', 'Cancel', 8, 'ENG'),
(648, 'ModalButtonCancelar', 'Cancelar', 8, 'ESP'),
(649, 'TitleCreate', 'Create', 36, 'ENG'),
(650, 'TitleCreate', 'Crear', 36, 'ESP'),
(651, 'TitleUpdate', 'Update', 36, 'ENG'),
(652, 'TitleUpdate', 'Actualizar', 36, 'ESP'),
(653, 'ButtonCreate', 'Create', 36, 'ENG'),
(654, 'ButtonCreate', 'Crear', 36, 'ESP'),
(655, 'ButtonUpdate', 'Update', 36, 'ENG'),
(656, 'ButtonUpdate', 'Actualizar', 36, 'ESP'),
(657, 'tId', 'ID', 21, 'ENG'),
(658, 'tId', 'ID', 21, 'ESP'),
(659, 'tName', 'Name', 21, 'ENG'),
(660, 'tName', 'Nombre', 21, 'ESP'),
(661, 'tId', 'ID', 15, 'ENG'),
(662, 'tId', 'ID', 15, 'ESP'),
(663, 'tUsername', 'Username', 15, 'ENG'),
(664, 'tUserName', 'Usuario', 15, 'ESP'),
(665, 'tEmail', 'Email', 15, 'ENG'),
(666, 'tEmail', 'Correo', 15, 'ESP'),
(667, 'tAvatar', 'Avatar', 15, 'ENG'),
(668, 'tAvatar', 'Avatar', 15, 'ESP'),
(669, 'tPrefLanguage', 'Prefered Language', 15, 'ENG'),
(670, 'tPrefLanguage', 'Idioma Preferido', 15, 'ESP'),
(671, 'tBirthday', 'Birthday', 15, 'ENG'),
(672, 'tBirthday', 'Nacimiento', 15, 'ESP'),
(673, 'tCreationDate', 'Creation', 15, 'ENG'),
(674, 'tCreationDate', 'Creación', 15, 'ESP'),
(675, 'tFavGame', 'Fav. Games', 15, 'ENG'),
(676, 'tFavGame', 'Juegos Fav.', 15, 'ESP'),
(677, 'tScoredGame', 'Scored Games', 15, 'ENG'),
(678, 'tScoredGame', 'Juegos Puntuados', 15, 'ESP'),
(679, 'fId', 'ID', 34, 'ENG'),
(680, 'fId', 'ID', 34, 'ESP'),
(681, 'fUsername', 'Username', 34, 'ENG'),
(682, 'fUserName', 'Usuario', 34, 'ESP'),
(683, 'fPassword', 'Password', 34, 'ENG'),
(684, 'fPassword', 'Contraseña', 34, 'ESP'),
(685, 'fEmail', 'Email', 34, 'ENG'),
(686, 'fEmail', 'Correo', 34, 'ESP'),
(687, 'fAvatar', 'Avatar', 34, 'ENG'),
(688, 'fAvatar', 'Avatar', 34, 'ESP'),
(689, 'fPrefLanguage', 'Prefered Language', 34, 'ENG'),
(690, 'fPrefLanguage', 'Idioma Preferido', 34, 'ESP'),
(691, 'fBirthday', 'Birthday', 34, 'ENG'),
(692, 'fBirthday', 'Nacimiento', 34, 'ESP'),
(693, 'fId', 'ID', 22, 'ENG'),
(694, 'fId', 'ID', 22, 'ESP'),
(695, 'fName', 'Nmae', 22, 'ENG'),
(696, 'fName', 'Nombre', 22, 'ESP'),
(697, 'tId', 'ID', 6, 'ENG'),
(698, 'tId', 'ID', 6, 'ESP'),
(699, 'tEmail', 'Email', 6, 'ENG'),
(700, 'tEmail', 'Correo', 6, 'ESP'),
(701, 'tAvatar', 'Avatar', 6, 'ENG'),
(702, 'tAvatar', 'Avatar', 6, 'ESP'),
(703, 'tPrefLanguage', 'Prefered Language', 6, 'ENG'),
(704, 'tPrefLanguage', 'Idioma Preferido', 6, 'ESP'),
(705, 'tBirthday', 'Birthday', 6, 'ENG'),
(706, 'tBirthday', 'Nacimiento', 6, 'ESP'),
(707, 'tStartDate', 'Start', 6, 'ENG'),
(708, 'tStartDate', 'Inicio', 6, 'ESP'),
(709, 'tFinishDate', 'Finish', 6, 'ENG'),
(710, 'tFinishDate', 'Fin', 6, 'ESP'),
(711, 'tIsAdmin', 'Is Admin', 6, 'ENG'),
(712, 'tIsAdmin', 'Es Administrador', 6, 'ESP'),
(713, 'tCanPublish', 'Can Publish', 6, 'ENG'),
(714, 'tCanPublish', 'Puede Publicar', 6, 'ESP'),
(715, 'tIsActive', 'Is active', 6, 'ENG'),
(716, 'tIsActive', 'Está activo', 6, 'ESP'),
(717, 'tName', 'Name', 6, 'ENG'),
(718, 'tName', 'Nombre', 6, 'ESP'),
(719, 'tFirstName', 'First Name', 6, 'ENG'),
(720, 'tFirstName', 'Apellido', 6, 'ESP'),
(721, 'tSecondName', 'Second Name', 6, 'ENG'),
(722, 'tSecondName', 'Segundo Apellido', 6, 'ESP'),
(723, 'tPhone', 'Phone', 6, 'ENG'),
(724, 'tPhone', 'Teléfono', 6, 'ESP'),
(725, 'tDescription', 'Description', 6, 'ENG'),
(726, 'tDescription', 'Descripción', 6, 'ESP'),
(727, 'tArticleList', 'Articles', 6, 'ENG'),
(728, 'tArticleList', 'Artículos', 6, 'ESP'),
(729, 'fId', 'ID', 19, 'ENG'),
(730, 'fId', 'ID', 19, 'ESP'),
(731, 'fName', 'Nombre', 19, 'ESP'),
(732, 'fFirstName', 'First Name', 19, 'ENG'),
(733, 'fFirstName', 'Apellido', 19, 'ESP'),
(734, 'fSecondName', 'Second Name', 19, 'ENG'),
(735, 'fSecondName', 'Segundo Apellido', 19, 'ESP'),
(736, 'fPhone', 'Phone', 19, 'ENG'),
(737, 'fPhone', 'Teléfono', 19, 'ESP'),
(738, 'fDescription', 'Description', 19, 'ENG'),
(739, 'fDescription', 'Descripción', 19, 'ESP'),
(740, 'fPassword', 'Password', 19, 'ENG'),
(741, 'fPassword', 'Contraseña', 19, 'ESP'),
(742, 'fEmail', 'Email', 19, 'ENG'),
(743, 'fEmail', 'Correo', 19, 'ESP'),
(744, 'fAvatar', 'Avatar', 19, 'ENG'),
(745, 'fAvatar', 'Avatar', 19, 'ESP'),
(746, 'fPrefLanguage', 'Prefered Language', 19, 'ENG'),
(747, 'fPrefLanguage', 'Idioma Preferido', 19, 'ESP'),
(748, 'fBirthday', 'Birthday', 19, 'ENG'),
(749, 'fBirthday', 'Nacimiento', 19, 'ESP'),
(750, 'fStartDate', 'Start', 19, 'ENG'),
(751, 'fStartDate', 'Inicio', 19, 'ESP'),
(752, 'fFinishDate', 'Finish', 19, 'ENG'),
(753, 'fFinishDate', 'Fin', 19, 'ESP'),
(754, 'fIsAdmin', 'Is Admin', 19, 'ENG'),
(755, 'fIsAdmin', 'Es Administrador', 19, 'ESP'),
(756, 'fCanPublish', 'Can Publish', 19, 'ENG'),
(757, 'fCanPublish', 'Puede Publicar', 19, 'ESP'),
(758, 'fIsActive', 'Is active', 19, 'ENG'),
(759, 'fIsActive', 'Está activo', 19, 'ESP'),
(760, 'tId', 'ID', 5, 'ENG'),
(761, 'tId', 'ID', 5, 'ESP'),
(762, 'tHeadline', 'Headline', 5, 'ENG'),
(763, 'tHeadline', 'Titular', 5, 'ESP'),
(764, 'tSummary', 'Summary', 5, 'ENG'),
(765, 'tSummary', 'Resumen', 5, 'ESP'),
(766, 'tBody', 'Body', 5, 'ENG'),
(767, 'tBody', 'Cuerpo', 5, 'ESP'),
(768, 'tCover', 'Cover', 5, 'ENG'),
(769, 'tCover', 'Portada', 5, 'ESP'),
(770, 'tIsPublished', 'Is Published', 5, 'ENG'),
(771, 'tIsPublished', 'Está Publicado', 5, 'ESP'),
(772, 'tCreatedDate', 'Created', 5, 'ENG'),
(773, 'tCreatedDate', 'Fecha de Creación', 5, 'ESP'),
(774, 'tUpdatedDate', 'Updated', 5, 'ENG'),
(775, 'tUpdatedDate', 'Fecha de Actualización', 5, 'ESP'),
(776, 'tIdAuthor', 'ID Author', 5, 'ENG'),
(777, 'tIdAuthor', 'ID del Autor', 5, 'ESP'),
(778, 'tAuthor', 'Author', 5, 'ENG'),
(779, 'tAuthor', 'Autor', 5, 'ESP'),
(780, 'tCanPublish', 'Can Publish', 5, 'ENG'),
(781, 'tCanPublish', 'Puede Publicar', 5, 'ESP'),
(782, 'tLanguage', 'Language', 5, 'ENG'),
(783, 'tLanguage', 'Idioma', 5, 'ESP'),
(784, 'tGamesList', 'Games', 5, 'ENG'),
(785, 'tGamesList', 'Juegos', 5, 'ESP'),
(786, 'fId', 'ID', 35, 'ENG'),
(787, 'fId', 'ID', 35, 'ESP'),
(788, 'fHeadline', 'Headline', 35, 'ENG'),
(789, 'fHeadline', 'Titular', 35, 'ESP'),
(790, 'fSummary', 'Summary', 35, 'ENG'),
(791, 'fSummary', 'Resumen', 35, 'ESP'),
(792, 'fBody', 'Body', 35, 'ENG'),
(793, 'fBody', 'Cuerpo', 35, 'ESP'),
(794, 'fCover', 'Cover', 35, 'ENG'),
(795, 'fCover', 'Portada', 35, 'ESP'),
(796, 'fPublished', 'Publish', 35, 'ENG'),
(797, 'fPublished', 'Publicar', 35, 'ESP'),
(798, 'fCreatedDate', 'Created', 35, 'ENG'),
(799, 'fCreatedDate', 'Fecha de Creación', 35, 'ESP'),
(800, 'fUpdatedDate', 'Updated', 35, 'ENG'),
(801, 'fUpdatedDate', 'Fecha de Actualización', 35, 'ESP'),
(802, 'fAuthor', 'Author', 35, 'ENG'),
(803, 'fAuthor', 'Autor', 35, 'ESP'),
(804, 'fLanguage', 'Language', 35, 'ENG'),
(805, 'fLanguage', 'Idioma', 35, 'ESP'),
(806, 'fGamesList', 'Games', 35, 'ENG'),
(807, 'fGamesList', 'Juegos', 35, 'ESP'),
(808, 'tId', 'ID', 8, 'ENG'),
(809, 'tId', 'ID', 8, 'ESP'),
(810, 'tLanguage', 'Language', 8, 'ENG'),
(811, 'tLanguage', 'Idioma', 8, 'ESP'),
(812, 'tTitle', 'Title', 8, 'ENG'),
(813, 'tTitle', 'Título', 8, 'ESP'),
(814, 'tSubtitle', 'Subtitle', 8, 'ENG'),
(815, 'tSubtitle', 'Subtítulo', 8, 'ESP'),
(816, 'tDescription', 'Description', 8, 'ENG'),
(817, 'tDescription', 'Descripción', 8, 'ESP'),
(818, 'tCover', 'Cover', 8, 'ENG'),
(819, 'tCover', 'Portada', 8, 'ESP'),
(820, 'tReleaseDate', 'Release', 8, 'ENG'),
(821, 'tReleaseDate', 'Fecha de Lanzamiento', 8, 'ESP'),
(822, 'tTotalScore', 'Total Score', 8, 'ENG'),
(823, 'tTotalScore', 'Puntuación Total', 8, 'ESP'),
(824, 'tIsFav', 'Is Fav', 8, 'ENG'),
(825, 'tIsFav', 'Es Favorito', 8, 'ESP'),
(826, 'tIdDev', 'ID Dev', 8, 'ENG'),
(827, 'tIdDev', 'ID del Desarrollador', 8, 'ESP'),
(828, 'tDev', 'Developer', 8, 'ENG'),
(829, 'tDev', 'Desarrollador', 8, 'ESP'),
(830, 'tIdPlatform', 'ID Platform', 8, 'ENG'),
(831, 'tIdPlatform', 'ID de Plataforma', 8, 'ESP'),
(832, 'tIcon', 'Platform Icon', 8, 'ENG'),
(833, 'tIcon', 'Icono de Plataforma', 8, 'ESP'),
(834, 'tPlatform', 'Platform', 8, 'ENG'),
(835, 'tPlatform', 'Plataforma', 8, 'ESP'),
(836, 'tIdPublisher', 'ID Publisher', 8, 'ENG'),
(837, 'tIdPublisher', 'ID de Editor', 8, 'ESP'),
(838, 'tPublisher', 'Publisher', 8, 'ENG'),
(839, 'tPublisher', 'Editor', 8, 'ESP'),
(840, 'tGenresList', 'Genres', 8, 'ENG'),
(841, 'tGenresList', 'Géneros', 8, 'ESP'),
(842, 'tPlayerTypesList', 'Player Types', 8, 'ENG'),
(843, 'tPlayerTypesList', 'Tipos de Jugadores', 8, 'ESP'),
(844, 'tGameLanguagesList', 'Game Languages', 8, 'ENG'),
(845, 'tGameLanguagesList', 'Idiomas del Juego', 8, 'ESP'),
(846, 'tArticlesList', 'Articles', 8, 'ENG'),
(847, 'tArticlesList', 'Artículos', 8, 'ESP'),
(848, 'fId', 'ID', 36, 'ENG'),
(849, 'fId', 'ID', 36, 'ESP'),
(850, 'fLanguage', 'Language', 36, 'ENG'),
(851, 'fLanguage', 'Idioma', 36, 'ESP'),
(852, 'fTitle', 'Title', 36, 'ENG'),
(853, 'fTitle', 'Título', 36, 'ESP'),
(854, 'fSubtitle', 'Subtitle', 36, 'ENG'),
(855, 'fSubtitle', 'Subtítulo', 36, 'ESP'),
(856, 'fDescription', 'Description', 36, 'ENG'),
(857, 'fDescription', 'Descripción', 36, 'ESP'),
(858, 'fCover', 'Cover', 36, 'ENG'),
(859, 'fCover', 'Portada', 36, 'ESP'),
(860, 'fReleaseDate', 'Release', 36, 'ENG'),
(861, 'fReleaseDate', 'Fecha de Lanzamiento', 36, 'ESP'),
(862, 'fTotalScore', 'Total Score', 36, 'ENG'),
(863, 'fTotalScore', 'Puntuación Total', 36, 'ESP'),
(864, 'fIsFav', 'Is Fav', 36, 'ENG'),
(865, 'fIsFav', 'Es Favorito', 36, 'ESP'),
(866, 'fIdDev', 'ID Dev', 36, 'ENG'),
(867, 'fIdDev', 'ID del Desarrollador', 36, 'ESP'),
(868, 'fDev', 'Developer', 36, 'ENG'),
(869, 'fDev', 'Desarrollador', 36, 'ESP'),
(870, 'fIdPlatform', 'ID Platform', 36, 'ENG'),
(871, 'fIdPlatform', 'ID de Plataforma', 36, 'ESP'),
(872, 'fIcon', 'Platform Icon', 36, 'ENG'),
(873, 'fIcon', 'Icono de Plataforma', 36, 'ESP'),
(874, 'fPlatform', 'Platform', 36, 'ENG'),
(875, 'fPlatform', 'Plataforma', 36, 'ESP'),
(876, 'fIdPublisher', 'ID Publisher', 36, 'ENG'),
(877, 'fIdPublisher', 'ID de Editor', 36, 'ESP'),
(878, 'fPublisher', 'Publisher', 36, 'ENG'),
(879, 'fPublisher', 'Editor', 36, 'ESP'),
(880, 'fGenresList', 'Genres', 36, 'ENG'),
(881, 'fGenresList', 'Géneros', 36, 'ESP'),
(882, 'fPlayerTypesList', 'Player Types', 36, 'ENG'),
(883, 'fPlayerTypesList', 'Tipos de Jugadores', 36, 'ESP'),
(884, 'fGameLanguagesList', 'Game Languages', 36, 'ENG'),
(885, 'fGameLanguagesList', 'Idiomas del Juego', 36, 'ESP'),
(886, 'fArticlesList', 'Articles', 36, 'ENG'),
(887, 'fArticlesList', 'Artículos', 36, 'ESP'),
(888, 'tId', 'ID', 7, 'ENG'),
(889, 'tId', 'ID', 7, 'ESP'),
(890, 'tName', 'Name', 7, 'ENG'),
(891, 'tName', 'Nombre', 7, 'ESP'),
(892, 'tId', 'ID', 14, 'ENG'),
(893, 'tId', 'ID', 14, 'ESP'),
(894, 'tName', 'Name', 14, 'ENG'),
(895, 'tName', 'Nombre', 14, 'ESP'),
(896, 'tId', 'ID', 12, 'ENG'),
(897, 'tId', 'ID', 12, 'ESP'),
(898, 'tName', 'Name', 12, 'ENG'),
(899, 'tName', 'Nombre', 12, 'ESP'),
(900, 'tIcon', 'Icon', 12, 'ENG'),
(901, 'tIcon', 'Icono', 12, 'ESP'),
(902, 'tId', 'ID', 9, 'ENG'),
(903, 'tId', 'ID', 9, 'ESP'),
(904, 'tName', 'Name', 9, 'ENG'),
(905, 'tName', 'Nombre', 9, 'ESP'),
(906, 'tLanguage', 'Language', 9, 'ENG'),
(907, 'tLanguage', 'Idioma', 9, 'ESP'),
(908, 'tId', 'ID', 10, 'ENG'),
(909, 'tId', 'ID', 10, 'ESP'),
(910, 'tName', 'Name', 10, 'ENG'),
(911, 'tName', 'Nombre', 10, 'ESP'),
(912, 'tLanguage', 'Language', 10, 'ENG'),
(913, 'tLanguage', 'Idioma', 10, 'ESP'),
(914, 'tId', 'ID', 13, 'ENG'),
(915, 'tId', 'ID', 13, 'ESP'),
(916, 'tName', 'Name', 13, 'ENG'),
(917, 'tName', 'Nombre', 13, 'ESP'),
(918, 'tLanguage', 'Language', 13, 'ENG'),
(919, 'tLanguage', 'Idioma', 13, 'ESP'),
(920, 'fId', 'ID', 31, 'ENG'),
(921, 'fId', 'ID', 31, 'ESP'),
(922, 'fName', 'Name', 31, 'ENG'),
(923, 'fName', 'Nombre', 31, 'ESP'),
(924, 'fId', 'ID', 32, 'ENG'),
(925, 'fId', 'ID', 32, 'ESP'),
(926, 'fName', 'Name', 32, 'ENG'),
(927, 'fName', 'Nombre', 32, 'ESP'),
(928, 'fId', 'ID', 33, 'ENG'),
(929, 'fId', 'ID', 33, 'ESP'),
(930, 'fName', 'Name', 33, 'ENG'),
(931, 'fName', 'Nombre', 33, 'ESP'),
(932, 'fIcon', 'Icon', 33, 'ENG'),
(933, 'fIcon', 'Icono', 12, 'ESP'),
(934, 'fId', 'ID', 30, 'ENG'),
(935, 'fId', 'ID', 30, 'ESP'),
(936, 'fName', 'Name', 30, 'ENG'),
(937, 'fName', 'Nombre', 30, 'ESP'),
(938, 'fLanguage', 'Language', 30, 'ENG'),
(939, 'fLanguage', 'Idioma', 30, 'ESP'),
(940, 'fId', 'ID', 27, 'ENG'),
(941, 'fId', 'ID', 27, 'ESP'),
(942, 'fName', 'Name', 27, 'ENG'),
(943, 'fName', 'Nombre', 27, 'ESP'),
(944, 'fLanguage', 'Language', 27, 'ENG'),
(945, 'fLanguage', 'Idioma', 27, 'ESP'),
(946, 'fId', 'ID', 29, 'ENG'),
(947, 'fId', 'ID', 29, 'ESP'),
(948, 'fName', 'Name', 29, 'ENG'),
(949, 'fName', 'Nombre', 29, 'ESP'),
(950, 'fLanguage', 'Language', 29, 'ENG'),
(951, 'fLanguage', 'Idioma', 29, 'ESP'),
(952, 'tId', 'ID', 11, 'ENG'),
(953, 'tId', 'ID', 11, 'ESP'),
(954, 'tName', 'Name', 11, 'ENG'),
(955, 'tName', 'Nombre', 11, 'ESP'),
(956, 'tIcon', 'Icon', 11, 'ENG'),
(957, 'tIcon', 'Icono', 11, 'ESP'),
(958, 'fId', 'ID', 20, 'ENG'),
(959, 'fId', 'ID', 20, 'ESP'),
(960, 'fName', 'Name', 20, 'ENG'),
(961, 'fName', 'Nombre', 20, 'ESP'),
(962, 'fIcon', 'Icon', 20, 'ENG'),
(963, 'fIcon', 'Icono', 20, 'ESP'),
(964, 'tId', 'ID', 25, 'ENG'),
(965, 'tId', 'ID', 25, 'ESP'),
(966, 'tTitle', 'Title', 25, 'ENG'),
(967, 'tTitle', 'Título', 25, 'ESP'),
(968, 'tText', 'Text', 25, 'ENG'),
(969, 'tText', 'Texto', 25, 'ESP'),
(970, 'tCategory', 'Category', 25, 'ENG'),
(971, 'tCategory', 'Categoría', 25, 'ESP'),
(972, 'tLanguage', 'Language', 25, 'ENG'),
(973, 'tLanguage', 'Idioma', 25, 'ESP'),
(974, 'fId', 'ID', 26, 'ENG'),
(975, 'fId', 'ID', 26, 'ESP'),
(976, 'fTitle', 'Title', 26, 'ENG'),
(977, 'fTitle', 'Título', 26, 'ESP'),
(978, 'fText', 'Text', 26, 'ENG'),
(979, 'fText', 'Texto', 26, 'ESP'),
(980, 'fCategory', 'Category', 26, 'ENG'),
(981, 'fCategory', 'Categoría', 26, 'ESP'),
(982, 'fLanguage', 'Language', 26, 'ENG'),
(983, 'fLanguage', 'Idioma', 26, 'ESP'),
(984, 'fName', 'Name', 19, 'ENG'),
(985, 'tPreview', 'Preview', 5, 'ENG'),
(986, 'tPreview', 'Previsualizar', 5, 'ESP'),
(987, 'Created', 'Created', 37, 'ENG'),
(988, 'Created', 'Creado', 37, 'ESP'),
(989, 'Updated', 'Updated', 37, 'ENG'),
(990, 'Updated', 'Actualizado', 37, 'ESP'),
(991, 'tScore', 'Score', 8, 'ENG'),
(992, 'tScore', 'Puntuación', 8, 'ESP'),
(993, 'tIdCategory', 'ID Category', 25, 'ENG'),
(994, 'tIdCategory', 'ID de la Categoría', 25, 'ESP');

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
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `author`
--
ALTER TABLE `author`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `dev`
--
ALTER TABLE `dev`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `game`
--
ALTER TABLE `game`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

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
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=995;

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
