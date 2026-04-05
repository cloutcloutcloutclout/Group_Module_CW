package com.example.group52.service;

import com.example.group52.model.Course;
import com.example.group52.model.Review;
import com.example.group52.model.User;
import com.example.group52.repository.CourseRepository;
import com.example.group52.repository.ReviewRepository;
import com.example.group52.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class CourseService {



    private final CourseRepository courseRepository;
    private final ReviewRepository reviewRepository;
    private final UserRepository userRepository;


    @Autowired
    public CourseService(CourseRepository courseRepository,
                         ReviewRepository reviewRepository,
                         UserRepository userRepository) {
        this.courseRepository = courseRepository;
        this.reviewRepository = reviewRepository;
        this.userRepository = userRepository;
    }

    public List<Course> getAllCourses() {
        return courseRepository.findAll();
    }

    public Course getCourseById(int courseId) {
        return courseRepository.findById(courseId)
                .orElseThrow(() -> new RuntimeException("Course not found"));
    }

    public List<Review> getReviewsByCourseId(int courseId) {
        return reviewRepository.findByCourseId(courseId);
    }

    public Review getReviewById(int id) {
        return reviewRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Review not found"));
    }

    public void addReview(int courseId, Integer rating, String comment, String username) {
        Course course = getCourseById(courseId);

        Optional<User> userOpt = userRepository.findByUsername(username);
        if (userOpt.isPresent()) {
            User user = userOpt.get();

            Review review = new Review();
            review.setCourse(course);
            review.setUser(user);
            review.setRating(rating != null ? rating : 0);
            review.setComment(comment);

            reviewRepository.save(review);
        }
    }

    public void saveCourse(Course course) {
        courseRepository.save(course);
    }


    public void saveReview(Review review) {
        reviewRepository.save(review);
    }

    public void deleteCourse(int id) {
        courseRepository.deleteById(id);
    }

    public void deleteReview(int id) {
        reviewRepository.deleteById(id);
    }

    public long countCourses() {
        return courseRepository.count();
    }

    public long countReviews() {
        return reviewRepository.count();
    }
}