USE gestionealloggi;

SET FOREIGN_KEY_CHECKS = 0;

/* UTENTE */
INSERT INTO utente (email, nome, cognome, nazionalita, bio) VALUES
('m.destasio@studenti.unisa.it',  'Matteo','De Stasio',   'Italiana', 'Amo i viaggi in montagna'),
('e.deluca24@studenti.unisa.it', 'Elena','De Luca', 'Italiana', NULL),
('axel@gmail.com','Axel','Blaze','Statunitense', 'Digital nomad.');

/* CITTA */
INSERT INTO citta (nome, regione, nazione) VALUES
('Roma',      'Lazio',   'Italia'),
('Milano',    'Lombardia','Italia'),
('New York',  'New York','USA'),
('Parigi',    'Ile-de-France','Francia');

/* SERVIZIO */
INSERT INTO servizio (nome, tipo) VALUES
('WiFi',           'Comfort'),
('Ascensore',     'Accessibilità'),
('Colazione',      'Ristorazione'),
('Aria condizionata','Comfort');

/* ESPERIENZA */
INSERT INTO esperienza (prezzo, num_max_partecipanti, descrizione, nome) VALUES
(25.00, 10, 'Tour a piedi del centro storico', 'Walking tour'),
(60.00, 6,  'Degustazione vini locali', 'Wine tasting'),
(40.00, 8,  'Lezione di cucina tipica', 'Cooking class');

/* AGENZIA */
INSERT INTO agenzia (nome, sede) VALUES
('YouBnB',  'Roma'),
('DomusMi',  'Milano'),
('Zeitgeist Berlin', 'Germania');

/* LINGUA */
INSERT INTO lingua (nome_lingua) VALUES
('Italiano'),
('Inglese'),
('Francese'),
('Spagnolo');

/* BADGE */
INSERT INTO badge (categoria) VALUES
('pulizia'),
('qualita'),
('disponibilita'),
('precisione');

/* PRENOTAZIONE */
INSERT INTO prenotazione (n_ospiti, data_inizio, data_fine, costo_totale, sconto, email_utente) VALUES
(2, '2025-06-10', '2025-06-15', 350.00, NULL, 'e.deluca24@studenti.unisa.it'),
(4, '2025-07-01', '2025-07-05', 500.00, 10.00, 'axel@gmail.com'),
(1, '2025-08-20', '2025-08-22', 180.00, NULL, 'm.destasio@studenti.unisa.it');

/* ALLOGGIO */
INSERT INTO alloggio (
  nome, num_max_ospiti, animali, link, utenza, descrizione,
  num_servizi_offerti, genere_presente, genere, num_piani,
  tipo_alloggio, bagno_privato, giardino, metri_quadri,
  num_civico, via, costo_per_notte, num_locali,
  nome_citta, nazione_citta, regione_citta
) VALUES
('Loft Colosseo', 2, TRUE,  'https://example.com/loft-colosseo', TRUE,
 'Loft moderno vicino al Colosseo.', 3, 0, NULL, 1,
 'appartamento', TRUE, FALSE, 45, '12', 'Via dei Fori Imperiali', 80, 2,
 'Roma','Italia','Lazio'),
('Attico Duomo', 4, FALSE, 'https://example.com/attico-duomo', TRUE,
 'Attico con vista Duomo.', 4, 1, 'donna', 2,
 'appartamento', TRUE, TRUE, 90, '5', 'Via Torino', 150, 3,
 'Milano','Italia','Lombardia'),
('Studio Midtown', 2, FALSE, 'https://example.com/studio-midtown', FALSE,
 'Monolocale in Midtown Manhattan.', 2, 1, 'uomo', 10,
 'camera', TRUE, FALSE, 30, '101', '5th Avenue', 120, 1,
 'New York','USA','New York');

/* PUNTO_DI_INTERESSE */
INSERT INTO punto_di_interesse (nome, categoria, nome_citta, nazione_citta, regione_citta) VALUES
('Colosseo',     'Monumento', 'Roma','Italia','Lazio'),
('Duomo',        'Monumento', 'Milano','Italia','Lombardia'),
('Central Park', 'Parco',     'New York','USA','New York'),
('Louvre',       'Museo',     'Parigi','Francia','Ile-de-France');

/* OFFERTA (agenzia–esperienza) */
INSERT INTO offerta (id_agenzia, id_esperienza) VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 1);

/* HOST */
INSERT INTO host (email, tipo_host, livello, tasso_risposta, nazionalita, id_agenzia, id_alloggio) VALUES
('e.deluca@gmail.com',  'privato', 3, 95.50, 'Italiana', NULL, 1),
('elena.email@libero.it', 'privato', 2, 90.00, 'Francese', NULL, 2),
('matteo@libero.it', 'privato', 2, 77.00, 'Italiana', NULL, 2),
('destasiomatteo@email.com','professionista', NULL, 88.75, 'Statunitense',3, 3),
('matteo@email.com','professionista', NULL, 60.75, 'Tedesca',3, 2);

/* TELEFONO */
INSERT INTO telefono (prefisso, num_telefono, email_utente, id_agenzia) VALUES
('+39', '3331234567', 'e.deluca24@studenti.unisa.it', NULL),
('+39', '3477654321', NULL, 2),
('+1',  '2125557890', NULL, 3);

/* SUPERHOST */
INSERT INTO superhost (data_acquisizione_titolo, badge_posseduti, email_host) VALUES
('2025-01-10', 2, 'e.deluca@gmail.com'),
('2025-03-05', 3, 'elena.email@libero.it');

/* CONFERIMENTO (host–badge) */
INSERT INTO conferimento (email_host, categoria_badge) VALUES
('elena.email@libero.it', 'pulizia');
# ('elena.email@libero.it', 'disponibilita'),
# ('elena.email@libero.it', 'qualita'),
# ('e.deluca@gmail.com', 'precisione'),
# ('e.deluca@gmail.com', 'qualita'),
# ('matteo@libero.it','disponibilita');

INSERT INTO host (email, tipo_host, livello, tasso_risposta, nazionalita, id_agenzia, id_alloggio) VALUES
                                                                                                       ('e.deluca@gmail.com',  'privato', 3, 95.50, 'Italiana', NULL, 1),
                                                                                                       ('elena.email@libero.it', 'privato', 2, 90.00, 'Francese', NULL, 2),
                                                                                                       ('matteo@libero.it', 'privato', 2, 77.00, 'Italiana', NULL, 2),
                                                                                                       ('destasiomatteo@email.com','professionista', NULL, 88.75, 'Statunitense',3, 3),
                                                                                                       ('matteo@email.com','professionista', NULL, 60.75, 'Tedesca',3, 2);

/* CONOSCENZA (host–lingua) */
INSERT INTO conoscenza (email_host, id_lingua) VALUES
('elena.email@libero.it', 1),  
('elena.email@libero.it', 2),  
('destasiomatteo@email.com',1),
('matteo@email.com',    2);

/* RECENSIONE */
INSERT INTO recensione (
  data_recensione, id_prenotazione, testo,
  rating_pulizia, rating_qualita, rating_disponiilita, rating_precisione
) VALUES
('2025-06-16', 1, 'Alloggio molto pulito e centrale.', 5, 4, 5, 4),
('2025-07-06', 2, 'Ottima comunicazione con l’host.', 4, 4, 5, 5),
('2025-08-23', 3, NULL , 4, 3, 4, 4);

/* ASSEGNAZIONE (prenotazione–alloggio) */
INSERT INTO assegnazione (id_prenotazione, id_alloggio) VALUES
(1, 1),
(2, 2),
(3, 2);

/* DOTAZIONE (alloggio–servizio) */
INSERT INTO dotazione (id_servizio, id_alloggio) VALUES
(1, 1), -- WiFi in Loft Colosseo
(2, 1), -- Parcheggio
(1, 2), -- WiFi in Attico Duomo
(3, 2), -- Colazione
(1, 3); -- WiFi in Studio Midtown

/* AGGIUNTA (prenotazione–esperienza) */
INSERT INTO aggiunta (id_esperienza, id_prenotazione, data_aggiunta) VALUES
(1, 1, '2025-06-11'),
(2, 1, '2025-06-12'),
(3, 2, '2025-07-02'),
(1, 3, '2025-08-20');

SET FOREIGN_KEY_CHECKS = 1;
