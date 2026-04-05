package com.example.group52.controller;

import java.security.Principal;

import com.example.group52.service.CourseService;
import com.example.group52.service.DashboardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.group52.model.User;
import com.example.group52.model.UserProfile;
import com.example.group52.repository.CourseRepository;
import com.example.group52.repository.UserProfileRepository;
import com.example.group52.repository.UserRepository;
import com.example.group52.service.CourseSessionService;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class CourseController {
    @Value("${app.course.open-mode:popup}")
    private String courseOpenMode;

    @Autowired
    private CourseRepository courseRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UserProfileRepository userProfileRepository;

    @Autowired
    private CourseSessionService courseSessionService;

    @Autowired
    private DashboardService dashboardService;

    @Autowired
    private CourseService courseService;

    @RequestMapping("/courses")
    public String courses() {
        return "redirect:/search";
    }

    @RequestMapping("/courses/details/{id}")
    public String courseDetails(@PathVariable("id") Integer id,
                                @RequestParam(required = false) Integer editId,
                                Model model, Principal principal) {
        var courseOptional = courseRepository.findById(id);
        if (courseOptional.isPresent()) {
            var course = courseOptional.get();
            model.addAttribute("course", course);
            long durationSeconds = (long) course.getDurationMinutes() * 60;
            model.addAttribute("durationSeconds", durationSeconds);
            if (principal != null) {
                User currentUser = userRepository.findByUsername(principal.getName()).orElse(null);
                model.addAttribute("currentUser", currentUser);
                if (currentUser != null) {
                    UserProfile userProfile = userProfileRepository.findByUserId(currentUser.getId());
                    model.addAttribute("userProfile", userProfile);
                }
                String courseId = String.valueOf(course.getId());
                long totalSeconds = courseSessionService.getTotalSecondsForUserCourse(principal.getName(), courseId);
                boolean hasStarted = courseSessionService.hasStartedCourse(principal.getName(), courseId);
                int progressPercent = durationSeconds > 0
                        ? (int) Math.min(100, totalSeconds * 100 / durationSeconds) : 0;
                model.addAttribute("totalElapsedSeconds", totalSeconds);
                model.addAttribute("progressPercent", progressPercent);
                model.addAttribute("hasStarted", hasStarted);
            } else {
                model.addAttribute("totalElapsedSeconds", 0L);
                model.addAttribute("progressPercent", 0);
                model.addAttribute("hasStarted", false);
            }
            model.addAttribute("courseOpenMode", courseOpenMode);
            model.addAttribute("reviews", courseService.getReviewsByCourseId(id));
            model.addAttribute("editId", editId);
            return "course/details";
        }
        return "redirect:/search";
    }

    @PostMapping("/addCourse")
    public String addCourse(@RequestParam String courseId, Principal principal) {
        dashboardService.addCourse(courseId, principal.getName());
        return "redirect:/dashboard";
    }

    @PostMapping("/completeCourse")
    public String completeCourse(@RequestParam String courseId, Principal principal) {
        if (principal != null) {
            dashboardService.completeCourse(courseId, principal.getName());
        }
        return "redirect:/dashboard";
    }

    @PostMapping("/resetCourse")
    public String resetCourse(@RequestParam String courseId, Principal principal) {
        if (principal != null) {
            dashboardService.resetCourse(courseId, principal.getName());
        }
        return "redirect:/dashboard";
    }
}
