--
-- creazione database
--

CREATE DATABASE  IF NOT EXISTS `gestionealloggi` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `gestionealloggi`;
-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Dat7abase: gestionealloggi
-- ------------------------------------------------------
-- Server version	8.0.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;



/* 
creazione tabella utente 
*/

DROP TABLE IF EXISTS utente;
CREATE TABLE utente (
  email VARCHAR(45) NOT NULL,
  nome VARCHAR(50) NOT NULL,
  cognome VARCHAR(50) NOT NULL,
  nazionalita VARCHAR(30) DEFAULT NULL,
  bio TEXT,
  PRIMARY KEY (email)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

/*
 creazione tabella citta
*/

DROP TABLE IF EXISTS citta;
CREATE TABLE citta (
  nome varchar(45) NOT NULL,
  regione varchar(45) NOT NULL,
  nazione varchar(45) NOT NULL,
  PRIMARY KEY (nome,regione,nazione)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*
 creazione tabella servizio
*/

DROP TABLE IF EXISTS servizio;
CREATE TABLE servizio (
  id_servizio INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nome varchar(45) NOT NULL,
  tipo varchar(45) NOT NULL,
  PRIMARY KEY (id_servizio)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


/*
 creazione tabella esperienza
*/

DROP TABLE IF EXISTS esperienza;
CREATE TABLE esperienza (
  id_esperienza INT UNSIGNED NOT NULL AUTO_INCREMENT,
  prezzo decimal(5,2) unsigned NOT NULL,
  num_max_partecipanti int NOT NULL,
  descrizione varchar(100) NOT NULL,
  nome varchar(45) NOT NULL,
  PRIMARY KEY (id_esperienza)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


/*
 creazione tabella agenzia
*/
DROP TABLE IF EXISTS agenzia;
CREATE TABLE agenzia (
  id_agenzia  INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nome       VARCHAR(45) NOT NULL,
  sede       VARCHAR(60) NOT NULL,
  PRIMARY KEY (id_agenzia)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*
 creazione tabella lingua
*/

DROP TABLE IF EXISTS lingua;
CREATE TABLE lingua (
  id_lingua INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nome_lingua varchar(45) NOT NULL,
  PRIMARY KEY (id_lingua)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


/*
 creazione tabella badge
*/

DROP TABLE IF EXISTS badge;
CREATE TABLE badge (
  categoria VARCHAR(45) NOT NULL,
  CONSTRAINT chk_categoria_badge CHECK (categoria IN ('pulizia', 'qualita', 'disponibilita', 'precisione')),
  PRIMARY KEY (categoria)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


/*
 creazione tabella prenotazione
*/

DROP TABLE IF EXISTS prenotazione;
CREATE TABLE prenotazione (
  id_prenotazione int unsigned NOT NULL AUTO_INCREMENT,
  n_ospiti int unsigned NOT NULL,
  data_inizio date NOT NULL,
  data_fine date NOT NULL,
  costo_totale decimal(5,2) unsigned NOT NULL,
  sconto decimal(5,2) unsigned DEFAULT NULL,
  email_utente varchar(45) NOT NULL,
  PRIMARY KEY (id_prenotazione),
  KEY email_utente_idx (email_utente),
  CONSTRAINT fk_prenotazione_utente FOREIGN KEY (email_utente) REFERENCES utente(email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


  
/*
 creazione tabella alloggio
*/

DROP TABLE IF EXISTS alloggio;
CREATE TABLE alloggio (
  id_alloggio int unsigned NOT NULL AUTO_INCREMENT,
  nome varchar(45) NOT NULL,
  num_max_ospiti int unsigned NOT NULL,
  animali BOOLEAN NOT NULL,
  link varchar(100) NOT NULL,
  utenza BOOLEAN NOT NULL,
  descrizione varchar(100) NOT NULL,
  num_servizi_offerti int DEFAULT NULL,
  genere_presente BOOLEAN NOT NULL DEFAULT 0, 
  genere ENUM('uomo', 'donna'),
  num_piani int DEFAULT NULL,
  tipo_alloggio VARCHAR(45) NOT NULL, 
  bagno_privato BOOLEAN DEFAULT NULL,
  giardino BOOLEAN DEFAULT NULL,
  metri_quadri decimal(10,0) DEFAULT NULL,
  num_civico varchar(45) NOT NULL,
  via varchar(45) NOT NULL,
  costo_per_notte decimal(10,0) NOT NULL,
  num_locali int DEFAULT NULL,
  nome_citta varchar(45) NOT NULL,
  nazione_citta varchar(45) NOT NULL,
  regione_citta varchar(45) NOT NULL,
  PRIMARY KEY (id_alloggio),
  KEY nome_citta_idx (nome_citta),
  KEY regione_citta_idx (regione_citta),
  KEY nazione_citta_idx (nazione_citta),
 CONSTRAINT fk_alloggio_citta FOREIGN KEY (nome_citta, regione_citta, nazione_citta) REFERENCES citta (nome, regione, nazione),
 CONSTRAINT chk_tipo_alloggio CHECK (tipo_alloggio IN ('camera', 'appartamento', 'villa')),
 CONSTRAINT chk_genere
  CHECK (
    (genere_presente = 0 AND genere IS NULL)
    OR
    (genere_presente = 1 AND genere IN ('uomo','donna'))
  )
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


/*
 creazione tabella punto di interesse
*/

DROP TABLE IF EXISTS punto_di_interesse;
CREATE TABLE punto_di_interesse (
  nome varchar(45) NOT NULL,
  categoria varchar(45) NOT NULL,
  nome_citta varchar(45) NOT NULL,
  nazione_citta varchar(45) NOT NULL,
  regione_citta varchar(45) NOT NULL,
  PRIMARY KEY (nome,categoria,nome_citta,nazione_citta,regione_citta),
  CONSTRAINT fk_pdi_citta FOREIGN KEY (nome_citta, regione_citta, nazione_citta) REFERENCES citta (nome, regione, nazione)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


/*
 creazione tabella offerta
*/

DROP TABLE IF EXISTS offerta;
CREATE TABLE offerta (
  id_agenzia int unsigned NOT NULL,
  id_esperienza int unsigned NOT NULL,
  PRIMARY KEY (id_esperienza,id_agenzia),
  CONSTRAINT fk_offerta_agenzia FOREIGN KEY (id_agenzia) REFERENCES agenzia (id_agenzia),
  CONSTRAINT fk_offerta_esperienza FOREIGN KEY (id_esperienza) REFERENCES esperienza (id_esperienza)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


/*
 creazione tabella host
*/

DROP TABLE IF EXISTS host;
CREATE TABLE host (
  email varchar(45) NOT NULL,
  tipo_host   ENUM('privato', 'professionista') NOT NULL,
  livello int unsigned DEFAULT NULL,
  tasso_risposta decimal(5,2) NOT NULL,
  nazionalita varchar(45) NOT NULL,
  id_agenzia int unsigned DEFAULT NULL,
  id_alloggio int unsigned NOT NULL,
  PRIMARY KEY (email),
  CONSTRAINT chk_livello_host CHECK ((tipo_host = 'privato' AND livello IS NOT NULL) OR (tipo_host <> 'privato' AND livello IS NULL)),
  CONSTRAINT chk_host_agenzia CHECK ((tipo_host = 'professionista' AND id_agenzia IS NOT NULL) OR (tipo_host = 'privato' AND id_agenzia IS NULL)),
  CONSTRAINT fk_host_agenzia FOREIGN KEY (id_agenzia) REFERENCES agenzia(id_agenzia),
  CONSTRAINT fk_host_alloggio FOREIGN KEY (id_alloggio) REFERENCES alloggio(id_alloggio)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


/*
 creazione tabella telefono
*/

DROP TABLE IF EXISTS telefono;
CREATE TABLE telefono (
  prefisso VARCHAR(10) NOT NULL,
  num_telefono VARCHAR(20) NOT NULL,
  email_utente varchar(45) DEFAULT NULL,
  id_agenzia int unsigned DEFAULT NULL,
  PRIMARY KEY (prefisso,num_telefono),
  CONSTRAINT chk_telefono_destinatario CHECK ((email_utente IS NOT NULL AND id_agenzia IS NULL) OR (email_utente IS NULL AND id_agenzia IS NOT NULL)),
 CONSTRAINT fk_telefono_utente FOREIGN KEY (email_utente) REFERENCES utente(email),
  CONSTRAINT fk_telefono_agenzia FOREIGN KEY (id_agenzia) REFERENCES agenzia(id_agenzia)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*
 creazione tabella superhost
*/

DROP TABLE IF EXISTS superhost;
CREATE TABLE superhost (
  data_acquisizione_titolo date NOT NULL,
  badge_posseduti int unsigned NOT NULL,
  email_host varchar(45) NOT NULL,
  PRIMARY KEY (data_acquisizione_titolo,email_host),
 CONSTRAINT fk_superhost_host FOREIGN KEY (email_host) REFERENCES host(email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


/*
 creazione tabella conferimento
*/

DROP TABLE IF EXISTS conferimento;
CREATE TABLE conferimento (
  email_host varchar(45) NOT NULL,
  categoria_badge varchar(45) NOT NULL,
  PRIMARY KEY (email_host,categoria_badge),
  CONSTRAINT fk_conferimento_host FOREIGN KEY (email_host) REFERENCES host(email),
  CONSTRAINT fk_conferimento_badge FOREIGN KEY (categoria_badge) REFERENCES badge(categoria)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*
 creazione tabella conoscenza
*/

DROP TABLE IF EXISTS conoscenza;
CREATE TABLE conoscenza (
  email_host varchar(45) NOT NULL,
  id_lingua int unsigned NOT NULL,
  PRIMARY KEY (email_host,id_lingua),
 CONSTRAINT fk_conoscenza_host FOREIGN KEY (email_host) REFERENCES host(email),
  CONSTRAINT fk_conoscenza_lingue FOREIGN KEY (id_lingua) REFERENCES lingua(id_lingua)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


/*
 creazione tabella recensione
*/

DROP TABLE IF EXISTS recensione;
CREATE TABLE recensione (
  data_recensione date NOT NULL,
  id_prenotazione int unsigned NOT NULL,
  testo varchar(100) DEFAULT NULL,
  rating_pulizia int unsigned NOT NULL,
  rating_qualita int unsigned NOT NULL,
  rating_disponiilita int unsigned NOT NULL,
  rating_precisione int unsigned NOT NULL,
  PRIMARY KEY (data_recensione, id_prenotazione),
  CONSTRAINT fk_recensione_prenotazione FOREIGN KEY (id_prenotazione) REFERENCES prenotazione(id_prenotazione),
  CONSTRAINT chk_rating_tutti
  CHECK (
    rating_pulizia      BETWEEN 1 AND 5 AND
    rating_qualita      BETWEEN 1 AND 5 AND
    rating_disponiilita BETWEEN 1 AND 5 AND
    rating_precisione   BETWEEN 1 AND 5
  )
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*
 creazione tabella assegnazione
*/

DROP TABLE IF EXISTS assegnazione;
CREATE TABLE assegnazione (
  id_prenotazione int unsigned NOT NULL,
  id_alloggio int unsigned NOT NULL,
  PRIMARY KEY (id_prenotazione,id_alloggio),
 CONSTRAINT fk_assegnazione_prenotazione FOREIGN KEY (id_prenotazione) REFERENCES prenotazione(id_prenotazione),
  CONSTRAINT fk_assegnazione_alloggio FOREIGN KEY (id_alloggio) REFERENCES alloggio(id_alloggio)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*
 creazione tabella dotazione
*/

DROP TABLE IF EXISTS dotazione;
CREATE TABLE dotazione (
  id_servizio int unsigned NOT NULL,
  id_alloggio int unsigned NOT NULL,
  PRIMARY KEY (id_alloggio,id_servizio),
  CONSTRAINT fk_dotazione_servizio FOREIGN KEY (id_servizio) REFERENCES servizio(id_servizio),
  CONSTRAINT fk_dotazione_alloggio FOREIGN KEY (id_alloggio) REFERENCES alloggio(id_alloggio)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*
 creazione tabella aggiunta
*/

DROP TABLE IF EXISTS aggiunta;
CREATE TABLE aggiunta (
  id_esperienza   INT UNSIGNED NOT NULL,
  id_prenotazione INT UNSIGNED NOT NULL,
  data_aggiunta DATE NOT NULL,
  PRIMARY KEY (id_esperienza, id_prenotazione),
 CONSTRAINT fk_aggiunta_esperienza FOREIGN KEY (id_esperienza) REFERENCES esperienza(id_esperienza),
  CONSTRAINT fk_aggiunta_prenotazione FOREIGN KEY (id_prenotazione) REFERENCES prenotazione(id_prenotazione)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELIMITER $$

CREATE TRIGGER conferimento_before_insert
BEFORE INSERT ON conferimento
FOR EACH ROW
BEGIN
  -- 1) blocco tutti i professionisti
  IF EXISTS (
    SELECT 1
    FROM host h
    WHERE h.email = NEW.email_host
      AND h.tipo_host = 'professionista'
  ) THEN
    SIGNAL SQLSTATE '45000';
  END IF;

  -- 2) se è privato, deve avere almeno una recensione con rating 5
  IF EXISTS (
    SELECT 1
    FROM host h
    WHERE h.email = NEW.email_host
      AND h.tipo_host = 'privato'
  ) THEN

    IF NOT EXISTS (
      SELECT 1
      FROM host h
      JOIN alloggio a        ON a.id_alloggio       = h.id_alloggio
      JOIN assegnazione asg  ON asg.id_alloggio     = a.id_alloggio
      JOIN prenotazione p    ON p.id_prenotazione   = asg.id_prenotazione
      JOIN recensione r      ON r.id_prenotazione   = p.id_prenotazione
      WHERE h.email = NEW.email_host
        AND (
          r.rating_pulizia      = 5 OR
          r.rating_qualita      = 5 OR
          r.rating_disponiilita = 5 OR
          r.rating_precisione   = 5
        )
    ) THEN
      SIGNAL SQLSTATE '45000';
    END IF;

  END IF;
END$$

DELIMITER ;
