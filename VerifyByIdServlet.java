import java.io.IOException;
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

@WebServlet("/VerifyByIdServlet")
public class VerifyByIdServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        Map<String, String> documentInfo = retrieveDocumentInfo(id);

        if (documentInfo.isEmpty()) {
            // Document not found, handle appropriately
            request.setAttribute("error", "Document with ID " + id + " not found");
            request.getRequestDispatcher("VerifyById.jsp").forward(request, response);
        } else {
            request.setAttribute("documentInfo", documentInfo);
            request.getRequestDispatcher("DisplayDocumentById.jsp").forward(request, response);
        }
    }

    // Method to retrieve document information from the database based on the documentId
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
        } catch (ClassNotFoundException e) {
            // Log ClassNotFoundException
            e.printStackTrace();
        } catch (SQLException e) {
            // Log SQLException
            e.printStackTrace();
            // Provide meaningful error message to the user
        } catch (Exception e) {
            // Log any other unexpected exceptions
            e.printStackTrace();
            // Provide meaningful error message to the user
        }
        return documentInfo;
    }
}
