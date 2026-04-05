package com.example.group52.configuration;

import com.example.group52.model.User;
import com.example.group52.model.UserProfile;
import com.example.group52.repository.UserRepository;
import com.example.group52.repository.UserProfileRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
public class AdminSeeder {

    @Bean
    @Order(1)
    CommandLineRunner seedAdmin(UserRepository userRepository, PasswordEncoder encoder, UserProfileRepository userProfileRepository) {
        return args -> {

            String adminUsername = "admin@ibmskillsbuild.com";

            User admin;

            // If admin doesn't exist, create it
            if (userRepository.findByUsername(adminUsername).isEmpty()) {
                admin = new User();
                admin.setUsername(adminUsername);
                admin.setPasswordHash(encoder.encode("password"));
                admin.setRoles("ADMIN"); // IMPORTANT: store ADMIN (not ROLE_ADMIN)
                userRepository.save(admin);

                System.out.println("Admin created: " + adminUsername + " / password");
            } else {
                admin = userRepository.findByUsername(adminUsername).get();
            }

            // Ensure admin has a UserProfile
            if (userProfileRepository.findByUserId(admin.getId()) == null) {
                UserProfile profile = new UserProfile();
                profile.setUser(admin);
                profile.setFirstName("Admin");
                profile.setLastName("User");
                userProfileRepository.save(profile);
                System.out.println("Admin UserProfile created for: " + adminUsername);
            }
        };
    }
}
