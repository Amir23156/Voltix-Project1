package com.example.voltix.HomePage;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.voltix.CircuitBreakers.CircuitBreakerRepository;
import com.example.voltix.Machine.MachineModel;
import com.example.voltix.Machine.MachineRepository;
import com.example.voltix.ZoneConsomationHistory.ZoneConsomationModel;
import com.example.voltix.ZoneConsomationHistory.ZoneConsomationRepository;
import com.example.voltix.Zones.ZoneModel;
import com.example.voltix.Zones.ZoneRepository;
import com.example.voltix.Zones.ZoneService;

@Service
public class HomeService {
    @Autowired
    private final ZoneConsomationRepository zoneConsomationRepository;
    @Autowired
    private final MachineRepository machineRepository;
    @Autowired
    private final ZoneService zoneService;

    @Autowired
    public HomeService(MachineRepository machineRepository,
            ZoneRepository zoneRepository,
            ZoneConsomationRepository zoneConsomationRepository, ZoneService zoneService) {
        this.zoneConsomationRepository = zoneConsomationRepository;
        this.zoneService = zoneService;
        this.machineRepository = machineRepository;
    }

    public HomePageData getHomeData() {
        try {
            HomePageData homePageData = new HomePageData();
            List<ZoneModel> zoneListe = zoneService.findAll();
            ZoneModel MostsZoneConsumed = zoneListe.get(0);
            double Consumption = 0;
            for (ZoneModel zoneModel : zoneListe) {
                List<ZoneConsomationModel> zoneConsomation = zoneConsomationRepository
                        .findByZoneIdOrderByDateAsc(zoneModel.getId());
                double totalConsumpt = zoneConsomation.stream()
                        .mapToDouble(ZoneConsomationModel::getConsomation)
                        .sum();
                if (totalConsumpt > Consumption) {
                    MostsZoneConsumed = zoneModel;
                    Consumption = totalConsumpt;
                }

            }
            homePageData.setMostConsumedZoneConsumption(Consumption);
            homePageData.setMostConsumedZone(MostsZoneConsumed);

            List<MachineModel> machines = machineRepository.findAll();
            double totalConsumption = 0.0;
            for (MachineModel machine : machines) {
                totalConsumption += machine.getConsomation();
            }

            // Check if there are machines to avoid division by zero.
            if (machines.isEmpty()) {
                homePageData.setAverageConsumption(0);
            } else {
                homePageData.setAverageConsumption(totalConsumption / machines.size());
            }
            double total = machines.stream()
                    .mapToDouble(MachineModel::getConsomation)
                    .sum();
            homePageData.setTotaleConsumption(total);
            return homePageData;
        } catch (Exception e) {
        
            return null;
        }
    }
}
