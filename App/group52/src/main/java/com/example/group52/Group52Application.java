package com.example.group52;

import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class Group52Application {

	public static void main(String[] args) {
		new SpringApplicationBuilder(Group52Application.class)
			.headless(false)
			.run(args);
	}

}
