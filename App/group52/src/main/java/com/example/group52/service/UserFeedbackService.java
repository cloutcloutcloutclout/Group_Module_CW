package com.example.group52.service;

import com.example.group52.model.UserFeedback;
import com.example.group52.repository.UserFeedbackRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class UserFeedbackService {

    private final UserFeedbackRepository repository;

    public UserFeedbackService(UserFeedbackRepository repository) {
        this.repository = repository;
    }

    public UserFeedback submitFeedback(UserFeedback feedback) {

        if (feedback.getMessage() == null || feedback.getMessage().trim().isEmpty()) {
            throw new IllegalArgumentException("Message cannot be empty");
        }

        feedback.setStatus("OPEN");
        feedback.setCreatedAt(LocalDateTime.now());

        return repository.save(feedback);
    }
}


