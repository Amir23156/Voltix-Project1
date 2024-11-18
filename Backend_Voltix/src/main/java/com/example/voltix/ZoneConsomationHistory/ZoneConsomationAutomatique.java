package com.example.voltix.ZoneConsomationHistory;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.example.voltix.CircuitBreakers.CircuitBreakerModel;
import com.example.voltix.CircuitBreakers.CircuitBreakerRepository;
import com.example.voltix.Machine.MachineModel;
import com.example.voltix.Machine.MachineRepository;
import com.example.voltix.Zones.ZoneModel;
import com.example.voltix.Zones.ZoneRepository;

@Service
public class ZoneConsomationAutomatique {

    @Autowired
    private MachineRepository machineRepository;
    @Autowired
    private ZoneRepository zoneRepository;
    @Autowired
    private ZoneConsomationRepository zoneConsomationRepository;

    // Inject your machine repository
    @Autowired
    private CircuitBreakerRepository circuitBreakerRepository; // Inject your circuit breaker repository

    @Scheduled(cron = "@hourly") // Déclencher tous les jours à minuit (00:00 AM)
    public void monitorConsumptionAndCreateAlerts() {
        List<ZoneModel> zones = zoneRepository.findAll();
        for (ZoneModel zone : zones) {

            double totalConsumption = calculateTotalConsumption(zone);

            // Create an alert
            ZoneConsomationModel zoneConsomation = new ZoneConsomationModel();
            zoneConsomation.setConsomation(totalConsumption);
            Date same = new Date();

            // Create a Calendar instance and set it to the given Date
            

            zoneConsomation.setDate(same);
            zoneConsomation.setZone(zone);

            zoneConsomationRepository.save(zoneConsomation);

        }
    }

    private double calculateTotalConsumption(ZoneModel zone) {
        double totalConsumption = 0.0;

        List<CircuitBreakerModel> circuitBrekers = circuitBreakerRepository.findByZone_Id(zone.getId());

        for (CircuitBreakerModel circuitBreaker : circuitBrekers) {
            List<MachineModel> machines = machineRepository.findByCircuitBreaker_Id(circuitBreaker.getId());
            for (MachineModel machine : machines) {

                totalConsumption += machine.getConsomation();
            }
        }
        List<ZoneConsomationModel> zoneConsomation = zoneConsomationRepository.findByZoneIdOrderByDateAsc(zone.getId());
        double totalConsumpt = zoneConsomation.stream()
                .mapToDouble(ZoneConsomationModel::getConsomation)
                .sum();
        return totalConsumption - totalConsumpt;

    }
}
