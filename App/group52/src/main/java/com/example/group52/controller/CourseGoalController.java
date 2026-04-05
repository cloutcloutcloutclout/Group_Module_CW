package com.example.group52.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.example.group52.model.*;
import com.example.group52.repository.UserProfileRepository;
import com.example.group52.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.group52.repository.CourseRepository;
import com.example.group52.service.CourseGoalService;
import com.example.group52.service.CourseSessionService;

@Controller
@RequestMapping("/goals")
public class CourseGoalController {

    private static final Logger log = Logger.getLogger(CourseGoalController.class.getName());

    @Autowired
    private CourseGoalService courseGoalService;

    @Autowired
    private CourseRepository courseRepository;

    @Autowired
    private CourseSessionService courseSessionService;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UserProfileRepository userProfileRepository;

    @GetMapping
    public String viewCalendar(Model model, Principal principal) {
        User currentUser = userRepository.findByUsername(principal.getName()).orElseThrow();
        if (principal == null) {
            return "redirect:/login";
        }
        
        String username = principal.getName();
        List<CourseGoal> userGoals = courseGoalService.getGoalsByUserId(username);
        for (CourseGoal goal : userGoals) {
            String courseIdsStr = goal.getCourseId();
            int totalGoalCourses = 0;
            int totalCompletedCourses = 0;
            long goalTotalSecondsRequired = 0;
            long goalTotalSecondsAccumulated = 0;
            List<GoalCourseInfo> courseInfos = new ArrayList<>();

            if (courseIdsStr != null && !courseIdsStr.isEmpty()) {
                String[] courseIds = courseIdsStr.split(",");
                for (String cidStr : courseIds) {
                    try {
                        int cid = Integer.parseInt(cidStr.trim());
                        Course course = courseRepository.findById(cid).orElse(null);
                        if (course != null) {
                            totalGoalCourses++;
                            long courseRequiredSeconds = course.getDurationMinutes() * 60L;
                            long accumulatedSeconds = courseSessionService.getTotalSecondsForUserCourse(username, String.valueOf(cid));

                            goalTotalSecondsRequired += courseRequiredSeconds;
                            goalTotalSecondsAccumulated += Math.min(accumulatedSeconds, courseRequiredSeconds);

                            if (accumulatedSeconds >= courseRequiredSeconds) {
                                totalCompletedCourses++;
                            }

                            int individualProgress = 0;
                            if (courseRequiredSeconds > 0) {
                                individualProgress = (int) ((Math.min(accumulatedSeconds, courseRequiredSeconds) * 100) / courseRequiredSeconds);
                            }
                            courseInfos.add(new GoalCourseInfo(cid, course.getName(), individualProgress));
                        }
                    } catch (NumberFormatException e) {
                        log.log(Level.WARNING, "Failed to parse course ID when fetching goals: " + cidStr, e);
                    }
                }
            }

            goal.setTotalCoursesCount(totalGoalCourses);
            goal.setCompletedCoursesCount(totalCompletedCourses);
            goal.setAssociatedCourseDetails(courseInfos);

            int calcProgress = 0;
            if (goalTotalSecondsRequired > 0) {
                calcProgress = (int) ((goalTotalSecondsAccumulated * 100) / goalTotalSecondsRequired);
            }
            goal.setCalculatedProgress(calcProgress);
        }

        UserProfile userProfile = userProfileRepository.findByUserId(currentUser.getId());
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("userProfile", userProfile);
        model.addAttribute("userGoals", userGoals);
        
        return "calendar";
    }

    @GetMapping("/api/all")
    @ResponseBody
    public ResponseEntity<List<CourseGoal>> getUserGoals(Principal principal) {
        if (principal == null) {
            return ResponseEntity.status(401).build();
        }
        String userId = principal.getName();
        List<CourseGoal> goals = courseGoalService.getGoalsByUserId(userId);
        return ResponseEntity.ok(goals);
    }

    @PostMapping("/api/save")
    @ResponseBody
    public ResponseEntity<CourseGoal> saveGoal(@RequestBody CourseGoal goal, Principal principal) {
        if (principal == null) {
            return ResponseEntity.status(401).build();
        }
        goal.setUserId(principal.getName());
        CourseGoal savedGoal = courseGoalService.addOrUpdateGoal(goal);
        return ResponseEntity.ok(savedGoal);
    }

    @GetMapping("/api/course-names")
    @ResponseBody
    public ResponseEntity<List<Course>> getCourseNames(@RequestParam String courseIds, Principal principal) {
        if (principal == null) return ResponseEntity.status(401).build();
        if (courseIds == null || courseIds.trim().isEmpty()) {
            return ResponseEntity.ok(java.util.Collections.emptyList());
        }
        List<Integer> ids = java.util.Arrays.stream(courseIds.split(","))
                                        .map(String::trim)
                                        .filter(s -> !s.isEmpty())
                                        .map(Integer::parseInt)
                                        .collect(java.util.stream.Collectors.toList());
        List<Course> courses = (List<Course>) courseRepository.findAllById(ids);
        return ResponseEntity.ok(courses);
    }

    @DeleteMapping("/api/delete/{id}")
    @ResponseBody
    public ResponseEntity<Void> deleteGoal(@PathVariable Long id, Principal principal) {
        if (principal == null) {
            return ResponseEntity.status(401).build();
        }
        courseGoalService.removeGoal(id);
        return ResponseEntity.ok().build();
    }

    @GetMapping("/api/all-courses")
    @ResponseBody
    public ResponseEntity<List<Course>> getAllAvailableCourses(Principal principal) {
        if (principal == null) return ResponseEntity.status(401).build();
        List<Course> courses = (List<Course>) courseRepository.findAll();
        return ResponseEntity.ok(courses);
    }

    @PostMapping("/api/addCourse")
    @ResponseBody
    public ResponseEntity<?> addCourseToGoal(@RequestParam Long goalId, @RequestParam String courseId, Principal principal) {
        if (principal == null) return ResponseEntity.status(401).build();
        List<CourseGoal> goals = courseGoalService.getGoalsByUserId(principal.getName());
        java.util.Optional<CourseGoal> optGoal = goals.stream().filter(g -> g.getId().equals(goalId)).findFirst();
        if (optGoal.isPresent()) {
            CourseGoal g = optGoal.get();
            if (g.getCourseId() == null || g.getCourseId().isEmpty()) {
                g.setCourseId(courseId);
            } else {
                boolean contains = false;
                for (String id : g.getCourseId().split(",")) {
                    if (id.trim().equals(courseId)) contains = true;
                }
                if (!contains) {
                    g.setCourseId(g.getCourseId() + "," + courseId);
                } else {
                    return ResponseEntity.status(409).body("Course is already part of this goal.");
                }
            }
            courseGoalService.addOrUpdateGoal(g);
            return ResponseEntity.ok(g);
        }
        return ResponseEntity.notFound().build();
    }

    @PostMapping("/api/removeCourse")
    @ResponseBody
    public ResponseEntity<?> removeCourseFromGoal(@RequestParam Long goalId, @RequestParam String courseId, Principal principal) {
        if (principal == null) return ResponseEntity.status(401).build();
        List<CourseGoal> goals = courseGoalService.getGoalsByUserId(principal.getName());
        java.util.Optional<CourseGoal> optGoal = goals.stream().filter(g -> g.getId().equals(goalId)).findFirst();
        if (optGoal.isPresent()) {
            CourseGoal g = optGoal.get();
            if (g.getCourseId() != null && !g.getCourseId().isEmpty()) {
                List<String> ids = new java.util.ArrayList<>(java.util.Arrays.asList(g.getCourseId().split(",")));
                ids.removeIf(id -> id.trim().equals(courseId));
                g.setCourseId(String.join(",", ids));
                courseGoalService.addOrUpdateGoal(g);
            }
            return ResponseEntity.ok(g);
        }
        return ResponseEntity.notFound().build();
    }
}
