//Stampa del rating medio di ciascun host per ognuno dei 4 rating delle recensioni (Disponibilità, Qualità, Precisione, Pulizia);
package query;

import dao.HostDAO;

import java.sql.Connection;

public class Query12 implements Query {
    @Override
    public void executeQuery(Connection conn) {
        HostDAO.stampaRatingMediHost();
    }
}
