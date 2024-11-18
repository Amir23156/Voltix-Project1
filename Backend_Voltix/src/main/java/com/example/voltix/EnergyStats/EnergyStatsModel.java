package com.example.voltix.EnergyStats;
import java.time.LocalDate;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;
import com.example.voltix.Zones.ZoneModel;
import lombok.Data;

@Data
@Document(collection = "EnergyStats")
public class EnergyStatsModel {
    @Id
    private String id;
    private Double dailyConsumption;
    private Double monthlyConsumption;
    private Double annualConsumption;
    @DBRef
    private ZoneModel zone;

    
   
}
