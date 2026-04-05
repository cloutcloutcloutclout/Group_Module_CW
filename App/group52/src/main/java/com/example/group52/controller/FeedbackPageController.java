package com.example.group52.controller;

import java.security.Principal;

import com.example.group52.service.AdminMessageService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.group52.model.User;
import com.example.group52.model.UserFeedback;
import com.example.group52.model.UserProfile;
import com.example.group52.repository.UserProfileRepository;
import com.example.group52.repository.UserRepository;
import com.example.group52.service.UserFeedbackService;
import com.example.group52.model.AdminMessage;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/feedback")
public class FeedbackPageController {

    private final AdminMessageService adminMessageService;
    private final UserFeedbackService feedbackService;
    private final UserRepository userRepository;
    private final UserProfileRepository userProfileRepository;

    public FeedbackPageController(UserFeedbackService feedbackService,
                                  UserRepository userRepository,
                                  UserProfileRepository userProfileRepository,
                                  AdminMessageService adminMessageService) {
        this.feedbackService = feedbackService;
        this.userRepository = userRepository;
        this.userProfileRepository = userProfileRepository;
        this.adminMessageService = adminMessageService;
    }

    // Show feedback page
    @GetMapping
    public String showFeedbackPage(@RequestParam(required = false) Boolean success,
                                   @RequestParam(required = false) Boolean error,
                                   Model model,
                                   Principal principal) {

        if (success != null && success) model.addAttribute("success", true);
        if (error != null && error) model.addAttribute("error", true);

        if (principal != null) {
            User currentUser = userRepository.findByUsername(principal.getName()).orElse(null);
            String username = principal.getName();
            List<AdminMessage> userMessages = adminMessageService.getTopLevelMessagesBySender(username);
            Map<Long, List<AdminMessage>> replyMap = new HashMap<>();

            for (AdminMessage msg : userMessages) {
                replyMap.put(msg.getId(), adminMessageService.getReplies(msg.getId()));
            }

            model.addAttribute("userMessages", userMessages);
            model.addAttribute("replyMap", replyMap);
            model.addAttribute("currentUser", currentUser);
            if (currentUser != null) {
                UserProfile userProfile = userProfileRepository.findByUserId(currentUser.getId());
                model.addAttribute("userProfile", userProfile);
            }
        }

        return "feedback/feedback"; // feedback.jsp
    }

    @PostMapping("/reply")
    public String replyToAdmin(@RequestParam("parentId") Long parentId,
                               @RequestParam("message") String message,
                               Principal principal) {

        if (principal == null) {
            return "redirect:/login";
        }

        if (message == null || message.trim().isEmpty()) {
            return "redirect:/feedback?error=true";
        }

        String username = principal.getName();

        adminMessageService.saveReplyMessage(principal.getName(), message.trim(),parentId);

        return "redirect:/feedback?success=true";
    }

    @PostMapping("/delete")
    public String deleteFeedbackMessage(@RequestParam("id") Long id,
                                        Principal principal) {
        if (principal == null) {
            return "redirect:/login";
        }

        AdminMessage msg = adminMessageService.getById(id);

        if (msg != null && msg.getSender() != null && msg.getSender().equals(principal.getName())) {
            adminMessageService.deleteMessage(id);
        }

        return "redirect:/feedback";
    }


    // Handle feedback submit
    @PostMapping("/submit")
    public String submitFeedback(@RequestParam(value = "message", required = false) String message,
                                 Principal principal) {

        // must be logged in
        if (principal == null) {
            return "redirect:/login";
        }

        if (message == null || message.trim().isEmpty()) {
            return "redirect:/feedback?error=true";
        }

        try {
            String username = principal.getName(); // will be "user" if using generated password

            // Find user in DB, or CREATE if missing
            User user = userRepository.findByUsername(username).orElse(null);

            if (user == null) {
                user = new User();
                user.setUsername(username);
                user = userRepository.save(user);
            }

            UserFeedback feedback = new UserFeedback();
            feedback.setUser(user);
            feedback.setMessage(message.trim());

            feedbackService.submitFeedback(feedback);
            adminMessageService.saveMessage(username, message.trim());

            return "redirect:/feedback?success=true";

        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/feedback?error=true";
        }
    }
}
