<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Verify Document by ID</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Custom styles -->
    <style>
        body {
            width: 100%;
    height: 100vh;
    background-image: linear-gradient(rgba(0,0,50,0.8), rgba(0,0,50,0.8)),url(459-background.png);
    background-size: cover;
    background-position: center;
    background-attachment: fixed;
            padding-top: 50px;
        }

        h1 {
            text-align: center;
            margin-bottom: 30px;
        }

        form {
            max-width: 400px;
            margin: 0 auto;
            padding: 20px;
            background-color: rgba(0,0,50,0.8);
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        label {
            font-weight: bold;
            display: block;
            margin-bottom: 10px;
            color: #ffffff;
        }

        input[type="text"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            box-sizing: border-box;
        }

        button[type="submit"] {
            display: block;
            width: 100%;
            padding: 10px;
            margin-top: 20px;
            background-color: #007bff;
            color: #ffffff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button[type="submit"]:hover {
            background-color: transparent;
    border: 2px solid #007bff;
    cursor: pointer;
        }

        .error {
            color: #dc3545;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 style="color: #ffffff;">Verify Document by ID</h1>
        <form action="VerifyByIdServlet" method="post">
            <div class="form-group">
                <label for="id">Enter Document ID:</label>
                <input type="text" id="id" name="id" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-primary">Verify</button>
        </form>
        <% String error = (String) request.getAttribute("error");
        if (error != null) { %>
        <p class="error"><strong>Error:</strong> <%= error %></p>
        <% } %>
    </div>
</body>
</html>
