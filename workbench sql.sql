-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema proyeco_sql
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema proyeco_sql
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `proyeco_sql` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`old_HDD`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`old_HDD` (
  `idold_HDD` INT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `full_name` VARCHAR(45) NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `release_year` INT NOT NULL,
  `category_id` INT NOT NULL,
  PRIMARY KEY (`idold_HDD`))
ENGINE = InnoDB;

USE `proyeco_sql` ;

-- -----------------------------------------------------
-- Table `proyeco_sql`.`film_actor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyeco_sql`.`film_actor` (
  `title` TEXT NOT NULL,
  `full_name` TEXT NOT NULL,
  PRIMARY KEY (`title`, `full_name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `proyeco_sql`.`actor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyeco_sql`.`actor` (
  `actor_id` INT NOT NULL,
  `first_name` TEXT NOT NULL,
  `last_name` TEXT NOT NULL,
  `full_name` TEXT NOT NULL,
  `film_actor_title` TEXT NOT NULL,
  `film_actor_full_name` TEXT NOT NULL,
  PRIMARY KEY (`actor_id`, `film_actor_title`, `film_actor_full_name`),
  UNIQUE INDEX `full_name_UNIQUE` (`full_name` ASC) VISIBLE,
  INDEX `fk_actor_film_actor1_idx` (`film_actor_title` ASC, `film_actor_full_name` ASC) VISIBLE,
  CONSTRAINT `fk_actor_film_actor1`
    FOREIGN KEY (`film_actor_title` , `film_actor_full_name`)
    REFERENCES `proyeco_sql`.`film_actor` (`title` , `full_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `proyeco_sql`.`film_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyeco_sql`.`film_category` (
  `title` TEXT NOT NULL,
  `category_id` INT NOT NULL,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `proyeco_sql`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyeco_sql`.`category` (
  `category_id` INT NOT NULL,
  `name` TEXT NOT NULL,
  `film_category_category_id` INT NOT NULL,
  PRIMARY KEY (`category_id`, `film_category_category_id`),
  INDEX `fk_category_film_category1_idx` (`film_category_category_id` ASC) VISIBLE,
  CONSTRAINT `fk_category_film_category1`
    FOREIGN KEY (`film_category_category_id`)
    REFERENCES `proyeco_sql`.`film_category` (`category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `proyeco_sql`.`inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyeco_sql`.`inventory` (
  `inventory_id` INT NOT NULL,
  `film_id` INT NOT NULL,
  `store_id` INT NOT NULL,
  PRIMARY KEY (`inventory_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `proyeco_sql`.`language`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyeco_sql`.`language` (
  `language_id` INT NOT NULL,
  `name` TEXT NOT NULL,
  PRIMARY KEY (`language_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `proyeco_sql`.`film`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyeco_sql`.`film` (
  `film_id` INT NOT NULL,
  `title` TEXT NOT NULL,
  `description` TEXT NOT NULL,
  `release_year` INT NOT NULL,
  `language_id` INT NOT NULL,
  `rental_duration` INT NOT NULL,
  `rental_rate` DOUBLE NOT NULL,
  `length` INT NOT NULL,
  `replacement_cost` DOUBLE NOT NULL,
  `rating` GEOMETRY NOT NULL,
  `special_features` TEXT NOT NULL,
  `category_category_id` INT NOT NULL,
  `language_language_id` INT NOT NULL,
  `inventory_inventory_id` INT NOT NULL,
  `old_hdd_film_id` INT NOT NULL,
  `film_actor_title` TEXT NOT NULL,
  `film_actor_full_name` TEXT NOT NULL,
  PRIMARY KEY (`film_id`, `language_language_id`, `inventory_inventory_id`, `old_hdd_film_id`, `film_actor_title`, `film_actor_full_name`),
  INDEX `fk_film_category1_idx` (`category_category_id` ASC) VISIBLE,
  INDEX `fk_film_language1_idx` (`language_language_id` ASC) VISIBLE,
  INDEX `fk_film_inventory1_idx` (`inventory_inventory_id` ASC) VISIBLE,
  INDEX `fk_film_film_actor1_idx` (`film_actor_title` ASC, `film_actor_full_name` ASC) VISIBLE,
  CONSTRAINT `fk_film_category1`
    FOREIGN KEY (`category_category_id`)
    REFERENCES `proyeco_sql`.`category` (`category_id`),
  CONSTRAINT `fk_film_inventory1`
    FOREIGN KEY (`inventory_inventory_id`)
    REFERENCES `proyeco_sql`.`inventory` (`inventory_id`),
  CONSTRAINT `fk_film_language1`
    FOREIGN KEY (`language_language_id`)
    REFERENCES `proyeco_sql`.`language` (`language_id`),
  CONSTRAINT `fk_film_film_actor1`
    FOREIGN KEY (`film_actor_title` , `film_actor_full_name`)
    REFERENCES `proyeco_sql`.`film_actor` (`title` , `full_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `proyeco_sql`.`rental`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyeco_sql`.`rental` (
  `rental_id` INT NOT NULL,
  `rental_date` TEXT NOT NULL,
  `inventory_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  `return_date` TEXT NOT NULL,
  `staff_id` INT NOT NULL,
  `inventory_inventory_id` INT NOT NULL,
  PRIMARY KEY (`rental_id`, `inventory_inventory_id`),
  INDEX `fk_rental_inventory1_idx` (`inventory_inventory_id` ASC) VISIBLE,
  CONSTRAINT `fk_rental_inventory1`
    FOREIGN KEY (`inventory_inventory_id`)
    REFERENCES `proyeco_sql`.`inventory` (`inventory_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;