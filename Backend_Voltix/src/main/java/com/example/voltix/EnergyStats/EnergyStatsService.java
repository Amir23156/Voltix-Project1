package com.example.voltix.EnergyStats;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class EnergyStatsService {

    @Autowired
    private EnergyStatsRepository energyStatsRepository;


    
     public List<EnergyStatsModel> findAll(){
     return energyStatsRepository.findAll();
     }
    

    public List<EnergyStatsModel> getEnergyStatssByZones(String id) {
       

        return energyStatsRepository.findByZone_Id(id);
    }


    public EnergyStatsModel findEnergyStatsById(String energyStatsId) {
        return energyStatsRepository.findById(energyStatsId).orElse(null);
    }


    public EnergyStatsModel addEnergyStats(EnergyStatsModel energyStats) {
        return energyStatsRepository.save(energyStats);
    }
}