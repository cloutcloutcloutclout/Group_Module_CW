<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
    <title>User Details</title>

    <!-- Bootstrap -->
    <link href="../bootstrap-3.3.7/css/bootstrap.css" rel="stylesheet"/>

    <style>
        body {
            background-color: #F1F9F8;
            font-family: "IBM Plex Sans", sans-serif;
            padding: 30px;
        }

        h2, h4 {
            font-weight: 600;
        }

        .card {
            border-radius: 10px;
            box-shadow: 2px 2px 6px rgba(0, 0, 0, 0.2);
            margin-bottom: 20px;
        }

        .course-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="container">
    <h2 class="mb-4">User Details</h2>

    <!--show user's information -->
    <div class="container mt-5">


        <form action="${pageContext.request.contextPath}/admin/users/update" method="post">
            <!-- CSRF Token -->
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <input type="hidden" name="id" value="${user.id}"/>

            <!-- Username -->
            <div class="mb-3">
                <label class="form-label">Username</label>
                <input type="text" class="form-control" name="username" value="${user.username}" required>
            </div>
    <div class="card p-4">
        <h4>Account Information</h4>
        <hr>

            <!-- Email -->
            <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="email" class="form-control" name="email" value="${user.email}" required>
            </div>

            <!-- Points (read-only) -->
            <div class="mb-3">
                <label class="form-label">Points</label>
                <input type="number" class="form-control" name="points" value="${user.points}" readonly>
            </div>

            <!-- Registered Courses -->
            <div class="mb-3">
                <label class="form-label">Registered Courses</label>
                <ul class="list-group">
                    <c:if test="${not empty registeredCourses}">
                        <ul>
                            <c:forEach var="course" items="${registeredCourses}">
                                <li>
                                    <strong>${course.courseName}</strong> -
                                    Category: ${course.courseCategory} -
                                    Completed: <c:choose>
                                    <c:when test="${course.completed}">Yes</c:when>
                                    <c:otherwise>No</c:otherwise>
                                </c:choose>
                                </li>
                            </c:forEach>
                        </ul>
                    </c:if>
                    <c:if test="${empty registeredCourses}">
                        <p>No courses registered yet.</p>
                    </c:if>
                </ul>
            </div>

            <!-- Buttons -->
            <button type="submit" class="btn btn-success">Save Changes</button>
            <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary">Back</a>
        </form>
    </div>
</div>
</body>

</html>