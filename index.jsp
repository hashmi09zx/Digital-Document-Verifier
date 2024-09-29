<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document Verifier</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <!-- Custom styles -->
    <style>
        body {
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
        }

        .navbar {
            background-color: #343a40;
        }

        .navbar-brand,
        .navbar-nav .nav-link {
            color: #ffffff;
        }

        .navbar-brand:hover,
        .navbar-nav .nav-link:hover {
            color: #ffffff;
        }

        .hero-section {
            background-color: #007bff;
            color: #ffffff;
            padding: 100px 0;
        }

        .feature-section {
            padding: 50px 0;
        }

        .feature-icon {
            font-size: 40px;
            color: #007bff;
        }

        .feature-heading {
            color: #007bff;
        }

        .footer {
            background-color: #343a40;
            color: #ffffff;
            padding: 20px 0;
        }

        .btn-login-signup {
            background: linear-gradient(45deg, #4CAF50, #007bff);
            color: #ffffff;
            border: none;
            border-radius: 4px;
            padding: 10px 20px;
            margin-top: 20px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .btn-login-signup:hover {
            background: linear-gradient(45deg, #45a049, #0056b3);
        }
    </style>
</head>

<body>

    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="#">Document Verifier</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="ScanQRFromCamera.jsp">Verify by Scanner</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="UploadQR.jsp">Verify by Uploading QR</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="VerifyById.jsp">Verify by ID</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="GenerateQR.jsp">Generate QR</a>
                    </li>
                    <li class="nav-item" style="margin-right: 80px;">
                        <a class="nav-link" href="UploadDocument.jsp">Upload Document</a>
                    </li>
                    <%-- Check if the user is logged in --%>
                        <% if (request.getSession().getAttribute("fullName") !=null) { %>
                            <li class="nav-item dropdown">
                                <a href="#" id="navbarDropdown" role="button" data-toggle="dropdown"
                                    aria-haspopup="true" aria-expanded="false">
                                    <i class='fas fa-user-alt' style='font-size:32px'></i>
                                </a>
                                <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">
                                    <span class="dropdown-item-text">
                                        <%= request.getSession().getAttribute("fullName") %>
                                    </span>
                                    <div class="dropdown-divider"></div>
                                    <a class="dropdown-item" href="LogoutServlet">Logout</a>
                                </div>
                            </li>


                            <% } %>
                </ul>
            </div>
        </div>
    </nav>



    <div class="container mt-4">
        <%-- Check if the message attribute is not null and display it --%>
            <% if (request.getAttribute("message") !=null) { %>
                <div id="messageBox" class="alert alert-primary" role="alert">
                    ${message}
                </div>
                <% } %>
    </div>


    <div class="hero-section text-center">
        <div class="container">
            <h1 class="display-4">Welcome to Document Verifier</h1>
            <p class="lead">Verify your documents securely and easily.</p>
            <a href="login.jsp" class="btn btn-login-signup">Login</a>
            <a href="signup.jsp" class="btn btn-login-signup">Signup</a>
        </div>
    </div>

    <div class="feature-section text-center">
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <i class="fa fa-lock feature-icon"></i>
                    <h3 class="feature-heading">Secure Verification</h3>
                    <p>Ensure the authenticity of your documents with our secure verification process.
                    </p>
                </div>
                <div class="col-md-4">
                    <i class="fa fa-user feature-icon"></i>
                    <h3 class="feature-heading">User-Friendly</h3>
                    <p>Easy-to-use interface makes document verification hassle-free for all users.</p>
                </div>
                <div class="col-md-4">
                    <i class="fa fa-check-circle feature-icon"></i>
                    <h3 class="feature-heading">Reliable Results</h3>
                    <p>Get accurate verification results quickly and reliably every time.</p>
                </div>
            </div>
        </div>
    </div>

    <footer class="footer text-center">
        <div class="container">
            <p>&copy; 2022 Document Verifier. All rights reserved.</p>
            <p>Email: abdullahhashmi24012006@gmail.com | Phone: +91-9835445727</p>
            <p>Address: ALIGARH MUSLIM UNIVERSITY, Aligarh, India</p>
        </div>
    </footer>

    <!-- jQuery and Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>


    <script>
        // Wait for the document to be fully loaded
        document.addEventListener("DOMContentLoaded", function () {
            // Select the message box
            var messageBox = document.getElementById("messageBox");
            // If the message box exists
            if (messageBox) {
                // Set a timeout to remove the message box after 8 seconds
                setTimeout(function () {
                    // Remove the message box from the DOM
                    messageBox.parentNode.removeChild(messageBox);
                }, 8000); // 8000 milliseconds = 8 seconds
            }
        });
    </script>

</body>

</html>