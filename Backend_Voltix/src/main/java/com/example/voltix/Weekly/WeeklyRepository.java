package com.example.voltix.Weekly;
import org.springframework.data.mongodb.repository.MongoRepository;
import java.util.List;

public interface WeeklyRepository extends MongoRepository<WeeklyModel, String> {
    public java.util.Optional<WeeklyModel> findById(String id);
    List<WeeklyModel> findByZone_Id(String circuitBreakerId);
}
