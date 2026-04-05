<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Reset Page</title>
</head>
<body>
<h1>Reset Password</h1>

<c:if test="${param.error == 'mismatch'}">
    <div class="msg error">Passwords do not match</div>
</c:if>
<c:if test="${param.error == 'not found'}">
    <div class="msg error">User not found</div>
</c:if>


<!--RESET PASSWORD FORM -->
<form action="${pageContext.request.contextPath}/forgot-password" method="post">
    <h2>Reset Password</h2>

    <input type="text" name="username" placeholder="Username" required />
    <input type="password" name="newPassword" placeholder="New Password" required />
    <input type="password" name="confirmPassword" placeholder="Confirm Password" required />

    <button type="submit">Reset Password</button>
</form>

<a href="${pageContext.request.contextPath}/login">Back to Login</a>


</body>
</html>
