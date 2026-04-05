package com.example.group52.service;

import com.example.group52.model.Course;
import com.example.group52.model.UserCourses;
import com.example.group52.repository.CourseRepository;
import com.example.group52.repository.UserCourseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class DashboardService {

    @Autowired
    private CourseRepository courseRepository;

    @Autowired
    private UserCourseRepository userCourseRepository;

    public void addCourse(String courseIdStr, String userid) {
        Integer courseId = Integer.parseInt(courseIdStr);

        Course masterCourse = courseRepository.findById(courseId).orElseThrow(() -> new RuntimeException("Course not found"));

        UserCourses existing = userCourseRepository.findByUserIdAndCourseId(userid, courseIdStr);

        if (existing != null) {
            return;
        }

        UserCourses userCourses = new UserCourses();
        userCourses.setUserId(userid);
        userCourses.setCourseId(courseIdStr);
        userCourses.setCourseName(masterCourse.getName());
        userCourses.setCourseCategory(masterCourse.getCategory());
        userCourses.setCourseDescription(masterCourse.getDescription());
        userCourses.setCompleted(false);

        userCourses.setImage(masterCourse.getImage());

        userCourseRepository.save(userCourses);
    }

    public void completeCourse(String courseIdStr, String userid) {
        UserCourses userCourse = userCourseRepository.findByUserIdAndCourseId(userid, courseIdStr);
        if (userCourse != null) {
            userCourse.setCompleted(true);
            userCourse.setCompletedDate(LocalDateTime.now());

            userCourseRepository.save(userCourse);
        }
    }

    public void resetCourse(String courseIdStr, String userid) {
        UserCourses userCourse = userCourseRepository.findByUserIdAndCourseId(userid, courseIdStr);
        if (userCourse != null) {
            userCourseRepository.delete(userCourse);
        }
    }
}
 