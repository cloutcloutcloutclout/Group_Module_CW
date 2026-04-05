package com.example.group52.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.group52.service.SeleniumBrowserService;

import jakarta.servlet.http.HttpServletRequest;

@RestController
public class SeleniumController {

    private final SeleniumBrowserService seleniumBrowserService;

    public SeleniumController(SeleniumBrowserService seleniumBrowserService) {
        this.seleniumBrowserService = seleniumBrowserService;
    }

    @GetMapping("/selenium/open")
    public ResponseEntity<String> open(@RequestParam String url,
                                       @RequestParam(required = false) String sessionId,
                                       @RequestParam(required = false, defaultValue = "popup") String mode,
                                       HttpServletRequest request) {
        try {
            String scheme = request.getScheme();
            String host = request.getServerName();
            int port = request.getServerPort();
            String origin = scheme + "://" + host + (port == 80 || port == 443 ? "" : ":" + port);

            seleniumBrowserService.openUrl(url, sessionId, origin, null, mode);
            return ResponseEntity.ok("opened");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("error: " + e.getMessage());
        }
    }

    @GetMapping("/selenium/close")
    public ResponseEntity<String> close() {
        try {
            seleniumBrowserService.close();
            return ResponseEntity.ok("closed");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("error: " + e.getMessage());
        }
    }
}
