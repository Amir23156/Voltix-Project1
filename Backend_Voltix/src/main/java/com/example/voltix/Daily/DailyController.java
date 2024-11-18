package com.example.voltix.Daily;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/daily")

public class DailyController {

    private final DailyService dailyService;

    @Autowired
    public DailyController(DailyService dailyService) {
        this.dailyService = dailyService;
    }

    @PostMapping("/AddDaily")
    public ResponseEntity<DailyModel> addDaily(@RequestBody DailyModel daily) {

        return new ResponseEntity<DailyModel>(dailyService.addDaily(daily), HttpStatus.ACCEPTED);
    }
    
      @GetMapping("/FindAllDailys")
      public ResponseEntity<List<DailyModel>> findAll() {
      return new ResponseEntity<List<DailyModel>>(dailyService.findAll(),
      HttpStatus.ACCEPTED);
      }
     
    @GetMapping("/FindDailyForZone/{zoneId}")
    public ResponseEntity<List<DailyModel>> findAllDailysForZone(@PathVariable String zoneId) {
        List<DailyModel> dailys = dailyService.getDailysByZones(zoneId);
        return new ResponseEntity<>(dailys, HttpStatus.ACCEPTED);
    }


   
}
