import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// This code is for displaying the document_content using qr scanning by using camera

@WebServlet("/DisplayDocumentServlet")
public class DisplayDocumentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get document ID from request parameter
        String documentId = request.getParameter("documentId");

        // Retrieve document information from the database based on the documentId
        Map<String, String> documentInfo = retrieveDocumentInfo(documentId);

        // Set documentInfo as request attribute
        request.setAttribute("documentInfo", documentInfo);

        // Forward request to displayDocument.jsp
        request.getRequestDispatcher("displayDocument.jsp").forward(request, response);
    }

    // Method to retrieve document information (id, name, issued_by, last_modified, document_content) from the database
    private Map<String, String> retrieveDocumentInfo(String documentId) {
        Map<String, String> documentInfo = new HashMap<>();
        String jdbcUrl = "jdbc:mysql://localhost:3306/abdullahdb";
        String dbUser = "root";
        String dbPassword = "Munger@123";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword)) {
                String sql = "SELECT id, document_name, issued_by, last_modified, document_content FROM documents WHERE id = ?";
                try (PreparedStatement statement = conn.prepareStatement(sql)) {
                    statement.setString(1, documentId);
                    try (ResultSet resultSet = statement.executeQuery()) {
                        if (resultSet.next()) {
                            documentInfo.put("id", resultSet.getString("id"));
                            documentInfo.put("name", resultSet.getString("document_name"));
                            documentInfo.put("issuedBy", resultSet.getString("issued_by"));
                            documentInfo.put("lastModified", resultSet.getString("last_modified"));
                            // Retrieve document content as base64 encoded string
                            byte[] documentContentBytes = resultSet.getBytes("document_content");
                            String documentContentBase64 = java.util.Base64.getEncoder().encodeToString(documentContentBytes);
                            documentInfo.put("documentContentBase64", documentContentBase64);
                        }
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return documentInfo;
    }
}
