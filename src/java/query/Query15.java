// Stampa di tutti gli utenti che non hanno prenotato alcuna esperienza
package query;

import dao.UtenteDAO;

import java.sql.Connection;

public class Query15 implements Query {
    @Override
    public void executeQuery(Connection conn) {
        UtenteDAO.stampaUtentiSenzaEsperienze();
    }
}
