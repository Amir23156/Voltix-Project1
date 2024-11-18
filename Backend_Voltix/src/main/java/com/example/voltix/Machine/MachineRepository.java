package com.example.voltix.Machine;

import com.example.voltix.CircuitBreakers.CircuitBreakerModel;
import com.example.voltix.Zones.ZoneModel;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;

public interface MachineRepository extends MongoRepository<MachineModel,String> {
    List<MachineModel> findByCircuitBreaker_Id(String circuitBreakerId);

}
