package com.example.voltix.Sites;

import org.springframework.data.mongodb.repository.MongoRepository;

public interface SiteRepository extends MongoRepository<SiteModel, String> {
    public java.util.Optional<SiteModel> findById(String id);

    SiteModel findBySiteName(String siteName);
}
