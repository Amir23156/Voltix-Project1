package com.example.voltix.Alerte;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.voltix.CircuitBreakers.CircuitBreakerModel;
import com.example.voltix.CircuitBreakers.CircuitBreakerRepository;
import com.example.voltix.Machine.MachineModel;
import com.example.voltix.Machine.MachineRepository;

@Service
public class AlerteService {
    @Autowired

    private final AlerteRepository alerteRepository;
    @Autowired

    private final com.example.voltix.Machine.MachineRepository machineRepository;
    @Autowired

    private final CircuitBreakerRepository circuitBreakerRepository;

    @Autowired
    public AlerteService(MachineRepository machineRepository, AlerteRepository alerteRepository,
            CircuitBreakerRepository circuitBreakerRepository) {
        this.alerteRepository = alerteRepository;
        this.circuitBreakerRepository = circuitBreakerRepository;
        this.machineRepository = machineRepository;
    }

    public AlerteModel CreateAlerte(AlerteModel alerte) {

        return alerteRepository.save(alerte);
    }

    public List<AlerteModel> findAll() {
        return alerteRepository.findAll();
    }

    public void deleteAlertes(String id) {
        List<AlerteModel> alerts = alerteRepository.findByCause_Id(id);
        alerteRepository.deleteAll(alerts);
    }

    public List<AlerteModel> findByViewedAndCause_Id(boolean viewed, String causeId) {
        return alerteRepository.findByViewedAndCause_Id(false, causeId);
    }

   
    public void deleteMachineById(String id) {
        alerteRepository.deleteById(id);
    }

    public long getUnviewedNotificationCount() {
        return alerteRepository.countByViewedFalse();
    }

    public void markAlertsAsViewed(List<AlerteModel> alertes) {

        for (AlerteModel alerte : alertes) {
            alerte.setViewed(true);
        }
        alerteRepository.saveAll(alertes);
    }

    public void updatMachine(AlerteModel user) {
        alerteRepository.save(user);
    }

    public AlerteModel findById(String id) {

        return alerteRepository.findById(id).orElse(null);
    }

    public List<AlerteWithCauseAndTotal> getAlertesWithCauseAndTotal() {
        List<AlerteModel> alertes = alerteRepository.findAll(); // Fetch all alerts

        // Reverse the order of the alertes list using Collections.reverse
        Collections.reverse(alertes);

        // Create a list to hold the results
        List<AlerteWithCauseAndTotal> result = new ArrayList<>();

        for (AlerteModel alerte : alertes) {
            // Get the cause circuit breaker for each alert

            CircuitBreakerModel cause = alerte.getCause();

            // Calculate the total consumption for the cause circuit breaker

            double totalConsumption = calculateTotalConsumption(cause);

            // Create a new object that holds alert info along with cause and total
            // consumption
            AlerteWithCauseAndTotal alerteWithCauseAndTotal = new AlerteWithCauseAndTotal(alerte, cause,
                    totalConsumption);

            // Add to the result list
            result.add(alerteWithCauseAndTotal);
        }

        return result;
    }

    private double calculateTotalConsumption(CircuitBreakerModel circuitBreaker) {
        double totalConsumption = 0.0;

        List<MachineModel> machines = machineRepository.findByCircuitBreaker_Id(circuitBreaker.getId());

        for (MachineModel machine : machines) {

            totalConsumption += machine.getConsomation();
        }

        return totalConsumption;
    }

}