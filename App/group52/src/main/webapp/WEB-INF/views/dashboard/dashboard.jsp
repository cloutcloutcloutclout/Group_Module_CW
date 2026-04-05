<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
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

        .side-nav .spacer{
            flex-grow: 1;
        }

        .side-link:hover {
            background-color: rgba(255, 255, 255, 0.10) !important;
            color: white;
            width: 100%;
        }

        /*User info*/
        .user-info {
            padding-top: 40px;
            align-items: center;
            padding-bottom: 50px;
        }

        .streak {
            color: orange;
            font-size: 20px;
            font-weight: 600;
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

        .ph-medal {
            font-size: 130px !important;
            color: #0f62fe;
        }

        .user-card {
            padding-top: 40px;
            padding-bottom: 40px;
            border-bottom: #9BAEE9 solid 10px !important;
        }

        .info-card {
            border-bottom: #9BAEE9 solid 5px !important;
        }

        .ph-trophy {
            color: green !important;
            font-size: 40px !important;
        }

        .ph-lightning {
            color: #FFBC0A !important;
            font-size: 40px !important;
        }

        h4 {
            font-family: "IBM Plex Sans", sans-serif;
            font-size: 23px !important;
        }

        /*Courses*/
        .Courses {
            padding-top: 20px;
            margin-bottom: 10px !important;
            position: relative;
        }

        .course-list, .badges-section, .goals-section {
            margin-bottom: 20px !important;
        }

        .warning-text {
            margin-bottom: 50px !important;
        }

        h5 {
            font-family: "IBM Plex Sans", sans-serif;
            font-weight: 600 !important;
            font-size: 20px !important;
        }

        .Courses::before {
            content: "";
            position: absolute;
            top: 0;
            left: 10%;
            right: 10%;
            height: 1px;
            background-color: rgba(0, 0, 0, 0.1);
        }

        .card {
            border-radius: 10px !important;
            margin-right: 20px;
            margin-left: 20px;
            margin-top: 10px;
        }

        .course-card {
            transition:
                    transform 0.4s cubic-bezier(0.22, 1, 0.36, 1),
                    box-shadow 0.4s cubic-bezier(0.22, 1, 0.36, 1);

        }

        .course-card:hover {
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            cursor: pointer;
            transform: translateY(-8px);
        }

        h3 {
            font-family: "IBM Plex Sans", sans-serif;
            font-weight: 500 !important;
        }

        .card-subtitle {
            font-family: "IBM Plex Sans", sans-serif;
        }

        .card-text {
            font-family: "IBM Plex Sans", sans-serif;
            font-weight: 300 !important;
        }

        /*badges*/
        .badges {
            padding-top: 20px;
            margin-bottom: 10px !important;
            position: relative;
        }

        .badges::before {
            content: "";
            position: absolute;
            top: 0;
            left: 10%;
            right: 10%;
            height: 1px;
            background-color: rgba(0, 0, 0, 0.1);
        }

        .goals {
            padding-top: 20px;
            margin-bottom: 10px !important;
            position: relative;
        }

        .goals::before {
            content: "";
            position: absolute;
            top: 0;
            left: 10%;
            right: 10%;
            height: 1px;
            background-color: rgba(0, 0, 0, 0.1);
        }

        .badge-card {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            margin-top: 30px !important;
            padding-top: 30px;
            padding-bottom: 0px;
        }

        .badge-streak-7 {
            filter: drop-shadow(0px 8px 10px rgba(15, 98, 254, 0.5));
        }

        .badge-streak-15 {
            filter: hue-rotate(280deg) saturate(1.5) drop-shadow(0px 8px 10px rgba(0, 180, 80, 0.5));
        }

        .badge-streak-30 {
            filter: sepia(1) saturate(5) hue-rotate(10deg) brightness(1.2) drop-shadow(0px 8px 10px rgba(205, 127, 50, 0.5));
        }

        .badge-rank-1 {
            filter: drop-shadow(0px 8px 10px rgba(255, 215, 0, 0.6));
        }

        .badge-rank-2 {
            filter: drop-shadow(0px 8px 10px rgba(192, 192, 192, 0.6));
        }

        .badge-rank-3 {
            filter: drop-shadow(0px 8px 10px rgba(205, 127, 50, 0.6));
        }

        .badge-icon {
            width: 60% !important;
            padding-top: 30px;
        }

        /*Completed Courses*/
        .completed-courses {
            padding-top: 20px;
            margin-bottom: 10px !important;
            position: relative;
        }
        .course-complete-p {
            font-size: 16px !important;
        }

        .completed-courses::before {
            content: "";
            position: absolute;
            top: 0;
            left: 10%;
            right: 10%;
            height: 1px;
            background-color: rgba(0, 0, 0, 0.1);
        }

        @media (min-width: 768px) {
            h3 {
                font-size: 25px !important;
            }

            .card {
                width: 100%;
            }

            .card-subtitle {
                font-size: 15px;
            }

            .card-text {
                font-size: 15px;
            }

            .courses {
                margin-right: 30px !important;
            }

            .card {
                margin: 0;
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
                z-index: 1000;
            }

            .side-link {
                font-size: 20px;
                margin-right: 20px;
                padding-top: 20px;
            }

            section {
                padding-left: 200px;
            }

            .user-info {
                padding-top: 100px;
            }

            .Courses::before {
                left: calc(200px + 5%);
                right: 5%;
            }

            .badges::before {
                left: calc(200px + 5%);
                right: 5%;
            }

            .goals::before {
                left: calc(200px + 5%);
                right: 5%;
            }

            .completed-courses::before {
                left: calc(200px + 5%);
                right: 5%;
            }
        }

        @media (min-width: 992px) {
            h1 {
                padding-top: 50px !important;
                font-size: 35px !important;
            }

            .welcome-message {
                margin-right: 70px;
                margin-left: 50px;
            }

            .card-1 {
                margin-top: 50px;
            }
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
    <title>Dashboard</title>
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



<section class="user-info">
    <div class="container">
        <div class="row g-4 align-items-stretch">
            <div class="col-12 col-lg-3 text-center welcome-message">
                <h1 class="welcome">Welcome ${username}!</h1>
                <p class="lead">
                    Hope you are ready for another day of learning!
                </p>
                <p class="streak">
                    <i class="ph ph-flame"></i>
                    Your Current streak is: ${currentUser.currentStreak}
                </p>
            </div>
            <div class="col-12 col-lg-3">
                <div class="card shadow-sm user-card">
                    <div class="card-body text-center justify-content-center">
                        <i class="ph ph-medal"></i>
                        <h4 class="card-title fw-bold mt-3">
                            Badges Earned: ${badgeCount}
                        </h4>
                    </div>
                </div>
            </div>
            <div class="col-12 col-lg-4">
                <div class="row g-4">
                    <div class="col-12">
                        <div class="card info-card card-1 shadow-sm">
                            <div class="card-body d-flex align-items-center">
                                <i class="ph ph-trophy me-3"></i>
                                <div>
                                    <h4 class="card-title fw-bold mb-0">
                                        Global Rank: #${rank}
                                    </h4>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-12">
                        <div class="card info-card shadow-sm">
                            <div class="card-body d-flex align-items-center">
                                <i class="ph ph-lightning me-3"></i>
                                <div>
                                    <h4 class="card-title fw-bold mb-0">
                                        Points: ${points}
                                    </h4>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="Courses">
    <div class="container-fluid px-xl-4">
        <h2 class="course-list">Your Courses</h2>
        <c:choose>
            <c:when test="${not empty Courses}">
                <div class="row courses">
                    <c:forEach var="course" items="${Courses}">
                        <div class="col-12 col-md-6 col-lg-4 col-xl-3 mb-4">
                            <div class="card shadow-sm course-card h-100">
                                <img src=${course.image} class="card-img-top">
                                <div class="card-body text-center">
                                    <h3 class="card-title text-center">${course.courseName}</h3>
                                    <p class="card-subtitle text-muted text-center">Category: ${course.courseCategory}</p>
                                    <a href="${pageContext.request.contextPath}/courses/details/${course.courseId}" class="btn btn-block w-100 btn-primary mt-2">Continue Course</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>

            <c:otherwise>
                <div class="text-center warning-text pt-5 pb-5">
                    <h5 class="text-muted">You Currently have no courses.</h5>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</section>

<section class="goals">
    <div class="container-fluid px-xl-4 pb-4">
        <h2 class="goals-section">Your Goals</h2>
        <c:choose>
            <c:when test="${not empty userGoals}">
                <div class="row gy-4">
                    <c:forEach var="goal" items="${userGoals}">
                        <div class="col-12 col-md-6 col-lg-4 col-xl-3">
                            <div class="card shadow-sm h-100" style="border-left: 5px solid ${goal.color};">
                                <div class="card-body d-flex flex-column" style="padding-top: 20px;">
                                    <h5 class="card-title text-truncate" style="font-size:16px; margin-bottom:5px; font-family: 'IBM Plex Sans', sans-serif;" title="${goal.courseName}">${goal.courseName}</h5>
                                    <p class="card-subtitle text-muted" style="font-size:14px; margin-top:10px; margin-bottom:5px; line-height:1.2; font-family: 'IBM Plex Sans', sans-serif;">
                                        <i class="fa-regular fa-calendar me-1"></i> Start: ${goal.formattedStartDate}
                                    </p>
                                    <p class="card-subtitle text-muted" style="font-size:14px; margin-bottom:10px; line-height:1.2; font-family: 'IBM Plex Sans', sans-serif;">
                                        <i class="fa-regular fa-calendar-check me-1"></i> Target: ${goal.formattedTargetDate}
                                    </p>
                                    <p class="card-subtitle text-muted" style="font-size:14px; margin-top:5px; margin-bottom:2px; font-family: 'IBM Plex Sans', sans-serif;">Status: ${goal.formattedStatus}</p>
                                    <p class="card-subtitle text-muted mb-0" style="font-size:14px; font-family: 'IBM Plex Sans', sans-serif;">Progress: ${goal.calculatedProgress}% (${goal.completedCoursesCount}/${goal.totalCoursesCount} courses)</p>
                                    <div class="progress mt-3 mb-3" style="height: 6px; border-radius: 3px; background-color: #e9ecef;" title="${goal.calculatedProgress}%">
                                        <div class="progress-bar" role="progressbar" style="width: ${goal.calculatedProgress}%; background-color: ${goal.color};" aria-valuenow="${goal.calculatedProgress}" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>
                                    <button class="btn btn-sm btn-outline-primary mt-auto w-100" style="font-family: 'IBM Plex Sans', sans-serif;" data-bs-toggle="modal" data-bs-target="#viewGoalModal-${goal.id}">View Details</button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <c:forEach var="goal" items="${userGoals}">
                    <div class="modal fade" id="viewGoalModal-${goal.id}" tabindex="-1" aria-labelledby="viewGoalLabel-${goal.id}" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="viewGoalLabel-${goal.id}">${goal.courseName}</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <div class="mb-3">
                                        <p class="mb-1"><strong>Start Date:</strong> ${goal.formattedStartDate}</p>
                                        <p class="mb-1"><strong>Target Date:</strong> ${goal.formattedTargetDate}</p>
                                        <p class="mb-1"><strong>Status:</strong> ${goal.formattedStatus}</p>
                                        <p class="mb-1"><strong>Overall Progress:</strong> ${goal.calculatedProgress}%</p>
                                        <div class="progress mt-2" style="height: 10px; border-radius: 5px; background-color: #e9ecef;">
                                            <div class="progress-bar" role="progressbar" style="width: ${goal.calculatedProgress}%; background-color: ${goal.color};" aria-valuenow="${goal.calculatedProgress}" aria-valuemin="0" aria-valuemax="100"></div>
                                        </div>
                                    </div>
                                    <hr>
                                    <h6 class="mb-3">Associated Courses</h6>
                                    <c:choose>
                                        <c:when test="${not empty goal.associatedCourseDetails}">
                                            <ul class="list-group">
                                                <c:forEach var="cinfo" items="${goal.associatedCourseDetails}">
                                                    <li class="list-group-item" style="font-family: 'IBM Plex Sans', sans-serif;">
                                                        <div class="d-flex justify-content-between align-items-center mb-1">
                                                            <h6 class="mb-0" style="font-size:15px;">${cinfo.courseName}</h6>
                                                            <span class="badge bg-secondary rounded-pill">${cinfo.progressPercentage}%</span>
                                                        </div>
                                                        <div class="progress" style="height: 6px; border-radius: 3px;">
                                                            <div class="progress-bar bg-success" role="progressbar" style="width: ${cinfo.progressPercentage}%;" aria-valuenow="${cinfo.progressPercentage}" aria-valuemin="0" aria-valuemax="100"></div>
                                                        </div>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </c:when>
                                        <c:otherwise>
                                            <p class="text-muted" style="font-size: 14px;">No associated courses.</p>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-warning me-auto" data-goal-id="${goal.id}" data-goal-name="${goal.courseName}" data-goal-start="${goal.startDate}" data-goal-target="${goal.targetDate}" data-goal-color="${goal.color}" data-goal-courseid="${goal.courseId}" onclick="openEditGoalModal(this)">Edit Goal</button>
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="text-center warning-text pt-4 pb-4">
                    <h5 class="text-muted">You haven't set any course goals yet.</h5>
                    <p class="text-muted" style="font-size: 14px;">Click the button above to start planning your progress.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</section>

<section class="badges">
    <div class="container-fluid px-xl-4">
        <h2 class="badges-section">Your Badges</h2>
        <c:choose>
            <c:when test="${not empty userBadges}">
                <div class="row gy-4">
                    <c:forEach var="badge" items="${userBadges}">
                        <div class="col-12 col-md-4 col-lg-4 col-xl-2">
                            <div class="card shadow-sm badge-card h-100 justify-content-center">
                                <div class="position-relative" style="width: 140px; margin: 0 auto;">
                                    <img src="${badge.badgeImage}" class="${badge.badgeCssClass}" style="width: 140px; height: 140px; object-fit: contain; border-radius: 8px;">
                                    <c:if test="${badge.isRepeatableBadge}">
                                        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger border border-light" style="font-size: 13px; padding: 5px 8px; font-family: 'IBM Plex Sans', sans-serif;">
                                            x${badge.earnedCount}
                                        </span>
                                    </c:if>
                                </div>
                                <div class="card-body text-center flex-grow-0" style="padding-top: 20px;">
                                    <h5 class="card-title" style="font-size:16px; margin-bottom:5px;">${badge.badgeName}</h5>
                                    <p class="card-subtitle text-muted" style="font-size:14px; margin-top:10px; margin-bottom:10px; line-height:1.2;">
                                        ${badge.badgeDescription}
                                    </p>
                                    <p class="card-subtitle text-muted" style="font-size:14px; margin-top:5px; margin-bottom:2px;">Rarity: ${badge.rarity}%</p>
                                    <p class="card-subtitle text-muted mb-0" style="font-size:14px;">Earned: ${badge.formattedDate}</p>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>

            <c:otherwise>
                <div class="text-center warning-text pt-5 pb-5">
                    <h5 class="text-muted">You havent earned any badges.</h5>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</section>

<div class="modal fade" id="addGoalModal" tabindex="-1" aria-labelledby="addGoalModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addGoalModalLabel">Edit Course Goal</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="goalForm">
                    <input type="hidden" id="goalId" name="id">
                    <input type="hidden" id="courseId" name="courseId">
                    <div class="mb-3">
                        <label for="courseName" class="form-label">Goal Name</label>
                        <input type="text" class="form-control" id="courseName" required>
                    </div>
                    <div class="mb-3">
                        <label for="startDate" class="form-label">Start Date</label>
                        <input type="date" class="form-control" id="startDate" required>
                    </div>
                    <div class="mb-3">
                        <label for="targetDate" class="form-label">Target Completion Date</label>
                        <input type="date" class="form-control" id="targetDate" required>
                    </div>
                    <div class="mb-3">
                        <label for="color" class="form-label">Color</label>
                        <input type="color" class="form-control form-control-color" id="color" value="#007bff">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Associated Courses</label>
                        <ul id="associatedCoursesList" class="list-group mb-2">
                            <li class="list-group-item text-muted">Loading courses...</li>
                        </ul>
                        <div class="input-group">
                            <select id="availableCoursesSelect" class="form-select">
                                <option value="">Loading courses...</option>
                            </select>
                            <button type="button" class="btn btn-outline-success" id="btnAddNewCourse">Add Course</button>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger me-auto" id="btnDeleteGoal" style="display:none;">Delete</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="btnSaveGoal">Save Goal</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    var allAvailableCourses = [];

    function updateAvailableCoursesDropdown(courseIdsString) {
        var sel = document.getElementById('availableCoursesSelect');
        if(!sel) return;
        sel.innerHTML = '<option value="">-- Select a Course to Add --</option>';

        var associatedIds = [];
        if (courseIdsString && courseIdsString.trim().length > 0) {
            associatedIds = courseIdsString.split(',').map(id => id.trim());
        }

        allAvailableCourses.forEach(c => {
            if (!associatedIds.includes(c.id.toString())) {
                var opt = document.createElement('option');
                opt.value = c.id;
                opt.textContent = c.name;
                sel.appendChild(opt);
            }
        });
    }

    function populateModalCourses(goalId, courseIdsString) {
        var courseListUl = document.getElementById('associatedCoursesList');
        if(!courseListUl) return;
        courseListUl.innerHTML = '';

        updateAvailableCoursesDropdown(courseIdsString);

        var associatedIds = [];
        if (courseIdsString && courseIdsString.trim().length > 0) {
            associatedIds = courseIdsString.split(',').map(id => id.trim()).filter(id => id !== '');
        }

        if (associatedIds.length > 0 && allAvailableCourses.length > 0) {
            associatedIds.forEach(id => {
                var c = allAvailableCourses.find(course => course.id.toString() === id);
                var cName = c ? c.name : ('Course ID ' + id);

                var li = document.createElement('li');
                li.className = 'list-group-item d-flex justify-content-between align-items-center';
                li.textContent = cName;

                var rmBtn = document.createElement('button');
                rmBtn.type = 'button';
                rmBtn.className = 'btn btn-sm btn-outline-danger';
                rmBtn.textContent = 'Remove';
                rmBtn.onclick = function() {
                    var currentIds = document.getElementById('courseId').value.split(',').map(i=>i.trim()).filter(i=>i!=='');
                    var newIds = currentIds.filter(i => i !== id);
                    document.getElementById('courseId').value = newIds.join(',');
                    populateModalCourses(goalId, document.getElementById('courseId').value);
                };
                li.appendChild(rmBtn);
                courseListUl.appendChild(li);
            });
        } else if (associatedIds.length === 0) {
            courseListUl.innerHTML = '<li class="list-group-item text-muted">No associated courses.</li>';
        } else {
            courseListUl.innerHTML = '<li class="list-group-item text-muted">Loading courses...</li>';
        }
    }

    function openEditGoalModal(btn) {
        var id = btn.getAttribute('data-goal-id');
        var name = btn.getAttribute('data-goal-name');
        var start = btn.getAttribute('data-goal-start');
        var target = btn.getAttribute('data-goal-target');
        var color = btn.getAttribute('data-goal-color');
        var courseId = btn.getAttribute('data-goal-courseid');

        document.getElementById('goalId').value = id;
        document.getElementById('courseName').value = name;
        document.getElementById('startDate').value = start;
        document.getElementById('targetDate').value = target;
        document.getElementById('color').value = color;
        document.getElementById('courseId').value = courseId;
        
        document.getElementById('btnDeleteGoal').style.display = 'block';
        
        populateModalCourses(id, courseId);

        var viewModals = document.querySelectorAll('.modal.show');
        viewModals.forEach(m => {
            var modalInstance = bootstrap.Modal.getInstance(m);
            if (modalInstance) modalInstance.hide();
        });

        var editModal = bootstrap.Modal.getOrCreateInstance(document.getElementById('addGoalModal'));
        editModal.show();
    }

    $(document).ready(function() {
        fetch('/goals/api/all-courses')
            .then(res => res.json())
            .then(data => {
                allAvailableCourses = data;
            })
            .catch(err => console.error("Error loading available courses", err));

        $('#btnAddNewCourse').click(function() {
            var goalId = document.getElementById('goalId').value;
            var addSel = document.getElementById('availableCoursesSelect');
            var selectedCourseId = addSel.value;

            if (!selectedCourseId) return;

            var cInput = document.getElementById('courseId');
            var currentIds = cInput.value ? cInput.value.split(',').map(i=>i.trim()).filter(i=>i!=='') : [];
            if (!currentIds.includes(selectedCourseId)) {
                currentIds.push(selectedCourseId);
                cInput.value = currentIds.join(',');
                populateModalCourses(goalId, cInput.value);
            }
        });

        $('#btnSaveGoal').click(function() {
            var goal = {
                id: document.getElementById('goalId').value || null,
                courseId: document.getElementById('courseId').value,
                courseName: document.getElementById('courseName').value,
                startDate: document.getElementById('startDate').value,
                targetDate: document.getElementById('targetDate').value,
                color: document.getElementById('color').value,
                status: 'IN_PROGRESS'
            };

            var csrfInput = document.querySelector('input[name="_csrf"]');
            var headers = {
                'Content-Type': 'application/json'
            };
            if (csrfInput) {
                headers['X-CSRF-TOKEN'] = csrfInput.value;
            }

            fetch('/goals/api/save', {
                method: 'POST',
                headers: headers,
                body: JSON.stringify(goal)
            })
            .then(response => {
                if (response.ok) return response.json();
                throw new Error('Network response was not ok');
            })
            .then(data => {
                window.location.reload();
            })
            .catch(error => {
                console.error('Error saving goal:', error);
                alert("Error saving goal");
            });
        });

        $('#btnDeleteGoal').click(function() {
            var id = document.getElementById('goalId').value;
            if (id && confirm('Are you sure you want to delete this goal?')) {
                var csrfInput = document.querySelector('input[name="_csrf"]');
                var headers = {};
                if (csrfInput) headers['X-CSRF-TOKEN'] = csrfInput.value;

                fetch('/goals/api/delete/' + id, {
                    method: 'DELETE',
                    headers: headers
                })
                .then(response => {
                    if (response.ok) window.location.reload();
                    else throw new Error('Network error');
                })
                .catch(error => alert("Error deleting goal"));
            }
        });

        $('.fa-bars').click(function() {
            $('.side-nav').slideToggle(350);
        });

        $(window).resize(function() {
            if ($(window).width() >= 900) {
                $('.side-nav').removeAttr('style');
            }
        });

        $('#profilePic').on('click', function() {
            $(this).siblings('.dropdown-menu').toggleClass('show');
        });

        // Fix: When clicking outside, specifically target the profile dropdown
        $(document).on('click', function(e) {
            if (!$(e.target).closest('#profileContainer').length) {
                $('#profileContainer .dropdown-menu').removeClass('show');
            }
        });


        const timeZoneInput = document.querySelectorAll('.userTimeZone');
        timeZoneInput.forEach(input => {
            input.value = Intl.DateTimeFormat().resolvedOptions().timeZone;
        });

        const courseBadges = document.querySelectorAll('.badge-course');
        courseBadges.forEach(img => {
            img.style.boxShadow = 'none';

            const extractAndApply = () => {
                if (!img.naturalWidth || img.naturalWidth === 0) return;

                const canvas = document.createElement('canvas');
                const ctx = canvas.getContext('2d', { willReadFrequently: true });
                canvas.width = img.naturalWidth;
                canvas.height = img.naturalHeight;

                try {
                    ctx.drawImage(img, 0, 0, canvas.width, canvas.height);
                    const data = ctx.getImageData(0, 0, canvas.width, canvas.height).data;

                    let maxS = 0;
                    let r = 0, g = 0, b = 0;

                    for (let i = 0; i < data.length; i += 4) { 
                        if (data[i + 3] > 128) {
                            let pr = data[i], pg = data[i+1], pb = data[i+2];
                            let max = Math.max(pr, pg, pb);
                            let min = Math.min(pr, pg, pb);
                            let saturation = max - min;

                            if (saturation > maxS) {
                                maxS = saturation;
                                r = pr;
                                g = pg;
                                b = pb;
                            }
                        }
                    }

                    if (maxS > 15) {
                        img.style.filter = "drop-shadow(0px 8px 10px rgba(" + r + ", " + g + ", " + b + ", 0.5))";
                    }
                } catch (e) {
                    console.error(e);
                }
            };

            if (img.complete && img.naturalWidth !== 0) {
                extractAndApply();
            } else {
                img.addEventListener('load', extractAndApply);
            }
        });
    });

</script>

<script>const currentUserId = '<c:out value="${currentUser.id}"/>';</script>

<script src="${pageContext.request.contextPath}/js/notifications.js?v=1.01"></script>
<script src="${pageContext.request.contextPath}/js/sidebar-toggle.js"></script>
</body>
</html>
