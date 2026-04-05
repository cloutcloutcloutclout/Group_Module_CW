<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/@phosphor-icons/web@2.1.1/src/regular/style.css"/>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:ital,wght@0,100..700;1,100..700&display=swap" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <title>Leaderboard</title>
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

        .Leaderboard {
            padding-top: 20px;
            align-items: center;
            padding-bottom: 50px;
        }

        h1 {
            font-family: "IBM Plex Sans", sans-serif;
            font-weight: 500 !important;
            margin-right: 20px;
            margin-left: 20px;
            font-size: 40px !important;
        }

        th {
            font-family: "IBM Plex Sans", sans-serif;
            font-weight: 700 !important;
            background-color: orange !important;
        }

        td {
            font-family: "IBM Plex Sans", sans-serif;
            font-weight: 400 !important;
        }

        .table tbody tr:nth-child(2) td:first-child {
            background: linear-gradient(135deg, #fff9e6 0%, #ffeaa7 100%);
            border-left: 5px solid #FFD700;
            font-weight: bold;
            box-shadow: inset 2px 0 5px rgba(255, 215, 0, 0.2);
        }
        .table tbody tr:nth-child(2) .rank-badge {
            background: #FFD700;
            color: #4a3700;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .table tbody tr:nth-child(3) td:first-child {
            background: linear-gradient(135deg, #f2f2f2 0%, #dfe6e9 100%);
            border-left: 5px solid #C0C0C0;
            font-weight: bold;
        }
        .table tbody tr:nth-child(3) .rank-badge {
            background: #C0C0C0;
            color: white;
            text-shadow: 0px 1px 2px rgba(0,0,0,0.2);
        }

        .table tbody tr:nth-child(4) td:first-child {
            background: linear-gradient(135deg, #fff3e6 0%, #fab1a0 100%);
            border-left: 5px solid #CD7F32;
            font-weight: bold;
        }
        .table tbody tr:nth-child(4) .rank-badge {
            background: #CD7F32;
            color: white;
        }

        table {
            margin-top: 20px !important;
            border-radius: 20px !important;
            border: 1px solid black !important;
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

            .Leaderboard {
                padding-top: 80px;
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
    </style>
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

<section class="Leaderboard">
    <div class="container">
        <h1 class="text-center mt-2">Leaderboard</h1>
        <table class="table table-bordered table-striped">
            <tr>
                <th>Rank</th>
                <th>Username</th>
                <th>Points</th>
            </tr>
            <c:forEach var="users" items="${user}">
                <tr>
                    <td style="width:8%">${users.userRank}</td>
                    <td>${users.username}</td>
                    <td>${users.points}</td>
                </tr>
            </c:forEach>
        </table>

        <h2 class="text-center mt-5" style="font-family: 'IBM Plex Sans', sans-serif; font-weight: 500; font-size: 32px;">Top 10 Guilds</h2>
        <table class="table table-bordered table-striped">
            <thead>
            <tr>
                <th style="width:8%">Rank</th>
                <th>Guild Name</th>
                <th>Total Points</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="guild" items="${topGuilds}" varStatus="status">
                <tr>
                    <td style="width:8%"><span class="rank-badge">${status.index + 1}</span></td>
                    <td>
                        <a href="${pageContext.request.contextPath}/guild/${guild.guildName}" style="text-decoration: none; color: inherit;">
                            <strong>${guild.guildName}</strong>
                        </a>
                    </td>
                    <td>${guild.guildPoints}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <div class="mt-4 p-0" style="background-color: white; border-radius: 15px; border: 1px solid black; max-width: 400px; margin: 0 auto; overflow: hidden; box-shadow: 0 4px 15px rgba(0,0,0,0.05);">
            <h4 style="font-family: 'IBM Plex Sans', sans-serif; font-weight: 700; font-size: 18px; background-color: orange; color: black; padding: 12px; margin: 0; text-align: center; border-bottom: 1px solid black;">
                Your Guild Standing
            </h4>
            <c:choose>
                <c:when test="${not empty usersGuild}">
                    <div style="font-family: 'IBM Plex Sans', sans-serif; font-size: 16px; padding: 20px; background: linear-gradient(135deg, #fff9e6 0%, #ffeaa7 100%); border-left: 8px solid #FFD700;">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <span style="color: #4a3700;"><i class="ph ph-shield-check me-2"></i><strong>Guild Name</strong></span>
                            <span style="font-weight: 600;">
                        <a href="${pageContext.request.contextPath}/guild/${usersGuild.guildName}" style="text-decoration: none; color: inherit;">
                                ${usersGuild.guildName}
                        </a>
                    </span>
                        </div>
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <span style="color: #4a3700;"><i class="ph ph-coins me-2"></i><strong>Total Points</strong></span>
                            <span style="font-weight: 600;">${usersGuild.guildPoints}</span>
                        </div>
                        <div class="d-flex justify-content-between align-items-center">
                            <span style="color: #4a3700;"><i class="ph ph-trophy me-2"></i><strong>Global Rank</strong></span>
                            <span class="rank-badge" style="background: #FFD700; color: #4a3700; padding: 2px 10px; border-radius: 8px; font-weight: 700; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
                        #${guildRank}
                    </span>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div style="padding: 20px; text-align: center; color: #666; font-style: italic;">
                        <i class="ph ph-users-three d-block mb-2" style="font-size: 24px;"></i>
                        Not currently in a guild.
                    </div>
                </c:otherwise>
            </c:choose>
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
    });


</script>
<script>const currentUserId = '<c:out value="${currentUser.id}"/>';</script>

<script src="${pageContext.request.contextPath}/js/notifications.js?v=1.01"></script>
<script src="${pageContext.request.contextPath}/js/sidebar-toggle.js"></script>
</body>
</html>
