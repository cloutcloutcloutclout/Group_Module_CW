package com.example.group52.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
public class UserCourses {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String CourseName;
    private String CourseCategory;
    @Column(length = 1000)
    private String CourseDescription;
    private String Image;

    private String userId;

    private String courseId;

    @Column(name = "completed")
    private boolean completed = false;

    private LocalDateTime completedDate;

    public LocalDateTime getCompletedDate() {
        return completedDate;
    }

    public void setCompletedDate(LocalDateTime completedDate) {
        this.completedDate = completedDate;
    }

    public String getUserId() {return userId;}

    public boolean isCompleted() {return completed;
    }

    public void setCompleted(boolean completed) {this.completed = completed;
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
        return CourseName;
    }

    public void setCourseName(String courseName) {
        CourseName = courseName;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCourseCategory() {
        return CourseCategory;
    }

    public void setCourseCategory(String courseCategory) {
        CourseCategory = courseCategory;
    }

    public String getCourseDescription() {
        return CourseDescription;
    }

    public void setCourseDescription(String courseDescription) {
        CourseDescription = courseDescription;
    }

    public String getImage() {
        return Image;
    }

    public void setImage(String image) {
        Image = image;
    }
}
