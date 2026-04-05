package com.example.group52.repository;
import com.example.group52.model.AdminMessage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface AdminMessageRepository extends JpaRepository<AdminMessage,Long> {
List<AdminMessage> findBySender(String sender);
List<AdminMessage> findBySenderAndParentIdIsNull(String sender);
List<AdminMessage> findByParentId(Long parentId);
List<AdminMessage> findByParentIdIsNull();
long countByParentIdIsNullAndStatusIn(List<String> statuses);

}
