<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Streak</title>
</head>
<body>

<h2>Streak Dashboard</h2>

<c:if test="${not empty message}">
    <p><strong>Nice!</strong> ${message}</p>
</c:if>

<div>
    <p>Current Streak: ${user.currentStreak} days</p>
    <p>Total Points: ${user.points}</p>
</div>

<form action="/streak/increment" method="post">
    <input type="hidden" name="userId" value="${user.userId}">
    <input type="hidden" name="timeZone" value="UTC">

    <button type="submit">
        Log Daily Activity
    </button>
</form>

</body>
</html>