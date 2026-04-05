package com.example.group52.controller;


import java.security.Principal;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.group52.model.User;
import com.example.group52.model.UserBadges;
import com.example.group52.repository.UserBadgesRepository;
import com.example.group52.repository.UserRepository;
import com.example.group52.service.StreakService;

@Controller
public class StreakController {

//handles logic for incrementing user streaks
    @Autowired
    private StreakService streakService;
//handles database operations for user entity
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UserBadgesRepository userBadgesRepository;

    @GetMapping("/streak")
    public String streakPage(Principal principal, Model model){
        String loggedInUser=principal.getName(); //gets the name of the logged-in user

        User user=userRepository.findByUsername(loggedInUser).orElseGet(()->{ //gets the user through the credentials
            User newUser= new User();
            newUser.setUsername(loggedInUser);
            newUser.setCurrentStreak(0);
            newUser.setPoints(0);

            return userRepository.save(newUser); //saves a new user if it has not been made yet
        });

        model.addAttribute("user",user);
        return "streak/streakPage";
    }

    @PostMapping("/streak/increment-courses")
    public String incStreak( @RequestParam String timeZone, RedirectAttributes redirectAttributes, Principal principal){

        String loggedInUser=principal.getName();
        User user=userRepository.findByUsername(loggedInUser).orElseThrow();
        streakService.streakIncrement(user.getId(),timeZone);

        user = userRepository.findById(user.getId()).orElse(user);

        awardStreakBadgeIfEligible(user, 7, "7-Day Streak Badge", "https://upload.wikimedia.org/wikipedia/commons/5/51/IBM_logo.svg");
        awardStreakBadgeIfEligible(user, 15, "15-Day Streak Badge", "https://upload.wikimedia.org/wikipedia/commons/5/51/IBM_logo.svg");
        awardStreakBadgeIfEligible(user, 30, "30-Day Streak Badge", "https://upload.wikimedia.org/wikipedia/commons/5/51/IBM_logo.svg");

        return "redirect:/search";
    }

    private void awardStreakBadgeIfEligible(User user, int milestone, String badgeName, String badgeImage) {
        if (user.getCurrentStreak() == milestone) {
            UserBadges existingBadge = userBadgesRepository.findByUserIdAndBadgeName(user.getUsername(), badgeName);
            if (existingBadge == null) {
                UserBadges newBadge = new UserBadges();
                newBadge.setBadgeName(badgeName);
                newBadge.setBadgeImage(badgeImage);
                newBadge.setBadgeDate(new Date());
                newBadge.setUserId(user.getUsername());
                newBadge.setEarnedCount(1);
                userBadgesRepository.save(newBadge);
            } else {
                java.text.SimpleDateFormat fmt = new java.text.SimpleDateFormat("yyyy-MM-dd");
                String todayStr = fmt.format(new Date());
                String badgeEarnedStr = existingBadge.getBadgeDate() != null ? fmt.format(existingBadge.getBadgeDate()) : "";
                
                if (!todayStr.equals(badgeEarnedStr)) {
                    int currentCount = existingBadge.getEarnedCount() == null ? 1 : existingBadge.getEarnedCount();
                    existingBadge.setEarnedCount(currentCount + 1);
                    existingBadge.setBadgeDate(new Date());
                    userBadgesRepository.save(existingBadge);
                }
            }
        }
    }
}
