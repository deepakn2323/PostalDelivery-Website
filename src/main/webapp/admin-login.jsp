<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Admin Login</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            text-align: center;
            background-color: #121212; /* Dark background */
            color: white; /* White text */
            padding: 50px;
        }

        h2 {
            color: #ff4757; /* Bright red */
            margin-bottom: 20px;
        }

        form {
            max-width: 400px;
            margin: auto;
            padding: 20px;
            border: 1px solid #444; /* Dark border */
            border-radius: 10px;
            background: #222; /* Dark background for the form */
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.5);
        }

        label {
            display: block; /* Make labels block elements */
            margin-bottom: 8px;
            text-align: left; /* Left align labels */
            color: #ffffff; /* White text for labels */
        }

        input[type="text"], input[type="password"] {
            width: calc(100% - 22px);
            padding: 10px;
            margin: 5px 0 15px 0; /* Bottom margin for spacing */
            border: 1px solid #555; /* Darker border for inputs */
            border-radius: 5px;
            background-color: #333; /* Darker input background */
            color: white; /* White text in inputs */
            transition: border-color 0.3s;
        }

        input[type="text"]:focus, input[type="password"]:focus {
            border-color: #ff4757; /* Bright red border on focus */
            outline: none; /* Remove default outline */
        }

        input[type="submit"] {
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            background-color: #ff4757; /* Bright red button */
            color: white;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #d10000; /* Darker red on hover */
        }

        .error {
            color: #dc3545; /* Red for error messages */
            margin-top: 15px;
        }
    </style>
</head>
<body>
<h2>Admin Login</h2>
<form action="admin" method="post">
    <input type="hidden" name="action" value="login" />
    <label>Username:</label>
    <input type="text" name="name" required />
    <label>Password:</label>
    <input type="password" name="password" required />
    <input type="submit" value="Login" />
</form>

<c:if test="${not empty param.error}">
    <div class="error">${param.error}</div>
</c:if>
</body>
</html>
