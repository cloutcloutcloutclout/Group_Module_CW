<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/@phosphor-icons/web@2.1.1/src/regular/style.css"/>
    <link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:ital,wght@0,100..700;1,100..700&display=swap" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <title>${guild.guildName} | Guild</title>
    <style>
        body {
            background-color: #F1F9F8 !important;
            margin-bottom: 80px !important;
            font-family: "IBM Plex Sans", sans-serif;
        }

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
            color: black; font-size: 33px; text-decoration: none;
            margin-left: 15px; transition: color 0.2s ease;
        }
        .fa-bars:hover { cursor: pointer; color: white; }

        .dropdown-menu {
            display: none; position: absolute; top: 100%; right: 0;
            z-index: 1000; min-width: 180px; padding: 0.5rem 0;
            margin-top: 10px; background-color: white;
            border-radius: 8px; list-style: none; text-align: left;
        }
        .dropdown-menu.show {
            display: block;
            animation: snappyFade 0.15s cubic-bezier(0.2, 0, 0.2, 1) forwards;
        }
        .dropdown-item { font-family: "IBM Plex Sans", sans-serif; }
        .dropdown-item:focus, .dropdown-item:active {
            background-color: transparent !important;
            color: inherit !important;
        }
        @keyframes snappyFade {
            from { opacity: 0; transform: translateY(8px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        .profile-pic {
            width: 45px; height: 45px; border-radius: 50%;
            object-fit: cover; border-color: black; border-style: solid;
            transition: box-shadow 0.2s ease;
        }
        .profile-pic:hover { box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3); cursor: pointer; }

        .btn-group { padding-right: 10px; }

        .side-nav { background-color: #302B27; display: none; z-index: 1000}
        .side-link {
            text-decoration: none; display: block; color: white;
            padding: 10px; font-family: "IBM Plex Sans", sans-serif;
            font-weight: 300; font-size: 23px;
        }
        .side-link:hover {
            background-color: rgba(255, 255, 255, 0.10) !important;
            color: white; width: 100%;
        }

        .guild-banner {
            width: 100%; height: 200px;
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            position: relative;
        }
        .guild-avatar-on-banner {
            position: absolute;
            bottom: -45px; left: 40px;
            width: 90px; height: 90px;
            border-radius: 50%;
            border: 4px solid white;
            object-fit: cover;
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
        }

        .guild-content { padding: 60px 40px 40px 40px; }

        h1 {
            font-family: "IBM Plex Sans", sans-serif;
            font-weight: 600; font-size: 28px; margin-bottom: 6px;
        }

        .member-role-text {
            font-size: 13px; color: #888; flex-shrink: 0;
        }

        .section-divider {
            border: none; border-top: 1px solid rgba(0,0,0,0.08); margin: 24px 0;
        }

        h3 {
            font-family: "IBM Plex Sans", sans-serif;
            font-weight: 600; font-size: 14px;
            color: #333; margin-bottom: 14px;
            text-transform: uppercase; letter-spacing: 0.5px;
        }

        .bio-box {
            font-size: 15px; color: #444; line-height: 1.6;
            margin-bottom: 24px; background: white;
            padding: 16px 20px; border-radius: 10px;
            border-left: 4px solid #9BAEE9;
        }

        .announcement-box {
            font-size: 15px; color: #444; line-height: 1.6;
            background: #fff8e1; padding: 16px 20px;
            border-radius: 10px; border-left: 4px solid #f59e0b;
            margin-bottom: 24px;
        }
        .announcement-box .ann-label {
            font-size: 11px; font-weight: 700;
            text-transform: uppercase; letter-spacing: 1px;
            color: #b45309; margin-bottom: 6px;
        }

        .code-pill {
            display: inline-flex; align-items: center; gap: 8px;
            background: white; border: 1px solid #e5e7eb;
            border-radius: 8px; padding: 6px 14px;
            font-size: 14px; color: #374151; font-weight: 500;
            margin-bottom: 20px;
        }
        .code-pill span { font-family: monospace; font-size: 15px; color: #5567b8; }

        .members-grid { display: flex; flex-direction: column; gap: 10px; }
        .member-card {
            display: flex; align-items: center; gap: 14px;
            background: white; border-radius: 10px;
            padding: 12px 16px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.06);
            transition: box-shadow 0.2s ease;
        }
        .member-card:hover { box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
        .member-avatar {
            width: 42px; height: 42px; border-radius: 50%;
            object-fit: cover; border: 2px solid #e5e7eb; flex-shrink: 0;
        }
        .member-info { flex: 1; min-width: 0; }
        .member-name {
            font-weight: 600; font-size: 15px; color: #111;
            text-decoration: none; white-space: nowrap;
            overflow: hidden; text-overflow: ellipsis;
        }
        .member-name:hover { color: #5567b8; text-decoration: underline; }

        .guild-actions { display: flex; gap: 10px; flex-wrap: wrap; margin-bottom: 20px; }
        .btn-guild-edit {
            background: #9BAEE9; color: white; border: none;
            padding: 8px 20px; border-radius: 8px;
            font-family: "IBM Plex Sans", sans-serif;
            font-size: 14px; font-weight: 500;
            cursor: pointer; text-decoration: none; display: inline-block;
            transition: background 0.2s ease;
        }
        .btn-guild-edit:hover { background: #7b96e0; color: white; }
        .btn-guild-leave {
            background: white; color: #e53e3e;
            border: 1.5px solid #e53e3e; padding: 8px 20px;
            border-radius: 8px; font-family: "IBM Plex Sans", sans-serif;
            font-size: 14px; font-weight: 500;
            cursor: pointer; text-decoration: none; display: inline-block;
            transition: background 0.2s ease, color 0.2s ease;
        }
        .btn-guild-leave:hover { background: #e53e3e; color: white; }

        @media (min-width: 900px) {
            .navbar { position: fixed !important; width: 100%; z-index: 1050; }
            .navbar-brand { padding-left: 10px; }
            .fa-bars { display: none; }
            .side-nav {
                position: fixed; top: 60px; bottom: 0;
                left: 0; display: block; width: 200px;
            }
            .side-link { font-size: 20px; margin-right: 20px; padding-top: 20px; }
            .page-body { padding-left: 200px; padding-top: 60px; }
        }

        .blur-content {
            filter: blur(6px);
            pointer-events: none;
            user-select: none;
        }

        .restricted-overlay {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            border-radius: 14px;
            padding: 32px 40px;
            text-align: center;
            box-shadow: 0 4px 24px rgba(0,0,0,0.15);
            z-index: 999;
            width: 90%;
            max-width: 450px;
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
            <div class="dropdown-menu dropdown-menu-end shadow border-0 mt-3" id="notificationInboxMenu" style="width: 320px;max-height: 400px;overflow-y:auto;padding: 0;">
                <div class="d-flex justify-content-between align-items-center p-2 border-bottom" id="notiHeader">
                    <span style="font-weight: 600; font-size: 14px; margin-left: 8px;">Notifications</span>
                    <button id="clearAllNotisBtn" class="btn btn-sm btn-link text-danger text-decoration-none" style="font-size: 12px; display: none;" onclick="clearAllNotifications(event)">Clear All</button>
                </div>
                <div class="p-3 text-center text-muted" id="emptyInboxMsg" style="font-size: 14px;">No new notifications</div>
                <div id="inboxItems"></div>
            </div>
        </div>
        <div class="btn-group" id="profileContainer">
            <img id="profilePic" src="${currentUser.userProfile.avatar}" alt="Profile" class="profile-pic">
            <ul class="dropdown-menu dropdown-menu-end shadow border-0 mt-2">
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile/${currentUser.id}"><i class="fa-solid fa-circle-user me-2"></i>View Profile</a></li>
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/editProfile/${currentUser.id}"><i class="fa-solid fa-user-pen me-2"></i>Edit Profile</a></li>
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/friends/${currentUser.id}"><i class="fa-solid fa-user-group me-2"></i>Friends</a></li>
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/account"><i class="fa-solid fa-gear me-2"></i>Account Details</a></li>
            <li><hr class="dropdown-divider"></li>
            <li>
                <form action="${pageContext.request.contextPath}/logout" method="post" style="margin:0;">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <button type="submit" class="dropdown-item text-danger" style="border:none;background:none;cursor:pointer;">
                        <i class="fa-solid fa-power-off me-2"></i>Logout
                    </button>
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

<div class="page-body ${restricted ? 'blur-content' : ''}">
    <div class="guild-banner" style="background-image: url('${pageContext.request.contextPath}/${guild.background}')">
        <img src="${pageContext.request.contextPath}/${guild.avatar}" class="guild-avatar-on-banner" alt="Guild Avatar"/>
    </div>

    <div class="guild-content">
        <div class="d-flex align-items-center gap-2 mb-3">
            <h1 class="m-0" style="font-size: 24px; font-weight: 700; color: #111;">${guild.guildName}</h1>
            <div style="display: flex; align-items: center; gap: 5px; color: #f59e0b; font-family: 'IBM Plex Sans', sans-serif; font-size: 15px; font-weight: 600; padding-top: 5px;">
                <i class="ph ph-crown" style="font-size: 18px;"></i>
                <span>Total Points: ${guild.guildPoints}</span>
            </div>
        </div>

        <c:if test="${currentUser.guild.guildName == guild.guildName && (currentUser.guildRole == 'MASTER' || currentUser.guildRole == 'CAPTAIN')}">
            <div class="code-pill">
                <i class="fa-solid fa-key" style="color:#9BAEE9;"></i>
                Invite Code: <span>${guild.code}</span>
            </div>
        </c:if>

        <div class="guild-actions">
            <a href="${pageContext.request.contextPath}/guilds" class="btn-guild-edit">
                <i class="fa-solid fa-arrow-left me-1"></i> Back
            </a>

            <c:if test="${empty currentUser.guild}">
                <c:if test="${guild.guildJoinMethod == 'public'}">
                    <c:choose>
                        <c:when test="${members.size() < 8}">
                            <form action="${pageContext.request.contextPath}/guild/join/public/${guild.guildName}" method="post" style="margin:0;">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                <button type="submit" class="btn-guild-edit" style="background: #10b981;">
                                    <i class="ph ph-plus-circle me-1"></i> Join Guild
                                </button>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <button class="btn-guild-edit" style="background: #9ca3af; cursor: not-allowed;" disabled>
                                <i class="ph ph-users-three me-1"></i> Guild Full
                            </button>
                        </c:otherwise>
                    </c:choose>
                </c:if>
            </c:if>
            <c:if test="${currentUser.guildRole == 'MASTER' && currentUser.guild.guildName == guild.guildName}">
                <a href="${pageContext.request.contextPath}/editGuild/${guild.guildName}" class="btn-guild-edit">
                    <i class="fa-solid fa-pen me-1"></i> Edit Guild
                </a>
            </c:if>

            <c:if test="${currentUser.guild.guildName == guild.guildName && (currentUser.guildRole == 'CAPTAIN' || currentUser.guildRole == 'ROOKIE')}">
                <form action="${pageContext.request.contextPath}/leave/${guild.guildName}" method="post" style="margin:0;">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <button type="submit" class="btn-guild-leave">
                        <i class="fa-solid fa-right-from-bracket me-1"></i> Leave Guild
                    </button>
                </form>
            </c:if>
        </div>

        <c:if test="${not empty guild.announcement}">
            <div class="announcement-box">
                <div class="ann-label"><i class="fa-solid fa-bullhorn me-1"></i> Announcement</div>
                    ${guild.announcement}
            </div>
        </c:if>

        <c:if test="${not empty guild.bio}">
            <div class="bio-box">${guild.bio}</div>
        </c:if>

        <hr class="section-divider"/>

        <h3><i class="fa-solid fa-users me-1" style="color:#9BAEE9;"></i> Members (${members.size()})</h3>

        <div class="members-grid">
            <c:forEach var="member" items="${members}">
                <div class="member-card">
                    <img src="${member.userProfile.avatar}" alt="${member.username}" class="member-avatar"/>
                    <div class="member-info">
                        <a href="${pageContext.request.contextPath}/profile/${member.id}" class="member-name">
                                ${member.userProfile.firstName} ${member.userProfile.lastName}
                        </a>
                    </div>
                    <span style="font-size:13px; color:#ca8a04; font-weight:600; flex-shrink:0;">${member.points} pts</span>
                    <span class="member-role-text">${member.guildRole}</span>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<c:if test="${restricted}">
    <div class="restricted-overlay">
        <i class="ph ph-lock-keyhole mb-3" style="font-size:48px; color:#9BAEE9;"></i>
        <h2 class="mb-3">This Guild is Private</h2>
        <p class="text-muted mb-4">
            The details of <strong>${guild.guildName}</strong> are only visible to its members.
            Please use an invite code to join.
        </p>
        <div class="d-flex gap-3 justify-content-center">
            <a href="${pageContext.request.contextPath}/guilds" class="btn btn-outline-secondary">Back to Search</a>
            <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-primary" style="background:#9BAEE9; border:none;">Dashboard</a>
        </div>
    </div>
</c:if>

<script>
    $(document).ready(function () {
        $('.fa-bars').click(function () {
            $('.side-nav').slideToggle(350);
        });
        $(window).resize(function () {
            if ($(window).width() >= 900) {
                $('.side-nav').removeAttr('style');
            }
        });
        $('#profilePic').on('click', function () {
            $('.dropdown-menu').toggleClass('show');
        });
        $(document).on('click', function (e) {
            if (!$(e.target).closest('#profileContainer').length) {
                $('.dropdown-menu').removeClass('show');
            }
        });
    });
</script>
<script>const currentUserId = '<c:out value="${currentUser.id}"/>';</script>
<script src="${pageContext.request.contextPath}/js/notifications.js?v=1.01"></script>
<script src="${pageContext.request.contextPath}/js/sidebar-toggle.js"></script>
</body>
</html>
