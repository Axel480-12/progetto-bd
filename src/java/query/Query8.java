// Stampa di tutti gli utenti, compreso il numero di prenotazioni effettuate;
package query;

import dao.UtenteDAO;

import java.sql.Connection;

public class Query8 implements Query {
    @Override
    public void executeQuery(Connection conn) {
        UtenteDAO.stampaUtentiConPrenotazioni();
    }
}
