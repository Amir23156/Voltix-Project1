package com.example.voltix.Zones;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.voltix.Buildings.BuildingModel;
import com.example.voltix.CircuitBreakers.CircuitBreakerService;

@Service
public class ZoneService {

    @Autowired
    private ZoneRepository zoneRepository;
    @Autowired
    private CircuitBreakerService circuitBreakerService;

    public ZoneModel addZone(ZoneModel zone) {
        return zoneRepository.save(zone);
    }

    public List<ZoneModel> findAll() {
        return zoneRepository.findAll();
    }

    public ZoneModel findZoneByName(String zoneName) {
        return zoneRepository.findByZoneName(zoneName);
    }

    public List<ZoneModel> getZonesByBuildings(String id) {
     
        return zoneRepository.findByBuilding_Id(id);
    }

    public void deleteZoneById(String id) {
        Optional<ZoneModel> zoneOptional = zoneRepository.findById(id);
        if (zoneOptional.isPresent()) {
            ZoneModel zone = zoneOptional.get();
            zoneRepository.delete(zone);
            circuitBreakerService.deleteCircuitBreakers(id);

        } else {
            // Handle the case when the zone with the specified ID does not exist.
            // You can throw an exception, log a message, or take any other appropriate
            // action.
        }
    }

    public void deleteZones(String id) {
        List<ZoneModel> zoneOptional = zoneRepository.findByBuilding_Id(id);
        // if (zoneOptional.isPresent()) {
        // ZoneModel zone = zoneOptional.get();
        zoneRepository.deleteAll(zoneOptional);
        circuitBreakerService.deleteCircuitBreakers(id);
        // } else {
        // Handle the case when the zone with the specified ID does not exist.
        // You can throw an exception, log a message, or take any other appropriate
        // action.
        // }
    }

    public ZoneModel findZoneById(String zoneId) {
        return zoneRepository.findById(zoneId).orElse(null);
    }

}