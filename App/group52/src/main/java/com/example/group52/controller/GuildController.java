package com.example.group52.controller;

import com.example.group52.model.Guild;
import com.example.group52.model.User;
import com.example.group52.model.UserProfile;
import com.example.group52.repository.FriendsRepository;
import com.example.group52.repository.GuildRepository;
import com.example.group52.repository.UserProfileRepository;
import com.example.group52.repository.UserRepository;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.validation.BindingResult;

import java.util.Optional;
import java.util.regex.*;
import java.util.UUID;
import java.security.Principal;
import java.util.List;

@Controller
public class GuildController {

    private final UserRepository userRepository;
    private final UserProfileRepository userProfileRepository;
    private final FriendsRepository friendsRepository;
    private final GuildRepository guildRepository;

    @Autowired
    public GuildController(UserRepository userRepository, UserProfileRepository userProfileRepository, FriendsRepository friendsRepository, GuildRepository guildRepository) {
        this.userRepository = userRepository;
        this.userProfileRepository = userProfileRepository;
        this.friendsRepository = friendsRepository;
        this.guildRepository = guildRepository;
    }

    /*
    /guilds will be for finding guilds, needs to show member count
    guilds will have their own edit guild page and guildProfile
    needs post mapping here
     */

    @GetMapping("/guilds")
    public String guilds(Model model, Principal principal)
    {
        // currentUser
        User currentUser = userRepository.findByUsername(principal.getName()).orElseThrow();
        UserProfile userProfile = userProfileRepository.findByUserId(currentUser.getId());
        // listing every guild on guilds
        List<Guild> everyGuild = guildRepository.findAll();
        // new guild method then I'll will put it int @Valid @ModelAttribute?
        Guild guild = new  Guild();
        // Attributes
        model.addAttribute("everyGuild", everyGuild);
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("guild", guild);
        model.addAttribute("userProfile", userProfile);

        return "guilds/findguild";
    }

    @PostMapping("/guilds/create")
    public String  createGuild(@Valid @ModelAttribute("guild") Guild newGuild, BindingResult result, Model model, Principal principal) {
        // currentUser model
        User currentUser = userRepository.findByUsername(principal.getName()).orElseThrow();
        // if results have errors

        if (newGuild.getGuildName() == null || newGuild.getGuildName().isEmpty()) {
            result.rejectValue("guildName", "EmptyName", "Guild's name cannot be empty");
        } else {
            if (guildRepository.findByGuildNameIgnoreCase(newGuild.getGuildName()).isPresent()) {
                result.rejectValue("guildName", "nameExist", "Guild's name already exists");
            }
            if (!newGuild.getGuildName().matches("[a-zA-Z0-9]+")) {
                result.rejectValue("guildName", "guildName.special", "Guild name cannot contain special characters");
            }
            if (currentUser.getGuild() != null){
                result.rejectValue("guildName", "alreadyIn", "User already in Guild, leave to create");
            }
        }

        if (result.hasErrors()) {
            model.addAttribute("currentUser", currentUser);
            model.addAttribute("everyGuild", guildRepository.findAll());
            return "guilds/findguild";
            }


        // Java util Random UUID, creates a unique identifier
        // Replacing hyphens '-' to " " blank, and making it only 6 characters in length so its easier
        String code = UUID.randomUUID().toString().replace("-", "").substring(0, 8);

        //Save Guild
        Guild guild = new Guild();
        guild.setGuildName(newGuild.getGuildName());
        guild.setCode(code);
        guild.setGuildPrivacy("public");
        guild.setGuildJoinMethod("public");
        guildRepository.save(guild);
        //Save User
        currentUser.setGuild(guild);
        currentUser.setGuildRole("MASTER");
        guild.getMembers().add(currentUser);
        userRepository.save(currentUser);


        return "redirect:/guild/" + guild.getGuildName();
    }

    @PostMapping("/guilds/join")
    public String guildJoin(@Valid @ModelAttribute("guild") Guild joinGuild, BindingResult result, Principal principal, Model model){
        // Model
        User currentUser = userRepository.findByUsername(principal.getName()).orElseThrow();

        if (joinGuild.getCode() == null || joinGuild.getCode().isEmpty()) {
            result.rejectValue("code", "emptyCode", "Enter a code to join");
        } else {
            Guild guild = guildRepository.findByCode(joinGuild.getCode()).orElse(null);
            if (guild == null) {
                result.rejectValue("code", "emptyGuild", "No Guild with this code exists");
            } else if (currentUser.getGuild() != null) {
                result.rejectValue("code", "alreadyInGuild", "User already in guild");
            } else if (userRepository.findByGuild(guild).size() >= 8) {
                result.rejectValue("code", "guildFull", "This guild is full");
            } else {
                currentUser.setGuild(guild);
                currentUser.setGuildRole("ROOKIE");
                userRepository.save(currentUser);
                return "redirect:/guild/" + guild.getGuildName();
            }
        }

        // Last error check
        if (result.hasErrors()) {
            model.addAttribute("currentUser", currentUser);
            model.addAttribute("everyGuild", guildRepository.findAll());
            return "guilds/findguild";
        }
        // redirect instead of new url
        return "redirect:/guilds";
    }


    @PostMapping("/guild/join/public/{guildName}")
    public String joinPublicGuild(@PathVariable String guildName, Model model, Principal principal)
    {
        User currentUser = userRepository.findByUsername(principal.getName()).orElseThrow();
        Guild guild = guildRepository.findByGuildName(guildName).orElse(null);

        // guild exist or throw null
        if (guild == null) {
            return "redirect:/guilds";
        }

        // Logic

        boolean isPublic = "Public".equalsIgnoreCase(guild.getGuildJoinMethod());
        int memberCount = userRepository.findByGuild(guild).size();
        // public check
        if (!isPublic){
            return "redirect:/guild/" + guildName;
        }
        // guild check
        if (currentUser.getGuild() != null) {
            return "redirect:/guild/" + guildName;
        }
        // member count check
        if (memberCount >= 8){
            return "redirect:/guild/" + guildName;
        }

        // if it passes these checks then they'll join the guild
        currentUser.setGuild(guild);
        currentUser.setGuildRole("ROOKIE");
        userRepository.save(currentUser);

        return "redirect:/guild/" + guild.getGuildName();
    }

/*
    guild owner can receive requests from people who want to join guild? -> code can then be given to people they actually want via Friends or some
    other form of contact
 */
    /*
    guild will show the guild stuff
    need post mapping here
     */

    // a guilds homepage
    @GetMapping("/guild/{guildName}")
    public String guild(@PathVariable String guildName, Model model, Principal principal)
    {
        // Finding Guild by guild id, Current User declaration
        Guild guild = guildRepository.findByGuildName(guildName).orElse(null);
        User currentUser = userRepository.findByUsername(principal.getName()).orElseThrow();

        // creating model attributes
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("guild", guild);

        // Privacy from friendController
        boolean isMember = guild.equals(currentUser.getGuild());

        if (!isMember) {
            // guildOnly make it restricted
            if ("guildOnly".equalsIgnoreCase(guild.getGuildPrivacy())) {
                model.addAttribute("restricted", true);
            }
        }

        // adding the members list only if not restricted
        if (model.getAttribute("restricted") == null) {
            List<User> members = userRepository.findByGuild(guild);
            model.addAttribute("members", members);
        }
        return "guilds/guildhome";
    }

    // editing a guilds information and style
    @GetMapping("/editGuild/{guildName}")
    public String editGuild(@PathVariable String guildName, Model model, Principal principal) {
        Guild guild = guildRepository.findByGuildName(guildName).orElse(null);
        // error catching
        if (guild == null) return "redirect:/guilds";

        // Making the currentUser declared for the if statement
        User currentUser = userRepository.findByUsername(principal.getName()).orElseThrow();

        // MASTER ROLE is only able to edit the guild since they're the owner of the guild
        if (!"MASTER".equals(currentUser.getGuildRole()) || !guild.equals(currentUser.getGuild())) {
            return "redirect:/accessDenied";
        }

        // Member list for form
        List<User> members = userRepository.findByGuild(guild);
        model.addAttribute("members", members);
        // Models for user and guild to be passed
        model.addAttribute("guild", guild);
        model.addAttribute("currentUser", currentUser);
        return "guilds/editGuild";
    }


    // post of editing a guilds information / styles
    @PostMapping("/editGuild/{guildName}")
    public String editGuild(@PathVariable String guildName, @Valid @ModelAttribute("guild") Guild updatedGuild, BindingResult result, Model model, Principal principal) {
        // Declaring currentGuild and user
        User currentUser = userRepository.findByUsername(principal.getName()).orElseThrow();
        Guild existingGuild = guildRepository.findByGuildName(guildName).orElse(null);
        // error catch
        if (existingGuild == null) return "redirect:/guilds";

        // Only Master is able to edit the guilds information -> cant be captain since they're below in authority
        if (!"MASTER".equals(currentUser.getGuildRole()) || !existingGuild.equals(currentUser.getGuild())) {
            return "redirect:/accessDenied";
        }

        // Same if statements to accountController for guildName
        // Guild name validation to check its not empty
        if (updatedGuild.getGuildName() == null || updatedGuild.getGuildName().isEmpty()) {
            result.rejectValue("guildName", "EmptyName", "Guild name cannot be empty");
        } else {
            // Check duplicate only if name has changed -> same as accountController
            if (!updatedGuild.getGuildName().equalsIgnoreCase(existingGuild.getGuildName()) &&
                    guildRepository.findByGuildNameIgnoreCase(updatedGuild.getGuildName()).isPresent()) {
                result.rejectValue("guildName", "nameExist", "A guild with this name already exists");
            } // checks for regular expressions, here is special characters
            if (!updatedGuild.getGuildName().matches("[a-zA-Z0-9 ]+")) {
                result.rejectValue("guildName", "guildSpecial", "Guild name cannot contain special characters");
            }
        }
        // error catcher to redirect back to edit
        if (result.hasErrors()) {
            model.addAttribute("currentUser", currentUser);
            model.addAttribute("guild", existingGuild); // Keep the original guild data for the form
            model.addAttribute("members", userRepository.findByGuild(existingGuild)); // Re-add members!
            return "guilds/editGuild";
        }

        // Update fields which were filled in only or selected like the avatar etc, same to profile controller
        if (updatedGuild.getGuildName() != null && !updatedGuild.getGuildName().isEmpty()) {
            existingGuild.setGuildName(updatedGuild.getGuildName());
        }
        if (updatedGuild.getBio() != null && !updatedGuild.getBio().isEmpty()) {
            existingGuild.setBio(updatedGuild.getBio());
        }
        if (updatedGuild.getAnnouncement() != null && !updatedGuild.getAnnouncement().isEmpty()) {
            existingGuild.setAnnouncement(updatedGuild.getAnnouncement());
        }
        if (updatedGuild.getAvatar() != null && !updatedGuild.getAvatar().isEmpty()) {
            existingGuild.setAvatar(updatedGuild.getAvatar());
        }
        if (updatedGuild.getBackground() != null && !updatedGuild.getBackground().isEmpty()) {
            existingGuild.setBackground(updatedGuild.getBackground());
        }

        // Update privacy field
        if (updatedGuild.getGuildPrivacy() != null) {
            existingGuild.setGuildPrivacy(updatedGuild.getGuildPrivacy());
        }
        // guild join method
        if (updatedGuild.getGuildJoinMethod() != null) {
            existingGuild.setGuildJoinMethod(updatedGuild.getGuildJoinMethod());
        }

        model.addAttribute("members", userRepository.findByGuild(existingGuild));

        // saves all the changes and redirects you back to the guilds homepage
        guildRepository.save(existingGuild);
        return "redirect:/guild/" + existingGuild.getGuildName();
    }

    // PostMapping to leave guild if you are ROOKIE or CAPTAIN , NOT MASTER
    @PostMapping("leave/{guildName}")
    public String leaveGuild(@PathVariable String guildName, Model model, Principal principal) {
        User currentUser = userRepository.findByUsername(principal.getName()).orElseThrow();
        Guild existingGuild = guildRepository.findByGuildName(guildName).orElse(null);

        // if guild is null redirect to guilds
        if (existingGuild == null) return "redirect:/guilds";

        // user needs to be in guild
        if (!existingGuild.equals(currentUser.getGuild())) {
            return "redirect:/guild/" + existingGuild.getGuildName();
        }
        // If the person leaving is master they can't leave
        if ("MASTER".equals(currentUser.getGuildRole()))
        {
            return "redirect:/guild/" + existingGuild.getGuildName();
        }

        currentUser.setGuild(null);
        currentUser.setGuildRole("NONE");
        userRepository.save(currentUser);

        return "redirect:/guilds";
    }

// Promoting a user using postMapping
    @PostMapping("/guild/{guildName}/promote/{id}")
    public String promotion(@PathVariable String guildName, @PathVariable int id, Model model, Principal principal) {
        // Declaring
        User currentUser = userRepository.findByUsername(principal.getName()).orElseThrow();
        Guild existingGuild = guildRepository.findByGuildName(guildName).orElse(null);

        // If guild null return to guilds
        if (existingGuild == null) return "redirect:/guilds";

        // Only master can promote
        if (!"MASTER".equals(currentUser.getGuildRole()) || !existingGuild.equals(currentUser.getGuild())) {
            return "redirect:/guild/" + existingGuild.getGuildName();
        }

        // Declaring the target user to promote
        User targUser = userRepository.findById(id).orElse(null);
        // TargetRole
        String targRole = targUser.getGuildRole();

        // Same guild or throw

        if (!existingGuild.equals(targUser.getGuild())) {
            return "redirect:/guild/" + guildName;
        }

        // targUser check null

        if (targUser == null) return "redirect:/guild/" + existingGuild.getGuildName();


        // Making a rookie into a captain
        if ("ROOKIE".equals(targRole)) {
            targUser.setGuildRole("CAPTAIN");
            userRepository.save(targUser);
        } else if ("CAPTAIN".equals(targRole)) {
            // Transferring ownership of the guild
            currentUser.setGuildRole("CAPTAIN");
            targUser.setGuildRole("MASTER");
            userRepository.save(currentUser);
            userRepository.save(targUser);
        }

        return "redirect:/guild/" + existingGuild.getGuildName();
    }


// Code for deleting controller, needs to validate that the guild MASTER is the only one able to delete it
    // Maybe a method to promote a guild member as well in the same page


    @PostMapping("/delete/{guildName}")
    public String deleteGuild(@PathVariable String guildName, @Valid @ModelAttribute("guild") Guild guild, BindingResult result,Model model, Principal principal)
    {
        User currentUser = userRepository.findByUsername(principal.getName()).orElseThrow();
        Guild existingGuild = guildRepository.findByGuildName(guildName).orElse(null);

        if (existingGuild == null) {
            return "redirect:/guilds";
        }

        if (!"MASTER".equals(currentUser.getGuildRole()) || !existingGuild.equals(currentUser.getGuild())) {
            return "redirect:/accessDenied";
        }

        if (guild.getConfirmGuildName() == null || guild.getConfirmGuildName().isEmpty()) {
            result.rejectValue("confirmGuildName", "EmptyCFName", "Confirm name cannot be empty");
        } else if (!guild.getConfirmGuildName().equals(existingGuild.getGuildName())) {
            result.rejectValue("confirmGuildName","MismatchGuildName", "Guild names aren't the same");
        }

        if (result.hasErrors()) {
            model.addAttribute("currentUser", currentUser);
            model.addAttribute("guild", existingGuild);
            model.addAttribute("members", userRepository.findByGuild(existingGuild));
            return "guilds/editGuild";
        }

        List<User> members = userRepository.findByGuild(existingGuild);
        for (User member : members){
            member.setGuild(null);
            member.setGuildRole("NONE");
            userRepository.save(member);
        }

        guildRepository.delete(existingGuild);
        return "redirect:/guilds";
    }



    @PostMapping("/guild/{guildName}/kick/{id}")
    public String kickMember(@PathVariable String guildName, @PathVariable int id, Model model, Principal principal){
        User currentUser = userRepository.findByUsername(principal.getName()).orElseThrow();
        Guild existingGuild = guildRepository.findByGuildName(guildName).orElse(null);

        // Error checks
        if (existingGuild == null) return "redirect:/guilds";
        if (!"MASTER".equals(currentUser.getGuildRole()) || !existingGuild.equals(currentUser.getGuild())) {
            return "redirect:/guild/" + guildName;
        }

        // Target User
        User targetUser = userRepository.findById(id).orElse(null);

        // Target is real, and in the guild and NOT master.
        if (targetUser != null && existingGuild.equals(targetUser.getGuild()) && targetUser.getId() != currentUser.getId()) {
            targetUser.setGuild(null);
            targetUser.setGuildRole("NONE");
            userRepository.save(targetUser);
        }


        return  "redirect:/editGuild/" + guildName;

    }

}

/*
Guild model,

Guild invite code -> String UUID
Guild one to many users

Roles,
Guild roles of admin, co-admin whatever needed
Maybe u can select a user and give them privileges on the page

Controller,
Mapping to /guild
Create guild by /guilds   -> button to create guilds

/guilds
only joinable with code
need error if members = 8 cant join

/guild
will have href to editGuild

/leaderboard
Two more leaderboards for
Guild points total -> guild.name for i in range(len(guild.users)) -> guild-points += user.points
Guild completion of courses? total

 */