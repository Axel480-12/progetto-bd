//Aggiunta di un servizio per uno specifico alloggio;
package query;

import dao.DotazioneDAO;
import dto.DotazioneDTO;

import java.sql.Connection;
import java.util.Scanner;

public class Query4 implements Query {
    @Override
    public void executeQuery(Connection conn) {
        Scanner sc = new Scanner(System.in);

        System.out.print("ID Servizio: ");
        int idServizio = sc.nextInt();

        System.out.print("ID Alloggio: ");
        int idAlloggio = sc.nextInt();

        DotazioneDTO dto = new DotazioneDTO(idServizio, idAlloggio);
        DotazioneDAO.aggiungiServizio(dto);

        System.out.println("Operazione completata!");
    }
}
