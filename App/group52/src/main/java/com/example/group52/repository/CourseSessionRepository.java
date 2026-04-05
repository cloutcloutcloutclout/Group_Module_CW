package com.example.group52.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.repository.CrudRepository;

import com.example.group52.model.CourseSession;
import com.example.group52.model.CourseSession.SessionStatus;

public interface CourseSessionRepository extends CrudRepository<CourseSession, Long> {
    Optional<CourseSession> findByIdAndUserId(Long id, String userId);
    List<CourseSession> findByStatus(SessionStatus status);
    List<CourseSession> findByUserIdAndCourseId(String userId, String courseId);
    void deleteByUserIdAndCourseId(String userId, String courseId);
}
