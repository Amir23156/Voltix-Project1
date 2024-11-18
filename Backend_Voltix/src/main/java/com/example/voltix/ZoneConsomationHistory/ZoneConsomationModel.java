package com.example.voltix.ZoneConsomationHistory;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;
import lombok.Data;
import com.example.voltix.Zones.ZoneModel;

@Data
@Document(collection = "ZoneConsomation")
public class ZoneConsomationModel {
    @Id
    private String id;
    private double consomation;
    private Date date;
    @DBRef
    private ZoneModel zone;


}
