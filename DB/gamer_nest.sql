-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 09, 2023 at 07:57 PM
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
  `birthday` date NOT NULL,
  `startDate` date NOT NULL,
  `endDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

--
-- Dumping data for table `author`
--

INSERT INTO `author` (`id`, `name`, `firstLastName`, `secondLastName`, `password`, `email`, `phone`, `description`, `avatar`, `preferedLanguage`, `isAdmin`, `canPublish`, `isActive`, `birthday`, `startDate`, `endDate`) VALUES
(1, 'John', 'Doe', 'Smith', 'password123', 'john.doe@email.com', '1234567890', NULL, NULL, 'ENG', 0, 0, 1, '1990-01-01', '2022-01-01', NULL),
(3, 'Sarah', 'Johnson', NULL, 'password456', 'sarah.johnson@email.com', '2345678901', NULL, NULL, 'ENG', 0, 0, 1, '1995-03-15', '2022-02-01', NULL),
(4, 'Michael', 'Chang', 'Wong', 'password789', 'michael.chang@email.com', '3456789012', NULL, NULL, 'ENG', 0, 0, 1, '1987-12-10', '2022-03-01', NULL),
(5, 'Karen', 'Lee', 'Kim', 'password1234', 'karen.lee@email.com', '4567890123', NULL, NULL, 'ENG', 0, 1, 1, '1980-08-25', '2022-04-01', NULL),
(6, 'David', 'Wu', NULL, 'password5678', 'david.wu@email.com', '5678901234', NULL, NULL, 'ENG', 1, 0, 1, '1992-05-20', '2022-05-01', NULL),
(7, 'Sophia', 'Nguyen', 'Tran', 'password91011', 'sophia.nguyen@email.com', '6789012345', NULL, NULL, 'ENG', 0, 0, 1, '1999-11-30', '2022-06-01', NULL),
(8, 'William', 'Park', 'Jung', 'password121314', 'william.park@email.com', '7890123456', NULL, NULL, 'ENG', 0, 0, 1, '1985-04-05', '2022-07-01', NULL),
(9, 'Olivia', 'Garcia', NULL, 'password151617', 'olivia.garcia@email.com', '8901234567', NULL, NULL, 'ENG', 0, 0, 1, '1997-08-08', '2022-08-01', NULL),
(10, 'Cristina', 'Carbonell', 'Matamoros', '$2a$12$MZ8Yv12l3gj/C.6i0B.S6OZErlbW1AondFJtxHAkaAf.VNW1RZbN6', 'cristicarmat2@gmail.com', '965878965', 'AAAAAAAAA AAAAA A A A AAAAAAA AAAAAAAAA A AAAA A AAAAA A AA A A A A AA A A', '/img/Banner/Logo.png', 'ENG', 1, 1, 1, '2013-04-09', '2023-04-03', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

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
(1, 'PlayStation 5', ''),
(2, 'Xbox Series X', ''),
(3, 'Nintendo Switch', ''),
(4, 'PlayStation 4', ''),
(5, 'Xbox One', ''),
(6, 'PC', ''),
(7, 'Mac', ''),
(8, 'Linux', ''),
(9, 'Mobile', ''),
(10, 'PlayStation 3', ''),
(11, 'Xbox 360', ''),
(12, 'Nintendo Wii', '');

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
('ENG', 'English', 'english_icon.png'),
('ESP', 'Spanish', 'spanish_icon.png');

-- --------------------------------------------------------

--
-- Table structure for table `web_text`
--

CREATE TABLE `web_text` (
  `id` int NOT NULL,
  `text` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `idCategory` int NOT NULL,
  `language` char(3) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL DEFAULT 'ENG'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

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
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

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
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

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
