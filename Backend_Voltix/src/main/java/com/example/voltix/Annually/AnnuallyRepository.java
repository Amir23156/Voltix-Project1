package com.example.voltix.Annually;
import org.springframework.data.mongodb.repository.MongoRepository;
import java.util.List;

public interface AnnuallyRepository extends MongoRepository<AnnuallyModel, String> {
    public java.util.Optional<AnnuallyModel> findById(String id);
    List<AnnuallyModel> findByZone_Id(String circuitBreakerId);
}
