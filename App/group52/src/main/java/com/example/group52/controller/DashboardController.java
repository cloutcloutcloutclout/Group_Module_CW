package com.example.group52.controller;

import java.security.Principal;
import java.time.Duration;
import java.time.Instant;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.group52.model.Course;
import com.example.group52.model.CourseGoal;
import com.example.group52.model.CourseSession;
import com.example.group52.model.GoalCourseInfo;
import com.example.group52.model.User;
import com.example.group52.model.UserBadges;
import com.example.group52.model.UserProfile;
import com.example.group52.repository.CourseRepository;
import com.example.group52.repository.CourseSessionRepository;
import com.example.group52.repository.UserBadgesRepository;
import com.example.group52.repository.UserCourseRepository;
import com.example.group52.repository.UserProfileRepository;
import com.example.group52.repository.UserRepository;
import com.example.group52.service.CourseSessionService;

@Controller
public class DashboardController {

    private static final Logger log = Logger.getLogger(DashboardController.class.getName());

    @Autowired
    private UserCourseRepository userCourseRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UserProfileRepository userProfileRepository;

    @Autowired
    private CourseRepository courseRepository;

    @Autowired
    private CourseSessionRepository courseSessionRepository;

    @Autowired
    private UserBadgesRepository userBadgesRepository;

    @Autowired
    private com.example.group52.service.UserService userService;

    @Autowired
    private com.example.group52.service.CourseGoalService courseGoalService;

    @Autowired
    private CourseSessionService courseSessionService;

    @RequestMapping("/dashboard")
    public String dashboard(Model model, Principal principal) {
        userService.displayUserRank();
        String userId = principal.getName();
        User currentUser = userRepository.findByUsername(principal.getName()).orElseThrow();
        UserProfile userProfile = userProfileRepository.findByUserId(currentUser.getId());

        syncEarnedCourseBadges(currentUser.getUsername());
        List<UserBadges> userBadges = getEarnedBadgesWithRarity(currentUser.getUsername());

        model.addAttribute("currentUser", currentUser);
        model.addAttribute("userProfile", userProfile);
        model.addAttribute("badgeCount", userBadges.size());
        model.addAttribute("userBadges", userBadges);
        model.addAttribute("Courses", userCourseRepository.findAll());
        model.addAttribute("Courses", userCourseRepository.findByUserIdAndCompletedFalse(userId));
        model.addAttribute("completedCourses", userCourseRepository.findByUserIdAndCompletedTrue(userId));
        model.addAttribute("username", currentUser.getFirstName());
        model.addAttribute("rank", currentUser.getUserRank());
        model.addAttribute("points", currentUser.getPoints());
        model.addAttribute("admin", currentUser.getRoles().contains("ADMIN"));

        List<CourseGoal> userGoals = courseGoalService.getGoalsByUserId(currentUser.getUsername());
        for (CourseGoal goal : userGoals) {
            String courseIdsStr = goal.getCourseId();
            int totalGoalCourses = 0;
            int totalCompletedCourses = 0;
            int totalCoursePercentages = 0;
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
                            long accumulatedSeconds = courseSessionService.getTotalSecondsForUserCourse(currentUser.getUsername(), String.valueOf(cid));

                            if (accumulatedSeconds >= courseRequiredSeconds) {
                                totalCompletedCourses++;
                            }

                            int individualProgress = 0;
                            if (courseRequiredSeconds > 0) {
                                individualProgress = (int) ((Math.min(accumulatedSeconds, courseRequiredSeconds) * 100) / courseRequiredSeconds);
                            }
                            totalCoursePercentages += individualProgress;
                            courseInfos.add(new GoalCourseInfo(cid, course.getName(), individualProgress));
                        }
                    } catch (NumberFormatException e) {
                        log.log(Level.WARNING, "Failed to parse course ID for progress calculation: " + cidStr, e);
                    }
                }
            }

            goal.setTotalCoursesCount(totalGoalCourses);
            goal.setCompletedCoursesCount(totalCompletedCourses);
            goal.setAssociatedCourseDetails(courseInfos);

            int calcProgress = 0;
            if (totalGoalCourses > 0) {
                calcProgress = totalCoursePercentages / totalGoalCourses;
            }
            goal.setCalculatedProgress(calcProgress);
        }

        model.addAttribute("userGoals", userGoals);
        return "dashboard/dashboard";
    }

    private void syncEarnedCourseBadges(String currentUsername) {
        Iterable<Course> allCourses = courseRepository.findAll();
        List<CourseSession> userSessions = courseSessionRepository.findByUserIdAndCourseId(currentUsername, null);

        List<CourseSession> allUserSessions = new ArrayList<>();
        courseSessionRepository.findAll().forEach(s -> {
            if (s.getUserId().equals(currentUsername)) {
                allUserSessions.add(s);
            }
        });

        for (Course course : allCourses) {
            String cid = String.valueOf(course.getId());
            long durationSecs = (long) course.getDurationMinutes() * 60;
            if (durationSecs <= 0) continue;

            long timeSpent = 0;
            for (CourseSession s : allUserSessions) {
                if (s.getCourseId().equals(cid)) {
                    timeSpent += s.getAccumulatedSeconds();
                    if (s.getStatus() == CourseSession.SessionStatus.IN_PROGRESS && s.getLastActiveAt() != null) {
                        long delta = Duration.between(s.getLastActiveAt(), Instant.now()).getSeconds();
                        if (delta > 0) timeSpent += delta;
                    }
                }
            }

            if (timeSpent >= durationSecs) {
                if (!userBadgesRepository.existsByUserIdAndBadgeName(currentUsername, course.getName())) {
                    UserBadges newBadge = new UserBadges();
                    newBadge.setBadgeName(course.getName());
                    newBadge.setBadgeImage(course.getImage());
                    newBadge.setBadgeDate(new Date());
                    newBadge.setUserId(currentUsername);
                    userBadgesRepository.save(newBadge);
                }
            }
        }

        List<CourseGoal> userGoals = courseGoalService.getGoalsByUserId(currentUsername);
        for (CourseGoal goal : userGoals) {
            String courseIdsStr = goal.getCourseId();
            if (courseIdsStr != null && !courseIdsStr.isEmpty()) {
                boolean allCompleted = true;
                boolean hasCourses = false;
                String[] courseIds = courseIdsStr.split(",");
                for (String gcId : courseIds) {
                    try {
                        int goalCid = Integer.parseInt(gcId.trim());
                        Course c = courseRepository.findById(goalCid).orElse(null);
                        if (c != null) {
                            hasCourses = true;
                            long requiredSecs = c.getDurationMinutes() * 60L;
                            long accumulatedSecs = courseSessionService.getTotalSecondsForUserCourse(currentUsername, String.valueOf(goalCid));
                            if (accumulatedSecs < requiredSecs) {
                                allCompleted = false;
                                break;
                            }
                        }
                    } catch (NumberFormatException e) {
                        log.log(Level.WARNING, "Failed to parse course ID for goal status sync: " + gcId, e);
                    }
                }

                if (hasCourses) {
                    if (allCompleted && "IN_PROGRESS".equals(goal.getStatus())) {
                        java.time.LocalDate today = java.time.LocalDate.now();
                        if (goal.getTargetDate() != null && !today.isAfter(goal.getTargetDate())) {
                            goal.setStatus("COMPLETED_ON_TIME");
                            courseGoalService.addOrUpdateGoal(goal);

                            java.util.Set<String> thisGoalCourses = new java.util.HashSet<>(java.util.Arrays.asList(goal.getCourseId().split(",")));
                            java.util.Set<String> previouslyCompletedCourses = new java.util.HashSet<>();
                            for (CourseGoal other : userGoals) {
                                if (!other.getId().equals(goal.getId()) && other.getStatus() != null && other.getStatus().startsWith("COMPLETED") && other.getCourseId() != null) {
                                    for (String c : other.getCourseId().split(",")) {
                                        previouslyCompletedCourses.add(c.trim());
                                    }
                                }
                            }

                            int newCoursesCount = 0;
                            for (String cid : thisGoalCourses) {
                                if (!cid.trim().isEmpty() && !previouslyCompletedCourses.contains(cid.trim())) {
                                    newCoursesCount++;
                                }
                            }

                            final int pointsToAward = newCoursesCount * 15;
                            if (pointsToAward > 0) {
                                userRepository.findByUsername(currentUsername).ifPresent(u -> {
                                    u.setPoints(u.getPoints() + pointsToAward);
                                    userRepository.save(u);
                                });
                            }
                        } else {
                            goal.setStatus("COMPLETED_LATE");
                            courseGoalService.addOrUpdateGoal(goal);
                        }
                    } else if (!allCompleted && goal.getStatus() != null && goal.getStatus().startsWith("COMPLETED")) {
                        goal.setStatus("IN_PROGRESS");
                        courseGoalService.addOrUpdateGoal(goal);
                    }
                }
            }
        }
    }

    private List<UserBadges> getEarnedBadgesWithRarity(String currentUsername) {
        long totalUsers = userRepository.count();
        if (totalUsers == 0) totalUsers = 1;

        List<UserBadges> storedBadges = userBadgesRepository.findByUserId(currentUsername);

        for (UserBadges b : storedBadges) {
            long holders = userBadgesRepository.countByBadgeName(b.getBadgeName());
            double rarity = ((double) holders / (double) totalUsers) * 100.0;
            rarity = Math.round(rarity * 10.0) / 10.0;
            b.setRarity(rarity);
        }

        return storedBadges;
    }
}
