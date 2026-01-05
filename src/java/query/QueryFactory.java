package query;

import java.util.HashMap;
import java.util.Map;

public class QueryFactory {
    private static final Map<Integer, Query> queries = new HashMap<>();

    static {
        // aggiunta query
        queries.put(1, new Query1());
    }

    public static Query getQuery(int scelta) {
        return queries.get(scelta);
    }
}
