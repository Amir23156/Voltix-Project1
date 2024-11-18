package com.example.voltix.EnergyStats;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/energyStat")

public class EnergyStatsController {

    private final EnergyStatsService energyStatsService;

    @Autowired
    public EnergyStatsController(EnergyStatsService energyStatsService) {
        this.energyStatsService = energyStatsService;
    }

    @PostMapping("/AddEnergyStats")
    public ResponseEntity<EnergyStatsModel> addEnergyStats(@RequestBody EnergyStatsModel energyStats) {

        return new ResponseEntity<EnergyStatsModel>(energyStatsService.addEnergyStats(energyStats), HttpStatus.ACCEPTED);
    }
    
      @GetMapping("/FindAllEnergyStatss")
      public ResponseEntity<List<EnergyStatsModel>> findAll() {
      return new ResponseEntity<List<EnergyStatsModel>>(energyStatsService.findAll(),
      HttpStatus.ACCEPTED);
      }
     
    @GetMapping("/FindAllEnergyStatssForZone/{zoneId}")
    public ResponseEntity<List<EnergyStatsModel>> findAllEnergyStatssForZone(@PathVariable String zoneId) {
        List<EnergyStatsModel> energyStatss = energyStatsService.getEnergyStatssByZones(zoneId);
        return new ResponseEntity<>(energyStatss, HttpStatus.ACCEPTED);
    }


   
}
