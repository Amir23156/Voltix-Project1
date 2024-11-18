package com.example.voltix.Zones;

import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.example.voltix.Annually.AnnuallyModel;
import com.example.voltix.Annually.AnnuallyService;
import com.example.voltix.Daily.DailyModel;
import com.example.voltix.Daily.DailyService;
import com.example.voltix.EnergyStats.EnergyStatsModel;
import com.example.voltix.EnergyStats.EnergyStatsService;
import com.example.voltix.Monthly.MonthlyModel;
import com.example.voltix.Monthly.MonthlyService;
import com.example.voltix.Weekly.WeeklyModel;
import com.example.voltix.Weekly.WeeklyService;

@RestController
@RequestMapping("/api/zone")
public class ZoneController {

    @Autowired
    private ZoneService zoneService;
    @Autowired
    private DailyService dailyService;
    @Autowired
    private EnergyStatsService energyStatsService;
    @Autowired
    private WeeklyService weeklyService;
    @Autowired
    private MonthlyService monthlyService;
    @Autowired
    private AnnuallyService annuallyService;

    @PostMapping("/AddZone")
    public ResponseEntity<ZoneModel> addZone(@RequestBody ZoneModel zone) {
        ZoneModel addedZone = zoneService.addZone(zone);

        DailyModel daily = new DailyModel();
        daily.setZone(addedZone);
        dailyService.addDaily(daily);

        WeeklyModel weekly = new WeeklyModel();
        weekly.setZone(addedZone);
        weeklyService.addWeekly(weekly);

        MonthlyModel monthly = new MonthlyModel();
        monthly.setZone(addedZone);
        monthlyService.addMonthly(monthly);

        AnnuallyModel annually = new AnnuallyModel();
        annually.setZone(addedZone);
        annuallyService.addAnnually(annually);

        EnergyStatsModel energyStats = new EnergyStatsModel();
        energyStats.setZone(addedZone);

        Random random = new Random();
        energyStats.setDailyConsumption(roundToTwoDecimals(1 + random.nextDouble() * 99)); // Set random values for
                                                                                           // consumption
        energyStats.setMonthlyConsumption(roundToTwoDecimals(1 + random.nextDouble() * 99));
        energyStats.setAnnualConsumption(roundToTwoDecimals(1 + random.nextDouble() * 99));

        energyStatsService.addEnergyStats(energyStats);

        return new ResponseEntity<>(addedZone, HttpStatus.ACCEPTED);
    }

    // Method to round a double to two decimal places
    private double roundToTwoDecimals(double value) {
        return Math.round(value * 100.0) / 100.0;
    }

    @GetMapping("/getZonesForBuilding/{id}")

    public ResponseEntity<List<ZoneModel>> getZonesForBuilding(@PathVariable String id) {
       
        // CircuitBreakerModel
        // circuitBreaker=circuitBreakerService.findCircuitBreakerById(id);
        List<ZoneModel> zones = zoneService.getZonesByBuildings(id);

        // List<MachineModel> students =
        // machineService.getMachineofCircuitBreaker(circuitBreaker);
      

        return ResponseEntity.ok(zones);

    }

    @GetMapping("/FindAllZones")
    public ResponseEntity<List<ZoneModel>> findAll() {
        return new ResponseEntity<List<ZoneModel>>(zoneService.findAll(),
                HttpStatus.ACCEPTED);
    }

    @GetMapping("/FindAllZonesForBuilding/{buildingId}")
    public ResponseEntity<List<ZoneModel>> findAllZonesForBuilding(@PathVariable String buildingId) {
        List<ZoneModel> zones = zoneService.getZonesByBuildings(buildingId);
        return new ResponseEntity<>(zones, HttpStatus.ACCEPTED);
    }

    @GetMapping("/FindZoneByName/{zoneName}")
    public ResponseEntity<?> findZoneByName(@PathVariable String zoneName) {
        ZoneModel zone = zoneService.findZoneByName(zoneName);
        if (zone != null) {
            return ResponseEntity.ok(zone);
        } else {
            String errorMessage = "Zone with name '" + zoneName + "' not found.";
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(errorMessage);
        }
    }

    @DeleteMapping("/DeleteZone/{id}")
    public ResponseEntity<String> deleteById(@PathVariable String id) {
        zoneService.deleteZoneById(id);
        return new ResponseEntity<>("Zone with ID " + id + " deleted", HttpStatus.OK);
    }

    @PutMapping("/UpdateZone/{id}")
    public ResponseEntity<ZoneModel> updateZone(@PathVariable String id, @RequestBody ZoneModel updatedZone) {
        ZoneModel existingZone = zoneService.findZoneById(id);
        if (existingZone != null) {
            // Effectuer ici les mises à jour nécessaires sur l'objet existingZone en
            // utilisant les setters appropriés de la classe ZoneModel
            existingZone.setZoneName(updatedZone.getZoneName());
            existingZone.setZoneSurface(updatedZone.getZoneSurface());
            existingZone.setZoneMainActivity(updatedZone.getZoneMainActivity());
            existingZone.setAttendanceDays(updatedZone.getAttendanceDays());
            existingZone.setWorkStartTime(updatedZone.getWorkStartTime());
            existingZone.setWorkEndTime(updatedZone.getWorkEndTime());
            // Ajouter d'autres mises à jour pour les autres propriétés de ZoneModel si
            // nécessaire

            ZoneModel savedZone = zoneService.addZone(existingZone);
            return new ResponseEntity<>(savedZone, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
}
