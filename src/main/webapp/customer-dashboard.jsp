<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>Customer Dashboard</title>
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
            background-color: #b30000; /* Darker red background */
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
            max-width: 100%; /* Center container */
            height: 100vh;
            margin: auto;
            padding: 20px;
            background-color: #222; /* Dark background for content */
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.5);
            text-align: center; /* Center text inside the container */
        }

        .btn {
            background-color: #ff4757; /* Red button */
            color: white;
            padding: 15px 30px;
            margin: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s; /* Smooth background transition */
        }

        .btn:hover {
            background-color: #e84118; /* Darker red on hover */
        }

        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            padding-top: 100px;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.6); /* Darker overlay */
        }

        .modal-content {
            background-color: #333; /* Dark background for modal */
            margin: auto;
            padding: 20px;
            border-radius: 5px;
            width: 50%;
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
            background-color: #e84118; /* Darker red on hover */
        }

        .welcome {
            margin-top: 20px;
            font-size: 18px;
            color: #ff4757; /* Bright red welcome message */
        }
    </style>
</head>
<body>
    <% response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); %>
    <c:if test="${empty customer }">
        <c:redirect url="/customer-login.jsp"></c:redirect>
    </c:if>

    <!-- Navbar -->
    <div class="navbar">
        <div class="navbar-left">
            <span>Customer Dashboard</span>
        </div>
        <div class="navbar-right">
            <a href="#" onclick="openModal('sendPostcardModal')">Send Postcard</a>
            <a href="#" onclick="openModal('trackPostcardModal')">Track Postcard</a>
            <a href="#" onclick="openModal('viewReceivedPostsModal')">View Received Posts</a>
            <a href="logout">Logout</a>
        </div>
    </div>

    <div class="container">
        <h2>Welcome, ${customer.name}!</h2>
        <p class="welcome">Thank you for trusting our service!</p>
		<c:if test="${not empty param.success}">
        <div class="success">${param.success}</div>
    	</c:if>
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

        <!-- View Received Posts Modal -->
        <div id="viewReceivedPostsModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeModal('viewReceivedPostsModal')">&times;</span>
                <h3>View Received Posts</h3>
                <form action="customer" method="post">
                    <input type="hidden" name="action" value="viewReceivedPosts">
                    <input type="submit" value="View Posts">
                </form>
            </div>
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
