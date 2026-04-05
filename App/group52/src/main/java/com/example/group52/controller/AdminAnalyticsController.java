package com.example.group52.controller;

import com.example.group52.service.AdminAnalyticsService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AdminAnalyticsController {

    private final AdminAnalyticsService adminAnalyticsService;

    public AdminAnalyticsController(AdminAnalyticsService adminAnalyticsService) {
        this.adminAnalyticsService = adminAnalyticsService;
    }

    @GetMapping("/admin/analytics")
    public String showAnalytics(@RequestParam(value = "range", defaultValue = "7") String range,
                                Model model) {
        model.addAttribute("range", range);
        model.addAttribute("totalUsers", adminAnalyticsService.getTotalUsers());
        model.addAttribute("totalCourses", adminAnalyticsService.getTotalCourses());
        model.addAttribute("totalSessions", adminAnalyticsService.getTotalSessions());
        model.addAttribute("totalFeedback", adminAnalyticsService.getTotalFeedback());
        model.addAttribute("totalUserCourses", adminAnalyticsService.getTotalUserCourses());
        model.addAttribute("topUsers", adminAnalyticsService.getTopUsers());


        return "analytics/analytics";
    }
}