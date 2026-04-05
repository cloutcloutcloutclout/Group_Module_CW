package com.example.group52.service;


import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.group52.model.User;
import com.example.group52.model.UserBadges;
import com.example.group52.model.UserProfile;
import com.example.group52.repository.UserBadgesRepository;
import com.example.group52.repository.UserProfileRepository;
import com.example.group52.repository.UserRepository;

@Service
public class UserService {

    private final UserRepository userRepository;

    @Autowired
    private UserProfileRepository userProfileRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private UserBadgesRepository userBadgesRepository;

    @Autowired
    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public void registerUser(String firstName, String lastName, String username, String password) {
        User user = new User();
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setUsername(username);
        user.setPasswordHash(passwordEncoder.encode(password));
        user.setRoles("USER");
        userRepository.save(user);
    }

    public User registerOAuth2User(String email, String fullName) {
        User user = userRepository.findByUsername(email).orElse(null);

        if(user == null){
            user = new User();
            user.setUsername(email);
            user.setRoles("USER");
            user.setPasswordHash(null);
        }

        if(fullName != null && !fullName.isBlank()) {
            String[] parts = fullName.split(" ", 2);
            user.setFirstName(parts[0]);
            user.setLastName(parts.length > 1 ? parts[1] : "");
        }
        User savedUser = userRepository.save(user);

        if (!userProfileRepository.existsById(savedUser.getId())) {
            UserProfile profile = new UserProfile();
            profile.setUser(savedUser);
            userProfileRepository.save(profile);
        }

        return savedUser;
    }
    public User updateUser(String username, User form) {
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException("Username not found"));

        if(form.getFirstName() != null) user.setFirstName(form.getFirstName());
        if(form.getLastName() != null) user.setLastName(form.getLastName());
        if(form.getPasswordHash() != null && !form.getPasswordHash().isBlank()) {
            user.setPasswordHash(passwordEncoder.encode(form.getPasswordHash()));
        }
        return userRepository.save(user);
    }

    public boolean updatePassword(String username, String newPassword) {
        User user = userRepository.findByUsername(username).orElse(null);
        if (user == null) {
            return false;
        }
        user.setPasswordHash(passwordEncoder.encode(newPassword));
        userRepository.save(user);
        return true;
    }

    public List<User> displayUserRank() {
        List<User> usersList = userRepository.findAll(Sort.by(Sort.Direction.DESC, "points")); //find all users, sort them in descending order of points on leaderboard ranking before giving a rank

        int currentRank = 1;
        Integer lastPoints = null;
        for (int i = 0; i < usersList.size(); i++) { //loop through each user and assign a rank

            User currentUser = usersList.get(i);

            if (lastPoints != null && currentUser.getPoints() < lastPoints) {
                currentRank = i + 1;
            }

            currentUser.setUserRank(currentRank);
            lastPoints = currentUser.getPoints();

            if (userBadgesRepository != null && currentUser.getPoints() > 0) {
                if (currentRank == 1) {
                    awardRankBadge(currentUser, "1st Place Rank Badge", "https://cdn-icons-png.flaticon.com/512/179/179249.png");
                } else if (currentRank == 2) {
                    awardRankBadge(currentUser, "2nd Place Rank Badge", "https://cdn-icons-png.flaticon.com/512/179/179251.png");
                } else if (currentRank == 3) {
                    awardRankBadge(currentUser, "3rd Place Rank Badge", "https://cdn-icons-png.flaticon.com/512/179/179250.png");
                }
            }
        }

        userRepository.saveAll(usersList);

        return usersList;
    }

    private void awardRankBadge(User user, String badgeName, String badgeImage) {
        if (user == null || user.getUsername() == null) return;
        UserBadges existingBadge = userBadgesRepository.findByUserIdAndBadgeName(user.getUsername(), badgeName);
        if (existingBadge == null) {
            UserBadges newBadge = new UserBadges();
            newBadge.setBadgeName(badgeName);
            newBadge.setBadgeImage(badgeImage);
            newBadge.setBadgeDate(new Date());
            newBadge.setUserId(user.getUsername());
            newBadge.setEarnedCount(1);
            userBadgesRepository.save(newBadge);
        } else {
            java.text.SimpleDateFormat fmt = new java.text.SimpleDateFormat("yyyy-MM-dd");
            String todayStr = fmt.format(new Date());
            String badgeEarnedStr = existingBadge.getBadgeDate() != null ? fmt.format(existingBadge.getBadgeDate()) : "";
            
            if (!todayStr.equals(badgeEarnedStr)) {
                int currentCount = existingBadge.getEarnedCount() == null ? 1 : existingBadge.getEarnedCount();
                existingBadge.setEarnedCount(currentCount + 1);
                existingBadge.setBadgeDate(new Date());
                userBadgesRepository.save(existingBadge);
            }
        }
    }

    public long countUsers() {
        return userRepository.count();
    }

}
