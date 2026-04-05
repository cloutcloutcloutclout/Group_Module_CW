<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
    <title>Account Details</title>
    <style>
        body {
            background-color: #F1F9F8;
            margin-bottom: 80px;
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
            width: 45px;
            height: 45px;
            border-radius: 50%;
            object-fit: cover;
            border-color: black;
            border-style: solid;
            transition: color 0.2s ease;
        }

        .profile-pic:hover { box-shadow: 0 5px 15px rgba(0,0,0,0.3); cursor: pointer; }

        .btn-group { padding-right: 10px; }

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

        .side-link:hover {
            background-color: rgba(255,255,255,0.10);
            color: white;
            width: 100%;
        }

        .account-section {
            padding-top: 40px;
            padding-bottom: 60px;
        }

        .account-section h2 {
            font-family: "IBM Plex Sans", sans-serif;
            font-weight: 500;
            font-size: 30px;
            margin-bottom: 30px;
        }

        @media (min-width: 900px) {
            .navbar {
                position: fixed !important;
                width: 100%;
                z-index: 1050;
            }

            .navbar-brand { padding-left: 10px; }
            .fa-bars { display: none; }

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

            section { padding-left: 200px; }

            .account-section { padding-top: 100px; }
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
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile/${user.id}"><i class="fa-solid fa-circle-user me-2"></i>View Profile</a></li>
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/editProfile/${user.id}"><i class="fa-solid fa-user-pen me-2"></i>Edit Profile</a></li>
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/friends/${user.id}"><i class="fa-solid fa-user-group me-2"></i>Friends</a></li>
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

<section class="account-section">
    <div class="container">
        <h2>${user.username}'s Account Details</h2>

        <div style="background: white; border-radius: 10px; padding: 24px 28px; max-width: 480px; box-shadow: 0 2px 8px rgba(0,0,0,0.07);">
            <h5 style="font-family: 'IBM Plex Sans', sans-serif; font-weight: 500; border-bottom: 1px solid #ccc; padding-bottom: 6px; margin-bottom: 12px;">Username</h5>
            <p style="font-family: 'IBM Plex Sans', sans-serif; margin-bottom: 24px;">${user.username}</p>

            <h5 style="font-family: 'IBM Plex Sans', sans-serif; font-weight: 500; border-bottom: 1px solid #ccc; padding-bottom: 6px; margin-bottom: 12px;">Email</h5>
            <p style="font-family: 'IBM Plex Sans', sans-serif; margin-bottom: 0;">${user.email}</p>
        </div>

        <br/>

        <a href="${pageContext.request.contextPath}/editAccount/${user.id}" class="btn btn-primary mt-3">Edit Account Details</a>
    </div>
</section>

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
<script src="${pageContext.request.contextPath}/js/sidebar-toggle.js"></script>
</body>
</html>
