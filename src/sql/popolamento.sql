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
INSERT INTO agenzia (nome, id_citta) VALUES
                                         ('YouBnB',  1),
                                         ('DomusMi',  2),
                                         ('RomaBnB', 1);

/* LINGUA */
INSERT INTO lingua (nome) VALUES
                              ('Italiano'),
                              ('Inglese'),
                              ('Francese'),
                              ('Spagnolo');

/* PRENOTAZIONE */
INSERT INTO prenotazione (n_ospiti, data_inizio, data_fine, costo_totale, sconto, id_utente, id_alloggio)
VALUES
    (2, '2025-06-10', '2025-06-15', 350.00, NULL, 1, 1),
    (4, '2025-07-01', '2025-07-05', 500.00, 10.00, 2, 2),
    (1, '2025-08-20', '2025-08-22', 180.00, NULL, 3, 3),


/* ALLOGGIO */
INSERT INTO alloggio (
    nome, num_max_ospiti, animali, url, utenza, descrizione,
    num_servizi_offerti, genere, num_piani,
    tipo_alloggio, bagno_privato, giardino, metri_quadri,
    num_civico, via, costo_per_notte, num_locali,
    id_citta
) VALUES
      ('Loft Colosseo', 2, TRUE,  'https://example.com/loft-colosseo', TRUE,
       'Loft moderno vicino al Colosseo.', 3, 'M', 1,
       'appartamento', TRUE, FALSE, 45,
       '12', 'Via dei Fori Imperiali', 80, 2, 1),
      ('Attico Duomo', 4, FALSE, 'https://example.com/attico-duomo', TRUE,
       'Attico con vista Duomo.', 4,  'F', 4,
       'appartamento', TRUE, TRUE, 90,
       '5', 'Via Torino', 150, 3, 4),
      ('Studio Midtown', 2, FALSE, 'https://example.com/studio-midtown', FALSE,
       'Monolocale in Midtown Manhattan.', 2, 'M', 10,
       'camera', TRUE, FALSE, 30,
       '101', '5th Avenue', 120, 1, 3);

/* PUNTO_DI_INTERESSE */
INSERT INTO punto_di_interesse (nome, categoria, id_citta) VALUES
                                                               ('Colosseo',     'Monumento', 1),
                                                               ('Duomo',        'Monumento', 4),
                                                               ('Central Park', 'Parco',     2),
                                                               ('Louvre',       'Museo',     3);

/* OFFERTA (agenzia–esperienza) */
INSERT INTO offerta (id_agenzia, id_esperienza) VALUES
                                                    (1, 1),
                                                    (1, 2),
                                                    (2, 3),
                                                    (3, 1);

/* HOST */
INSERT INTO host (email, tipo_host, livello, tasso_risposta, nazionalita, id_agenzia, id_alloggio)
VALUES
    ('e.deluca@gmail.com',  'privato', 3, 95.50, 'Italiana', NULL, 1),
    ('elena.email@libero.it', 'privato', 2, 90.00, 'Francese', NULL, 2),
    ('matteo@libero.it', 'privato', 2, 77.00, 'Italiana', NULL, 2),
    ('destasiomatteo@email.com','professionista', NULL, 88.75, 'Statunitense',3, 3),
    ('matteo@email.com','professionista', NULL, 60.75, 'Tedesca',3, 2);


/* TELEFONO */
INSERT INTO num_telefono_utenti (prefisso, num_telefono, id_utente) VALUES
                                                                        ('+39', '3331234567', 1),
                                                                        ('+39', '3477654321',  2),
                                                                        ('+1',  '2125557890', 3);

/* TELEFONO */
INSERT INTO num_telefono_agenzie(prefisso, num_telefono, id_agenzia) VALUES
                                                                         ('+39', '3391233567', 1),
                                                                         ('+39', '3778894021',  2),
                                                                         ('+1',  '2456558880', 3);

/* RECENSIONE */
INSERT INTO recensione (id_prenotazione, testo, rating_pulizia, rating_qualita, rating_disponibilita, rating_precisione)
VALUES
    (1, 'Alloggio molto pulito e centrale.', 5, 4, 5, 4),
    (2, 'Ottima comunicazione con l’host.', 4, 4, 5, 5),
    (3, NULL , 4, 3, 4, 4);


/* CONFERIMENTO (host–badge) */
INSERT INTO conferimento (id_host, categoria_badge) VALUES
    (2, 'PULIZIA'),
    (2, 'DISPONIBILITA'),
    (2, 'QUALITA'),
    (1, 'PRECISIONE'),
    (1, 'QUALITA');

/* CONOSCENZA (host–lingua) */
INSERT INTO conoscenza (id_host, id_lingua) VALUES
                                                (1, 1),
                                                (2, 2),
                                                (4,1),
                                                (5,    2);

/* DOTAZIONE (alloggio–servizio) */
INSERT INTO dotazione (id_servizio, id_alloggio) VALUES
                                                     (1, 1), -- WiFi in Loft Colosseo
                                                     (2, 1), -- Parcheggio
                                                     (1, 2), -- WiFi in Attico Duomo
                                                     (3, 2), -- Colazione
                                                     (1, 3); -- WiFi in Studio Midtown

/* AGGIUNTA (prenotazione–esperienza) */
INSERT INTO aggiunta_esperienze (id_esperienza, id_prenotazione, data_aggiunta) VALUES
                                                                                    (1, 1, '2025-06-11'),
                                                                                    (2, 1, '2025-06-12'),
                                                                                    (3, 2, '2025-07-02'),
                                                                                    (1, 3, '2025-08-20');

SET FOREIGN_KEY_CHECKS = 1;