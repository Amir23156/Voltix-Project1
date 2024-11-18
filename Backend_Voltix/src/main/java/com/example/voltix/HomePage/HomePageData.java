package com.example.voltix.HomePage;

import com.example.voltix.Zones.ZoneModel;

import lombok.Data;

@Data
public class HomePageData {
    private ZoneModel mostConsumedZone;
    private double mostConsumedZoneConsumption;
    private double averageConsumption;
    private double TotaleConsumption;
}
