//Prenotazione di una esperienza;
package query;

import dao.AggiuntaEsperienzaDAO;
import dto.AggiuntaEsperienzeDTO;

import java.sql.Connection;
import java.util.Scanner;

public class Query2 implements Query {
    @Override

    public void executeQuery(Connection conn) {
        Scanner sc = new Scanner(System.in);

        System.out.print("ID Esperienza: ");
        int idEsperienza = sc.nextInt();

        System.out.print("ID Prenotazione: ");
        int idPrenotazione = sc.nextInt();

        AggiuntaEsperienzeDTO dto = new AggiuntaEsperienzeDTO(idEsperienza, idPrenotazione);
        AggiuntaEsperienzaDAO.aggiungiEsperienza(dto, conn);

        System.out.println("✓ Operazione completata!");
    }



}
