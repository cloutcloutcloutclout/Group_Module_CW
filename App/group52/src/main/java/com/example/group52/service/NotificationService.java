package com.example.group52.service;

import com.example.group52.controller.NotificationController;
import com.example.group52.model.Notification;
import com.example.group52.model.User;
import com.example.group52.repository.NotificationRepository;
import com.example.group52.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
public class NotificationService {

    @Autowired
    private NotificationRepository notificationRepository;

    @Autowired
    @Lazy
    private NotificationController notificationController;

    @Autowired
    private UserRepository userRepository;

    public void deleteNotification(Long notificationId){
        notificationRepository.deleteById(notificationId);
    }



//notification which is sent when the user hits the 7,14,30 day milestones
    public void sendMilestoneNoti(User user, int days, int points){
        Notification milestoneNotif = new Notification(user,
                "Streak Milestone! \uD83C\uDF89",
                "You hit a " + days + " day streak! Here is " + points + " points.",
                java.time.LocalDateTime.now(),
                false,
                "streakMilestone");
        milestoneNotif = notificationRepository.save(milestoneNotif);
        notificationController.pushToUsr((long) user.getId(), milestoneNotif);
    }
//milestone for when a user increases their streak
    public void sendIncreaseStreak(User user, int days){
        Notification incrementNoti = new Notification(
                user,
                "Streak increase!",
                "Your streak is now " + days + " days. Keep it up!",
                java.time.LocalDateTime.now(),
                false,
                "streakIncrement"
        );
        incrementNoti = notificationRepository.save(incrementNoti);
        notificationController.pushToUsr((long) user.getId(), incrementNoti);
    }
//notification for when a users streak resets due to missing a streak
    public void sendStreakReset(User user, int days){
        Notification incrementNoti = new Notification(
                user,
                "Streak reset",
                "Your streak has now reset to " + days + " days. Keep coming back to bring it up!",
                java.time.LocalDateTime.now(),
                false,
                "streakReset"
        );
        incrementNoti = notificationRepository.save(incrementNoti);
        notificationController.pushToUsr((long) user.getId(), incrementNoti);
    }
//notification for when a user starts a new streak
    public void newUserStreak(User user, int days){
        Notification incrementNoti = new Notification(
                user,
                "Welcome to streaks!",
                "Your streak is now " + days + " days. Keep coming back to bring it up!",
                java.time.LocalDateTime.now(),
                false,
                "newUserStreak"
        );
        incrementNoti = notificationRepository.save(incrementNoti);
        notificationController.pushToUsr((long) user.getId(), incrementNoti);
    }

    //notification to remind user to complete their streak task before they loose their streak
    public void sendStreakReminder(User user, LocalDate date) {
        Notification reminderNoti=new Notification(
                user,
                "Dont loose your streak",
                "Check out courses before your streak ends",
                date.atTime(18, 0),
                false,
                "StreakReminder"
        );
        reminderNoti=notificationRepository.save(reminderNoti);
        try {
            notificationController.pushToUsr((long) user.getId(), reminderNoti);
        } catch (Exception e) {
            System.err.println("Failed to push streak reminder to User ID " + user.getId() + ": " + e.getMessage());
        }

    }
    //notification which is sent every day to encourage users to have a look at their courses
    public void  sendNewDayNotification(User user, LocalDate date){
        Notification newDayNoti=new Notification(
                user,
                "Time to Level Up!",
                "Your daily learning awaits. Complete a task to update your streak!",
                date.atTime(0,0),
                false,
                "startDay"
        );
        newDayNoti = notificationRepository.save(newDayNoti);
        notificationController.pushToUsr((long) user.getId(), newDayNoti);
    }

    @Scheduled(cron = "0 0 18 * * ?")
    public void eveningStreakNoti() {
        List<User> allUsers = (List<User>) userRepository.findAll();
        LocalDate today = LocalDate.now();

        for (User user : allUsers) {
            if (user.getLastActivityDate() == null || user.getLastActivityDate().isBefore(today)) {
                sendStreakReminder(user,today);

            }
        }
    }
}