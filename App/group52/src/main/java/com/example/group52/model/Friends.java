package com.example.group52.model;

import jakarta.persistence.*;

@Entity
public class Friends {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne
    @JoinColumn(name = "requester_id")
    private User requester;

    @ManyToOne
    @JoinColumn(name = "responder_id")
    private User responder;

    protected Friends() {
    }

    public Friends(User requester, User responder) {
        this.requester = requester;
        this.responder = responder;
    }

    public enum Status {
        PENDING, APPROVED, REJECTED
    }

    @Enumerated(EnumType.STRING)
    private Status status = Status.PENDING;


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public User getRequester() {
        return requester;
    }

    public void setRequester(User requester) {
        this.requester = requester;
    }

    public User getResponder() {
        return responder;
    }
    public void setResponder(User responder) {
        this.responder = responder;
    }

    public Status getStatus() {
        return status;
    }
    public void setStatus(Status status) {
        this.status = status;
    }

}
