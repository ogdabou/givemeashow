SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';


-- -----------------------------------------------------
-- Table `givemeashow`.`lang_iso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `givemeashow`.`lang_iso` ;

CREATE  TABLE IF NOT EXISTS `givemeashow`.`lang_iso` (
  `lang_iso` VARCHAR(2) NOT NULL ,
  PRIMARY KEY (`lang_iso`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `givemeashow`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `givemeashow`.`User` ;

CREATE  TABLE IF NOT EXISTS `givemeashow`.`User` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `login` VARCHAR(32) NOT NULL ,
  `is_admin` TINYINT(1) NOT NULL DEFAULT false ,
  `invite_code` VARCHAR(32) NOT NULL ,
  `password` VARCHAR(45) NOT NULL ,
  `time_spent` BIGINT NOT NULL DEFAULT 0 ,
  `default_lang` VARCHAR(2) NOT NULL ,
  `use_subtitles` TINYINT(1) NOT NULL DEFAULT false ,
  `sub_default_lang` VARCHAR(2) NOT NULL DEFAULT 'fr' ,
  `confirmed` TINYINT(1) NOT NULL DEFAULT false ,
  `email` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `dontcare` (`default_lang` ASC) ,
  INDEX `keytwo` (`sub_default_lang` ASC) ,
  CONSTRAINT `dontcare`
    FOREIGN KEY (`default_lang` )
    REFERENCES `givemeashow`.`lang_iso` (`lang_iso` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `keytwo`
    FOREIGN KEY (`sub_default_lang` )
    REFERENCES `givemeashow`.`lang_iso` (`lang_iso` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `givemeashow`.`fb_kind`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `givemeashow`.`fb_kind` ;

CREATE  TABLE IF NOT EXISTS `givemeashow`.`fb_kind` (
  `fb_kind` VARCHAR(10) NOT NULL ,
  PRIMARY KEY (`fb_kind`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `givemeashow`.`feedback`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `givemeashow`.`feedback` ;

CREATE  TABLE IF NOT EXISTS `givemeashow`.`feedback` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `user_id` INT NOT NULL ,
  `title` VARCHAR(100) NOT NULL ,
  `content` VARCHAR(600) NOT NULL ,
  `kind` VARCHAR(10) NOT NULL ,
  `hasBeenRead` TINYINT(1) NOT NULL ,
  `posted_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_feedback_1` (`user_id` ASC) ,
  INDEX `fk_feedback_2` (`kind` ASC) ,
  CONSTRAINT `fk_feedback_1`
    FOREIGN KEY (`user_id` )
    REFERENCES `givemeashow`.`User` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_feedback_2`
    FOREIGN KEY (`kind` )
    REFERENCES `givemeashow`.`fb_kind` (`fb_kind` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `givemeashow`.`fb_answer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `givemeashow`.`fb_answer` ;

CREATE  TABLE IF NOT EXISTS `givemeashow`.`fb_answer` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `fb_id` INT NOT NULL ,
  `posted_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `content` VARCHAR(600) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_fb_answer_1` (`fb_id` ASC) ,
  CONSTRAINT `fk_fb_answer_1`
    FOREIGN KEY (`fb_id` )
    REFERENCES `givemeashow`.`feedback` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `givemeashow`.`show`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `givemeashow`.`show` ;

CREATE  TABLE IF NOT EXISTS `givemeashow`.`show` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(150) NOT NULL ,
  `icon_url` VARCHAR(150) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `givemeashow`.`season`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `givemeashow`.`season` ;

CREATE  TABLE IF NOT EXISTS `givemeashow`.`season` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(200) NOT NULL ,
  `position` INT NOT NULL ,
  `icon_url` VARCHAR(150) NOT NULL ,
  `show_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_season_1` (`show_id` ASC) ,
  CONSTRAINT `fk_season_1`
    FOREIGN KEY (`show_id` )
    REFERENCES `givemeashow`.`show` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `givemeashow`.`video`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `givemeashow`.`video` ;

CREATE  TABLE IF NOT EXISTS `givemeashow`.`video` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `title` VARCHAR(150) NOT NULL ,
  `season_id` INT NOT NULL ,
  `lang_iso` VARCHAR(2) NOT NULL ,
  `position` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_video_1` (`lang_iso` ASC) ,
  INDEX `fk_video_2` (`season_id` ASC) ,
  CONSTRAINT `fk_video_1`
    FOREIGN KEY (`lang_iso` )
    REFERENCES `givemeashow`.`lang_iso` (`lang_iso` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_video_2`
    FOREIGN KEY (`season_id` )
    REFERENCES `givemeashow`.`season` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `givemeashow`.`subtitle`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `givemeashow`.`subtitle` ;

CREATE  TABLE IF NOT EXISTS `givemeashow`.`subtitle` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `video_id` INT NOT NULL ,
  `lang_iso` VARCHAR(2) NOT NULL ,
  `url` VARCHAR(150) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_subtitle_1` (`lang_iso` ASC) ,
  INDEX `fk_subtitle_2` (`video_id` ASC) ,
  CONSTRAINT `fk_subtitle_1`
    FOREIGN KEY (`lang_iso` )
    REFERENCES `givemeashow`.`lang_iso` (`lang_iso` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_subtitle_2`
    FOREIGN KEY (`video_id` )
    REFERENCES `givemeashow`.`video` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;