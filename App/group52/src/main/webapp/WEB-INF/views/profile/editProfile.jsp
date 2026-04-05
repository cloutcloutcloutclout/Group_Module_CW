<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
    <title>Edit Profile</title>
    <style>
        body {
            background-color: #F1F9F8;
            margin-bottom: 80px;
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

        /* Form */
        .edit-section {
            padding-top: 40px;
            padding-bottom: 60px;
        }

        .edit-section h2 {
            font-family: "IBM Plex Sans", sans-serif;
            font-weight: 500;
            font-size: 30px;
            margin-left: 20px;
            margin-bottom: 30px;
        }

        .edit-section label {
            font-family: "IBM Plex Sans", sans-serif;
            font-weight: 500;
        }

        .avatar-grid img {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            vertical-align: middle;
            cursor: pointer;
        }

        .avatar-grid input { display: none; }

        .avatar-grid input:checked + img { outline: 2px solid lightblue; }

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

            .edit-section { padding-top: 100px; }
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


<section class="edit-section">
    <div class="container">
        <h2>Edit Profile</h2>

        <form:form action="${pageContext.request.contextPath}/editProfile/${userId}"
                   modelAttribute="userProfile"
                   method="post">

            <label>Profile Privacy:</label>
            <form:select path="profilePrivacy" id="profilePrivacy">
                <form:option value="public" label="Public"/>
                <form:option value="friends" label="Friends Only"/>
                <form:option value="private" label="Private"/>
            </form:select>
            <form:errors path="profilePrivacy" cssClass="error"/>
            <br/><br/>


            <label>Avatar:</label>
            <br/><br/>
            <div class="avatar-grid">
                <label>
                    <form:radiobutton path="avatar"
                                      value="https://static.vecteezy.com/system/resources/previews/024/766/958/non_2x/default-male-avatar-profile-icon-social-media-user-free-vector.jpg"/>
                    <img src="https://static.vecteezy.com/system/resources/previews/024/766/958/non_2x/default-male-avatar-profile-icon-social-media-user-free-vector.jpg"/>
                </label>
                <label>
                    <form:radiobutton path="avatar"
                                      value="https://static.vecteezy.com/system/resources/previews/024/766/960/non_2x/default-female-avatar-profile-icon-social-media-user-free-vector.jpg"/>
                    <img src="https://static.vecteezy.com/system/resources/previews/024/766/960/non_2x/default-female-avatar-profile-icon-social-media-user-free-vector.jpg"/>
                </label>
                <label>
                    <form:radiobutton path="avatar"
                                      value="https://static.vecteezy.com/system/resources/previews/046/409/821/non_2x/avatar-profile-icon-in-flat-style-male-user-profile-illustration-on-isolated-background-man-profile-sign-business-concept-vector.jpg"/>
                    <img src="https://static.vecteezy.com/system/resources/previews/046/409/821/non_2x/avatar-profile-icon-in-flat-style-male-user-profile-illustration-on-isolated-background-man-profile-sign-business-concept-vector.jpg"/>
                </label>
                <label>
                    <form:radiobutton path="avatar"
                                      value="https://img.freepik.com/premium-vector/woman-avatar-profile-icon-vector-illustration_874723-207.jpg?w=360"/>
                    <img src="https://img.freepik.com/premium-vector/woman-avatar-profile-icon-vector-illustration_874723-207.jpg?w=360"/>
                </label>
            </div>
            <br/><br/>

            <label>Profile Banners:</label>
            <form:select path="background" id="background">
                <form:option value="https://static.vecteezy.com/system/resources/previews/010/481/742/non_2x/light-and-dark-background-random-minimalist-abstract-illustration-for-logo-card-banner-web-and-printing-free-vector.jpg" label="Default"/>
                <form:option value="https://4kwallpapers.com/images/walls/thumbs_3t/8846.jpg" label="Blue"/>
                <form:option value="https://images8.alphacoders.com/131/thumb-1920-1318499.jpeg" label="Black"/>
                <form:option value="https://images.freecreatives.com/wp-content/uploads/2016/03/White-Abstract-Wallpaper-1.jpg" label="White"/>
            </form:select>
            <form:errors path="background" cssClass="error"/>
            <br/><br/>

            <label>First Name:</label>
            <form:input path="firstName"/>
            <form:errors path="firstName" cssClass="error"/><br/><br/>

            <label>Last Name:</label>
            <form:input path="lastName"/>
            <form:errors path="lastName" cssClass="error"/><br/><br/>

            <label>Pronoun:</label>
            <form:input path="pronoun"/>
            <form:errors path="pronoun" cssClass="error"/><br/><br/>

            <label>Pronunciation:</label>
            <form:input path="pronunciation"/>
            <form:errors path="pronunciation" cssClass="error"/><br/><br/>

            <label>Bio:</label>
            <form:textarea path="bio"/>
            <form:errors path="bio" cssClass="error"/><br/><br/>

            <label>Status:</label>
            <form:input path="status"/>
            <form:errors path="status" cssClass="error"/><br/><br/>

            <label>Location:</label>
            <form:input path="location"/>
            <form:errors path="location" cssClass="error"/><br/><br/>

            <h3>Social Profiles</h3>

            <label>LinkedIn URL:</label>
            <form:input path="linkedIn"/>
            <form:errors path="linkedIn" cssClass="error"/><br/><br/>

            <label>GitHub URL:</label>
            <form:input path="github"/>
            <form:errors path="github" cssClass="error"/><br/><br/>

            <label>IBM URL:</label>
            <form:input path="ibm"/>
            <form:errors path="ibm" cssClass="error"/><br/><br/>

            <label>Website:</label>
            <form:input path="website"/>
            <form:errors path="website" cssClass="error"/><br/><br/>

            <label>Contact Email:</label>
            <form:input path="contactEmail"/>
            <form:errors path="contactEmail" cssClass="error"/><br/><br/>

            <button type="submit" class="btn btn-primary">Save Changes</button>
        </form:form>
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
<script>const currentUserId = '<c:out value="${currentUser.id}"/>';</script>

<script src="${pageContext.request.contextPath}/js/notifications.js?v=1.01"></script>
<script src="${pageContext.request.contextPath}/js/sidebar-toggle.js"></script>
</body>
</html>
