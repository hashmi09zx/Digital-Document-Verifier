import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DownloadDocumentServlet")
public class DownloadDocumentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve document ID from request parameter
        String documentId = request.getParameter("documentId");

        if (documentId != null && !documentId.isEmpty()) {
            try {
                // Retrieve document content from database based on document ID
                byte[] documentContentBytes = retrieveDocumentContentFromDatabase(documentId);

                if (documentContentBytes != null) {
                    // Convert document content to image format
                    BufferedImage image = convertToImage(documentContentBytes);

                    // Set response headers
                    response.setContentType("image/png");
                    response.setHeader("Content-Disposition", "attachment; filename=document.png");

                    // Write image to response output stream
                    OutputStream out = response.getOutputStream();
                    ImageIO.write(image, "png", out);
                    out.close();
                } else {
                    response.getWriter().println("Document content not found in the database.");
                }
            } catch (Exception e) {
                e.printStackTrace();
                // Handle errors (e.g., log or return error response)
                response.getWriter().println("Error downloading document: " + e.getMessage());
            }
        } else {
            // Handle case where document ID is not provided
            response.getWriter().println("Document ID not found.");
        }
    }

    // Method to retrieve document content from the database
    private byte[] retrieveDocumentContentFromDatabase(String documentId) {
        // Define database connection parameters
        String jdbcUrl = "jdbc:mysql://localhost:3306/abdullahdb";
        String dbUser = "root";
        String dbPassword = "Munger@123";

        try {
            // Establish database connection
            Connection conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

            // Prepare SQL statement to retrieve document content
            String sql = "SELECT document_content FROM documents WHERE id = ?";
            try (PreparedStatement statement = conn.prepareStatement(sql)) {
                statement.setString(1, documentId);
                try (ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                        // Retrieve document content bytes
                        return resultSet.getBytes("document_content");
                    }
                }
            }
            conn.close(); // Close database connection
        } catch (Exception e) {
            e.printStackTrace();
            // Handle database connection or query error
        }
        return null;
    }

    // Method to convert document content bytes to image format
    private BufferedImage convertToImage(byte[] documentContentBytes) throws IOException {
        // Create ByteArrayInputStream to read document content bytes
        ByteArrayInputStream in = new ByteArrayInputStream(documentContentBytes);

        // Read document content into BufferedImage
        return ImageIO.read(in);
    }
}
