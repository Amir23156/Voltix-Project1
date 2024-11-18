package com.example.voltix.Annually;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/annually")

public class AnnuallyController {

    private final AnnuallyService annuallyService;

    @Autowired
    public AnnuallyController(AnnuallyService annuallyService) {
        this.annuallyService = annuallyService;
    }

    @PostMapping("/AddAnnually")
    public ResponseEntity<AnnuallyModel> addAnnually(@RequestBody AnnuallyModel annually) {

        return new ResponseEntity<AnnuallyModel>(annuallyService.addAnnually(annually), HttpStatus.ACCEPTED);
    }
    
      @GetMapping("/FindAllAnnuallys")
      public ResponseEntity<List<AnnuallyModel>> findAll() {
      return new ResponseEntity<List<AnnuallyModel>>(annuallyService.findAll(),
      HttpStatus.ACCEPTED);
      }
     
    @GetMapping("/FindAnnuallyForZone/{zoneId}")
    public ResponseEntity<List<AnnuallyModel>> findAllAnnuallysForZone(@PathVariable String zoneId) {
        List<AnnuallyModel> annuallys = annuallyService.getAnnuallysByZones(zoneId);
        return new ResponseEntity<>(annuallys, HttpStatus.ACCEPTED);
    }


   
}
