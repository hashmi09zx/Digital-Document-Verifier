import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.google.zxing.BinaryBitmap;
import com.google.zxing.DecodeHintType;
import com.google.zxing.MultiFormatReader;
import com.google.zxing.NotFoundException;
import com.google.zxing.Result;
import com.google.zxing.client.j2se.BufferedImageLuminanceSource;
import com.google.zxing.common.HybridBinarizer;

import java.awt.image.BufferedImage;

@WebServlet("/DecodeQRServlet")
@MultipartConfig
public class DecodeQRServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get uploaded QR code file
        Part filePart = request.getPart("qrFile");
        InputStream fileContent = filePart.getInputStream();

        // Decode QR code and retrieve associated information
        String qrContent = decodeQR(fileContent);

        if (qrContent != null) {
            // Retrieve document information from the database based on the QR content
            Map<String, String> documentInfo = retrieveDocumentInfo(qrContent);

            // Forward the retrieved information to the display page
            request.setAttribute("documentInfo", documentInfo);
            request.getRequestDispatcher("DisplayDocumentInfo.jsp").forward(request, response);
        } else {
            // Handle QR decoding failure
            request.setAttribute("error", "Failed to decode QR code. Please upload a valid QR code.");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }

    // Method to decode QR code
    private String decodeQR(InputStream fileContent) {
        try {
            // Read the image from input stream
            BufferedImage image = ImageIO.read(fileContent);

            // Set up the hint map to specify the types of barcodes to be detected
            Map<DecodeHintType, Object> hints = new HashMap<>();
            hints.put(DecodeHintType.TRY_HARDER, Boolean.TRUE);

            // Create binary bitmap from image
            BinaryBitmap binaryBitmap = new BinaryBitmap(new HybridBinarizer(new BufferedImageLuminanceSource(image)));

            // Use ZXing's MultiFormatReader to decode the QR code
            Result result = new MultiFormatReader().decode(binaryBitmap, hints);

            // Return the decoded QR content
            return result.getText();
        } catch (IOException | NotFoundException e) {
            e.printStackTrace();
            // Handle the exception (e.g., log or return an error message)
            return null;
        }
    }

    // Method to retrieve document information from the database
    private Map<String, String> retrieveDocumentInfo(String qrContent) {
        // Define database connection parameters
        String jdbcUrl = "jdbc:mysql://localhost:3306/abdullahdb";
        String dbUser = "root";
        String dbPassword = "Munger@123";

        // Initialize document information map
        Map<String, String> documentInfo = new HashMap<>();

        // Attempt database connection and retrieve document information
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
            String sql = "SELECT id, document_name, issued_by, last_modified, document_content FROM documents WHERE id = ?";
            try (PreparedStatement statement = conn.prepareStatement(sql)) {
                statement.setString(1, qrContent);
                try (ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                        documentInfo.put("id", resultSet.getString("id"));
                        documentInfo.put("name", resultSet.getString("document_name"));
                        documentInfo.put("issuedBy", resultSet.getString("issued_by"));
                        documentInfo.put("lastModified", resultSet.getString("last_modified"));

                        // Retrieve document content
                        InputStream inputStream = resultSet.getBinaryStream("document_content");
                        if (inputStream != null) {
                            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                            byte[] buffer = new byte[4096];
                            int bytesRead;
                            while ((bytesRead = inputStream.read(buffer)) != -1) {
                                outputStream.write(buffer, 0, bytesRead);
                            }
                            byte[] contentBytes = outputStream.toByteArray();
                            String documentContentBase64 = Base64.getEncoder().encodeToString(contentBytes);
                            documentInfo.put("documentContentBase64", documentContentBase64);
                        } else {
                            // No document content available
                            documentInfo.put("documentContentBase64", null);
                        }
                    }
                }
            }
            conn.close(); // Closing the connection
        } catch (ClassNotFoundException | SQLException | IOException e) {
            e.printStackTrace();
            // Handle database connection or query error
            // Log the exception or provide a meaningful error message to the user
        }

        return documentInfo;
    }
}
