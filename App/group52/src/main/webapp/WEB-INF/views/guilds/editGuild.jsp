<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
    <title>Edit Guild | ${guild.guildName}</title>
    <style>
        body { background-color: #F1F9F8 !important; margin-bottom: 80px !important; font-family: "IBM Plex Sans", sans-serif; }
        nav { background-color: #9BAEE9; }
        .navbar-brand { font-family: "IBM Plex Sans", sans-serif; font-weight: 600; color: black; font-size: 23px !important; transition: color 0.2s ease; }
        .navbar-brand:hover { color: white; cursor: pointer; }
        .nav-group { display: flex; align-items: center; gap: 10px; }
        .fa-bars { color: black; font-size: 33px; text-decoration: none; margin-left: 15px; transition: color 0.2s ease; }
        .fa-bars:hover { cursor: pointer; color: white; }
        .dropdown-menu { display: none; position: absolute; top: 100%; right: 0; z-index: 1000; min-width: 180px; padding: 0.5rem 0; margin-top: 10px; background-color: white; border-radius: 8px; list-style: none; text-align: left; }
        .dropdown-menu.show { display: block; animation: snappyFade 0.15s cubic-bezier(0.2, 0, 0.2, 1) forwards; }
        @keyframes snappyFade { from { opacity: 0; transform: translateY(8px); } to { opacity: 1; transform: translateY(0); } }
        .profile-pic { width: 45px; height: 45px; border-radius: 50%; object-fit: cover; border-color: black; border-style: solid; transition: box-shadow 0.2s ease; }
        .profile-pic:hover { box-shadow: 0 5px 15px rgba(0,0,0,0.3); cursor: pointer; }
        .side-nav { background-color: #302B27; display: none; z-index: 1000}
        .side-link { text-decoration: none; display: block; color: white; padding: 10px; font-family: "IBM Plex Sans", sans-serif; font-weight: 300; font-size: 23px; }
        .side-link:hover { background-color: rgba(255, 255, 255, 0.10) !important; color: white; width: 100%; }
        .edit-content { padding-top: 40px; }
        .section-card { background: white; border-radius: 12px; padding: 28px 30px; margin-bottom: 24px; box-shadow: 0 1px 6px rgba(0,0,0,0.06); }
        .section-card h3 { font-size: 14px; font-weight: 700; text-transform: uppercase; color: #555; border-bottom: 1px solid #eee; padding-bottom: 10px; margin-bottom: 20px; }
        .avatar-grid, .bg-grid { display: flex; gap: 16px; flex-wrap: wrap; }
        .avatar-grid input, .bg-grid input { display: none; }
        .avatar-grid img { width: 64px; height: 64px; border-radius: 50%; border: 3px solid transparent; cursor: pointer; }
        .bg-grid img { width: 150px; height: 85px; border-radius: 8px; border: 3px solid transparent; cursor: pointer; }
        input:checked + img { border-color: #9BAEE9; box-shadow: 0 0 0 3px rgba(155,174,233,0.3); }
        .member-card { display: flex; align-items: center; background: #f8faff; border-radius: 10px; padding: 12px; border: 1px solid #e8edfc; gap: 12px; margin-bottom: 10px; }
        .member-avatar { width: 42px; height: 42px; border-radius: 50%; object-fit: cover; }
        .role-badge { font-size: 11px; padding: 2px 8px; border-radius: 20px; font-weight: 600; }
        .badge-master { background: #ffe8cc; color: #b05e00; }
        .badge-captain { background: #e8edfc; color: #5567b8; }
        .badge-rookie { background: #e6f9f0; color: #1a7a4a; }
        .btn-save { background: #9BAEE9; color: white; border: none; padding: 10px 26px; border-radius: 8px; font-weight: 600; }
        .btn-manage { background: #f5e0e0; color: #b00; border: none; padding: 10px 26px; border-radius: 8px; font-weight: 600; margin-left: 10px; }
        .btn-delete { background: #b00; color: white; border: none; padding: 12px; border-radius: 8px; width: 100%; font-weight: 600; margin-top: 15px; }
        #managePanelWrapper { display: none; margin-top: 24px; }
        @media (min-width: 900px) {
            .navbar { position: fixed !important; width: 100%; z-index: 1050; }
            .navbar-brand { padding-left: 10px; }
            .fa-bars { display: none; }
            .side-nav { position: fixed; top: 60px; bottom: 0; left: 0; display: block; }
            .side-link { font-size: 20px; margin-right: 20px; padding-top: 20px; }
            section { padding-left: 200px; }
            .edit-content { padding-top: 100px; }
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

<section class="edit-content">
    <div class="container">
        <h2 style="font-weight: 500; font-size: 30px; margin-bottom: 30px;">Edit Guild</h2>

        <form action="${pageContext.request.contextPath}/editGuild/${guild.guildName}" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

            <div class="section-card shadow-sm">
                <h3>Guild Details</h3>
                <div class="mb-3">
                    <label class="fw-bold mb-1">Guild Name</label>
                    <input type="text" name="guildName" value="${guild.guildName}" class="form-control" style="max-width:400px;">
                </div>
                <div class="mb-3">
                    <label class="fw-bold mb-1">Guild Privacy</label>
                    <select name="guildPrivacy" class="form-select" style="max-width:400px;">
                        <option value="public" ${guild.guildPrivacy == 'public' ? 'selected' : ''}>Public (Visible to everyone)</option>
                        <option value="guildOnly" ${guild.guildPrivacy == 'guildOnly' ? 'selected' : ''}>Private (Members only)</option>
                    </select>
                    <small class="text-muted">Controls who can see the guild page content.</small>
                </div>

                <div class="mb-3">
                    <label class="fw-bold mb-1">Join Method</label>
                    <select name="guildJoinMethod" class="form-select" style="max-width:400px;">
                        <option value="public" ${guild.guildJoinMethod == 'public' ? 'selected' : ''}>Open (Join button enabled)</option>
                        <option value="private" ${guild.guildJoinMethod == 'private' ? 'selected' : ''}>Invite Only (Requires code)</option>
                    </select>
                    <small class="text-muted">Controls how new members can enter the guild.</small>
                </div>
                <div class="mb-3">
                    <label class="fw-bold mb-1">Bio</label>
                    <textarea name="bio" class="form-control" rows="3">${guild.bio}</textarea>
                </div>
                <div class="mb-3">
                    <label class="fw-bold mb-1">Announcement</label>
                    <textarea name="announcement" class="form-control" rows="2">${guild.announcement}</textarea>
                </div>
            </div>

            <div class="section-card shadow-sm">
                <h3>Visuals</h3>
                <div class="avatar-grid mb-4">
                    <c:forEach var="img" items="orb-guild.png,dragon-guild.png,fire-guild.png,forest-guild.png">
                        <label>
                            <input type="radio" name="avatar" value="images/${img}" ${guild.avatar == 'images/'.concat(img) ? 'checked' : ''}>
                            <img src="${pageContext.request.contextPath}/images/${img}" alt="Avatar">
                        </label>
                    </c:forEach>
                </div>
                <div class="bg-grid">
                    <c:forEach var="bg" items="guild-background-one.png,guild-background-two.png,guild-background-three.png">
                        <label>
                            <input type="radio" name="background" value="images/${bg}" ${guild.background == 'images/'.concat(bg) ? 'checked' : ''}>
                            <img src="${pageContext.request.contextPath}/images/${bg}" alt="Background">
                        </label>
                    </c:forEach>
                </div>
            </div>

            <div class="d-flex align-items-center">
                <button type="submit" class="btn-save shadow-sm">
                    <i class="ph ph-floppy-disk me-2"></i>Save Settings
                </button>
                <button type="button" class="btn-manage shadow-sm" onclick="toggleManage()">
                    <i class="ph ph-wrench me-2"></i>Manage Guild
                </button>
                <a href="${pageContext.request.contextPath}/guild/${guild.guildName}" class="btn ms-auto text-muted fw-bold" style="text-decoration: none; font-size: 14px;">
                    <i class="ph ph-arrow-left me-1"></i> Back to Guild
                </a>
            </div>
        </form>

        <div id="managePanelWrapper">
            <div class="section-card shadow-sm" style="margin-top: 24px;">
                <h3>Members Management (${members.size()})</h3>
                <c:forEach var="member" items="${members}">
                    <div class="member-card">
                        <img src="${member.userProfile.avatar}" class="member-avatar" alt="User">
                        <div style="flex-grow: 1;">
                            <div class="fw-bold">${member.userProfile.firstName} ${member.userProfile.lastName}</div>
                            <div class="text-muted small">@${member.username}</div>
                            <c:choose>
                                <c:when test="${member.guildRole == 'MASTER'}"><span class="role-badge badge-master">Master</span></c:when>
                                <c:when test="${member.guildRole == 'CAPTAIN'}"><span class="role-badge badge-captain">Captain</span></c:when>
                                <c:otherwise><span class="role-badge badge-rookie">Rookie</span></c:otherwise>
                            </c:choose>
                        </div>
                        <c:if test="${member.id != currentUser.id}">
                            <div class="d-flex gap-2">
                                <form action="${pageContext.request.contextPath}/guild/${guild.guildName}/promote/${member.id}" method="post" style="margin:0;">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                    <button type="submit" class="btn btn-sm btn-outline-primary">
                                        <c:choose>
                                            <c:when test="${member.guildRole == 'ROOKIE'}">Promote</c:when>
                                            <c:otherwise>Make Master</c:otherwise>
                                        </c:choose>
                                    </button>
                                </form>
                                <form action="${pageContext.request.contextPath}/guild/${guild.guildName}/kick/${member.id}" method="post" style="margin:0;">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                    <button type="submit" class="btn btn-sm btn-outline-danger" onclick="return confirm('Kick this member?')">
                                        <i class="fa-solid fa-user-minus"></i>
                                    </button>
                                </form>
                            </div>
                        </c:if>
                    </div>
                </c:forEach>
            </div>

            <div class="section-card border border-danger shadow-sm">
                <h3 class="text-danger">Dissolve Guild</h3>
                <p class="text-muted small">To dissolve the guild, enter the details exactly as shown. These will be validated on the server.</p>
                <form action="${pageContext.request.contextPath}/delete/${guild.guildName}" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <div class="mb-3">
                        <label class="small fw-bold">Guild Name:</label>
                        <input type="text" name="guildName" class="form-control" autocomplete="off">
                    </div>
                    <div class="mb-3">
                        <label class="small fw-bold">Confirm Guild Name:</label>
                        <input type="text" name="confirmGuildName" class="form-control" autocomplete="off">
                    </div>
                    <button type="submit" class="btn-delete shadow-sm">Delete Guild</button>
                </form>
            </div>
        </div>
    </div>
</section>

<script>
    $(document).ready(function() {
        $('.fa-bars').click(function() { $('.side-nav').slideToggle(350); });
        $(window).resize(function() { if ($(window).width() >= 900) { $('.side-nav').removeAttr('style'); } });
        $('#profilePic').on('click', function() { $('.dropdown-menu').toggleClass('show'); });
        $(document).on('click', function(e) { if (!$(e.target).closest('#profileContainer').length) { $('.dropdown-menu').removeClass('show'); } });
    });
    function toggleManage() { $('#managePanelWrapper').slideToggle(); }
</script>
<script>const currentUserId = '<c:out value="${currentUser.id}"/>';</script>
<script src="${pageContext.request.contextPath}/js/notifications.js?v=1.01"></script>
<script src="${pageContext.request.contextPath}/js/sidebar-toggle.js"></script>
</body>
</html>
