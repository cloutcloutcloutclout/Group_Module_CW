package com.example.group52.model;

import jakarta.persistence.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import com.fasterxml.jackson.annotation.JsonIgnore;




    @Entity
    public class Notification {
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        private long notificationID;

        private String heading;
        private String notificationMsg;
        private boolean read;
        private String notificationType;
        private LocalDateTime time;

        @ManyToOne
        @JoinColumn(name = "user_id")
        @JsonIgnore
        private User user;

        public Notification(){}
        public Notification(User user, String heading, String notiMessage,LocalDateTime time, boolean read, String notiType) {
            this.heading = heading;
            this.notificationMsg = notiMessage;
            this.time=time;
            this.read = read;
            this.notificationType = notiType;
            this.user = user;
        }


        public User getUser() {
            return user;
        }

        public void setUser(User user) {
            this.user = user;
        }

        public String getNotificationType() {
            return notificationType;
        }

        public void setNotificationType(String notiType) {
            this.notificationType = notiType;
        }

        public boolean isRead() {
            return read;
        }

        public void setRead(boolean read) {
            this.read = read;
        }

        public String getNotificationMsg() {
            return notificationMsg;
        }

        public void setNotificationMsg(String notiMessage) {
            this.notificationMsg = notiMessage;
        }

        public String getHeading() {
            return heading;
        }

        public void setHeading(String heading) {
            this.heading = heading;
        }

        public long getNotificationID() {
            return notificationID;
        }

        public void setNotificationID(long notificationID) {
            this.notificationID = notificationID;
        }

        public LocalDateTime getTime() {
            return time;
        }

        public void setTime(LocalDateTime time) {
            this.time = time;
        }


        }


