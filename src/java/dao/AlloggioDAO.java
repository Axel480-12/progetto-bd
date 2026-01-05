package dao;

import db.DBConnection;
import dto.AlloggioDTO;
import dto.DisponibilitaDTO;
import dto.ModificaLocaliDTO;

import java.sql.*;

public class AlloggioDAO {

    // Query 2
    private static final String INSERT_ALLLOGGIO = """
        INSERT INTO alloggio (nome, num_max_ospiti, animali, url, utenza, descrizione, 
                             tipo_alloggio, num_civico, via, costo_per_notte, id_citta)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        """;

    // Query 5
    private static final String UPDATE_NUM_LOCALI_APPARTAMENTO = """
            UPDATE alloggio SET num_locali = ? WHERE id = ? AND tipo_alloggio = 'APPARTAMENTO'
            """;

    // Query 10
    private static final String SELECT_ALLOGGI_DISPONIBILI_IN_RANGE = """
        SELECT DISTINCT a.id, a.nome, a.num_max_ospiti, a.tipo_alloggio, a.costo_per_notte,
               c.nome as citta
        FROM alloggio a
        JOIN citta c ON a.id_citta = c.id
        WHERE a.num_max_ospiti >= ?
        AND NOT EXISTS (
            SELECT 1 FROM prenotazione p
            WHERE p.id_alloggio = a.id
            AND NOT (p.data_fine < ? OR p.data_inizio > ?)
        )
        ORDER BY a.costo_per_notte ASC
        """;

    // Query 14
    private static final String SELECT_ALLOGGI_CON_ALMENO_TRENTA_OSPITI = """
        SELECT a.id, a.nome, a.descrizione,
               SUM(p.n_ospiti) as ospiti_totali
        FROM alloggio a
        JOIN prenotazione p ON a.id = p.id_alloggio
        GROUP BY a.id, a.nome, a.descrizione
        HAVING ospiti_totali >= 30
        ORDER BY ospiti_totali DESC
        """;

    public static void aggiungiAlloggio(AlloggioDTO dto) {
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(INSERT_ALLLOGGIO, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, dto.nome());
            ps.setInt(2, dto.numMaxOspiti());
            ps.setBoolean(3, dto.animali());
            ps.setString(4, dto.url());
            ps.setBoolean(5, dto.utenza());
            ps.setString(6, dto.descrizione());
            ps.setString(7, dto.tipoAlloggio());
            ps.setInt(8, dto.numCivico());
            ps.setString(9, dto.via());
            ps.setFloat(10, dto.costoNotte());
            ps.setInt(11, dto.idCitta());

            ps.executeUpdate();

            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (!keys.next()) {
                    throw new RuntimeException("Errore durante il salvataggio");
                }

                System.out.println("Alloggio aggiunto! ID generato: " + keys.getInt(1));
            }

        } catch (SQLException e) {
            System.err.println("Errore aggiunta alloggio: " + e.getSQLState() + ", " + e.getMessage());
        }
    }

    public static void modificaLocali(ModificaLocaliDTO dto) {
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(UPDATE_NUM_LOCALI_APPARTAMENTO)) {

            ps.setInt(1, dto.numLocali());
            ps.setInt(2, dto.idAlloggio());

            int rows = ps.executeUpdate();

            if (rows == 0) {
                throw new IllegalArgumentException("Nessun appartamento trovato con ID: " + dto.idAlloggio());
            }

            System.out.println("Numero di locali modificato per appartamento con ID: " + dto.idAlloggio());
        } catch (SQLException e) {
            System.err.println("Errore modifica locali: " + e.getSQLState() + ", " + e.getMessage());
        }
    }

    public static void trovaAlloggiDisponibili(DisponibilitaDTO dto) {
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_ALLOGGI_DISPONIBILI_IN_RANGE)) {

            ps.setInt(1, dto.numOspitiMin());
            ps.setDate(2, Date.valueOf(dto.dataInizio()));
            ps.setDate(3, Date.valueOf(dto.dataFine()));

            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.isBeforeFirst()) {
                    System.err.println("Nessun alloggio disponibile in questo range di date/numero diospiti");
                    return;
                }

                System.out.println("\n=== ALLOGGI DISPONIBILI " + dto.dataInizio() + " → " + dto.dataFine() + " (" + dto.numOspitiMin() + "+ ospiti) ===");
                System.out.printf("%-4s | %-20s | %-3s ospiti | %-12s | %-10s | %-15s%n",
                        "ID", "Nome", "Max", "Tipo", "Costo €", "Città");
                System.out.println("\n");

                while (rs.next()) {
                    System.out.printf("%-4d | %-20s | %-3d ospiti | %-12s | %-10.0f | %-15s%n",
                            rs.getInt("id"),
                            rs.getString("nome"),
                            rs.getInt("num_max_ospiti"),
                            rs.getString("tipo_alloggio"),
                            rs.getFloat("costo_per_notte"),
                            rs.getString("citta")
                    );
                }
                System.out.println("\n");

            }
        } catch (SQLException e) {
            System.err.println("Errore ricerca alloggi: " + e.getMessage());
        }
    }

    public static void stampaAlloggiConAlmenoTrentaOspiti() {
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_ALLOGGI_CON_ALMENO_TRENTA_OSPITI);
             ResultSet rs = ps.executeQuery()) {

            if (!rs.isBeforeFirst()) {
                System.err.println("Nessun alloggio ha ospitato più di 30 ospiti in totale");
                return;
            }

            System.out.println("\n=== ALLOGGI CON ≥30 OSPITI TOTALI ===");
            System.out.printf("%-25s | %-40s | %-12s%n",
                    "Nome Alloggio", "Descrizione", "Ospiti Totali");

            while (rs.next()) {
                System.out.printf("%-25s | %-40s | %-12d%n",
                        rs.getString("nome"),
                        rs.getString("descrizione"),
                        rs.getInt("ospiti_totali")
                );
            }
            System.out.println("\n");
        } catch (SQLException e) {
            System.err.println("Errore alloggi ospiti: " + e.getMessage());
        }
    }
}
