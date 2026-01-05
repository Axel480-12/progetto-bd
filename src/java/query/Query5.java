//Modifica del numero di locali di un appartamento;
package query;

import dao.AlloggioDAO;
import dto.ModificaLocaliDTO;

import java.sql.Connection;
import java.util.Scanner;

public class Query5 implements Query {
    @Override
    public void executeQuery(Connection conn) {
        Scanner sc = new Scanner(System.in);

        System.out.print("Nuovo numero locali: ");
        int numLocali = sc.nextInt();

        System.out.print("ID Alloggio (solo APPARTAMENTO): ");
        int idAlloggio = sc.nextInt();

        ModificaLocaliDTO dto = new ModificaLocaliDTO(numLocali, idAlloggio);
        AlloggioDAO.modificaLocali(dto);

        System.out.println("Operazione completata!");
    }
}
