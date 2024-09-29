<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Generate QR Code</title>
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
        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            background-color: rgba(0,0,50,0.8);
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        form {
            text-align: center;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #fff;
        }
        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
        .home-link {
            text-align: center;
            margin-top: 20px;
        }
        .home-link a {
            color: #007bff;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 style="color: #fff;">Generate QR Code</h2>
        <form action="GenerateQRServlet" method="post">
            <label for="documentId">Document ID:</label><br>
            <input type="text" id="documentId" name="documentId" required><br><br>
            
            <input type="submit" value="Generate QR Code">
        </form>
        
        <div class="home-link">
            <a href="index.jsp">Go back to home page</a>
        </div>
    </div>
</body>
</html>
