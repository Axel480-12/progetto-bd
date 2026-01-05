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
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(INSERT_PRENOTAZIONE)) {
            ps.setInt(1, dto.numOspiti());
            ps.setDate(2, Date.valueOf(dto.dataInizio()));
            ps.setDate(3, Date.valueOf(dto.dataFine()));
            ps.setFloat(4, dto.costoTotale());
            ps.setInt(5, dto.sconto());
            ps.setInt(6, dto.idUtente());
            ps.setInt(7, dto.idAlloggio());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println(e.getSQLState() + ": " + e.getMessage());
        }
    }

    public static void stampaTuttePrenotazioni() {
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_ALL);
             ResultSet rs = ps.executeQuery()) {

            System.out.println("\nTUTTE LE PRENOTAZIONI ");
            System.out.printf("%-5s | %-10s | %-10s | %-10s | %-10s | %-8s | %-15s | %-20s%n",
                    "ID", "Ospiti", "Inizio", "Fine", "Costo", "Sconto", "Utente", "Alloggio");
            System.out.println("__");

            while (rs.next()) {
                System.out.printf("%-5d | %-10d | %-10s | %-10s | %-10.2f | %-8d | %-15s | %-20s%n",
                        rs.getInt("id"),
                        rs.getInt("n_ospiti"),
                        rs.getString("data_inizio"),
                        rs.getString("data_fine"),
                        rs.getFloat("importo_netto"),
                        rs.getInt("sconto"),
                        rs.getString("nome") + " " + rs.getString("cognome"),
                        rs.getString("nome_alloggio")
                );
            }
            System.out.println("\n");

        } catch (SQLException e) {
            System.err.println("Errore stampa prenotazioni: " + e.getSQLState() + ", " + e.getMessage());
        }
    }
}
