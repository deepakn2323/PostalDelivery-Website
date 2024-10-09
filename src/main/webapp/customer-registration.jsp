<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Customer Registration</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; /* Updated font */
            background-color: #121212; /* Dark background */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: white; /* White text */
            margin: 0; /* Remove default margin */
        }

        .container {
            max-width: 400px;
            width: 100%;
            background: #222; /* Dark background for container */
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.5);
        }

        h2 {
            text-align: center;
            color: #ff4757; /* Bright red for the heading */
            margin-bottom: 20px;
        }

        label {
            display: block; /* Block display for labels */
            margin: 10px 0 5px;
            color: #ffffff; /* White text for labels */
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 5px 0 20px;
            border: 1px solid #555; /* Darker border for inputs */
            border-radius: 5px;
            background-color: #333; /* Darker input background */
            color: white; /* White text in inputs */
            transition: border-color 0.3s;
        }

        input[type="text"]:focus,
        input[type="password"]:focus {
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

        .success {
            color: #28a745; /* Green for success messages */
            text-align: center;
            margin-top: 10px;
        }

        .error {
            color: #dc3545; /* Red for error messages */
            text-align: center;
            margin-top: 10px;
        }

        .login-link {
            text-align: center;
            margin-top: 20px;
        }

        .login-link a {
            color: #ff4757; /* Bright red for the link */
            text-decoration: none;
        }

        .login-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Customer Registration</h2>

    <c:if test="${not empty param.success}">
        <div class="success">${param.success}</div>
    </c:if>
    <c:if test="${not empty param.error}">
        <div class="error">${param.error}</div>
    </c:if>
    <c:if test="${not empty param.msg}">
        <div class="error">${param.msg}</div>
    </c:if>

    <form action="customer" method="post">
        <input type="hidden" name="action" value="register" />

        <label for="name">Name:</label>
        <input type="text" name="name" required />

        <label for="aadhar">Aadhar Number:</label>
		<input type="text" name="aadharnumber" pattern="\d{12}" title="Aadhar number must be 12 digits long" required />

        <label for="address">Address:</label>
        <input type="text" name="address" required />

        <label for="city">City:</label>
        <input type="text" name="city" required />

        <label for="password">Password:</label>
        <input type="password" name="password" required />

        <input type="submit" value="Register" />
    </form>

    <div class="login-link">
        <h3>Already have an account? <a href="customer-login.jsp">Login here.</a></h3>
    </div>
</div>

</body>
</html>
