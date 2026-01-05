//Stampa di tutte le prenotazioni registrate, compreso l’importo totale;

package query;

import dao.PrenotazioneDAO;

import java.sql.Connection;

public class Query6 implements Query {
    @Override
    public void executeQuery(Connection conn) {
        PrenotazioneDAO.stampaTuttePrenotazioni();
    }

    @Override
    public void executeQuery() {
        PrenotazioneDAO.stampaTuttePrenotazioni();
    }
}
