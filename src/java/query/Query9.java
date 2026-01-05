// Stampa del numero di alloggi gestiti da ogni host;
package query;

import dao.HostDAO;

import java.sql.Connection;

public class Query9 implements Query {
    @Override
    public void executeQuery(Connection conn) {
        HostDAO.stampaAlloggiPerHost();
    }
}
