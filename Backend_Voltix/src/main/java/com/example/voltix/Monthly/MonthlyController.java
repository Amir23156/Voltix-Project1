package com.example.voltix.Monthly;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController

public class MonthlyController {

    private final MonthlyService monthlyService;

    @Autowired
    public MonthlyController(MonthlyService monthlyService) {
        this.monthlyService = monthlyService;
    }

    @PostMapping("/AddMonthly")
    public ResponseEntity<MonthlyModel> addMonthly(@RequestBody MonthlyModel monthly) {

        return new ResponseEntity<MonthlyModel>(monthlyService.addMonthly(monthly), HttpStatus.ACCEPTED);
    }
    
      @GetMapping("/FindAllMonthlys")
      public ResponseEntity<List<MonthlyModel>> findAll() {
      return new ResponseEntity<List<MonthlyModel>>(monthlyService.findAll(),
      HttpStatus.ACCEPTED);
      }
     
    @GetMapping("/FindMonthlyForZone/{zoneId}")
    public ResponseEntity<List<MonthlyModel>> findAllMonthlysForZone(@PathVariable String zoneId) {
        List<MonthlyModel> monthlys = monthlyService.getMonthlysByZones(zoneId);
        return new ResponseEntity<>(monthlys, HttpStatus.ACCEPTED);
    }


   
}
