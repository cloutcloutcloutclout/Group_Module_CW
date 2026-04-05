package com.example.group52.controller;


import com.example.group52.model.Review;
import com.example.group52.service.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/courses")
public class CourseReviewController {

    private final CourseService courseService;

    @Autowired
    public CourseReviewController(CourseService courseService) {
        this.courseService = courseService;
    }

    @PostMapping("/{courseId}/review")
    public String addReview(
            @PathVariable int courseId,
            @RequestParam(required = false) Integer rating, // optional now
            @RequestParam String comment,
            Authentication authentication
    ) {
        if (authentication != null && authentication.isAuthenticated()) {
            String username = authentication.getName();

            // If rating is null (user didn't select stars), you can store 0 or null
            courseService.addReview(courseId, rating != null ? rating : 0, comment, username);
        }

        return "redirect:/courses/details/" + courseId;
    }


    @PostMapping("/reviews/edit")
    public String editReview(@RequestParam int reviewId,@RequestParam String comment,
                             @RequestParam int rating, Authentication authentication) {
        Review review = courseService.getReviewById(reviewId);

        if (!review.getUser().getUsername().equals(authentication.getName())) {
            return "redirect:/courses/details/" + reviewId;
        }

        review.setComment(comment);
        review.setRating(rating);
        courseService.saveReview(review);

        return "redirect:/courses/details/" + review.getCourse().getId();
    }

    @PostMapping("/reviews/delete")
    public String deleteReview(@RequestParam int reviewId, @RequestParam int courseId,
                               Authentication authentication) {
        Review review = courseService.getReviewById(reviewId);

        if (!review.getUser().getUsername().equals(authentication.getName())
                && !authentication.getAuthorities().stream().anyMatch
                (a -> a.getAuthority().equals("ROLE_ADMIN"))) {
            return "redirect:/courses/details/" + courseId;
        }

        courseService.deleteReview(reviewId);

        return "redirect:/courses/details/" + courseId;
    }


}
