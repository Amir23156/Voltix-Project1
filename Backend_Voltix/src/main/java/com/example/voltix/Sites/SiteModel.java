package com.example.voltix.Sites;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import lombok.Data;


@Data
@Document(collection = "sites")
public class SiteModel {
    @Id
    private String id;
    private String siteName;
    private String siteLocation;

}

