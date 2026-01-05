// Ricerca degli alloggi disponibili in un determinato range di date che possano accogliere almeno n ospiti
package query;

import dao.AlloggioDAO;
import dto.DisponibilitaDTO;

import java.sql.Connection;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Scanner;

public class Query10 implements Query {
    @Override
    public void executeQuery(Connection conn) {
        Scanner sc = new Scanner(System.in);

        System.out.print("Numero minimo ospiti: ");
        int numOspiti = sc.nextInt();
        sc.nextLine();

        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        System.out.print("Data inizio (yyyy-MM-dd): ");
        LocalDate dataInizio = LocalDate.parse(sc.nextLine(), dtf);

        System.out.print("Data fine (yyyy-MM-dd): ");
        LocalDate dataFine = LocalDate.parse(sc.nextLine(), dtf);

        DisponibilitaDTO dto = new DisponibilitaDTO(numOspiti, dataInizio, dataFine);
        AlloggioDAO.trovaAlloggiDisponibili(dto);

        System.out.println("✓ Ricerca completata!");
    }
}
