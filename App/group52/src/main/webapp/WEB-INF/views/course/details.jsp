<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Course Details</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            background-color: #F1F9F8 !important;
            margin-bottom: 80px !important;
            font-family: "IBM Plex Sans", sans-serif;
        }

        nav {
            background-color: #9BAEE9;
        }

        .navbar-brand {
            font-family: "IBM Plex Sans", sans-serif;
            font-weight: 600;
            color: black;
            font-size: 23px !important;
            transition: color 0.2s ease;
        }

        .navbar-brand:hover {
            color: white;
            cursor: pointer;
        }

        .nav-group {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .fa-bars {
            color: black;
            font-size: 33px;
            text-decoration: none;
            margin-left: 15px;
            transition: color 0.2s ease;
        }

        .fa-bars:hover {
            cursor: pointer;
            color: white;
        }
        .star-rating {
            display: flex;
            gap: 5px;
            font-size: 24px;
            cursor: pointer;
        }

        .star-rating i {
            color: #ccc;
            transition: color 0.2s ease;
        }

        .star-rating i.active {
            color: #fbc02d;
        }

        .dropdown-menu {
            display: none;
            position: absolute;
            top: 100%;
            right: 0;
            z-index: 1000;
            min-width: 180px;
            padding: 0.5rem 0;
            margin-top: 10px;
            background-color: white;
            border-radius: 8px;
            list-style: none;
            text-align: left;
        }

        .dropdown-menu.show {
            display: block;
            animation: snappyFade 0.15s cubic-bezier(0.2, 0, 0.2, 1) forwards;
        }

        .dropdown-item {
            font-family: "IBM Plex Sans", sans-serif;
        }

        @keyframes snappyFade {
            from { opacity: 0; transform: translateY(8px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        .dropdown-item:focus,
        .dropdown-item:active {
            background-color: transparent !important;
            color: inherit !important;
        }

        .profile-pic {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            object-fit: cover;
            border-color: black;
            border-style: solid;
            transition: color 0.2s ease;
        }

        .profile-pic:hover {
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            cursor: pointer;
        }

        .btn-group {
            padding-right: 10px;
        }

        /* ── Sidebar ── */
        .side-nav {
            position: fixed;
            top: 60px;
            bottom: 0;
            left: 0;
            background-color: #302B27;
            width: 200px;
            z-index: 1000;
        }

        .side-link {
            text-decoration: none;
            display: block;
            color: white;
            padding: 10px;
            font-family: "IBM Plex Sans", sans-serif;
            font-weight: 300;
            font-size: 23px;
        }

        .side-link:hover {
            background-color: rgba(255, 255, 255, 0.10);
            color: white;
            width: 100%;
        }
        .side-nav .admin-link-container {
            position: absolute;
            bottom: 0;
            width: 100%;
            left: 0;
            z-index: 1001;
        }

        .side-nav .admin-link-container a {
            display: block;
            padding: 10px;
            font-size: 20px;
            color: white;
            text-decoration: none;
            width: 100%;
        }

        .side-nav .admin-link-container a:hover {
            background-color: rgba(255, 255, 255, 0.1);
            color: white;
        }

        .details-content {
            padding-top: 40px;
            padding-bottom: 50px;
        }

        .course-details h2 {
            font-family: "IBM Plex Sans", sans-serif;
            font-weight: 500 !important;
            font-size: 30px !important;
        }

        .course-details h3 {
            font-family: "IBM Plex Sans", sans-serif;
            font-weight: 500 !important;
            font-size: 22px !important;
        }

        .course-details p {
            font-family: "IBM Plex Sans", sans-serif;
            font-weight: 300;
            font-size: 16px;
        }

        .progress-container {
            width: 100%;
            max-width: 500px;
            background: #e0e0e0;
            border-radius: 8px;
            overflow: hidden;
            margin: 12px 0;
            height: 28px;
            position: relative;
        }

        .progress-bar {
            height: 100%;
            background: #4caf50;
            transition: width 0.4s ease;
            border-radius: 8px 0 0 8px;
        }

        .progress-text {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 13px;
            font-weight: bold;
            color: #333;
        }

        .action-buttons {
            margin: 16px 0;
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .action-buttons button {
            padding: 8px 18px;
            font-size: 14px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            color: #fff;
        }

        #startResumeBtn {
            background: #1976d2;
        }

        #startResumeBtn:hover {
            background: #1565c0;
        }

        #markCompleteBtn {
            background: #388e3c;
        }

        #markCompleteBtn:hover {
            background: #2e7d32;
        }

        #resetProgressBtn {
            background: #d32f2f;
        }

        #resetProgressBtn:hover {
            background: #c62828;
        }

        button:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        @media (min-width: 900px) {
            .navbar {
                position: fixed !important;
                width: 100%;
                z-index: 1050;
            }

            .navbar-brand {
                padding-left: 10px;
            }

            .fa-bars {
                display: none;
            }

            .side-nav {
                position: fixed;
                top: 60px;
                bottom: 0;
                left: 0;
                display: block;
            }

            .side-link {
                font-size: 20px;
                margin-right: 20px;
                padding-top: 20px;
            }

            .details-content {
                padding-left: 200px;
                padding-top: 100px;
            }
        }

        /* --- CSS for notifications --- */

        .toast-notification {
            background: #ffffff;
            border-left: 5px solid #0f62fe;
            padding: 16px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1); /* Softer shadow like your site cards */
            border-radius: 8px;
            min-width: 280px;
            margin-bottom: 12px;
            font-family: "IBM Plex Sans", sans-serif;
            animation: snappyFade 0.3s ease forwards;
        }

        .toast-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 4px;
        }

        .toast-title {
            margin: 0;
            font-size: 15px;
            font-weight: 600;
            color: #161616;
            display: flex;
            align-items: center;
            gap: 8px;
        }


        .toast-title i {
            color: #0f62fe;
        }

        .toast-close {
            background: none;
            border: none;
            cursor: pointer;
            color: #999;
            font-size: 16px;
            transition: color 0.2s ease;
        }

        .toast-close:hover {
            color: #da1e28;
        }

        .toast-body {
            margin: 0;
            font-size: 14px;
            color: #4d4d4d;
            font-weight: 400;
            line-height: 1.4;
        }

        /* --- CSS for the notification bell and badge --- */

        #notificationBell {
            color: #161616 !important;
            transition: color 0.2s ease !important;
        }

        #notificationBell:hover {
            color: #ffffff !important;
        }

        #notificationBadge {
            background-color: #da1e28 !important;
            border: 2px solid #9BAEE9;
            font-weight: 700;
            padding: 4px 6px;
        }

        /* --- CSS for the clear all button --- */
        #clearAllNotisBtn {
            color: #0f62fe;
            font-weight: 600;
            text-decoration: none;
        }

        #clearAllNotisBtn:hover {
            color: #0043ce;
            text-decoration: underline;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/@phosphor-icons/web@2.1.1/src/regular/style.css"/>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:ital,wght@0,100..700;1,100..700&display=swap" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
</head>

<body>
<%--notifications container--%>
<div id="notificationContainer" style="position: fixed; top: 80px; right: 20px; z-index: 1060; display: flex; flex-direction: column; gap: 10px;"></div>
<%--heading section--%>
<nav class="navbar">
    <div class="nav-group">
        <a class="fa-solid fa-bars"></a>
        <a class="navbar-brand" href="${pageContext.request.contextPath}/dashboard">SkillsBuilder</a>
    </div>
    <div class="d-flex align-items-center gap-4" style="padding-right: 20px;">
        <div class="dropdown" id="notificationBoxContainer">
            <button class="btn-link text-dark position-relative p-0" id="notificationBell" style="border: none; background: transparent; text-decoration: none; font-size: 36px;cursor: pointer;">
                <i class="ph ph-bell"></i>
                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" id="notificationBadge" style="font-size: 0.6rem;display:none">0</span>
            </button>
            <div class="dropdown-menu dropdown-menu-end shadow border-0 mt-3" id="notificationInboxMenu"style="width: 320px;max-height: 400px;overflow-y:auto;padding: 0; ">

                <div class="d-flex justify-content-between align-items-center p-2 border-bottom" id="notiHeader">
                    <span style="font-weight: 600; font-size: 14px; margin-left: 8px;">Notifications</span>
                    <button id="clearAllNotisBtn" class="btn btn-sm btn-link text-danger text-decoration-none" style="font-size: 12px; display: none;" onclick="clearAllNotifications(event)">Clear All</button>
                </div>

                <div class="p-3 text-center text-muted" id="emptyInboxMsg" style="font-size: 14px;">No new notifications</div>
                <div id="inboxItems"></div> </div>
        </div>

    <div class="btn-group" id="profileContainer">
        <img id="profilePic" src="${userProfile.avatar}" alt="Profile" class="profile-pic">
        <ul class="dropdown-menu dropdown-menu-end shadow border-0 mt-2">
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile/${currentUser.id}"><i class="fa-solid fa-circle-user me-2"></i>View Profile</a></li>
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/editProfile/${currentUser.id}"><i class="fa-solid fa-user-pen me-2"></i>Edit Profile</a></li>
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/friends/${currentUser.id}"><i class="fa-solid fa-user-group me-2"></i>Friends</a></li>
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/account"><i class="fa-solid fa-gear me-2"></i>Account Details</a></li>
            <li><hr class="dropdown-divider"></li>
            <li>
                <form action="${pageContext.request.contextPath}/logout" method="post" style="margin:0;">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <button type="submit" class="dropdown-item text-danger" style="border:none;background:none;cursor:pointer;"><i class="fa-solid fa-power-off me-2"></i>Logout</button>
                </form>
            </li>
        </ul>
    </div>
    </div>

</nav>

<aside class="side-nav bg-dark">
    <div class="user-sidebar-links">
    <a href="${pageContext.request.contextPath}/dashboard" class="side-link">
        <i class="ph ph-house"></i> Home
    </a>

    <form action="${pageContext.request.contextPath}/streak/increment-courses" method="post" style="margin: 0; padding: 0;">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        <input type="hidden" name="timeZone" class="userTimeZone" value="UTC">
        <button type="submit" class="side-link" style="background: none; border: none; width: 100%; text-align: left; cursor: pointer; display: block; outline: none;">
            <i class="ph ph-books"></i> Courses
        </button>
    </form>

    <a href="${pageContext.request.contextPath}/goals" class="side-link">
        <i class="ph ph-calendar"></i> Goals
    </a>

    <a href="${pageContext.request.contextPath}/leaderboard" class="side-link">
        <i class="ph ph-chart-bar"></i> Leaderboard
    </a>

    <a href="${pageContext.request.contextPath}/guilds" class="side-link">
        <i class="ph ph-building-apartment"></i> Guilds
    </a>

    <a href="${pageContext.request.contextPath}/stats/userstats" class="side-link">
        <i class="ph ph-chart-bar-horizontal"></i> Stats
    </a>
    <a href="${pageContext.request.contextPath}/feedback" class="side-link">
        <i class="ph ph-newspaper"></i> Feedback
    </a>
    </div>

    <c:if test="${pageContext.request.isUserInRole('ROLE_ADMIN')}">
    <div class="admin-sidebar-links" style="display: none;">
        <a href="${pageContext.request.contextPath}/dashboard" class="side-link">
            <i class="ph ph-house"></i> Home
        </a>
        <a href="${pageContext.request.contextPath}/admin/users" class="side-link">
            <i class="ph ph-users"></i> Manage Users
        </a>
        <a href="${pageContext.request.contextPath}/admin/courses" class="side-link">
            <i class="ph ph-books"></i> Manage Courses
        </a>
        <a href="${pageContext.request.contextPath}/admin/inbox" class="side-link">
            <i class="ph ph-envelope-simple"></i> Admin Inbox
        </a>
    </div>

    <div class="spacer"></div>

    <div class="admin-link-container">
        <a href="#" id="adminModeToggle" class="side-link">
            <i class="ph ph-shield-check"></i> Admin
        </a>
    </div>
    </c:if>
</aside>

<section class="details-content">
    <div class="container">
        <div class="course-details">
            <h2>${course.name}</h2>
        <p><strong>Duration:</strong> ${course.formatDuration()}</p>
        <p><strong>Description:</strong> ${course.description}</p>
        <p><strong>Languages:</strong> ${course.formatLanguages()}</p>
        <p><strong>Eligibility:</strong> ${course.eligibility}</p>
        <p><strong>Category:</strong> ${course.category}</p>

        <span id="courseUrl" style="display:none">${course.url}</span>

        <h3>Course Progress</h3>
        <div class="progress-container">
            <div class="progress-bar" id="progressBar" data-progress="${progressPercent}" style="width:0%"></div>
            <div class="progress-text" id="progressText">${progressPercent}%</div>
        </div>
        <p id="timeInfo">
            <strong>Time spent:</strong> <span id="timeSpent">0</span> / <span id="timeTotal">0</span>
        </p>

        <div class="action-buttons">
            <button id="startResumeBtn">${hasStarted ? 'Resume' : 'Start'}</button>
            <button id="markCompleteBtn">Mark as Completed</button>
            <button id="resetProgressBtn">Reset Progress</button>
        </div>

        <div id="sessionPanel" style="display:none">
            <span id="status" style="display:none">No active session</span>
            <span id="sessionId" style="display:none">-</span>
            <span id="elapsed" style="display:none">0</span>
        </div>

    <script>
        const sessionStartEndpoint = '/sessions/start';
        const userId = '${currentUser != null ? currentUser.username : ""}';
        const courseId = '${course.id}';
        const durationSeconds = parseInt('${durationSeconds}') || 0;
        const courseOpenMode = '${courseOpenMode != null ? courseOpenMode : "popup"}';

        let currentTotalSeconds = parseInt('${totalElapsedSeconds}') || 0;
        let currentProgress = parseInt('${progressPercent}') || 0;
        let courseHasStarted = ('${hasStarted}' === 'true');

        function formatTime(seconds) {
            const h = Math.floor(seconds / 3600);
            const m = Math.floor((seconds % 3600) / 60);
            const s = seconds % 60;
            if (h > 0) return h + 'h ' + m + 'm ' + s + 's';
            if (m > 0) return m + 'm ' + s + 's';
            return s + 's';
        }

        function formatTimeNoSeconds(seconds) {
            const h = Math.floor(seconds / 3600);
            const m = Math.floor((seconds % 3600) / 60);
            if (h > 0) return h + 'h ' + m + 'm';
            return m + 'm';
        }

        function updateProgressUI(totalSec, pct) {
            currentTotalSeconds = totalSec;
            currentProgress = pct;
            document.getElementById('progressBar').style.width = pct + '%';
            document.getElementById('progressText').innerText = pct + '%';
            document.getElementById('timeSpent').innerText = (pct >= 100)
                ? formatTimeNoSeconds(totalSec)
                : formatTime(totalSec);
            document.getElementById('timeTotal').innerText = formatTimeNoSeconds(durationSeconds);
            document.getElementById('markCompleteBtn').disabled = (pct >= 100);
        }

        function updateStartResumeLabel() {
            document.getElementById('startResumeBtn').innerText = courseHasStarted ? 'Resume' : 'Start';
        }

        updateProgressUI(currentTotalSeconds, currentProgress);
        updateStartResumeLabel();

        async function refreshProgress() {
            try {
                const res = await fetch('/sessions/progress?courseId=' + encodeURIComponent(courseId));
                if (res.ok) {
                    const j = await res.json();
                    const total = parseInt(j.totalSeconds) || 0;
                    const pct = durationSeconds > 0 ? Math.min(100, Math.floor(total * 100 / durationSeconds)) : 0;
                    courseHasStarted = !!j.hasStarted;
                    updateProgressUI(total, pct);
                    updateStartResumeLabel();
                }
            } catch (e) { console.error('refreshProgress', e); }
        }

        setInterval(refreshProgress, 5000);

        document.getElementById('startResumeBtn').addEventListener('click', async () => {
            const courseUrl = document.getElementById('courseUrl').innerText;
            let sid = document.getElementById('sessionId').innerText || '';

            if (!courseHasStarted) {
                try {
                    await fetch('${pageContext.request.contextPath}/addCourse?courseId=' + encodeURIComponent(courseId), {
                        method: 'POST'
                    });
                } catch (e) {
                    console.error('AddCourse Error:', e);
                    document.getElementById('sessionId').innerText = 'Error adding course to dashboard.';
                    return;
                }
            }

            if (sid && sid !== '-') {
                try {
                    const chk = await fetch('/sessions/' + encodeURIComponent(sid));
                    if (chk.ok) {
                        const sj = await chk.json();
                        const st = (sj.status || '').toUpperCase();
                        if (st !== 'IN_PROGRESS') {
                            sid = '';
                            document.getElementById('sessionId').innerText = '-';
                        }
                    } else {
                        sid = '';
                        document.getElementById('sessionId').innerText = '-';
                    }
                } catch (e) {
                    console.warn('Could not check session status, will create new', e);
                    sid = '';
                    document.getElementById('sessionId').innerText = '-';
                }
            }

            if (!sid || sid === '-') {
                try {
                    const payload = { courseId: courseId, courseUrl };
                    const startRes = await fetch(sessionStartEndpoint, {
                        method: 'POST',
                        headers: { 'content-type': 'application/json' },
                        body: JSON.stringify(payload)
                    });
                    if (!startRes.ok) {
                        if (startRes.status === 401 || startRes.redirected) {
                            document.getElementById('status').innerText = 'Not authenticated — please login';
                            return;
                        }
                        document.getElementById('status').innerText = 'Failed to start session: ' + startRes.statusText;
                        return;
                    }
                    const j = await startRes.json();
                    sid = j.sessionId;
                    document.getElementById('sessionId').innerText = sid;
                    document.getElementById('status').innerText = 'Session started: ' + sid;
                    courseHasStarted = true;
                    updateStartResumeLabel();
                } catch (e) {
                    console.error('Failed to auto-start session before Selenium open', e);
                    document.getElementById('status').innerText = 'Failed to start session (network)';
                    return;
                }
            }

            if (courseOpenMode === 'tab') {
                try {
                    const res = await fetch('/selenium/open?url=' + encodeURIComponent(courseUrl)
                        + '&sessionId=' + encodeURIComponent(sid)
                        + '&mode=tab');
                    if (res.ok) {
                        document.getElementById('status').innerText = 'Opened in new tab via Selenium (session ' + sid + ')';
                        startPolling(sid);
                    } else {
                        const err = await res.text().catch(() => '');
                        document.getElementById('status').innerText = 'Selenium tab open failed: ' + (err || res.statusText);
                    }
                } catch (e) {
                    console.error(e);
                    document.getElementById('status').innerText = 'Failed to open tab via Selenium';
                }
            } else {
                try {
                    const res = await fetch('/selenium/open?url=' + encodeURIComponent(courseUrl) + '&sessionId=' + encodeURIComponent(sid));
                    if (res.ok) {
                        document.getElementById('status').innerText = 'Opened in Chrome via Selenium (session ' + sid + ')';
                        startPolling(sid);
                    } else {
                        const err = await res.text().catch(() => '');
                        document.getElementById('status').innerText = 'Selenium open failed: ' + (err || res.statusText);
                    }
                } catch (e) {
                    console.error(e);
                    document.getElementById('status').innerText = 'Failed to open via Selenium';
                }
            }
        });

        document.getElementById('markCompleteBtn').addEventListener('click', async () => {
            if (!confirm('Mark this course as completed? Progress will be set to 100%.')) return;
            try {
                const res = await fetch('/sessions/mark-complete?courseId=' + encodeURIComponent(courseId)
                    + '&durationSeconds=' + durationSeconds, { method: 'POST' });
                if (res.ok) {
                    updateProgressUI(durationSeconds, 100);
                    courseHasStarted = true;
                    updateStartResumeLabel();
                    await fetch('${pageContext.request.contextPath}/completeCourse?courseId=' + encodeURIComponent(courseId), {
                        method: 'POST'
                    });
                } else if (res.status === 401) {
                    alert('Please log in first.');
                }
            } catch (e) { console.error('markComplete error', e); }
        });

        document.getElementById('resetProgressBtn').addEventListener('click', async () => {
            if (!confirm('Reset all progress for this course? This cannot be undone.')) return;
            try {
                const res = await fetch('/sessions/reset-progress?courseId=' + encodeURIComponent(courseId),
                    { method: 'POST' });
                if (res.ok) {
                    updateProgressUI(0, 0);
                    courseHasStarted = false;
                    updateStartResumeLabel();
                    await fetch('${pageContext.request.contextPath}/resetCourse?courseId=' + encodeURIComponent(courseId), {
                        method: 'POST'
                    });
                    document.getElementById('sessionId').innerText = '-';
                } else if (res.status === 401) {
                    alert('Please log in first.');
                }
            } catch (e) { console.error('resetProgress error', e); }
        });

        let pollTimer = null;
        let clientTickTimer = null;
        let lastServerElapsed = 0;
        let clientIncrement = 0;
        let sessionOwnedByChild = false;

        function displayElapsed() {
            const total = lastServerElapsed + clientIncrement;
            document.getElementById('elapsed').innerText = total;
        }

        function startClientTick() {
            stopClientTick();
            clientTickTimer = setInterval(() => { clientIncrement++; displayElapsed(); }, 1000);
        }

        function stopClientTick() {
            if (clientTickTimer) {
                clearInterval(clientTickTimer);
                clientTickTimer = null;
            }
        }

        function startPolling(sid) {
            stopPolling();
            document.getElementById('status').innerText = 'Polling session ' + sid;
            document.getElementById('sessionId').innerText = sid;
            const doFetch = async () => {
                try {
                    const res = await fetch('/sessions/' + encodeURIComponent(sid));
                    if (res.ok) {
                        const j = await res.json();
                        lastServerElapsed = parseInt(j.elapsedSeconds) || 0;
                        clientIncrement = 0;
                        displayElapsed();
                        document.getElementById('status').innerText = 'Status: ' + j.status;
                        const serverStatus = (j.status || '').toString().toUpperCase();
                        if (serverStatus === 'COMPLETED') {
                            stopPolling();
                            document.getElementById('status').innerText = 'Completed (server)';
                            document.getElementById('sessionId').innerText = '-';
                            return;
                        }
                        try {
                            if (serverStatus === 'IN_PROGRESS' || serverStatus === 'RUNNING' || serverStatus === 'ACTIVE') {
                                startClientTick();
                            } else {
                                stopClientTick();
                            }
                        } catch (e) {
                            startClientTick();
                        }
                    } else {
                        document.getElementById('status').innerText = 'Session not found';
                        stopClientTick();
                    }
                } catch (e) {
                    console.error(e);
                }
            };
            doFetch();
            pollTimer = setInterval(doFetch, 5000);
        }

        function stopPolling() {
            if (pollTimer) {
                clearInterval(pollTimer);
                pollTimer = null;
            }
            stopClientTick();
        }

        let lastChildPingAt = 0;
        const CHILD_PING_TIMEOUT_MS = 30000;
        let pendingPauseTimer = null;
        const PENDING_PAUSE_MS = 3000;

        window.addEventListener('message', (ev) => {
            try {
                if (!ev.data) {
                    return;
                }
            } catch (e) {
                console.error(e);
            }
            try {
                const d = ev.data;
                console.log('parent received postMessage', d, 'origin=', ev.origin);
                if (d.type === 'skillsbuild-complete') {
                    const sid = d.sessionId;
                    document.getElementById('status').innerText = 'Completed via callback';
                    window._skillsbuild_completedViaCallback = true;
                    sessionOwnedByChild = false;
                    doComplete(sid, 'child-signalled-complete');
                    try {
                        if (window._skillsbuild_child) {
                            window._skillsbuild_child.close();
                        }
                    } catch (e) {
                        console.error(e);
                    }
                    return;
                }
                if (d.type === 'skillsbuild-ping') {
                    lastChildPingAt = Date.now();
                    document.getElementById('status').innerText = 'Child active - last ping ' + new Date(lastChildPingAt).toLocaleTimeString();
                    if (pendingPauseTimer) {
                        clearTimeout(pendingPauseTimer);
                        pendingPauseTimer = null;
                    }
                    return;
                }
                if (d.type === 'skillsbuild-focus') {
                    const sid = d.sessionId;
                    document.getElementById('status').innerText = 'Child focused';
                    try {
                        fetch('/sessions/resume?sessionId=' + encodeURIComponent(sid), { method: 'POST' });
                        startPolling(sid);
                    } catch (e) {
                        console.error(e);
                    }
                    return;
                }
                if (d.type === 'skillsbuild-unfocus') {
                    const sid = d.sessionId;
                    document.getElementById('status').innerText = 'Child unfocused - paused';
                    try {
                        fetch('/sessions/pause?sessionId=' + encodeURIComponent(sid), { method: 'POST' });
                    } catch (e) {
                        console.error(e);
                    }
                    stopClientTick();
                    return;
                }
                if (d.type === 'skillsbuild-closed') {
                    const sid = d.sessionId;
                    document.getElementById('status').innerText = 'Child reported closing - completing session';
                    if (!window._skillsbuild_completedViaCallback) {
                        try {
                            doComplete(sid, 'child-reported-closed');
                        } catch (e) {
                            console.error(e);
                        }
                    }
                    try {
                        if (window._skillsbuild_child) {
                            window._skillsbuild_child.close();
                        }
                    } catch (e) {
                        console.error(e);
                    }
                    return;
                }
            } catch (e) {
                console.error('message handler error', e);
            }
        });

        function startChildWatch(sid) {
            const poll = setInterval(() => {
                try {
                    if (lastChildPingAt && (Date.now() - lastChildPingAt) < CHILD_PING_TIMEOUT_MS) {
                        return;
                    }
                    const child = window._skillsbuild_child;
                    if (child && child.closed) {
                        clearInterval(poll);
                        if (!window._skillsbuild_completedViaCallback) {
                            try {
                                doComplete(sid, 'child-closed');
                            } catch (e) {
                                console.error(e);
                            }
                        }
                        sessionOwnedByChild = false;
                        document.getElementById('status').innerText = 'Child closed - completed';
                        return;
                    }
                    if (!child) {
                        if (!window._skillsbuild_completedViaCallback && !pendingPauseTimer) {
                            pendingPauseTimer = setTimeout(async () => {
                                clearInterval(poll);
                                document.getElementById('status').innerText = 'No child detected - pausing session';
                                try {
                                    await fetch('/sessions/pause?sessionId=' + encodeURIComponent(sid), { method: 'POST' });
                                } catch (e) {
                                    console.error('auto-pause failed', e);
                                }
                                sessionOwnedByChild = false;
                            }, PENDING_PAUSE_MS);
                        }
                        return;
                    }
                    if (!window._skillsbuild_completedViaCallback && !pendingPauseTimer) {
                        pendingPauseTimer = setTimeout(async () => {
                            document.getElementById('status').innerText = 'Child present but not pinging - pausing session';
                            try {
                                await fetch('/sessions/pause?sessionId=' + encodeURIComponent(sid), { method: 'POST' });
                            } catch (e) {
                                console.error('auto-pause failed', e);
                            }
                            sessionOwnedByChild = false;
                        }, PENDING_PAUSE_MS);
                    }
                } catch (e) {
                    clearInterval(poll);
                    console.error('Child watch error', e);
                }
            }, 1000);
            setTimeout(() => {
                if (!lastChildPingAt || (Date.now() - lastChildPingAt) >= CHILD_PING_TIMEOUT_MS) {
                    if (!window._skillsbuild_completedViaCallback && !pendingPauseTimer) {
                        pendingPauseTimer = setTimeout(async () => {
                            document.getElementById('status').innerText = 'No child ping received - pausing session';
                            try {
                                await fetch('/sessions/pause?sessionId=' + encodeURIComponent(sid), { method: 'POST' });
                            } catch (e) {
                                console.error('auto-pause failed', e);
                            }
                            sessionOwnedByChild = false;
                        }, PENDING_PAUSE_MS);
                    }
                }
            }, CHILD_PING_TIMEOUT_MS + 2000);
        }

        window.addEventListener('focus', async () => {
            try {
                if (pendingPauseTimer) {
                    clearTimeout(pendingPauseTimer);
                    pendingPauseTimer = null;
                }
                const sid = document.getElementById('sessionId').innerText;
                if (!sid || sid === '-') {
                    return;
                }
                const child = window._skillsbuild_child;
                if (child) {
                    return;
                }
                document.getElementById('status').innerText = 'Parent focused - session awaiting explicit resume';
            } catch (e) {
                console.error(e);
            }
        });

        function doComplete(sid, reason) {
            try {
                console.log('doComplete invoked: session=', sid, 'reason=', reason);
                fetch('/sessions/complete?sessionId=' + encodeURIComponent(sid), { method: 'POST' })
                    .then(() => { console.log('complete request sent for', sid); startPolling(sid); })
                    .catch((e) => { console.error('complete request failed', e); startPolling(sid); });
            } catch (e) {
                console.error('doComplete error', e);
            }
        }

            </script>
            <div class="mt-5">
                <h3>Course Reviews</h3>

                <c:choose>
                    <c:when test="${not empty reviews}">
                        <c:forEach var="review" items="${reviews}">
                            <div class="card mb-3 shadow-sm">
                                <div class="card-body">
                                    <c:if test="${review.user.id == currentUser.id}">

                                        <div class="position-absolute"
                                             style="top:10px; right:10px;">

                                            <div class="d-flex gap-2">

                                                <!-- Edit -->
                                                <a href="${pageContext.request.contextPath}/courses/details/${course.id}?editId=${review.id}"
                                                   class="btn btn-sm btn-outline-primary">
                                                    Edit
                                                </a>

                                                <!-- Delete -->
                                                <form action="${pageContext.request.contextPath}/courses/reviews/delete"
                                                      method="post"
                                                      class="m-0">

                                                    <input type="hidden" name="reviewId" value="${review.id}" />
                                                    <input type="hidden" name="courseId" value="${course.id}" />
                                                    <input type="hidden"
                                                           name="${_csrf.parameterName}"
                                                           value="${_csrf.token}" />

                                                    <button type="submit"
                                                            class="btn btn-sm btn-outline-danger"
                                                            onclick="return confirm('Are you sure you want to delete?');">
                                                        Delete
                                                    </button>

                                                </form>

                                            </div>

                                        </div>

                                    </c:if>

                                    <c:if test="${not empty editId && editId == review.id}">

                                        <form action="${pageContext.request.contextPath}/courses/reviews/edit"
                                              method="post">

                                            <input type="hidden" name="reviewId" value="${review.id}" />
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                                            <h5>${review.user.username}</h5>

                                            <textarea name="comment" class="form-control mb-2">${review.comment}</textarea>

                                            <input type="number" name="rating"
                                                   value="${review.rating}"
                                                   min="1" max="5"
                                                   class="form-control mb-2"/>

                                            <div class="d-flex gap-2">
                                                <button type="submit" class="btn btn-success btn-sm">Update</button>

                                                <a href="${pageContext.request.contextPath}/courses/details/${course.id}"
                                                   class="btn btn-secondary btn-sm">
                                                    Cancel
                                                </a>
                                            </div>

                                        </form>

                                    </c:if>


                                    <c:if test="${empty editId || editId != review.id}">

                                        <h5>${review.user.username}</h5>

                                        <small>
                                            <c:forEach begin="1" end="${review.rating}">
                                                <i class="fa-solid fa-star text-warning"></i>
                                            </c:forEach>
                                        </small>

                                        <p>${review.comment}</p>

                                    </c:if>



                                </div>
                            </div>
                        </c:forEach>
                    </c:when>

                    <c:otherwise>
                        <p>No reviews yet.</p>
                    </c:otherwise>
                </c:choose>
                <!Review form -->
                <form action="${pageContext.request.contextPath}/courses/${course.id}/review" method="post" class="mb-4">
                    <input type="hidden" name="courseId" value="${course.id}" />
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                    <div class="mb-3">
                        <label class="form-label">Comment</label>
                        <textarea class="form-control" name="comment" rows="3"></textarea>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Rating</label>

                        <div class="star-rating">
                            <i class="fa-regular fa-star" data-value="1"></i>
                            <i class="fa-regular fa-star" data-value="2"></i>
                            <i class="fa-regular fa-star" data-value="3"></i>
                            <i class="fa-regular fa-star" data-value="4"></i>
                            <i class="fa-regular fa-star" data-value="5"></i>
                        </div>

                        <input type="hidden" name="rating" id="ratingValue" required>
                    </div>

                    <button type="submit" class="btn btn-primary">Submit</button>
                </form>
            </div>




        </div>
    </div>
</section>

<script>
    $(document).ready(function() {
        $('.fa-bars').click(function() {
            $('.side-nav').slideToggle(350);
        });

        $(window).resize(function() {
            if ($(window).width() >= 900) {
                $('.side-nav').removeAttr('style');
            }
        });

        $('#profilePic').on('click', function() {
            $('.dropdown-menu').toggleClass('show');
        });

        $(document).on('click', function(e) {
            if (!$(e.target).closest('#profileContainer').length) {
                $('.dropdown-menu').removeClass('show');
            }
        });

        const timeZoneInput = document.querySelectorAll('.userTimeZone');
        timeZoneInput.forEach(input => {
            input.value = Intl.DateTimeFormat().resolvedOptions().timeZone;
        });
        // Star rating interactivity
        $(document).ready(function() {
            const stars = $('.star-rating i');
            const ratingInput = $('#ratingValue');

            stars.on('mouseenter', function() {
                const val = $(this).data('value');
                stars.each(function() {
                    $(this).toggleClass('active', $(this).data('value') <= val);
                });
            });

            stars.on('mouseleave', function() {
                const currentVal = parseInt(ratingInput.val()) || 0;
                stars.each(function() {
                    $(this).toggleClass('active', $(this).data('value') <= currentVal);
                });
            });

            stars.on('click', function() {
                const val = $(this).data('value');
                ratingInput.val(val);
                stars.each(function() {
                    $(this).toggleClass('active', $(this).data('value') <= val);
                });
            });
        });
    });


</script>
<script>const currentUserId = '<c:out value="${currentUser.id}"/>';</script>

<script src="${pageContext.request.contextPath}/js/notifications.js?v=1.01"></script>
<script src="${pageContext.request.contextPath}/js/sidebar-toggle.js"></script>
</body>

</html>
