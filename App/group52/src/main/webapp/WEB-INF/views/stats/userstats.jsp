<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="countCyber" value="0" />
<c:set var="countArtInt" value="0" />
<c:set var="countData" value="0" />
<c:set var="countCloud" value="0" />
<c:set var="countWeb" value="0" />
<c:set var="countProf" value="0" />
<c:set var="countSustain" value="0" />
<c:set var="countJob" value="0" />
<c:set var="countQuantum" value="0" />
<c:set var="countMainframe" value="0" />

<c:forEach var="c" items="${completedCourses}">
    <c:choose>
        <c:when test="${c.courseCategory == 'Cybersecurity'}"><c:set var="countCyber" value="${countCyber + 1}" /></c:when>
        <c:when test="${c.courseCategory == 'Artificial Intelligence'}"><c:set var="countArtInt" value="${countArtInt + 1}" /></c:when>
        <c:when test="${c.courseCategory == 'Data Science'}"><c:set var="countData" value="${countData + 1}" /></c:when>
        <c:when test="${c.courseCategory == 'Cloud Computing'}"><c:set var="countCloud" value="${countCloud + 1}" /></c:when>
        <c:when test="${c.courseCategory == 'Web Development'}"><c:set var="countWeb" value="${countWeb + 1}" /></c:when>
        <c:when test="${c.courseCategory == 'Professional Skills'}"><c:set var="countProf" value="${countProf + 1}" /></c:when>
        <c:when test="${c.courseCategory == 'Sustainability'}"><c:set var="countSustain" value="${countSustain + 1}" /></c:when>
        <c:when test="${c.courseCategory == 'Job Readiness'}"><c:set var="countJob" value="${countJob + 1}" /></c:when>
        <c:when test="${c.courseCategory == 'Quantum Computing'}"><c:set var="countQuantum" value="${countQuantum + 1}" /></c:when>
        <c:when test="${c.courseCategory == 'Mainframe'}"><c:set var="countMainframe" value="${countMainframe + 1}" /></c:when>
    </c:choose>
</c:forEach>
<!DOCTYPE HTML>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            background-color: #F1F9F8 !important;
            margin-bottom: 80px !important;
        }

        /*Navbar*/
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
            from {
                opacity: 0;
                transform: translateY(8px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .dropdown-item:focus,
        .dropdown-item:active {
            background-color: transparent !important;
            color: inherit !important;
        }

        .fa-bars:hover {
            cursor: pointer;
            color: white;
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

        /*Side Bar*/
        .side-nav {
            background-color: #302B27;
            display: none;
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
            background-color: rgba(255, 255, 255, 0.10) !important;
            color: white;
            width: 100%;
        }

        h1 {
            font-family: "IBM Plex Sans", sans-serif;
            font-weight: 500 !important;
            margin-right: 20px;
            margin-left: 20px;
            font-size: 40px !important;
        }

        h2 {
            font-family: "IBM Plex Sans", sans-serif;
            font-weight: 400 !important;
            margin-right: 20px;
            margin-left: 20px;
            font-size: 30px !important;
        }


        h4 {
            font-family: "IBM Plex Sans", sans-serif;
            font-size: 23px !important;
        }


        h5 {
            font-family: "IBM Plex Sans", sans-serif;
            font-weight: 600 !important;
            font-size: 20px !important;
        }


        h3 {
            font-family: "IBM Plex Sans", sans-serif;
            font-weight: 350 !important;
        }

        /*User-stats*/
        .user-stats {
            padding-top: 40px;
            align-items: center;
            padding-bottom: 50px;
        }
        .stats-card {
            background-color: white;
            border-radius: 16px;
            padding: 25px;
            margin-top: 20px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
            max-width: 800px;
        }
        .output-card {
            text-align: left !important;
            max-width: 100% !important;
            width: 100% !important;
        }
        .course-category-section {
            min-width: fit-content;
            white-space: nowrap;
        }
        .category-tag {
            display: inline-block !important;
            white-space: nowrap !important;
            word-break: keep-all !important;
            margin-bottom: 5px;
        }

        .stats-card h3 {
            margin-bottom: 15px;
        }

        .stats-btn {
            font-family: "IBM Plex Sans", sans-serif;
            width: 300px !important;
            border-radius: 30px !important;
            background-color: #9BAEE9 !important;
            color: white !important;
        }
        .stats-btn:hover {
            background-color: #7993E2 !important;
        }

        .chart-card {
            border-radius: 16px !important;
        }
        /*Courses section*/
        .stats-output {
            font-family: "IBM Plex Sans", sans-serif;
            white-space: pre-wrap;
            line-height: 1.2 !important;
            font-size: 16px;
        }

        .course-row-body {
            flex: 1;
            padding: 15px 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .course-card {
            border-radius: 20px !important;
        }

        .course-category-section {
            text-align: right;
        }

        .category-tag {
            background-color: #E0E0E0;
            color: #4D4D4D;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
            text-transform: uppercase;
            font-family: "IBM Plex Sans", sans-serif;

        }

        @media (min-width: 768px) {
            h3 {
                font-size: 25px !important;
            }

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

            section {
                padding-left: 200px;
            }

        }

        @media (min-width: 992px) {
            h1 {
                padding-top: 50px !important;
                font-size: 35px !important;
            }

        }
        /* Admin button at the bottom */
        .side-nav .admin-link-container {
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
        }

        /* Full clickable row */
        .side-nav .admin-link-container a {
            display: block;
            padding: 10px;
            font-size: 20px;
            color: white;
            text-decoration: none;
        }

        /* Hover effect */
        .side-nav .admin-link-container a:hover {
            background-color: rgba(255, 255, 255, 0.1);
            color: white;
        }

        /*Fonts*/
        .ibm-plex-sans {
            font-family: "IBM Plex Sans", sans-serif;
            font-optical-sizing: auto;
            font-weight: 600;
            font-style: normal;
            font-variation-settings:
                    "wdth" 100;
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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/@phosphor-icons/web@2.1.1/src/regular/style.css"/>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:ital,wght@0,100..700;1,100..700&display=swap" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"></script>
    <title>Stats</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
</head>

<body>

<div id="notificationContainer" style="position: fixed; top: 80px; right: 20px; z-index: 1060; display: flex; flex-direction: column; gap: 10px;"></div>

<div aria-live="polite" aria-atomic="true" class="position-relative">
    <div class="toast-container position-fixed bottom-0 end-0 p-3" style="z-index: 1100;">
        <div id="appToast" class="toast align-items-center text-white bg-success border-0" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="d-flex">
                <div class="toast-body" id="appToastBody">Message</div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
        </div>
    </div>
</div>

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


        <%--profile button--%>
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

<section class="user-stats">
    <div class="container-fluid px-xl-4">
        <h1 class="mb-5">${username}'s Stats:</h1>

        <div class="container-fluid px-xl-4">
            <h2 class="course-list mb-3 mt-4">In Progress Courses</h2>
            <c:choose>
                <c:when test="${not empty Courses}">
                    <div class="row courses mb-5">
                        <c:forEach var="course" items="${Courses}">
                            <div class="col-12 mb-3">
                                <div class="card shadow-sm course-card h-100">
                                    <div class="course-row-body">
                                        <h3 class="card-title text-center">${course.courseName}</h3>
                                        <div class="course-category-section">
                                            <span class="category-tag">${course.courseCategory}</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>

                <c:otherwise>
                    <div class="text-center warning-text pt-5 pb-5">
                        <h5 class="text-muted">You Currently have no courses in progress.</h5>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="container-fluid px-xl-4">
            <h2 class="course-list mb-3">Completed Courses</h2>
            <c:choose>
                <c:when test="${not empty completedCourses}">
                    <div class="row courses">
                        <c:forEach var="courses" items="${completedCourses}">
                            <div class="col-12 mb-3">
                                <div class="card shadow-sm course-card h-100">
                                    <div class="course-row-body">
                                        <h3 class="card-title text-center">${courses.courseName}</h3>
                                        <div class="course-category-section">
                                            <span class="category-tag">${courses.courseCategory}</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>

                <c:otherwise>
                    <div class="text-center warning-text pt-5 pb-5">
                        <h5 class="text-muted">You have not completed any courses yet.</h5>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="container-fluid px-xl-4">
            <h2 class="course-list mb-3 mt-5">Completions by Category</h2>
            <div class="card shadow-sm border-0 chart-card mb-4 pt-3">
                <div class="card-body">
                    <div style="position: relative; height:300px;">
                        <canvas id="horizontalCompletionsChart"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <div class="container-fluid text-center mt-4">
            <form id="statsForm" action="${pageContext.request.contextPath}/stats/ask" method="get">
                <button type="submit" id="generateBtn" class="btn stats-btn btn-lg mt-1 text-center"><i class="ph ph-magic-wand"></i> Generate AI Feedback</button>
            </form>

            <div id="loaderArea" class="d-none mt-4">
                <div class="spinner-border" style="width: 3rem; height: 3rem; color: #9BAEE9" role="status">
                    <span class="visually-hidden"></span>
                </div>
            </div>

            <div id="aiResultCard" class="stats-card output-card mt-4 d-none">
                <h3>Your AI Learning Analysis</h3>
                <pre id="aiOutput" class="stats-output"></pre>
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

        $('#profilePic').on('click', function(e) {
            e.stopPropagation();
            $('#profileContainer .dropdown-menu').toggleClass('show');
        });

        $(document).on('click', function(e) {
            if (!$(e.target).closest('#profileContainer').length) {
                $('#profileContainer .dropdown-menu').removeClass('show');
            }
        });

        $('#statsForm').on('submit', async function(e) {
            e.preventDefault();

            const $loader = $('#loaderArea');
            const $resultCard = $('#aiResultCard');
            const $output = $('#aiOutput');

            $loader.removeClass('d-none').hide().fadeIn(300);
            $resultCard.fadeOut(200);

            try {
                const response = await fetch($(this).attr('action'));
                const data = await response.text();
                $output.html(data);
                $loader.fadeOut(200, function() {
                    $(this).addClass('d-none');
                    $resultCard.removeClass('d-none').hide().fadeIn(600);
                });
            } catch (error) {
                console.error("Fetch Error:", error);
            }
        });

        const timeZoneInput = document.querySelectorAll('.userTimeZone');
        timeZoneInput.forEach(input => {
            input.value = Intl.DateTimeFormat().resolvedOptions().timeZone;
        });

        const ctx = document.getElementById('horizontalCompletionsChart');

        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: [
                    'Cybersecurity', 'Artificial Intelligence', 'Data Science',
                    'Cloud Computing', 'Web Development', 'Professional Skills',
                    'Sustainability', 'Job Readiness', 'Quantum Computing', 'Mainframe'
                ],
                datasets: [{
                    data: [
                        ${countCyber}, ${countArtInt}, ${countData},
                        ${countCloud}, ${countWeb}, ${countProf}, ${countSustain},
                        ${countJob}, ${countQuantum}, ${countMainframe}
                    ],
                    backgroundColor: '#9BAEE9',
                    borderRadius: 4,
                    barThickness: 15
                }]
            },
            options: {
                indexAxis: 'y',
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false }
                },
                scales: {
                    x: {
                        min: 0,
                        max: 20,
                        ticks: {
                            stepSize: 1,
                            precision: 0
                        },
                        grid: { color: '#f0f0f0' }
                    },
                    y: {
                        grid: { display: false },
                        ticks: {
                            font: { family: 'IBM Plex Sans', size: 11, weight: '600' }
                        }
                    }
                }
            }
        });
    });

</script>
<script>const currentUserId = '<c:out value="${currentUser.id}"/>';</script>
<script src="${pageContext.request.contextPath}/js/notifications.js?v=1.01"></script>
<script src="${pageContext.request.contextPath}/js/sidebar-toggle.js"></script>
</body>
</html>
