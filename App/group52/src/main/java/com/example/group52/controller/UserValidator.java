package com.example.group52.controller;

import com.example.group52.model.User;
import com.example.group52.repository.UserRepository;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;


public class UserValidator implements Validator {
    private UserRepository userRepository;

    public UserValidator(UserRepository userRepository) {
        this.userRepository = userRepository;
    }
    @Override
    public boolean supports(Class<?> clazz) {
        return User.class.equals(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {
        User user = (User) target;

        User existingUser = userRepository.findByUsername(user.getUsername()).orElse(null);

        if (existingUser != null) {
            errors.rejectValue("username", "", "Username already exists");
        }
    }
}
