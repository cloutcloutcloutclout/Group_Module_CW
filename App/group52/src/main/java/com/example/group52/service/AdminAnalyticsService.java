package com.example.group52.service;

import com.example.group52.repository.CourseRepository;
import com.example.group52.repository.CourseSessionRepository;
import com.example.group52.repository.UserFeedbackRepository;
import com.example.group52.repository.UserRepository;
import org.springframework.stereotype.Service;
import com.example.group52.repository.UserCourseRepository;
import org.springframework.data.domain.Sort;
import java.util.List;
import com.example.group52.model.User;

@Service
public class AdminAnalyticsService {

    private final UserRepository userRepository;
    private final CourseRepository courseRepository;
    private final CourseSessionRepository courseSessionRepository;
    private final UserFeedbackRepository userFeedbackRepository;
    private final UserCourseRepository userCourseRepository;

    public AdminAnalyticsService(UserRepository userRepository,
                                 CourseRepository courseRepository,
                                 CourseSessionRepository courseSessionRepository,
                                 UserFeedbackRepository userFeedbackRepository,
                                 UserCourseRepository userCourseRepository) {
        this.userRepository = userRepository;
        this.courseRepository = courseRepository;
        this.courseSessionRepository = courseSessionRepository;
        this.userFeedbackRepository = userFeedbackRepository;
        this.userCourseRepository = userCourseRepository;
    }

    public List<User> getTopUsers() {
        return userRepository.findAll(Sort.by(Sort.Direction.DESC, "points"))
                .stream()
                .filter(user -> user.getRoles() != null && !user.getRoles().contains("ADMIN"))
                .limit(5)
                .toList();
    }

    public List<Integer> getActivityData(String range) {
        if ("30".equals(range)) {
            return List.of(3, 5, 4, 6, 8, 7, 9);
        } else if ("all".equals(range)) {
            return List.of(5, 8, 6, 10, 12, 15, 20);
        } else {
            return List.of(1, 2, 1, 3, 2, 4, 5);
        }
    }

    public long getTotalUsers() {
        return userRepository.count();
    }

    public long getTotalCourses() {
        return courseRepository.count();
    }

    public long getTotalSessions() {
        return courseSessionRepository.count();
    }

    public long getTotalFeedback() {
        return userFeedbackRepository.count();
    }

    public long getTotalUserCourses() {
        return userCourseRepository.count();
    }


}