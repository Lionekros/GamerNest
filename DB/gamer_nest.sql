-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 01, 2023 at 06:52 PM
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateWebLanguage` (IN `pId` CHAR(3), IN `pName` VARCHAR(255), IN `pIcon` VARCHAR(255))   BEGIN
  INSERT INTO web_language(id, name, icon)
  VALUES(pId, pName, pIcon);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateWebText` (IN `pTitle` VARCHAR(255), IN `pText` TEXT, IN `pIdCategory` INT, IN `pLanguage` CHAR(3))   BEGIN
  INSERT INTO `web_text` (`title`, `text`, `idCategory`, `language`)
  VALUES (pTitle, pText, pIdCategory, pLanguage);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteAuthor` (IN `pId` INT)   BEGIN
    DELETE FROM `author`
    WHERE `id` = pId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteCategory` (IN `pId` INT)   BEGIN
    DELETE FROM `category` WHERE `id` = pId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteWebLanguage` (IN `pId` CHAR(3))   BEGIN
  DELETE FROM web_language
  WHERE id = pId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteWebText` (IN `pId` INT)   BEGIN
  DELETE FROM `web_text`
  WHERE `id` = pId;
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
  `cover` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `isPublished` tinyint NOT NULL,
  `createdDate` datetime NOT NULL,
  `updatedDate` datetime DEFAULT NULL,
  `idAuthor` int NOT NULL,
  `language` char(3) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

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
(12, 'Lidia', 'Echuaca', NULL, '$2a$12$MZ8Yv12l3gj/C.6i0B.S6OZErlbW1AondFJtxHAkaAf.VNW1RZbN6', 'lidia@gmail.com', '587698569', '<p>si leeis esto es un mensaje de ayuda cristiana me tiene secuestrada soy una esclava auxilio &aacute;NGEL</p>', '/img/Avatar/Author/avatar_12.jpg', 'ESP', 0, 1, 1, '2023-04-22', '2023-04-22', NULL),
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
(10, 'AdminLanguage (Game)'),
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
(26, 'AdminTextForm');

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
  `releaseDate` date NOT NULL,
  `totalScore` tinyint NOT NULL DEFAULT '0',
  `isApproved` tinyint NOT NULL DEFAULT '0',
  `isFav` tinyint NOT NULL DEFAULT '0',
  `idDev` int NOT NULL,
  `idPlatform` int NOT NULL,
  `idPublisher` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

-- --------------------------------------------------------

--
-- Table structure for table `game_article`
--

CREATE TABLE `game_article` (
  `idGame` bigint NOT NULL,
  `idArticle` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

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

-- --------------------------------------------------------

--
-- Table structure for table `publisher`
--

CREATE TABLE `publisher` (
  `id` int NOT NULL,
  `name` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` bigint NOT NULL,
  `username` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT '0',
  `preferedLanguage` char(3) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `isConfirmed` tinyint NOT NULL DEFAULT '1',
  `birthday` date NOT NULL,
  `creationDate` datetime NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

-- --------------------------------------------------------

--
-- Table structure for table `user_fav_game`
--

CREATE TABLE `user_fav_game` (
  `idUser` bigint NOT NULL,
  `idGame` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

-- --------------------------------------------------------

--
-- Table structure for table `user_score_game`
--

CREATE TABLE `user_score_game` (
  `idUser` bigint NOT NULL,
  `idGame` bigint NOT NULL,
  `score` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

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
(232, 'ModalButtonCancelar', 'Cancelar', 25, 'ESP');

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
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `author`
--
ALTER TABLE `author`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `dev`
--
ALTER TABLE `dev`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `game`
--
ALTER TABLE `game`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `genre`
--
ALTER TABLE `genre`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `language`
--
ALTER TABLE `language`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `platform`
--
ALTER TABLE `platform`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `player_type`
--
ALTER TABLE `player_type`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `publisher`
--
ALTER TABLE `publisher`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `web_text`
--
ALTER TABLE `web_text`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=234;

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
