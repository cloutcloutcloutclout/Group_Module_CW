package com.example.group52.controller;
import com.example.group52.model.User;
import com.example.group52.model.UserCourses;
import com.example.group52.model.UserProfile;
import com.example.group52.repository.UserCourseRepository;
import com.example.group52.repository.UserProfileRepository;
import com.example.group52.repository.UserRepository;
import com.example.group52.service.StatsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.security.Principal;
import java.util.List;

@Controller
@RequestMapping("/stats")
public class StatsController {
    @Autowired
    private StatsService statsService;

    @Autowired
    private UserCourseRepository userCourseRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UserProfileRepository userProfileRepository;

    public StatsController(StatsService statsService) {
        this.statsService = statsService;
    }

    @GetMapping("/ask")
    @ResponseBody
    public String ask(Principal principal) {
        String username = principal.getName();
        List <UserCourses> completedCourses = userCourseRepository.findByUserIdAndCompletedTrue(username);
        List <UserCourses> currentCourses = userCourseRepository.findByUserIdAndCompletedFalse(username);

        StringBuilder prompt = new StringBuilder();
        prompt.append("You are an AI Statistics Analyser to help identify strengths, weaknesses, and areas to improve based on the courses a user has completed for an IBM site.\n");

        prompt.append("\nCourses in Progress:\n");
        if (currentCourses.isEmpty()) {
            prompt.append("- No courses currently in progress.\n");
        } else {
            for (UserCourses u : currentCourses) {
                prompt.append("- ").append(u.getCourseName()).append(" (Category: ").append(u.getCourseCategory())
                        .append(")\n");
            }
        }

        prompt.append("Courses Completed:\n");
        if (completedCourses.isEmpty()) {
            prompt.append("- No courses completed yet.\n");
        } else {
            for (UserCourses u : completedCourses) {
                prompt.append("- ").append(u.getCourseName()).append(" (Category: ").append(u.getCourseCategory())
                        .append(")\n");
            }
        }

        prompt.append("\nBased on this data, provide a list of strengths, weaknesses, and areas to improve, as well as give the user personalised tips to help them gain new knowledge\n");
        prompt.append("\nFORMATTING INSTRUCTIONS:\n");
        prompt.append("1. Use NO Markdown characters. Never use '*', '**', or '###'.\n");
        prompt.append("2. Use <h4><strong>Heading Name</strong></h4> for each section header.\n");
        prompt.append("3. For any text that needs emphasis, wrap it in <strong>Text</strong>.\n");
        prompt.append("4. Use <ul> and <li> tags for all bulleted lists.\n");
        prompt.append("6. Return ONLY raw HTML code. Do not wrap it in ```html blocks.");
        prompt.append("\nDO NOT PROVIDE OR ENCOURAGE THE USER FOR FURTHER PROMPTS.");
        System.out.println(prompt);
        return statsService.generateText(prompt.toString());
    }

    @GetMapping("/userstats")
    public String userstats(Model model, Principal principal) {
        String userId = principal.getName();
        User currentUser = userRepository.findByUsername(principal.getName()).orElseThrow();
        UserProfile userProfile = userProfileRepository.findByUserId(currentUser.getId());
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("userProfile", userProfile);
        model.addAttribute("Courses", userCourseRepository.findByUserIdAndCompletedFalse(userId));
        model.addAttribute("completedCourses", userCourseRepository.findByUserIdAndCompletedTrue(userId));
        model.addAttribute("username", currentUser.getUsername());
        return "stats/userstats";
    }
}
