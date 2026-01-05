// Stampa i dati dei professionisti che lavorano presso una specifica agenzia;
package query;

import dao.HostDAO;

import java.sql.Connection;
import java.util.Scanner;

public class Query7 implements Query {
    @Override
    public void executeQuery(Connection conn) {
        Scanner sc = new Scanner(System.in);
        System.out.print("ID Agenzia: ");
        int idAgenzia = sc.nextInt();

        HostDAO.stampaProfessionistiAgenzia(idAgenzia);
    }
}
