package com.example.group52.repository;

import com.example.group52.model.Review;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface ReviewRepository  extends CrudRepository<Review,Integer> {
    List<Review> findByCourseId(int courseId);

    boolean existsByUserIdAndCourseId(int userId, int courseId );
}
