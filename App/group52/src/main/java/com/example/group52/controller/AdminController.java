package com.example.group52.controller;


import com.example.group52.model.Course;
import com.example.group52.model.User;
import com.example.group52.model.UserCourses;
import com.example.group52.model.UserProfile;
import com.example.group52.repository.UserCourseRepository;
import com.example.group52.repository.ReviewRepository;
import com.example.group52.repository.UserProfileRepository;
import com.example.group52.repository.UserRepository;
import com.example.group52.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import com.example.group52.service.CourseService;

import java.security.Principal;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private final UserRepository userRepository;
    private final CourseService courseService;
    private final UserService userService;
    private final UserCourseRepository userCourseRepository;
    private final UserProfileRepository userProfileRepository;



    @Autowired
    public AdminController(UserRepository userRepository, CourseService courseService, UserService userService, UserCourseRepository userCourseRepository, UserProfileRepository userProfileRepository) {
        this.userRepository = userRepository;
        this.courseService = courseService;
        this.userService = userService;
        this.userCourseRepository = userCourseRepository;
        this.userProfileRepository = userProfileRepository;
    }

    //create admin dashboard
    @GetMapping("/dashboard")
    public String dashboard( Model model, Principal principal) {

        User currentUser = userRepository.findByUsername(principal.getName()).orElseThrow();
        UserProfile userProfile = userProfileRepository.findByUserId(currentUser.getId());

        List<User> users = (List<User>)  userRepository.findAll();

        model.addAttribute("currentUser", currentUser);
        model.addAttribute("userProfile", userProfile);
        model.addAttribute("users", users);
        model.addAttribute("userCount", userService.countUsers());
        model.addAttribute("courseCount", courseService.countCourses());
        model.addAttribute("reviewCount", courseService.countReviews());

        return "dashboard/admin";
    }

    @GetMapping("/users")
    public String users(Model model, Principal principal) {

        User currentUser = userRepository.findByUsername(principal.getName()).orElseThrow();
        UserProfile userProfile = userProfileRepository.findByUserId(currentUser.getId());

        List<User> users = (List<User>) userRepository.findAll();

        List<User> filteredUsers = users.stream()
                .filter(user -> !user.getRoles().equals("ROLE_ADMIN"))
                .toList();

        model.addAttribute("currentUser", currentUser);
        model.addAttribute("userProfile", userProfile);
        model.addAttribute("users", filteredUsers);

        return "dashboard/user";
    }

    //edit user
    @PostMapping("/users/update")
    public String updateUser(@ModelAttribute User updatedUser) {
        User existingUser = userRepository.findById(updatedUser.getId())
                .orElseThrow(() -> new IllegalArgumentException("Invalid user ID: " + updatedUser.getId()));

        existingUser.setUsername(updatedUser.getUsername());
        existingUser.setEmail(updatedUser.getEmail());

        // Default role if none provided
        if (updatedUser.getRoles() == null || updatedUser.getRoles().isEmpty()) {
            existingUser.setRoles("ROLE_USER");
        } else {
            existingUser.setRoles(updatedUser.getRoles());
        }

        userRepository.save(existingUser);
        return "redirect:/admin/users";
    }

    //delete user
    @PostMapping("/users/delete/{id}")
    public String deleteUser(@PathVariable("id") int id) {

        userRepository.deleteById(id);

        return "redirect:/admin/dashboard";
    }

    //show reviews
    @GetMapping("/reviews/{courseId}")
    public String reviews(@PathVariable int courseId, Model model) {

        model.addAttribute("course", courseService.getCourseById(courseId));
        model.addAttribute("reviews", courseService.getReviewsByCourseId(courseId));
        return "course/adminReview";
    }



    //delete reviews
    @PostMapping("/reviews/delete/{reviewId}")
    public String deleteReview(@PathVariable int reviewId, @RequestParam int courseId) {


        courseService.deleteReview(reviewId);


        return "redirect:/courses/details/" + courseId;
    }

    //manage courses
    @GetMapping("/courses")
    public String manageCourses(Model model, Principal principal) {
        User currentUser = userRepository.findByUsername(principal.getName()).orElseThrow();
        UserProfile userProfile = userProfileRepository.findByUserId(currentUser.getId());
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("userProfile", userProfile);
        model.addAttribute("courses", courseService.getAllCourses());
        return "course/courses";
    }

    //create new course
    @GetMapping("/courses/new")
    public String NewCourse(Model model) {
        model.addAttribute("course", new Course());
        return "course/adminCourse";
    }

    //save the new course
    @PostMapping("/courses/new")
    public String createCourse(@ModelAttribute Course course) {
        courseService.saveCourse(course);
        return "redirect:/admin/courses";
    }

    //edit courses
    @GetMapping("/courses/edit/{id}")
    public String editCourse(@PathVariable int id, Model model) {
        model.addAttribute("course", courseService.getCourseById(id));

        return "course/editCourse";
    }

    //updating course
    @PostMapping("/courses/update")
    public String updateCourse(@ModelAttribute Course updatedCourse) {

        Course existedCourse = courseService.getCourseById(updatedCourse.getId());

        existedCourse.setName(updatedCourse.getName());
        existedCourse.setDescription(updatedCourse.getDescription());
        existedCourse.setCategory(updatedCourse.getCategory());
        existedCourse.setUrl(updatedCourse.getUrl());
        existedCourse.setDurationMinutes(updatedCourse.getDurationMinutes());
        existedCourse.setEligibility(updatedCourse.getEligibility());
        existedCourse.setImage(updatedCourse.getImage());

        courseService.saveCourse(existedCourse);

        return "redirect:/admin/courses";
    }

    @PostMapping("/courses/delete/{id}")
    public String deleteCourse(@PathVariable("id") int id){
        courseService.deleteCourse(id);
        return "redirect:/admin/courses";
    }

    //show users information
    @GetMapping("/user/{id}")
    public String userDetails(@PathVariable int id, Model model) {
        User user = userRepository.findById(id).get();

        // Fetch all courses for this user

        List<UserCourses> registeredCourses = userCourseRepository.findByUserIdAndCompletedFalse(user.getUsername());
        registeredCourses.addAll(userCourseRepository.findByUserIdAndCompletedTrue(user.getUsername()));
        model.addAttribute("user", user);
        model.addAttribute("registeredCourses", registeredCourses);

        System.out.println("Registered courses for user " + user.getId() + ": " + registeredCourses.size());
        for (UserCourses c : registeredCourses) {
            System.out.println(c.getCourseName() + " - completed: " + c.isCompleted());
        }

        return "dashboard/userDetails";
    }

}
