<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Received Posts</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; /* Updated font */
            background-color: #121212; /* Dark background */
            color: white; /* White text */
            margin: 0;
            padding: 0;
        }

        h2 {
            margin-top: 30px;
            color: #ff4757; /* Bright red heading */
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #b30000; /* Dark red background */
            padding: 15px 20px;
            color: white; /* White text */
        }

        .navbar a {
            color: white; /* White text for navbar links */
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 5px;
        }

        .navbar a:hover {
            background-color: #ff4757; /* Lighter red on hover */
        }

        .container {
            max-width: 80%; /* Center container */
            margin: 20px auto; /* Centering */
            padding: 20px;
            background-color: #222; /* Dark background for content */
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.5);
            text-align: center; /* Center text inside the container */
        }

        table {
            width: 100%; /* Full width for table */
            margin: 20px auto;
            border-collapse: collapse;
        }

        th, td {
            padding: 10px;
            border: 1px solid #555; /* Dark border for table */
            text-align: left;
        }

        th {
            background-color: #b30000; /* Dark red header */
            color: white; /* White text for header */
        }

        td {
            background-color: #444; /* Darker background for table rows */
            color: white; /* White text for table rows */
        }

        /* Additional styles for better aesthetics */
        tr:nth-child(even) {
            background-color: #555; /* Slightly lighter gray for even rows */
        }

        tr:hover {
            background-color: #ff4757; /* Red hover effect */
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
            background-color: rgba(0, 0, 0, 0.6); /* Black w/ opacity */
        }

        .modal-content {
            background-color: #333; /* Dark background for modal */
            margin: auto;
            padding: 20px;
            border-radius: 5px;
            width: 50%; /* Could be more or less, depending on screen size */
            color: white; /* White text inside modal */
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.5); /* Modal shadow */
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover, .close:focus {
            color: white; /* Change close button color on hover */
            text-decoration: none;
            cursor: pointer;
        }

        input[type="text"],
        textarea {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #555; /* Darker border for inputs */
            border-radius: 5px;
            background-color: #444; /* Darker input background */
            color: white; /* White text in inputs */
        }

        input[type="submit"] {
            padding: 10px 20px;
            background-color: #ff4757; /* Red button */
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s; /* Smooth background transition */
        }

        input[type="submit"]:hover {
            background-color: #b30000; /* Darker red on hover */
        }
    </style>
</head>
<body>
 <% response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); %>
    <c:if test="${empty customer }">
        <c:redirect url="/customer-login.jsp"></c:redirect>
    </c:if>

<div class="navbar">
    <div>
        <a href="customer-dashboard.jsp">Customer</a>
    </div>
    <div>
        <a href="#" onclick="openModal('sendPostcardModal')">Send Postcard</a>
        <a href="#" onclick="openModal('trackPostcardModal')">Track Postcard</a>
        <a href="logout">Logout</a>
    </div>
</div>

<div class="container">
    <h2>Your Received Posts</h2>

    <table>
        <thead>
            <tr>
                <th>Postcard ID</th>
                <th>Sender Name</th>
                <th>Sender Address</th>
                <th>Message</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="postcard" items="${receivedPosts}">
                <tr>
                    <td>${postcard.id}</td>
                    <td>${postcard.senderName}</td>
                    <td>${postcard.senderAddress}, ${postcard.senderCity}</td>
                    <td>${postcard.message}</td>
                    <td>${postcard.status}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<!-- Send Postcard Modal -->
<div id="sendPostcardModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal('sendPostcardModal')">&times;</span>
        <h3>Send a Postcard</h3>
        <form action="customer" method="post">
            <input type="hidden" name="action" value="sendPostCard">
            <label>Receiver Name:</label> <input type="text" name="receiverName" required>
            <label>Receiver Address:</label> <input type="text" name="receiverAddress" required>
            <label>Receiver City:</label> <input type="text" name="receiverCity" required>
            <label>Message:</label>
            <textarea name="message" required></textarea>
            <input type="submit" value="Send Postcard">
        </form>
    </div>
</div>

<!-- Track Postcard Modal -->
<div id="trackPostcardModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal('trackPostcardModal')">&times;</span>
        <h3>Track a Postcard</h3>
        <form action="customer" method="post">
            <input type="hidden" name="action" value="trackPostCard">
            <label>Postcard ID:</label> <input type="text" name="postCardId" required>
            <input type="submit" value="Track Postcard">
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
