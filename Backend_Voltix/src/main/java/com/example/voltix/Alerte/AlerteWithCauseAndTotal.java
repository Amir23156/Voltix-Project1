package com.example.voltix.Alerte;

import com.example.voltix.CircuitBreakers.CircuitBreakerModel;

import lombok.Data;

@Data
public class AlerteWithCauseAndTotal {
    private AlerteModel alerte;
    private CircuitBreakerModel cause;
    private double totalConsumption;

    public AlerteWithCauseAndTotal(AlerteModel alerte, CircuitBreakerModel cause, double totalConsumption) {
        this.alerte = alerte;
        this.cause = cause;
        this.totalConsumption = totalConsumption;
    }

    // Getters and setters
}
