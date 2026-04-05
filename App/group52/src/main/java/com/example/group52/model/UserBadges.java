package com.example.group52.model;

import java.util.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class UserBadges {
    @Id
    @GeneratedValue (strategy = GenerationType.IDENTITY)
    private Integer id;
    private String badgeName;
    private Date badgeDate;
    private String badgeImage;
    private String userId;
    
    @jakarta.persistence.Column(columnDefinition = "int default 1")
    private Integer earnedCount = 1;

    @jakarta.persistence.Transient
    private Double rarity;

    @jakarta.persistence.Transient
    public String getFormattedDate() {
        if (badgeDate == null) return "Unlocked";
        return new java.text.SimpleDateFormat("MMM dd, yyyy").format(badgeDate);
    }

    public Double getRarity() {
        return rarity;
    }

    public void setRarity(Double rarity) {
        this.rarity = rarity;
    }

    @jakarta.persistence.Transient
    public boolean getIsRepeatableBadge() {
        return badgeName != null && (badgeName.contains("Streak") || badgeName.contains("Rank"));
    }

    @jakarta.persistence.Transient
    public String getBadgeCssClass() {
        if ("7-Day Streak Badge".equals(badgeName)) {
            return "badge-streak-7";
        } else if ("15-Day Streak Badge".equals(badgeName)) {
            return "badge-streak-15";
        } else if ("30-Day Streak Badge".equals(badgeName)) {
            return "badge-streak-30";
        } else if ("1st Place Rank Badge".equals(badgeName)) {
            return "badge-rank-1";
        } else if ("2nd Place Rank Badge".equals(badgeName)) {
            return "badge-rank-2";
        } else if ("3rd Place Rank Badge".equals(badgeName)) {
            return "badge-rank-3";
        }
        return "badge-course";
    }

    @jakarta.persistence.Transient
    public String getBadgeDescription() {
        if ("7-Day Streak Badge".equals(badgeName)) {
            return "Awarded for learning 7 days in a row.";
        } else if ("15-Day Streak Badge".equals(badgeName)) {
            return "Awarded for an impressive 15-day learning streak.";
        } else if ("30-Day Streak Badge".equals(badgeName)) {
            return "Awarded for an incredible 30-day learning streak.";
        } else if ("1st Place Rank Badge".equals(badgeName)) {
            return "Awarded for reaching 1st place on the leaderboard.";
        } else if ("2nd Place Rank Badge".equals(badgeName)) {
            return "Awarded for reaching 2nd place on the leaderboard.";
        } else if ("3rd Place Rank Badge".equals(badgeName)) {
            return "Awarded for reaching 3rd place on the leaderboard.";
        }
        return "Awarded for fully completing this learning course.";
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public Integer getEarnedCount() {
        return earnedCount != null ? earnedCount : 1;
    }

    public void setEarnedCount(Integer earnedCount) {
        this.earnedCount = earnedCount;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getBadgeName() {
        return badgeName;
    }

    public void setBadgeName(String badgeName) {
        this.badgeName = badgeName;
    }

    public Date getBadgeDate() {
        return badgeDate;
    }

    public void setBadgeDate(Date badgeDate) {
        this.badgeDate = badgeDate;
    }

    public String getBadgeImage() {
        return badgeImage;
    }

    public void setBadgeImage(String badgeImage) {
        this.badgeImage = badgeImage;
    }
}
