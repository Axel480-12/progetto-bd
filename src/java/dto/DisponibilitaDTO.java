package dto;

import java.time.LocalDate;

public record DisponibilitaDTO(int numOspitiMin,
                               LocalDate dataInizio,
                               LocalDate dataFine
) {}
