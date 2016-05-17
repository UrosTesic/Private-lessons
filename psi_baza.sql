-- MySQL Script generated by MySQL Workbench
-- Tue 17 May 2016 03:28:54 PM CEST
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Korisnik`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Korisnik` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Korisnik` (
  `idKorisnik` INT NOT NULL AUTO_INCREMENT,
  `nadimak` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `sifra` VARCHAR(256) NOT NULL,
  `banovan` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`idKorisnik`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  UNIQUE INDEX `nadimak_UNIQUE` (`nadimak` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Admin`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Admin` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Admin` (
  `idAdmin` INT NOT NULL,
  PRIMARY KEY (`idAdmin`),
  CONSTRAINT `fk_Admin_1`
    FOREIGN KEY (`idAdmin`)
    REFERENCES `mydb`.`Korisnik` (`idKorisnik`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Prijava`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Prijava` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Prijava` (
  `idPrijava` INT NOT NULL AUTO_INCREMENT,
  `idPosiljalac` INT NOT NULL,
  `idPrimalac` INT NOT NULL,
  `idAdmin` INT NULL,
  `text` TINYTEXT NULL,
  `datum` TIMESTAMP NOT NULL,
  PRIMARY KEY (`idPrijava`),
  INDEX `fk_Posiljalac_idx` (`idPosiljalac` ASC),
  INDEX `fk_Primalac_idx` (`idPrimalac` ASC),
  INDEX `fk_Admin_idx` (`idAdmin` ASC),
  CONSTRAINT `fk_Posiljalac`
    FOREIGN KEY (`idPosiljalac`)
    REFERENCES `mydb`.`Korisnik` (`idKorisnik`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Primalac`
    FOREIGN KEY (`idPrimalac`)
    REFERENCES `mydb`.`Korisnik` (`idKorisnik`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Admin`
    FOREIGN KEY (`idAdmin`)
    REFERENCES `mydb`.`Admin` (`idAdmin`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Poruka`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Poruka` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Poruka` (
  `idPoruka` INT NOT NULL AUTO_INCREMENT,
  `idPosiljalac` INT NOT NULL,
  `subjekat` VARCHAR(45) NULL,
  `text` TINYTEXT NULL,
  `datum` DATETIME NOT NULL,
  PRIMARY KEY (`idPoruka`),
  INDEX `fk_Poruka_1_idx` (`idPosiljalac` ASC),
  CONSTRAINT `fk_Poruka_1`
    FOREIGN KEY (`idPosiljalac`)
    REFERENCES `mydb`.`Korisnik` (`idKorisnik`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Primanje`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Primanje` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Primanje` (
  `idPoruka` INT NOT NULL,
  `idKorisnik` INT NOT NULL,
  `procitana` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`idPoruka`, `idKorisnik`),
  INDEX `fk_Primanje_idx` (`idKorisnik` ASC),
  CONSTRAINT `fk_Poruka`
    FOREIGN KEY (`idPoruka`)
    REFERENCES `mydb`.`Poruka` (`idPoruka`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Primanje`
    FOREIGN KEY (`idKorisnik`)
    REFERENCES `mydb`.`Korisnik` (`idKorisnik`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Tutor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Tutor` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Tutor` (
  `idTutor` INT NOT NULL,
  `ime` VARCHAR(45) NOT NULL,
  `prezime` VARCHAR(45) NOT NULL,
  `biografija` LONGTEXT NULL,
  `mesto` VARCHAR(45) NULL,
  `telefoni` VARCHAR(90) NOT NULL,
  `titula` VARCHAR(45) NULL,
  `slika` VARCHAR(90) NULL,
  `naAdresu` TINYINT(1) NOT NULL DEFAULT 0,
  `onlineCasove` TINYINT(1) NOT NULL DEFAULT 0,
  `grupneCasove` TINYINT(1) NOT NULL DEFAULT 0,
  `ukupnaOcena` FLOAT NOT NULL DEFAULT 0,
  PRIMARY KEY (`idTutor`),
  CONSTRAINT `fk_Tutor_1`
    FOREIGN KEY (`idTutor`)
    REFERENCES `mydb`.`Korisnik` (`idKorisnik`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Ocena`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Ocena` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Ocena` (
  `idTutor` INT NOT NULL,
  `idKorisnik` INT NOT NULL,
  `text` TINYTEXT NOT NULL,
  `ocena` FLOAT NOT NULL,
  `datum` DATETIME NOT NULL,
  PRIMARY KEY (`idTutor`, `idKorisnik`),
  INDEX `fk_Ocena_1_idx` (`idKorisnik` ASC),
  CONSTRAINT `fk_Ocnjivac`
    FOREIGN KEY (`idKorisnik`)
    REFERENCES `mydb`.`Korisnik` (`idKorisnik`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tutor_Ocena`
    FOREIGN KEY (`idTutor`)
    REFERENCES `mydb`.`Tutor` (`idTutor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Sertifikat`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Sertifikat` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Sertifikat` (
  `idSertifikat` INT NOT NULL AUTO_INCREMENT,
  `idTutor` INT NOT NULL,
  `naziv` VARCHAR(45) NULL,
  `ustanova` VARCHAR(45) NULL,
  `datum` VARCHAR(45) NULL,
  PRIMARY KEY (`idSertifikat`),
  INDEX `fk_Sertifikat_1_idx` (`idTutor` ASC),
  CONSTRAINT `fk_Sertifikat_1`
    FOREIGN KEY (`idTutor`)
    REFERENCES `mydb`.`Tutor` (`idTutor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Predmet`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Predmet` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Predmet` (
  `idPredmet` INT NOT NULL AUTO_INCREMENT,
  `naziv` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPredmet`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Disciplina`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Disciplina` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Disciplina` (
  `idDisciplina` INT NOT NULL AUTO_INCREMENT,
  `idPredmet` INT NOT NULL,
  `naziv` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idDisciplina`),
  INDEX `fk_Disciplina_1_idx` (`idPredmet` ASC),
  CONSTRAINT `fk_Disciplina_1`
    FOREIGN KEY (`idPredmet`)
    REFERENCES `mydb`.`Predmet` (`idPredmet`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Oglas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Oglas` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Oglas` (
  `idOglas` INT NOT NULL AUTO_INCREMENT,
  `idTutor` INT NOT NULL,
  `idPredmet` INT NOT NULL,
  `idDisciplina` INT NULL,
  `cena` INT NOT NULL,
  INDEX `fk_Predmet_idx` (`idPredmet` ASC),
  INDEX `fk_Disciplina_idx` (`idDisciplina` ASC),
  PRIMARY KEY (`idOglas`),
  CONSTRAINT `fk_Tutor_Oglas`
    FOREIGN KEY (`idTutor`)
    REFERENCES `mydb`.`Tutor` (`idTutor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Predmet`
    FOREIGN KEY (`idPredmet`)
    REFERENCES `mydb`.`Predmet` (`idPredmet`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Disciplina`
    FOREIGN KEY (`idDisciplina`)
    REFERENCES `mydb`.`Disciplina` (`idDisciplina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Posao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Posao` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Posao` (
  `idPosao` INT NOT NULL AUTO_INCREMENT,
  `naziv` VARCHAR(45) NULL,
  `poslodavac` VARCHAR(45) NULL,
  `period` VARCHAR(90) NULL,
  `opis` TINYTEXT NULL,
  `idTutor` INT NOT NULL,
  PRIMARY KEY (`idPosao`),
  INDEX `fk_Posao_1_idx` (`idTutor` ASC),
  CONSTRAINT `fk_Posao_1`
    FOREIGN KEY (`idTutor`)
    REFERENCES `mydb`.`Tutor` (`idTutor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Obrazovanje`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Obrazovanje` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Obrazovanje` (
  `idObrazovanje` INT NOT NULL AUTO_INCREMENT,
  `institucija` VARCHAR(90) NULL,
  `nivo` VARCHAR(45) NULL,
  `period` VARCHAR(90) NULL,
  `opis` TINYTEXT NULL,
  `idTutor` INT NOT NULL,
  PRIMARY KEY (`idObrazovanje`),
  INDEX `fk_Obrazovanje_1_idx` (`idTutor` ASC),
  CONSTRAINT `fk_Obrazovanje_1`
    FOREIGN KEY (`idTutor`)
    REFERENCES `mydb`.`Tutor` (`idTutor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
