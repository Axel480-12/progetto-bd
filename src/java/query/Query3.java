//Aggiunta di un nuovo alloggio;
package query;

import dao.AlloggioDAO;
import dto.AlloggioDTO;

import java.sql.Connection;
import java.util.Scanner;

public class Query3 implements Query {
    @Override
    public void executeQuery(Connection conn) {
        Scanner sc = new Scanner(System.in);

        System.out.print("Nome alloggio: ");
        String nome = sc.nextLine();

        System.out.print("Num max ospiti: ");
        int numMaxOspiti = sc.nextInt();

        System.out.print("Animali ammessi (true/false): ");
        boolean animali = sc.nextBoolean();
        sc.nextLine(); // Consuma newline

        System.out.print("URL: ");
        String url = sc.nextLine();

        System.out.print("Utenza (true/false): ");
        boolean utenza = sc.nextBoolean();
        sc.nextLine();

        System.out.print("Descrizione: ");
        String descrizione = sc.nextLine();

        System.out.print("Tipo alloggio (CAMERA/APPARTAMENTO/VILLA): ");
        String tipoAlloggio = sc.nextLine();

        System.out.print("Via: ");
        String via = sc.nextLine();

        System.out.print("Numero civico: ");
        int numCivico = sc.nextInt();
        sc.nextLine();

        System.out.print("Costo per notte: ");
        float costoNotte = sc.nextFloat();
        sc.nextLine();

        System.out.print("ID Città: ");
        int idCitta = sc.nextInt();

        AlloggioDTO dto = new AlloggioDTO(
                nome, numMaxOspiti, animali, url, utenza, descrizione,
                tipoAlloggio, numCivico, via, costoNotte, idCitta
        );

        AlloggioDAO.aggiungiAlloggio(dto);
        System.out.println("Operazione completata!");
    }
    }

