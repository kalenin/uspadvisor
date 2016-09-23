SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `uspadvisor` ;
CREATE SCHEMA IF NOT EXISTS `uspadvisor` DEFAULT CHARACTER SET utf8 ;
USE `uspadvisor` ;

-- -----------------------------------------------------
-- Table `uspadvisor`.`disciplines`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `uspadvisor`.`disciplines` ;

CREATE TABLE IF NOT EXISTS `uspadvisor`.`disciplines` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `code` VARCHAR(45) NOT NULL,
  `circular_structure` VARCHAR(45) NOT NULL,
  `syllabus` TEXT NULL DEFAULT NULL,
  `category` VARCHAR(45) NULL DEFAULT NULL,
  `approval_criteria` VARCHAR(45) NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uspadvisor`.`professors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `uspadvisor`.`professors` ;

CREATE TABLE IF NOT EXISTS `uspadvisor`.`professors` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `num_usp` CHAR(9) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `entry_year` INT NULL DEFAULT NULL,
  `tags` MEDIUMTEXT NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uspadvisor`.`students`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `uspadvisor`.`students` ;

CREATE TABLE IF NOT EXISTS `uspadvisor`.`students` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `num_usp` CHAR(9) NOT NULL,
  `entry_year` INT NULL DEFAULT NULL,
  `email` VARCHAR(45) NOT NULL,
  `email_validation_token` CHAR(32) NULL DEFAULT NULL,
  `email_validated_at` TIMESTAMP NULL DEFAULT NULL,
  `tags` MEDIUMTEXT NULL DEFAULT NULL,
  `password_hash` CHAR(60) NOT NULL,
  `password_recovery_token` CHAR(32) NULL DEFAULT NULL,
  `password_recovery_until` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uspadvisor`.`offerings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `uspadvisor`.`offerings` ;

CREATE TABLE IF NOT EXISTS `uspadvisor`.`offerings` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `discipline_id` INT NOT NULL,
  `professor_id` INT NOT NULL,
  `year` INT NULL DEFAULT NULL,
  `period` VARCHAR(45) NULL DEFAULT NULL,
  `schedule` VARCHAR(45) NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_offerings_1_idx` (`discipline_id` ASC),
  INDEX `fk_offerings_2_idx` (`professor_id` ASC),
  CONSTRAINT `fk_offerings_1`
    FOREIGN KEY (`discipline_id`)
    REFERENCES `uspadvisor`.`disciplines` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_offerings_2`
    FOREIGN KEY (`professor_id`)
    REFERENCES `uspadvisor`.`professors` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uspadvisor`.`evaluations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `uspadvisor`.`evaluations` ;

CREATE TABLE IF NOT EXISTS `uspadvisor`.`evaluations` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `offering_id` INT NOT NULL,
  `student_id` INT NOT NULL,
  `dificulty` INT NULL DEFAULT NULL,
  `quality` INT NULL DEFAULT NULL,
  `tags` MEDIUMTEXT NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_evaluations_1_idx` (`offering_id` ASC),
  INDEX `fk_evaluations_2_idx` (`student_id` ASC),
  CONSTRAINT `fk_evaluations_1`
    FOREIGN KEY (`offering_id`)
    REFERENCES `uspadvisor`.`offerings` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_evaluations_2`
    FOREIGN KEY (`student_id`)
    REFERENCES `uspadvisor`.`students` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `uspadvisor`.`comments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `uspadvisor`.`comments` ;

CREATE TABLE IF NOT EXISTS `uspadvisor`.`comments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `offering_id` INT NOT NULL,
  `student_id` INT NOT NULL,
  `comment` TEXT NULL DEFAULT NULL,
  `tags` MEDIUMTEXT NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_comments_1_idx` (`offering_id` ASC),
  INDEX `fk_comments_2_idx` (`student_id` ASC),
  CONSTRAINT `fk_comments_1`
    FOREIGN KEY (`offering_id`)
    REFERENCES `uspadvisor`.`offerings` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comments_2`
    FOREIGN KEY (`student_id`)
    REFERENCES `uspadvisor`.`students` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
