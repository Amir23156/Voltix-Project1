package com.example.voltix.Sites;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.voltix.Machine.MachineModel;

@RestController
@RequestMapping("/api/site")

public class SiteController {
    @Autowired
    private SiteService siteService;

    @PostMapping("/AddSite")
    public ResponseEntity<SiteModel> addCircuitBreaker(@RequestBody SiteModel site) {
        return new ResponseEntity<SiteModel>(siteService.addCircuitBreaker(site), HttpStatus.ACCEPTED);
    }

    @GetMapping("/FindAllSite")
    public ResponseEntity<List<SiteModel>> findAll() {
        return new ResponseEntity<List<SiteModel>>(siteService.findAll(), HttpStatus.ACCEPTED);
    }

    @GetMapping("/FindSiteByName/{SiteName}")
    public ResponseEntity<?> findBySiteName(@PathVariable String siteName) {
        SiteModel site = siteService.findSiteByName(siteName);
        if (site != null) {
            return ResponseEntity.ok(site);
        } else {
            String errorMessage = "Site with name '" + siteName + "' not found.";
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(errorMessage);
        }
    }

    @DeleteMapping("/DeleteSite/{id}")
    public ResponseEntity<String> deleteById(@PathVariable String id) {
        siteService.deleteSiteById(id);
        return new ResponseEntity<>("Site with ID " + id + " deleted", HttpStatus.OK);
    }

    @PutMapping("/UpdateSite/{id}")
    public ResponseEntity<SiteModel> updateSite(@PathVariable String id, @RequestBody SiteModel updatedsite) {
        SiteModel existingsite = siteService.findSiteById(id);
        if (existingsite != null) {
            // Effectuer ici les mises à jour nécessaires sur l'objet existingZone en
            // utilisant les setters appropriés de la classe ZoneModel
            existingsite.setSiteName(updatedsite.getSiteName());
            existingsite.setSiteLocation(updatedsite.getSiteLocation());
            // Ajouter d'autres mises à jour pour les autres propriétés de ZoneModel si
            // nécessaire

            SiteModel savedsite = siteService.addCircuitBreaker(existingsite);
            return new ResponseEntity<>(savedsite, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
    // hhhhhhhhh

}
