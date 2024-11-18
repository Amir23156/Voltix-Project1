package com.example.voltix.CircuitBreakers;

import java.util.List;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;

import com.example.voltix.Zones.ZoneModel;

import lombok.Data;

@Data
@Document(collection = "circuitBreakers")
public class CircuitBreakerModel {
    @Id
    private String id;
    private String circuitBreakerName;
    private String circuitBreakerRefrence;

    @DBRef
    private ZoneModel zone;

    private double limitConsomation;

}
