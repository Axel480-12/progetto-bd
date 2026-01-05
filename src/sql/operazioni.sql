
-- Le operazioni da realizzare sono le seguenti:
-- 1. Registrazione di una nuova prenotazione per un alloggio;
-- 2. Prenotazione di una esperienza;
-- 3. Aggiunta di un nuovo alloggio;
-- 4. Aggiunta di un servizio per uno specifico alloggio;
-- 5. Modifica del numero di locali di un appartamento;
-- 6. Stampa di tutte le prenotazioni registrate, compreso l’importo totale;
-- 7. Stampa i dati dei professionisti che lavorano presso una specifica agenzia;
-- 8. Stampa di tutti gli utenti, compreso il numero di prenotazioni effettuate;
-- 9. Stampa del numero di alloggi gestiti da ogni host;
-- 10.Ricerca degli alloggi disponibili in un determinato range di date che possano accogliere almeno n ospiti
-- 11.Stampa di tutti gli utenti che hanno effettuato prenotazioni per un totale di almeno 30 giorni;
-- 12.Stampa del rating medio di ciascun host per ognuno dei 4 rating delle recensioni (Disponibilità, Qualità, Precisione, Pulizia);
-- 13.Stampa di una classifica degli host ordinata in base al numero totale di recensioni ricevute;
-- 14.Stampa Nome e Descrizione degli alloggi che hanno ospitato (in totale) almeno 30 ospiti;
-- 15.Stampa di tutti gli utenti che non hanno prenotato alcuna esperienza

-- OPERAZIONE 1: REGISTRAZIONE DI UNA NUOVA PRENOTAZIONE

INSERT INTO prenotazione (n_ospiti, data_inizio, data_fine, costo_totale, sconto, email_utente);
INSERT INTO assegnazione (id_prenotazione, id_allogggio);

-- OPERAZIONE 2: PRENOTAZIONE ESPERIENZA

INSERT INTO aggiunta (id_esperienza, id_prenotazione, data_aggiunta);

-- OPERAZIONE 3: AGGIUNTA DI UN NUOVO ALLOGGIO

INSERT INTO alloggio (nome, num_max_ospiti, animali, link, utenza, descrizione, num_servizi_offerti, genere_presente, genere, num_piani, tipo_alloggio, bagno_privato, giardino, metri_quadri, num_civico, via, costo_per_notte, num_locali, nome_citta, nazione_citta, regione_citta);

-- OPERAZIONE 4: AGGIUNTA DI UN SERVIZIO PER UNO SPECIFICO ALLOGGIO

INSERT INTO dotazione (id_servizio, id_alloggio);

--OPERAZIONE 5: MODIFICA DEL NUMERO DI LOCALI DI UN APPARTAMENTO

UPDATE alloggio SET num_locali = ? WHERE id_alloggio = ? AND tipo_alloggio = 'appartamento';
-- OPERAZIONE 6: Stampa di tutte le prenotazioni registrate, compreso l’importo totale;

SELECT p.*, p.costo_totale - p.sconto, 0 AS importo_netto
FROM prenotazione p ORDER BY p.id_prenotazione DESC;

-- OPERAZIONE 7. Stampa i dati dei professionisti che lavorano presso una specifica agenzia;

SELECT h.* FROM host h WHERE h.tipo_host = 'professionista' AND h.id_agenzia = 1;


-- OPERAZIONE 8. Stampa di tutti gli utenti, compreso il numero di prenotazioni effettuate;

SELECT u.nome, u.cognome, COUNT(p.id_prenotazione) AS num_prenotazioni
FROM utente u LEFT JOIN prenotazione p ON u.email = p.email_utente
GROUP BY u.email ORDER BY num_prenotazioni DESC;

-- OPERAZIONE 9. Stampa del numero di alloggi gestiti da ogni host;

SELECT h.email, COUNT(h.id_alloggio) AS num_alloggi FROM host h GROUP BY h.email;

-- OPERAZIONE 10.Ricerca degli alloggi disponibili in un determinato range di date che possano accogliere almeno n ospiti

SELECT DISTINCT a.* FROM alloggio a
WHERE a.num_max_ospiti >= ?
  AND NOT EXISTS (
    SELECT 1 FROM assegnazione asg
                      JOIN prenotazione p ON asg.id_prenotazione = p.id_prenotazione
    WHERE asg.id_alloggio = a.id_alloggio
      AND NOT (p.data_fine < ? OR p.data_inizio > ?)
);

-- OPERAZIONE 11.Stampa di tutti gli utenti che hanno effettuato prenotazioni per un totale di almeno 30 giorni;

SELECT  u.* FROM utente u JOIN prenotazione p ON u.email = p.email_utente
GROUP BY u.email HAVING SUM(DATEDIFF(p.data_fine, p.data_inizio)) >= 30;

-- OPERAZIONE 12.Stampa del rating medio di ciascun host per ognuno dei 4 rating delle recensioni (Disponibilità, Qualità, Precisione, Pulizia);

SELECT h.email,
       AVG(r.rating_pulizia) AS avg_pulizia,
       AVG(r.rating_qualita) AS avg_qualita,
       AVG(r.rating_disponiilita) AS avg_disponibilita,
       AVG(r.rating_precisione) AS avg_precisione
FROM host h JOIN alloggio a ON h.id_alloggio = a.id_alloggio
            JOIN assegnazione asg ON a.id_alloggio = asg.id_alloggio
            JOIN prenotazione p ON asg.id_prenotazione = p.id_prenotazione
            JOIN recensione r ON p.id_prenotazione = r.id_prenotazione
GROUP BY h.email;

-- OPERAZIONE 13.Stampa di una classifica degli host ordinata in base al numero totale di recensioni ricevute;

SELECT h.email, COUNT(r.data_recensione) AS num_recensioni
FROM host h JOIN alloggio a ON h.id_alloggio = a.id_alloggio
            JOIN assegnazione asg ON a.id_alloggio = asg.id_alloggio
            JOIN recensione r ON asg.id_prenotazione = r.id_prenotazione
GROUP BY h.email ORDER BY num_recensioni DESC;

-- OPERAZIONE 14.Stampa Nome e Descrizione degli alloggi che hanno ospitato (in totale) almeno 30 ospiti;

SELECT a.nome, a.descrizione FROM alloggio a
WHERE (SELECT SUM(p.n_ospiti) FROM assegnazione asg
                                       JOIN prenotazione p ON asg.id_prenotazione = p.id_prenotazione
       WHERE asg.id_alloggio = a.id_alloggio) >= ?;

-- OPERAZIONE 15.Stampa di tutti gli utenti che non hanno prenotato alcuna esperienza

SELECT u.* FROM utente u
WHERE NOT EXISTS (
    SELECT 1 FROM prenotazione p
                      JOIN aggiunta agg ON p.id_prenotazione = agg.id_prenotazione
    WHERE p.email_utente = u.email
);