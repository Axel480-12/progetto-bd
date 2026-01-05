package dao;

import db.DBConnection;
import dto.PrenotazioneDTO;

import java.sql.*;

public class PrenotazioneDAO {

    private static final String INSERT_PRENOTAZIONE = """
                INSERT INTO prenotazione (n_ospiti, data_inizio, data_fine, costo_totale, sconto, id_utente, id_alloggio)
                VALUES (?, ?, ?, ?, ?, ?, ?)
            """;

    public static void registraPrenotazione(PrenotazioneDTO dto) {
        try (Connection conn = DBConnection.getInstance().getConnection()) {
            try (PreparedStatement ps = conn.prepareStatement(INSERT_PRENOTAZIONE)) {
                ps.setInt(1, dto.numOspiti());
                ps.setDate(2, Date.valueOf(dto.dataInizio()));
                ps.setDate(3, Date.valueOf(dto.dataFine()));
                ps.setFloat(4, dto.costoTotale());
                ps.setInt(5, dto.sconto());
                ps.setInt(6, dto.idUtente());
                ps.setInt(7, dto.idAlloggio());
                ps.executeUpdate();
            }
        } catch (SQLException e) {
            System.err.println(e.getSQLState() + ": " + e.getMessage());
        }
    }
}
