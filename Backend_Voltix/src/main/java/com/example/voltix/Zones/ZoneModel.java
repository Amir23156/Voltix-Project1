package com.example.voltix.Zones;

import java.util.List;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;

import com.example.voltix.Buildings.BuildingModel;
import com.example.voltix.Sites.SiteModel;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data

@Document(collection = "zones")
public class ZoneModel {
    @Id
    private String id;
    private String zoneName;
    private String zoneSurface;
    private String zoneMainActivity;
    private List<String> attendanceDays;
    private String workStartTime;
    private double consomation;
    private String workEndTime;
    @DBRef
    private BuildingModel building;

}
