package com.example.voltix.Sites;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;

import com.example.voltix.Buildings.BuildingRepository;
import com.example.voltix.Buildings.BuildingService;
import com.example.voltix.Machine.MachineModel;

@Service
public class SiteService {
    @Autowired
    private SiteRepository siteRepository;
    @Autowired
    private BuildingService buildingService;

    public SiteModel addCircuitBreaker(SiteModel site) {
        return siteRepository.save(site);
    }

    public List<SiteModel> findAll() {
        return siteRepository.findAll();
    }

    public SiteModel findSiteByName(String siteName) {
        return siteRepository.findBySiteName(siteName);
    }

    public void deleteSiteById(String id) {
        Optional<SiteModel> siteOptional = siteRepository.findById(id);
        if (siteOptional.isPresent()) {
            SiteModel site = siteOptional.get();
            siteRepository.delete(site);
            buildingService.deleteBuildings(id);
        } else {
            // Handle the case when the zone with the specified ID does not exist.
            // You can throw an exception, log a message, or take any other appropriate
            // action.
        }
    }

    public SiteModel updateSite(String id, SiteModel updatedsite) {
        SiteModel result = new SiteModel();
        try {
         
            result = siteRepository.save(updatedsite);
            
        } catch (StackOverflowError e) {
            
        }
        // System.out.println(updatedcircuitBreaker);
        return result;
    }

    public SiteModel findSiteById(String Id) {
        return siteRepository.findById(Id).orElse(null);
    }

}
