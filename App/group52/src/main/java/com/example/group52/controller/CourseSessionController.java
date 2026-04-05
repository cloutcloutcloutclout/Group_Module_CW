package com.example.group52.controller;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.security.Principal;
import java.util.Map;

import com.example.group52.model.Course;
import com.example.group52.repository.CourseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.group52.model.CourseSession;
import com.example.group52.service.CourseSessionService;

@RestController
@RequestMapping("/sessions")
public class CourseSessionController {

    @Autowired
    private CourseSessionService courseSessionService;
    @Autowired
    private CourseRepository courseRepository;

    @GetMapping("/progress")
    public ResponseEntity<?> progress(@RequestParam String courseId, Principal principal) {
        if (principal == null) {
            return ResponseEntity.status(401).build();
        }
        String userId = principal.getName();
        long totalSeconds = courseSessionService.getTotalSecondsForUserCourse(userId, courseId);
        boolean hasStarted = courseSessionService.hasStartedCourse(userId, courseId);
        return ResponseEntity.ok(Map.of(
                "totalSeconds", totalSeconds,
                "hasStarted", hasStarted));
    }

    @PostMapping("/mark-complete")
    public ResponseEntity<?> markComplete(@RequestParam String courseId,
                                          @RequestParam long durationSeconds,
                                          Principal principal) {
        if (principal == null) {
            return ResponseEntity.status(401).build();
        }

        boolean isFirstComplete = courseSessionService.getTotalSecondsForUserCourse(principal.getName(), courseId) < durationSeconds;
        courseSessionService.markCourseCompleted(principal.getName(), courseId, durationSeconds);

        if (isFirstComplete) {
            try {
                Course course = courseRepository.findById(Integer.parseInt(courseId)).orElse(null);
                if (course != null) {
                    course.setEnrollmentCount(course.getEnrollmentCount() + 1);
                    courseRepository.save(course);
                }
            } catch (NumberFormatException e) {
                System.err.print("invalid courseID");
            }
        }
        return ResponseEntity.ok().build();
    }

    @PostMapping("/reset-progress")
    public ResponseEntity<?> resetProgress(@RequestParam String courseId, Principal principal) {
        if (principal == null) {
            return ResponseEntity.status(401).build();
        }
        courseSessionService.resetCourseProgress(principal.getName(), courseId);
        return ResponseEntity.ok().build();
    }

    @PostMapping("/start")
    public ResponseEntity<?> start(@RequestBody Map<String, String> body, Principal principal) {
        if (principal == null) {
            return ResponseEntity.status(401).build();
        }
        String userId = principal.getName();
        String courseId = body.getOrDefault("courseId", "unknown-course");
        String courseUrl = body.getOrDefault("courseUrl", "/skillsbuild_simulator.html");
        CourseSession session = courseSessionService.start(userId, courseId);

        String separator = courseUrl.contains("?") ? "&" : "?";
        String returnPath = "/return.html?sessionId=" + session.getId();
        String encodedReturn = URLEncoder.encode(returnPath, StandardCharsets.UTF_8);
        String courseUrlWithReturn = courseUrl + separator + "sessionId=" + session.getId() + "&returnUrl="
                + encodedReturn;
        return ResponseEntity
                .ok(Map.of("sessionId", session.getId().toString(), "courseUrlWithReturn", courseUrlWithReturn));
    }

    @PostMapping("/heartbeat")
    public ResponseEntity<?> heartbeat(@RequestParam Long sessionId, Principal principal) {
        if (principal == null) {
            return ResponseEntity.status(401).build();
        }
        courseSessionService.heartbeat(sessionId, principal.getName());
        return ResponseEntity.ok().build();
    }

    @PostMapping("/ext-heartbeat")
    public ResponseEntity<?> extHeartbeat(@RequestParam Long sessionId) {
        courseSessionService.heartbeatById(sessionId);
        return ResponseEntity.ok().build();
    }

    @PostMapping("/ext-close")
    public ResponseEntity<?> extClose(@RequestParam Long sessionId) {
        courseSessionService.completeById(sessionId);
        return ResponseEntity.ok().build();
    }

    @PostMapping("/ext-pause")
    public ResponseEntity<?> extPause(@RequestParam Long sessionId) {
        courseSessionService.pauseById(sessionId);
        return ResponseEntity.ok().build();
    }

    @PostMapping("/ext-resume")
    public ResponseEntity<?> extResume(@RequestParam Long sessionId) {
        courseSessionService.resumeById(sessionId);
        return ResponseEntity.ok().build();
    }

    @PostMapping("/pause")
    public ResponseEntity<?> pause(@RequestParam Long sessionId, Principal principal) {
        if (principal == null) {
            return ResponseEntity.status(401).build();
        }
        courseSessionService.pause(sessionId, principal.getName());
        return ResponseEntity.ok().build();
    }

    @PostMapping("/resume")
    public ResponseEntity<?> resume(@RequestParam Long sessionId, Principal principal) {
        if (principal == null) {
            return ResponseEntity.status(401).build();
        }
        courseSessionService.resume(sessionId, principal.getName());
        return ResponseEntity.ok().build();
    }

    @PostMapping("/complete")
    public ResponseEntity<?> complete(@RequestParam Long sessionId, Principal principal) {
        if (principal == null) {
            return ResponseEntity.status(401).build();
        }
        courseSessionService.complete(sessionId, principal.getName());
        return ResponseEntity.ok().build();
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getSession(@PathVariable("id") Long id, Principal principal) {
        if (principal == null) {
            return ResponseEntity.status(401).build();
        }
        CourseSession session = courseSessionService.getSession(id, principal.getName());
        if (session == null) {
            return ResponseEntity.notFound().build();
        }
        Long elapsed = session.getAccumulatedSeconds();
        if (session.getStatus() == CourseSession.SessionStatus.IN_PROGRESS && session.getLastActiveAt() != null) {
            Long delta = java.time.Duration.between(session.getLastActiveAt(), java.time.Instant.now()).getSeconds();
            if (delta > 0) {
                elapsed += delta;
            }
        }
        return ResponseEntity.ok(Map.of("sessionId", session.getId().toString(), "status", session.getStatus().name(),
                "accumulatedSeconds", Long.toString(session.getAccumulatedSeconds()), "elapsedSeconds",
                Long.toString(elapsed), "startTime",
                session.getStartTime() == null ? "" : session.getStartTime().toString(), "endedAt",
                session.getEndedAt() == null ? "" : session.getEndedAt().toString()));
    }
}
