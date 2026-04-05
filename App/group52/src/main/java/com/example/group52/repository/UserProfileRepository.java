package com.example.group52.repository;

import com.example.group52.model.UserProfile;
import org.springframework.data.repository.CrudRepository;

public interface UserProfileRepository extends CrudRepository<UserProfile, Integer> {
    UserProfile findByUserId(Integer userId);

}
