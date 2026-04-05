package com.example.group52.model;

import java.util.List;
import java.util.StringJoiner;

import jakarta.persistence.*;

@Entity
public class Course {
    @Id
    @GeneratedValue
    private int id;
    private String name;
    @Column(length = 512)
    private String description;
    private String category;
    private String url;
    private List<String> languages;
    private String eligibility;
    private int durationMinutes;
    @OneToMany(mappedBy = "course", cascade = CascadeType.ALL)
    private List<Review> reviews;
    @ManyToMany(mappedBy = "course", fetch = FetchType.LAZY)
    private List<User> user;
    private String image;
    private int enrollmentCount = 0;


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public List<String> getLanguages() {
        return languages;
    }

    public void setLanguages(List<String> languages) {
        this.languages = languages;
    }

    public String formatLanguages() {
        StringJoiner languagesJoiner = new StringJoiner(", ");

        for (String language : languages) {
            languagesJoiner.add(language);
        }

        return languagesJoiner.toString();
    }

    public String getEligibility() {
        return eligibility;
    }

    public void setEligibility(String eligibility) {
        this.eligibility = eligibility;
    }

    public int getDurationMinutes() {
        return durationMinutes;
    }

    public void setDurationMinutes(int durationMinutes) {
        this.durationMinutes = durationMinutes;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getEnrollmentCount() {
        return enrollmentCount;
    }

    public void setEnrollmentCount(int enrollmentCount) {
        this.enrollmentCount = enrollmentCount;
    }


    public String formatDuration() {
        int hours = durationMinutes / 60;
        int minutes = durationMinutes % 60;

        StringBuilder durationStr = new StringBuilder();

        if (hours > 0) {
            durationStr.append(hours).append(" hour");
            if (hours > 1) {
                durationStr.append("s");
            }
            durationStr.append(" ");
        }

        if (minutes > 0) {
            durationStr.append(minutes).append(" minute");
            if (minutes > 1) {
                durationStr.append("s");
            }
        }

        if (durationStr.length() == 0) {
            durationStr.append("0 minutes");
        }

        return durationStr.toString();
    }
}
