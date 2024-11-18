package com.example.voltix.CircuitBreakers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.voltix.Buildings.BuildingModel;
import com.example.voltix.Machine.MachineModel;

@RestController
@RequestMapping("/api/cuircuitBreaker")

public class CircuitBreakerController {
    @Autowired
    private CircuitBreakerService circuitBreakerService;

    @GetMapping("/getCircuitBreakerForZone/{id}")

    public ResponseEntity<List<CircuitBreakerModel>> getCircuitBreakerForZone(@PathVariable String id) {
        List<CircuitBreakerModel> circuitBreaker = circuitBreakerService.getCircuitBreakersByZone(id);
        return ResponseEntity.ok(circuitBreaker);
    }

    @PostMapping("/AddCircuitBreaker")

    public ResponseEntity<CircuitBreakerModel> addCircuitBreaker(@RequestBody CircuitBreakerModel circuitBreaker) {
        circuitBreaker.setLimitConsomation(0);

        return new ResponseEntity<CircuitBreakerModel>(circuitBreakerService.addCircuitBreaker(circuitBreaker),
                HttpStatus.ACCEPTED);
    }

    @GetMapping("/FindAllCircuitBreaker")
    public ResponseEntity<List<CircuitBreakerModel>> findAll() {
        return new ResponseEntity<List<CircuitBreakerModel>>(circuitBreakerService.findAll(), HttpStatus.ACCEPTED);
    }

    @GetMapping("/FindCircuitBreakerByName/{CircuitBreakerName}")
    public ResponseEntity<?> findCircuitBreakerByName(@PathVariable String circuitBreakerName) {
        CircuitBreakerModel circuitBreaker = circuitBreakerService.findCircuitBreakerByName(circuitBreakerName);
        if (circuitBreaker != null) {
            return ResponseEntity.ok(circuitBreaker);
        } else {
            String errorMessage = "CircuitBreaker with name '" + circuitBreakerName + "' not found.";
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(errorMessage);
        }
    }

    @DeleteMapping("/DeleteCircuitBreaker/{id}")
    public ResponseEntity<String> deleteById(@PathVariable String id) {
        circuitBreakerService.deleteCircuitBreakerById(id);
        return new ResponseEntity<>("Zone with ID " + id + " deleted", HttpStatus.OK);
    }

    @PutMapping("/UpdateCircuitBreaker/{id}")
    public ResponseEntity<CircuitBreakerModel> updateCircuitBreaker(@PathVariable String id,
            @RequestBody CircuitBreakerModel updatedcircuitBreaker) {
        CircuitBreakerModel existingcircuitBreaker = circuitBreakerService.findCircuitBreakerById(id);
        if (existingcircuitBreaker != null) {
            // Effectuer ici les mises à jour nécessaires sur l'objet existingZone en
            // utilisant les setters appropriés de la classe ZoneModel
            existingcircuitBreaker.setCircuitBreakerName(updatedcircuitBreaker.getCircuitBreakerName());
            existingcircuitBreaker.setCircuitBreakerRefrence(updatedcircuitBreaker.getCircuitBreakerRefrence());

            existingcircuitBreaker.setLimitConsomation(updatedcircuitBreaker.getLimitConsomation());
            // Ajouter d'autres mises à jour pour les autres propriétés de ZoneModel si
            // nécessaire

            CircuitBreakerModel savedcircuitBreaker = circuitBreakerService.addCircuitBreaker(existingcircuitBreaker);
            return new ResponseEntity<>(savedcircuitBreaker, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @PostMapping("/Updatelimit/{id}")
    public ResponseEntity<CircuitBreakerModel> updateCircuitBreakerLimit(@PathVariable String id,
            @RequestBody CircuitBreakerModel updatedcircuitBreaker) {
       
        CircuitBreakerModel existingcircuitBreaker = circuitBreakerService.findCircuitBreakerById(id);
        if (existingcircuitBreaker != null) {
            // Effectuer ici les mises à jour nécessaires sur l'objet existingZone en
            // utilisant les setters appropriés de la classe ZoneModel

            existingcircuitBreaker.setLimitConsomation(updatedcircuitBreaker.getLimitConsomation());
            // Ajouter d'autres mises à jour pour les autres propriétés de ZoneModel si
            // nécessaire
          
            CircuitBreakerModel savedcircuitBreaker = circuitBreakerService.addCircuitBreaker(existingcircuitBreaker);
            return new ResponseEntity<>(savedcircuitBreaker, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    // hhhhhhhhh

}