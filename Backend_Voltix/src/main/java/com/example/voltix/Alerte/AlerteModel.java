package com.example.voltix.Alerte;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;
import lombok.Data;
import com.example.voltix.CircuitBreakers.CircuitBreakerModel;

@Data
@Document(collection = "Alerte")
public class AlerteModel {
    @Id
    private String id;
    private String content;
    private String type;
    private boolean viewed;
    @DBRef
    private CircuitBreakerModel cause;

}
