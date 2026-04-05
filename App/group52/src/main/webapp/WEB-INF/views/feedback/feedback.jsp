<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Feedback | SkillsBuilder</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/@phosphor-icons/web@2.1.1/src/regular/style.css"/>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:ital,wght@0,100..700;1,100..700&display=swap" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <style>
        .feedback-section {
            padding-top: 24px;
        }

        .page-shell {
            max-width: 1450px;
            margin: 28px auto;
            padding: 0 18px;
        }

        .container-main {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            min-height: calc(100vh - 140px);
        }

        .card-box {
            background: white;
            padding: 24px;
            border-radius: 18px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.06);
            border: 1px solid #e0e0e0;
            box-sizing: border-box;
        }

        .messages {
            max-height: 72vh;
            overflow-y: auto;
            padding-right: 6px;
        }

        .msg {
            border: 1px solid #eee;
            padding: 14px;
            border-radius: 12px;
            margin-bottom: 14px;
            background: #fff;
        }

        .reply-box {
            background: #eef4ff;
            padding: 12px;
            border-radius: 10px;
            margin-top: 10px;
            border-left: 4px solid #2f6df6;
        }

        .user-reply-box {
            background: #f7f7f7;
            padding: 12px;
            border-radius: 10px;
            margin-top: 10px;
            border-left: 4px solid #999;
        }

        .timestamp {
            font-size: 12px;
            color: grey;
            display: block;
            margin-top: 4px;
        }

        textarea {
            width: 100%;
            border-radius: 10px;
            padding: 12px;
            border: 1px solid #ccc;
            box-sizing: border-box;
            resize: vertical;
        }

        textarea:focus {
            outline: none;
            border-color: #0f62fe;
            box-shadow: 0 0 0 0.15rem rgba(15, 98, 254, 0.15);
        }

        .reply-form {
            margin-top: 10px;
        }

        h3 {
            margin-bottom: 8px;
            font-family: "IBM Plex Sans", sans-serif;
            font-weight: 700;
        }

        .subtitle {
            color: #666;
            margin-bottom: 14px;
        }

        .submit-btn {
            background: #0f62fe;
            border: none;
            border-radius: 10px;
            font-weight: 600;
            padding: 10px 16px;
        }

        .submit-btn:hover {
            background: #0353e9;
        }

        @media (max-width: 900px) {
            body {
                overflow: auto;
            }

            .container-main {
                grid-template-columns: 1fr;
                min-height: auto;
            }

            .messages {
                max-height: none;
            }
        }

        @media (min-width: 900px) {
            .feedback-section {
                padding-left: 200px;
                padding-top: 90px;
            }
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

<section class="feedback-section">
    <div class="container-fluid page-shell">

        <div class="container-main">

            <div class="card-box">
                <h3>Send Feedback</h3>
                <p class="subtitle">We value your feedback</p>

                <c:if test="${success}">
                    <div class="alert alert-success">Feedback sent successfully.</div>
                </c:if>

                <c:if test="${error}">
                    <div class="alert alert-danger">Something went wrong. Please try again.</div>
                </c:if>

                <form method="post" action="${pageContext.request.contextPath}/feedback/submit">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <textarea name="message" rows="4" placeholder="Write your feedback..." required></textarea>
                    <button type="submit" class="btn btn-primary w-100 mt-3 submit-btn">Submit Feedback</button>
                </form>
            </div>

            <div class="card-box">
                <div class="d-flex justify-content-between align-items-center">
                    <h3>Your Messages</h3>
                    <button onclick="location.reload()" class="btn btn-sm btn-outline-secondary">
                        <i class="fa fa-refresh"></i>
                    </button>
                </div>

                <div class="messages">
                    <c:choose>
                        <c:when test="${empty userMessages}">
                            <p class="text-muted">You have not sent any feedback yet.</p>
                        </c:when>

                        <c:otherwise>
                            <c:forEach var="msg" items="${userMessages}">
                                <div class="msg">

                                    <strong>You said</strong>
                                    <p class="mb-1">${msg.message}</p>
                                    <span class="timestamp">${msg.formattedCreatedAt}</span>

                                    <c:if test="${not empty replyMap[msg.id]}">
                                        <c:forEach var="child" items="${replyMap[msg.id]}">

                                            <c:choose>
                                                <c:when test="${child.sender == 'admin'}">
                                                    <div class="reply-box">
                                                        <strong>Admin reply</strong>
                                                        <p class="mb-1">${child.message}</p>
                                                        <span class="timestamp">${child.formattedCreatedAt}</span>
                                                    </div>
                                                </c:when>

                                                <c:otherwise>
                                                    <div class="user-reply-box">
                                                        <strong>You replied</strong>
                                                        <p class="mb-1">${child.message}</p>
                                                        <span class="timestamp">${child.formattedCreatedAt}</span>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>

                                        </c:forEach>
                                    </c:if>

                                    <div class="reply-form">
                                        <form method="post" action="${pageContext.request.contextPath}/feedback/reply">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                            <input type="hidden" name="parentId" value="${msg.id}" />
                                            <textarea name="message" rows="2" placeholder="Write your reply..." required></textarea>
                                            <button type="submit" class="btn btn-outline-primary btn-sm mt-2">Reply</button>
                                        </form>
                                    </div>

                                </div>
                            </c:forEach>
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

        $('#profilePic').on('click', function(e) {
            e.stopPropagation();
            $('#profileContainer .dropdown-menu').toggleClass('show');
        });

        $(document).on('click', function(e) {
            if (!$(e.target).closest('#profileContainer').length) {
                $('#profileContainer .dropdown-menu').removeClass('show');
            }
            if (!$(e.target).closest('#notificationBoxContainer').length) {
                $('#notificationInboxMenu').removeClass('show');
            }
        });

        const timeZoneInput = document.querySelectorAll('.userTimeZone');
        timeZoneInput.forEach(input => {
            input.value = Intl.DateTimeFormat().resolvedOptions().timeZone;
        });

        const successAlert = document.querySelector('.alert-success');
        if (successAlert) {
            setTimeout(() => {
                successAlert.style.display = "none";
            }, 5000);
        }
    });



</script>
<script>const currentUserId = '<c:out value="${currentUser.id}"/>';</script>

<script src="${pageContext.request.contextPath}/js/notifications.js?v=1.01"></script>
<script src="${pageContext.request.contextPath}/js/sidebar-toggle.js"></script>
</body>
</html>
