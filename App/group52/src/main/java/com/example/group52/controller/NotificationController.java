package com.example.group52.controller;

import com.example.group52.model.Notification;

import com.example.group52.repository.NotificationRepository;
import com.example.group52.service.NotificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@RestController
@RequestMapping("/api/notifications")
public class NotificationController {

    @Autowired
    private NotificationService notificationService;

    @Autowired
    private NotificationRepository notificationRepository;

    private final Map<Long, SseEmitter> userEmitters=new ConcurrentHashMap<>();

    @GetMapping("/stream/{id}")
    public SseEmitter streamNoti(@PathVariable Long id){
        SseEmitter emitter=new SseEmitter(Long.MAX_VALUE);

        userEmitters.put(id,emitter);

        emitter.onCompletion(() -> userEmitters.remove(id));
        emitter.onTimeout(()-> userEmitters.remove(id));
        emitter.onError((e)-> userEmitters.remove(id));

        return emitter;


    }


    public void pushToUsr(Long id, Notification notification){
        SseEmitter emitter=userEmitters.get(id);
        if (emitter!=null){
            try {
                emitter.send(SseEmitter.event().data(notification));
            } catch (IOException e) {
                userEmitters.remove(id);
                System.out.println("notification unavailable");
            }
        }
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<?> deleteNotification(@PathVariable Long id){
        try {
            notificationService.deleteNotification(id);
            return ResponseEntity.ok().build();
        }catch (Exception e){
            return ResponseEntity.status(500).body("Cannot delete notification");
        }
    }

    @GetMapping("/{userId}/all")
    public ResponseEntity<List<Notification>> getAllNotifications(@PathVariable Long userId) {
        List<Notification> userNotifications = notificationRepository.findByUserIdOrderByTimeDesc(userId);

        return ResponseEntity.ok(userNotifications);
    }

    @DeleteMapping("{userId}/clear-all")
    public ResponseEntity<?> clearAllNoti(@PathVariable Long userId) {
        try {


            notificationRepository.deleteByUserId(userId);
            return ResponseEntity.ok().body("Notifications cleared");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("unable to clear notifications");
        }
    }


}
