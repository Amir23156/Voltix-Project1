package com.example.voltix.Daily;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DailyService {

    @Autowired
    private DailyRepository dailyRepository;


    
     public List<DailyModel> findAll(){
     return dailyRepository.findAll();
     }
    

    public List<DailyModel> getDailysByZones(String id) {
       
        return dailyRepository.findByZone_Id(id);
    }


    public DailyModel findDailyById(String dailyId) {
        return dailyRepository.findById(dailyId).orElse(null);
    }


    public DailyModel addDaily(DailyModel daily) {
        return dailyRepository.save(daily);
    }
}