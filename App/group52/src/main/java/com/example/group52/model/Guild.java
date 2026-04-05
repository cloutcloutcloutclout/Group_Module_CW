package com.example.group52.model;

import jakarta.persistence.*;

import java.util.ArrayList;
import java.util.List;

@Entity
public class Guild {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // making primary key for guilds
    private int id;
    // guild.id

    @Column(unique = true)
    private String code;
    // https://wall.alphacoders.com/big.php?i=772940
    // https://www.artstation.com/artwork/18brOX
    @Column(unique = true)
    private String guildName;

    private String avatar = "images/dragon-guild.png";

    private String background = "images/guild-background-one.png";

    private String bio;

    private String announcement;

    private String guildPrivacy = "public";
    // public, guildOnly

    private String guildJoinMethod = "public"; // "public" or "private"

    @Transient
    public int getGuildPoints() {
        int total = 0;
        if (this.members != null) {
            for (User member : this.members) {
                total += member.getPoints();
            }
        }
        return total;
    }

    // Guild
    public Guild() {
    }

    // confirmation of deleting guild
    @Transient
    private String confirmGuildName;

    @OneToMany(mappedBy = "guild")
    private List<User> members = new ArrayList<>();
    // Get and setter

    public List<User> getMembers() {return members;}
    public void setMembers(List<User> members) {this.members = members;}

    public int getId() {return id;}
    public void setId(int id) {this.id = id;}

    public String getCode() {return code;}
    public void setCode(String code) {this.code = code;}

    public String getGuildName() {return guildName;}
    public void setGuildName(String guildName) {this.guildName = guildName;}

    public String getAvatar() {return avatar;}
    public void setAvatar(String avatar) {this.avatar = avatar;}

    public String getBackground() {return background;}
    public void setBackground(String background) {this.background = background;}

    public String getBio() {return bio;}
    public void setBio(String bio) {this.bio = bio;}

    public String getAnnouncement() {return announcement;}
    public void setAnnouncement(String announcement) {this.announcement = announcement;}

    public String getGuildPrivacy() {return guildPrivacy;}
    public  void setGuildPrivacy(String guildPrivacy) { this.guildPrivacy = guildPrivacy;}

    public String getConfirmGuildName() {return confirmGuildName;}
    public void setConfirmGuildName(String confirmGuildName){ this.confirmGuildName = confirmGuildName;}

    public String getGuildJoinMethod() {return guildJoinMethod;}
    public void setGuildJoinMethod(String guildJoinMethod) {this.guildJoinMethod = guildJoinMethod;}
}
