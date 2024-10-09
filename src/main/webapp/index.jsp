<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Welcome to the Postcard Delivery System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: black; /* Black background for body */
            margin: 0;
            padding: 0;
            color: white; /* Set default text color to white */
        }

        /* Navbar styling */
        .navbar {
            background-color: #b30000; /* Red background for navbar */
            overflow: hidden;
            padding: 10px 0;
        }

        .navbar-left {
            float: left;
            color: white;
            font-size: 24px;
            margin-left: 20px;
        }

        .navbar-right {
            float: right;
            margin-right: 20px;
        }

        .navbar-right .button {
            padding: 10px 20px;
            margin: 0 5px;
            font-size: 16px;
            background-color: #333; /* Darker color for buttons */
            border: none;
            border-radius: 5px;
            color: white;
            text-decoration: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .navbar-right .button:hover {
            background-color: #b30000; /* Red on hover */
        }

        /* Clearfix to ensure the navbar content stays in place */
        .navbar::after {
            content: "";
            clear: both;
            display: table;
        }

        /* Background image */
        .main-content {
            background-image: url('background.jpg'); /* Add your background image URL here */
            background-size: cover;
            background-position: center;
            height: 100vh; /* Full height for the content */
            padding: 50px;
        }

        /* Heading and content styling */
        .heading {
            text-align: center;
            color: #b30000; /* Red heading text */
            font-size: 36px;
            margin-bottom: 50px;
        }

        /* Flexbox for feature sections */
        .features {
            display: flex;
            justify-content: space-around;
            align-items: center;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            flex-wrap: wrap;
        }

        /* Individual feature boxes */
        .feature-box {
            background: #333; /* Dark background for feature boxes */
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
            text-align: center;
            width: 250px;
            margin: 10px;
            color: white;
        }

        .feature-box img {
            width: 80px;
            margin-bottom: 20px;
        }

        .feature-box h2 {
            font-size: 24px;
            color: #b30000; /* Red feature headings */
            margin-bottom: 15px;
        }

        .feature-box p {
            font-size: 16px;
            color: #ccc; /* Lighter text for feature descriptions */
        }

        /* Responsive design */
        @media (max-width: 768px) {
            .features {
                flex-direction: column;
                align-items: stretch;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <div class="navbar">
        <div class="navbar-left">Postcard Delivery</div>
        <div class="navbar-right">
            <a class="button" href="postman-login.jsp">Postman Login</a>
            <a class="button" href="customer-login.jsp">Customer Login</a>
        </div>
    </div>

    <!-- Main content with background image -->
    <div class="main-content">
        <!-- Welcome Heading -->
        <div class="heading">
            Welcome to Our Postal Delivery System
        </div>

        <!-- Features Section -->
        <div class="features">
            <!-- Secure Feature -->
            <div class="feature-box">
                <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2vGv9eAAemT90lFszPHidcFhXiFmup6t2_A&s" alt="Secure"> <!-- Replace with actual image -->
                <h2>Secure</h2>
                <p>Your postcards are handled with utmost security at every step of the process.</p>
            </div>

            <!-- Reliable Feature -->
            <div class="feature-box">
                <img src="https://cdn-icons-png.freepik.com/512/10074/10074028.png" alt="Reliable"> <!-- Replace with actual image -->
                <h2>Reliable</h2>
                <p>Depend on us to deliver your postcards promptly and safely.</p>
            </div>

            <!-- Track Feature -->
            <div class="feature-box">
                <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTI2vG8HFvT4xt5P_S6MvA6Nv-vy2kgGaQlBg&s" alt="Track"> <!-- Replace with actual image -->
                <h2>Track</h2>
                <p>Easily track the status of your postcards with our real-time tracking system.</p>
            </div>
        </div>
    </div>
</body>
</html>
