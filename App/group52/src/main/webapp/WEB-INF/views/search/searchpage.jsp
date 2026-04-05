<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE HTML>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Find Courses</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous"> <%--link to bootstap css --%>
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/@phosphor-icons/web@2.1.1/src/regular/style.css"/>
    <link rel="preconnect" href="https://fonts.googleapis.com"> <%-- intergration for google font--%>

    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:ital,wght@0,100..700;1,100..700&display=swap" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script> <%-- link to jquery--%>

    <%--    CSS--%>
    <style>

        body { background-color: #F1F9F8 !important; margin-bottom: 80px !important; }
        nav { background-color: #9BAEE9; }
        .navbar-brand { font-family: "IBM Plex Sans", sans-serif; font-weight: 600; color: black; font-size: 23px !important; transition: color 0.2s ease; text-decoration: none;}
        .navbar-brand:hover { color: white; cursor: pointer; }
        .nav-group { display: flex; align-items: center; gap: 10px; }
        .fa-bars { color: black; font-size: 33px; text-decoration: none; margin-left: 15px; transition: color 0.2s ease; }
        .dropdown-menu { display: none; position: absolute; top: 100%; right: 0; z-index: 1000; min-width: 180px; padding: 0.5rem 0; margin-top: 10px; background-color: white; border-radius: 8px; list-style: none; text-align: left; }
        .dropdown-menu.show { display: block; animation: snappyFade 0.15s cubic-bezier(0.2, 0, 0.2, 1) forwards; }
        .dropdown-item { font-family: "IBM Plex Sans", sans-serif; }
        @keyframes snappyFade { from { opacity: 0; transform: translateY(8px); } to { opacity: 1; transform: translateY(0); } }
        .dropdown-item:focus, .dropdown-item:active { background-color: transparent !important; color: inherit !important; }
        .fa-bars:hover { cursor: pointer; color: white; }
        .profile-pic { width: 45px; height: 45px; border-radius: 50%; object-fit: cover; border-color: black; border-style: solid; transition: color 0.2s ease; }
        .profile-pic:hover { box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3); cursor: pointer; }
        .btn-group { padding-right: 10px; }
        .side-nav { background-color: #302B27; display: none;  z-index: 1000; }
        .side-link { text-decoration: none; display: block; color: white; padding: 10px; font-family: "IBM Plex Sans", sans-serif; font-weight: 300; font-size: 23px; }
        .side-link:hover { background-color: rgba(255, 255, 255, 0.10) !important;; color: white; width: 100%; }

        /* spacing for search box */
        .search-info { padding-top: 40px; padding-bottom: 20px; }

        /* CSS for course grid */
        .Courses { padding-top: 20px; margin-bottom: 10px !important; position: relative; }
        .Courses::before { content: ""; position: absolute; top: 0; left: 10%; right: 10%; height: 1px; background-color: rgba(0, 0, 0, 0.1); }
        .card { border-radius: 10px !important; margin-right: 20px; margin-left: 20px; margin-top: 10px; }
        .course-card { transition: transform 0.4s cubic-bezier(0.22, 1, 0.36, 1), box-shadow 0.4s cubic-bezier(0.22, 1, 0.36, 1); }
        .course-card:hover { box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3); cursor: pointer; transform: translateY(-8px); }

        /*CSS for headings */
        h2 { font-family: "IBM Plex Sans", sans-serif; font-weight: 400 !important; margin-right: 20px; margin-left: 20px; font-size: 30px !important; }
        h3 { font-family: "IBM Plex Sans", sans-serif; font-weight: 500 !important; }
        h5 { font-family: "IBM Plex Sans", sans-serif; font-weight: 600 !important; font-size: 20px !important; }
        .card-subtitle { font-family: "IBM Plex Sans", sans-serif; }
        .card-text { font-family: "IBM Plex Sans", sans-serif; font-weight: 300 !important; }

        @media (min-width: 768px) {
            h3 { font-size: 25px !important; }
            .card { width: 100%; margin: 0; }
            .card-subtitle { font-size: 15px; }
            .card-text { font-size: 15px; }
        }

        @media (min-width: 900px) {
            .navbar { position: fixed !important; width: 100%; z-index: 1050; }
            .navbar-brand { padding-left: 10px; }
            .fa-bars { display: none; }
            .side-nav { position: fixed; top: 60px; bottom: 0; left: 0; display: block; }
            .side-link { font-size: 20px; margin-right: 20px; padding-top: 20px; }
            section { padding-left: 200px; }
            .search-info { padding-top: 100px; }
            .Courses::before { left: calc(200px + 5%); right: 5%; }
        }

        @media (min-width: 992px) {
            h1 { padding-top: 50px !important; font-size: 35px !important; }
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

        .side-nav .admin-link-container {position: absolute; bottom: 0;  width: 100%; left: 0; z-index: 1001;}
        .side-nav .admin-link-container a{display: block; padding: 10px; font-size: 20px; color: white; text-decoration: none; width: 100%;}
        .side-nav .admin-link-container a:hover{background-color: rgba(255, 255, 255, 0.1); color: white;}

    </style>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
</head>
<body>
<%--notifications container--%>
<div id="notificationContainer" style="position: fixed; top: 80px; right: 20px; z-index: 1060; display: flex; flex-direction: column; gap: 10px;"></div>

<div aria-live="polite" aria-atomic="true" class="position-relative">
    <div class="toast-container position-fixed bottom-0 end-0 p-3" style="z-index: 1100;">
        <div id="appToast" class="toast align-items-center text-white bg-success border-0" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="d-flex">
                <div class="toast-body" id="appToastBody">
                    Message
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
        </div>
    </div>
</div>

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

        <%--    profile button--%>
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


<%--side navigation bar buttons --%>
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

<section class="search-info">
    <div class="container">

        <%-- search box heading --%>
        <c:if test="${not empty message}">
            <div class="alert alert-success alert-dismissible fade show text-center mb-4 shadow-sm" role="alert" style="border-radius: 12px;">
                <strong>Awesome!</strong> ${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <%--        search box--%>
        <div class="card shadow-sm p-4 mb-5 bg-white border-0" style="border-radius: 12px">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h3 class="fw-bold text-dark m-0">Find Your Next Course</h3>
                <button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#createGoalModal">
                    <i class="fa-solid fa-plus me-1"></i> Create Goal
                </button>
            </div>

            <form action="/search" method="get" class="row g-3 align-items-end">
                <div class="col-12 col-md-5">
                    <label class="form-label fw-medium text-secondary" style="font-family: 'IBM Plex Sans', sans-serif;">Search Course</label>
                    <div class="input-group">
                        <span class="input-group-text bg-light border-end-0"><i class="fa-solid fa-search"></i></span>
                        <input type="text" name="course" class="form-control border-start-0 ps-0 py-2" placeholder="Search courses..." value="${param.course}">
                    </div>
                </div>

                <%--                dropdown for course categories--%>
                <div class="col-12 col-md-4">
                    <label class="form-label fw-medium text-secondary" style="font-family: 'IBM Plex Sans', sans-serif;">Category</label>
                    <select name="category" class="form-select py-2" onchange="this.form.submit()">
                        <option value="">Select category </option>
                        <option value="Web Development">Web Development</option>
                        <option value="Cloud Computing">Cloud Computing</option>
                        <option value="Professional Skills">Professional Skills</option>
                        <option value="Artificial Intelligence">Artificial Intelligence</option>
                        <option value="Cybersecurity">Cybersecurity</option>
                        <option value="Data Science">Data Science</option>
                        <option value="Sustainability">Sustainability</option>
                        <option value="Job Readiness">Job Readiness</option>
                        <option value="Quantum Computing">Quantum Computing</option>
                        <option value="Mainframe">Mainframe</option>
                    </select>
                </div>

                <%--                dropdown for the sort by time--%>
                <div class="col-12 col-md-3">
                    <label class="description-from-type-label fw-medium text-secondary" style="font-family: 'IBM Plex Sans', sans-serif;">Sort by time:</label>
                    <select name="sortParam" class="form-select py-2" onchange="this.form.submit()">
                        <option value="">Default</option>
                        <option value="asc">Time: Low to High</option>
                        <option value="desc">Time: High to Low</option>
                    </select>
                </div>
            </form>
        </div>
    </div>
</section>


<%-- trending courses --%>
<c:if test="${not empty trendingCourses3}">
    <section class="Courses pt-2 pb-2">
        <div class="container-fluid px-xl-4">

            <h2 class="mb-4 text-secondary"> Trending Courses: </h2>

            <div class="row g-4 courses">
                <c:forEach var="trendCourse" items="${trendingCourses3}" varStatus="status">
                    <div class="col-12 col-md-6 col-lg-4 col-xl-3 mb-4">

                        <div class="card shadow-sm course-card h-100">

                            <img src="${trendCourse.image}" class="card-img-top" alt="Course Image" style="aspect-ratio: 1 / 1; object-fit: contain; background: #fff; width: 100%; height: auto; border-top-left-radius: 0; border-top-right-radius: 0;">

                            <div class="card-body d-flex flex-column flex-grow-1">

                                <h3 class="card-title text-center text-primary fw-bold mb-2" style="font-size: 20px !important;">
                                        ${trendCourse.name}
                                </h3>
                                <p class="card-text card-description text-muted small text-center">${trendCourse.description}</p>

                                <div class="card-actions">
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <span class="text-muted small"><i class="fa-regular fa-clock me-1"></i> ${trendCourse.durationMinutes} mins</span>

                                        <div class="shadow-sm d-flex justify-content-center align-items-center flex-shrink-0"
                                             style="padding: 4px 12px; border-radius: 16px; font-size: 0.85rem; font-weight: bold; font-family: 'IBM Plex Sans', sans-serif;
                                                     background-color: ${status.count == 1 ? '#FFD700' : (status.count == 2 ? '#C0C0C0' : '#CD7F32')};
                                                     color: ${status.count == 1 ? 'black' : 'white'};">
                                                ${status.count == 1 ? '1st Most Popular' : (status.count == 2 ? '2nd Most Popular' : '3rd Most Popular')}
                                        </div>
                                    </div>
                                </div>

                                <a href="/courses/details/${trendCourse.id}" class="btn btn-primary mb-2 py-2">View Details</a>
                                <form action="${pageContext.request.contextPath}/addCourse" method="POST" class=" w-100 m-0">
                                    <input type="hidden" name="courseId" value="${trendCourse.id}">
                                    <input type="hidden" name="userid" value="${sessionScope.user.id}">

                                </form>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </section>
</c:if>
<%--results section--%>
<section class="Courses">
    <div class="container-fluid px-xl-4">


        <c:if test="${not empty param.course}">
            <h2 class="mb-4 text-secondary">Results for ${param.course}</h2>
        </c:if>

        <h2 class="mb-4 text-secondary"> Courses: </h2>
        <div class="row g-4 courses">
            <c:forEach var="course" items="${courses}">
                <div class="col-12 col-md-6 col-lg-4 col-xl-3 mb-4">
                    <div class="card shadow-sm course-card h-100">
                        <img src="${course.image}" class="card-img-top" alt="Course Image" style="aspect-ratio: 1 / 1; object-fit: contain; background: #fff; width: 100%; height: auto;">
                        <div class="card-body d-flex flex-column flex-grow-1">
                            <h3 class="card-title text-center text-primary fw-bold" style="font-size: 20px !important;">${course.name}</h3>
                            <p class="card-text card-description text-muted small text-center mb-3">${course.description}</p>

                            <div class="card-actions">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <span class="text-muted small">
                                    <i class="fa-regular fa-clock me-1"></i> ${course.durationMinutes} mins
                                </span>

                                <c:set var="avg" value="${courseRatings[course.id]}" />

                                <c:if test="${empty avg}">
                                    <%
                                        int dummy = (int)(Math.random() * 5) + 1;
                                        pageContext.setAttribute("avg", dummy);
                                    %>
                                </c:if>
                                <div class="text-center">
                                    <c:forEach begin="1" end="5" var="i">
                                        <i class="fa-solid fa-star" style="color: ${i <= avg ? 'gold' : '#ccc'};"></i>
                                    </c:forEach>
                                    <span class="small text-muted">(${avg})</span>
                                </div>
                            </div>
                            <div class="d-flex gap-2 mb-2">
                                <a href="/courses/details/${course.id}" class="btn btn-outline-primary w-100" style="font-size: 14px;">View Details</a>
                                <button type="button" class="btn btn-outline-success w-100" style="font-size: 14px;" data-course-id="${course.id}" data-course-name="<c:out value='${course.name}'/>" onclick="openAddToGoalModal(this)">Add to Goal</button>
                            </div>
                            <form action="${pageContext.request.contextPath}/addCourse" method="POST" class="w-100 m-0">
                                <input type="hidden" name="courseId" value="${course.id}">
                                <input type="hidden" name="userid" value="${sessionScope.user.id}">
                            </form>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <c:if test="${empty courses}">
            <div class="text-center warning-text pt-5 pb-5">
                <h5 class="text-muted">No courses found.</h5>
            </div>
        </c:if>

    </div>
</section>

<div class="modal fade" id="createGoalModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content" style="border-radius: 12px;">
            <div class="modal-header">
                <h5 class="modal-title" style="font-family: 'IBM Plex Sans', sans-serif;">Create a New Goal</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="createGoalForm">
                    <div class="mb-3">
                        <label for="newGoalName" class="form-label" style="font-family: 'IBM Plex Sans', sans-serif; font-size: 14px;">Goal Name</label>
                        <input type="text" class="form-control" id="newGoalName" name="courseName" placeholder="E.g. Summer Learning" required>
                    </div>
                    <div class="mb-3">
                        <label for="newGoalStartDate" class="form-label" style="font-family: 'IBM Plex Sans', sans-serif; font-size: 14px;">Start Date</label>
                        <input type="date" class="form-control" id="newGoalStartDate" name="startDate" required>
                    </div>
                    <div class="mb-3">
                        <label for="newGoalTargetDate" class="form-label" style="font-family: 'IBM Plex Sans', sans-serif; font-size: 14px;">Target Completion Date</label>
                        <input type="date" class="form-control" id="newGoalTargetDate" name="targetDate" required>
                    </div>
                    <div class="mb-3">
                        <label for="newGoalColor" class="form-label" style="font-family: 'IBM Plex Sans', sans-serif; font-size: 14px;">Color</label>
                        <input type="color" class="form-control form-control-color" id="newGoalColor" name="color" value="#0f62fe">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="btnCreateNewGoal">Create Goal</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="addToGoalModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content" style="border-radius: 12px;">
            <div class="modal-header">
                <h5 class="modal-title" style="font-family: 'IBM Plex Sans', sans-serif;">Add <span id="addGoalCourseNameTitle"></span> to Goal</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="addToGoalForm">
                    <input type="hidden" id="addGoalCourseId" name="courseId">
                    <div class="mb-3">
                        <label for="existingGoalsSelect" class="form-label" style="font-family: 'IBM Plex Sans', sans-serif; font-size: 14px;">Select Goal to Attach To</label>
                        <select class="form-select" id="existingGoalsSelect" required>
                            <option value="">Loading goals...</option>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-success" id="btnAddToGoal">Attach Course</button>
            </div>
        </div>
    </div>
</div>

<%--javascript--%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script>
    function showToast(message, isError = false) {
        var toastEl = document.getElementById('appToast');
        var toastBody = document.getElementById('appToastBody');
        toastBody.textContent = message;
        
        if (isError) {
            toastEl.classList.remove('bg-success');
            toastEl.classList.add('bg-danger');
        } else {
            toastEl.classList.remove('bg-danger');
            toastEl.classList.add('bg-success');
        }

        var toast = new bootstrap.Toast(toastEl);
        toast.show();
    }

    function openAddToGoalModal(btn) {
        const courseId = btn.getAttribute('data-course-id');
        const courseName = btn.getAttribute('data-course-name');
        
        document.getElementById('addToGoalForm').reset();
        document.getElementById('addGoalCourseId').value = courseId;
        document.getElementById('addGoalCourseNameTitle').innerText = courseName;
        
        let selectBox = document.getElementById('existingGoalsSelect');
        selectBox.innerHTML = '<option value="">Loading goals...</option>';
        
        var modal = new bootstrap.Modal(document.getElementById('addToGoalModal'));
        modal.show();

        fetch('/goals/api/all')
            .then(response => response.json())
            .then(data => {
                const inProgressGoals = data.filter(g => g.status === 'IN_PROGRESS' || g.status === 'ACTIVE');
                if (inProgressGoals.length === 0) {
                    selectBox.innerHTML = '<option value="">No active goals found. Create one first!</option>';
                } else {
                    selectBox.innerHTML = '<option value="">-- Choose a Goal --</option>';
                    inProgressGoals.forEach(g => {
                        let opt = document.createElement('option');
                        opt.value = g.id;
                        opt.textContent = g.courseName + " (Due: " + g.targetDate + ")";
                        selectBox.appendChild(opt);
                    });
                }
            })
            .catch(error => {
                selectBox.innerHTML = '<option value="">Error loading goals.</option>';
                console.error(error);
            });
    }

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

        document.getElementById('createGoalModal').addEventListener('show.bs.modal', function () {
            const defaultDate = new Date().toISOString().split('T')[0];
            document.getElementById('createGoalForm').reset();
            document.getElementById('newGoalStartDate').value = defaultDate;
            let target = new Date();
            target.setDate(target.getDate() + 7);
            document.getElementById('newGoalTargetDate').value = target.toISOString().split('T')[0];
        });

        document.getElementById('btnCreateNewGoal').addEventListener('click', function() {
            var newGoalName = document.getElementById('newGoalName').value;
            if (!newGoalName || newGoalName.trim() === '') {
                showToast("Goal Name cannot be empty.", true);
                return;
            }

            var goal = {
                courseId: "",
                courseName: newGoalName,
                targetDate: document.getElementById('newGoalTargetDate').value,        
                color: document.getElementById('newGoalColor').value,
                status: 'IN_PROGRESS'
            };

            var csrfInput = document.querySelector('input[name="_csrf"]');
            var headers = {
                'Content-Type': 'application/json'
            };
            if (csrfInput) {
                headers['X-CSRF-TOKEN'] = csrfInput.value;
            }

            fetch('/goals/api/save', {
                method: 'POST',
                headers: headers,
                body: JSON.stringify(goal)
            })
            .then(response => {
                if (response.ok) {
                    let modalInstance = bootstrap.Modal.getInstance(document.getElementById('createGoalModal'));
                    if (modalInstance) modalInstance.hide();
                    showToast("Goal created successfully! You can now attach courses to it.");
                } else {
                    throw new Error('Network response was not ok');
                }
            })
            .catch(error => {
                console.error('Error creating goal:', error);
                showToast("Error creating goal.", true);
            });
        });

        document.getElementById('btnAddToGoal').addEventListener('click', function() {
            var goalId = document.getElementById('existingGoalsSelect').value;
            var courseId = document.getElementById('addGoalCourseId').value;
            
            if (!goalId) {
                showToast("Please select a goal.", true);
                return;
            }

            var csrfInput = document.querySelector('input[name="_csrf"]');
            var headers = {};
            if (csrfInput) {
                headers['X-CSRF-TOKEN'] = csrfInput.value;
            }

            fetch('/goals/api/addCourse?goalId=' + encodeURIComponent(goalId) + '&courseId=' + encodeURIComponent(courseId), {
                method: 'POST',
                headers: headers
            })
            .then(async response => {
                if (response.ok) {
                    let modalInstance = bootstrap.Modal.getInstance(document.getElementById('addToGoalModal'));
                    if (modalInstance) modalInstance.hide();
                    showToast("Course successfully added to goal!");
                } else if (response.status === 409) {
                    throw new Error("Course is already part of this goal.");
                } else {
                    throw new Error('Network response was not ok');
                }
            })
            .catch(error => {
                console.error('Error adding course to goal:', error);
                showToast(error.message || "Error adding course to goal.", true);
            });
        });

        //script to detect the users timezone
        const timeZoneInputs = document.querySelectorAll('.userTimeZone');
        timeZoneInputs.forEach(input => {
            input.value = Intl.DateTimeFormat().resolvedOptions().timeZone;
        });

        //script to save the dropdowns for the category's and sort once pressed
        if ("${param.category}"){
            document.querySelector('select[name="category"]').value="${param.category}";
        }
        if ("${param.sortParam}"){
            document.querySelector('select[name="sortParam"]').value = "${param.sortParam}";
        }
    });
</script>
<script>const currentUserId = '<c:out value="${currentUser.id}"/>';</script>

<script src="${pageContext.request.contextPath}/js/notifications.js?v=999"></script>
<script src="${pageContext.request.contextPath}/js/sidebar-toggle.js"></script>
</body>
</html>
