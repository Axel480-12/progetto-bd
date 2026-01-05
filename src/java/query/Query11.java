//Stampa di tutti gli utenti che hanno effettuato prenotazioni per un totale di almeno 30 giorni;
package query;

import dao.UtenteDAO;

import java.sql.Connection;

public class Query11 implements Query {
    @Override
    public void executeQuery(Connection conn) {
        UtenteDAO.stampaUtentiPiu30Giorni();
    }
}
