package com.example.group52.configuration;

import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.example.group52.model.User;
import com.example.group52.model.UserProfile;
import com.example.group52.repository.UserProfileRepository;
import com.example.group52.repository.UserRepository;

import java.util.Optional;

@Configuration
public class UserProfileSeeder {

    @Bean
    @Order(2)
    CommandLineRunner seedUsersWithProfiles(UserRepository userRepository,
                                            UserProfileRepository userProfileRepository,
                                            PasswordEncoder encoder) {
        return args -> {
            if (userRepository.findByUsername("john").isEmpty()) {
                User user1 = new User();
                user1.setUsername("john");
                user1.setPasswordHash(encoder.encode("password123"));
                user1.setRoles("USER");
                userRepository.save(user1);

                UserProfile profile1 = new UserProfile();
                profile1.setUser(user1);
                profile1.setFirstName("John");
                profile1.setLastName("Doe");
                profile1.setPronoun("He/Him");
                profile1.setPronunciation("Jon Doh");
                profile1.setBio("Software developer from NY");
                profile1.setStatus("Active");
                profile1.setLocation("New York");
                profile1.setProfilePrivacy("Public");
                profile1.setLinkedIn("John@Linkedin");
                profile1.setIbm("John@Ibm");
                profile1.setGithub("John@Github");
                profile1.setWebsite("https://johndoe.com");
                profile1.setContactEmail("contact@johndoe.com");
                userProfileRepository.save(profile1);

                System.out.println("User + profile created: john / password123");
            }

            if (userRepository.findByUsername("jane").isEmpty()) {
                User user2 = new User();
                user2.setUsername("jane");
                user2.setPasswordHash(encoder.encode("password456"));
                user2.setRoles("USER");
                userRepository.save(user2);

                UserProfile profile2 = new UserProfile();
                profile2.setUser(user2);
                profile2.setFirstName("Jane");
                profile2.setLastName("Smith");
                profile2.setPronoun("She/Her");
                profile2.setPronunciation("Jane Smith");
                profile2.setBio("Graphic designer and painter");
                profile2.setStatus("Active");
                profile2.setLocation("Los Angeles");
                profile2.setProfilePrivacy("Public");
                profile2.setLinkedIn("JohnD@Linkedin");
                profile2.setIbm("JohnD@Ibm");
                profile2.setGithub("JohnD@Github");
                profile2.setWebsite("https://janesmith.com");
                profile2.setContactEmail("contact@janesmith.com");
                userProfileRepository.save(profile2);

                System.out.println("User + profile created: jane / password456");
            }

            if (userRepository.findByUsername("mary").isEmpty()) {
                User user3 = new User();
                user3.setUsername("mary");
                user3.setPasswordHash(encoder.encode("password"));
                user3.setRoles("USER");
                userRepository.save(user3);

                UserProfile profile3 = new UserProfile();
                profile3.setUser(user3);
                profile3.setFirstName("Mary");
                profile3.setLastName("Test");
                profile3.setPronoun("She/Her");
                profile3.setPronunciation("Mary Test");
                profile3.setBio("Software Engineer");
                profile3.setStatus("Active");
                profile3.setLocation("Rotterdam");
                profile3.setProfilePrivacy("Public");
                profile3.setLinkedIn("Mary@Linkedin");
                profile3.setIbm("Mary@Ibm");
                profile3.setGithub("Mary@Github");
                profile3.setWebsite("https://marytest.com");
                profile3.setContactEmail("contact@marytest.com");
                userProfileRepository.save(profile3);

                System.out.println("User + profile created: mary / password");

            }




        };
    }
}
