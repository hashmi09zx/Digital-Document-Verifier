<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Document Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        .container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1, h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        th, td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        .document-content {
            text-align: center;
            margin-top: 20px;
        }

        .document-content img {
            max-width: 100%;
            border-radius: 8px;
            box-shadow: 0 0 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 10px;
        }

        .document-content .download-btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            margin-top: 10px;
        }

        .document-content .download-btn:hover {
            background-color: #b30000;
        }

        .no-content {
            text-align: center;
            color: #888;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Document Details</h1>

        <%-- Display document information --%>
        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Issued By</th>
                <th>Last Modified</th>
            </tr>
            <tr>
                <%
                    Map<String, String> documentInfo = (Map<String, String>) request.getAttribute("documentInfo");
                %>
                <td><%= documentInfo.get("id") %></td>
                <td><%= documentInfo.get("name") %></td>
                <td><%= documentInfo.get("issuedBy") %></td>
                <td><%= documentInfo.get("lastModified") %></td>
            </tr>
        </table>

        <%-- Display document content (if available) --%>
        <div class="document-content">
            <h2>Document Content</h2>
            <% String documentId = documentInfo.get("id");
            String documentContentBase64 = documentInfo.get("documentContentBase64");
            if (documentId != null && !documentId.isEmpty() && documentContentBase64 != null && !documentContentBase64.isEmpty()) { %>
                <img src="data:image/jpeg;base64,<%= documentContentBase64 %>" alt="Document Image">
                <br>
                <form action="DownloadDocumentServlet" method="post">
                    <input type="hidden" name="documentId" value="<%= documentId %>">
                    <button type="submit" class="download-btn">Download Document</button>
                </form>
            <% } else { %>
                <p class="no-content">No document content available.</p>
            <% } %>
        </div>
    </div>
</body>
</html>
