package com.example.group52.model;

public class GoalCourseInfo {
    private int courseId;
    private String courseName;
    private int progressPercentage;

    public GoalCourseInfo(int courseId, String courseName, int progressPercentage) {
        this.courseId = courseId;
        this.courseName = courseName;
        this.progressPercentage = progressPercentage;
    }

    public int getCourseId() { return courseId; }
    public String getCourseName() { return courseName; }
    public int getProgressPercentage() { return progressPercentage; }
}
