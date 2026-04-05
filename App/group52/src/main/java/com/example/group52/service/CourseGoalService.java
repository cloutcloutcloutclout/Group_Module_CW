package com.example.group52.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.group52.model.CourseGoal;
import com.example.group52.repository.CourseGoalRepository;

@Service
public class CourseGoalService {

    @Autowired
    private CourseGoalRepository courseGoalRepository;

    public List<CourseGoal> getGoalsByUserId(String userId) {
        return courseGoalRepository.findByUserId(userId);
    }

    public CourseGoal addOrUpdateGoal(CourseGoal goal) {
        return courseGoalRepository.save(goal);
    }

    public void removeGoal(Long goalId) {
        courseGoalRepository.deleteById(goalId);
    }

    public Optional<CourseGoal> getGoalByUserAndCourse(String userId, String courseId) {
        List<CourseGoal> goals = courseGoalRepository.findByUserId(userId);
        return goals.stream().filter(g -> {
            if (g.getCourseId() == null || g.getCourseId().isEmpty()) return false;
            String[] ids = g.getCourseId().split(",");
            for (String id : ids) {
                if (id.trim().equals(courseId)) return true;
            }
            return false;
        }).findFirst();
    }
}
