package com.example.voltix.Monthly;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MonthlyService {

    @Autowired
    private MonthlyRepository monthlyRepository;

    public List<MonthlyModel> findAll() {
        return monthlyRepository.findAll();
    }

    public List<MonthlyModel> getMonthlysByZones(String id) {

        return monthlyRepository.findByZone_Id(id);
    }

    public MonthlyModel findMonthlyById(String monthlyId) {
        return monthlyRepository.findById(monthlyId).orElse(null);
    }

    public MonthlyModel addMonthly(MonthlyModel monthly) {
        return monthlyRepository.save(monthly);
    }
}