package com.example.group52.repository;

import com.example.group52.model.Guild;
import com.example.group52.model.User;
import org.springframework.data.repository.CrudRepository;

import java.util.List;
import java.util.Optional;

public interface GuildRepository extends CrudRepository<Guild, Integer> {
    List<Guild> findAll();
    Optional<Guild> findByGuildName(String guildName);
    // better to find as it ignores case-sensitive
    Optional<Guild> findByGuildNameIgnoreCase(String guildName);
    // Finding code
    Optional<Guild> findByCode(String code);
}
