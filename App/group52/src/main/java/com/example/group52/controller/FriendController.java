package com.example.group52.controller;

import com.example.group52.repository.UserProfileRepository;
import com.example.group52.repository.UserRepository;
import com.example.group52.service.FriendsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import com.example.group52.model.*;
import org.springframework.web.bind.annotation.PostMapping;

import java.security.Principal;


@Controller
public class FriendController {

    private final UserRepository userRepository;
    private final UserProfileRepository userProfileRepository;
    private final FriendsService friendsService;


    @Autowired
    public FriendController(UserRepository userRepository, UserProfileRepository userProfileRepository, FriendsService friendsService) {
        this.userRepository = userRepository;
        this.userProfileRepository = userProfileRepository;
        this.friendsService = friendsService;
    }

    @GetMapping("/friends/{id}")
    public String friend(@PathVariable Integer id, Model model, Principal principal)
    {
        // finding user, profile
        User currentUser = userRepository.findByUsername(principal.getName()).orElseThrow();
        User ProfileUser = userRepository.findById(id).orElseThrow();
        UserProfile userProfile = userProfileRepository.findByUserId(id);        // saving to model attribute for later
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("userProfile", userProfile);
        model.addAttribute("profileUser", ProfileUser);
        model.addAttribute("friends", friendsService.getFriendsOf(ProfileUser));
        model.addAttribute("incomingRequests", friendsService.getIncomingRequests(currentUser));

        return "friends/friend";

    }

    @PostMapping("/friend/request/{id}")
    public String sendRequest(@PathVariable Integer id, Principal principal) {
        // finds requester by email -> getName email , id
        User requester = userRepository.findByUsername(principal.getName()).orElseThrow();
        // sends request from requester user to responder user by service request
        userRepository.findById(id).ifPresent(responder -> {
            friendsService.sendRequest(requester, responder);
        });
        return "redirect:/findFriends";
    }

    @PostMapping("/friend/accept/{id}")
    public String acceptRequest(@PathVariable Integer id, Principal principal) {
        // finding current user by getName which is email
        User currentUser = userRepository.findByUsername(principal.getName()).orElseThrow();
        // finds both id's and accepts request with currentUser and then the user who sent the request
        // making them connect as a list on the database via Friends model / repository usage
        userRepository.findById(id).ifPresent(other ->
                friendsService.acceptRequest(currentUser, other));
        // refresh
        return "redirect:/friends/" + currentUser.getId();
    }

    @PostMapping("/friend/remove/{id}")
    public String removeFriend(@PathVariable Integer id, Principal principal) {
        // finding current user by getName which is email
        User currentUser = userRepository.findByUsername(principal.getName()).orElseThrow();
        // remove friend removes them from the friends list via database connection
        userRepository.findById(id).ifPresent(other ->
                friendsService.removeFriend(currentUser, other));
        // refreshes to show friend is deleted
        return "redirect:/friends/" + currentUser.getId();
    }

    @GetMapping("/findFriends")
    public String findFriends(Model model, Principal principal) {
        // finding current user by getName which is email
        User currentUser        = userRepository.findByUsername(principal.getName()).orElseThrow();
        // getting useProfile based on currentUser id
        UserProfile userProfile = userProfileRepository.findByUserId(currentUser.getId());        model.addAttribute("currentUser",      currentUser);
        model.addAttribute("userProfile",      userProfile);
        // friendsService.getSuggestions used to find users who aren't in your friends list
        model.addAttribute("users",            friendsService.getSuggestions(currentUser));
        // displays incoming requests from other users - requesters and responders which is the user
        model.addAttribute("incomingRequests", friendsService.getIncomingRequests(currentUser));
        return "friends/findFriends";
    }
}