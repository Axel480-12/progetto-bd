package query;

import java.util.HashMap;
import java.util.Map;

public class QueryFactory {
    private static final Map<Integer, Query> queries = new HashMap<>();

    static {
        // aggiunta query
        queries.put(1, new Query1());
        queries.put(2, new Query2());
        queries.put(3, new Query3());
        queries.put(4, new Query4());
        queries.put(5, new Query5());
        queries.put(6, new Query6());
        queries.put(7, new Query7());
        queries.put(8, new Query8());
        queries.put(9, new Query9());
        queries.put(10, new Query10());
        queries.put(11, new Query11());
        queries.put(12, new Query12());
        queries.put(13, new Query13());
        queries.put(14, new Query14());
        queries.put(15, new Query15());
    }

    public static Query getQuery(int scelta) {
        return queries.get(scelta);
    }
}
