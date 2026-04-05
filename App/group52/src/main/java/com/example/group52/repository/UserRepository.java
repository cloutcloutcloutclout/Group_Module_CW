package com.example.group52.repository;

import java.util.List;
import java.util.Optional;

import com.example.group52.model.Guild;
import org.springframework.data.domain.Sort;
import org.springframework.data.repository.CrudRepository;

import com.example.group52.model.User;

public interface UserRepository extends CrudRepository<User, Integer> {
    Optional<User> findByUsername(String username); //method to find the user by their username
    List<User> findAll(Sort points); //find all users and sort the user points
    List<User> findByIdNot(int id);
    Optional<User> findByEmail(String email);

    // caps to reduce dupes
    Optional<User> findByUsernameIgnoreCase(String username);
    Optional<User> findByEmailIgnoreCase(String email);

    List<User> findByGuild(Guild existingGuild);
}
