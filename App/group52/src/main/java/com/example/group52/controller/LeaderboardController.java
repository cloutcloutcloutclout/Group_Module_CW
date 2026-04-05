package com.example.group52.controller;
import com.example.group52.model.Guild;
import com.example.group52.model.User;
import com.example.group52.model.UserProfile;
import com.example.group52.repository.GuildRepository;
import com.example.group52.repository.UserProfileRepository;
import com.example.group52.repository.UserRepository;
import com.example.group52.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.security.Principal;
import java.util.List;

@Controller
public class LeaderboardController {
    @Autowired
    private UserService userService;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private UserProfileRepository userProfileRepository;
    @Autowired
    private GuildRepository guildRepository;

    @RequestMapping("/leaderboard")
    public String leaderboard(Model model, Principal principal) {

        List<User> leaderboardRanking = userService.displayUserRank();
        model.addAttribute("user", leaderboardRanking);

        // Guild list
        List<Guild> allGuilds = guildRepository.findAll();

        // Sorting highest to lowest with guilds
        allGuilds.sort((g1,g2) -> Integer.compare(g2.getGuildPoints(), g1.getGuildPoints()));

        // sorting it into top 10 (5 to 1
        List<Guild> topGuilds = allGuilds.stream().limit(10).toList();
        model.addAttribute("topGuilds", topGuilds);


        if (principal != null) {
            User currentUser = userRepository.findByUsername(principal.getName()).orElse(null);
            model.addAttribute("currentUser", currentUser);
            if (currentUser != null) {
                UserProfile userProfile = userProfileRepository.findByUserId(currentUser.getId());
                model.addAttribute("userProfile", userProfile);

                Guild usersGuild = currentUser.getGuild();
                if (usersGuild != null) {
                    model.addAttribute("usersGuild", usersGuild);

                    // Find the rank by finding the index and adding 1 with increment
                    int rank = 1;
                    // for loop of guilds in allGuilds
                    for (Guild g : allGuilds) {
                        // if the guild id is user guild
                        if (g.getId() == usersGuild.getId()) {
                            break;
                        }
                        // increment
                        rank ++;
                    }
                    model.addAttribute("guildRank", rank);

                }
            }
        }

        return "leaderboard/leaderboard";
    }
}