package com.example.group52.model;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;

@Entity
@Table(name = "course_goals")
public class CourseGoal {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String userId;
    private String courseId;
    private String courseName;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern="yyyy-MM-dd")
    private LocalDate startDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern="yyyy-MM-dd")
    private LocalDate targetDate;
    
    private String status;
    private String color;

    @Transient
    private int completedCoursesCount;

    @Transient
    private int totalCoursesCount;

    @Transient
    private int calculatedProgress;

    @Transient
    private java.util.List<GoalCourseInfo> associatedCourseDetails;

    public CourseGoal() {
    }

    public CourseGoal(String userId, String courseId, String courseName, LocalDate startDate, LocalDate targetDate, String status, String color) {
        this.userId = userId;
        this.courseId = courseId;
        this.courseName = courseName;
        this.startDate = startDate;
        this.targetDate = targetDate;
        this.status = status;
        this.color = color;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getCourseId() {
        return courseId;
    }

    public void setCourseId(String courseId) {
        this.courseId = courseId;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public LocalDate getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }

    public LocalDate getTargetDate() {
        return targetDate;
    }

    public void setTargetDate(LocalDate targetDate) {
        this.targetDate = targetDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getFormattedStartDate() {
        if (startDate != null) {
            java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("d MMM yyyy");
            return startDate.format(formatter);
        }
        return "";
    }

    public String getFormattedTargetDate() {
        if (targetDate != null) {
            java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("d MMM yyyy");
            return targetDate.format(formatter);
        }
        return "";
    }

    public String getFormattedStatus() {
        if (status == null) return "";
        if ("IN_PROGRESS".equals(status) && startDate != null && java.time.LocalDate.now().isBefore(startDate)) {
            return "Upcoming";
        }
        switch (status) {
            case "IN_PROGRESS": return "In Progress";
            case "COMPLETED_ON_TIME": return "Completed On Time";
            case "COMPLETED_LATE": return "Completed Late";
            case "COMPLETED": return "Completed";
            case "FAILED": return "Failed";
            default: return status.substring(0, 1).toUpperCase() + status.substring(1).toLowerCase().replace("_", " ");
        }
    }

    public int getProgressPercentage() {
        if (status != null && status.contains("COMPLETED")) {
            return 100;
        }
        if (startDate != null && targetDate != null) {
            LocalDate now = LocalDate.now();
            if (now.isBefore(startDate)) return 0;
            if (now.isAfter(targetDate)) return 100;
            
            long totalDays = java.time.temporal.ChronoUnit.DAYS.between(startDate, targetDate);
            if (totalDays <= 0) return 100;
            long daysPassed = java.time.temporal.ChronoUnit.DAYS.between(startDate, now);
            
            return (int) ((daysPassed * 100) / totalDays);
        }
        return 0;
    }

    public int getCompletedCoursesCount() {
        return completedCoursesCount;
    }

    public void setCompletedCoursesCount(int completedCoursesCount) {
        this.completedCoursesCount = completedCoursesCount;
    }

    public int getTotalCoursesCount() {
        return totalCoursesCount;
    }

    public void setTotalCoursesCount(int totalCoursesCount) {
        this.totalCoursesCount = totalCoursesCount;
    }

    public int getCalculatedProgress() {
        return calculatedProgress;
    }

    public void setCalculatedProgress(int calculatedProgress) {
        this.calculatedProgress = calculatedProgress;
    }

    public java.util.List<GoalCourseInfo> getAssociatedCourseDetails() {
        return associatedCourseDetails;
    }

    public void setAssociatedCourseDetails(java.util.List<GoalCourseInfo> associatedCourseDetails) {
        this.associatedCourseDetails = associatedCourseDetails;
    }
}
