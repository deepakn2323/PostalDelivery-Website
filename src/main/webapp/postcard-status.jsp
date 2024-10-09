<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Postcard Status</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-color: #0a0a0a; /* Dark background */
            color: white; /* White text */
            margin: 0;
            padding: 0;
        }

        h2 {
            margin-top: 30px;
            color: #ff1a1a; /* Bright red heading */
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #b30000; /* Dark red background */
            padding: 15px 20px;
            color: white; /* White text */
        }

        .navbar div {
            display: flex;
            align-items: center;
        }

        .navbar a {
            color: white; /* White text for navbar links */
            text-decoration: none;
            padding: 10px 20px;
            margin-left: 10px;
            border-radius: 5px;
        }

        .navbar a:hover {
            background-color: #ff1a1a; /* Lighter red on hover */
        }

        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            border-radius: 5px;
            background-color: #222; /* Dark background for container */
        }

        table {
            width: 100%;
            margin: 20px 0;
            border-collapse: collapse;
            border: 1px solid #ccc; /* Light border for table */
        }

        th, td {
            padding: 10px;
            border: 1px solid #ccc;
            text-align: left;
        }

        th {
            background-color: #b30000; /* Dark red header */
            color: white; /* White text for header */
        }

        td {
            background-color: #fff; /* White background for table cells */
            color: #000; /* Black text for table cells */
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
            background-color: rgba(0, 0, 0, 0.7); /* Black w/ opacity */
        }

        .modal-content {
            background-color: #333; /* Dark background for modal */
            margin: auto;
            padding: 20px;
            border-radius: 5px;
            width: 50%; /* Could be more or less, depending on screen size */
            color: white; /* White text inside modal */
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

        input[type="text"], textarea {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #444; /* Darker input background */
            color: white; /* White text in inputs */
        }

        input[type="submit"] {
            padding: 10px 20px;
            background-color: #b30000; /* Red button */
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #ff1a1a; /* Lighter red on hover */
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
        <span>Welcome, ${customer.name}</span>
    </div>
    <div>
        <a href="#" onclick="openModal('sendPostcardModal')">Send Postcard</a>
        <a href="#" onclick="openModal('viewReceivedPostsModal')">View Received Posts</a>
        <a href="logout">Logout</a>
    </div>
</div>

<div class="container">
    <h2>Postcard Status</h2>

    <c:if test="${not empty postcard}">
        <table>
            <tr>
                <th>Postcard ID</th>
                <td>${postcard.id}</td>
            </tr>
            <tr>
                <th>Sender Name</th>
                <td>${postcard.senderName}</td>
            </tr>
            <tr>
                <th>Receiver Address</th>
                <td>${postcard.receiverAddress}, ${postcard.receiverCity}</td>
            </tr>
            <tr>
                <th>Message</th>
                <td>${postcard.message}</td>
            </tr>
            <tr>
                <th>Status</th>
                <td>${postcard.status}</td>
            </tr>
        </table>
    </c:if>
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
