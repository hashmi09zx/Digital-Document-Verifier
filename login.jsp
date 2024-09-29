<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>User Login</title>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <!-- Custom styles -->
        <style>
            body {
                width: 100%;
                height: 100vh;
                background-image: linear-gradient(rgba(0, 0, 50, 0.8), rgba(0, 0, 50, 0.8)), url(459-background.png);
                background-size: cover;
                background-position: center;
                background-attachment: fixed;
            }

            .container {
                /* max-width: 400px; */
                width: 400px;
                height: 350px;
                margin-top: 40px;
                border-radius: 5px;
                background: transparent;
                border: 2px solid rgba(225, 225, 225, 0.637);
            }

            .form-group label {
                font-weight: bold;
                color: #ffffff;
            }

            .btn-login {
                background-color: #007bff;
                color: #ffffff;
                border: none;
                border-radius: 4px;
                padding: 10px 20px;
                margin-top: 20px;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .btn-login:hover {
                background-color: transparent;
                border: 2px solid #007bff;
                cursor: pointer;
            }
        </style>
    </head>

    <body>

        <div class="container">
            <h2 style="color: #ffffff;" class="text-center mb-4">User Login</h2>
            <form action="LoginServlet" method="post">
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" class="form-control" id="email" name="email" required>
                </div>
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" class="form-control" id="password" name="password" required>
                </div>
                <button style="color: #ffffff;" type="submit" class="btn btn-login btn-block">Login</button>
            </form>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    </body>

    </html>