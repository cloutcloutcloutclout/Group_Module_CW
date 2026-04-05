package com.example.group52.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.example.group52.model.UserBadges;

public interface UserBadgesRepository extends CrudRepository<UserBadges, Integer> {
    List<UserBadges> findByUserId(String userId);
    List<UserBadges> findByBadgeName(String badgeName);
    long countByBadgeName(String badgeName);
    boolean existsByUserIdAndBadgeName(String userId, String badgeName);
    UserBadges findByUserIdAndBadgeName(String userId, String badgeName);
}
