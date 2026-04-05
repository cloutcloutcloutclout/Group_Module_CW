package com.example.group52.model;

import jakarta.persistence.*;

@Entity
public class UserProfile {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String profilePrivacy = "public";

    private String avatar = "https://static.vecteezy.com/system/resources/previews/024/766/958/non_2x/default-male-avatar-profile-icon-social-media-user-free-vector.jpg";
    private String background = "https://static.vecteezy.com/system/resources/previews/010/481/742/non_2x/light-and-dark-background-random-minimalist-abstract-illustration-for-logo-card-banner-web-and-printing-free-vector.jpg";

    private String firstName;
    private String lastName;

    private String pronoun;
    private String pronunciation;
    private String bio;
    private String status;
    private String location;

    // removed the list string because it gives too many errors
    // adding individual stuff
    private String linkedIn;
    private String ibm;
    private String github;

    private String website;
    private String contactEmail;

    // trying to link User and UserProfile here *test*

    @OneToOne
    @JoinColumn
    private User user;

    public UserProfile() {}


    // Get/Set methods

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getProfilePrivacy() {
        return profilePrivacy;
    }

    public void setProfilePrivacy(String profilePrivacy) {
        this.profilePrivacy = profilePrivacy;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getBackground() {
        return background;
    }

    public void setBackground(String background) {
        this.background = background;
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

    public String getPronoun() {
        return pronoun;
    }

    public void setPronoun(String pronoun) {
        this.pronoun = pronoun;
    }

    public String getPronunciation() {
        return pronunciation;
    }

    public void setPronunciation(String pronunciation) {
        this.pronunciation = pronunciation;
    }

    public String getBio() {
        return bio;
    }

    public void setBio(String bio) {
        this.bio = bio;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }

    public String getContactEmail() {
        return contactEmail;
    }

    public void setContactEmail(String contactEmail) {
        this.contactEmail = contactEmail;
    }

    public User getUser() {
        return user;
    }
    public void setUser(User user) {
        this.user = user;
    }

    public String getLinkedIn() {
        return linkedIn;
    }
    public void setLinkedIn(String linkedIn) {
        this.linkedIn = linkedIn;
    }

    public String getIbm() {
        return ibm;
    }

    public void setIbm(String ibm) {
        this.ibm = ibm;
    }

    public String getGithub() {
        return github;
    }

    public void setGithub(String github) {
        this.github = github;
    }


}