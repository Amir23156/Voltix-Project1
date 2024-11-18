package com.example.voltix.ZoneConsomationHistory;

import java.util.Date;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;
import lombok.Data;
import com.example.voltix.Zones.ZoneModel;

@Data
public class fetchDataModel {

    private Date dateDebut;

    private Date dateFin;

    private ZoneModel zone;
    private String type;

}
