package com.example.voltix.Buildings;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/building")

public class BuildingController {
    @Autowired

    private BuildingService buildingService;

    @GetMapping("/getBuildingsForSite/{id}")

    public ResponseEntity<List<BuildingModel>> getBuildingsForSite(@PathVariable String id) {
        List<BuildingModel> buildings = buildingService.getBuildingsBySite(id);
        return ResponseEntity.ok(buildings);
    }

    @PostMapping("/AddBuilding")
    public ResponseEntity<BuildingModel> addBuilding(@RequestBody BuildingModel building) {
        return new ResponseEntity<BuildingModel>(buildingService.addBuilding(building), HttpStatus.ACCEPTED);
    }

    @GetMapping("/FindAllBuildings")
    public ResponseEntity<List<BuildingModel>> findAll() {
        return new ResponseEntity<List<BuildingModel>>(buildingService.findAll(), HttpStatus.ACCEPTED);
    }

    @GetMapping("/FindBuildingByName/{buildingName}")
    public ResponseEntity<?> findBuildingByName(@PathVariable String buildingName) {
        BuildingModel building = buildingService.findBuildingByName(buildingName);
        if (building != null) {
            return ResponseEntity.ok(building);
        } else {
            String errorMessage = "building with name '" + buildingName + "' not found.";
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(errorMessage);
        }
    }

    @DeleteMapping("/DeleteBuilding/{id}")
    public ResponseEntity<String> deleteById(@PathVariable String id) {
        buildingService.deleteBuildingById(id);
        return new ResponseEntity<>("building with ID " + id + " deleted", HttpStatus.OK);
    }

    @PutMapping("/UpdateBuilding/{id}")
    public ResponseEntity<BuildingModel> updateBuilding(@PathVariable String id,
            @RequestBody BuildingModel updatedBuilding) {
        BuildingModel existingBuilding = buildingService.findBuildingById(id);
        if (existingBuilding != null) {
            // Effectuer ici les mises à jour nécessaires sur l'objet existingBuilding en
            // utilisant les setters appropriés de la classe BuildingModel
            existingBuilding.setBuildingName(updatedBuilding.getBuildingName());
            existingBuilding.setBuildingLocation(updatedBuilding.getBuildingLocation());

            // Ajouter d'autres mises à jour pour les autres propriétés de BuildingModel si
            // nécessaire

            BuildingModel savedBuilding = buildingService.addBuilding(existingBuilding);
            return new ResponseEntity<>(savedBuilding, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
}
