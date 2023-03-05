-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Mar 05, 2023 at 02:03 PM
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
  `headline` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `summary` text COLLATE utf8mb3_bin NOT NULL,
  `body` mediumtext COLLATE utf8mb3_bin NOT NULL,
  `cover` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `isPublished` tinyint NOT NULL,
  `createdDate` datetime NOT NULL,
  `updatedDate` datetime DEFAULT NULL,
  `idAuthor` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

-- --------------------------------------------------------

--
-- Table structure for table `author`
--

CREATE TABLE `author` (
  `id` int NOT NULL,
  `name` varchar(45) COLLATE utf8mb3_bin NOT NULL,
  `firstLastName` varchar(45) COLLATE utf8mb3_bin NOT NULL,
  `secondLatName` varchar(45) COLLATE utf8mb3_bin DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `email` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `phone` varchar(20) COLLATE utf8mb3_bin NOT NULL,
  `description` text COLLATE utf8mb3_bin,
  `avatar` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `isAdmin` tinyint NOT NULL DEFAULT '0',
  `canPublish` tinyint NOT NULL DEFAULT '0',
  `isActive` tinyint NOT NULL DEFAULT '1',
  `birthday` date NOT NULL,
  `startDate` datetime NOT NULL,
  `endDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

-- --------------------------------------------------------

--
-- Table structure for table `dev`
--

CREATE TABLE `dev` (
  `id` int NOT NULL,
  `name` varchar(45) COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

--
-- Dumping data for table `dev`
--

INSERT INTO `dev` (`id`, `name`) VALUES
(9, 'Bethesda Game Studios'),
(3, 'Blizzard Entertainment'),
(6, 'CD Projekt Red'),
(8, 'Capcom'),
(5, 'Electronic Arts'),
(7, 'Naughty Dog'),
(10, 'Nintendo'),
(1, 'Rockstar Games'),
(4, 'Square Enix'),
(2, 'Ubisoft');

-- --------------------------------------------------------

--
-- Table structure for table `game`
--

CREATE TABLE `game` (
  `id` bigint NOT NULL,
  `title` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `subtitle` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `description` text COLLATE utf8mb3_bin NOT NULL,
  `cover` varchar(255) COLLATE utf8mb3_bin NOT NULL,
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
  `name` varchar(45) COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

--
-- Dumping data for table `genre`
--

INSERT INTO `genre` (`id`, `name`) VALUES
(1, 'Action'),
(2, 'Adventure'),
(8, 'Fighting'),
(9, 'Puzzle'),
(7, 'Racing'),
(3, 'Role-playing'),
(10, 'Shooter'),
(4, 'Simulation'),
(6, 'Sports'),
(5, 'Strategy');

-- --------------------------------------------------------

--
-- Table structure for table `language`
--

CREATE TABLE `language` (
  `id` int NOT NULL,
  `name` varchar(45) COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

-- --------------------------------------------------------

--
-- Table structure for table `platform`
--

CREATE TABLE `platform` (
  `id` int NOT NULL,
  `name` varchar(45) COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

--
-- Dumping data for table `platform`
--

INSERT INTO `platform` (`id`, `name`) VALUES
(8, 'Linux'),
(7, 'Mac'),
(9, 'Mobile'),
(3, 'Nintendo Switch'),
(12, 'Nintendo Wii'),
(6, 'PC'),
(10, 'PlayStation 3'),
(4, 'PlayStation 4'),
(1, 'PlayStation 5'),
(11, 'Xbox 360'),
(5, 'Xbox One'),
(2, 'Xbox Series X');

-- --------------------------------------------------------

--
-- Table structure for table `player_type`
--

CREATE TABLE `player_type` (
  `id` int NOT NULL,
  `name` varchar(45) COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

-- --------------------------------------------------------

--
-- Table structure for table `publisher`
--

CREATE TABLE `publisher` (
  `id` int NOT NULL,
  `name` varchar(45) COLLATE utf8mb3_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` bigint NOT NULL,
  `username` varchar(45) COLLATE utf8mb3_bin NOT NULL,
  `password` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `email` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `avatar` varchar(255) COLLATE utf8mb3_bin DEFAULT '0',
  `isConfirmed` tinyint NOT NULL DEFAULT '1',
  `birthday` date NOT NULL,
  `creationDate` datetime NOT NULL,
  `token` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL
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

--
-- Indexes for dumped tables
--

--
-- Indexes for table `article`
--
ALTER TABLE `article`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_article_author1_idx` (`idAuthor`);

--
-- Indexes for table `author`
--
ALTER TABLE `author`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`),
  ADD UNIQUE KEY `phone_UNIQUE` (`phone`);

--
-- Indexes for table `dev`
--
ALTER TABLE `dev`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name_UNIQUE` (`name`);

--
-- Indexes for table `game`
--
ALTER TABLE `game`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_game_publisher_idx` (`idPublisher`),
  ADD KEY `fk_game_dev1_idx` (`idDev`),
  ADD KEY `fk_game_platform1_idx` (`idPlatform`);

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
  ADD UNIQUE KEY `name_UNIQUE` (`name`);

--
-- Indexes for table `language`
--
ALTER TABLE `language`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name_UNIQUE` (`name`);

--
-- Indexes for table `platform`
--
ALTER TABLE `platform`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name_UNIQUE` (`name`);

--
-- Indexes for table `player_type`
--
ALTER TABLE `player_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name_UNIQUE` (`name`);

--
-- Indexes for table `publisher`
--
ALTER TABLE `publisher`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name_UNIQUE` (`name`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username_UNIQUE` (`username`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`);

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
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dev`
--
ALTER TABLE `dev`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `game`
--
ALTER TABLE `game`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `genre`
--
ALTER TABLE `genre`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

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
-- Constraints for dumped tables
--

--
-- Constraints for table `article`
--
ALTER TABLE `article`
  ADD CONSTRAINT `fk_article_author1` FOREIGN KEY (`idAuthor`) REFERENCES `author` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `game`
--
ALTER TABLE `game`
  ADD CONSTRAINT `fk_game_dev1` FOREIGN KEY (`idDev`) REFERENCES `dev` (`id`) ON UPDATE CASCADE,
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
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
