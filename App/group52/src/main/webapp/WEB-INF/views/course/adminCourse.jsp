<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Create Course</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">

    <h2 class="mb-4">Create Course</h2>

    <%--@elvariable id="course" type="java"--%>
    <form:form action="${pageContext.request.contextPath}/admin/courses/new" method="post"
    modelAttribute="course">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>


        <!--course name-->
        <div class="mb-3">
            <label>Course Name</label>
            <form:input path="name" class="form-control"/>
        </div>
        <!--Description-->
        <div class="mb-3">
            <label>Description</label>
            <form:textarea path="description" class="form-control" rows="4"/>
        </div>

        <!--Category-->
        <div class="mb-3">
            <label>Category</label>
            <form:input path="category" class="form-control"/>
        </div>

        <!-- url-->
        <div class="mb-3">
            <label>URL</label>
            <form:input path="url" class="form-control" />
        </div>

        <!--Duration-->
        <div class="mb-3">
            <label>Duration</label>
            <form:input path="durationMinutes" class="form-control" />
        </div>

        <!-- Eligibility-->
        <div class="mb-3">
            <label>Eligibility</label>
            <form:input path="eligibility" class="form-control" />
        </div>

        <div class="mb-3">
            <label>Image</label>
            <form:input path="image" class="form-control" />
        </div>

        <!--Buttons -->
        <button type="submit" class="btn btn-success">Create Course</button>

        <a href="${pageContext.request.contextPath}/admin/courses" class="btn btn-secondary">Cancel</a>
    </form:form>



</div>
</body>
</html>