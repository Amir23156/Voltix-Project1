package com.example.voltix.Machine;

import com.example.voltix.CircuitBreakers.CircuitBreakerModel;
import com.example.voltix.CircuitBreakers.CircuitBreakerRepository;
import com.example.voltix.CircuitBreakers.CircuitBreakerService;
import com.example.voltix.Zones.ZoneModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/machine")
public class MachineController {
    @Autowired
    private CircuitBreakerRepository circuitBreakerRepository;

    private final MachineService machineService;
    private final CircuitBreakerService circuitBreakerService;

    @Autowired
    public MachineController(MachineService machineService, CircuitBreakerService circuitBreakerService,
            CircuitBreakerRepository circuitBreakerRepository) {

        this.machineService = machineService;
        this.circuitBreakerService = circuitBreakerService;
        this.circuitBreakerRepository = circuitBreakerRepository;
    }

    @GetMapping("/getMachinesForCircuitBreaker/{id}")

    public ResponseEntity<List<MachineModel>> getMachinesByCircuitBreaker(@PathVariable String id) {
     
        // CircuitBreakerModel
        // circuitBreaker=circuitBreakerService.findCircuitBreakerById(id);
        List<MachineModel> machines = machineService.getMachinesByCircuitBreaker(id);

        // List<MachineModel> students =
        // machineService.getMachineofCircuitBreaker(circuitBreaker);
      

        return ResponseEntity.ok(machines);

    }

    @GetMapping
    public List<MachineModel> getAllMachine() {
        return machineService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getMachineById(@PathVariable String id) {
        MachineModel machine = machineService.findById(id);
        if (machine != null) {
            return ResponseEntity.ok(machine);
        } else {
            String errorMessage = "machine with id '" + id + "' not found.";
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(errorMessage);
        }
    }

    @PostMapping
    public ResponseEntity<MachineModel> createMachine(@RequestBody MachineModel machine) {
        MachineModel createdUser = machineService.CreateMachine(machine);

        return ResponseEntity.ok().build();
    }

    @GetMapping("/totalConsumption")
    public double getTotalConsumption() {

        List<MachineModel> machines = machineService.findAll();
        double totalConsumption = machines.stream()
                .mapToDouble(MachineModel::getConsomation)
                .sum();
        return totalConsumption;
    }

    @PostMapping("/{id}")
    public ResponseEntity<Void> updateMachine(@PathVariable String id, @RequestBody MachineModel machine) {

        MachineModel existingMachine = machineService.findById(machine.getId());

        if (existingMachine != null) {
          

            machine.setId(machine.getId());
            machineService.updatMachine(machine);
            
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteMachine(@PathVariable String id) {
        machineService.deleteMachineById(id);
        return ResponseEntity.noContent().build();
    }
}
