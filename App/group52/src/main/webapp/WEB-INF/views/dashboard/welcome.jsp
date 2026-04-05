<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Welcome to SkillsBuilder Academic</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .welcome-container {
            background: #fff;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            max-width: 600px;
            width: 90%;
        }
        .welcome-container img {
            max-width: 100px;
            margin-bottom: 1rem;
        }
        h1 {
            font-size: 2rem;
            color: #333;
            margin-bottom: 1rem;
        }
        p {
            color: #555;
            margin-bottom: 2rem;
        }
        a, button.linkish {
            display: inline-block;
            padding: 0.8rem 1.2rem;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            font-size: 1rem;
            transition: background-color 0.3s ease;
            border: none;
            cursor: pointer;
        }
        a:hover, button.linkish:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<div class="welcome-container">
    <img src="https://upload.wikimedia.org/wikipedia/commons/5/51/IBM_logo.svg"
         alt="IBM Logo" style="width: 120px; margin-bottom: 1rem;">
    <h1>Welcome to  SkillsBuilder</h1>

    <p>Explore our range of courses to boost your knowledge</p>

    <div class="cta-buttons">
        <a href="/search" class="btn btn-primary">Browse Courses</a>
    </div>

    <!-- If your logout endpoint is POST (Spring Security default), use a form -->
    <form action="${pageContext.request.contextPath}/logout" method="post" style="margin:0;">
        <c:if test="${not empty _csrf}">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        </c:if>
        <button type="submit" class="linkish">Logout</button>
    </form>
</div>
</body>
</html>
