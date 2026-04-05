package com.example.group52.service;

import java.time.Duration;
import java.time.Instant;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.example.group52.model.CourseSession;
import com.example.group52.model.CourseSession.SessionStatus;
import com.example.group52.repository.CourseSessionRepository;
import com.example.group52.repository.UserRepository;

import jakarta.transaction.Transactional;

@Service
public class CourseSessionService {

    private static final Logger log = Logger.getLogger(CourseSessionService.class.getName());

    @Autowired
    private CourseSessionRepository courseSessionRepository;

    @Autowired
    private UserRepository userRepository;

    public CourseSession start(String userId, String courseId) {
        CourseSession session = new CourseSession();
        session.setUserId(userId);
        session.setCourseId(courseId);
        session.setStartTime(Instant.now());
        session.setLastActiveAt(Instant.now());
        session.setAccumulatedSeconds(0);
        session.setStatus(SessionStatus.IN_PROGRESS);
        CourseSession saved = courseSessionRepository.save(session);
        log.log(Level.INFO, "Started session {0} for user {1} course {2}", new Object[]{saved.getId(), userId, courseId});
        return saved;
    }

    private static final long INACTIVITY_THRESHOLD_SECONDS = 20;

    @Scheduled(fixedDelay = 10000)
    public void scanForInactiveSessions() {
        Instant now = Instant.now();
        for (CourseSession session : courseSessionRepository.findByStatus(SessionStatus.IN_PROGRESS)) {
            if (session.getLastActiveAt() == null) {
                continue;
            }
            long idle = Duration.between(session.getLastActiveAt(), now).getSeconds();
            if (idle >= INACTIVITY_THRESHOLD_SECONDS) {
                long delta = idle;
                session.setAccumulatedSeconds(session.getAccumulatedSeconds() + delta);
                session.setStatus(SessionStatus.PAUSED);
                session.setLastActiveAt(null);
                courseSessionRepository.save(session);
                log.log(Level.INFO, "Scanner paused session {0} user {1} after {2}s idle (acc={3})", new Object[]{session.getId(), session.getUserId(), idle, session.getAccumulatedSeconds()});
            }
        }
    }

    public void heartbeat(Long sessionId, String userId) {
        CourseSession session = courseSessionRepository.findByIdAndUserId(sessionId, userId).orElse(null);
        if (session == null) return;
        if (session.getStatus() != SessionStatus.IN_PROGRESS) return;
        Instant now = Instant.now();
        if (session.getLastActiveAt() != null) {
            long delta = Duration.between(session.getLastActiveAt(), now).getSeconds();
            if (delta > 0) {
                session.setAccumulatedSeconds(session.getAccumulatedSeconds() + delta);
                log.log(Level.INFO, "Heartbeat session {0} user {1} delta {2} acc {3}", new Object[]{sessionId, userId, delta, session.getAccumulatedSeconds()});
            } else {
                log.log(Level.FINE, "Heartbeat session {0} user {1} delta {2} (no add)", new Object[]{sessionId, userId, delta});
            }
        }
        session.setLastActiveAt(now);
        courseSessionRepository.save(session);
    }

    public void heartbeatById(Long sessionId) {
        CourseSession session = courseSessionRepository.findById(sessionId).orElse(null);
        if (session == null) return;
        if (session.getStatus() != SessionStatus.IN_PROGRESS) return;
        Instant now = Instant.now();
        if (session.getLastActiveAt() != null) {
            long delta = Duration.between(session.getLastActiveAt(), now).getSeconds();
            if (delta > 0) {
                session.setAccumulatedSeconds(session.getAccumulatedSeconds() + delta);
                log.log(Level.INFO, "Ext-heartbeat session {0} delta {1} acc {2}", new Object[]{sessionId, delta, session.getAccumulatedSeconds()});
            }
        }
        session.setLastActiveAt(now);
        courseSessionRepository.save(session);
    }

    public void completeById(Long sessionId) {
        CourseSession session = courseSessionRepository.findById(sessionId).orElse(null);
        if (session == null) return;
        if (session.getStatus() == SessionStatus.IN_PROGRESS || session.getStatus() == SessionStatus.PAUSED) {
            Instant now = Instant.now();
            if (session.getLastActiveAt() != null) {
                long delta = Duration.between(session.getLastActiveAt(), now).getSeconds();
                if (delta > 0) {
                    session.setAccumulatedSeconds(session.getAccumulatedSeconds() + delta);
                }
            }
            session.setStatus(SessionStatus.COMPLETED);
            session.setEndedAt(now);
            session.setLastActiveAt(null);
            courseSessionRepository.save(session);
            log.log(Level.INFO, "Ext-close completed session {0} acc {1}", new Object[]{sessionId, session.getAccumulatedSeconds()});
        }
    }

    public void pauseById(Long sessionId) {
        CourseSession session = courseSessionRepository.findById(sessionId).orElse(null);
        if (session == null) return;
        if (session.getStatus() != SessionStatus.IN_PROGRESS) return;
        Instant now = Instant.now();
        if (session.getLastActiveAt() != null) {
            long delta = Duration.between(session.getLastActiveAt(), now).getSeconds();
            if (delta > 0) {
                session.setAccumulatedSeconds(session.getAccumulatedSeconds() + delta);
            }
        }
        session.setStatus(SessionStatus.PAUSED);
        session.setLastActiveAt(null);
        courseSessionRepository.save(session);
        log.log(Level.INFO, "Ext-pause paused session {0} acc {1}", new Object[]{sessionId, session.getAccumulatedSeconds()});
    }

    public void resumeById(Long sessionId) {
        CourseSession session = courseSessionRepository.findById(sessionId).orElse(null);
        if (session == null) return;
        if (session.getStatus() != SessionStatus.PAUSED) return;
        session.setLastActiveAt(Instant.now());
        session.setStatus(SessionStatus.IN_PROGRESS);
        courseSessionRepository.save(session);
        log.log(Level.INFO, "Ext-resume resumed session {0}", new Object[]{sessionId});
    }

    public void pause(Long sessionId, String userId) {
        CourseSession session = courseSessionRepository.findByIdAndUserId(sessionId, userId).orElse(null);
        if (session == null) {
            return;
        }
        if (session.getStatus() == SessionStatus.IN_PROGRESS) {
            Instant now = Instant.now();
            if (session.getLastActiveAt() != null) {
                long delta = Duration.between(session.getLastActiveAt(), now).getSeconds();
                if (delta > 0) {
                    session.setAccumulatedSeconds(session.getAccumulatedSeconds() + delta);
                    log.log(Level.INFO, "Pause session {0} user {1} delta {2} acc {3}", new Object[]{sessionId, userId, delta, session.getAccumulatedSeconds()});
                } else {
                    log.log(Level.FINE, "Pause session {0} user {1} delta {2} (no add)", new Object[]{sessionId, userId, delta});
                }
            }
            session.setStatus(SessionStatus.PAUSED);
            session.setLastActiveAt(null);
            courseSessionRepository.save(session);
        }
    }

    public void resume(Long sessionId, String userId) {
        CourseSession session = courseSessionRepository.findByIdAndUserId(sessionId, userId).orElse(null);
        if (session == null) return;
        if (session.getStatus() == SessionStatus.PAUSED) {
            session.setLastActiveAt(Instant.now());
            session.setStatus(SessionStatus.IN_PROGRESS);
            courseSessionRepository.save(session);
            log.log(Level.INFO, "Resume session {0} user {1}", new Object[]{sessionId, userId});
        }
    }

    public void complete(Long sessionId, String userId) {
        CourseSession session = courseSessionRepository.findByIdAndUserId(sessionId, userId).orElse(null);
        if (session == null) return;
        if (session.getStatus() == SessionStatus.IN_PROGRESS) {
            Instant now = Instant.now();
            if (session.getLastActiveAt() != null) {
                long delta = Duration.between(session.getLastActiveAt(), now).getSeconds();
                if (delta > 0) {
                    session.setAccumulatedSeconds(session.getAccumulatedSeconds() + delta);
                    log.log(Level.INFO, "Complete session {0} user {1} delta {2} acc {3}", new Object[]{sessionId, userId, delta, session.getAccumulatedSeconds()});
                } else {
                    log.log(Level.FINE, "Complete session {0} user {1} delta {2} (no add)", new Object[]{sessionId, userId, delta});
                }
            }
        }
        session.setStatus(SessionStatus.COMPLETED);
        session.setEndedAt(Instant.now());
        session.setLastActiveAt(null);
        courseSessionRepository.save(session);
    }

    public CourseSession getSession(Long sessionId, String userId) {
        return courseSessionRepository.findByIdAndUserId(sessionId, userId).orElse(null);
    }

    public long getTotalSecondsForUserCourse(String userId, String courseId) {
        var sessions = courseSessionRepository.findByUserIdAndCourseId(userId, courseId);
        long total = 0;
        Instant now = Instant.now();
        for (CourseSession s : sessions) {
            total += s.getAccumulatedSeconds();
            if (s.getStatus() == SessionStatus.IN_PROGRESS && s.getLastActiveAt() != null) {
                long delta = Duration.between(s.getLastActiveAt(), now).getSeconds();
                if (delta > 0) total += delta;
            }
        }
        return total;
    }

    public boolean hasStartedCourse(String userId, String courseId) {
        return !courseSessionRepository.findByUserIdAndCourseId(userId, courseId).isEmpty();
    }

    public void markCourseCompleted(String userId, String courseId, long courseDurationSeconds) {
        boolean alreadyCompleted = courseSessionRepository.findByUserIdAndCourseId(userId, courseId)
                .stream().anyMatch(s -> s.getStatus() == SessionStatus.COMPLETED);
        if (!alreadyCompleted) {
            userRepository.findByUsername(userId).ifPresent(user -> {
                user.setPoints(user.getPoints() + 100);
                userRepository.save(user);
                log.log(Level.INFO, "Awarded 100 points to user {0} for completing course {1}",
                        new Object[]{userId, courseId});
            });
        }
        long totalSoFar = getTotalSecondsForUserCourse(userId, courseId);
        long remaining = courseDurationSeconds - totalSoFar;
        if (remaining < 0) remaining = 0;
        CourseSession session = new CourseSession();
        session.setUserId(userId);
        session.setCourseId(courseId);
        session.setStartTime(Instant.now());
        session.setLastActiveAt(null);
        session.setAccumulatedSeconds(remaining);
        session.setStatus(SessionStatus.COMPLETED);
        session.setEndedAt(Instant.now());
        courseSessionRepository.save(session);
        log.log(Level.INFO, "Marked course {0} complete for user {1}, added {2}s",
                new Object[]{courseId, userId, remaining});
    }

    @Transactional
    public void resetCourseProgress(String userId, String courseId) {
        courseSessionRepository.deleteByUserIdAndCourseId(userId, courseId);
        log.log(Level.INFO, "Reset progress for user {0} course {1}", new Object[]{userId, courseId});
    }
}
