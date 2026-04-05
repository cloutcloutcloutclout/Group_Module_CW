<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Analytics Dashboard</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/@phosphor-icons/web@2.1.1/src/regular/style.css"/>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:ital,wght@0,100..700;1,100..700&display=swap" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        body {
            background-color: #F1F9F8 !important;
            font-family: "IBM Plex Sans", sans-serif;
            margin-bottom: 80px !important;
        }

        nav {
            background-color: #9BAEE9;
        }

        .navbar-brand {
            font-weight: 600;
            color: black;
            font-size: 23px !important;
        }

        .navbar-brand:hover {
            color: white;
        }

        .nav-group {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .fa-bars {
            color: black;
            font-size: 33px;
            margin-left: 15px;
            cursor: pointer;
        }

        .fa-bars:hover {
            color: white;
        }

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
            font-weight: 300;
            font-size: 23px;
        }

        .side-link:hover,
        .side-link.active {
            background-color: rgba(255, 255, 255, 0.10) !important;
            color: white;
            width: 100%;
        }

        .analytics-section {
            padding-top: 100px;
        }

        h1 {
            font-weight: 600 !important;
            font-size: 40px !important;
            margin-bottom: 10px;
        }

        .subtitle {
            font-size: 18px;
            color: #555;
            margin-bottom: 30px;
        }

        .metrics-grid {
            display: grid;
            grid-template-columns: repeat(5, minmax(0, 1fr));
            gap: 18px;
        }

        .analytics-card {
            border-radius: 14px !important;
            border-bottom: #9BAEE9 solid 6px !important;
            min-height: 125px;
        }

        .analytics-card h3 {
            font-size: 17px;
            font-weight: 500;
            margin-bottom: 10px;
        }

        .analytics-card p {
            font-size: 26px;
            font-weight: 700;
            margin: 0;
        }

        .chart-card {
            border-radius: 14px !important;
            border-bottom: #9BAEE9 solid 6px !important;
            margin-top: 25px;
        }

        .chart-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
            margin-bottom: 16px;
            flex-wrap: wrap;
        }

        .chart-title {
            margin: 0;
            font-size: 20px;
            font-weight: 600;
        }

        .range-form {
            display: flex;
            align-items: center;
            gap: 10px;
            margin: 0;
        }

        .range-form label {
            font-size: 15px;
            color: #555;
            margin: 0;
        }

        .range-form select {
            border-radius: 8px;
            border: 1px solid #ced4da;
            padding: 6px 10px;
            background: white;
        }

        .insight-card {
            border-radius: 14px !important;
            border-bottom: #9BAEE9 solid 6px !important;
            margin-top: 25px;
        }

        .insight-list {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 12px;
        }

        .insight-item {
            background: #f8fbff;
            border: 1px solid #e6edf7;
            border-radius: 12px;
            padding: 14px 16px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .insight-label {
            font-size: 15px;
            color: #555;
            font-weight: 500;
        }

        .insight-value {
            font-size: 22px;
            font-weight: 700;
            color: #222;
        }

        .insight-messages {
            margin-top: 20px;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .insight-message {
            background: #f1f9f8;
            border-left: 4px solid #9BAEE9;
            padding: 14px 16px;
            border-radius: 10px;
            font-size: 16px;
            color: #333;
            margin: 0;
        }

        .leaderboard-list {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .leaderboard-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 14px;
            padding: 14px 16px;
            border-radius: 12px;
            background: #f8fbff;
            border: 1px solid #e6edf7;
        }

        .leaderboard-left {
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .leaderboard-rank {
            min-width: 52px;
            height: 52px;
            border-radius: 50%;
            background: #9BAEE9;
            color: black;
            font-weight: 700;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 15px;
            flex-shrink: 0;
        }

        .leaderboard-item.rank-1 .leaderboard-rank {
            background: #FFD700;
        }

        .leaderboard-item.rank-2 .leaderboard-rank {
            background: #C0C0C0;
        }

        .leaderboard-item.rank-3 .leaderboard-rank {
            background: #CD7F32;
            color: white;
        }

        .leaderboard-item.rank-1 {
            background: rgba(255, 215, 0, 0.18);
        }

        .leaderboard-item.rank-2 {
            background: rgba(192, 192, 192, 0.18);
        }

        .leaderboard-item.rank-3 {
            background: rgba(205, 127, 50, 0.16);
        }

        .leaderboard-user {
            display: flex;
            flex-direction: column;
        }

        .leaderboard-name {
            font-size: 17px;
            font-weight: 600;
            color: #222;
        }

        .leaderboard-subtext {
            font-size: 13px;
            color: #666;
        }

        .leaderboard-points {
            font-size: 16px;
            font-weight: 700;
            color: #333;
            white-space: nowrap;
        }

        @media (max-width: 1399px) {
            .metrics-grid {
                grid-template-columns: repeat(4, minmax(0, 1fr));
            }
        }

        @media (max-width: 1199px) {
            .metrics-grid {
                grid-template-columns: repeat(3, minmax(0, 1fr));
            }
        }

        @media (max-width: 767px) {
            .metrics-grid {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }

            h1 {
                font-size: 32px !important;
            }
        }

        @media (max-width: 575px) {
            .metrics-grid {
                grid-template-columns: 1fr;
            }

            .leaderboard-item {
                flex-direction: column;
                align-items: flex-start;
            }

            .leaderboard-points {
                margin-left: 66px;
            }
        }

        @media (min-width: 900px) {
            .navbar {
                position: fixed !important;
                width: 100%;
                z-index: 1050;
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

            section {
                padding-left: 220px;
                padding-top: 90px;
            }
        }
    </style>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
</head>

<body>
<nav class="navbar d-flex justify-content-between align-items-center px-3">

    <div class="nav-group">
        <a class="fa-solid fa-bars"></a>
        <a class="navbar-brand" href="${pageContext.request.contextPath}/dashboard">SkillsBuilder</a>
    </div>

    <!-- PROFILE BUTTON (RIGHT SIDE) -->
    <div>
        <a href="${pageContext.request.contextPath}/profile" class="btn btn-light">
            <i class="fa fa-user"></i> Profile
        </a>
    </div>

</nav>

<aside class="side-nav bg-dark">
    <a href="${pageContext.request.contextPath}/dashboard" class="side-link"><i class="ph ph-house"></i> Home</a>
    <a href="${pageContext.request.contextPath}/leaderboard" class="side-link"><i class="ph ph-chart-bar"></i> Leaderboard</a>
    <a href="${pageContext.request.contextPath}/feedback" class="side-link"><i class="ph ph-newspaper"></i> Feedback</a>
    <a href="${pageContext.request.contextPath}/admin/analytics" class="side-link active"><i class="ph ph-chart-line"></i> Analytics</a>
</aside>

<section class="analytics-section">
    <div class="container-fluid px-4">
        <h1>Admin Analytics Dashboard</h1>
        <p class="subtitle">Overview of student progress and platform activity</p>

        <div class="metrics-grid">
            <div class="card shadow-sm analytics-card">
                <div class="card-body">
                    <h3>Total Users</h3>
                    <p>${totalUsers}</p>
                </div>
            </div>

            <div class="card shadow-sm analytics-card">
                <div class="card-body">
                    <h3>Total Courses</h3>
                    <p>${totalCourses}</p>
                </div>
            </div>

            <div class="card shadow-sm analytics-card">
                <div class="card-body">
                    <h3>User Courses</h3>
                    <p>${totalUserCourses}</p>
                </div>
            </div>

            <div class="card shadow-sm analytics-card">
                <div class="card-body">
                    <h3>Total Sessions</h3>
                    <p>${totalSessions}</p>
                </div>
            </div>

            <div class="card shadow-sm analytics-card">
                <div class="card-body">
                    <h3>Total Feedback</h3>
                    <p>${totalFeedback}</p>
                </div>
            </div>
        </div>

        <div class="card shadow-sm chart-card">
            <div class="card-body">
                <div class="chart-header">
                    <h3 class="chart-title">Platform Metrics Overview</h3>

                    <form method="get" action="${pageContext.request.contextPath}/admin/analytics" class="range-form">
                        <label for="range">View range:</label>
                        <select name="range" id="range" onchange="this.form.submit()">
                            <option value="7" ${range == '7' ? 'selected' : ''}>Last 7 days</option>
                            <option value="30" ${range == '30' ? 'selected' : ''}>Last 30 days</option>
                            <option value="all" ${range == 'all' ? 'selected' : ''}>All time</option>
                        </select>
                    </form>
                </div>

                <canvas id="analyticsChart"></canvas>
            </div>
        </div>

        <div class="card shadow-sm insight-card">
            <div class="card-body">
                <h3 class="mb-4">Insights</h3>

                <div class="insight-list">
                    <div class="insight-item">
                        <span class="insight-label">Users</span>
                        <span class="insight-value">${totalUsers}</span>
                    </div>

                    <div class="insight-item">
                        <span class="insight-label">Courses</span>
                        <span class="insight-value">${totalCourses}</span>
                    </div>

                    <div class="insight-item">
                        <span class="insight-label">User Courses</span>
                        <span class="insight-value">${totalUserCourses}</span>
                    </div>

                    <div class="insight-item">
                        <span class="insight-label">Feedback</span>
                        <span class="insight-value">${totalFeedback}</span>
                    </div>

                    <div class="insight-item">
                        <span class="insight-label">Sessions</span>
                        <span class="insight-value">${totalSessions}</span>
                    </div>

                    <div class="insight-item">
                        <span class="insight-label">Enrollment Rate</span>
                        <span class="insight-value">
                            ${totalCourses == 0 ? 0 : (totalUserCourses * 100 / totalCourses)}%
                        </span>
                    </div>
                </div>

                <div class="insight-messages">
                    <c:if test="${totalFeedback > totalUsers}">
                        <p class="insight-message">High engagement: users are actively submitting feedback.</p>
                    </c:if>

                    <c:choose>
                        <c:when test="${totalUserCourses == 0}">
                            <p class="insight-message">No students are currently enrolled in any courses.</p>
                        </c:when>
                        <c:when test="${totalUserCourses < totalUsers}">
                            <p class="insight-message">Some users are enrolled in courses, but engagement can be improved.</p>
                        </c:when>
                        <c:otherwise>
                            <p class="insight-message">All users are actively enrolled in courses. High engagement.</p>
                        </c:otherwise>
                    </c:choose>

                    <c:if test="${totalSessions == 0}">
                        <p class="insight-message">No active sessions have been recorded yet.</p>
                    </c:if>
                </div>
            </div>
        </div>

        <div class="card shadow-sm insight-card">
            <div class="card-body">
                <h3 class="mb-4"><i class="fa-solid fa-trophy me-2"></i>Top Students</h3>

                <c:choose>
                    <c:when test="${not empty topUsers}">
                        <div class="leaderboard-list">
                            <c:forEach var="student" items="${topUsers}" varStatus="status">
                                <div class="leaderboard-item ${status.index == 0 ? 'rank-1' : ''} ${status.index == 1 ? 'rank-2' : ''} ${status.index == 2 ? 'rank-3' : ''}">
                                    <div class="leaderboard-left">
                                        <div class="leaderboard-rank">
                                            <c:choose>
                                                <c:when test="${status.index == 0}">#1</c:when>
                                                <c:when test="${status.index == 1}">#2</c:when>
                                                <c:when test="${status.index == 2}">#3</c:when>
                                                <c:otherwise>#${status.index + 1}</c:otherwise>
                                            </c:choose>
                                        </div>

                                        <div class="leaderboard-user">
                                            <div class="leaderboard-name">

                                                        ${student.username}

                                            </div>
                                            <div class="leaderboard-subtext">
                                                <c:choose>
                                                    <c:when test="${not empty student.displayName}">
                                                        @${student.username}
                                                    </c:when>
                                                    <c:otherwise>
                                                        Top learner
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="leaderboard-points">${student.points} pts</div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <p class="mb-0">No ranking data available yet.</p>
                    </c:otherwise>
                </c:choose>
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
    });

    const totalUsers = ${totalUsers};
    const totalCourses = ${totalCourses};
    const totalSessions = ${totalSessions};
    const totalFeedback = ${totalFeedback};
    const totalUserCourses = ${totalUserCourses};

    const ctx = document.getElementById('analyticsChart').getContext('2d');

    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ['Users', 'Courses', 'User Courses', 'Sessions', 'Feedback'],
            datasets: [{
                label: 'Platform Metrics',
                data: [totalUsers, totalCourses, totalUserCourses, totalSessions, totalFeedback],
                backgroundColor: [
                    'rgba(54, 162, 235, 0.75)',
                    'rgba(75, 192, 192, 0.75)',
                    'rgba(255, 206, 86, 0.75)',
                    'rgba(153, 102, 255, 0.75)',
                    'rgba(255, 99, 132, 0.75)'
                ],
                borderRadius: 8,
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    display: false
                }
            },
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
</script>
</body>
</html>