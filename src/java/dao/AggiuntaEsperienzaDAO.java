package dao;

import db.DBConnection;
import dto.AggiuntaEsperienzeDTO;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AggiuntaEsperienzaDAO {

    private static final String INSERT_AGGIUNTA = """
        INSERT INTO aggiunta_esperienze (id_esperienza, id_prenotazione, data_aggiunta)
        VALUES (?, ?, CURRENT_DATE)
        """;

    public static void aggiungiEsperienza(AggiuntaEsperienzeDTO dto, Connection conn) {
        try (PreparedStatement ps = conn.prepareStatement(INSERT_AGGIUNTA)) {

            ps.setInt(1, dto.idEsperienza());
            ps.setInt(2, dto.idPrenotazione());
            int rows = ps.executeUpdate();

            System.out.println("Esperienza aggiunta! Righe modificate: " + rows);
        } catch (SQLException e) {
            System.err.println(e.getSQLState() + ": " + e.getMessage());
        }
    }
}

