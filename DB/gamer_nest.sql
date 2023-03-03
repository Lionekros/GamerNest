-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema gamer_nest
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema gamer_nest
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `gamer_nest` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `gamer_nest` ;

-- -----------------------------------------------------
-- Table `gamer_nest`.`language`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gamer_nest`.`language` (
  `id` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gamer_nest`.`genre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gamer_nest`.`genre` (
  `id` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gamer_nest`.`player_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gamer_nest`.`player_type` (
  `id` TINYINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gamer_nest`.`platform`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gamer_nest`.`platform` (
  `id` SMALLINT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gamer_nest`.`publisher`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gamer_nest`.`publisher` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gamer_nest`.`dev`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gamer_nest`.`dev` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gamer_nest`.`author`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gamer_nest`.`author` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `firstLastName` VARCHAR(45) NOT NULL,
  `secondLatName` VARCHAR(45) NULL,
  `password` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `phone` VARCHAR(20) NOT NULL,
  `description` TEXT NULL,
  `avatar` VARCHAR(255) NULL,
  `isAdmin` TINYINT(1) NOT NULL DEFAULT 0,
  `canPublish` TINYINT(1) NOT NULL DEFAULT 0,
  `isActive` TINYINT(1) NOT NULL DEFAULT 1,
  `birthday` DATE NOT NULL,
  `startDate` DATETIME NOT NULL,
  `endDate` DATETIME NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `phone_UNIQUE` (`phone` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gamer_nest`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gamer_nest`.`user` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `avatar` VARCHAR(255) NULL DEFAULT 0,
  `isConfirmed` TINYINT(1) NOT NULL DEFAULT 1,
  `birthday` DATE NOT NULL,
  `creationDate` DATETIME NOT NULL,
  `token` VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gamer_nest`.`game`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gamer_nest`.`game` (
  `id` BIGINT NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `subtitle` VARCHAR(255) NULL,
  `description` TEXT NOT NULL,
  `cover` VARCHAR(255) NOT NULL,
  `releaseDate` DATE NOT NULL,
  `totalScore` TINYINT NOT NULL DEFAULT 0,
  `isApproved` TINYINT(1) NOT NULL DEFAULT 0,
  `isFav` TINYINT(1) NOT NULL DEFAULT 0,
  `idDev` INT NOT NULL,
  `idPlatform` SMALLINT NOT NULL,
  `idPublisher` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_game_publisher_idx` (`idPublisher` ASC) VISIBLE,
  INDEX `fk_game_dev1_idx` (`idDev` ASC) VISIBLE,
  INDEX `fk_game_platform1_idx` (`idPlatform` ASC) VISIBLE,
  CONSTRAINT `fk_game_publisher`
    FOREIGN KEY (`idPublisher`)
    REFERENCES `gamer_nest`.`publisher` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_game_dev1`
    FOREIGN KEY (`idDev`)
    REFERENCES `gamer_nest`.`dev` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_game_platform1`
    FOREIGN KEY (`idPlatform`)
    REFERENCES `gamer_nest`.`platform` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gamer_nest`.`article`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gamer_nest`.`article` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `headline` VARCHAR(255) NOT NULL,
  `summary` TEXT NOT NULL,
  `body` MEDIUMTEXT NOT NULL,
  `cover` VARCHAR(255) NOT NULL,
  `isPublished` TINYINT(1) NOT NULL,
  `createdDate` DATETIME NOT NULL,
  `updatedDate` DATETIME NULL,
  `idAuthor` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_article_author1_idx` (`idAuthor` ASC) VISIBLE,
  CONSTRAINT `fk_article_author1`
    FOREIGN KEY (`idAuthor`)
    REFERENCES `gamer_nest`.`author` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gamer_nest`.`game_language`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gamer_nest`.`game_language` (
  `idGame` BIGINT NOT NULL,
  `idLanguage` TINYINT NOT NULL,
  PRIMARY KEY (`idGame`, `idLanguage`),
  INDEX `fk_game_has_language_language1_idx` (`idLanguage` ASC) VISIBLE,
  INDEX `fk_game_has_language_game1_idx` (`idGame` ASC) VISIBLE,
  CONSTRAINT `fk_game_has_language_game1`
    FOREIGN KEY (`idGame`)
    REFERENCES `gamer_nest`.`game` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_game_has_language_language1`
    FOREIGN KEY (`idLanguage`)
    REFERENCES `gamer_nest`.`language` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gamer_nest`.`game_genre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gamer_nest`.`game_genre` (
  `idGame` BIGINT NOT NULL,
  `idGenre` TINYINT NOT NULL,
  PRIMARY KEY (`idGame`, `idGenre`),
  INDEX `fk_game_has_genre_genre1_idx` (`idGenre` ASC) VISIBLE,
  INDEX `fk_game_has_genre_game1_idx` (`idGame` ASC) VISIBLE,
  CONSTRAINT `fk_game_has_genre_game1`
    FOREIGN KEY (`idGame`)
    REFERENCES `gamer_nest`.`game` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_game_has_genre_genre1`
    FOREIGN KEY (`idGenre`)
    REFERENCES `gamer_nest`.`genre` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gamer_nest`.`game_player_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gamer_nest`.`game_player_type` (
  `idGame` BIGINT NOT NULL,
  `idPlayerType` TINYINT NOT NULL,
  PRIMARY KEY (`idGame`, `idPlayerType`),
  INDEX `fk_game_has_player_type_player_type1_idx` (`idPlayerType` ASC) VISIBLE,
  INDEX `fk_game_has_player_type_game1_idx` (`idGame` ASC) VISIBLE,
  CONSTRAINT `fk_game_has_player_type_game1`
    FOREIGN KEY (`idGame`)
    REFERENCES `gamer_nest`.`game` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_game_has_player_type_player_type1`
    FOREIGN KEY (`idPlayerType`)
    REFERENCES `gamer_nest`.`player_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gamer_nest`.`user_fav_game`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gamer_nest`.`user_fav_game` (
  `idUser` BIGINT NOT NULL,
  `idGame` BIGINT NOT NULL,
  PRIMARY KEY (`idUser`, `idGame`),
  INDEX `fk_game_has_user_user1_idx` (`idUser` ASC) VISIBLE,
  INDEX `fk_game_has_user_game1_idx` (`idGame` ASC) VISIBLE,
  CONSTRAINT `fk_game_has_user_game1`
    FOREIGN KEY (`idGame`)
    REFERENCES `gamer_nest`.`game` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_game_has_user_user1`
    FOREIGN KEY (`idUser`)
    REFERENCES `gamer_nest`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gamer_nest`.`user_score_game`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gamer_nest`.`user_score_game` (
  `idUser` BIGINT NOT NULL,
  `idGame` BIGINT NOT NULL,
  `score` TINYINT NOT NULL,
  PRIMARY KEY (`idUser`, `idGame`),
  INDEX `fk_user_has_game_game1_idx` (`idGame` ASC) VISIBLE,
  INDEX `fk_user_has_game_user1_idx` (`idUser` ASC) VISIBLE,
  CONSTRAINT `fk_user_has_game_user1`
    FOREIGN KEY (`idUser`)
    REFERENCES `gamer_nest`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_user_has_game_game1`
    FOREIGN KEY (`idGame`)
    REFERENCES `gamer_nest`.`game` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gamer_nest`.`game_article`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gamer_nest`.`game_article` (
  `idGame` BIGINT NOT NULL,
  `idArticle` BIGINT NOT NULL,
  PRIMARY KEY (`idGame`, `idArticle`),
  INDEX `fk_game_has_article_article1_idx` (`idArticle` ASC) VISIBLE,
  INDEX `fk_game_has_article_game1_idx` (`idGame` ASC) VISIBLE,
  CONSTRAINT `fk_game_has_article_game1`
    FOREIGN KEY (`idGame`)
    REFERENCES `gamer_nest`.`game` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_game_has_article_article1`
    FOREIGN KEY (`idArticle`)
    REFERENCES `gamer_nest`.`article` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
