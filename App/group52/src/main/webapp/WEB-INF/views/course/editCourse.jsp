<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Course</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">

    <h2 class="mb-4">Edit Course</h2>

    <form action="${pageContext.request.contextPath}/admin/courses/update" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

        <input type="hidden" name="id" value="${course.id}"/>
        <!--course name-->
        <div class="mb-3">
            <label class="form-label">Course Name</label>
            <input type="text" class="form-control" name="name" value="${course.name}" required>
        </div>
        <!--Description-->
        <div class="mb-3">
            <label class="form-label">Description</label>
            <textarea class="form-control" name="description" rows="4" required></textarea>
        </div>

        <!--Category-->
        <div class="mb-3">
            <label class="form-label">Category</label>
            <input type="text" class="form-control" name="category" value="${course.category}" required>
        </div>

        <!-- url-->
        <div class="mb-3">
            <label class="form-label">URL</label>
            <input type="text" class="form-control" name="url" value="${course.url}" required>
        </div>

        <!--Duration-->
        <div class="mb-3">
            <label class="form-label">Duration</label>
            <input type="text" class="form-control" name="duration" value="${course.durationMinutes}" required>
        </div>

        <!-- Eligibility-->
        <div class="mb-3">
            <label class="form-label">Eligibility</label>
            <input type="text" class="form-control" name="eligibility" value="${course.eligibility}" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Image</label>
            <input type="text" class="form-control" name="image" value="${course.image}" required>
        </div>

        <!--Buttons -->
        <button type="submit" class="btn btn-success">Save Changes</button>

        <a href="${pageContext.request.contextPath}/admin/courses" class="btn btn-secondary">Cancel</a>
    </form>



</div>
</body>
</html>