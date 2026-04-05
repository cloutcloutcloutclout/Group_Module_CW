package com.example.group52.configuration;

import com.example.group52.model.UserProfile;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.example.group52.model.User;
import com.example.group52.repository.UserRepository;
import com.example.group52.repository.UserProfileRepository;

@Configuration
public class UserSeeder {
    @Bean
    @Order(3)
    CommandLineRunner seedUser(UserRepository userRepository, PasswordEncoder encoder, UserProfileRepository userProfileRepository) {
        return args -> {
            if (userRepository.findByUsername("user").isEmpty()) {
                User user = new User();
                user.setUsername("user");
                user.setDisplayName("User User");
                user.setPasswordHash(encoder.encode("password"));
                user.setRoles("USER");
                userRepository.save(user);

                UserProfile profile = new UserProfile();
                profile.setUser(user);
                profile.setFirstName("Default");
                profile.setLastName("User");
                profile.setBio("This is a seeded profile.");
                userProfileRepository.save(profile);

                System.out.println("User created: user / password");
            }
        };
    }
}
