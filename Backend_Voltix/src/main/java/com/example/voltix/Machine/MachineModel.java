package com.example.voltix.Machine;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;
import lombok.Data;
import com.example.voltix.CircuitBreakers.CircuitBreakerModel;

@Data
@Document(collection = "Machines")
public class MachineModel {
    @Id
    private String id;
    private String name;
    private String type;
    private double consomation;
    private String imageLink;
    private String marque;
    @DBRef
    private CircuitBreakerModel circuitBreaker;


}
