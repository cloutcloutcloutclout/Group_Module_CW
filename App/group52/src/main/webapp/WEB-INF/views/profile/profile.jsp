<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/@phosphor-icons/web@2.1.1/src/regular/style.css"/>
    <link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:ital,wght@0,100..700;1,100..700&display=swap" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <title>Profile</title>
    <style>
        body {
            background-color: #F1F9F8;
            margin-bottom: 80px;
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
        .navbar-brand:hover { color: white; cursor: pointer; }

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
        .dropdown-item:focus, .dropdown-item:active {
            background-color: transparent !important;
            color: inherit !important;
        }

        @keyframes snappyFade {
            from { opacity: 0; transform: translateY(8px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .profile-pic {
            width: 45px; height: 45px; border-radius: 50%;
            object-fit: cover; border-color: black; border-style: solid;
            transition: box-shadow 0.2s ease;
        }
        .profile-pic:hover { box-shadow: 0 5px 15px rgba(0,0,0,0.3); cursor: pointer; }

        .btn-group { padding-right: 10px; }


        .side-nav {
            background-color: #302B27;
            display: none;
        }
        .side-link {
            text-decoration: none; display: block; color: white;
            padding: 10px; font-family: "IBM Plex Sans", sans-serif;
            font-weight: 300; font-size: 23px;
        }
        .side-link:hover {
            background-color: rgba(255,255,255,0.10);
            color: white; width: 100%;
        }


        .profile-banner {
            width: 100%;
            height: 200px;
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            position: relative;
        }


        .avatar-on-banner {
            position: absolute;
            bottom: -45px;
            left: 40px;
            width: 90px;
            height: 90px;
            border-radius: 50%;
            border: 4px solid white;
            object-fit: cover;
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
        }


        .profile-content {
            padding: 60px 40px 40px 40px;
        }

        h1 {
            font-family: "IBM Plex Sans", sans-serif;
            font-weight: 600;
            font-size: 28px;
            margin-bottom: 6px;
        }

        .pronoun-tag {
            display: inline-block;
            background: #e8edfc;
            color: #5567b8;
            font-size: 12px;
            padding: 3px 10px;
            border-radius: 20px;
            margin-bottom: 16px;
            font-weight: 500;
        }

        .meta-row {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
            margin-bottom: 20px;
            font-size: 14px;
            color: #555;
        }

        .meta-row span { display: flex; align-items: center; gap: 6px; }
        .meta-dot {
            width: 8px; height: 8px; border-radius: 50%;
            background: #9BAEE9; display: inline-block;
        }

        .bio-box {
            font-size: 15px; color: #444; line-height: 1.6;
            margin-bottom: 24px; background: white;
            padding: 16px 20px; border-radius: 10px;
            border-left: 4px solid #9BAEE9;
        }

        .section-divider {
            border: none;
            border-top: 1px solid rgba(0,0,0,0.08);
            margin: 24px 0;
        }

        h3 {
            font-family: "IBM Plex Sans", sans-serif;
            font-weight: 600; font-size: 14px;
            color: #333; margin-bottom: 14px;
            text-transform: uppercase; letter-spacing: 0.5px;
        }

        .social-links {
            display: flex;
            gap: 12px;
            align-items: center;
        }

        .social-links img {
            width: 32px;
            height: 32px;
            object-fit: cover;
        }


        .contact-row { display: flex; gap: 20px; flex-wrap: wrap; font-size: 14px; }
        .contact-row a { color: #5567b8; text-decoration: none; font-weight: 500; }
        .contact-row a:hover { text-decoration: underline; }

        @media (min-width: 900px) {
            .navbar {
                position: fixed !important;
                width: 100%; z-index: 1050;
            }
            .navbar-brand { padding-left: 10px; }
            .fa-bars { display: none; }

            .side-nav {
                position: fixed; top: 60px; bottom: 0;
                left: 0; display: block; width: 200px;
            }
            .side-link {
                font-size: 20px; margin-right: 20px; padding-top: 20px;
            }

            .page-body { padding-left: 200px; padding-top: 60px; }
        }

        /* --- CSS for notifications --- */

        .toast-notification {
            background: #ffffff;
            border-left: 5px solid #0f62fe;
            padding: 16px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
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
        } /* THIS WAS THE MISSING BRACE */

        /* --- Privacy Settings CSS --- */
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

    <div class="profile-banner" style="background-image: url('${userProfile.background}')">
        <img src="${userProfile.avatar}" class="avatar-on-banner" alt="Avatar"/>
    </div>


    <div class="profile-content">
        <h1>${userProfile.firstName} ${userProfile.lastName}</h1>

        <c:if test="${not empty userProfile.pronoun}">
            <span class="pronoun-tag">${userProfile.pronoun}</span>
        </c:if>

        <div class="meta-row">
            <c:if test="${not empty userProfile.status}">
                <span><span class="meta-dot"></span>${userProfile.status}</span>
            </c:if>
            <c:if test="${not empty userProfile.location}">
                <span> ${userProfile.location}</span>
            </c:if>
        </div>

        <c:if test="${not empty userProfile.bio}">
            <div class="bio-box">${userProfile.bio}</div>
        </c:if>

        <hr class="section-divider"/>

        <h3>Social Profiles</h3>
        <div class="social-links">

            <c:if test="${not empty userProfile.linkedIn}">
                <a href="https://www.linkedin.com/in/${userProfile.linkedIn}" target="_blank">
                    <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/8/81/LinkedIn_icon.svg/3840px-LinkedIn_icon.svg.png"
                         alt="LinkedIn" width="32">
                </a>
            </c:if>

            <c:if test="${not empty userProfile.github}">
                <a href="https://github.com/${userProfile.github}" target="_blank">
                    <img src="https://upload.wikimedia.org/wikipedia/commons/9/91/Octicons-mark-github.svg"
                         alt="GitHub" width="32">
                </a>
            </c:if>

            <c:if test="${not empty userProfile.ibm}">
                <a href="https://www.ibm.com/ibmweb/myibm/us-en/profile/${userProfile.ibm}" target="_blank">
                    <img src="https://www.svgrepo.com/show/331437/ibm.svg"
                         alt="IBM" width="32">
                </a>
            </c:if>

        </div>

        <hr class="section-divider"/>

        <div class="contact-row">
            <c:if test="${not empty userProfile.website}">
                <span><strong>Website:</strong> <a href="${userProfile.website}" target="_blank">${userProfile.website}</a></span>
            </c:if>
            <c:if test="${not empty userProfile.contactEmail}">
                <span><strong>Contact:</strong> <a href="mailto:${userProfile.contactEmail}">${userProfile.contactEmail}</a></span>
            </c:if>
        </div>
    </div>
</div>

<c:if test="${restricted}">
    <div class="restricted-overlay">
        <i class="fa-solid fa-lock mb-3" style="font-size:36px; color:#9BAEE9;"></i>
        <h2 class="mb-3">${user.username}'s profile is limited</h2>
        <div class="d-flex gap-3 justify-content-center">
            <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-outline-secondary">Dashboard</a>
            <a href="${pageContext.request.contextPath}/profile/${currentUser.id}" class="btn btn-primary" style="background:#9BAEE9; border:none;">My Profile</a>
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