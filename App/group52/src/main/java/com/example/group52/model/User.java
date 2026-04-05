package com.example.group52.model;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import jakarta.persistence.*;

@Entity
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) //automatically generates a primary key value
    private int id;
    @Column(unique = true)
    private String username;
    @Column(unique = true)
    private String email;
    private String passwordHash;
    @Transient
    private String confirmPassword;
    @Transient
    private String confirmEmail;
    @Column(nullable = false)
    private String roles;
    @OneToOne(mappedBy = "user", cascade = CascadeType.ALL)
    private UserProfile userProfile;
    private String displayName;
    private String firstName;
    private String lastName;
    private int points; //points scored
    private int userRank; //Users rank on the leaderboard
    @ManyToMany
    @JoinTable(
            name = "user_course",
            joinColumns = @JoinColumn(name = "userId"),
            inverseJoinColumns = @JoinColumn(name = "courseId")
    )
    private List<Course> course;
    private LocalDate lastActivityDate;
    private LocalDateTime time;
    private int currentStreak;
    @OneToMany(mappedBy = "user")
    private List<UserFeedback> feedbacks;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "guild_id")
    private Guild guild;

    private String guildRole = "NONE";
    // MASTER will be the guild owner
    // CAPTAIN will be the middle level
    // ROOKIE is someone who joins and isn't promoted
    // NONE is default



    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public String getRoles() {
        return roles;
    }

    public void setRoles(String roles) {
        this.roles = roles;
    }

    public UserProfile getUserProfile() {
        return userProfile;
    }

    public void setUserProfile(UserProfile userProfile) {
        this.userProfile = userProfile;
    }

    public String getDisplayName() {
        return displayName;
    }

    public void setDisplayName(String displayName) {
        this.displayName = displayName;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public int getPoints() {
        return points;
    }

    public void setPoints(int points) {
        this.points = points;
    }

    public int getUserRank() {
        return userRank;
    }

    public void setUserRank(int userRank) {
        this.userRank = userRank;
    }

    public LocalDate getLastActivityDate() {
        return lastActivityDate;
    }

    public void setLastActivityDate(LocalDate lastActivityDate) {
        this.lastActivityDate = lastActivityDate;
    }

    public LocalDateTime getTime() {
        return time;
    }

    public void setTime(LocalDateTime time) {
        this.time = time;
    }

    public int getCurrentStreak() {
        return currentStreak;
    }

    public void setCurrentStreak(int currentStreak) {
        this.currentStreak = currentStreak;
    }

    public List<UserFeedback> getFeedbacks() {
        return feedbacks;
    }

    public void setFeedbacks(List<UserFeedback> feedbacks) {
        this.feedbacks = feedbacks;
    }

    public String getConfirmPassword() { return confirmPassword; }

    public void setConfirmPassword(String confirmPassword) { this.confirmPassword = confirmPassword; }

    public String getConfirmEmail() { return confirmEmail; }

    public void setConfirmEmail(String confirmEmail) { this.confirmEmail = confirmEmail; }

    public Guild getGuild() {return guild;}
    public void setGuild(Guild guild) {this.guild = guild;}

    public String getGuildRole(){return guildRole;}
    public void setGuildRole(String guildRole){ this.guildRole = guildRole;}

    public List<Course> getCourse() { return course; }

    public void setCourse(List<Course> course) { this.course = course; }

}
