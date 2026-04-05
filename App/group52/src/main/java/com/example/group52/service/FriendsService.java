package com.example.group52.service;

import com.example.group52.model.Friends;
import com.example.group52.model.User;
import com.example.group52.repository.FriendsRepository;
import com.example.group52.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class FriendsService {

    private final FriendsRepository friendsRepository;
    private final UserRepository userRepository;

    @Autowired
    public FriendsService(FriendsRepository friendsRepository,  UserRepository userRepository) {
        this.friendsRepository = friendsRepository;
        this.userRepository = userRepository;
    }

    // finds a friendship between two users checking both directions
    public Optional<Friends> findBetween(User a, User b) {
        Optional<Friends> f = friendsRepository.findByRequesterAndResponder(a, b);
        if (f.isPresent()) return f;
        return friendsRepository.findByRequesterAndResponder(b, a);
    }

    // returns all approved friends for a user
    public List<User> getFriendsOf(User user) {
        List<User> friends = new ArrayList<>();

        List<Friends> asRequester = friendsRepository.findByRequesterAndStatus(user, Friends.Status.APPROVED);
        List<Friends> asResponder = friendsRepository.findByResponderAndStatus(user, Friends.Status.APPROVED);

        System.out.println("getFriendsOf: " + user.getUsername());
        System.out.println("asRequester size: " + asRequester.size());
        System.out.println("asResponder size: " + asResponder.size());

        asRequester.forEach(f -> friends.add(f.getResponder()));
        asResponder.forEach(f -> friends.add(f.getRequester()));

        return friends;
    }

    // sends a friend request if one doesn't already exist
    public void sendRequest(User requester, User responder) {
        if (findBetween(requester, responder).isEmpty()) {
            friendsRepository.save(new Friends(requester, responder));
        }
    }

    // accepts a request — only the responder can accept
    public void acceptRequest(User currentUser, User other) {
        findBetween(currentUser, other).ifPresent(f -> {
            if (f.getResponder().getId() == currentUser.getId()) {
                f.setStatus(Friends.Status.APPROVED);
                friendsRepository.save(f);
            }
        });
    }

    // removes or declines a friend
    public void removeFriend(User currentUser, User other) {
        findBetween(currentUser, other).ifPresent(friendsRepository::delete);
    }

    // returns all incoming pending requests for a user
    public List<Friends> getIncomingRequests(User user) {
        return friendsRepository.findByResponderAndStatus(user, Friends.Status.PENDING);
    }

    // returns users with no connection to current user
    public List<User> getSuggestions(User currentUser) {
        List<User> allUsers = userRepository.findByIdNot(currentUser.getId());
        List<User> alreadyConnected = new ArrayList<>();

        allUsers.forEach(u -> {
            if (findBetween(currentUser, u).isPresent()) {
                alreadyConnected.add(u);
            }
        });

        allUsers.removeAll(alreadyConnected);
        return allUsers;
    }

}