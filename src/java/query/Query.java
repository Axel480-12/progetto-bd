package query;

import java.sql.Connection;

public interface Query{
    void executeQuery(Connection conn);
    default void executeQuery() {
        executeQuery(null);
    }
}
