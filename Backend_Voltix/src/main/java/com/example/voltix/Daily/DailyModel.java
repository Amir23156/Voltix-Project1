package com.example.voltix.Daily;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;
import com.example.voltix.Zones.ZoneModel;
import lombok.Data;

@Data
@Document(collection = "Daily")
public class DailyModel {
    @Id
    private String id;
    private List<String> hours = new ArrayList<>(); // Initialized hours list
    private List<Double> values = new ArrayList<>(); // List of double values
    @DBRef
    private ZoneModel zone;

        // Constructor
    public DailyModel() {
        hours.add("00h");
        hours.add("02h");
        hours.add("04h");
        hours.add("06h");
        hours.add("08h");
        hours.add("10h");
        hours.add("12h");
        hours.add("14h");
        hours.add("16h");
        hours.add("18h");
        hours.add("20h");
        hours.add("22h");

        Random random = new Random();
        for (int i = 0; i < 12; i++) {
            double randomValue = roundToTwoDecimals(1 + random.nextDouble() * 99); // Generate a random value between 0 and 100
            values.add(randomValue); // Add the value to the list
        }
        
    }
    
      // Method to round a double to two decimal places
      private double roundToTwoDecimals(double value) {
        return Math.round(value * 100.0) / 100.0;
    }
    
   
}
