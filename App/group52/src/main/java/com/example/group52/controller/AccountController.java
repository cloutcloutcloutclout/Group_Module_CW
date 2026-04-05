package com.example.group52.controller;

import com.example.group52.model.User;
import com.example.group52.repository.UserProfileRepository;
import com.example.group52.repository.UserRepository;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;
import java.util.Optional;

@Controller
public class AccountController {

    private final UserRepository userRepository;
    private final UserProfileRepository userProfileRepository;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public AccountController(UserRepository userRepository, UserProfileRepository userProfileRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.userProfileRepository = userProfileRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/account")
    public String account(Principal principal, Model model) {
        User user = userRepository.findByUsername(principal.getName()).orElseThrow();
        model.addAttribute("user", user);
        model.addAttribute("userProfile", user.getUserProfile());

        return "account/viewAccount";
    }

    @GetMapping("/editAccount/{id}")
    public String editAccount(@PathVariable int id, Model model, Principal principal) {
        User currentUser = userRepository.findByUsername(principal.getName()).orElseThrow();

        if (currentUser.getId() != id) {
            return "redirect:/accessDenied";
        }

        model.addAttribute("user", currentUser);
        model.addAttribute("userProfile", currentUser.getUserProfile());
        return "account/editAccount";
    }

    @PostMapping("/editAccount/{id}")
    public String editAccount(@PathVariable int id, @Valid @ModelAttribute("user") User updatedUser, BindingResult result, Model model, Principal principal) {

        User currentUser = userRepository.findByUsername(principal.getName()).orElseThrow();

        if (result.hasErrors()) {
            model.addAttribute("userProfile", currentUser.getUserProfile());
            return "account/editAccount";
        }

        if (updatedUser.getEmail() != null && !updatedUser.getEmail().isEmpty()) {
            Optional<User> userHasEmail = userRepository.findByEmailIgnoreCase(updatedUser.getEmail());
            if (userHasEmail.isPresent() && userHasEmail.get().getId() != id) {
                result.rejectValue("email", "Email", "Email already exists");
            }
        }

        if (updatedUser.getUsername() != null && !updatedUser.getUsername().isEmpty()) {
            Optional<User> userHasUsername = userRepository.findByUsernameIgnoreCase(updatedUser.getUsername());
            if (userHasUsername.isPresent() && userHasUsername.get().getId() != id) {
                result.rejectValue("username", "Username", "Username already exists");
            } else {
                if (updatedUser.getUsername() != null && !updatedUser.getUsername().isEmpty()) {
                    if (!updatedUser.getUsername().matches("[a-zA-Z0-9]+")) {
                        result.rejectValue("username", "UsernameSpecial", "Username has special characters");
                    }
                }

            }
        }


        if (updatedUser.getPasswordHash() != null && !updatedUser.getPasswordHash().isEmpty()) {

            if (updatedUser.getPasswordHash().length() < 8) {
                result.rejectValue("passwordHash", "Length", "Password has to be longer than 8 characters");
            }
        }

        // checks to see that confirmPassword and getPasswordHash is the same to then save changes
        if (updatedUser.getPasswordHash() != null && !updatedUser.getPasswordHash().isEmpty()) {
            if (updatedUser.getConfirmPassword() != null && !updatedUser.getConfirmPassword().isEmpty()) {
                if (!updatedUser.getPasswordHash().equals(updatedUser.getConfirmPassword())) {
                    result.rejectValue("confirmPassword", "Match", "Passwords do not match");
                }
            } else {
                result.rejectValue("confirmPassword", "confirmPasswordEmpty", "Confirmation password needed");
            }
        }

        // checks to see that confirmEmail is the same to the new Email we're setting
        if (updatedUser.getEmail() != null && !updatedUser.getEmail().isEmpty()) {
            if (updatedUser.getConfirmEmail() != null && !updatedUser.getConfirmEmail().isEmpty()) {
                if (!updatedUser.getEmail().equals(updatedUser.getConfirmEmail())) {
                    result.rejectValue("confirmEmail", "EmailMatch", "Email does not match");
                }
            } else {
                result.rejectValue("confirmEmail", "confirmMailEmpty", "Confirmation email needed");
            }
        }

        if (result.hasErrors()) {
            model.addAttribute("userProfile", currentUser.getUserProfile());
            return "account/editAccount";
        }

        // Making sure it's not empty
        if (updatedUser.getUsername() != null && !updatedUser.getUsername().isEmpty()) {
            currentUser.setUsername(updatedUser.getUsername());
        }
        if (updatedUser.getEmail() != null && !updatedUser.getEmail().isEmpty()) {
            currentUser.setEmail(updatedUser.getEmail());
        }

        if (updatedUser.getPasswordHash() != null && !updatedUser.getPasswordHash().isEmpty()) {
            currentUser.setPasswordHash(passwordEncoder.encode(updatedUser.getPasswordHash()));
        }

        userRepository.save(currentUser);

        return "redirect:/login";

    }

    // Model model, Principal Principal


    // deleting an account

    @PostMapping("/deleteAccount/{id}")
    public String deleteAccount(@PathVariable int id, Principal principal, HttpSession session, RedirectAttributes redirectAttributes) {
        User currentUser = userRepository.findByUsername(principal.getName()).orElseThrow();

        if (currentUser.getId() != id) {
            return "redirect:/accessDenied";
        }

        if (currentUser.getGuild() != null) {
            currentUser.getGuild().getMembers().remove(currentUser);
            currentUser.setGuild(null);
        }

        // Delete the user
        userRepository.delete(currentUser);
        session.invalidate();
        redirectAttributes.addAttribute("accountDeleted", "true");

        // This safely redirects to: /login?accountDeleted=true
        return "redirect:/login";
    }
}


