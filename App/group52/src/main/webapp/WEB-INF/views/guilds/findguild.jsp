<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body { background-color: #F1F9F8 !important; margin-bottom: 80px !important; }
        nav { background-color: #9BAEE9; }
        .navbar-brand { font-family: "IBM Plex Sans", sans-serif; font-weight: 600; color: black; font-size: 23px !important; transition: color 0.2s ease; }
        .navbar-brand:hover { color: white; cursor: pointer; }
        .nav-group { display: flex; align-items: center; gap: 10px; }
        .fa-bars { color: black; font-size: 33px; text-decoration: none; margin-left: 15px; transition: color 0.2s ease; }
        .fa-bars:hover { cursor: pointer; color: white; }
        .dropdown-menu { display: none; position: absolute; top: 100%; right: 0; z-index: 1000; min-width: 180px; padding: 0.5rem 0; margin-top: 10px; background-color: white; border-radius: 8px; list-style: none; text-align: left; }
        .dropdown-menu.show { display: block; animation: snappyFade 0.15s cubic-bezier(0.2,0,0.2,1) forwards; }
        .dropdown-item { font-family: "IBM Plex Sans", sans-serif; }
        .dropdown-item:focus, .dropdown-item:active { background-color: transparent !important; color: inherit !important; }
        @keyframes snappyFade { from { opacity: 0; transform: translateY(8px); } to { opacity: 1; transform: translateY(0); } }
        .profile-pic { width: 45px; height: 45px; border-radius: 50%; object-fit: cover; border-color: black; border-style: solid; }
        .profile-pic:hover { box-shadow: 0 5px 15px rgba(0,0,0,0.3); cursor: pointer; }
        .nav-profile { padding-right: 10px; position: relative; }
        .side-nav { background-color: #302B27; display: none; z-index: 1000; }
        .side-link { text-decoration: none; display: block; color: white; padding: 10px; font-family: "IBM Plex Sans", sans-serif; font-weight: 300; font-size: 23px; }
        .side-link:hover { background-color: rgba(255,255,255,0.10) !important; color: white; width: 100%; }

        h2 { font-family: "IBM Plex Sans", sans-serif; font-weight: 400 !important; margin-right: 20px; margin-left: 20px; font-size: 30px !important; }
        h5 { font-family: "IBM Plex Sans", sans-serif; font-weight: 600 !important; font-size: 20px !important; }

        .page-section { padding-top: 20px; margin-bottom: 10px !important; position: relative; }
        .page-section::before { content: ""; position: absolute; top: 0; left: 10%; right: 10%; height: 1px; background-color: rgba(0,0,0,0.1); }

        .card { border-radius: 10px !important; }
        .guild-card { transition: transform 0.4s cubic-bezier(0.22,1,0.36,1), box-shadow 0.4s cubic-bezier(0.22,1,0.36,1); }
        .guild-card:hover { box-shadow: 0 5px 15px rgba(0,0,0,0.3); cursor: pointer; transform: translateY(-8px); }
        .guild-avatar { width: 56px; height: 56px; object-fit: cover; border-radius: 6px; flex-shrink: 0; }
        .member-count { font-size: 0.78rem; color: #666; font-family: "IBM Plex Sans", sans-serif; display: flex; align-items: center; gap: 4px; margin-top: 4px; }
        .card-text { font-family: "IBM Plex Sans", sans-serif; font-weight: 300 !important; }

        .create-section { padding: 20px 20px 10px; }
        .field-error { color: #dc3545; font-size: 0.82rem; margin-top: 0.3rem; }

        .form-control-guild { border: 1.5px solid #d0daf5; border-radius: 8px; padding: 0.5rem 1rem; font-size: 0.9rem; font-family: "IBM Plex Sans", sans-serif; background: #fff; }
        .form-control-guild:focus { outline: none; border-color: #9BAEE9; box-shadow: none; }

        .btn-accent { background-color: #9BAEE9; color: #fff; border: none; border-radius: 6px; padding: 0.5rem 1.1rem; font-family: "IBM Plex Sans", sans-serif; font-weight: 600; font-size: 0.9rem; cursor: pointer; transition: background 0.2s; }
        .btn-accent:hover { background-color: #7A92D4; }

        .btn-my-guild { background-color: #fff; color: #9BAEE9; border: 2px solid #9BAEE9; border-radius: 6px; padding: 0.4rem 1rem; font-family: "IBM Plex Sans", sans-serif; font-weight: 600; font-size: 0.9rem; text-decoration: none; transition: all 0.2s; }
        .btn-my-guild:hover { background-color: #9BAEE9; color: #fff; }

        .search-input { border: 1.5px solid #d0daf5; border-radius: 8px; padding: 0.5rem 1rem; font-size: 0.9rem; font-family: "IBM Plex Sans", sans-serif; width: 100%; max-width: 320px; margin-bottom: 1rem; }
        .search-input:focus { outline: none; border-color: #9BAEE9; }

        @media (min-width: 900px) {
            .navbar { position: fixed !important; width: 100%; z-index: 1050; }
            .navbar-brand { padding-left: 10px; }
            .fa-bars { display: none; }
            .side-nav { position: fixed; top: 60px; bottom: 0; left: 0; display: block; }
            .side-link { font-size: 20px; margin-right: 20px; padding-top: 20px; }
            section { padding-left: 200px; }
            .page-section::before { left: calc(200px + 5%); right: 5%; }
        }
        @media (min-width: 992px) { h2 { padding-top: 50px !important; } }

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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/@phosphor-icons/web@2.1.1/src/regular/style.css"/>
    <link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:ital,wght@0,100..700;1,100..700&display=swap" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <title>Guilds – SkillsBuilder</title>
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

<section>
    <div class="container-fluid px-xl-4">

        <h2 class="pt-4"><i class="ph ph-building-apartment me-2"></i>Guilds</h2>

        <div class="create-section">
            <h5>Create a Guild</h5>
            <form:form action="/guilds/create" method="post" modelAttribute="guild">
                <div class="d-flex gap-2 align-items-start flex-wrap" style="max-width:460px;">
                    <div>
                        <form:input path="guildName" cssClass="form-control-guild" placeholder="Guild name…" autocomplete="off"/>
                        <form:errors path="guildName" cssClass="field-error" element="div"/>
                    </div>
                    <button type="submit" class="btn-accent">Create</button>
                </div>
            </form:form>
        </div>

        <div class="create-section">
            <h5>Join by Code</h5>
            <form:form action="/guilds/join" method="post" modelAttribute="guild">
                <div class="d-flex gap-2 align-items-start flex-wrap" style="max-width:460px;">
                    <div>
                        <form:input path="code" cssClass="form-control-guild" placeholder="Enter invite code…" autocomplete="off"/>
                        <form:errors path="code" cssClass="field-error" element="div"/>
                    </div>
                    <button type="submit" class="btn-accent">Join</button>
                </div>
            </form:form>
        </div>

        <div class="page-section">
            <div class="d-flex align-items-center justify-content-between px-3 mb-3">
                <h2 class="m-0" style="padding-top: 0 !important;">All Guilds</h2>
                <c:if test="${not empty currentUser.guild}">
                    <a href="${pageContext.request.contextPath}/guild/${currentUser.guild.guildName}" class="btn-my-guild">
                        <i class="ph ph-users-three me-1"></i> My Guild
                    </a>
                </c:if>
            </div>

            <div class="px-3">
                <input type="text" id="guildSearch" class="search-input" placeholder="Search guilds…" oninput="filterGuilds()"/>
            </div>

            <c:choose>
                <c:when test="${empty everyGuild}">
                    <div class="text-center pt-5 pb-5">
                        <h5 class="text-muted">No guilds yet — create the first one!</h5>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="container-fluid px-3">
                        <div class="row gy-4" id="guildsGrid">
                            <c:forEach var="g" items="${everyGuild}">
                                <div class="col-12 col-md-6 col-lg-4 col-xl-3" data-name="${g.guildName}">
                                    <a href="/guild/${g.guildName}" style="text-decoration:none; color:inherit;">
                                        <div class="card shadow-sm guild-card h-100">
                                            <div class="card-body">
                                                <div class="d-flex align-items-center gap-3 mb-2">
                                                    <img src="${pageContext.request.contextPath}/${g.avatar}" alt="${g.guildName}" class="guild-avatar"/>
                                                    <div>
                                                        <h5 class="mb-0">${g.guildName}</h5>
                                                        <div class="member-count">
                                                            <i class="fa-solid fa-users" style="font-size:11px;"></i>
                                                                ${g.members.size()} / 8 members
                                                        </div>
                                                    </div>
                                                </div>
                                                <c:if test="${not empty g.bio}">
                                                    <p class="card-text text-muted" style="font-size:0.88rem;">${g.bio}</p>
                                                </c:if>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

    </div>
</section>

<script>
    $(document).ready(function () {
        $('.fa-bars').click(function () { $('.side-nav').slideToggle(350); });
        $(window).resize(function () { if ($(window).width() >= 900) { $('.side-nav').removeAttr('style'); } });
        $('#profilePic').on('click', function () { $('.dropdown-menu').toggleClass('show'); });
        $(document).on('click', function (e) { if (!$(e.target).closest('#profileContainer').length) { $('.dropdown-menu').removeClass('show'); } });
    });

    function filterGuilds() {
        const q = document.getElementById('guildSearch').value.toLowerCase();
        document.querySelectorAll('#guildsGrid [data-name]').forEach(col => {
            col.style.display = col.dataset.name.toLowerCase().includes(q) ? '' : 'none';
        });
    }
</script>
<script>const currentUserId = '<c:out value="${currentUser.id}"/>';</script>
<script src="${pageContext.request.contextPath}/js/notifications.js?v=1.01"></script>
<script src="${pageContext.request.contextPath}/js/sidebar-toggle.js"></script>
</body>
</html>
