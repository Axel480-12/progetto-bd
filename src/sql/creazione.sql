--
-- creazione database
--


CREATE DATABASE  IF NOT EXISTS `gestionealloggi` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `gestionealloggi`;
-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: gestionealloggi
-- ------------------------------------------------------
-- Server version   8.0.44


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


/*
Lunghezza delle stringhe uguale e potenza di due
*/
DROP TABLE IF EXISTS utente;
CREATE TABLE utente (
                        id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
                        email VARCHAR(64) NOT NULL UNIQUE,
                        nome VARCHAR(64) NOT NULL,
                        cognome VARCHAR(64) NOT NULL,
                        nazionalita VARCHAR(64) DEFAULT NULL,
                        bio TEXT
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;


/*
creazione tabella citta
*/


DROP TABLE IF EXISTS citta;
CREATE TABLE citta (
                       id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
                       nome VARCHAR(32) NOT NULL,
                       regione VARCHAR(32) NOT NULL,
                       nazione VARCHAR(32) NOT NULL,
                       CONSTRAINT UC_citta UNIQUE (nome, regione, nazione)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


/*
creazione tabella servizio
*/


DROP TABLE IF EXISTS servizio;
CREATE TABLE servizio (
                          id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
                          nome VARCHAR(32) NOT NULL,
                          tipo VARCHAR(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




/*
creazione tabella esperienza
*/


DROP TABLE IF EXISTS esperienza;
CREATE TABLE esperienza (
                            id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
                            nome VARCHAR(32) NOT NULL,
                            descrizione VARCHAR(128) NOT NULL,
                            prezzo DECIMAL(5,2) UNSIGNED NOT NULL,
                            num_max_partecipanti INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




/*
creazione tabella agenzia
*/
DROP TABLE IF EXISTS agenzia;
CREATE TABLE agenzia (
                         id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
                         nome VARCHAR(32) NOT NULL,
                         id_citta INT UNSIGNED NOT NULL,
                         CONSTRAINT fk_ubicazione_agenzia FOREIGN KEY (id_citta) REFERENCES citta(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


/*
creazione tabella lingua
*/


DROP TABLE IF EXISTS lingua;
CREATE TABLE lingua (
                        id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
                        nome VARCHAR(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




/*
creazione tabella alloggio
*/


DROP TABLE IF EXISTS alloggio;
CREATE TABLE alloggio (
                          id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
                          nome VARCHAR(32) NOT NULL,
                          num_max_ospiti INT UNSIGNED NOT NULL,
                          animali BOOLEAN NOT NULL,
                          url VARCHAR(128) NOT NULL,
                          utenza BOOLEAN NOT NULL,
                          descrizione VARCHAR(128) NOT NULL,
                          num_servizi_offerti INT DEFAULT NULL,
                          genere ENUM('M', 'F', NULL),
                          num_piani INT DEFAULT NULL,
                          tipo_alloggio ENUM('CAMERA', 'APPARTAMENTO', 'VILLA') NOT NULL,
                          bagno_privato BOOLEAN DEFAULT NULL,
                          giardino BOOLEAN DEFAULT NULL,
                          metri_quadri DECIMAL(10,0) DEFAULT NULL,
                          via VARCHAR(32) NOT NULL,
                          num_civico INT NOT NULL,
                          costo_per_notte DECIMAL(10,0) NOT NULL,
                          num_locali INT DEFAULT NULL,
                          id_citta INT UNSIGNED NOT NULL,
                          CONSTRAINT fk_alloggio_citta FOREIGN KEY (id_citta) REFERENCES citta(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




/*
creazione tabella prenotazione
*/


DROP TABLE IF EXISTS prenotazione;
CREATE TABLE prenotazione (
                              id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
                              n_ospiti INT UNSIGNED  NOT NULL,
                              data_inizio DATE NOT NULL,
                              data_fine DATE NOT NULL,
                              costo_totale DECIMAL(5,2) UNSIGNED NOT NULL,
                              sconto DECIMAL(5,2) UNSIGNED DEFAULT NULL,
                              id_utente INT UNSIGNED NOT NULL,
                              id_alloggio INT UNSIGNED NOT NULL,
                              KEY email_utente_idx (id_utente),
                              CONSTRAINT fk_prenotazione_utente FOREIGN KEY (id_utente) REFERENCES utente(id),
                              CONSTRAINT fk_prenotazione_alloggio FOREIGN KEY (id_alloggio) REFERENCES alloggio(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;








/*
creazione tabella punto di interesse
*/


DROP TABLE IF EXISTS punto_di_interesse;
CREATE TABLE punto_di_interesse (
                                    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
                                    nome VARCHAR(45) NOT NULL,
                                    categoria VARCHAR(45) NOT NULL,
                                    id_citta INT UNSIGNED NOT NULL,
                                    CONSTRAINT fk_pdi_citta FOREIGN KEY (id_citta) REFERENCES citta(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




/*
creazione tabella offerta
*/


DROP TABLE IF EXISTS offerta;
CREATE TABLE offerta (
                         id_agenzia INT UNSIGNED NOT NULL,
                         id_esperienza INT UNSIGNED NOT NULL,
                         PRIMARY KEY (id_esperienza,id_agenzia),
                         CONSTRAINT fk_offerta_agenzia FOREIGN KEY (id_agenzia) REFERENCES agenzia(id),
                         CONSTRAINT fk_offerta_esperienza FOREIGN KEY (id_esperienza) REFERENCES esperienza(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




/*
creazione tabella host
*/


DROP TABLE IF EXISTS host;
CREATE TABLE host (
                      id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
                      email VARCHAR(64) NOT NULL,
                      tipo_host ENUM('PRIVATO', 'PROFESSIONISTA') NOT NULL,
                      livello INT UNSIGNED DEFAULT NULL,
                      tasso_risposta DECIMAL(5,2) NOT NULL,
                      nazionalita VARCHAR(32) NOT NULL,
                      id_agenzia INT UNSIGNED DEFAULT NULL,
                      id_alloggio INT UNSIGNED NOT NULL,
                      CONSTRAINT chk_livello_host CHECK ((tipo_host = 'privato' AND livello IS NOT NULL) OR (tipo_host <> 'privato' AND livello IS NULL)),
                      CONSTRAINT chk_host_agenzia CHECK ((tipo_host = 'professionista' AND id_agenzia IS NOT NULL) OR (tipo_host = 'privato' AND id_agenzia IS NULL)),
                      CONSTRAINT fk_host_agenzia FOREIGN KEY (id_agenzia) REFERENCES agenzia(id),
                      CONSTRAINT fk_host_alloggio FOREIGN KEY (id_alloggio) REFERENCES alloggio(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




/*
creazione tabella telefono utenti
*/


DROP TABLE IF EXISTS num_telefono_utenti;
CREATE TABLE num_telefono_utenti (
                                     prefisso VARCHAR(10) NOT NULL,
                                     num_telefono VARCHAR(20) NOT NULL,
                                     id_utente INT UNSIGNED NOT NULL,
                                     PRIMARY KEY (prefisso,num_telefono),
                                     CONSTRAINT fk_telefono_utente FOREIGN KEY (id_utente) REFERENCES utente(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




/*
creazione tabella telefono agenzie
*/


DROP TABLE IF EXISTS num_telefono_agenzie;
CREATE TABLE num_telefono_agenzie (
                                      prefisso VARCHAR(10) NOT NULL,
                                      num_telefono VARCHAR(20) NOT NULL,
                                      id_agenzia INT UNSIGNED NOT NULL,
                                      PRIMARY KEY (prefisso,num_telefono),
                                      CONSTRAINT fk_telefono_agenzie FOREIGN KEY (id_agenzia) REFERENCES utente(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


/*
creazione tabella superhost
*/


DROP TABLE IF EXISTS superhost;
CREATE TABLE superhost (
                           data_acquisizione_titolo date NOT NULL,
                           id_host INT UNSIGNED NOT NULL,
                           badge_posseduti INT UNSIGNED  NOT NULL,
                           PRIMARY KEY (data_acquisizione_titolo, id_host),
                           CONSTRAINT fk_superhost_host FOREIGN KEY (id_host) REFERENCES host(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




/*
creazione tabella conferimento
*/


DROP TABLE IF EXISTS conferimento;
CREATE TABLE conferimento (
                              id_host INT UNSIGNED NOT NULL,
                              categoria_badge ENUM('PULIZIA', 'QUALITA', 'DISPONIBILITA', 'PRECISIONE'),
                              PRIMARY KEY (id_host, categoria_badge),
                              CONSTRAINT fk_conferimento_host FOREIGN KEY (id_host) REFERENCES host(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


/*
creazione tabella conoscenza
*/


DROP TABLE IF EXISTS conoscenza;
CREATE TABLE conoscenza (
                            id_host INT UNSIGNED NOT NULL,
                            id_lingua INT UNSIGNED NOT NULL,
                            PRIMARY KEY (id_host, id_lingua),
                            CONSTRAINT fk_conoscenza_host FOREIGN KEY (id_host) REFERENCES host(id),
                            CONSTRAINT fk_conoscenza_lingue FOREIGN KEY (id_lingua) REFERENCES lingua(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




/*
creazione tabella recensione
*/


DROP TABLE IF EXISTS recensione;
CREATE TABLE recensione (
                            timestamp timestamp NOT NULL,
                            id_prenotazione INT UNSIGNED NOT NULL,
                            testo VARCHAR(128) DEFAULT NULL,
                            rating_pulizia INT UNSIGNED NOT NULL,
                            rating_qualita INT UNSIGNED  NOT NULL,
                            rating_disponibilita  INT UNSIGNED  NOT NULL,
                            rating_precisione  INT UNSIGNED  NOT NULL,
                            PRIMARY KEY (timestamp, id_prenotazione),
                            CONSTRAINT fk_recensione_prenotazione FOREIGN KEY (id_prenotazione) REFERENCES prenotazione(id),
                            CONSTRAINT chk_rating
                                CHECK (
                                    rating_pulizia      BETWEEN 1 AND 5 AND
                                    rating_qualita      BETWEEN 1 AND 5 AND
                                    rating_disponibilita BETWEEN 1 AND 5 AND
                                    rating_precisione   BETWEEN 1 AND 5
                                    )
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


/*
creazione tabella assegnazione
*/


DROP TABLE IF EXISTS assegnazione;
CREATE TABLE assegnazione (
                              id_prenotazione INT UNSIGNED NOT NULL,
                              id_alloggio INT UNSIGNED NOT NULL,
                              PRIMARY KEY (id_prenotazione, id_alloggio),
                              CONSTRAINT fk_assegnazione_prenotazione FOREIGN KEY (id_prenotazione) REFERENCES prenotazione(id),
                              CONSTRAINT fk_assegnazione_alloggio FOREIGN KEY (id_alloggio) REFERENCES alloggio(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


/*
creazione tabella dotazione
*/


DROP TABLE IF EXISTS dotazione;
CREATE TABLE dotazione (
                           id_servizio INT UNSIGNED NOT NULL,
                           id_alloggio INT UNSIGNED NOT NULL,
                           PRIMARY KEY (id_alloggio,id_servizio),
                           CONSTRAINT fk_dotazione_servizio FOREIGN KEY (id_servizio) REFERENCES servizio(id),
                           CONSTRAINT fk_dotazione_alloggio FOREIGN KEY (id_alloggio) REFERENCES alloggio(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


/*
creazione tabella aggiunta
*/


DROP TABLE IF EXISTS aggiunta_esperienze;
CREATE TABLE aggiunta_esperienze (
                                     id_esperienza INT UNSIGNED NOT NULL,
                                     id_prenotazione INT UNSIGNED NOT NULL,
                                     data_aggiunta DATE NOT NULL,
                                     PRIMARY KEY (id_esperienza, id_prenotazione),
                                     CONSTRAINT fk_aggiunta_esperienza FOREIGN KEY (id_esperienza) REFERENCES esperienza(id),
                                     CONSTRAINT fk_aggiunta_prenotazione FOREIGN KEY (id_prenotazione) REFERENCES prenotazione(id)
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
      WHERE h.id = NEW.id_host
        AND h.tipo_host = 'PROFESSIONISTA'
   ) THEN
      SIGNAL SQLSTATE '45000';
END IF;


-- 2) se è privato, deve avere almeno una recensione con rating 5
IF EXISTS (
      SELECT 1
      FROM host h
      WHERE h.id = NEW.id_host
        AND h.tipo_host = 'PRIVATO'
   ) THEN


      IF NOT EXISTS (
         SELECT 1
         FROM host h
                JOIN alloggio a        ON a.id        = h.id_alloggio
                JOIN assegnazione asg  ON asg.id_alloggio     = a.id
                JOIN prenotazione p    ON p.id   = asg.id_prenotazione
                JOIN recensione r      ON r.id_prenotazione   = p.id
         WHERE h.id = NEW.id_host
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