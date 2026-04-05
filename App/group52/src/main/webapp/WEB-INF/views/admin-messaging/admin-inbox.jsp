<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Inbox | SkillsBuilder</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/@phosphor-icons/web@2.1.1/src/regular/style.css"/>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:ital,wght@0,100..700;1,100..700&display=swap" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">

    <style>
        .inbox-section {
            padding-top: 24px;
        }

        .page-shell {
            max-width: 1450px;
            margin: 28px auto;
            padding: 0 18px;
        }

        .topbar-card,
        .panel-card {
            background: #ffffff;
            border: 1px solid #e0e0e0;
            border-radius: 18px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
        }

        .topbar-card {
            padding: 26px 28px;
            margin-bottom: 22px;
        }

        .page-title {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 4px;
        }

        .page-subtitle {
            color: #6f6f6f;
            margin-bottom: 0;
        }

        .stats-row {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            margin-top: 14px;
        }

        .stat-chip {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 8px 12px;
            border-radius: 999px;
            font-size: 0.92rem;
            font-weight: 600;
        }

        .chip-unread {
            background: #fff2cc;
            color: #8a6d00;
        }

        .chip-read {
            background: #dde1e6;
            color: #393939;
        }

        .left-panel {
            height: 760px;
            overflow-y: auto;
            padding: 0;
        }

        .right-panel {
            min-height: 760px;
        }

        .panel-header {
            padding: 22px 24px 10px;
            font-weight: 700;
            font-size: 1.1rem;
        }

        .message-item {
            display: block;
            text-decoration: none;
            color: inherit;
            padding: 18px 20px;
            border-top: 1px solid #f0f0f0;
            transition: background 0.15s ease;
        }

        .message-item:hover {
            background: #f8fbff;
            color: inherit;
        }

        .message-item.selected {
            background: #edf5ff;
            border-left: 4px solid #0f62fe;
            padding-left: 16px;
        }

        .message-item.unread {
            background: #fffef7;
        }

        .message-item.read {
            opacity: 0.95;
        }

        .message-top {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 12px;
            margin-bottom: 10px;
        }

        .message-title {
            font-size: 1.05rem;
            font-weight: 700;
            margin-bottom: 4px;
            word-break: break-word;
        }

        .message-meta {
            font-size: 0.9rem;
            color: #6f6f6f;
            word-break: break-word;
        }

        .message-time {
            font-size: 0.82rem;
            color: #8d8d8d;
            margin-top: 4px;
        }

        .status-badge {
            border-radius: 999px;
            padding: 7px 12px;
            font-size: 0.78rem;
            font-weight: 700;
            flex-shrink: 0;
        }

        .status-new {
            background: #fff2cc;
            color: #8a6d00;
        }

        .status-read {
            background: #d9f0e3;
            color: #1f6b45;
        }

        .preview-block {
            font-size: 0.92rem;
            line-height: 1.45;
            color: #393939;
            margin-top: 10px;
        }

        .preview-label {
            font-weight: 700;
        }

        .empty-left {
            padding: 20px 24px 28px;
            color: #6f6f6f;
        }

        .detail-wrap {
            padding: 28px;
        }

        .detail-empty {
            min-height: 760px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            color: #6f6f6f;
            text-align: center;
        }

        .detail-title {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 10px;
        }

        .detail-meta {
            color: #525252;
            font-size: 0.95rem;
            margin-bottom: 14px;
        }

        .detail-badges {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            margin-bottom: 22px;
        }

        .skills-badge {
            background: #dde1e6;
            color: #393939;
            padding: 8px 12px;
            border-radius: 999px;
            font-size: 0.82rem;
            font-weight: 700;
        }

        .section-heading {
            font-size: 1.2rem;
            font-weight: 700;
            margin: 20px 0 12px;
        }

        .thread-card {
            border: 1px solid #e0e0e0;
            border-radius: 16px;
            padding: 16px;
            background: #ffffff;
            margin-bottom: 14px;
        }

        .bubble {
            border-radius: 16px;
            padding: 16px 18px;
            border: 1px solid #e0e0e0;
            background: #f8f9fb;
        }

        .bubble.admin {
            background: #edf5ff;
            border-left: 4px solid #0f62fe;
        }

        .bubble.user {
            background: #f7f7f7;
            border-left: 4px solid #8d8d8d;
        }

        .bubble-header {
            font-weight: 700;
            margin-bottom: 6px;
            text-transform: capitalize;
        }

        .bubble-time {
            font-size: 0.85rem;
            color: #6f6f6f;
            margin-top: 8px;
        }

        .thread-actions {
            margin-top: 12px;
        }

        .reply-btn {
            background: #0f62fe;
            border: none;
            border-radius: 8px;
            padding: 8px 14px;
            font-weight: 600;
        }

        .reply-btn:hover {
            background: #0353e9;
        }

        .delete-btn {
            border-radius: 8px;
            padding: 8px 14px;
            font-weight: 600;
        }

        .detail-divider {
            margin: 22px 0;
            border-color: #e0e0e0;
        }

        @media (max-width: 991px) {
            .left-panel,
            .right-panel,
            .detail-empty {
                min-height: auto;
                height: auto;
            }

            .detail-title {
                font-size: 1.6rem;
            }
        }

        @media (min-width: 900px) {
            .inbox-section {
                padding-left: 200px;
                padding-top: 90px;
            }
        }
    </style>
</head>
<body>
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
                <div id="inboxItems"></div>
            </div>
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

<section class="inbox-section">
    <div class="container-fluid page-shell">

        <div class="topbar-card d-flex justify-content-between align-items-start flex-wrap gap-3">
            <div>
                <div class="page-title">Admin Inbox</div>
                <p class="page-subtitle">Manage feedback and admin messages</p>

                <div class="stats-row">
                    <span class="stat-chip chip-unread">Unread: ${unreadCount}</span>
                    <span class="stat-chip chip-read">Read: ${readCount}</span>
                </div>
            </div>
        </div>

        <div class="row g-4">

            <div class="col-lg-5">
                <div class="panel-card left-panel">
                    <div class="panel-header d-flex justify-content-between align-items-center">
                        <span>Messages</span>
                        <button onclick="location.reload()" class="btn btn-sm btn-outline-secondary">
                            <i class="fa fa-refresh"></i>
                        </button>
                    </div>

                    <c:choose>
                        <c:when test="${not empty messages}">
                            <c:forEach var="msg" items="${messages}">
                                <a href="${pageContext.request.contextPath}/admin/inbox?id=${msg.id}"
                                   class="message-item
                                   <c:if test='${not empty selectedMessage and ((not empty threadRoot and threadRoot.id == msg.id) or selectedMessage.id == msg.id)}'>selected</c:if>
                                   <c:choose>
                                       <c:when test='${msg.status == "NEW"}'> unread</c:when>
                                       <c:otherwise> read</c:otherwise>
                                   </c:choose>">

                                    <div class="message-top">
                                        <div>
                                            <div class="message-title">Conversation from ${msg.sender}</div>
                                            <div class="message-meta">From: ${msg.sender}</div>
                                            <div class="message-time">${msg.formattedCreatedAt}</div>
                                        </div>

                                        <c:choose>
                                            <c:when test="${msg.status == 'NEW'}">
                                                <span class="status-badge status-new">UNREAD</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-badge status-read">READ</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <div class="preview-block">
                                        <div>
                                            <span class="preview-label">Started:</span>
                                            <c:choose>
                                                <c:when test="${fn:length(msg.message) > 52}">
                                                    ${fn:substring(msg.message, 0, 52)}...
                                                </c:when>
                                                <c:otherwise>
                                                    ${msg.message}
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </a>
                            </c:forEach>
                        </c:when>

                        <c:otherwise>
                            <div class="empty-left">No messages found.</div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <div class="col-lg-7">
                <div class="panel-card right-panel">
                    <c:choose>
                        <c:when test="${not empty selectedMessage}">
                            <div class="detail-wrap">

                                <c:set var="rootMsg" value="${not empty threadRoot ? threadRoot : selectedMessage}" />

                                <div class="detail-title">Conversation #${rootMsg.id}</div>

                                <div class="detail-meta">
                                    <div><strong>Started by:</strong> ${rootMsg.sender}</div>
                                    <div><strong>Created:</strong> ${rootMsg.formattedCreatedAt}</div>
                                </div>

                                <div class="detail-badges">
                                    <span class="skills-badge">Feedback Thread</span>

                                    <c:choose>
                                        <c:when test="${rootMsg.status == 'NEW'}">
                                            <span class="status-badge status-new">UNREAD</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge status-read">READ</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <hr class="detail-divider">

                                <div class="section-heading">Conversation</div>

                                <div class="thread-card">
                                    <div class="bubble user">
                                        <div class="bubble-header">${rootMsg.sender}</div>
                                        <div>${rootMsg.message}</div>
                                        <div class="bubble-time">${rootMsg.formattedCreatedAt}</div>
                                    </div>
                                </div>

                                <c:if test="${not empty threadReplies}">
                                    <c:forEach var="child" items="${threadReplies}">
                                        <div class="thread-card">

                                            <c:choose>
                                                <c:when test="${child.sender == 'admin'}">
                                                    <div class="bubble admin">
                                                        <div class="bubble-header">Admin</div>
                                                        <div>${child.message}</div>
                                                        <div class="bubble-time">${child.formattedCreatedAt}</div>
                                                    </div>
                                                </c:when>

                                                <c:otherwise>
                                                    <div class="bubble user">
                                                        <div class="bubble-header">${child.sender}</div>
                                                        <div>${child.message}</div>
                                                        <div class="bubble-time">${child.formattedCreatedAt}</div>
                                                    </div>

                                                    <div class="thread-actions">
                                                        <a href="${pageContext.request.contextPath}/admin/reply?id=${child.id}"
                                                           class="btn btn-primary btn-sm reply-btn">
                                                            Reply
                                                        </a>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>

                                        </div>
                                    </c:forEach>
                                </c:if>

                                <div class="d-flex gap-2 flex-wrap mt-4">
                                    <a href="${pageContext.request.contextPath}/admin/reply?id=${rootMsg.id}"
                                       class="btn btn-primary reply-btn">
                                        Reply to Conversation
                                    </a>

                                    <form id="deleteForm"
                                          method="post"
                                          action="${pageContext.request.contextPath}/admin/delete"
                                          class="mb-0">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        <input type="hidden" name="id" value="${rootMsg.id}" />
                                        <button type="button"
                                                class="btn btn-outline-danger delete-btn"
                                                data-bs-toggle="modal"
                                                data-bs-target="#deleteModal">
                                            Delete
                                        </button>
                                    </form>

                                    <div class="modal fade" id="deleteModal" tabindex="-1">
                                        <div class="modal-dialog modal-dialog-centered">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title">Delete Conversation</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                </div>

                                                <div class="modal-body">
                                                    Are you sure you want to delete this conversation?
                                                </div>

                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                                        Cancel
                                                    </button>
                                                    <button type="submit" form="deleteForm" class="btn btn-danger">
                                                        Delete
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </c:when>

                        <c:otherwise>
                            <div class="detail-empty">
                                <h4 class="mb-2">Select a conversation</h4>
                                <p class="mb-0">Choose a conversation from the left to view the full thread.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
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
            $(this).closest('#profileContainer').find('.dropdown-menu').toggleClass('show');
        });

        $(document).on('click', function(e) {
            if (!$(e.target).closest('#profileContainer').length) {
                $('#profileContainer .dropdown-menu').removeClass('show');
            }
        });

        const timeZoneInput = document.querySelectorAll('.userTimeZone');
        timeZoneInput.forEach(input => {
            input.value = Intl.DateTimeFormat().resolvedOptions().timeZone;
        });
    });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>const currentUserId = '<c:out value="${currentUser.id}"/>';</script>
<script src="${pageContext.request.contextPath}/js/notifications.js?v=1.01"></script>
<script src="${pageContext.request.contextPath}/js/sidebar-toggle.js"></script>
</body>
</html>