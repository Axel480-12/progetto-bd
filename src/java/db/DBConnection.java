package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static volatile DBConnection instance;
    private Connection connection;

    private static final String URL =
            "jdbc:mysql://localhost:3306/gestionealloggi?serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "3l3-MySQL";

    private DBConnection() throws SQLException {
        this.connection = DriverManager.getConnection(URL, USER, PASSWORD);
    }

    public static DBConnection getInstance() throws SQLException {
        if (instance == null) {
            synchronized (DBConnection.class) {
                if (instance == null) {
                    instance = new DBConnection();
                }
            }
        }
        return instance;
    }

    public Connection getConnection() {
        return connection;
    }
}