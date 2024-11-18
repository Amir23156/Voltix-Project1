package com.example.voltix.Weekly;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class WeeklyService {

    @Autowired
    private WeeklyRepository weeklyRepository;


    
     public List<WeeklyModel> findAll(){
     return weeklyRepository.findAll();
     }
    

    public List<WeeklyModel> getWeeklysByZones(String id) {
      

        return weeklyRepository.findByZone_Id(id);
    }


    public WeeklyModel findWeeklyById(String weeklyId) {
        return weeklyRepository.findById(weeklyId).orElse(null);
    }


    public WeeklyModel addWeekly(WeeklyModel weekly) {
        return weeklyRepository.save(weekly);
    }
}