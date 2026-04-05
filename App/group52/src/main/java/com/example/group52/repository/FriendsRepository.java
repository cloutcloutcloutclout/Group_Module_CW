package com.example.group52.repository;

import com.example.group52.model.Friends;
import com.example.group52.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface FriendsRepository extends JpaRepository<Friends, Integer> {
    // finds requester
    List<Friends> findByRequesterAndStatus(User requester, Friends.Status status);
    // finds responder
    List<Friends> findByResponderAndStatus(User responder, Friends.Status status);
    // finds both, join
    Optional<Friends> findByRequesterAndResponder(User requester, User responder);

    // profile Privacy to find if someone is a friend
    Optional<Friends> findByRequesterAndResponderAndStatus(User requester, User responder, Friends.Status status);

}
