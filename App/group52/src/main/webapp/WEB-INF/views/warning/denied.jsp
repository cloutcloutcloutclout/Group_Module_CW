<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Access Denied</title>
    </head>
<body>
<h1>Access Denied (403)</h1>
<p>You do not have permission to view this page.</p>

<p>
    <a href="${pageContext.request.contextPath}/welcome">Go to Welcome</a>
    |
    <a href="${pageContext.request.contextPath}/login">Login</a>
</p>
</body>
</html>
