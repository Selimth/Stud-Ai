-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema stud-ai
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema stud-ai
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `stud-ai` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `stud-ai` ;

-- -----------------------------------------------------
-- Table `stud-ai`.`etablissement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stud-ai`.`etablissement` (
  `idEtablissement` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(255) NOT NULL,
  `statut` VARCHAR(10) NOT NULL,
  `logo` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idEtablissement`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `stud-ai`.`classe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stud-ai`.`classe` (
  `idClasse` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(255) NOT NULL,
  `specialite` VARCHAR(45) NOT NULL,
  `etablissement_id` INT NOT NULL,
  PRIMARY KEY (`idClasse`),
  INDEX `fk_classe_etablissement1_idx` (`etablissement_id` ASC) VISIBLE,
  CONSTRAINT `fk_classe_etablissement1`
    FOREIGN KEY (`etablissement_id`)
    REFERENCES `stud-ai`.`etablissement` (`idEtablissement`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `stud-ai`.`professeur`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stud-ai`.`professeur` (
  `idProfesseur` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(255) NOT NULL,
  `prenom` VARCHAR(255) NOT NULL,
  `telephone` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idProfesseur`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `stud-ai`.`matiere`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stud-ai`.`matiere` (
  `idMatiere` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `coefficient` INT NOT NULL,
  PRIMARY KEY (`idMatiere`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `stud-ai`.`matiere_classe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stud-ai`.`matiere_classe` (
  `Matiere_idMatiere` INT NOT NULL,
  `classe_id` INT NOT NULL,
  `professeur_id` INT NOT NULL,
  PRIMARY KEY (`Matiere_idMatiere`, `classe_id`),
  INDEX `fk_Matiere_has_classe_classe1_idx` (`classe_id` ASC) VISIBLE,
  INDEX `fk_Matiere_has_classe_Matiere_idx` (`Matiere_idMatiere` ASC) VISIBLE,
  INDEX `fk_Matiere_classe_professeur1_idx` (`professeur_id` ASC) VISIBLE,
  CONSTRAINT `fk_Matiere_classe_professeur1`
    FOREIGN KEY (`professeur_id`)
    REFERENCES `stud-ai`.`professeur` (`idProfesseur`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Matiere_has_classe_classe1`
    FOREIGN KEY (`classe_id`)
    REFERENCES `stud-ai`.`classe` (`idClasse`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Matiere_has_classe_Matiere`
    FOREIGN KEY (`Matiere_idMatiere`)
    REFERENCES `stud-ai`.`matiere` (`idMatiere`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `stud-ai`.`cours`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stud-ai`.`cours` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(255) NOT NULL,
  `chapitre` VARCHAR(255) NOT NULL,
  `Matiere_has_classe_Matiere_idMatiere` INT NOT NULL,
  `Matiere_has_classe_classe_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cours_Matiere_has_classe1_idx` (`Matiere_has_classe_Matiere_idMatiere` ASC, `Matiere_has_classe_classe_id` ASC) VISIBLE,
  CONSTRAINT `fk_cours_Matiere_has_classe1`
    FOREIGN KEY (`Matiere_has_classe_Matiere_idMatiere` , `Matiere_has_classe_classe_id`)
    REFERENCES `stud-ai`.`matiere_classe` (`Matiere_idMatiere` , `classe_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `stud-ai`.`parent`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stud-ai`.`parent` (
  `idParent` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `prenom` VARCHAR(45) NOT NULL,
  `telephone` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idParent`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `stud-ai`.`eleve`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stud-ai`.`eleve` (
  `idEleve` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(255) NOT NULL,
  `prenom` VARCHAR(255) NOT NULL,
  `lieu_naissance` VARCHAR(255) NOT NULL,
  `date_naissance` DATE NOT NULL,
  `classe_idClasse` INT NOT NULL,
  `Parent_idParent` INT NOT NULL,
  PRIMARY KEY (`idEleve`),
  INDEX `fk_eleve_classe1_idx` (`classe_idClasse` ASC) VISIBLE,
  INDEX `fk_eleve_Parent1_idx` (`Parent_idParent` ASC) VISIBLE,
  CONSTRAINT `fk_eleve_classe1`
    FOREIGN KEY (`classe_idClasse`)
    REFERENCES `stud-ai`.`classe` (`idClasse`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_eleve_Parent1`
    FOREIGN KEY (`Parent_idParent`)
    REFERENCES `stud-ai`.`parent` (`idParent`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `stud-ai`.`stud_league`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stud-ai`.`stud_league` (
  `idStudLeague` INT NOT NULL AUTO_INCREMENT,
  `points` INT NOT NULL,
  `league` VARCHAR(50) NOT NULL,
  `grade` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idStudLeague`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `stud-ai`.`eleve_has_stud_league`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stud-ai`.`eleve_has_stud_league` (
  `eleve_idEleve` INT NOT NULL,
  `stud_league_idStudLeague` INT NOT NULL,
  PRIMARY KEY (`eleve_idEleve`, `stud_league_idStudLeague`),
  INDEX `fk_eleve_has_stud_league_stud_league1_idx` (`stud_league_idStudLeague` ASC) VISIBLE,
  INDEX `fk_eleve_has_stud_league_eleve1_idx` (`eleve_idEleve` ASC) VISIBLE,
  CONSTRAINT `fk_eleve_has_stud_league_eleve1`
    FOREIGN KEY (`eleve_idEleve`)
    REFERENCES `stud-ai`.`eleve` (`idEleve`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_eleve_has_stud_league_stud_league1`
    FOREIGN KEY (`stud_league_idStudLeague`)
    REFERENCES `stud-ai`.`stud_league` (`idStudLeague`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `stud-ai`.`etablissement_has_professeur`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stud-ai`.`etablissement_has_professeur` (
  `etablissement_idEtablissement` INT NOT NULL,
  `professeur_id` INT NOT NULL,
  PRIMARY KEY (`etablissement_idEtablissement`, `professeur_id`),
  INDEX `fk_etablissement_has_professeur_professeur1_idx` (`professeur_id` ASC) VISIBLE,
  INDEX `fk_etablissement_has_professeur_etablissement1_idx` (`etablissement_idEtablissement` ASC) VISIBLE,
  CONSTRAINT `fk_etablissement_has_professeur_etablissement1`
    FOREIGN KEY (`etablissement_idEtablissement`)
    REFERENCES `stud-ai`.`etablissement` (`idEtablissement`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_etablissement_has_professeur_professeur1`
    FOREIGN KEY (`professeur_id`)
    REFERENCES `stud-ai`.`professeur` (`idProfesseur`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `stud-ai`.`note`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stud-ai`.`note` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type_devoir` VARCHAR(50) NOT NULL,
  `note` DECIMAL(5,2) NOT NULL,
  `eleve_idEleve` INT NOT NULL,
  `matiere_classe_Matiere_idMatiere` INT NOT NULL,
  `matiere_classe_classe_id` INT NOT NULL,
  `professeur_idProfesseur` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_note_eleve1_idx` (`eleve_idEleve` ASC) VISIBLE,
  INDEX `fk_note_matiere_classe1_idx` (`matiere_classe_Matiere_idMatiere` ASC, `matiere_classe_classe_id` ASC) VISIBLE,
  INDEX `fk_note_professeur1_idx` (`professeur_idProfesseur` ASC) VISIBLE,
  CONSTRAINT `fk_note_eleve1`
    FOREIGN KEY (`eleve_idEleve`)
    REFERENCES `stud-ai`.`eleve` (`idEleve`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_note_matiere_classe1`
    FOREIGN KEY (`matiere_classe_Matiere_idMatiere` , `matiere_classe_classe_id`)
    REFERENCES `stud-ai`.`matiere_classe` (`Matiere_idMatiere` , `classe_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_note_professeur1`
    FOREIGN KEY (`professeur_idProfesseur`)
    REFERENCES `stud-ai`.`professeur` (`idProfesseur`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `stud-ai`.`paiement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stud-ai`.`paiement` (
  `idPaiement` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(255) NOT NULL,
  `description` TEXT NOT NULL,
  `montant_a_payer` DECIMAL(10,2) NOT NULL,
  `date_limite` DATE NOT NULL,
  `montant_deja_payer` DECIMAL(10,2) NULL DEFAULT NULL,
  `eleve_idEleve` INT NOT NULL,
  `classe_idClasse` INT NOT NULL,
  `etablissement_idEtablissement` INT NOT NULL,
  PRIMARY KEY (`idPaiement`),
  INDEX `fk_paiement_eleve1_idx` (`eleve_idEleve` ASC) VISIBLE,
  INDEX `fk_paiement_classe1_idx` (`classe_idClasse` ASC) VISIBLE,
  INDEX `fk_paiement_etablissement1_idx` (`etablissement_idEtablissement` ASC) VISIBLE,
  CONSTRAINT `fk_paiement_classe1`
    FOREIGN KEY (`classe_idClasse`)
    REFERENCES `stud-ai`.`classe` (`idClasse`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_paiement_eleve1`
    FOREIGN KEY (`eleve_idEleve`)
    REFERENCES `stud-ai`.`eleve` (`idEleve`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_paiement_etablissement1`
    FOREIGN KEY (`etablissement_idEtablissement`)
    REFERENCES `stud-ai`.`etablissement` (`idEtablissement`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `stud-ai`.`professeur_has_classe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stud-ai`.`professeur_has_classe` (
  `professeur_id` INT NOT NULL,
  `classe_idClasse` INT NOT NULL,
  PRIMARY KEY (`professeur_id`, `classe_idClasse`),
  INDEX `fk_professeur_has_classe_classe1_idx` (`classe_idClasse` ASC) VISIBLE,
  INDEX `fk_professeur_has_classe_professeur1_idx` (`professeur_id` ASC) VISIBLE,
  CONSTRAINT `fk_professeur_has_classe_classe1`
    FOREIGN KEY (`classe_idClasse`)
    REFERENCES `stud-ai`.`classe` (`idClasse`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_professeur_has_classe_professeur1`
    FOREIGN KEY (`professeur_id`)
    REFERENCES `stud-ai`.`professeur` (`idProfesseur`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `stud-ai`.`professeur_has_etablissement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stud-ai`.`professeur_has_etablissement` (
  `professeur_id` INT NOT NULL,
  `etablissement_idEtablissement` INT NOT NULL,
  PRIMARY KEY (`professeur_id`, `etablissement_idEtablissement`),
  INDEX `fk_professeur_has_etablissement_etablissement1_idx` (`etablissement_idEtablissement` ASC) VISIBLE,
  INDEX `fk_professeur_has_etablissement_professeur1_idx` (`professeur_id` ASC) VISIBLE,
  CONSTRAINT `fk_professeur_has_etablissement_etablissement1`
    FOREIGN KEY (`etablissement_idEtablissement`)
    REFERENCES `stud-ai`.`etablissement` (`idEtablissement`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_professeur_has_etablissement_professeur1`
    FOREIGN KEY (`professeur_id`)
    REFERENCES `stud-ai`.`professeur` (`idProfesseur`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
