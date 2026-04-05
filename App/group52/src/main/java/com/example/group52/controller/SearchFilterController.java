package com.example.group52.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.example.group52.model.Review;
import com.example.group52.repository.*;
import com.example.group52.model.Review;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;


import com.example.group52.model.Course;
import com.example.group52.model.User;
import com.example.group52.model.UserProfile;
import com.example.group52.repository.CourseRepository;
import com.example.group52.repository.UserCourseRepository;
import com.example.group52.repository.UserProfileRepository;
import com.example.group52.repository.UserRepository;
import com.example.group52.service.DashboardService;
import com.example.group52.repository.ReviewRepository;

@Controller
public class SearchFilterController {

    @Autowired
    private CourseRepository courseRepository;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private UserProfileRepository userProfileRepository;

    @Autowired
    private UserCourseRepository userCourseRepository;

    @Autowired
    private DashboardService dashboardService;

    @Autowired
    private ReviewRepository reviewRepository;


    @GetMapping("/search") //manages get request for the /search endpoint
    public String searchCourse(
            @RequestParam(required = false) String course,   //course parameter
            @RequestParam(required = false) String category,   //category parameter
            @RequestParam(required = false) String sortParam,    //sort parameter
            Model model, Principal principal) {

        if (principal != null) {
            User currentUser = userRepository.findByUsername(principal.getName()).orElse(null);
            model.addAttribute("currentUser", currentUser);
            if (currentUser != null) {
                UserProfile userProfile = userProfileRepository.findByUserId(currentUser.getId());
                model.addAttribute("userProfile", userProfile);
            }
        }
        //new feature: sorting by time
        Sort sortByTime = Sort.unsorted();
        if("asc".equals(sortParam)) { //if statement for when the user wants the results in ascending time to complete the course
            sortByTime = Sort.by(Sort.Direction.ASC, "durationMinutes");
        }else if ("desc".equals(sortParam)) { //if statement for when the user wants the results in descending time to complete the course
            sortByTime = Sort.by(Sort.Direction.DESC, "durationMinutes");
        }


        List<Course> list; //if a search keyword is provided then the course will be fetched from the database
        if (course != null && !course.isEmpty()) {
            list = courseRepository.findByNameContainingIgnoreCase(course, sortByTime);
        } else { //if there is no courses being searched it will just give all the courses
            list = courseRepository.findAll(sortByTime);
        }

        //filter for the dropdown menu of course categories
        if (category !=null && !category.isEmpty()) {
            List<Course> searchedList = new ArrayList<>(); //creates a new array list to store courses


            for (Course co : list) {
                if (co.getCategory() != null && co.getCategory().equals(category)) {
                    searchedList.add(co);//checks if course category matches with the requested category string it will be displayed to the user
                }
            }
            list = searchedList;
        }





        Map<Integer, Double> courseRatings = new HashMap<>();

        for (Course c : list) {
            List<Review> reviews = reviewRepository.findByCourseId(c.getId());

            double avg;
            if (!reviews.isEmpty()) {
                avg = reviews.stream().mapToDouble(review -> review.getRating()).average().orElse(0);
                avg = Math.round(avg);
            } else {
                avg = (int) (Math.random() * 5) + 1;
            }
            courseRatings.put(c.getId(), avg);
        }

            model.addAttribute("courses", list);

        for (Course c : list) {
            List<Review> reviews = reviewRepository.findByCourseId(c.getId());

            double avg;
            if (!reviews.isEmpty()) {
                avg = reviews.stream()
                        .mapToDouble(review -> review.getRating())
                        .average()
                        .orElse(0);
                avg = Math.round(avg);
            } else {
                avg = (int)(Math.random() * 5) + 1;
            }

            courseRatings.put(c.getId(), avg);
        }
        //Add the trending courses to the model to be displayed in the searchpage.jsp
        List<Course> trendingCourses3=courseRepository.findTop3ByOrderByEnrollmentCountDesc();

        model.addAttribute("trendingCourses3",trendingCourses3);
        model.addAttribute("courses", list);
        model.addAttribute("courseRatings", courseRatings);
        return "search/searchpage";
    }






}

