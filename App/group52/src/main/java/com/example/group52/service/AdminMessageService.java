package com.example.group52.service;

import com.example.group52.model.AdminMessage;
import com.example.group52.repository.AdminMessageRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;

@Service
public class AdminMessageService {

    private final AdminMessageRepository repo;

    public AdminMessageService(AdminMessageRepository repo) {
        this.repo = repo;
    }

    public List<AdminMessage> getTopLevelMessagesBySender(String sender) {
        return repo.findBySenderAndParentIdIsNull(sender);
    }

    public List<AdminMessage> getReplies(Long parentId) {
        return repo.findByParentId(parentId);
    }

    public Long countUnreadTopLevelMessages() {
        return repo.countByParentIdIsNullAndStatusIn(Arrays.asList("NEW"));
    }

    public Long countReadTopLevelMessages() {
        return repo.countByParentIdIsNullAndStatusIn(Arrays.asList("READ", "REPLIED"));
    }

    public List<AdminMessage> getTopLevelMessages(String sender) {
        return repo.findBySenderAndParentIdIsNull(sender);
    }

    public List<AdminMessage> getTopLevelMessages() {
        return repo.findByParentIdIsNull();
    }

    public List<AdminMessage> getAllMessages() {
        return repo.findAll();
    }

    public AdminMessage getById(Long id) {
        return repo.findById(id).orElse(null);
    }

    public List<AdminMessage> getMessagesBySender(String sender) {
        return repo.findBySender(sender);
    }

    public void deleteMessage(Long id) {
        repo.deleteById(id);
    }

    public void deleteById(Long id) {
        repo.deleteById(id);
    }

    public void markAsRead(Long id) {
        AdminMessage msg = repo.findById(id).orElse(null);
        if (msg != null && "NEW".equals(msg.getStatus())) {
            msg.setStatus("READ");
            repo.save(msg);
        }
    }

    public void saveMessage(String sender, String messageText) {
        AdminMessage msg = new AdminMessage();
        msg.setSender(sender);
        msg.setMessage(messageText);
        msg.setStatus("NEW");
        msg.setParentId(null);
        msg.setCreatedAt(LocalDateTime.now());
        msg.setReply(null);
        repo.save(msg);
    }

    public void saveReplyMessage(String sender, String messageText, Long parentId) {
        AdminMessage msg = new AdminMessage();
        msg.setSender(sender);
        msg.setMessage(messageText);
        msg.setStatus("NEW");
        msg.setParentId(parentId);
        msg.setCreatedAt(java.time.LocalDateTime.now());
        msg.setReply(null);
        repo.save(msg);

        AdminMessage parent = repo.findById(parentId).orElse(null);
        if (parent != null) {
            parent.setStatus("NEW");
            repo.save(parent);
        }

    }

    public void sendReply(Long id, String replyText) {
        AdminMessage parent = repo.findById(id).orElse(null);

        if (parent != null) {
            AdminMessage reply = new AdminMessage();
            reply.setSender("admin");
            reply.setMessage(replyText);
            reply.setStatus("REPLIED");
            reply.setParentId(parent.getId());
            reply.setCreatedAt(LocalDateTime.now());
            reply.setReply(null);
            reply.setRepliedAt(LocalDateTime.now());
            repo.save(reply);

            parent.setStatus("READ");
            repo.save(parent);
        }
    }
}