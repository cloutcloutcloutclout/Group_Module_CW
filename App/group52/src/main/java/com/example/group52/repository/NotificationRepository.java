package com.example.group52.repository;

import com.example.group52.model.Notification;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDateTime;
import java.util.List;

public interface NotificationRepository extends JpaRepository <Notification,Long> {

    List<Notification> findByNotificationTypeAndTimeEquals(String notificationType, LocalDateTime time);
    List<Notification> findByUserId(Long userId);
    List<Notification> findByUserIdOrderByTimeDesc(Long userId);

    @Transactional
    void deleteByUserId(Long userId);

}
