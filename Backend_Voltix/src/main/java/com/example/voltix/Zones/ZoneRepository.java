package com.example.voltix.Zones;

import org.springframework.data.mongodb.repository.MongoRepository;
import java.util.List;

public interface ZoneRepository extends MongoRepository<ZoneModel, String> {
    public java.util.Optional<ZoneModel> findById(String id);

    ZoneModel findByZoneName(String zoneName);

    List<ZoneModel> findByBuilding_Id(String circuitBreakerId);
}
