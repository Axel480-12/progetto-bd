// 1. Registrazione di una nuova prenotazione per un alloggio;

package query;

import dto.PrenotazioneDTO;
import dao.PrenotazioneDAO;

import java.sql.Connection;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Scanner;

public class Query1 implements Query {

    @Override
    public void executeQuery(Connection conn) {
        int numOspiti, sconto, idUtente, idAlloggio;
        LocalDate dataInizio, dataFine;
        float costoTotale;

        Scanner sc = new Scanner(System.in);
        System.out.print("Numero di ospiti: ");
        numOspiti = sc.nextInt();

        sc.nextLine();

        final DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd-MM-yyyy");

        System.out.print("Data di inizio (gg-MM-aaaa): ");
        dataInizio = LocalDate.parse(sc.nextLine(), dtf);

        System.out.print("Data di fine (gg-MM-aaaa): ");
        dataFine = LocalDate.parse(sc.nextLine(), dtf);

        System.out.print("Costo Totale: ");
        costoTotale = sc.nextInt();

        System.out.println("Sconto:");
        sconto = sc.nextInt();

        System.out.print("Id Utente: ");
        idUtente = sc.nextInt();

        System.out.print("Id Alloggio: ");
        idAlloggio = sc.nextInt();


        PrenotazioneDTO dto = new PrenotazioneDTO(
                numOspiti,
                dataInizio,
                dataFine,
                costoTotale,
                sconto,
                idUtente,
                idAlloggio
        );

        PrenotazioneDAO.registraPrenotazione(dto);

        System.out.println("Prenotazione effettuata con successo: ");
    }
}
