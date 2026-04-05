package com.example.group52.service;

import com.example.group52.model.User;
import com.example.group52.repository.UserRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.ZoneId;

@Service
public class StreakService {

    @Autowired
    private UserRepository userRepository;


    @Autowired
    private NotificationService notificationService;


    @Transactional
    public User streakIncrement(int userId, String userTimeZoneId) {
        User user = userRepository.findById(userId).orElseThrow(() -> new RuntimeException("user not found"));


        ZoneId timeZone = ZoneId.of(userTimeZoneId);
        LocalDate today = LocalDate.now(timeZone);
        LocalDate yesterday = today.minusDays(1);
        LocalDate lastActive=user.getLastActivityDate();




        if (lastActive==null){
            user.setCurrentStreak(1);
            user.setLastActivityDate(today);
            notificationService.newUserStreak(user,1);
            return userRepository.save(user);
        }
        else if (lastActive.equals(today)) {
            return user;
        } else if (lastActive.equals(yesterday)) {

            int newStreak = user.getCurrentStreak() + 1;
            user.setCurrentStreak(newStreak);





            if (newStreak==7){
                user.setPoints(user.getPoints()+10);
                notificationService.sendMilestoneNoti(user, 7, 10);
            } else if (newStreak==15){
                user.setPoints(user.getPoints()+20);
                notificationService.sendMilestoneNoti(user, 15, 20);
            }
            else if (newStreak==30){
                user.setPoints(user.getPoints()+50);
                notificationService.sendMilestoneNoti(user, 30, 50);
            }
            else{
                notificationService.sendIncreaseStreak(user, newStreak);
            }user.setLastActivityDate(today);

        } else {
            user.setCurrentStreak(1);
            user.setLastActivityDate(today);
            notificationService.sendStreakReset(user, 1);
        }
            return userRepository.save(user);
        }

}
