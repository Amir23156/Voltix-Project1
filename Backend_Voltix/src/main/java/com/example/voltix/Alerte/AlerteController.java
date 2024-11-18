package com.example.voltix.Alerte;

import com.example.voltix.CircuitBreakers.CircuitBreakerModel;
import com.example.voltix.CircuitBreakers.CircuitBreakerRepository;
import com.example.voltix.CircuitBreakers.CircuitBreakerService;
import com.example.voltix.Zones.ZoneModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;
import org.springframework.messaging.simp.SimpMessagingTemplate;

@RestController
@RequestMapping("/api/Alerte")
public class AlerteController {
    @Autowired

    private final AlerteService alerteService;
    @Autowired
    private SimpMessagingTemplate messagingTemplate;

    @Autowired
    public AlerteController(AlerteService alerteService, SimpMessagingTemplate messagingTemplate) {

        this.alerteService = alerteService;
        this.messagingTemplate = messagingTemplate;

    }

   

    @GetMapping
    public List<AlerteModel> getAllAlerte() {
        return alerteService.findAll();
    }

    @GetMapping("/allWithTotal")
    public List<AlerteWithCauseAndTotal> getAllAlerteWithTotal() {
        return alerteService.getAlertesWithCauseAndTotal();
    }

    @GetMapping("/unviewed-count")
    public long getUnviewedNotificationCount() {
        messagingTemplate.convertAndSend("/topic/new-Alerte", "New student created");

        return alerteService.getUnviewedNotificationCount();
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getMachineById(@PathVariable String id) {
        AlerteModel alerte = alerteService.findById(id);
        if (alerte != null) {
            return ResponseEntity.ok(alerte);
        } else {
            String errorMessage = "Alerte with id '" + id + "' not found.";
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(errorMessage);
        }
    }

    @PostMapping
    public ResponseEntity<AlerteModel> createMachine(@RequestBody AlerteModel alerte) {
        AlerteModel createdUser = alerteService.CreateAlerte(alerte);

        return ResponseEntity.ok().build();
    }

    @PostMapping("/{id}")
    public ResponseEntity<Void> updateMachine(@PathVariable String id, @RequestBody AlerteModel alerte) {

        AlerteModel existingMachine = alerteService.findById(alerte.getId());

        if (existingMachine != null) {

            alerte.setId(alerte.getId());
            alerteService.updatMachine(alerte);

            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping("/UpdateListe")
    public ResponseEntity<Void> updateMachineListe(@RequestBody List<AlerteWithCauseAndTotal> alerts) {

        List<AlerteModel> alerteList = alerts.stream()
                .map(AlerteWithCauseAndTotal::getAlerte)
                .collect(Collectors.toList());
        alerteService.markAlertsAsViewed(alerteList);
        return ResponseEntity.ok().build();

    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteMachine(@PathVariable String id) {
        alerteService.deleteMachineById(id);
        return ResponseEntity.noContent().build();
    }
}