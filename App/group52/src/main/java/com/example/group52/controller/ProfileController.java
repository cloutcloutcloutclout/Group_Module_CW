package com.example.group52.controller;

import com.example.group52.model.Friends;
import com.example.group52.model.User;
import com.example.group52.model.UserProfile;
import com.example.group52.repository.FriendsRepository;
import com.example.group52.repository.UserProfileRepository;
import com.example.group52.repository.UserRepository;
import jakarta.validation.Valid;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;

@Controller
public class ProfileController {

    // allowing the controller itself to interact with the database and repositories

    private final UserRepository userRepository;
    private final UserProfileRepository userProfileRepository;
    private final FriendsRepository friendsRepository;

    @Autowired
    public ProfileController(UserRepository userRepository, UserProfileRepository userProfileRepository, FriendsRepository friendsRepository) {
        this.userRepository = userRepository;
        this.userProfileRepository = userProfileRepository;
        this.friendsRepository = friendsRepository;
    }

    @GetMapping("/profile")
    public String myProfile(Principal principal) {
        User user = userRepository.findByUsername(principal.getName()).orElseThrow();
        return "redirect:/profile/" + user.getId();
    }

    @GetMapping("/profile/{id}")
    public String profile(@PathVariable Integer id, Model model, Principal principal) {
        User user = userRepository.findById(id).orElse(null);
        if (user == null) return "redirect:/";

        UserProfile userProfile = userProfileRepository.findByUserId(id);
        if (userProfile == null) return "redirect:/editProfile/" + id;

        User currentUser = userRepository.findByUsername(principal.getName()).orElse(null);

        model.addAttribute("user", user);
        model.addAttribute("userProfile", userProfile);
        model.addAttribute("currentUser", currentUser);

        if (currentUser.getId() != id) {
            if (userProfile.getProfilePrivacy().equals("private")) {
                model.addAttribute("restricted", true);
            } else if (userProfile.getProfilePrivacy().equals("friends")) {
                if (friendsRepository.findByRequesterAndResponderAndStatus(currentUser, user, Friends.Status.APPROVED).isEmpty() &&
                        friendsRepository.findByRequesterAndResponderAndStatus(user, currentUser, Friends.Status.APPROVED).isEmpty()) {
                    model.addAttribute("restricted", true);
                }
            }
        }










        return "profile/profile";
    }

    @GetMapping("/editProfile/{id}")
    public String editProfile(@PathVariable Integer id, Model model, Principal principal) {
        UserProfile profile = userProfileRepository.findByUserId(id);
        if (profile == null) return "redirect:/";

        if (!profile.getUser().getUsername().equals(principal.getName())) {
            return "redirect:/accessDenied";
        }

        User currentUser = userRepository.findByUsername(principal.getName()).orElseThrow();

        model.addAttribute("userProfile", profile);
        model.addAttribute("userId", id); // ← must be here
        model.addAttribute("currentUser", currentUser); // ← add this
        return "profile/editProfile";
    }

    @PostMapping("/editProfile/{id}")
    public String editProfile(@PathVariable Integer id,
                              @Valid @ModelAttribute("userProfile") UserProfile userProfile,
                              BindingResult result,
                              Principal principal) {
        if (result.hasErrors()) return "profile/editProfile";

        UserProfile existingProfile = userProfileRepository.findByUserId(id);
        if (existingProfile == null) return "redirect:/";

        if (!existingProfile.getUser().getUsername().equals(principal.getName())) {
            return "redirect:/accessDenied";
        }

        BeanUtils.copyProperties(userProfile, existingProfile, "id", "user");
        userProfileRepository.save(existingProfile);
        return "redirect:/profile/" + id;
    }

    @GetMapping("/accessDenied")
    public String accessDenied() {
        return "warning/denied";
    }
}

/*
Get -> Post mapping we need Post to update the database
'@ModelAttribute("userProfile") UserProfile userProfile' -> UPDATE by creating new profile

Had help from forums to see that BeanUtils declutters code instead of specific manual code


 */