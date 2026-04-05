package com.example.group52.configuration;

import com.example.group52.model.Guild;
import com.example.group52.model.User;
import com.example.group52.model.UserProfile;
import com.example.group52.repository.GuildRepository;
import com.example.group52.repository.UserProfileRepository;
import com.example.group52.repository.UserRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.util.List;

@Configuration
public class GuildSeeder {

    @Bean
    @Order(3)
    CommandLineRunner seedGuilds(GuildRepository guildRepository,
                                 UserRepository userRepository,
                                 UserProfileRepository userProfileRepository,
                                 PasswordEncoder encoder) {
        return args -> {

            // --- Create guild-only users ---

            User master1 = null;
            if (userRepository.findByUsername("guildmaster1").isEmpty()) {
                master1 = new User();
                master1.setUsername("guildmaster1");
                master1.setPasswordHash(encoder.encode("password"));
                master1.setRoles("USER");
                userRepository.save(master1);

                UserProfile p = new UserProfile();
                p.setUser(master1);
                p.setFirstName("Arthur");
                p.setLastName("Vance");
                p.setBio("Guild founder and strategist.");
                p.setLocation("London");
                p.setStatus("Active");
                p.setProfilePrivacy("Public");
                userProfileRepository.save(p);
            } else {
                master1 = userRepository.findByUsername("guildmaster1").get();
            }

            User captain1 = null;
            if (userRepository.findByUsername("guildcaptain1").isEmpty()) {
                captain1 = new User();
                captain1.setUsername("guildcaptain1");
                captain1.setPasswordHash(encoder.encode("password"));
                captain1.setRoles("USER");
                userRepository.save(captain1);

                UserProfile p = new UserProfile();
                p.setUser(captain1);
                p.setFirstName("Lyra");
                p.setLastName("Stone");
                p.setBio("Veteran coder and guild officer.");
                p.setLocation("Manchester");
                p.setStatus("Active");
                p.setProfilePrivacy("Public");
                userProfileRepository.save(p);
            } else {
                captain1 = userRepository.findByUsername("guildcaptain1").get();
            }

            User rookie1 = null;
            if (userRepository.findByUsername("guildrookie1").isEmpty()) {
                rookie1 = new User();
                rookie1.setUsername("guildrookie1");
                rookie1.setPasswordHash(encoder.encode("password"));
                rookie1.setRoles("USER");
                userRepository.save(rookie1);

                UserProfile p = new UserProfile();
                p.setUser(rookie1);
                p.setFirstName("Sam");
                p.setLastName("Elliot");
                p.setBio("New to the guild, eager to learn.");
                p.setLocation("Bristol");
                p.setStatus("Active");
                p.setProfilePrivacy("Public");
                userProfileRepository.save(p);
            } else {
                rookie1 = userRepository.findByUsername("guildrookie1").get();
            }

            User master2 = null;
            if (userRepository.findByUsername("guildmaster2").isEmpty()) {
                master2 = new User();
                master2.setUsername("guildmaster2");
                master2.setPasswordHash(encoder.encode("password"));
                master2.setRoles("USER");
                userRepository.save(master2);

                UserProfile p = new UserProfile();
                p.setUser(master2);
                p.setFirstName("Nora");
                p.setLastName("Blake");
                p.setBio("Private guild founder. Backend specialist.");
                p.setLocation("Edinburgh");
                p.setStatus("Active");
                p.setProfilePrivacy("Public");
                userProfileRepository.save(p);
            } else {
                master2 = userRepository.findByUsername("guildmaster2").get();
            }

            User master3 = null;
            if (userRepository.findByUsername("guildmaster3").isEmpty()) {
                master3 = new User();
                master3.setUsername("guildmaster3");
                master3.setPasswordHash(encoder.encode("password"));
                master3.setRoles("USER");
                userRepository.save(master3);

                UserProfile p = new UserProfile();
                p.setUser(master3);
                p.setFirstName("Vera");
                p.setLastName("Cross");
                p.setBio("Running a full house.");
                p.setStatus("Active");
                p.setProfilePrivacy("Public");
                userProfileRepository.save(p);
            } else {
                master3 = userRepository.findByUsername("guildmaster3").get();
            }

            User rookie2 = null;
            if (userRepository.findByUsername("guildrookie2").isEmpty()) {
                rookie2 = new User();
                rookie2.setUsername("guildrookie2");
                rookie2.setPasswordHash(encoder.encode("password"));
                rookie2.setRoles("USER");
                userRepository.save(rookie2);

                UserProfile p = new UserProfile();
                p.setUser(rookie2);
                p.setFirstName("Eli");
                p.setLastName("Marsh");
                p.setStatus("Active");
                p.setProfilePrivacy("Public");
                userProfileRepository.save(p);
            } else {
                rookie2 = userRepository.findByUsername("guildrookie2").get();
            }

            User rookie3 = null;
            if (userRepository.findByUsername("guildrookie3").isEmpty()) {
                rookie3 = new User();
                rookie3.setUsername("guildrookie3");
                rookie3.setPasswordHash(encoder.encode("password"));
                rookie3.setRoles("USER");
                userRepository.save(rookie3);

                UserProfile p = new UserProfile();
                p.setUser(rookie3);
                p.setFirstName("Cora");
                p.setLastName("Hunt");
                p.setStatus("Active");
                p.setProfilePrivacy("Public");
                userProfileRepository.save(p);
            } else {
                rookie3 = userRepository.findByUsername("guildrookie3").get();
            }

            User rookie4 = null;
            if (userRepository.findByUsername("guildrookie4").isEmpty()) {
                rookie4 = new User();
                rookie4.setUsername("guildrookie4");
                rookie4.setPasswordHash(encoder.encode("password"));
                rookie4.setRoles("USER");
                userRepository.save(rookie4);

                UserProfile p = new UserProfile();
                p.setUser(rookie4);
                p.setFirstName("Finn");
                p.setLastName("Cole");
                p.setStatus("Active");
                p.setProfilePrivacy("Public");
                userProfileRepository.save(p);
            } else {
                rookie4 = userRepository.findByUsername("guildrookie4").get();
            }

            User rookie5 = null;
            if (userRepository.findByUsername("guildrookie5").isEmpty()) {
                rookie5 = new User();
                rookie5.setUsername("guildrookie5");
                rookie5.setPasswordHash(encoder.encode("password"));
                rookie5.setRoles("USER");
                userRepository.save(rookie5);

                UserProfile p = new UserProfile();
                p.setUser(rookie5);
                p.setFirstName("Isla");
                p.setLastName("Webb");
                p.setStatus("Active");
                p.setProfilePrivacy("Public");
                userProfileRepository.save(p);
            } else {
                rookie5 = userRepository.findByUsername("guildrookie5").get();
            }

            User rookie6 = null;
            if (userRepository.findByUsername("guildrookie6").isEmpty()) {
                rookie6 = new User();
                rookie6.setUsername("guildrookie6");
                rookie6.setPasswordHash(encoder.encode("password"));
                rookie6.setRoles("USER");
                userRepository.save(rookie6);

                UserProfile p = new UserProfile();
                p.setUser(rookie6);
                p.setFirstName("Rex");
                p.setLastName("Ford");
                p.setStatus("Active");
                p.setProfilePrivacy("Public");
                userProfileRepository.save(p);
            } else {
                rookie6 = userRepository.findByUsername("guildrookie6").get();
            }

            User rookie7 = null;
            if (userRepository.findByUsername("guildrookie7").isEmpty()) {
                rookie7 = new User();
                rookie7.setUsername("guildrookie7");
                rookie7.setPasswordHash(encoder.encode("password"));
                rookie7.setRoles("USER");
                userRepository.save(rookie7);

                UserProfile p = new UserProfile();
                p.setUser(rookie7);
                p.setFirstName("Kai");
                p.setLastName("Burns");
                p.setStatus("Active");
                p.setProfilePrivacy("Public");
                userProfileRepository.save(p);
            } else {
                rookie7 = userRepository.findByUsername("guildrookie7").get();
            }

            User captain2 = null;
            if (userRepository.findByUsername("guildcaptain2").isEmpty()) {
                captain2 = new User();
                captain2.setUsername("guildcaptain2");
                captain2.setPasswordHash(encoder.encode("password"));
                captain2.setRoles("USER");
                userRepository.save(captain2);

                UserProfile p = new UserProfile();
                p.setUser(captain2);
                p.setFirstName("Owen");
                p.setLastName("Nash");
                p.setStatus("Active");
                p.setProfilePrivacy("Public");
                userProfileRepository.save(p);
            } else {
                captain2 = userRepository.findByUsername("guildcaptain2").get();
            }

            // --- Seed Guild 1: DragonForge (public) ---

            if (guildRepository.findByGuildNameIgnoreCase("DragonForge").isEmpty()) {
                Guild guild1 = new Guild();
                guild1.setGuildName("DragonForge");
                guild1.setCode("DRAG0001");
                guild1.setBio("Elite developers forging their skills in the fires of code.");
                guild1.setAnnouncement("Welcome to DragonForge! Weekly challenges every Monday.");
                guild1.setGuildPrivacy("public");
                guild1.setGuildJoinMethod("public");
                guildRepository.save(guild1);

                master1.setGuild(guild1);
                master1.setGuildRole("MASTER");
                guild1.getMembers().add(master1);
                userRepository.save(master1);

                captain1.setGuild(guild1);
                captain1.setGuildRole("CAPTAIN");
                guild1.getMembers().add(captain1);
                userRepository.save(captain1);

                rookie1.setGuild(guild1);
                rookie1.setGuildRole("ROOKIE");
                guild1.getMembers().add(rookie1);
                userRepository.save(rookie1);

                guildRepository.save(guild1);
                System.out.println("Guild created: DragonForge (master1=MASTER, captain1=CAPTAIN, rookie1=ROOKIE)");
            }

            // --- Seed Guild 2: SilverCoders (private) ---

            if (guildRepository.findByGuildNameIgnoreCase("SilverCoders").isEmpty()) {
                Guild guild2 = new Guild();
                guild2.setGuildName("SilverCoders");
                guild2.setCode("SILV0002");
                guild2.setBio("A close-knit guild for backend enthusiasts.");
                guild2.setAnnouncement("Invite only — ask around for the code.");
                guild2.setGuildPrivacy("guildOnly");
                guild2.setGuildJoinMethod("private");
                guildRepository.save(guild2);

                master2.setGuild(guild2);
                master2.setGuildRole("MASTER");
                guild2.getMembers().add(master2);
                userRepository.save(master2);

                guildRepository.save(guild2);
                System.out.println("Guild created: SilverCoders (master2=MASTER)");
            }

            // --- Seed Guild 4: IronPeak (full, 8 members) ---

            if (guildRepository.findByGuildNameIgnoreCase("IronPeak").isEmpty()) {
                Guild guild4 = new Guild();
                guild4.setGuildName("IronPeak");
                guild4.setCode("IRON0004");
                guild4.setBio("A fully packed guild — no room left.");
                guild4.setAnnouncement("Guild is full. Check back later!");
                guild4.setGuildPrivacy("public");
                guild4.setGuildJoinMethod("public");
                guildRepository.save(guild4);

                for (User member : List.of(master3, captain2, rookie2, rookie3, rookie4, rookie5, rookie6, rookie7)) {
                    member.setGuild(guild4);
                    member.setGuildRole(
                            member == master3  ? "MASTER"  :
                                    member == captain2 ? "CAPTAIN" : "ROOKIE"
                    );
                    guild4.getMembers().add(member);
                    userRepository.save(member);
                }

                guildRepository.save(guild4);
                System.out.println("Guild created: IronPeak (7 dedicated members + 1 = 8 total — add one more if needed)");
            }
        };
    }
}