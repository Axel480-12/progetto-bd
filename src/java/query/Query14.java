// Stampa Nome e Descrizione degli alloggi che hanno ospitato (in totale) almeno 30 ospiti;
package query;

import dao.AlloggioDAO;

import java.sql.Connection;

public class Query14 implements Query {
    @Override
    public void executeQuery(Connection conn) {
        AlloggioDAO.stampaAlloggiConAlmenoTrentaOspiti();
    }
}
