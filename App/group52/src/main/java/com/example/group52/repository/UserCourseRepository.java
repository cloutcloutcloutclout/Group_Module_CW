package com.example.group52.repository;

import com.example.group52.model.UserCourses;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface UserCourseRepository extends CrudRepository <UserCourses,Integer> {

    List<UserCourses> findByUserIdAndCompletedFalse(String userId);
    List<UserCourses> findByUserIdAndCompletedTrue(String userId);
    UserCourses findByUserIdAndCourseId(String userId, String courseId);

    @Query("SELECT uc FROM UserCourses uc WHERE uc.userId = :userId AND uc.completed = false")
    List<UserCourses> findIncompleteCourses(@Param("userId") String userId);

    @Query("SELECT uc FROM UserCourses uc WHERE uc.userId = :userId AND uc.completed = true")
    List<UserCourses> findCompletedCourses(@Param("userId") String userId);

}
