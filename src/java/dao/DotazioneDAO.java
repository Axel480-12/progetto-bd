package dao;

import db.DBConnection;
import dto.DotazioneDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;


public class DotazioneDAO {

    private static final String INSERT_DOTAZIONE = """
        INSERT INTO dotazione (id_servizio, id_alloggio)
        VALUES (?, ?)
        """;

    public static void aggiungiServizio(DotazioneDTO dto) {
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(INSERT_DOTAZIONE)) {

            ps.setInt(1, dto.idServizio());
            ps.setInt(2, dto.idAlloggio());

            ps.executeUpdate();
            System.out.println("Servizio aggiunto all'alloggio!");

        } catch (SQLException e) {
            System.err.println("Errore aggiunta servizio: " + e.getSQLState() + ", " + e.getMessage());
        }
    }
}
