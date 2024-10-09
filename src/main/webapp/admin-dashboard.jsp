<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.List"%>
<%@ page import="com.postaldelivery.model.core.PostOffice"%>

<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #121212; /* Dark background */
            color: #ffffff; /* White text */
            line-height: 1.6;
        }

        h2 {
            color: #ff4757; /* Bright red */
            margin-bottom: 10px;
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #c0392b; /* Dark red */
            padding: 15px 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.5);
        }

        .navbar-title {
            flex-grow: 1;
            text-align: center;
            color: #ffffff; /* White text for title */
            font-size: 24px;
            letter-spacing: 1px;
        }

        .navbar div {
            display: flex;
            align-items: center;
        }

        .navbar a {
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            margin-left: 10px;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .navbar a:hover {
            background-color: #e74c3c; /* Lighter red on hover */
        }

        .container {
            max-width: 800px;
            margin: 20px auto;
            background: #222; /* Darker background for the container */
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.5);
        }

        h3 {
            margin-bottom: 10px;
            color: #ff4757; /* Bright red */
        }

        form {
            margin: 20px 0;
        }

        input[type="text"], textarea {
            padding: 12px;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            width: calc(100% - 24px); /* Adjust width for padding */
            background-color: #444; /* Darker input background */
            color: white; /* White text in inputs */
            transition: border-color 0.3s;
        }

        input[type="text"]:focus {
            border-color: #ff4757; /* Bright red border on focus */
            outline: none;
        }

        input[type="submit"] {
            padding: 12px 20px;
            border: none;
            border-radius: 5px;
            background-color: #ff4757; /* Red button */
            color: white;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #d10000; /* Darker red on hover */
        }

        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }

        th, td {
            padding: 10px;
            border: 1px solid #444; /* Dark border for table */
            text-align: left;
        }

        th {
            background-color: #c0392b; /* Dark red header */
            color: white; /* White text for header */
        }

        .success {
            color: #28a745; /* Green for success messages */
            margin-bottom: 15px;
        }

        .error {
            color: #dc3545; /* Red for error messages */
            margin-bottom: 15px;
        }

        /* Modal Styles */
        .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            padding-top: 100px; /* Location of the box */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgba(0, 0, 0, 0.7); /* Black background with opacity */
        }

        .modal-content {
            background-color: #222; /* Dark background for modal */
            margin: auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            border-radius: 8px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.5);
        }

        .close {
            color: #aaa; /* Close button color */
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: #ff4757; /* Bright red on hover */
            text-decoration: none;
            cursor: pointer;
        }

    </style>
</head>
<body>
    <% response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); %>

    <c:if test="${empty admin }">
        <c:redirect url="admin-login.jsp"></c:redirect>
    </c:if>

    <div class="navbar">
        <div class="navbar-title">Admin Dashboard</div>
        <div>
            <a href="#" onclick="openModal('addPostOfficeModal')">Add Post Office</a>
            <a href="#" onclick="openModal('removePostOfficeModal')">Remove Post Office</a>
            <a href="logout">Logout</a>
        </div>
    </div>

    <div class="container">
        <h3>Welcome, Admin!</h3>

        <!-- Success and Error Messages -->
        <c:if test="${not empty param.success}">
            <div class="success">${param.success}</div>
        </c:if>
        <c:if test="${not empty param.error}">
            <div class="error">${param.error}</div>
        </c:if>
        <c:if test="${not empty param.failure}">
            <div class="error">${param.failure}</div>
        </c:if>

        <!-- Table to Display All Post Offices -->
        <h3>All Post Offices</h3>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>City</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="postOffice" items="${postOffices}">
                    <tr>
                        <td>${postOffice.id}</td>
                        <td>${postOffice.city}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Add Post Office Modal -->
    <div id="addPostOfficeModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal('addPostOfficeModal')">&times;</span>
            <h3>Add Post Office</h3>
            <form action="postoffice" method="post">
                <input type="hidden" name="action" value="addPostOffice" />
                <label for="city">City:</label>
                <input type="text" name="city" required />
                <input type="submit" value="Add Post Office" />
            </form>
        </div>
    </div>

    <!-- Remove Post Office Modal -->
    <div id="removePostOfficeModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal('removePostOfficeModal')">&times;</span>
            <h3>Remove Post Office</h3>
            <form action="postoffice" method="post">
                <input type="hidden" name="action" value="removePostOffice" />
                <label for="city">City:</label>
                <input type="text" name="city" required />
                <input type="submit" value="Remove Post Office" />
            </form>
        </div>
    </div>

    <!-- JavaScript for Modal Control -->
    <script>
        // Open modal by ID
        function openModal(modalId) {
            document.getElementById(modalId).style.display = "block";
        }

        // Close modal by ID
        function closeModal(modalId) {
            document.getElementById(modalId).style.display = "none";
        }

        // Close modal if user clicks outside the modal content
        window.onclick = function(event) {
            let modals = document.getElementsByClassName('modal');
            for (let i = 0; i < modals.length; i++) {
                if (event.target == modals[i]) {
                    modals[i].style.display = "none";
                }
            }
        }
    </script>

</body>
</html>
