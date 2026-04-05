package com.example.group52.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.web.server.context.WebServerInitializedEvent;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Service;

import io.github.bonigarcia.wdm.WebDriverManager;
import jakarta.annotation.PreDestroy;

@Service
public class SeleniumBrowserService {

    private static final Logger LOGGER = Logger.getLogger(SeleniumBrowserService.class.getName());

    @org.springframework.beans.factory.annotation.Value("${app.launch.mode:app}")
    private String launchMode;

    @org.springframework.beans.factory.annotation.Value("${selenium.chrome.user-data-dir:./resources/Chrome}")
    private String chromeUserDataDir;

    @Autowired
    private CourseSessionService courseSessionService;

    @Autowired
    private ConfigurableApplicationContext applicationContext;

    private WebDriver driver;
    private String cdpScriptId = null;
    private String externalTabHandle = null;
    private Long trackedSessionId = null;
    private Thread tabMonitorThread = null;
    private Thread mainWindowMonitorThread = null;
    private long chromeDriverPid = -1;

    @EventListener
    public void onWebReady(WebServerInitializedEvent event) {
        int port = event.getWebServer().getPort();
        String serverOrigin = "http://localhost:" + port;
        String appUrl = serverOrigin + "/";
        LOGGER.info("Web server ready at port " + port + "; launching app in Selenium: " + appUrl);
        try {
            openUrl(appUrl, null, serverOrigin, null);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Failed to open app in Selenium on web ready", e);
        }
    }

    public synchronized void openUrl(String url, String sessionId, String serverOrigin,
                                     java.util.Map<String, String> cookies) {
        openUrl(url, sessionId, serverOrigin, cookies, "popup");
    }

    public synchronized void openUrl(String url, String sessionId, String serverOrigin,
                                     java.util.Map<String, String> cookies, String mode) {
        try {
            ensureDriverRunning(serverOrigin);

            cleanUpStaleExternalTab();

            boolean hasTracking = sessionId != null && !sessionId.isBlank()
                    && serverOrigin != null && !serverOrigin.isBlank();
            boolean isAppPage = driver.getWindowHandles().size() <= 1 && isAppUrl(url, serverOrigin);

            if (isAppPage) {
                if (hasTracking) configureViaCdp(sessionId, serverOrigin);
                driver.get(url);
            } else {
                switchToNewWindow(mode);
                if (hasTracking) {
                    configureViaCdp(sessionId, serverOrigin);
                    externalTabHandle = driver.getWindowHandle();
                    trackedSessionId = Long.valueOf(sessionId);
                    startTabMonitor();
                }
                driver.get(url);
                LOGGER.info("CDP: installed tracking script on new " + mode + ", navigating to " + url);
            }

            LOGGER.info("Selenium: opened " + url + " (mode=" + mode + ")");
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Failed to open URL in Selenium Chrome", e);
            throw new RuntimeException(e);
        }
    }

    @PreDestroy
    public void onShutdown() {
        LOGGER.info("Spring shutdown: cleaning up Selenium driver");
        close();
    }

    public synchronized void close() {
        try {
            stopTabMonitor();
            stopMainWindowMonitor();
            if (driver != null) {
                try {
                    Set<String> handles = driver.getWindowHandles();
                    for (String h : handles) {
                        try {
                            driver.switchTo().window(h);
                            driver.close();
                        } catch (Exception ignored) {}
                    }
                } catch (Exception ignored) {}
                try {
                    driver.quit();
                } catch (Exception ignored) {}
                driver = null;
                cdpScriptId = null;
                externalTabHandle = null;
                trackedSessionId = null;
            }
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error closing Selenium driver", e);
        }
        forceKillChromeDriver();
    }

    private void cleanUpStaleExternalTab() {
        if (externalTabHandle == null || driver == null) return;
        try {
            Set<String> handles = driver.getWindowHandles();
            if (!handles.contains(externalTabHandle)) {
                LOGGER.info("openUrl: stale external tab detected, completing session " + trackedSessionId);
                stopTabMonitor();
                if (trackedSessionId != null) {
                    courseSessionService.completeById(trackedSessionId);
                }
                externalTabHandle = null;
                trackedSessionId = null;
                if (!handles.isEmpty()) {
                    driver.switchTo().window(handles.iterator().next());
                }
            }
        } catch (Exception e) {
            LOGGER.log(Level.FINE, "cleanUpStaleExternalTab: error, resetting state", e);
            externalTabHandle = null;
            trackedSessionId = null;
        }
    }

    private void ensureDriverRunning(String serverOrigin) throws IOException {
        if (driver != null) return;

        WebDriverManager.chromedriver().setup();

        ChromeOptions options = new ChromeOptions();
        options.setExperimentalOption("excludeSwitches", Arrays.asList("enable-automation"));
        options.setExperimentalOption("useAutomationExtension", false);
        options.addArguments("--disable-blink-features=AutomationControlled");
        options.addArguments("--disable-infobars");
        options.addArguments("--remote-allow-origins=*");

        Path userData = Path.of(chromeUserDataDir);
        try {
            Files.createDirectories(userData);
        } catch (Exception e) {
            userData = Files.createTempDirectory("selenium-chrome-profile");
        }
        options.addArguments("--user-data-dir=" + userData.toAbsolutePath().toString());
        options.addArguments("--disable-popup-blocking");
        options.addArguments("--disable-features="
                + "PrivateNetworkAccessRespectPreflightResults,"
                + "BlockInsecurePrivateNetworkRequests,"
                + "BlockInsecurePrivateNetworkRequestsForNavigations,"
                + "PrivateNetworkAccessPermissionPrompt,"
                + "PrivateNetworkAccessForWorkers,"
                + "PrivateNetworkAccessForNavigations");
        options.addArguments("--allow-running-insecure-content");
        options.addArguments("--disable-web-security");

        if (serverOrigin != null && !serverOrigin.isBlank() && "app".equalsIgnoreCase(launchMode)) {
            options.addArguments("--app=" + serverOrigin + "/");
        }

        driver = new ChromeDriver(options);

        try {
            if (driver instanceof ChromeDriver chrome) {
                chrome.executeCdpCommand("Page.addScriptToEvaluateOnNewDocument",
                        Map.of("source",
                                "Object.defineProperty(navigator, 'webdriver', {get: () => undefined});"));
            }
        } catch (Exception e) {
            LOGGER.log(Level.FINE, "Could not remove navigator.webdriver flag", e);
        }

        try {
            ProcessHandle.current().children().forEach(ph -> {
                ph.info().command().ifPresent(cmd -> {
                    if (cmd.toLowerCase().contains("chromedriver")) {
                        chromeDriverPid = ph.pid();
                        LOGGER.info("Captured chromedriver PID: " + chromeDriverPid);
                    }
                });
            });
        } catch (Exception e) {
            LOGGER.log(Level.FINE, "Could not capture chromedriver PID", e);
        }

        Runtime.getRuntime().addShutdownHook(new Thread(() -> {
            try {
                if (driver != null) {
                    try {
                        for (String h : driver.getWindowHandles()) {
                            try { driver.switchTo().window(h); driver.close(); } catch (Exception ignored) {}
                        }
                    } catch (Exception ignored) {}
                    try { driver.quit(); } catch (Exception ignored) {}
                }
            } catch (Exception ignored) {}
            forceKillChromeDriver();
        }, "chromedriver-shutdown-hook"));

        if (serverOrigin != null && !serverOrigin.isBlank()) {
            LOGGER.info("Selenium: launched in app mode at " + serverOrigin);
        }

        startMainWindowMonitor();
    }

    private void startMainWindowMonitor() {
        stopMainWindowMonitor();
        mainWindowMonitorThread = new Thread(() -> {
            LOGGER.info("Main-window monitor started");
            try {
                while (!Thread.currentThread().isInterrupted()) {
                    Thread.sleep(2000);
                    try {
                        synchronized (SeleniumBrowserService.this) {
                            if (driver == null) break;
                            Set<String> handles = driver.getWindowHandles();
                            if (handles.isEmpty()) {
                                LOGGER.info("Main-window monitor: all windows closed, quitting driver");
                                close();
                                shutdownApplication();
                                break;
                            }
                        }
                    } catch (org.openqa.selenium.WebDriverException e) {
                        LOGGER.info("Main-window monitor: driver unreachable, cleaning up");
                        synchronized (SeleniumBrowserService.this) {
                            driver = null;
                            cdpScriptId = null;
                            externalTabHandle = null;
                            trackedSessionId = null;
                        }
                        shutdownApplication();
                        break;
                    }
                }
            } catch (InterruptedException ie) {
            }
            LOGGER.info("Main-window monitor stopped");
        }, "main-window-monitor");
        mainWindowMonitorThread.setDaemon(true);
        mainWindowMonitorThread.start();
    }

    private void stopMainWindowMonitor() {
        if (mainWindowMonitorThread != null) {
            mainWindowMonitorThread.interrupt();
            mainWindowMonitorThread = null;
        }
    }

    private void forceKillChromeDriver() {
        if (chromeDriverPid > 0) {
            try {
                ProcessHandle.of(chromeDriverPid).ifPresent(ph -> {
                    if (ph.isAlive()) {
                        LOGGER.info("Force-killing chromedriver PID " + chromeDriverPid);
                        ph.destroyForcibly();
                    }
                });
            } catch (Exception e) {
                LOGGER.log(Level.FINE, "PID-based kill failed", e);
            }
        }
        if (System.getProperty("os.name", "").toLowerCase().contains("win")) {
            try {
                new ProcessBuilder("taskkill", "/F", "/IM", "chromedriver.exe")
                        .redirectErrorStream(true).start();
                LOGGER.info("Sent taskkill /F /IM chromedriver.exe");
            } catch (Exception e) {
                LOGGER.log(Level.FINE, "taskkill fallback failed", e);
            }
        }
        chromeDriverPid = -1;
    }

    private void shutdownApplication() {
        LOGGER.info("Initiating graceful Spring application shutdown");
        new Thread(() -> {
            try { Thread.sleep(500); } catch (InterruptedException ignored) {}
            try {
                SpringApplication.exit(applicationContext, () -> 0);
            } catch (Exception e) {
                LOGGER.log(Level.WARNING, "SpringApplication.exit failed, forcing System.exit", e);
                System.exit(0);
            }
        }, "app-shutdown").start();
    }

    private void configureViaCdp(String sessionId, String serverOrigin) {
        try {
            if (!(driver instanceof ChromeDriver chrome)) {
                LOGGER.warning("CDP fallback unavailable - driver is not ChromeDriver");
                return;
            }

            if (cdpScriptId != null) {
                try {
                    Map<String, Object> rm = new HashMap<>();
                    rm.put("identifier", cdpScriptId);
                    chrome.executeCdpCommand("Page.removeScriptToEvaluateOnNewDocument", rm);
                } catch (Exception ignore) {}
                cdpScriptId = null;
            }

            String js = buildCdpTrackingScript(sessionId, serverOrigin);
            Map<String, Object> params = new HashMap<>();
            params.put("source", js);
            Map<String, Object> result = chrome.executeCdpCommand(
                    "Page.addScriptToEvaluateOnNewDocument", params);
            if (result != null && result.containsKey("identifier")) {
                cdpScriptId = result.get("identifier").toString();
            }
            LOGGER.info("CDP fallback: installed tracking script for session " + sessionId);
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "CDP fallback script installation failed", e);
        }
    }

    private String buildCdpTrackingScript(String sessionId, String serverOrigin) {
        return "(function(){"
                + "var sid='" + escapeJs(sessionId) + "';"
                + "var origin='" + escapeJs(serverOrigin) + "';"
                + "if(!sid||!origin) return;"
                + "if(location.origin===origin) return;"
                + "if(window.__sb&&window.__sb.sid===sid) return;"
                + "if(window.__sb){window.__sb.stop();}"
                + "var base=origin+'/sessions/';"
                + "var qs='?sessionId='+encodeURIComponent(sid);"
                + "var hbUrl=base+'ext-heartbeat'+qs;"
                + "var pauseUrl=base+'ext-pause'+qs;"
                + "var resumeUrl=base+'ext-resume'+qs;"
                + "function post(u){try{fetch(u,{method:'POST',mode:'cors'})"
                + ".then(function(r){console.log('[sb-cdp]',u.split('/').pop(),r.status);})"
                + ".catch(function(){try{navigator.sendBeacon(u,'');}catch(e){}});"
                + "}catch(e){try{navigator.sendBeacon(u,'');}catch(e2){}}}"
                + "var hbTimer=null;"
                + "function startHb(){if(hbTimer)return;post(hbUrl);"
                + "hbTimer=setInterval(function(){post(hbUrl);},5000);}"
                + "function stopHb(){if(hbTimer){clearInterval(hbTimer);hbTimer=null;}}"
                + "var focused=true;"
                + "var startedAt=Date.now();"
                + "function onFocus(){if(!focused){focused=true;post(resumeUrl);}startHb();}"
                + "function onBlur(){"
                + "if(Date.now()-startedAt<5000) return;"
                + "if(focused){focused=false;stopHb();post(pauseUrl);}}"
                + "document.addEventListener('visibilitychange',function(){"
                + "if(document.hidden){onBlur();}else{onFocus();}});"
                + "window.addEventListener('focus',onFocus);"
                + "window.addEventListener('blur',onBlur);"
                + "var pollId=setInterval(function(){"
                + "var f=document.hasFocus();"
                + "if(f&&!focused){onFocus();}"
                + "else if(!f&&focused){onBlur();}"
                + "},1500);"
                + "window.__sb={sid:sid,stop:function(){stopHb();clearInterval(pollId);}};"
                + "startHb();"
                + "console.log('[sb-cdp] Tracking session '+sid+' on '+location.href);"
                + "})();";  
    }

    private void switchToNewWindow(String mode) {
        Set<String> before = driver.getWindowHandles();
        if ("tab".equalsIgnoreCase(mode)) {
            ((JavascriptExecutor) driver).executeScript(
                    "window.open('about:blank','_blank');");
        } else {
            ((JavascriptExecutor) driver).executeScript(
                    "window.open('about:blank','_blank','popup=yes,width=1200,height=800');");
        }
        try { Thread.sleep(400); } catch (InterruptedException ie) { Thread.currentThread().interrupt(); }
        Set<String> after = driver.getWindowHandles();
        String newHandle = null;
        for (String h : after) {
            if (!before.contains(h)) { newHandle = h; break; }
        }
        if (newHandle != null) {
            driver.switchTo().window(newHandle);
        } else if (!after.isEmpty()) {
            String last = null;
            for (String h : after) last = h;
            driver.switchTo().window(last);
        }
    }

    private void startTabMonitor() {
        stopTabMonitor();
        final String handle = externalTabHandle;
        final Long sid = trackedSessionId;
        if (handle == null || sid == null) return;

        tabMonitorThread = new Thread(() -> {
            LOGGER.info("Tab monitor started for session " + sid + " handle " + handle);
            try {
                while (!Thread.currentThread().isInterrupted()) {
                    Thread.sleep(2000);
                    try {
                        synchronized (SeleniumBrowserService.this) {
                            if (driver == null) break;
                            Set<String> handles = driver.getWindowHandles();
                            if (!handles.contains(handle)) {
                                LOGGER.info("Tab monitor: external tab closed (handle " + handle + ")");
                                courseSessionService.completeById(sid);
                                externalTabHandle = null;
                                trackedSessionId = null;
                                if (!handles.isEmpty()) {
                                    driver.switchTo().window(handles.iterator().next());
                                }
                                break;
                            }
                        }
                    } catch (Exception e) {
                        LOGGER.log(Level.FINE, "Tab monitor: driver error, stopping", e);
                        break;
                    }
                }
            } catch (InterruptedException ie) {}
            LOGGER.info("Tab monitor stopped for session " + sid);
        }, "tab-close-monitor");
        tabMonitorThread.setDaemon(true);
        tabMonitorThread.start();
    }

    private void stopTabMonitor() {
        if (tabMonitorThread != null) {
            tabMonitorThread.interrupt();
            tabMonitorThread = null;
        }
    }

    private boolean isAppUrl(String url, String serverOrigin) {
        return serverOrigin != null && url != null && url.startsWith(serverOrigin);
    }

    private static String escapeJs(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\").replace("'", "\\'").replace("\n", "\\n").replace("\r", "\\r");
    }
}
