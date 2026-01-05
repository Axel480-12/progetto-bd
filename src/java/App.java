import query.Query;
import query.QueryFactory;

import java.util.Scanner;

public class App {
    public static void main(String[] args) {

        Scanner sc = new Scanner(System.in);
        int scelta;

        do {
            stampaMenu();
            scelta = sc.nextInt();

            Query query = QueryFactory.getQuery(scelta);

            if (query != null) {
                query.executeQuery();
            } else if (scelta != 0) {
                System.out.println("Scelta non valida.");
            }

        } while (scelta != 0);

        System.out.println("Uscita");
    }

    private static void stampaMenu() {
        System.out.println("\n--- MENU ---");
        System.out.println("0. Esci");
        System.out.println("1. Registrazione di una nuova prenotazione per un alloggio");
        System.out.println("2. Prenotazione di una esperienza");
        System.out.println("3. Aggiunta di un nuovo alloggio");
        System.out.println("4. Aggiunta di un servizio per uno specifico alloggio");
        System.out.println("5. Modifica del numero di locali di un appartamento");
        System.out.println("6. Stampa di tutte le prenotazioni registrate, compreso l’importo totale");
        System.out.println("7. Stampa i dati dei professionisti che lavorano presso una specifica agenzia");
        System.out.println("8. Stampa di tutti gli utenti, compreso il numero di prenotazioni effettuate");
        System.out.println("9. Stampa del numero di alloggi gestiti da ogni host");
        System.out.println("10. Ricerca degli alloggi disponibili in un determinato range di date che possano accogliere almeno n ospiti");
        System.out.println("11. Stampa di tutti gli utenti che hanno effettuato prenotazioni per un totale di almeno 30 giorni");
        System.out.println("12. Stampa del rating medio di ciascun host per ognuno dei 4 rating delle recensioni (Disponibilità, Qualità, Precisione, Pulizia)");
        System.out.println("13. Stampa di una classifica degli host ordinata in base al numero totale di recensioni ricevute");
        System.out.println("14. Stampa Nome e Descrizione degli alloggi che hanno ospitato (in totale) almeno 30 ospiti");
        System.out.println("15. Stampa di tutti gli utenti che non hanno prenotato alcuna esperienza");
    }
}
