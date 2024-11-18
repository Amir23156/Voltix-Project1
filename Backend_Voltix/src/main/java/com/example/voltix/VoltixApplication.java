package com.example.voltix;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@EnableScheduling
@SpringBootApplication
public class VoltixApplication {

	public static void main(String[] args) {
		SpringApplication.run(VoltixApplication.class, args);
	}

}
