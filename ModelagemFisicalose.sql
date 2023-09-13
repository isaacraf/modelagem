-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema isaac
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `isaac` ;

-- -----------------------------------------------------
-- Schema isaac
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `isaac` ;
USE `isaac` ;

-- -----------------------------------------------------
-- Table `isaac`.`musica`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `isaac`.`musica` ;

CREATE TABLE IF NOT EXISTS `isaac`.`musica` (
  `titulo` INT NOT NULL,
  `letra` VARCHAR(45) NULL,
  `fãs e audiẽncia` VARCHAR(45) NULL,
  PRIMARY KEY (`titulo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `isaac`.`compõe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `isaac`.`compõe` ;

CREATE TABLE IF NOT EXISTS `isaac`.`compõe` (
  `letra` INT NOT NULL,
  `CPF` VARCHAR(45) NOT NULL,
  `musica_titulo` INT NOT NULL,
  `compõe_letra` INT NOT NULL,
  `compõe_musica_titulo` INT NOT NULL,
  PRIMARY KEY (`letra`, `musica_titulo`),
  INDEX `fk_compõe_musica1_idx` (`musica_titulo` ASC) VISIBLE,
  INDEX `fk_compõe_compõe1_idx` (`compõe_letra` ASC, `compõe_musica_titulo` ASC) VISIBLE,
  CONSTRAINT `fk_compõe_musica1`
    FOREIGN KEY (`musica_titulo`)
    REFERENCES `isaac`.`musica` (`titulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_compõe_compõe1`
    FOREIGN KEY (`compõe_letra` , `compõe_musica_titulo`)
    REFERENCES `isaac`.`compõe` (`letra` , `musica_titulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `isaac`.`gravação`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `isaac`.`gravação` ;

CREATE TABLE IF NOT EXISTS `isaac`.`gravação` (
  `tempo` INT NOT NULL,
  `instrumento musical` VARCHAR(45) NULL,
  `repertório musical` VARCHAR(45) NULL,
  `id_cantor` VARCHAR(45) NULL,
  PRIMARY KEY (`tempo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `isaac`.`compositor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `isaac`.`compositor` ;

CREATE TABLE IF NOT EXISTS `isaac`.`compositor` (
  `nome` VARCHAR(45) NULL,
  `CPF` VARCHAR(45) NOT NULL,
  `Direitos autorais` INT NULL,
  `compõe_letra` INT NOT NULL,
  PRIMARY KEY (`compõe_letra`, `CPF`),
  INDEX `fk_compositor_compõe1_idx` (`compõe_letra` ASC) VISIBLE,
  CONSTRAINT `fk_compositor_compõe1`
    FOREIGN KEY (`compõe_letra`)
    REFERENCES `isaac`.`compõe` (`letra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `isaac`.`tem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `isaac`.`tem` ;

CREATE TABLE IF NOT EXISTS `isaac`.`tem` (
  `letra` INT NOT NULL,
  `repertório musical` INT NOT NULL,
  PRIMARY KEY (`letra`, `repertório musical`),
  INDEX `fk_professor_has_Turma_Turma1_idx` (`repertório musical` ASC) VISIBLE,
  INDEX `fk_professor_has_Turma_professor1_idx` (`letra` ASC) VISIBLE,
  CONSTRAINT `fk_professor_has_Turma_professor1`
    FOREIGN KEY (`letra`)
    REFERENCES `isaac`.`gravação` (`tempo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_professor_has_Turma_Turma1`
    FOREIGN KEY (`repertório musical`)
    REFERENCES `isaac`.`musica` (`titulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `isaac`.`cantor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `isaac`.`cantor` ;

CREATE TABLE IF NOT EXISTS `isaac`.`cantor` (
  `CPF` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  `estilo musical` VARCHAR(45) NULL,
  PRIMARY KEY (`CPF`),
  INDEX `fk_professor_has_disciplina_disciplina1_idx` (`nome` ASC) VISIBLE,
  INDEX `fk_professor_has_disciplina_professor1_idx` (`CPF` ASC) VISIBLE,
  CONSTRAINT `fk_professor_has_disciplina_professor1`
    FOREIGN KEY (`CPF`)
    REFERENCES `isaac`.`gravação` (`tempo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_professor_has_disciplina_disciplina1`
    FOREIGN KEY (`nome`)
    REFERENCES `isaac`.`compositor` (`nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `isaac`.`Associada`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `isaac`.`Associada` ;

CREATE TABLE IF NOT EXISTS `isaac`.`Associada` (
  `professor_id_professor` INT NOT NULL,
  `Turma_idTurma` INT NOT NULL,
  PRIMARY KEY (`professor_id_professor`, `Turma_idTurma`),
  INDEX `fk_professor_has_Turma_Turma2_idx` (`Turma_idTurma` ASC) VISIBLE,
  INDEX `fk_professor_has_Turma_professor2_idx` (`professor_id_professor` ASC) VISIBLE,
  CONSTRAINT `fk_professor_has_Turma_professor2`
    FOREIGN KEY (`professor_id_professor`)
    REFERENCES `isaac`.`gravação` (`tempo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_professor_has_Turma_Turma2`
    FOREIGN KEY (`Turma_idTurma`)
    REFERENCES `isaac`.`musica` (`titulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
