package dto;

public record AlloggioDTO(String nome,
                          int numMaxOspiti,
                          boolean animali,
                          String url, boolean utenza,
                          String descrizione,
                          String tipoAlloggio,
                          int numCivico,
                          String via,
                          float costoNotte,
                          int idCitta
) {}
