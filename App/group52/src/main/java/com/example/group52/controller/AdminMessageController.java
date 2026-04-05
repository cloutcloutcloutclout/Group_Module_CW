package com.example.group52.controller;

import com.example.group52.model.AdminMessage;
import com.example.group52.model.User;
import com.example.group52.model.UserProfile;
import com.example.group52.repository.UserProfileRepository;
import com.example.group52.repository.UserRepository;
import com.example.group52.service.AdminMessageService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.security.Principal;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminMessageController {

    private final AdminMessageService service;
    private final UserRepository userRepository;
    private final UserProfileRepository userProfileRepository;

    public AdminMessageController(AdminMessageService service, UserRepository userRepository, UserProfileRepository userProfileRepository) {
        this.service = service;
        this.userRepository = userRepository;
        this.userProfileRepository = userProfileRepository;
    }

    @GetMapping("/inbox")
    public String inbox(@RequestParam(value = "id", required = false) Long id, Model model, Principal principal) {
        User currentUser = userRepository.findByUsername(principal.getName()).orElseThrow();
        UserProfile userProfile = userProfileRepository.findByUserId(currentUser.getId());
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("userProfile", userProfile);

        model.addAttribute("messages", service.getTopLevelMessages());
        model.addAttribute("unreadCount",
                service.getTopLevelMessages().stream().filter(m -> "NEW".equals(m.getStatus())).count());
        model.addAttribute("readCount",
                service.getTopLevelMessages().stream().filter(m -> !"NEW".equals(m.getStatus())).count());

        if (id != null) {
            AdminMessage selectedMessage = service.getById(id);
            if (selectedMessage != null && "NEW".equals(selectedMessage.getStatus())) {
                service.markAsRead(selectedMessage.getId());
                selectedMessage = service.getById(id);
            }
            model.addAttribute("selectedMessage", selectedMessage);

                Long rootId = (selectedMessage.getParentId() != null)
                        ? selectedMessage.getParentId()
                        : selectedMessage.getId();

                AdminMessage threadRoot = service.getById(rootId);
                List<AdminMessage> threadReplies = service.getReplies(rootId);

                model.addAttribute("threadRoot", threadRoot);
                model.addAttribute("threadReplies", threadReplies);
            }

        return "admin-messaging/admin-inbox";
    }

    @GetMapping("/compose")
    public String compose() {
        return "admin-messaging/admin-compose";
    }

    @PostMapping("/compose")
    public String save(@RequestParam("message") String message,
                       Principal principal) {
        String username = principal.getName();
        service.saveMessage(username, message);

        return "redirect:/admin/inbox";
    }

    @GetMapping("/reply")
    public String replyForm(@RequestParam("id") Long id, Model model) {
        AdminMessage msg = service.getById(id);

        if (msg == null) {
            return "redirect:/admin/inbox";
        }

        model.addAttribute("msg", msg);
        return "admin-messaging/admin-reply";
    }

    @PostMapping("/reply")
    public String saveReply(@RequestParam("id") Long id,
                            @RequestParam("reply") String reply) {
        AdminMessage msg = service.getById(id);

        if (msg == null) {
            return "redirect:/admin/inbox";
        }

        service.sendReply(id, reply);
        return "redirect:/admin/inbox?id=" + id;
    }

    @PostMapping("/delete")
    public String delete(@RequestParam("id") Long id) {
        service.deleteById(id);
        return "redirect:/admin/inbox";
    }
}