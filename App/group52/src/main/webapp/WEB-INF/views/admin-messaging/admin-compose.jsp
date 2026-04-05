<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Compose Admin Message | SkillsBuilder</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/@phosphor-icons/web@2.1.1/src/regular/style.css"/>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:ital,wght@0,100..700;1,100..700&display=swap" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <style>
        body {
            background-color: #F1F9F8 !important;
            margin-bottom: 80px !important;
            font-family: "IBM Plex Sans", Arial, sans-serif;
            color: #161616;
        }

        /* Navbar */
        nav {
            background-color: #9BAEE9;
        }

        .navbar {
            padding: 10px 16px;
        }

        .navbar-brand {
            font-family: "IBM Plex Sans", sans-serif;
            font-weight: 600;
            color: black;
            font-size: 23px !important;
            transition: color 0.2s ease;
            text-decoration: none;
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

        .fa-bars:hover {
            cursor: pointer;
            color: white;
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

        .dropdown-item:focus,
        .dropdown-item:active {
            background-color: transparent !important;
            color: inherit !important;
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

        /* Sidebar */
        .side-nav {
            background-color: #302B27;
            display: none;
            width: 200px;
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

        /* Page */
        .compose-section {
            padding-top: 24px;
        }

        .page-shell {
            max-width: 1100px;
            margin: 28px auto;
            padding: 0 18px;
        }

        .topbar-card,
        .compose-card {
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

        .compose-card {
            padding: 28px;
        }

        .section-heading {
            font-size: 1.4rem;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .section-subtitle {
            color: #6f6f6f;
            margin-bottom: 22px;
        }

        .form-label {
            font-weight: 600;
            margin-bottom: 8px;
        }

        .form-control {
            border-radius: 12px;
            border: 1px solid #c6c6c6;
            padding: 12px 14px;
        }

        .form-control:focus {
            border-color: #0f62fe;
            box-shadow: 0 0 0 0.15rem rgba(15, 98, 254, 0.15);
        }

        .compose-btn {
            background: #0f62fe;
            border: none;
            border-radius: 10px;
            padding: 11px 16px;
            font-weight: 600;
        }

        .compose-btn:hover {
            background: #0353e9;
        }

        .secondary-btn {
            border-radius: 10px;
            padding: 11px 16px;
            font-weight: 600;
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

            .compose-section {
                padding-left: 200px;
                padding-top: 90px;
            }
        }
    </style>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
</head>
<body>

<nav class="navbar">
    <div class="nav-group">
        <a class="fa-solid fa-bars"></a>
        <a class="navbar-brand" href="${pageContext.request.contextPath}/dashboard">SkillsBuilder</a>
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

<section class="compose-section">
    <div class="container-fluid page-shell">

        <div class="topbar-card">
            <div class="page-title">Compose New Message</div>
            <p class="page-subtitle">Send a message to the admin inbox.</p>
        </div>

        <div class="compose-card">
            <div class="section-heading">New message</div>
            <p class="section-subtitle">Write your message below and send it to the admin inbox.</p>

            <form action="${pageContext.request.contextPath}/admin/compose" method="post">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                <div class="mb-3">
                    <label class="form-label">Message</label>
                    <textarea class="form-control"
                              name="message"
                              rows="8"
                              required></textarea>
                </div>

                <div class="d-flex gap-2 flex-wrap">
                    <button type="submit" class="btn btn-primary compose-btn">
                        Send Message
                    </button>

                    <a href="${pageContext.request.contextPath}/admin/inbox"
                       class="btn btn-outline-secondary secondary-btn">
                        Back to Inbox
                    </a>
                </div>
            </form>
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
<script src="${pageContext.request.contextPath}/js/sidebar-toggle.js"></script>

</body>
</html>