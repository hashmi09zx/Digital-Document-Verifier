<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document Information</title>
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
                max-width: 600px;
                margin: 20px auto;
                padding: 20px;
                background: transparent;
                border: 2px solid rgba(225, 225, 225, 0.637);
                border-radius: 5px;
            }

            h2 {
                text-align: center;
                margin-bottom: 20px;
            }

            form {
                display: flex;
                flex-direction: column;
            }

            label {
                font-weight: bold;
                color: #fff;
            }

            input[type="text"],
            input[type="file"] {
                width: 100%;
                padding: 10px;
                margin: 5px 0 15px 0;
                border: 1px solid #ccc;
                border-radius: 5px;
                box-sizing: border-box;
            }

            input[type="submit"] {
                width: auto;
                padding: 10px 20px;
                margin-top: 15px;
                background-color: #007bff;
                color: #fff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            input[type="submit"]:hover {
                background-color: transparent;
                border: 2px solid #007bff;
                cursor: pointer;
            }

            .message {
                text-align: center;
                margin-top: 20px;
            }

            .message.success {
                color: green;
            }

            .message.error {
                color: red;
            }

            .back-link {
                text-align: center;
                margin-top: 20px;
            }

            .back-link a {
                color: #007bff;
                text-decoration: none;
            }
        </style>
    </head>

    <body>
        <div class="container">
            <h2 style="color: #fff;">Enter Document Information</h2>
            <% if (request.getAttribute("message") !=null) { %>
                <div class="message success">
                    <%= request.getAttribute("message") %>
                </div>
                <% } %>

                    <% if (request.getAttribute("error") !=null) { %>
                        <div class="message error">
                            <%= request.getAttribute("error") %>
                        </div>
                        <% } %>
                            <form action="UploadDocumentServlet" method="post" enctype="multipart/form-data">
                                <label for="id">Document ID:</label>
                                <input type="text" id="id" name="id" required>

                                <label for="documentName">Document Name:</label>
                                <input type="text" id="documentName" name="documentName" required>

                                <label for="issuedBy">Issued By:</label>
                                <input type="text" id="issuedBy" name="issuedBy">

                                <label for="documentContent">Document Content:</label>
                                <input type="file" id="documentContent" name="documentContent" required>

                                <input type="submit" value="Submit">
                            </form>

                            <div class="back-link">
                                <a href="index.jsp">Go back to Home page</a>
                            </div>
        </div>
    </body>

    </html>