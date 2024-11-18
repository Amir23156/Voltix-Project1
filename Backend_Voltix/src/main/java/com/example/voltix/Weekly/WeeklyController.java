package com.example.voltix.Weekly;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController

public class WeeklyController {

    private final WeeklyService weeklyService;

    @Autowired
    public WeeklyController(WeeklyService weeklyService) {
        this.weeklyService = weeklyService;
    }

    @PostMapping("/AddWeekly")
    public ResponseEntity<WeeklyModel> addWeekly(@RequestBody WeeklyModel weekly) {

        return new ResponseEntity<WeeklyModel>(weeklyService.addWeekly(weekly), HttpStatus.ACCEPTED);
    }
    
      @GetMapping("/FindAllWeeklys")
      public ResponseEntity<List<WeeklyModel>> findAll() {
      return new ResponseEntity<List<WeeklyModel>>(weeklyService.findAll(),
      HttpStatus.ACCEPTED);
      }
     
    @GetMapping("/FindWeeklyForZone/{zoneId}")
    public ResponseEntity<List<WeeklyModel>> findAllWeeklysForZone(@PathVariable String zoneId) {
        List<WeeklyModel> weeklys = weeklyService.getWeeklysByZones(zoneId);
        return new ResponseEntity<>(weeklys, HttpStatus.ACCEPTED);
    }


   
}
