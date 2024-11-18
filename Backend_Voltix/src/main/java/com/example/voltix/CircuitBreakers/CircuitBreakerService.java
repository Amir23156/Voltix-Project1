package com.example.voltix.CircuitBreakers;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;

import com.example.voltix.Alerte.AlerteService;
import com.example.voltix.Buildings.BuildingModel;
import com.example.voltix.Machine.MachineModel;
import com.example.voltix.Machine.MachineService;

@Service
public class CircuitBreakerService {
    @Autowired
    private CircuitBreakerRepository circuitBreakerRepository;
    @Autowired
    private MachineService machineService;

    @Autowired
    private AlerteService alerteService;

    public CircuitBreakerModel addCircuitBreaker(CircuitBreakerModel circuitbreaker) {
        return circuitBreakerRepository.save(circuitbreaker);
    }

    public List<CircuitBreakerModel> findAll() {
        return circuitBreakerRepository.findAll();
    }

    public List<CircuitBreakerModel> getCircuitBreakersByZone(String id) {

        return circuitBreakerRepository.findByZone_Id(id);
    }

    public CircuitBreakerModel findCircuitBreakerByName(String circuitBreakerName) {
        return circuitBreakerRepository.findByCircuitBreakerName(circuitBreakerName);
    }

    public void deleteCircuitBreakerById(String id) {
        Optional<CircuitBreakerModel> circuitBreakerOptional = circuitBreakerRepository.findById(id);
        if (circuitBreakerOptional.isPresent()) {
            CircuitBreakerModel circuitBreaker = circuitBreakerOptional.get();
            circuitBreakerRepository.delete(circuitBreaker);
            machineService.deleteMachines(id);
            alerteService.deleteAlertes(id);
        } else {
            // Handle the case when the zone with the specified ID does not exist.
            // You can throw an exception, log a message, or take any other appropriate
            // action.
        }
    }

    public void deleteCircuitBreakers(String id) {
        List<CircuitBreakerModel> circuitBreakerOptional = circuitBreakerRepository.findByZone_Id(id);
        // if (circuitBreakerOptional.isPresent()) {
        // CircuitBreakerModel circuitBreaker = circuitBreakerOptional.get();
        circuitBreakerRepository.deleteAll(circuitBreakerOptional);
        machineService.deleteMachines(id);
        alerteService.deleteAlertes(id);
        // } else {
        // Handle the case when the zone with the specified ID does not exist.
        // You can throw an exception, log a message, or take any other appropriate
        // action.

    }

    public CircuitBreakerModel updateCircuitBreaker(String id, CircuitBreakerModel updatedcircuitBreaker) {
        CircuitBreakerModel result = new CircuitBreakerModel();
        try {
          
            result = circuitBreakerRepository.save(updatedcircuitBreaker);
        
        } catch (StackOverflowError e) {
       
        }
        return result;
    }

    public CircuitBreakerModel findCircuitBreakerById(String Id) {
        return circuitBreakerRepository.findById(Id).orElse(null);
    }

}
