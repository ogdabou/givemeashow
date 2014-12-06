-- MySQL Script generated by MySQL Workbench
-- 12/06/14 21:53:00
-- Model: New Model    Version: 1.0
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema givemeashow
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `givemeashow` ;
CREATE SCHEMA IF NOT EXISTS `givemeashow` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `givemeashow` ;

-- -----------------------------------------------------
-- Table `givemeashow`.`lang_iso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `givemeashow`.`lang_iso` ;

CREATE TABLE IF NOT EXISTS `givemeashow`.`lang_iso` (
  `lang_iso` VARCHAR(2) NOT NULL,
  `lang_name` VARCHAR(45) NOT NULL,
  `lang_flag_url` VARCHAR(200) NULL,
  PRIMARY KEY (`lang_iso`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `givemeashow`.`User_roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `givemeashow`.`User_roles` ;

CREATE TABLE IF NOT EXISTS `givemeashow`.`User_roles` (
  `user_role` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`user_role`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `givemeashow`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `givemeashow`.`User` ;

CREATE TABLE IF NOT EXISTS `givemeashow`.`User` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(32) NOT NULL,
  `is_admin` TINYINT(1) NOT NULL DEFAULT false,
  `password` VARCHAR(60) NOT NULL,
  `time_spent` BIGINT NOT NULL DEFAULT 0,
  `default_lang` VARCHAR(2) NOT NULL,
  `use_subtitles` TINYINT(1) NOT NULL DEFAULT false,
  `sub_default_lang` VARCHAR(2) NOT NULL DEFAULT 'fr',
  `confirmed` TINYINT(1) NOT NULL DEFAULT false,
  `email` VARCHAR(100) NOT NULL,
  `user_role` VARCHAR(45) NOT NULL,
  `invited` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `dontcare_idx` (`default_lang` ASC),
  INDEX `keytwo_idx` (`sub_default_lang` ASC),
  INDEX `fk_User_User_roles1_idx` (`user_role` ASC),
  CONSTRAINT `dontcare`
    FOREIGN KEY (`default_lang`)
    REFERENCES `givemeashow`.`lang_iso` (`lang_iso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `keytwo`
    FOREIGN KEY (`sub_default_lang`)
    REFERENCES `givemeashow`.`lang_iso` (`lang_iso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_User_roles1`
    FOREIGN KEY (`user_role`)
    REFERENCES `givemeashow`.`User_roles` (`user_role`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `givemeashow`.`fb_kind`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `givemeashow`.`fb_kind` ;

CREATE TABLE IF NOT EXISTS `givemeashow`.`fb_kind` (
  `fb_kind` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`fb_kind`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `givemeashow`.`feedback`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `givemeashow`.`feedback` ;

CREATE TABLE IF NOT EXISTS `givemeashow`.`feedback` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `title` VARCHAR(100) NOT NULL,
  `content` VARCHAR(600) NOT NULL,
  `kind` VARCHAR(10) NOT NULL,
  `hasBeenRead` TINYINT(1) NOT NULL,
  `posted_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_feedback_1_idx` (`user_id` ASC),
  INDEX `fk_feedback_2_idx` (`kind` ASC),
  CONSTRAINT `fk_feedback_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `givemeashow`.`User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_feedback_2`
    FOREIGN KEY (`kind`)
    REFERENCES `givemeashow`.`fb_kind` (`fb_kind`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `givemeashow`.`fb_answer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `givemeashow`.`fb_answer` ;

CREATE TABLE IF NOT EXISTS `givemeashow`.`fb_answer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fb_id` INT NOT NULL,
  `posted_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `content` VARCHAR(600) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_fb_answer_1_idx` (`fb_id` ASC),
  CONSTRAINT `fk_fb_answer_1`
    FOREIGN KEY (`fb_id`)
    REFERENCES `givemeashow`.`feedback` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `givemeashow`.`show`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `givemeashow`.`show` ;

CREATE TABLE IF NOT EXISTS `givemeashow`.`show` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(150) NOT NULL,
  `icon_url` VARCHAR(600) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `givemeashow`.`season`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `givemeashow`.`season` ;

CREATE TABLE IF NOT EXISTS `givemeashow`.`season` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `position` INT NOT NULL,
  `icon_url` VARCHAR(150) NOT NULL,
  `show_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_season_1_idx` (`show_id` ASC),
  CONSTRAINT `fk_season_1`
    FOREIGN KEY (`show_id`)
    REFERENCES `givemeashow`.`show` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `givemeashow`.`video`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `givemeashow`.`video` ;

CREATE TABLE IF NOT EXISTS `givemeashow`.`video` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(150) NOT NULL,
  `season_id` INT NOT NULL,
  `lang_iso` VARCHAR(2) NOT NULL,
  `position` INT NOT NULL,
  `is_transition` TINYINT(1) NOT NULL,
  `relative_path` VARCHAR(500) NOT NULL,
  `viewed` MEDIUMTEXT NOT NULL,
  `url` VARCHAR(250) NOT NULL,
  `show_id` INT NOT NULL,
  `end_intro_time` DECIMAL NULL,
  `start_outro_time` DECIMAL NULL,
  `validated` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_video_1_idx` (`lang_iso` ASC),
  INDEX `fk_video_2_idx` (`season_id` ASC),
  INDEX `fk_video_show1_idx` (`show_id` ASC),
  UNIQUE INDEX `relative_path_UNIQUE` (`relative_path` ASC),
  CONSTRAINT `fk_video_1`
    FOREIGN KEY (`lang_iso`)
    REFERENCES `givemeashow`.`lang_iso` (`lang_iso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_video_2`
    FOREIGN KEY (`season_id`)
    REFERENCES `givemeashow`.`season` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_video_show1`
    FOREIGN KEY (`show_id`)
    REFERENCES `givemeashow`.`show` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `givemeashow`.`subtitle`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `givemeashow`.`subtitle` ;

CREATE TABLE IF NOT EXISTS `givemeashow`.`subtitle` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `video_id` INT NOT NULL,
  `lang_iso` VARCHAR(2) NOT NULL,
  `url` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_subtitle_1_idx` (`lang_iso` ASC),
  INDEX `fk_subtitle_2_idx` (`video_id` ASC),
  CONSTRAINT `fk_subtitle_1`
    FOREIGN KEY (`lang_iso`)
    REFERENCES `givemeashow`.`lang_iso` (`lang_iso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_subtitle_2`
    FOREIGN KEY (`video_id`)
    REFERENCES `givemeashow`.`video` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `givemeashow`.`props`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `givemeashow`.`props` ;

CREATE TABLE IF NOT EXISTS `givemeashow`.`props` (
  `id` INT NOT NULL,
  `schema_version` VARCHAR(45) NOT NULL,
  `giveme_version` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `givemeashow`.`invite_code`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `givemeashow`.`invite_code` ;

CREATE TABLE IF NOT EXISTS `givemeashow`.`invite_code` (
  `varc` VARCHAR(32) NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`varc`),
  INDEX `fk_invite_code_User1_idx` (`user_id` ASC),
  CONSTRAINT `fk_invite_code_User1`
    FOREIGN KEY (`user_id`)
    REFERENCES `givemeashow`.`User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
