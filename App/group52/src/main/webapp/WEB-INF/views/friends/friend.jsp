<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

        /* navbar styling */

        nav { background-color: #9BAEE9; }

        .navbar-brand {
            font-family: "IBM Plex Sans", sans-serif;
            font-weight: 600;
            color: black;
            font-size: 23px !important;
            transition: color 0.2s ease;
        }

        .navbar-brand:hover { color: white; cursor: pointer; }

        .nav-group { display: flex; align-items: center; gap: 10px; }

        .fa-bars {
            color: black;
            font-size: 33px;
            text-decoration: none;
            margin-left: 15px;
            transition: color 0.2s ease;
        }

        .fa-bars:hover { cursor: pointer; color: white; }

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

        .dropdown-item { font-family: "IBM Plex Sans", sans-serif; }

        @keyframes snappyFade {
            from { opacity: 0; transform: translateY(8px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        .dropdown-item:focus,
        .dropdown-item:active {
            background-color: transparent !important;
            color: inherit !important;
        }

        .btn-group { padding-right: 10px; }

        .side-nav { background-color: #302B27; display: none; z-index: 1000}

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
            background-color: rgba(255,255,255,0.10) !important;
            color: white;
            width: 100%;
        }

        /* profile picture / dropdown menu */

        .profile-pic {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            object-fit: cover;
            border-color: black;
            border-style: solid;
            transition: color 0.2s ease;
        }

        .profile-pic:hover { box-shadow: 0 5px 15px rgba(0,0,0,0.3); cursor: pointer; }

        /* main page styling */

        .page-content { padding: 30px 20px; }

        h1 {
            font-family: "IBM Plex Sans", sans-serif;
            font-weight: 500 !important;
            font-size: 32px !important;
            margin-bottom: 6px;
        }

        h2 {
            font-family: "IBM Plex Sans", sans-serif;
            font-weight: 400 !important;
            font-size: 22px !important;
            margin-bottom: 16px;
            margin-top: 30px;
        }

        /* search bar styling */

        .search-bar {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 20px;
            margin-top: 30px;
        }

        .search-bar input {
            padding: 8px 14px;
            border: 1.5px solid #d0d8f0;
            border-radius: 8px;
            font-family: "IBM Plex Sans", sans-serif;
            font-size: 14px;
            width: 260px;
            outline: none;
            background-color: white;
        }

        .search-bar input:focus { border-color: #9BAEE9; }

        /* friend display */

        .friend-row {
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 12px 16px;
            border-radius: 10px;
            background: white;
            margin-bottom: 10px;
            box-shadow: 0 1px 4px rgba(0,0,0,0.06);
            transition: box-shadow 0.2s ease;
        }

        .friend-row:hover { box-shadow: 0 4px 12px rgba(0,0,0,0.1); }

        .friend-row img {
            width: 46px;
            height: 46px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #9BAEE9;
        }

        .friend-info { flex: 1; display: flex; flex-direction: column; gap: 3px; }

        .friend-info span {
            font-family: "IBM Plex Sans", sans-serif;
            font-size: 15px;
            font-weight: 600;
            color: #1a1f2e;
        }

        .friend-info p {
            font-family: "IBM Plex Sans", sans-serif;
            font-size: 12px;
            color: #888;
            margin: 0;
        }

        /* friend buttons */

        .view-btn {
            padding: 7px 16px;
            background: #9BAEE9;
            color: white;
            border: none;
            border-radius: 8px;
            font-family: "IBM Plex Sans", sans-serif;
            font-size: 13px;
            font-weight: 600;
            text-decoration: none;
            cursor: pointer;
            transition: background 0.2s ease;
        }

        .view-btn:hover { background: #7b92d6; color: white; }

        .find-btn {
            padding: 7px 16px;
            background: #302B27;
            color: white;
            border-radius: 8px;
            font-family: "IBM Plex Sans", sans-serif;
            font-size: 13px;
            font-weight: 600;
            text-decoration: none;
            transition: background 0.2s ease;
        }

        .find-btn:hover { background: #4a4440; color: white; }

        .remove-btn {
            padding: 7px 16px;
            background: white;
            color: #e53935;
            border: 1px solid #ffcdd2;
            border-radius: 8px;
            font-family: "IBM Plex Sans", sans-serif;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.2s ease;
        }

        .remove-btn:hover { background: #fff1f1; }

        .empty-text {
            font-family: "IBM Plex Sans", sans-serif;
            color: #aaa;
            font-size: 14px;
            padding: 10px 0;
        }

        @media (min-width: 900px) {
            .navbar { position: fixed !important; width: 100%; z-index: 1050; }
            .navbar-brand { padding-left: 10px; }
            .fa-bars { display: none; }
            .side-nav { position: fixed; top: 60px; bottom: 0; left: 0; display: block; }
            .side-link { font-size: 20px; margin-right: 20px; padding-top: 20px; }
            section { padding-left: 200px; }
            .page-content { padding-top: 80px; }
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
    <title>Friends</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
</head>

<body>
<%--notifications container--%>
<div id="notificationContainer" style="position: fixed; top: 80px; right: 20px; z-index: 1060; display: flex; flex-direction: column; gap: 10px;"></div>

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

<section>
    <div class="page-content">

        <h1><i class="fa-solid fa-user-group me-2"></i>${userProfile.firstName}'s Friends</h1>

        <!-- Pending Requests using the friends requester status from repository / model -->
        <h2>Pending Requests</h2>
        <c:choose>
            <c:when test="${empty incomingRequests}">
                <p class="empty-text">No pending requests.</p>
            </c:when>
            <c:otherwise>
                <c:forEach var="req" items="${incomingRequests}">
                    <div class="friend-row">
                        <c:choose>
                            <c:when test="${not empty req.requester.userProfile}">
                                <img src="${req.requester.userProfile.avatar}" alt="avatar"/>
                                <div class="friend-info">
                                    <span>${req.requester.userProfile.firstName} ${req.requester.userProfile.lastName}</span>
                                    <p>${req.requester.userProfile.bio}</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <img src="https://static.vecteezy.com/system/resources/previews/024/766/958/non_2x/default-male-avatar-profile-icon-social-media-user-free-vector.jpg" alt="avatar"/>
                                <div class="friend-info">
                                    <span>${req.requester.username}</span>
                                </div>
                            </c:otherwise>
                        </c:choose>
                        <form action="${pageContext.request.contextPath}/friend/accept/${req.requester.id}" method="post">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <button class="view-btn" type="submit">Accept</button>
                        </form>
                        <form action="${pageContext.request.contextPath}/friend/remove/${req.requester.id}" method="post">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <button class="remove-btn" type="submit">Decline</button>
                        </form>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>

        <!-- search bar for the friends list to improve UX -->
        <div class="search-bar">
            <h2 style="margin:0;">Friends List</h2>
            <input type="text" id="searchInput" placeholder="Search friends..." onkeyup="searchFriends()"/>
            <a href="${pageContext.request.contextPath}/findFriends" class="find-btn"><i class="fa-solid fa-user-plus me-1"></i>Find Friends</a>
        </div>

        <c:choose>
            <c:when test="${empty friends}">
                <p class="empty-text">No friends yet.</p>
            </c:when>
            <c:otherwise>
                <c:forEach var="f" items="${friends}">
                    <div class="friend-row">
                        <c:choose>
                            <c:when test="${not empty f.userProfile}">
                                <img src="${f.userProfile.avatar}" alt="avatar"/>
                                <div class="friend-info">
                                    <span>${f.userProfile.firstName} ${f.userProfile.lastName}</span>
                                    <p>${f.userProfile.bio}</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <img src="https://static.vecteezy.com/system/resources/previews/024/766/958/non_2x/default-male-avatar-profile-icon-social-media-user-free-vector.jpg" alt="avatar"/>
                                <div class="friend-info">
                                    <span>${f.username}</span>
                                </div>
                            </c:otherwise>
                        </c:choose>

                        <a href="${pageContext.request.contextPath}/profile/${f.id}" class="view-btn">View Profile</a>

                            <!-- only show remove button if you are viewing your own friends list via currentUser id equaling to userprofile id -->
                        <c:if test="${currentUser.id == userProfile.user.id}">
                            <form action="${pageContext.request.contextPath}/friend/remove/${f.id}" method="post">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                <button class="remove-btn" type="submit">Remove</button>
                            </form>
                        </c:if>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>

    </div>
</section>

<script>

    /* script for navbar, searching, dropdown menu */

    $(document).ready(function() {
        $('.fa-bars').click(function() { $('.side-nav').slideToggle(350); });
        $(window).resize(function() {
            if ($(window).width() >= 900) { $('.side-nav').removeAttr('style'); }
        });
        $('#profilePic').on('click', function() { $('.dropdown-menu').toggleClass('show'); });
        $(document).on('click', function(e) {
            if (!$(e.target).closest('#profileContainer').length) { $('.dropdown-menu').removeClass('show'); }
        });
    });

    function searchFriends() {
        const input = document.getElementById('searchInput').value.toLowerCase();
        const rows  = document.querySelectorAll('.friend-row');
        rows.forEach(row => {
            const name = row.querySelector('span') ? row.querySelector('span').textContent.toLowerCase() : '';
            row.style.display = name.includes(input) ? 'flex' : 'none';
        });
    }
</script>
<script src="${pageContext.request.contextPath}/js/sidebar-toggle.js"></script>
</body>
</html>
