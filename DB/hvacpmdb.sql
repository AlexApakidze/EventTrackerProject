-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema hvacpmdb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `hvacpmdb` ;

-- -----------------------------------------------------
-- Schema hvacpmdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hvacpmdb` DEFAULT CHARACTER SET utf8 ;
USE `hvacpmdb` ;

-- -----------------------------------------------------
-- Table `address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `address` ;

CREATE TABLE IF NOT EXISTS `address` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(300) NOT NULL,
  `city` VARCHAR(300) NOT NULL,
  `state` VARCHAR(300) NULL,
  `zipcode` VARCHAR(300) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `phone_number`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `phone_number` ;

CREATE TABLE IF NOT EXISTS `phone_number` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `digits` VARCHAR(100) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `customer` ;

CREATE TABLE IF NOT EXISTS `customer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `company` VARCHAR(300) NOT NULL,
  `address_id` INT NOT NULL,
  `phone_number_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_customer_address_idx` (`address_id` ASC),
  INDEX `fk_customer_phone_number1_idx` (`phone_number_id` ASC),
  CONSTRAINT `fk_customer_address`
    FOREIGN KEY (`address_id`)
    REFERENCES `address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customer_phone_number1`
    FOREIGN KEY (`phone_number_id`)
    REFERENCES `phone_number` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hvac_pm`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hvac_pm` ;

CREATE TABLE IF NOT EXISTS `hvac_pm` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `quarter` INT NOT NULL,
  `address_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_hvac_pm_address1_idx` (`address_id` ASC),
  INDEX `fk_hvac_pm_customer1_idx` (`customer_id` ASC),
  CONSTRAINT `fk_hvac_pm_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hvac_pm_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `technician`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `technician` ;

CREATE TABLE IF NOT EXISTS `technician` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NULL,
  `address_id` INT NOT NULL,
  `phone_number_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_technician_address1_idx` (`address_id` ASC),
  INDEX `fk_technician_phone_number1_idx` (`phone_number_id` ASC),
  CONSTRAINT `fk_technician_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_technician_phone_number1`
    FOREIGN KEY (`phone_number_id`)
    REFERENCES `phone_number` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hvac_pm_technician`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hvac_pm_technician` ;

CREATE TABLE IF NOT EXISTS `hvac_pm_technician` (
  `technician_id` INT NOT NULL,
  `hvac_pm_id` INT NOT NULL,
  PRIMARY KEY (`technician_id`, `hvac_pm_id`),
  INDEX `fk_technician_has_hvac_pm_hvac_pm1_idx` (`hvac_pm_id` ASC),
  INDEX `fk_technician_has_hvac_pm_technician1_idx` (`technician_id` ASC),
  CONSTRAINT `fk_technician_has_hvac_pm_technician1`
    FOREIGN KEY (`technician_id`)
    REFERENCES `technician` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_technician_has_hvac_pm_hvac_pm1`
    FOREIGN KEY (`hvac_pm_id`)
    REFERENCES `hvac_pm` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `contact`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `contact` ;

CREATE TABLE IF NOT EXISTS `contact` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(70) NOT NULL,
  `phone_number_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_contact_phone_number1_idx` (`phone_number_id` ASC),
  CONSTRAINT `fk_contact_phone_number1`
    FOREIGN KEY (`phone_number_id`)
    REFERENCES `phone_number` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hvac_pm_contact`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hvac_pm_contact` ;

CREATE TABLE IF NOT EXISTS `hvac_pm_contact` (
  `hvac_pm_id` INT NOT NULL,
  `contact_id` INT NOT NULL,
  PRIMARY KEY (`hvac_pm_id`, `contact_id`),
  INDEX `fk_hvac_pm_has_contacts_contacts1_idx` (`contact_id` ASC),
  INDEX `fk_hvac_pm_has_contacts_hvac_pm1_idx` (`hvac_pm_id` ASC),
  CONSTRAINT `fk_hvac_pm_has_contacts_hvac_pm1`
    FOREIGN KEY (`hvac_pm_id`)
    REFERENCES `hvac_pm` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hvac_pm_has_contacts_contacts1`
    FOREIGN KEY (`contact_id`)
    REFERENCES `contact` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `task`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `task` ;

CREATE TABLE IF NOT EXISTS `task` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `todo` VARCHAR(500) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `equipment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `equipment` ;

CREATE TABLE IF NOT EXISTS `equipment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `make` VARCHAR(45) NULL,
  `model` VARCHAR(400) NULL,
  `serial` VARCHAR(400) NULL,
  `hvac_pm_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_equipment_hvac_pm1_idx` (`hvac_pm_id` ASC),
  CONSTRAINT `fk_equipment_hvac_pm1`
    FOREIGN KEY (`hvac_pm_id`)
    REFERENCES `hvac_pm` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hvac_pm_task`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hvac_pm_task` ;

CREATE TABLE IF NOT EXISTS `hvac_pm_task` (
  `hvac_pm_id` INT NOT NULL,
  `task_id` INT NOT NULL,
  PRIMARY KEY (`hvac_pm_id`, `task_id`),
  INDEX `fk_hvac_pm_has_task_task1_idx` (`task_id` ASC),
  INDEX `fk_hvac_pm_has_task_hvac_pm1_idx` (`hvac_pm_id` ASC),
  CONSTRAINT `fk_hvac_pm_has_task_hvac_pm1`
    FOREIGN KEY (`hvac_pm_id`)
    REFERENCES `hvac_pm` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hvac_pm_has_task_task1`
    FOREIGN KEY (`task_id`)
    REFERENCES `task` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS hvacuser@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'hvacuser'@'localhost' IDENTIFIED BY 'hvacuser';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'hvacuser'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `address`
-- -----------------------------------------------------
START TRANSACTION;
USE `hvacpmdb`;
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zipcode`) VALUES (1, '123 Fake st', 'Glen Burnie', 'MD', '01234');
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zipcode`) VALUES (2, '1 Corperate blvd', 'washington', 'DC', '43210');

COMMIT;


-- -----------------------------------------------------
-- Data for table `phone_number`
-- -----------------------------------------------------
START TRANSACTION;
USE `hvacpmdb`;
INSERT INTO `phone_number` (`id`, `digits`) VALUES (1, '281-330-8004');
INSERT INTO `phone_number` (`id`, `digits`) VALUES (2, '555-867-5309');
INSERT INTO `phone_number` (`id`, `digits`) VALUES (3, '123-456-7890');

COMMIT;


-- -----------------------------------------------------
-- Data for table `customer`
-- -----------------------------------------------------
START TRANSACTION;
USE `hvacpmdb`;
INSERT INTO `customer` (`id`, `name`, `company`, `address_id`, `phone_number_id`) VALUES (1, 'Bill Lectric', 'Bills Electronics', 2, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `hvac_pm`
-- -----------------------------------------------------
START TRANSACTION;
USE `hvacpmdb`;
INSERT INTO `hvac_pm` (`id`, `quarter`, `address_id`, `customer_id`) VALUES (1, 1, 2, 1);
INSERT INTO `hvac_pm` (`id`, `quarter`, `address_id`, `customer_id`) VALUES (2, 2, 2, 1);
INSERT INTO `hvac_pm` (`id`, `quarter`, `address_id`, `customer_id`) VALUES (3, 3, 2, 1);
INSERT INTO `hvac_pm` (`id`, `quarter`, `address_id`, `customer_id`) VALUES (4, 4, 2, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `technician`
-- -----------------------------------------------------
START TRANSACTION;
USE `hvacpmdb`;
INSERT INTO `technician` (`id`, `name`, `address_id`, `phone_number_id`) VALUES (1, 'Frank Mathias', 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `contact`
-- -----------------------------------------------------
START TRANSACTION;
USE `hvacpmdb`;
INSERT INTO `contact` (`id`, `name`, `phone_number_id`) VALUES (1, 'Joe Shmoe', 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `hvac_pm_contact`
-- -----------------------------------------------------
START TRANSACTION;
USE `hvacpmdb`;
INSERT INTO `hvac_pm_contact` (`hvac_pm_id`, `contact_id`) VALUES (1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `task`
-- -----------------------------------------------------
START TRANSACTION;
USE `hvacpmdb`;
INSERT INTO `task` (`id`, `todo`) VALUES (1, 'Check Heat');
INSERT INTO `task` (`id`, `todo`) VALUES (2, 'Check Cooling');
INSERT INTO `task` (`id`, `todo`) VALUES (3, 'Belts and Filters');

COMMIT;


-- -----------------------------------------------------
-- Data for table `equipment`
-- -----------------------------------------------------
START TRANSACTION;
USE `hvacpmdb`;
INSERT INTO `equipment` (`id`, `make`, `model`, `serial`, `hvac_pm_id`) VALUES (1, 'York', 'Ych', '171029384', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `hvac_pm_task`
-- -----------------------------------------------------
START TRANSACTION;
USE `hvacpmdb`;
INSERT INTO `hvac_pm_task` (`hvac_pm_id`, `task_id`) VALUES (1, 1);

COMMIT;

