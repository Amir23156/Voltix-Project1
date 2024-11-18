package com.example.voltix.Alerte;

import java.util.List;

import org.springframework.data.mongodb.repository.MongoRepository;

import com.example.voltix.CircuitBreakers.CircuitBreakerModel;

public interface AlerteRepository extends MongoRepository<AlerteModel, String> {
    // List<AlerteModel> findByCircuitBreaker_Id(String circuitBreakerId);
    List<AlerteModel> findByViewedAndCause_Id(boolean viewed, String causeId);

    List<AlerteModel> findByCause_Id(String circuitBreakerId);

    long countByViewedFalse();

}
