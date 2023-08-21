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
-- Table `contact_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `contact_info` ;

CREATE TABLE IF NOT EXISTS `contact_info` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `phone_number` VARCHAR(45) NOT NULL,
  `street` VARCHAR(300) NULL,
  `city` VARCHAR(45) NULL,
  `state` VARCHAR(300) NULL,
  `zipcode` VARCHAR(300) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `customer` ;

CREATE TABLE IF NOT EXISTS `customer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `company` VARCHAR(300) NOT NULL,
  `contact_info_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_customer_contact_info1_idx` (`contact_info_id` ASC),
  CONSTRAINT `fk_customer_contact_info1`
    FOREIGN KEY (`contact_info_id`)
    REFERENCES `contact_info` (`id`)
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
  `completed` TINYINT NULL,
  `customer_id` INT NOT NULL,
  `contact_info_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_hvac_pm_customer1_idx` (`customer_id` ASC),
  INDEX `fk_hvac_pm_contact_info1_idx` (`contact_info_id` ASC),
  CONSTRAINT `fk_hvac_pm_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hvac_pm_contact_info1`
    FOREIGN KEY (`contact_info_id`)
    REFERENCES `contact_info` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `technician`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `technician` ;

CREATE TABLE IF NOT EXISTS `technician` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `contact_info_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_technician_contact_info1_idx` (`contact_info_id` ASC),
  CONSTRAINT `fk_technician_contact_info1`
    FOREIGN KEY (`contact_info_id`)
    REFERENCES `contact_info` (`id`)
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
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hvac_pm_task`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hvac_pm_task` ;

CREATE TABLE IF NOT EXISTS `hvac_pm_task` (
  `hvac_pm_id` INT NOT NULL,
  `task_id` INT NOT NULL,
  PRIMARY KEY (`hvac_pm_id`, `task_id`),
  INDEX `fk_hvac_pm_has_task_task2_idx` (`task_id` ASC),
  INDEX `fk_hvac_pm_has_task_hvac_pm2_idx` (`hvac_pm_id` ASC),
  CONSTRAINT `fk_hvac_pm_has_task_hvac_pm2`
    FOREIGN KEY (`hvac_pm_id`)
    REFERENCES `hvac_pm` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hvac_pm_has_task_task2`
    FOREIGN KEY (`task_id`)
    REFERENCES `task` (`id`)
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
  INDEX `fk_hvac_pm_has_task_task2_idx` (`task_id` ASC),
  INDEX `fk_hvac_pm_has_task_hvac_pm2_idx` (`hvac_pm_id` ASC),
  CONSTRAINT `fk_hvac_pm_has_task_hvac_pm2`
    FOREIGN KEY (`hvac_pm_id`)
    REFERENCES `hvac_pm` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hvac_pm_has_task_task2`
    FOREIGN KEY (`task_id`)
    REFERENCES `task` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hvac_pm_has_equipment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hvac_pm_has_equipment` ;

CREATE TABLE IF NOT EXISTS `hvac_pm_has_equipment` (
  `hvac_pm_id` INT NOT NULL,
  `equipment_id` INT NOT NULL,
  PRIMARY KEY (`hvac_pm_id`, `equipment_id`),
  INDEX `fk_hvac_pm_has_equipment_equipment1_idx` (`equipment_id` ASC),
  INDEX `fk_hvac_pm_has_equipment_hvac_pm1_idx` (`hvac_pm_id` ASC),
  CONSTRAINT `fk_hvac_pm_has_equipment_hvac_pm1`
    FOREIGN KEY (`hvac_pm_id`)
    REFERENCES `hvac_pm` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hvac_pm_has_equipment_equipment1`
    FOREIGN KEY (`equipment_id`)
    REFERENCES `equipment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hvac_pm_contact_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hvac_pm_contact_info` ;

CREATE TABLE IF NOT EXISTS `hvac_pm_contact_info` (
  `hvac_pm_id` INT NOT NULL,
  `contact_info_id` INT NOT NULL,
  PRIMARY KEY (`hvac_pm_id`, `contact_info_id`),
  INDEX `fk_hvac_pm_has_contact_info_contact_info1_idx` (`contact_info_id` ASC),
  INDEX `fk_hvac_pm_has_contact_info_hvac_pm1_idx` (`hvac_pm_id` ASC),
  CONSTRAINT `fk_hvac_pm_has_contact_info_hvac_pm1`
    FOREIGN KEY (`hvac_pm_id`)
    REFERENCES `hvac_pm` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hvac_pm_has_contact_info_contact_info1`
    FOREIGN KEY (`contact_info_id`)
    REFERENCES `contact_info` (`id`)
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
-- Data for table `contact_info`
-- -----------------------------------------------------
START TRANSACTION;
USE `hvacpmdb`;
INSERT INTO `contact_info` (`id`, `name`, `phone_number`, `street`, `city`, `state`, `zipcode`) VALUES (1, 'Frank M', '3334445555', '123 Fake st', 'Glen Burnie', 'MD', '01234');
INSERT INTO `contact_info` (`id`, `name`, `phone_number`, `street`, `city`, `state`, `zipcode`) VALUES (2, 'Bill Lectric', '3337778888', '1 Corperate blvd', 'washington', 'DC', '43210');
INSERT INTO `contact_info` (`id`, `name`, `phone_number`, `street`, `city`, `state`, `zipcode`) VALUES (3, 'Lectric Electric', '1230503149', '5 Warehouse ct', 'Cityville', 'ST', '39393');

COMMIT;


-- -----------------------------------------------------
-- Data for table `customer`
-- -----------------------------------------------------
START TRANSACTION;
USE `hvacpmdb`;
INSERT INTO `customer` (`id`, `company`, `contact_info_id`) VALUES (1, 'Bills Electronics', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `hvac_pm`
-- -----------------------------------------------------
START TRANSACTION;
USE `hvacpmdb`;
INSERT INTO `hvac_pm` (`id`, `quarter`, `completed`, `customer_id`, `contact_info_id`) VALUES (1, 1, 1, 1, 3);
INSERT INTO `hvac_pm` (`id`, `quarter`, `completed`, `customer_id`, `contact_info_id`) VALUES (2, 2, 1, 1, 3);
INSERT INTO `hvac_pm` (`id`, `quarter`, `completed`, `customer_id`, `contact_info_id`) VALUES (3, 3, 1, 1, 3);
INSERT INTO `hvac_pm` (`id`, `quarter`, `completed`, `customer_id`, `contact_info_id`) VALUES (4, 4, 1, 1, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `technician`
-- -----------------------------------------------------
START TRANSACTION;
USE `hvacpmdb`;
INSERT INTO `technician` (`id`, `contact_info_id`) VALUES (1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `hvac_pm_technician`
-- -----------------------------------------------------
START TRANSACTION;
USE `hvacpmdb`;
INSERT INTO `hvac_pm_technician` (`technician_id`, `hvac_pm_id`) VALUES (1, 1);

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
INSERT INTO `equipment` (`id`, `make`, `model`, `serial`) VALUES (1, 'York', 'Ych', '171029384');

COMMIT;


-- -----------------------------------------------------
-- Data for table `hvac_pm_task`
-- -----------------------------------------------------
START TRANSACTION;
USE `hvacpmdb`;
INSERT INTO `hvac_pm_task` (`hvac_pm_id`, `task_id`) VALUES (1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `hvac_pm_contact_info`
-- -----------------------------------------------------
START TRANSACTION;
USE `hvacpmdb`;
INSERT INTO `hvac_pm_contact_info` (`hvac_pm_id`, `contact_info_id`) VALUES (1, 3);
INSERT INTO `hvac_pm_contact_info` (`hvac_pm_id`, `contact_info_id`) VALUES (2, 3);
INSERT INTO `hvac_pm_contact_info` (`hvac_pm_id`, `contact_info_id`) VALUES (3, 3);
INSERT INTO `hvac_pm_contact_info` (`hvac_pm_id`, `contact_info_id`) VALUES (4, 3);

COMMIT;

