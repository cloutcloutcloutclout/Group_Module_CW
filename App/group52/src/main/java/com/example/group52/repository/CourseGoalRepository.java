package com.example.group52.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.group52.model.CourseGoal;

@Repository
public interface CourseGoalRepository extends JpaRepository<CourseGoal, Long> {
    List<CourseGoal> findByUserId(String userId);
    List<CourseGoal> findByUserIdAndStatus(String userId, String status);
    Optional<CourseGoal> findByUserIdAndCourseId(String userId, String courseId);
}
