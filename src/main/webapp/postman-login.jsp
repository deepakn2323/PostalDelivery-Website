<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Postman Login</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; /* Updated font */
            background-color: #121212; /* Dark background */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: white; /* White text */
        }

        .container {
            background-color: #222; /* Dark background for the container */
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.5);
            width: 400px;
        }

        h2 {
            text-align: center;
            color: #ff4757; /* Bright red */
            margin-bottom: 20px;
        }

        label {
            display: block; /* Block display for labels */
            margin-bottom: 5px;
            color: #ffffff; /* White text for labels */
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border-radius: 5px;
            border: 1px solid #555; /* Darker border for inputs */
            background-color: #333; /* Darker input background */
            color: white; /* White text in inputs */
            transition: border-color 0.3s;
        }

        input[type="text"]:focus, input[type="password"]:focus {
            border-color: #ff4757; /* Bright red border on focus */
            outline: none; /* Remove default outline */
        }

        input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #ff4757; /* Bright red button */
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #d10000; /* Darker red on hover */
        }

        .error {
            color: #dc3545; /* Red for error messages */
            text-align: center;
            margin-top: 10px;
        }

        .success {
            color: #28a745; /* Green for success messages */
            text-align: center;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <% response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); %>

    <div class="container">
        <h2>Postman Login</h2>

        <!-- Display error or success messages -->
        <c:if test="${not empty param.error}">
            <div class="error">${param.error}</div>
        </c:if>
        <c:if test="${not empty param.success}">
            <div class="success">${param.success}</div>
        </c:if>

        <!-- Login Form -->
        <form action="postman" method="post">
            <input type="hidden" name="action" value="login">

            <label for="name">Postman Name:</label>
            <input type="text" name="name" required>

            <label for="password">Password:</label>
            <input type="password" name="password" required>

            <input type="submit" value="Login">
        </form>
    </div>
</body>
</html>
