<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>IBM Academic Login</title>

    <!-- IBM Plex Sans font -->
    <link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:wght@400;500;700&display=swap" rel="stylesheet">

    <style>
        /* BODY & BACKGROUND */
        body {
            font-family: 'IBM Plex Sans', sans-serif;
            background: linear-gradient(to right, #f0f4f8, #dbe9f4);
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        /* FORM CONTAINER */
        .form-container {
            background: #fff;
            padding: 2.5rem;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
            max-width: 400px;
            width: 100%;
            text-align: center;
        }

        /* LOGO */
        .form-container img {
            width: 120px;
            margin-bottom: 1rem;
        }

        h1 {
            margin-bottom: 1.5rem;
            font-weight: 500;
            color: #1f1f1f;
        }

        /* INPUTS */
        input[type="text"],
        input[type="password"] {
            width: calc(100% - 2rem);
            padding: 0.8rem;
            margin-bottom: 1rem;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 1rem;
            outline: none;
        }

        input:focus {
            border-color: #0072c6; /* IBM blue */
            box-shadow: 0 0 4px rgba(0, 114, 198, 0.4);
        }

        /* BUTTONS */
        button {
            background-color: #0072c6;
            color: white;
            border: none;
            padding: 0.8rem 1.2rem;
            border-radius: 8px;
            font-size: 1rem;
            cursor: pointer;
            width: 100%;
            transition: background 0.2s ease;
        }

        button:hover {
            background-color: #005fa3;
        }

        a.link-btn {
            display: inline-block;
            width: 100%;
            margin-top: 0.8rem;
            background-color: #6c757d;
            color: white;
            text-decoration: none;
            padding: 0.8rem 1.2rem;
            border-radius: 8px;
            font-size: 1rem;
            box-sizing: border-box;
            transition: background 0.2s ease;
        }

        a.link-btn:hover {
            background-color: #5a6268;
        }
        .link-btn.forgot {
            backgroung: none;
            color: #005fa3;
            padding: 0;
            margin-top: 10px;
        }
        .oauth-container {
            margin-top: 15px;
            display: flex;
            justify-content: center;
            gap: 20px;
        }

        .oauth-btn {
            display: flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            font-size: 0.95rem;
            color: #0f62fe;
            font-weight: 500;
        }

        .oauth-btn img {
            width: 18px;
            height: 18px;
        }



        /* MESSAGES */
        .success-message {
            background-color: #e6fffa;
            color: #065f46;
            border: 1px solid #34d399;
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 6px;
            text-align: center;
            font-weight: bold;
        }

        .msg {
            margin-bottom: 1rem;
            padding: 0.8rem;
            border-radius: 8px;
            font-size: 0.95rem;
        }

        .error {
            background: #ffe6e6;
            border: 1px solid #ffb3b3;
            color: #8a1f1f;
        }

        .ok {
            background: #e8ffe8;
            border: 1px solid #b8ffb8;
            color: #1f6b1f;
        }
    </style>
</head>
<body>
<div class="form-container">
    <!-- IBM Logo - External Test -->
    <img src="https://upload.wikimedia.org/wikipedia/commons/5/51/IBM_logo.svg"
         alt="IBM Logo" style="width: 120px; margin-bottom: 1rem;">

    <h1>Sign in to SkillsBuilder</h1>

    <!--Success /Register messages -->
    <c:if test="${not empty successMessage}">
        <div class="success-message"> ${successMessage}</div>
    </c:if>

    <!-- Error / Logout messages -->
    <c:if test="${param.error != null}">
        <div class="msg error">Invalid username or password.</div>
    </c:if>
    <c:if test="${param.logout != null}">
        <div class="msg ok">You have been successfully logged out.</div>
    </c:if>
    <c:if test="${param.resetSuccess != null}">
        <p style="color: green;">Password reset successfully. Please log in.</p>
    </c:if>


    <!-- LOGIN FORM -->
    <form action="${pageContext.request.contextPath}/login" method="post">
        <c:if test="${not empty _csrf}">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        </c:if>

        <input type="text" name="username" placeholder="Username" required />
        <input type="password" name="password" placeholder="Password" required />
        <button type="submit">Login</button>
    </form>

    <!-- FORGOT PASSWORD -->
    <a href="${pageContext.request.contextPath}/forgot-password">
        Forgot your password?
    </a>

    <h3>Or login with:</h3>
    <div class="oauth-container">
        <!--Google -->
        <a  class="oauth-btn"
            href="${pageContext.request.contextPath}/oauth2/authorization/google" class="oauth-btn google">
            <img src="https://www.google.com/favicon.ico" style="width: 16px; margin-right: 8px;
        vertical-align:middle;" alt="Google"/>
            Login with Google
        </a>

        <!-- github -->
        <a class="oauth-btn"
                href="${pageContext.request.contextPath}/oauth2/authorization/github" class="oauth-btn github">
            <img src="https://github.githubassets.com/favicons/favicon-dark.png" style="width: 16px; margin-right: 8px;
            vertical-align: middle;" alt="Github logo"/> Login with Github
        </a>
    </div>


    <!-- REGISTER BUTTON -->
    <div class="register-link">
        Don't have an account? <a href="${pageContext.request.contextPath}/register">Register here</a>
    </div>

</div>
</body>
</html>
