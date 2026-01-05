package dao;

import db.DBConnection;

import java.sql.*;

public class UtenteDAO {

    // Query 8
    private static final String SELECT_UTENTI_PRENOTAZIONI = """
        
            SELECT u.id, u.nome, u.cognome, u.email,
               COALESCE(COUNT(p.id), 0) as num_prenotazioni
        FROM utente u
        LEFT JOIN prenotazione p ON u.id = p.id_utente
        GROUP BY u.id, u.nome, u.cognome, u.email
        ORDER BY num_prenotazioni DESC, u.nome
        """;

    // Query 11
    private static final String SELECT_UTENTI_CON_30_GIORNI = """
        SELECT u.id, u.nome, u.cognome, u.email,
               SUM(DATEDIFF(p.data_fine, p.data_inizio)) as giorni_totali
        FROM utente u
        JOIN prenotazione p ON u.id = p.id_utente
        GROUP BY u.id, u.nome, u.cognome, u.email
        HAVING giorni_totali >= 30
        ORDER BY giorni_totali DESC
        """;

    // Query 15
    private static final String SELECT_UTENTI_SENZA_ESPERIENZE = """
        SELECT u.id, u.nome, u.cognome, u.email
        FROM utente u
        WHERE NOT EXISTS (
            SELECT 1 FROM prenotazione p
            JOIN aggiunta_esperienze ae ON p.id = ae.id_prenotazione
            WHERE p.id_utente = u.id
        )
        ORDER BY u.nome, u.cognome
        """;

    public static void stampaUtentiConPrenotazioni() {
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_UTENTI_PRENOTAZIONI);
             ResultSet rs = ps.executeQuery()) {

            if (!rs.isBeforeFirst()) {
                System.err.println("Nessun utente presente in piattaforma");
                return;
            }

            System.out.println("\n UTENTI + NUMERO PRENOTAZIONI ");
            System.out.printf("%-4s | %-15s | %-15s | %-25s | %-15s%n",
                    "ID", "Nome", "Cognome", "Email", "Prenotazioni");
            System.out.println("\n");

            while (rs.next()) {
                System.out.printf("%-4d | %-15s | %-15s | %-25s | %-15d%n",
                        rs.getInt("id"),
                        rs.getString("nome"),
                        rs.getString("cognome"),
                        rs.getString("email"),
                        rs.getInt("num_prenotazioni")
                );
            }
            System.out.println("\n");

        } catch (SQLException e) {
            System.err.println("Errore stampa utenti: " + e.getSQLState() + ", " + e.getMessage());
        }
    }

    public static void stampaUtentiPiu30Giorni() {
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_UTENTI_CON_30_GIORNI);
             ResultSet rs = ps.executeQuery()) {

            if (!rs.isBeforeFirst()) {
                System.err.println("Nessun utente ha prenotato più di 30 giorni totali");
                return;
            }

            System.out.println("\n UTENTI CON PIU DI 30 GIORNI PRENOTATI ");
            System.out.printf("%-4s | %-15s | %-15s | %-25s | %-12s%n",
                    "ID", "Nome", "Cognome", "Email", "Giorni Totali");
            System.out.println("\n");

            while (rs.next()) {
                System.out.printf("%-4d | %-15s | %-15s | %-25s | %-12d%n",
                        rs.getInt("id"),
                        rs.getString("nome"),
                        rs.getString("cognome"),
                        rs.getString("email"),
                        rs.getInt("giorni_totali")
                );
            }

            System.out.println("\n");
        } catch (SQLException e) {
            System.err.println("✗ Errore utenti ≥30gg: " + e.getMessage());
        }
    }

    public static void stampaUtentiSenzaEsperienze() {
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_UTENTI_SENZA_ESPERIENZE);
             ResultSet rs = ps.executeQuery()) {

            if (!rs.isBeforeFirst()) {
                System.err.println("Non sono stati trovati utenti con zero esperienze prenotate");
                return;
            }

            System.out.println("\n=== UTENTI SENZA PRENOTAZIONI ESPERIENZE ===");
            System.out.printf("%-4s | %-15s | %-15s | %-25s%n",
                    "ID", "Nome", "Cognome", "Email");
            System.out.println("---------------------------------------------------------");

            while (rs.next()) {
                System.out.printf("%-4d | %-15s | %-15s | %-25s%n",
                        rs.getInt("id"),
                        rs.getString("nome"),
                        rs.getString("cognome"),
                        rs.getString("email")
                );
            }
            System.out.println("\n");
        } catch (SQLException e) {
            System.err.println("Errore utenti senza esperienze: " + e.getSQLState() + ", " + e.getMessage());
        }
    }
}
