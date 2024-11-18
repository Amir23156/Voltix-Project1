package com.example.voltix.Daily;
import org.springframework.data.mongodb.repository.MongoRepository;
import java.util.List;

public interface DailyRepository extends MongoRepository<DailyModel, String> {
    public java.util.Optional<DailyModel> findById(String id);
    List<DailyModel> findByZone_Id(String circuitBreakerId);
}
