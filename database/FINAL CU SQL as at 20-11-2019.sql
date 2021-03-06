-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema cudb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema cudb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cudb` DEFAULT CHARACTER SET utf8 ;
USE `cudb` ;

-- -----------------------------------------------------
-- Table `cudb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cudb`.`user` (
  `user_id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_email` VARCHAR(255) NOT NULL,
  `user_fname` VARCHAR(255) NOT NULL,
  `user_lname` VARCHAR(255) NOT NULL,
  `user_phobeNo` VARCHAR(255) NULL DEFAULT NULL,
  `user_regno` VARCHAR(45) NULL DEFAULT NULL,
  `user_course` VARCHAR(500) NULL DEFAULT NULL,
  `user_pwd` LONGTEXT NOT NULL,
  `user_joindate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_img` VARCHAR(255) NULL DEFAULT '0',
  `user_verified` TINYINT(4) NULL DEFAULT '0' COMMENT 'This field will determined if the Email Address of the User is Verified. 0 means NO and 1 means YES',
  `registered_by` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC),
  UNIQUE INDEX `user_email_UNIQUE` (`user_email` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 294
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `cudb`.`admin`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cudb`.`admin` (
  `admin_fk_user_id` INT(11) NOT NULL,
  `admin_type` VARCHAR(45) NULL DEFAULT NULL,
  `admin_registered_by` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`admin_fk_user_id`),
  INDEX `fk_admin_user1_idx` (`admin_fk_user_id` ASC),
  CONSTRAINT `fk_admin_user1`
    FOREIGN KEY (`admin_fk_user_id`)
    REFERENCES `cudb`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `cudb`.`announcement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cudb`.`announcement` (
  `announcement_id` INT(11) NOT NULL,
  `announcement_title` VARCHAR(45) NULL DEFAULT NULL,
  `announcemet_maker` VARCHAR(45) NOT NULL,
  `announcement_text` LONGTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`announcement_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `cudb`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cudb`.`category` (
  `category_name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`category_name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `cudb`.`article`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cudb`.`article` (
  `article_id` INT(11) NOT NULL AUTO_INCREMENT,
  `article_tittle` VARCHAR(255) NOT NULL,
  `article_text` LONGTEXT NOT NULL,
  `article_pub_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `article_edit_date` DATETIME NULL DEFAULT NULL,
  `articleimg` VARCHAR(255) NULL DEFAULT '0',
  `article_fk_user_id` INT(11) NOT NULL,
  `likes` INT(11) NULL DEFAULT NULL,
  `article_status` TINYINT(4) NULL DEFAULT '0',
  `category_fk_category_name` VARCHAR(255) NOT NULL,
  `verified_by` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`article_id`),
  INDEX `fk_article_user_idx` (`article_fk_user_id` ASC),
  INDEX `fk_article_category1_idx` (`category_fk_category_name` ASC),
  CONSTRAINT `fk_article_category1`
    FOREIGN KEY (`category_fk_category_name`)
    REFERENCES `cudb`.`category` (`category_name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_article_user`
    FOREIGN KEY (`article_fk_user_id`)
    REFERENCES `cudb`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `cudb`.`article_comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cudb`.`article_comments` (
  `article_comments_id` INT(11) NOT NULL AUTO_INCREMENT,
  `comment` LONGTEXT NOT NULL,
  `article_comment_fk_article_id` INT(11) NOT NULL,
  `article_comments_fk_user_id` INT(11) NOT NULL,
  `parent_comment_id` INT(11) NOT NULL DEFAULT 0,
  `article_comment_date` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`article_comments_id`),
  UNIQUE INDEX `article_comments_id_UNIQUE` (`article_comments_id` ASC),
  INDEX `fk_article_comments_article1_idx` (`article_comment_fk_article_id` ASC),
  INDEX `fk_article_comments_user1_idx` (`article_comments_fk_user_id` ASC),
  CONSTRAINT `fk_article_comments_article1`
    FOREIGN KEY (`article_comment_fk_article_id`)
    REFERENCES `cudb`.`article` (`article_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_article_comments_user1`
    FOREIGN KEY (`article_comments_fk_user_id`)
    REFERENCES `cudb`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `cudb`.`comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cudb`.`comments` (
  `comments_id` INT(11) NOT NULL AUTO_INCREMENT,
  `commets_name` VARCHAR(45) NOT NULL,
  `comments_email` VARCHAR(45) NOT NULL,
  `message` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`comments_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `cudb`.`event`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cudb`.`event` (
  `event_id` INT(11) NOT NULL,
  `event_name` VARCHAR(45) NULL DEFAULT NULL,
  `event_descp` VARCHAR(45) NULL DEFAULT NULL,
  `event_img` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`event_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `cudb`.`ministries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cudb`.`ministries` (
  `mty_id` VARCHAR(45) NOT NULL,
  `mty_leader` VARCHAR(45) NULL DEFAULT NULL,
  `mty_desc` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`mty_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `cudb`.`position`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cudb`.`position` (
  `position_name` VARCHAR(45) NOT NULL COMMENT 'This is the name of the leaders position',
  PRIMARY KEY (`position_name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `cudb`.`leaders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cudb`.`leaders` (
  `leaders_fk_user_id` INT(11) NOT NULL,
  `leaders_fk_mty_id` VARCHAR(45) NULL DEFAULT NULL,
  `leaders_quote` TEXT NULL DEFAULT NULL COMMENT 'Thsi table will contains the leaders of various ministries\\\\n',
  `leaders_fk_position_name` VARCHAR(45) NOT NULL,
  `leader_added_by` VARCHAR(255) NULL DEFAULT NULL,
  `leaders_img` LONGBLOB NULL DEFAULT NULL,
  PRIMARY KEY (`leaders_fk_user_id`),
  INDEX `fk_leaders_user1_idx` (`leaders_fk_user_id` ASC),
  INDEX `fk_leaders_ministries1_idx` (`leaders_fk_mty_id` ASC),
  INDEX `fk_leaders_position1_idx` (`leaders_fk_position_name` ASC),
  CONSTRAINT `fk_leaders_ministries1`
    FOREIGN KEY (`leaders_fk_mty_id`)
    REFERENCES `cudb`.`ministries` (`mty_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_leaders_position1`
    FOREIGN KEY (`leaders_fk_position_name`)
    REFERENCES `cudb`.`position` (`position_name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_leaders_user1`
    FOREIGN KEY (`leaders_fk_user_id`)
    REFERENCES `cudb`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `cudb`.`ministries_has_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cudb`.`ministries_has_user` (
  `fk_mty_id` VARCHAR(45) NOT NULL,
  `fk_user_id` INT(11) NOT NULL,
  PRIMARY KEY (`fk_mty_id`, `fk_user_id`),
  INDEX `fk_ministries_has_user_user1_idx` (`fk_user_id` ASC),
  INDEX `fk_ministries_has_user_ministries1_idx` (`fk_mty_id` ASC),
  CONSTRAINT `fk_ministries_has_user_ministries1`
    FOREIGN KEY (`fk_mty_id`)
    REFERENCES `cudb`.`ministries` (`mty_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ministries_has_user_user1`
    FOREIGN KEY (`fk_user_id`)
    REFERENCES `cudb`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `cudb`.`notification`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cudb`.`notification` (
  `notification_id` INT(11) NOT NULL,
  `notification_title` VARCHAR(45) NULL DEFAULT NULL,
  `notification_text` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`notification_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `cudb`.`pages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cudb`.`pages` (
  `pages_name` INT(11) NOT NULL,
  `page_title` VARCHAR(45) NOT NULL,
  `pages_content` LONGTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`pages_name`, `page_title`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `cudb`.`pwdreset`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cudb`.`pwdreset` (
  `pwdreset_id` INT(11) NOT NULL AUTO_INCREMENT,
  `pwdreset_email` VARCHAR(255) NULL DEFAULT NULL,
  `pwdreset_selector` LONGTEXT NULL DEFAULT NULL,
  `pwdreset_token` LONGTEXT NULL DEFAULT NULL,
  `pwdreset_expires` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`pwdreset_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 12
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `cudb`.`sentmail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cudb`.`sentmail` (
  `sentmail_id` INT(11) NOT NULL,
  `sentmail_from` VARCHAR(45) NOT NULL,
  `sentmail_to` VARCHAR(45) NOT NULL,
  `sentmail_subject` VARCHAR(45) NOT NULL,
  `sentmail_message` LONGTEXT NOT NULL,
  PRIMARY KEY (`sentmail_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `cudb`.`subcom`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cudb`.`subcom` (
  `subcom_name` VARCHAR(255) NOT NULL,
  `subcom_fk_mty_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`subcom_name`, `subcom_fk_mty_id`),
  INDEX `fk_subcom_ministries1_idx` (`subcom_fk_mty_id` ASC),
  CONSTRAINT `fk_subcom_ministries1`
    FOREIGN KEY (`subcom_fk_mty_id`)
    REFERENCES `cudb`.`ministries` (`mty_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `cudb`.`subcom_mbs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cudb`.`subcom_mbs` (
  `subcom_mbs_id` INT(11) NOT NULL AUTO_INCREMENT,
  `subcom_mbs_fk_subcom_name` VARCHAR(255) NULL DEFAULT NULL,
  `subcom_mbs_fk_user_id` INT(11) NOT NULL,
  `ministries_fk_mty_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`subcom_mbs_id`),
  INDEX `fk_subcom_mbs_subcom1_idx` (`subcom_mbs_fk_subcom_name` ASC),
  INDEX `fk_subcom_mbs_user1_idx` (`subcom_mbs_fk_user_id` ASC),
  INDEX `fk_subcom_mbs_ministries1_idx` (`ministries_fk_mty_id` ASC),
  CONSTRAINT `fk_subcom_mbs_ministries1`
    FOREIGN KEY (`ministries_fk_mty_id`)
    REFERENCES `cudb`.`ministries` (`mty_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_subcom_mbs_subcom1`
    FOREIGN KEY (`subcom_mbs_fk_subcom_name`)
    REFERENCES `cudb`.`subcom` (`subcom_name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_subcom_mbs_user1`
    FOREIGN KEY (`subcom_mbs_fk_user_id`)
    REFERENCES `cudb`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `cudb`.`subscribers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cudb`.`subscribers` (
  `subscribers_id` INT(11) NOT NULL,
  `subscribers_email` VARCHAR(45) NULL DEFAULT NULL,
  `subscriberscol` VARCHAR(45) NULL DEFAULT NULL,
  `subscribers_fk_user_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`subscribers_id`),
  INDEX `fk_subscribers_user1_idx` (`subscribers_fk_user_id` ASC),
  CONSTRAINT `fk_subscribers_user1`
    FOREIGN KEY (`subscribers_fk_user_id`)
    REFERENCES `cudb`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `cudb`.`timestamps`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cudb`.`timestamps` (
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` TIMESTAMP NULL);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
