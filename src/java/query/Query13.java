// Stampa di una classifica degli host ordinata in base al numero totale di recensioni ricevute;
package query;

import dao.HostDAO;

import java.sql.Connection;

public class Query13 implements Query {
    public void executeQuery(Connection conn) {
        HostDAO.stampaHostRispostaAlta();
    }
}
