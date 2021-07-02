
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


CREATE SCHEMA IF NOT EXISTS `blood donation` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `blood donation` ;

-- -----------------------------------------------------
-- Table `blood donation`.`blood_bank`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blood donation`.`blood_bank` (
  `BBNAME` VARCHAR(20) NOT NULL,
  `BBCONTACT` INT NOT NULL,
  `BBADDRESS` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`BBNAME`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blood donation`.`storage`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blood donation`.`storage` (
  `blood_id` INT NOT NULL AUTO_INCREMENT,
  `donor_name` VARCHAR(20) NOT NULL,
  `blood_type` VARCHAR(2) NOT NULL,
  `date_taken` DATE NOT NULL,
  `expiry_date` DATE NOT NULL,
  PRIMARY KEY (`blood_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blood donation`.`blood_bank_has_storage`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blood donation`.`blood_bank_has_storage` (
  `blood_bank_BBNAME` VARCHAR(20) NOT NULL,
  `storage_blood_id` INT NOT NULL,
  PRIMARY KEY (`blood_bank_BBNAME`, `storage_blood_id`),
  INDEX `fk_blood_bank_has_storage_storage1_idx` (`storage_blood_id` ASC) VISIBLE,
  INDEX `fk_blood_bank_has_storage_blood_bank_idx` (`blood_bank_BBNAME` ASC) VISIBLE,
  CONSTRAINT `fk_blood_bank_has_storage_blood_bank`
    FOREIGN KEY (`blood_bank_BBNAME`)
    REFERENCES `blood donation`.`blood_bank` (`BBNAME`),
  CONSTRAINT `fk_blood_bank_has_storage_storage1`
    FOREIGN KEY (`storage_blood_id`)
    REFERENCES `blood donation`.`storage` (`blood_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blood donation`.`donor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blood donation`.`donor` (
  `donor_id` INT NOT NULL AUTO_INCREMENT,
  `donor_name` VARCHAR(20) NOT NULL,
  `donor_gender` TINYTEXT NOT NULL,
  `donor_contact` VARCHAR(20) NOT NULL,
  `donor_address` VARCHAR(30) NOT NULL,
  `blood_bank_BBNAME` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`donor_id`),
  INDEX `fk_donor_blood_bank1_idx` (`blood_bank_BBNAME` ASC) VISIBLE,
  CONSTRAINT `fk_donor_blood_bank1`
    FOREIGN KEY (`blood_bank_BBNAME`)
    REFERENCES `blood donation`.`blood_bank` (`BBNAME`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 21
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blood donation`.`donor_medical_report`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blood donation`.`donor_medical_report` (
  `donor_id` INT NOT NULL AUTO_INCREMENT,
  `donor_blood_group` VARCHAR(2) NOT NULL,
  `donor_status` VARCHAR(10) NOT NULL,
  `donor_birthdate` DATE NOT NULL,
  `donor_weight` VARCHAR(6) NOT NULL,
  `donor_height` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`donor_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blood donation`.`donor_has_donor_medical_report`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blood donation`.`donor_has_donor_medical_report` (
  `donor_donor_id` INT NOT NULL,
  `donor_medical_report_donor_id` INT NOT NULL,
  PRIMARY KEY (`donor_donor_id`, `donor_medical_report_donor_id`),
  INDEX `fk_donor_has_donor_medical_report_donor_medical_report1_idx` (`donor_medical_report_donor_id` ASC) VISIBLE,
  INDEX `fk_donor_has_donor_medical_report_donor1_idx` (`donor_donor_id` ASC) VISIBLE,
  CONSTRAINT `fk_donor_has_donor_medical_report_donor1`
    FOREIGN KEY (`donor_donor_id`)
    REFERENCES `blood donation`.`donor` (`donor_id`),
  CONSTRAINT `fk_donor_has_donor_medical_report_donor_medical_report1`
    FOREIGN KEY (`donor_medical_report_donor_id`)
    REFERENCES `blood donation`.`donor_medical_report` (`donor_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blood donation`.`recepient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blood donation`.`recepient` (
  `recepient_id` INT NOT NULL AUTO_INCREMENT,
  `recepient_name` VARCHAR(20) NOT NULL,
  `recepient_gender` TINYTEXT NOT NULL,
  `recepient_contact` VARCHAR(20) NOT NULL,
  `recepient_address` VARCHAR(30) NOT NULL,
  `blood_bank_BBNAME` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`recepient_id`),
  INDEX `fk_recepient_blood_bank1_idx` (`blood_bank_BBNAME` ASC) VISIBLE,
  CONSTRAINT `fk_recepient_blood_bank1`
    FOREIGN KEY (`blood_bank_BBNAME`)
    REFERENCES `blood donation`.`blood_bank` (`BBNAME`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blood donation`.`recepient_medical_report`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blood donation`.`recepient_medical_report` (
  `recepient_id` INT NOT NULL AUTO_INCREMENT,
  `recepient_blood_group` VARCHAR(2) NOT NULL,
  `recepient_health_status` VARCHAR(10) NOT NULL,
  `recepient_birthdate` DATE NOT NULL,
  `recepient_weight` VARCHAR(6) NOT NULL,
  `recepient_height` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`recepient_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blood donation`.`recepient_has_recepient_medical_report`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blood donation`.`recepient_has_recepient_medical_report` (
  `recepient_recepient_id` INT NOT NULL,
  `recepient_medical_report_recepient_id` INT NOT NULL,
  PRIMARY KEY (`recepient_recepient_id`, `recepient_medical_report_recepient_id`),
  INDEX `fk_recepient_has_recepient_medical_report_recepient_medical_idx` (`recepient_medical_report_recepient_id` ASC) VISIBLE,
  INDEX `fk_recepient_has_recepient_medical_report_recepient1_idx` (`recepient_recepient_id` ASC) VISIBLE,
  CONSTRAINT `fk_recepient_has_recepient_medical_report_recepient1`
    FOREIGN KEY (`recepient_recepient_id`)
    REFERENCES `blood donation`.`recepient` (`recepient_id`),
  CONSTRAINT `fk_recepient_has_recepient_medical_report_recepient_medical_r1`
    FOREIGN KEY (`recepient_medical_report_recepient_id`)
    REFERENCES `blood donation`.`recepient_medical_report` (`recepient_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
