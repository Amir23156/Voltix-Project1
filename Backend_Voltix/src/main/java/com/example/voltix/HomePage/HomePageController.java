package com.example.voltix.HomePage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.example.voltix.Machine.MachineService;

@RestController
@RequestMapping("/api/homePage")
public class HomePageController {
    @Autowired

    private final HomeService homeService;

    @Autowired
    public HomePageController(MachineService machineService, HomeService homeService) {

        this.homeService = homeService;
    }

    @GetMapping("/findData")

    public ResponseEntity<HomePageData> getMosteConsumedZone() {
      
        HomePageData homePageData = homeService.getHomeData();


        return ResponseEntity.ok(homePageData);

    }

}
