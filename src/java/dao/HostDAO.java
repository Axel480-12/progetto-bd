package dao;

import db.DBConnection;

import java.sql.*;

public class HostDAO {

    // Query 7
    private static final String SELECT_PROFESSIONISTI = """
        SELECT h.id, h.email, h.tipo_host, h.livello, h.tasso_risposta, h.nazionalita, 
               a.nome as agenzia, all.nome as alloggio
        FROM host h
        JOIN agenzia a ON h.id_agenzia = a.id
        JOIN alloggio all ON h.id_alloggio = all.id
        WHERE h.tipo_host = 'PROFESSIONISTA' AND h.id_agenzia = ?
        ORDER BY h.tasso_risposta DESC
        """;

    // Query 9
    private static final String SELECT_ALLOGGI_PER_HOST = """
        SELECT h.id, h.email, a.nome as nome_alloggio, h.tipo_host,
               COUNT(*) as num_alloggi
        FROM host h
        JOIN alloggio a ON h.id_alloggio = a.id
        GROUP BY h.id, h.email, a.nome, h.tipo_host
        ORDER BY num_alloggi DESC, h.email
        """;

    // Query 12
    private static final String SELECT_RATING_MEDIO_HOST = """
        SELECT h.id, h.email, h.tipo_host,
            ROUND(COALESCE(AVG(r.rating_pulizia), 0), 1) as avg_pulizia,
            ROUND(COALESCE(AVG(r.rating_qualita), 0), 1) as avg_qualita,
            ROUND(COALESCE(AVG(r.rating_posizione), 0), 1) as avg_posizione,
            ROUND(COALESCE(AVG(r.rating_servizi), 0), 1) as avg_servizi,
            COUNT(r.id) as num_recensioni
        FROM host h
        LEFT JOIN recensione r ON h.id = r.id_host
        GROUP BY h.id, h.email, h.tipo_host
        ORDER BY avg_pulizia DESC, avg_qualita DESC
        """;

    // Query 13
    private static final String SELECT_HOST_RISPOSTA_ALTA = """
        SELECT h.id, h.email, h.tasso_risposta, h.tipo_host, h.nazionalita,
               a.nome as agenzia
        FROM host h
        LEFT JOIN agenzia a ON h.id_agenzia = a.id
        WHERE h.tasso_risposta >= 80
        ORDER BY h.tasso_risposta DESC
        """;

    public static void stampaProfessionistiAgenzia(int idAgenzia) {
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_PROFESSIONISTI)) {

            ps.setInt(1, idAgenzia);
            ResultSet rs = ps.executeQuery();

            if (!rs.isBeforeFirst()) {
                System.err.println("Nessun professionista trovato per agenzia " + idAgenzia);
                return;
            }

            System.out.println("\nPROFESSIONISTI AGENZIA ID=" + idAgenzia);
            System.out.printf("%-4s | %-25s | %-12s | %-7s | %-12s | %-12s | %-20s%n",
                    "ID", "Email", "Tipo", "Livello", "Tasso%", "Nazionalità", "Agenzia/Alloggio");
            System.out.println("\n");

            while (rs.next()) {
                System.out.printf("%-4d | %-25s | %-12s | %-7s | %-12.1f | %-12s | %s / %s%n",
                        rs.getInt("id"),
                        rs.getString("email"),
                        rs.getString("tipo_host"),
                        rs.getString("livello"),
                        rs.getFloat("tasso_risposta"),
                        rs.getString("nazionalita"),
                        rs.getString("agenzia"),
                        rs.getString("alloggio")
                );
            }

            System.out.println("\n");

        } catch (SQLException e) {
            System.err.println("Errore stampa professionisti: " + e.getMessage());
        }
    }

    public static void stampaAlloggiPerHost() {
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_ALLOGGI_PER_HOST);
             ResultSet rs = ps.executeQuery()) {

            if (!rs.isBeforeFirst()) {
                System.err.println("Nessun host trovato");
                return;
            }

            System.out.println("\n NUMERO ALLOGGI PER HOST ");
            System.out.printf("%-4s | %-25s | %-20s | %-12s | %-12s%n",
                    "ID", "Email", "Alloggio", "Tipo Host", "N° Alloggi");
            System.out.println("\n");

            while (rs.next()) {
                System.out.printf("%-4d | %-25s | %-20s | %-12s | %-12d%n",
                        rs.getInt("id"),
                        rs.getString("email"),
                        rs.getString("nome_alloggio"),
                        rs.getString("tipo_host"),
                        rs.getInt("num_alloggi")
                );
            }
            System.out.println("\n");

        } catch (SQLException e) {
            System.err.println("Errore stampa alloggi host: " + e.getSQLState() + ", " + e.getMessage());
        }
    }

    public static void stampaRatingMediHost() {
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_RATING_MEDIO_HOST);
             ResultSet rs = ps.executeQuery()) {

            if (!rs.isBeforeFirst()) {
                System.err.println("Nessun host trovato");
                return;
            }

            System.out.println("\nRATING MEDI HOST (4 CATEGORIE)");
            System.out.printf("%-4s | %-25s | %-12s | %5s | %5s | %5s | %5s | %10s%n",
                    "ID", "Email", "Tipo", "Pulizia", "Qualità", "Posizione", "Servizi", "Recensioni");
            System.out.println("-------------------------------------------------------------------------------------");

            while (rs.next()) {
                System.out.printf("%-4d | %-25s | %-12s | %5.1f | %5.1f | %5.1f | %5.1f | %10d%n",
                        rs.getInt("id"),
                        rs.getString("email"),
                        rs.getString("tipo_host"),
                        rs.getFloat("avg_pulizia"),
                        rs.getFloat("avg_qualita"),
                        rs.getFloat("avg_posizione"),
                        rs.getFloat("avg_servizi"),
                        rs.getInt("num_recensioni")
                );
            }
            System.out.println("\n");

        } catch (SQLException e) {
            System.err.println("Errore rating host: " + e.getSQLState() + ", " + e.getMessage());
        }
    }

    public static void stampaHostRispostaAlta() {
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_HOST_RISPOSTA_ALTA);
             ResultSet rs = ps.executeQuery()) {

            if (!rs.isBeforeFirst()) {
                System.err.println("Nessun host trovato con tasso di risposta maggiore all'80%");
                return;
            }

            System.out.println("\n HOST CON TASSO RISPOSTA MAGGIORE O UGUALE ALL'80% ");
            System.out.printf("%-4s | %-25s | %-10s | %-12s | %-12s | %-15s%n",
                    "ID", "Email", "Tasso%", "Tipo", "Nazionalità", "Agenzia");
            System.out.println("\n");

            while (rs.next()) {
                System.out.printf("%-4d | %-25s | %-10.1f | %-12s | %-12s | %-15s%n",
                        rs.getInt("id"),
                        rs.getString("email"),
                        rs.getFloat("tasso_risposta"),
                        rs.getString("tipo_host"),
                        rs.getString("nazionalita"),
                        rs.getString("agenzia") != null ? rs.getString("agenzia") : "-"
                );
            }
            System.out.println("\n");

        } catch (SQLException e) {
            System.err.println("✗ Errore host alta risposta: " + e.getMessage());
        }
    }
}
