<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>Postman Dashboard</title>
<style>
body {
    font-family: Arial, sans-serif;
    background-color: #111; /* Dark background */
    margin: 0;
    padding: 0;
    color: white; /* White text */
}

.navbar {
    background-color: #b30000; /* Red background */
    overflow: hidden;
    padding: 15px 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.navbar-left {
    color: white;
    font-size: 18px;
}

.navbar-right .logout-btn {
    background-color: #b30000; /* Red button */
    color: white;
    padding: 10px 15px;
    border: none;
    cursor: pointer;
}

.navbar-right .logout-btn:hover {
    background-color: yellow; /* Yellow hover for logout button */
    color: black;
}

h2 {
    color: #ff1a1a; /* Red heading */
}

table {
    width: 80%;
    margin: 20px auto;
    border-collapse: collapse;
    background-color: #222; /* Dark background for the table */
}

th, td {
    padding: 10px;
    border: 1px solid #555; /* Dark border */
    text-align: left;
    color: white;
}

th {
    background-color: #b30000; /* Red table header */
    color: white;
}

td {
    background-color: #333; /* Dark background for table cells */
    color: white;
}

input[type="submit"] {
    padding: 10px 15px;
    background-color: #b30000; /* Red submit button */
    color: white;
    border: none;
    cursor: pointer;
}

input[type="submit"]:hover {
    background-color: #ff1a1a; /* Lighter red on hover */
}

.success {
    color: #28a745; /* Green success message */
}

.error {
    color: #ff3333; /* Red error message */
}

/* Center main content */
.main-content {
    text-align: center;
    padding: 20px;
}
</style>
</head>
<body>
    <% response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); %>
    <c:if test="${empty postman }">
        <c:redirect url="/postman-login.jsp"></c:redirect>
    </c:if>
    <!-- Navbar -->
    <div class="navbar">
        <div class="navbar-left">
            Postman: ${postman.name} <br>
            Post Office City: ${postman.city}
        </div>
        <div class="navbar-right">
            <form action="logout" method="get">
                <input type="submit" class="logout-btn" value="Logout">
            </form>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <h2>Postman Dashboard</h2>
        <p>Below are the posts assigned to your post office:</p>

        <!-- Display success or error messages -->
        <c:if test="${not empty param.success}">
            <div class="success">${param.success}</div>
        </c:if>
        <c:if test="${not empty param.error}">
            <div class="error">${param.error}</div>
        </c:if>

        <!-- Posts Table -->
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Sender</th>
                    <th>Receiver Name</th>
                    <th>Receiver Address</th>
                    <th>Receiver City</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="postcard" items="${postcards}">
                    <tr>
                        <td>${postcard.id}</td>
                        <td>${postcard.senderName}</td>
                        <td>${postcard.receiverName}</td>
                        <td>${postcard.receiverAddress}</td>
                        <td>${postcard.receiverCity}</td>
                        <td>${postcard.status}</td>
                        <td>
                            <form action="postman" method="post">
                                <input type="hidden" name="action" value="deliverPostcard">
                                <input type="hidden" name="postCardId" value="${postcard.id}">
                                <input type="submit" value="Mark as Delivered">
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>
