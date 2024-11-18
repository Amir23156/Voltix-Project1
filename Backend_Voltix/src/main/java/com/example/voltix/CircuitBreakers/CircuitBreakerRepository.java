package com.example.voltix.CircuitBreakers;

import java.util.List;

import org.springframework.data.mongodb.repository.MongoRepository;

public interface CircuitBreakerRepository extends MongoRepository<CircuitBreakerModel, String> {
    public java.util.Optional<CircuitBreakerModel> findById(String id);

    List<CircuitBreakerModel> findByZone_Id(String circuitBreakerId);

    CircuitBreakerModel findByCircuitBreakerName(String circuitBreakerName);
}
