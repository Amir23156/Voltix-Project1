package com.example.voltix.EnergyStats;
import org.springframework.data.mongodb.repository.MongoRepository;
import java.util.List;

public interface EnergyStatsRepository extends MongoRepository<EnergyStatsModel, String> {
    public java.util.Optional<EnergyStatsModel> findById(String id);
    List<EnergyStatsModel> findByZone_Id(String circuitBreakerId);
}
