<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Course Goals Calendar | SkillsBuilder</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #F1F9F8 !important;
            margin-bottom: 80px !important;
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

        @keyframes snappyFade {
            from { opacity: 0; transform: translateY(8px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        .dropdown-item:focus,
        .dropdown-item:active {
            background-color: transparent !important;
            color: inherit !important;
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
            background-color: rgba(255, 255, 255, 0.10);
            color: white;
            width: 100%;
        }

        .calendar-content {
            padding-top: 40px;
            padding-bottom: 50px;
        }

        #calendar { 
            max-width: 900px; 
            margin: 0 auto; 
            background: white; 
            padding: 20px; 
            border-radius: 8px; 
            box-shadow: 0 4px 6px rgba(0,0,0,0.1); 
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
                z-index: 1000;
            }

            .side-link {
                font-size: 20px;
                margin-right: 20px;
                padding-top: 20px;
            }

            .calendar-content {
                padding-left: 200px;
                padding-top: 100px;
            }
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
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/@phosphor-icons/web@2.1.1/src/regular/style.css"/>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>        
    <link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:ital,wght@0,100..700;1,100..700&display=swap" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
</head>

<body>

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

<section class="calendar-content">
    <div class="container pb-4">
        <h2 class="fw-bold mb-4 text-center">My Course Goals</h2>

        <div id="calendar"></div>
    </div>
</section>

<c:forEach var="goal" items="${userGoals}">
    <div class="modal fade" id="viewGoalModal-${goal.id}" tabindex="-1" aria-labelledby="viewGoalLabel-${goal.id}" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="viewGoalLabel-${goal.id}">${goal.courseName}</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <p class="mb-1"><strong>Start Date:</strong> ${goal.formattedStartDate}</p>
                        <p class="mb-1"><strong>Target Date:</strong> ${goal.formattedTargetDate}</p>
                        <p class="mb-1"><strong>Status:</strong> ${goal.formattedStatus}</p>
                        <p class="mb-1"><strong>Overall Progress:</strong> ${goal.calculatedProgress}%</p>
                        <div class="progress mt-2" style="height: 10px; border-radius: 5px; background-color: #e9ecef;">
                            <div class="progress-bar" role="progressbar" style="width: ${goal.calculatedProgress}%; background-color: ${goal.color};" aria-valuenow="${goal.calculatedProgress}" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </div>
                    <hr>
                    <h6 class="mb-3">Associated Courses</h6>
                    <c:choose>
                        <c:when test="${not empty goal.associatedCourseDetails}">
                            <ul class="list-group">
                                <c:forEach var="cinfo" items="${goal.associatedCourseDetails}">
                                    <li class="list-group-item" style="font-family: 'IBM Plex Sans', sans-serif;">
                                        <div class="d-flex justify-content-between align-items-center mb-1">
                                            <h6 class="mb-0" style="font-size:15px;">${cinfo.courseName}</h6>
                                            <span class="badge bg-secondary rounded-pill">${cinfo.progressPercentage}%</span>
                                        </div>
                                        <div class="progress" style="height: 6px; border-radius: 3px;">
                                            <div class="progress-bar bg-success" role="progressbar" style="width: ${cinfo.progressPercentage}%;" aria-valuenow="${cinfo.progressPercentage}" aria-valuemin="0" aria-valuemax="100"></div>
                                        </div>
                                    </li>
                                </c:forEach>
                            </ul>
                        </c:when>
                        <c:otherwise>
                            <p class="text-muted" style="font-size: 14px;">No associated courses.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning me-auto" data-goal-id="${goal.id}" data-goal-name="${goal.courseName}" data-goal-start="${goal.startDate}" data-goal-target="${goal.targetDate}" data-goal-color="${goal.color}" data-goal-courseid="${goal.courseId}" onclick="openEditGoalModal(this)">Edit Goal</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</c:forEach>

<div class="modal fade" id="addGoalModal" tabindex="-1" aria-labelledby="addGoalModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addGoalModalLabel">Edit Course Goal</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="goalForm">
                    <input type="hidden" id="goalId" name="id">
                    <input type="hidden" id="courseId" name="courseId">
                    <div class="mb-3">
                        <label for="courseName" class="form-label">Goal Name</label>
                        <input type="text" class="form-control" id="courseName" placeholder="E.g. Summer Learning" required>
                    </div>
                    <div class="mb-3">
                        <label for="startDate" class="form-label">Start Date</label>
                        <input type="date" class="form-control" id="startDate" required>
                    </div>
                    <div class="mb-3">
                        <label for="targetDate" class="form-label">Target Completion Date</label>
                        <input type="date" class="form-control" id="targetDate" required>
                    </div>
                    <div class="mb-3">
                        <label for="color" class="form-label">Color</label>
                        <input type="color" class="form-control form-control-color" id="color" value="#007bff">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Associated Courses</label>
                        <ul id="associatedCoursesList" class="list-group mb-2">
                            <li class="list-group-item text-muted">Loading courses...</li>
                        </ul>
                        <div class="input-group">
                            <select id="availableCoursesSelect" class="form-select">
                                <option value="">Loading courses...</option>
                            </select>
                            <button type="button" class="btn btn-outline-success" id="btnAddNewCourse">Add Course</button>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger me-auto" id="btnDeleteGoal" style="display:none;">Delete</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="btnSaveGoal">Save Goal</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.js"></script>
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
        });
        
        const timeZoneInput = document.querySelectorAll('.userTimeZone');   
        timeZoneInput.forEach(input => {
            input.value = Intl.DateTimeFormat().resolvedOptions().timeZone; 
        });

        var calendarEl = document.getElementById('calendar');
        var modal = new bootstrap.Modal(document.getElementById('addGoalModal'));
        var allAvailableCourses = [];

        function updateAvailableCoursesDropdown(courseIdsString) {
            var sel = document.getElementById('availableCoursesSelect');
            sel.innerHTML = '<option value="">-- Select a Course to Add --</option>';

            var associatedIds = [];
            if (courseIdsString && courseIdsString.trim().length > 0) {
                associatedIds = courseIdsString.split(',').map(id => id.trim());
            }

            allAvailableCourses.forEach(c => {
                if (!associatedIds.includes(c.id.toString())) {
                    var opt = document.createElement('option');
                    opt.value = c.id;
                    opt.textContent = c.name;
                    sel.appendChild(opt);
                }
            });
        }

        fetch('/goals/api/all-courses')
            .then(res => res.json())
            .then(data => {
                allAvailableCourses = data;
                var currentCourseId = document.getElementById('courseId').value || '';
                updateAvailableCoursesDropdown(currentCourseId);

                if (document.getElementById('addGoalModal').classList.contains('show') || document.getElementById('addGoalModal').style.display === 'block') {
                    populateModalCourses(document.getElementById('goalId').value, currentCourseId);
                }
            })
            .catch(err => console.error("Error loading available courses", err));

        function populateModalCourses(goalId, courseIdsString) {
            var courseListUl = document.getElementById('associatedCoursesList');
            courseListUl.innerHTML = '';

            updateAvailableCoursesDropdown(courseIdsString);
            
            var associatedIds = [];
            if (courseIdsString && courseIdsString.trim().length > 0) {
                associatedIds = courseIdsString.split(',').map(id => id.trim()).filter(id => id !== '');
            }

            if (associatedIds.length > 0 && allAvailableCourses.length > 0) {
                associatedIds.forEach(id => {
                    var c = allAvailableCourses.find(course => course.id.toString() === id);
                    var cName = c ? c.name : ('Course ID ' + id);
                    
                    var li = document.createElement('li');
                    li.className = 'list-group-item d-flex justify-content-between align-items-center';
                    li.textContent = cName;

                    var rmBtn = document.createElement('button');
                    rmBtn.type = 'button';
                    rmBtn.className = 'btn btn-sm btn-outline-danger';
                    rmBtn.textContent = 'Remove';
                    rmBtn.onclick = function() {
                        var currentIds = document.getElementById('courseId').value.split(',').map(i=>i.trim()).filter(i=>i!=='');
                        var newIds = currentIds.filter(i => i !== id);
                        document.getElementById('courseId').value = newIds.join(',');
                        populateModalCourses(goalId, document.getElementById('courseId').value);
                    };
                    li.appendChild(rmBtn);
                    courseListUl.appendChild(li);
                });
            } else if (associatedIds.length === 0) {
                courseListUl.innerHTML = '<li class="list-group-item text-muted">No associated courses.</li>';
            } else {
                courseListUl.innerHTML = '<li class="list-group-item text-muted">Loading courses...</li>';
            }
        }

        var calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth,timeGridWeek'
            },
            events: '/goals/api/all',
            eventDataTransform: function(eventData) {
                return {
                    id: eventData.id,
                    title: eventData.courseName,
                    start: eventData.startDate,
                    end: eventData.targetDate,
                    color: eventData.color,
                    extendedProps: {
                        courseId: eventData.courseId,
                        status: eventData.status
                    }
                };
            },
            selectable: true,
            dateClick: function(info) {
                document.getElementById('goalForm').reset();
                document.getElementById('goalId').value = '';
                document.getElementById('courseId').value = '';
                document.getElementById('addGoalModalLabel').innerText = 'Create a New Goal';
                document.getElementById('startDate').value = info.dateStr;
                
                var target = new Date(info.date);
                target.setDate(target.getDate() + 7);
                document.getElementById('targetDate').value = target.toISOString().split('T')[0];
                
                document.getElementById('btnDeleteGoal').style.display = 'none';
                populateModalCourses('', '');

                var editModal = bootstrap.Modal.getOrCreateInstance(document.getElementById('addGoalModal'));
                editModal.show();
            },
            eventClick: function(info) {
                var event = info.event;
                var viewModalEl = document.getElementById('viewGoalModal-' + event.id);
                if (viewModalEl) {
                    var viewModal = new bootstrap.Modal(viewModalEl);
                    viewModal.show();
                } else {
                    console.error("View modal not found for goal: " + event.id);
                }
            }
        });

        calendar.render();

        document.getElementById('btnAddNewCourse').addEventListener('click', function() {
            var goalId = document.getElementById('goalId').value;
            var addSel = document.getElementById('availableCoursesSelect');
            var selectedCourseId = addSel.value;

            if(!selectedCourseId) {
                showToast("Please select a course to add.", true);
                return;
            }

            var currentIdsString = document.getElementById('courseId').value;
            var currentIds = currentIdsString ? currentIdsString.split(',').map(i=>i.trim()).filter(i=>i!=='') : [];
            
            if (!currentIds.includes(selectedCourseId)) {
                currentIds.push(selectedCourseId);
                document.getElementById('courseId').value = currentIds.join(',');
                populateModalCourses(goalId, document.getElementById('courseId').value);
                addSel.value = '';
            } else {
                showToast("Course is already added.", true);
            }
        });

        document.getElementById('btnSaveGoal').addEventListener('click', function() {
            var inputName = document.getElementById('courseName').value;
            if (!inputName || inputName.trim() === '') {
                showToast("Goal Name cannot be empty.", true);
                return;
            }

            var goal = {
                id: document.getElementById('goalId').value || null,
                courseId: document.getElementById('courseId').value,
                courseName: inputName,
                startDate: document.getElementById('startDate').value,
                targetDate: document.getElementById('targetDate').value,        
                color: document.getElementById('color').value,
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
                    return response.json();
                } else {
                    throw new Error('Network response was not ok');
                }
            })
            .then(data => {
                var activeModal = bootstrap.Modal.getInstance(document.getElementById('addGoalModal'));
                if (activeModal) activeModal.hide();
                window.location.reload();
            })
            .catch(error => {
                console.error('Error saving goal:', error);
                showToast('Error saving goal. Please try again.', true);
            });
        });

        document.getElementById('btnDeleteGoal').addEventListener('click', function() {
            var goalId = document.getElementById('goalId').value;
            if (goalId && confirm('Are you sure you want to delete this goal?')) {
                var csrfInput = document.querySelector('input[name="_csrf"]');
                var headers = {};
                if (csrfInput) {
                    headers['X-CSRF-TOKEN'] = csrfInput.value;
                }

                fetch('/goals/api/delete/' + goalId, {
                    method: 'DELETE',
                    headers: headers
                })
                .then(() => {
                    var activeModal = bootstrap.Modal.getInstance(document.getElementById('addGoalModal'));
                    if (activeModal) activeModal.hide();
                    window.location.reload();
                })
                .catch(error => {
                    console.error('Error deleting goal:', error);
                    showToast('Error deleting goal. Please try again.', true);
                });
            }
        });

        window.openEditGoalModal = function(btn) {
            var id = btn.getAttribute('data-goal-id');
            var name = btn.getAttribute('data-goal-name');
            var start = btn.getAttribute('data-goal-start');
            var target = btn.getAttribute('data-goal-target');
            var color = btn.getAttribute('data-goal-color');
            var courseId = btn.getAttribute('data-goal-courseid');

            document.getElementById('goalId').value = id;
            document.getElementById('courseName').value = name;
            document.getElementById('startDate').value = start;
            document.getElementById('targetDate').value = target;
            document.getElementById('color').value = color;
            document.getElementById('courseId').value = courseId;
            document.getElementById('addGoalModalLabel').innerText = 'Edit Course Goal';

            document.getElementById('btnDeleteGoal').style.display = 'block';

            populateModalCourses(id, courseId);

            var viewModals = document.querySelectorAll('.modal.show');
            viewModals.forEach(m => {
                var modalInstance = bootstrap.Modal.getInstance(m);
                if (modalInstance) modalInstance.hide();
            });

            var editModal = bootstrap.Modal.getOrCreateInstance(document.getElementById('addGoalModal'));
            editModal.show();
        };

    });
</script>
<script>const currentUserId = '<c:out value="${currentUser.id}"/>';</script>
<script src="${pageContext.request.contextPath}/js/notifications.js?v=1.01"></script>
<script src="${pageContext.request.contextPath}/js/sidebar-toggle.js"></script>
</body>
</html>
