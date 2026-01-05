package dto;

import java.time.LocalDate;

public record PrenotazioneDTO(int numOspiti, LocalDate dataInizio, LocalDate dataFine,
                              float costoTotale, int sconto, int idUtente, int idAlloggio) {}
