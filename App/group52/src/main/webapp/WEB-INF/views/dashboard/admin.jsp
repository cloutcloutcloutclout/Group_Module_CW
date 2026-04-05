<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/@phosphor-icons/web@2.1.1/src/regular/style.css"/>
    <link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:ital,wght@0,100..700;1,100..700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">

    <style>
        .content {
            padding: 40px;
            margin-top: 100px;
        }
        @media (min-width: 900px) {
            .content {
                padding-left: 200px;
            }
        }
        .row {
            flex-wrap: wrap !important;
        }
        .content h1 {
            margin-bottom: 100px;
        }
    </style>
</head>
<body>

<nav class="navbar">
    <div class="nav-group">
        <a class="fa-solid fa-bars"></a>
        <a class="navbar-brand" href="${pageContext.request.contextPath}/dashboard">SkillsBuilder</a>
    </div>
    <div class="d-flex align-items-center" style="padding-right: 20px;">
        <form action="${pageContext.request.contextPath}/logout" method="post" style="margin:0;">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <button type="submit" class="btn btn-danger"><i class="fa-solid fa-power-off me-1"></i> Logout</button>
        </form>
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

<!-- Main board -->
<div class="content">
    <h1>Welcome, Administrator. Manage students account and courses here!</h1>




    <div class="container-fluid">
        <div class="row g-4">

            <!-- Users -->
            <div class="col-12 ">
                <div class="card shadow-sm">
                    <div class="card-body text-center">
                        <h4>Total Users</h4>
                        <h2>${userCount}</h2>
                    </div>
                </div>
            </div>

            <div class="col-12 ">
                <div class="card shadow-sm">
                    <div class="card-body text-center">
                        <h4>Total Courses</h4>
                        <h2>${courseCount}</h2>
                    </div>
                </div>
            </div>

            <div class="col-12 ">
                <div class="card shadow-sm">
                    <div class="card-body text-center">
                        <h4>Total Reviews</h4>
                        <h2>${reviewCount}</h2>
                    </div>
                </div>
            </div>


        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/sidebar-toggle.js"></script>
</body>
</html>
