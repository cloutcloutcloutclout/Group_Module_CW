package com.example.group52.service;

import com.example.group52.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.DefaultOAuth2User;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class Oauth2UserService extends DefaultOAuth2UserService {
    private final UserService userService;

    @Autowired
    public Oauth2UserService(UserService userService) {
        this.userService = userService;
    }

    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws
            OAuth2AuthenticationException {
        OAuth2User oauth2user = super.loadUser(userRequest);
        Map<String, Object> attributes = oauth2user.getAttributes();
        String registrationId = userRequest.getClientRegistration().getRegistrationId();

        System.out.println("Provider: " + registrationId.toUpperCase());


        String email = null;
        String name = null;

        //to handle the various providers
        if ("google".equals(registrationId)) {
            email = (String) attributes.get("email");
            name = (String) attributes.get("name");


        } else if ("github".equals(registrationId)) {

            String login = (String) attributes.get("login");
            email = (String) attributes.get("email");
            name = (String) attributes.get("name");

            //if github provides no email
            if (email == null || name == null) {
                email = login + "@github.com";//create a dummy email
            }
            if (name == null && login != null) {
                name = login;
            }

        }

        if (email == null || name == null) {
            throw new OAuth2AuthenticationException("Email not found");
        }

        User user = userService.registerOAuth2User(email, name);

        //create authority
        String authority = user.getRoles();
        if (!authority.startsWith("ROLE_")) {
            authority = "ROLE_" + authority.toUpperCase();
        }
        System.out.println("Authority granted: " + authority);

        String nameAttributeKey = "google".equals(registrationId) ? "email" : "login";
        System.out.println("Available attributes: " + attributes.keySet());

        // Return OAuth2User with correct authority and name attribute key
        return new DefaultOAuth2User(
                List.of(new SimpleGrantedAuthority(authority)),
                attributes,
                nameAttributeKey  // This is CRITICAL - must match an attribute key
        );
    }
}