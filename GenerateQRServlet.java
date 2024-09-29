import java.io.IOException;
import java.io.OutputStream;
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

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;

@WebServlet("/GenerateQRServlet")
public class GenerateQRServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the document ID from the form submission
        String documentId = request.getParameter("documentId");

        // Generate QR code for the document ID
        generateQRCode(documentId, response.getOutputStream());
    }

    // Method to generate QR code for the document ID
    private void generateQRCode(String documentId, OutputStream outputStream) throws IOException {
        try {
            // Generate QR code for the document ID
            BitMatrix bitMatrix = new MultiFormatWriter().encode(documentId, BarcodeFormat.QR_CODE, 400, 400);
            MatrixToImageWriter.writeToStream(bitMatrix, "PNG", outputStream);
        } catch (WriterException e) {
            e.printStackTrace();
        }
    }
}
