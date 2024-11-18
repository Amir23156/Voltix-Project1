package com.example.voltix.Monthly;
import org.springframework.data.mongodb.repository.MongoRepository;
import java.util.List;

public interface MonthlyRepository extends MongoRepository<MonthlyModel, String> {
    public java.util.Optional<MonthlyModel> findById(String id);
    List<MonthlyModel> findByZone_Id(String circuitBreakerId);
}
