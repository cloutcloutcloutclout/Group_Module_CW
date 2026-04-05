package com.example.group52.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.group52.model.User;
import com.example.group52.model.UserProfile;
import com.example.group52.repository.UserProfileRepository;
import com.example.group52.repository.UserRepository;
import com.example.group52.service.UserService;

import jakarta.validation.Valid;


@Controller
public class LoginController {

    @Autowired
    private UserService userService;
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UserProfileRepository userProfileRepository;


    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        binder.setValidator(new UserValidator(userRepository));
    }

    @GetMapping("/")
    public String home() {
        return "redirect:/login";
    }


    @GetMapping("/register")
    public String register(Model model) {
        model.addAttribute("user", new User());
        return "login/register";
    }

    @PostMapping("/register")
    public String registerUser(@Valid @ModelAttribute User user, BindingResult result,
                               @RequestParam String confirmPassword,
                               RedirectAttributes redirectAttributes) {



        //Check if passwords match
        if (!user.getPasswordHash().equals(confirmPassword)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Passwords do not match");
            return "redirect:/register";
            
        }

        //check for password length
        if (user.getPasswordHash() == null || user.getPasswordHash().length() < 8) {
            redirectAttributes.addFlashAttribute("errorMessage", "Password must be at least 8 characters long");
            return "redirect:/register";
        }

        if (result.hasErrors()) {
            String errorMessage = result.getFieldError("username").getDefaultMessage();
            redirectAttributes.addFlashAttribute("errorMessage", errorMessage);
            return "redirect:/register";
        }

        userService.registerUser(user.getFirstName(), user.getLastName(),
                user.getUsername(), user.getPasswordHash());

        // Create an empty profile for the new user
        User savedUser = userRepository.findByUsername(user.getUsername()).orElse(null);
        if (savedUser != null) {
            UserProfile profile = new UserProfile();
            profile.setUser(savedUser);
            profile.setFirstName(user.getFirstName());
            profile.setLastName(user.getLastName());
            userProfileRepository.save(profile);
        }

        redirectAttributes.addFlashAttribute("successMessage", "Account successfully created!");
        return "redirect:/login";
    }

    @GetMapping("/login")
    public String login() {

        return "login/login";
    }


    @GetMapping("/forgot-password")
    public String forgotPassword() {
        return "login/forgot-password";
    }


    @PostMapping("/forgot-password")
    public String resetPassword(@RequestParam String username, @RequestParam String newPassword,
                                @RequestParam String confirmPassword) {
        if (!newPassword.equals(confirmPassword)) {

            return "redirect:forgot-password?error=mismatch";
        }

        boolean success = userService.updatePassword(username, newPassword);
        if (!success) {

            return "redirect:forgot-password?error=notfound";
        }
        return "redirect:login?reset=success";

    }


    @GetMapping("/welcome")
    public String welcome() {
        return "dashboard/welcome";
    }


    @GetMapping("/admin")
    public String admin() {
        return "dashboard/admin";
    }







    @GetMapping("/success-login")
    public String successLogin(Authentication auth) {
        boolean isAdmin = auth.getAuthorities().stream()
                .anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"));

        return "redirect:/dashboard";
    } 
    @GetMapping("/denied")
    public String denied() {
        return "warning/denied";
    }


}
