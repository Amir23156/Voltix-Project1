package com.example.voltix.ZoneConsomationHistory;

import com.example.voltix.Zones.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class ZoneConsomationService {
    private final ZoneConsomationRepository zoneConsomationRepository;

    @Autowired
    public ZoneConsomationService(
            ZoneRepository zoneRepository,
            ZoneConsomationRepository zoneConsomationRepository, ZoneService zoneService) {
        this.zoneConsomationRepository = zoneConsomationRepository;
    }

    public ZoneConsomationModel CreateZoneConsomation(ZoneConsomationModel zoneConsomationModel) {
        return zoneConsomationRepository.save(zoneConsomationModel);
    }

    public List<ZoneConsomationModel> findAll() {
        return zoneConsomationRepository.findAll();
    }

    public void deleteZoneConsomationById(String id) {
        zoneConsomationRepository.deleteById(id);
    }

    public List<ZoneConsomationModel> getZoneConsomationsBetweenDates(fetchDataModel fetchRequest) {
        List<ZoneConsomationModel> filteredInstances = new ArrayList<>();
        try {
            List<ZoneConsomationModel> instancesInDateRange = zoneConsomationRepository
                    .findByDateBetweenAndZone_Id(fetchRequest.getDateDebut(), fetchRequest.getDateFin(),
                            fetchRequest.getZone().getId());

            if ((fetchRequest.getType()).equals("annully")) {

                Map<String, Double> yearMonthToConsumptionMap = new HashMap<>();

                // Iterate through instances and group by year and month
                for (ZoneConsomationModel instance : instancesInDateRange) {

                    Date date = instance.getDate();

                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");

                    String yearMonth = sdf.format(date);

                    // Update the consumption sum for the group
                    yearMonthToConsumptionMap.put(yearMonth,
                            yearMonthToConsumptionMap.getOrDefault(yearMonth, 0.0) + instance.getConsomation());
                }
              

                // Create a new list with grouped instances

                for (Map.Entry<String, Double> entry : yearMonthToConsumptionMap.entrySet()) {

                    ZoneConsomationModel groupedInstance = new ZoneConsomationModel();

                    groupedInstance.setConsomation(entry.getValue());

                    // Parse the year-month string back to a Date if needed
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
                    Date date = sdf.parse(entry.getKey());
                    Calendar calendar = Calendar.getInstance();
                    calendar.setTime(date);

                    // Add two hours to the Calendar
                    calendar.add(Calendar.HOUR_OF_DAY, 2);

                    // Get the updated Date
                    date = calendar.getTime();

                    groupedInstance.setDate(date);

                    // Add the grouped instance to the new list
                    filteredInstances.add(groupedInstance);

                }

            }

            else if (((fetchRequest.getType()).equals("monthly")) || ((fetchRequest.getType()).equals("weekly"))) {
                Map<String, Double> yearMonthToConsumptionMap = new HashMap<>();

                // Iterate through instances and group by year and month
                for (ZoneConsomationModel instance : instancesInDateRange) {

                    Date date = instance.getDate();

                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                  
                    String yearMonth = sdf.format(date);

                    // Update the consumption sum for the group
                    yearMonthToConsumptionMap.put(yearMonth,
                            yearMonthToConsumptionMap.getOrDefault(yearMonth, 0.0) + instance.getConsomation());
                }

                // Create a new list with grouped instances

                for (Map.Entry<String, Double> entry : yearMonthToConsumptionMap.entrySet()) {

                    ZoneConsomationModel groupedInstance = new ZoneConsomationModel();

                    groupedInstance.setConsomation(entry.getValue());

                    // Parse the year-month string back to a Date if needed
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    Date date = sdf.parse(entry.getKey());
                    Calendar calendar = Calendar.getInstance();
                    calendar.setTime(date);

                    // Add two hours to the Calendar
                    calendar.add(Calendar.HOUR_OF_DAY, 2);

                    // Get the updated Date
                    date = calendar.getTime();
                    groupedInstance.setDate(date);

                    // Add the grouped instance to the new list
                    filteredInstances.add(groupedInstance);

                }

            } else {

                Map<String, Double> yearMonthToConsumptionMap = new HashMap<>();
               
                // Iterate through instances and group by year and month
                for (ZoneConsomationModel instance : instancesInDateRange) {

                    Date date = instance.getDate();

                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM  HH");
                    String yearMonth = sdf.format(date);
                 
                    // Update the consumption sum for the group
                    yearMonthToConsumptionMap.put(yearMonth,
                            yearMonthToConsumptionMap.getOrDefault(yearMonth, 0.0) + instance.getConsomation());
                }
               
                // Create a new list with grouped instances

                for (Map.Entry<String, Double> entry : yearMonthToConsumptionMap.entrySet()) {

                    ZoneConsomationModel groupedInstance = new ZoneConsomationModel();

                    groupedInstance.setConsomation(entry.getValue());

                    // Parse the year-month string back to a Date if needed
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM  HH");
                    Date date = sdf.parse(entry.getKey());
                
                    groupedInstance.setDate(date);

                    // Add the grouped instance to the new list
                    filteredInstances.add(groupedInstance);

                }
            }

            Collections.sort(filteredInstances, new Comparator<ZoneConsomationModel>() {
                @Override
                public int compare(ZoneConsomationModel model1, ZoneConsomationModel model2) {
                    return model1.getDate().compareTo(model2.getDate());
                }
            });
           
            return filteredInstances;

        } catch (Exception e) {
           
            return null;
        }
    }

    public List<ZoneConsomationModel> getZoneConsomationsBetweenDatesForAll(FetchAll fetchRequest) {
        List<ZoneConsomationModel> filteredInstances = new ArrayList<>();

        try {
            List<ZoneConsomationModel> instancesInDateRange = zoneConsomationRepository
                    .findByDateBetween(fetchRequest.getDateDebut(), fetchRequest.getDateFin());

            if ((fetchRequest.getType()).equals("annully")) {

                Map<String, Double> yearMonthToConsumptionMap = new HashMap<>();

                // Iterate through instances and group by year and month
                for (ZoneConsomationModel instance : instancesInDateRange) {

                    Date date = instance.getDate();

                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");

                    String yearMonth = sdf.format(date);

                    // Update the consumption sum for the group
                    yearMonthToConsumptionMap.put(yearMonth,
                            yearMonthToConsumptionMap.getOrDefault(yearMonth, 0.0) + instance.getConsomation());
                }
               
                // Create a new list with grouped instances

                for (Map.Entry<String, Double> entry : yearMonthToConsumptionMap.entrySet()) {

                    ZoneConsomationModel groupedInstance = new ZoneConsomationModel();

                    groupedInstance.setConsomation(entry.getValue());

                    // Parse the year-month string back to a Date if needed
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
                    Date date = sdf.parse(entry.getKey());
                    Calendar calendar = Calendar.getInstance();
                    calendar.setTime(date);

                    // Add two hours to the Calendar
                    calendar.add(Calendar.HOUR_OF_DAY, 2);

                    // Get the updated Date
                    date = calendar.getTime();

                    groupedInstance.setDate(date);

                    // Add the grouped instance to the new list
                    filteredInstances.add(groupedInstance);

                }

            }

            else if (((fetchRequest.getType()).equals("monthly")) || ((fetchRequest.getType()).equals("weekly"))) {
                Map<String, Double> yearMonthToConsumptionMap = new HashMap<>();

                // Iterate through instances and group by year and month
                for (ZoneConsomationModel instance : instancesInDateRange) {

                    Date date = instance.getDate();

                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    
                    String yearMonth = sdf.format(date);

                    // Update the consumption sum for the group
                    yearMonthToConsumptionMap.put(yearMonth,
                            yearMonthToConsumptionMap.getOrDefault(yearMonth, 0.0) + instance.getConsomation());
                }

                // Create a new list with grouped instances

                for (Map.Entry<String, Double> entry : yearMonthToConsumptionMap.entrySet()) {

                    ZoneConsomationModel groupedInstance = new ZoneConsomationModel();

                    groupedInstance.setConsomation(entry.getValue());

                    // Parse the year-month string back to a Date if needed
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    Date date = sdf.parse(entry.getKey());
                    Calendar calendar = Calendar.getInstance();
                    calendar.setTime(date);

                    // Add two hours to the Calendar
                    calendar.add(Calendar.HOUR_OF_DAY, 2);

                    // Get the updated Date
                    date = calendar.getTime();
                    groupedInstance.setDate(date);

                    // Add the grouped instance to the new list
                    filteredInstances.add(groupedInstance);

                }

            } else {

                Map<String, Double> yearMonthToConsumptionMap = new HashMap<>();
               
                // Iterate through instances and group by year and month
                for (ZoneConsomationModel instance : instancesInDateRange) {

                    Date date = instance.getDate();

                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM  HH");
                    String yearMonth = sdf.format(date);
              
                    // Update the consumption sum for the group
                    yearMonthToConsumptionMap.put(yearMonth,
                            yearMonthToConsumptionMap.getOrDefault(yearMonth, 0.0) + instance.getConsomation());
                }
              
                // Create a new list with grouped instances

                for (Map.Entry<String, Double> entry : yearMonthToConsumptionMap.entrySet()) {

                    ZoneConsomationModel groupedInstance = new ZoneConsomationModel();

                    groupedInstance.setConsomation(entry.getValue());

                    // Parse the year-month string back to a Date if needed
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM  HH");
                    Date date = sdf.parse(entry.getKey());
                  
                    groupedInstance.setDate(date);

                    // Add the grouped instance to the new list
                    filteredInstances.add(groupedInstance);

                }
            }

            Collections.sort(filteredInstances, new Comparator<ZoneConsomationModel>() {
                @Override
                public int compare(ZoneConsomationModel model1, ZoneConsomationModel model2) {
                    return model1.getDate().compareTo(model2.getDate());
                }
            });
  
            return filteredInstances;

        } catch (Exception e) {
          
            return null;
        }

    }

    private ZoneConsomationModel mergeAndSum(List<ZoneConsomationModel> consomations) {
        ZoneConsomationModel mergedConsomation = new ZoneConsomationModel();

        // Assuming the first element's ID is the one to keep
        mergedConsomation.setId(consomations.get(0).getId());

        // Sum the consumption
        double totalConsumption = consomations.stream()
                .mapToDouble(ZoneConsomationModel::getConsomation)
                .sum();
        mergedConsomation.setConsomation(totalConsumption);

        // Set the date and other properties as needed

        return mergedConsomation;
    }

    private String getYearMonthKey(ZoneConsomationModel model) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(model.getDate());
        int year = cal.get(Calendar.YEAR);
        int month = cal.get(Calendar.MONTH) + 1; // Month is 0-based
        return year + "-" + month;
    }

    private ZoneConsomationModel mergeModels(List<ZoneConsomationModel> models) {
        ZoneConsomationModel mergedModel = new ZoneConsomationModel();

        // Keep values from one of the models
        ZoneConsomationModel modelToKeep = models.get(0);
       
        mergedModel.setId(modelToKeep.getId());
        mergedModel.setDate(modelToKeep.getDate());
        mergedModel.setZone(modelToKeep.getZone());

        // Calculate the total consumption for the merged models
        double totalConsumption = models.stream().mapToDouble(ZoneConsomationModel::getConsomation).sum();
        mergedModel.setConsomation(totalConsumption);

        return mergedModel;
    }

    private String getYearMonthDayKey(ZoneConsomationModel zoneConsomation) {
        // Create a key based on the year, month, and day (you can adjust this format as
        // needed)
        Calendar cal = Calendar.getInstance();
        cal.setTime(zoneConsomation.getDate());
        int year = cal.get(Calendar.YEAR);
        int month = cal.get(Calendar.MONTH) + 1; // Month is 0-based in Calendar
        int day = cal.get(Calendar.DAY_OF_MONTH);
        return year + "-" + month + "-" + day;
    }

    public void updatZoneConsomation(ZoneConsomationModel zoneConsomation) {
        zoneConsomationRepository.save(zoneConsomation);
    }

    public ZoneConsomationModel findById(String id) {
     

        return zoneConsomationRepository.findById(id).orElse(null);
    }

    public List<ZoneConsomationModel> getConsomatopForZone(String id) {
        List<ZoneConsomationModel> liste = new ArrayList<>();

        // System.out.println(machineRepository.findByCircuitBreaker_Id(id));

        List<ZoneConsomationModel> zoneConsomation = zoneConsomationRepository.findByZoneIdOrderByDateAsc(id);
        return zoneConsomation;
    }

}
