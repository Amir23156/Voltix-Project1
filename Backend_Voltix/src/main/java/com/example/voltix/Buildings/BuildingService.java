package com.example.voltix.Buildings;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.voltix.Zones.ZoneService;

@Service
public class BuildingService {

    @Autowired
    private BuildingRepository buildingRepository;
    @Autowired
    private ZoneService zoneService;

    public BuildingModel addBuilding(BuildingModel building) {
        return buildingRepository.save(building);
    }

    public List<BuildingModel> findAll() {
        return buildingRepository.findAll();
    }

    public BuildingModel findBuildingByName(String buildingName) {
        return buildingRepository.findByBuildingName(buildingName);
    }

    public void deleteBuildingById(String id) {
        Optional<BuildingModel> buildingOptional = buildingRepository.findById(id);
        if (buildingOptional.isPresent()) {
            BuildingModel building = buildingOptional.get();
            buildingRepository.delete(building);
                    zoneService.deleteZones(id);

        } else {
            // Handle the case when the building with the specified ID does not exist.
            // You can throw an exception, log a message, or take any other appropriate
            // action.
        }
    }

    public void deleteBuildings(String id) {
        List<BuildingModel> liste = buildingRepository.findBySite_Id(id);
        buildingRepository.deleteAll(liste);
        zoneService.deleteZones(id);
    }

    public BuildingModel findBuildingById(String buildingId) {
        return buildingRepository.findById(buildingId).orElse(null);
    }

    public List<BuildingModel> getBuildingsBySite(String id) {

        return buildingRepository.findBySite_Id(id);
    }

}