import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/UploadDocumentServlet")
@MultipartConfig(maxFileSize = 16177215) // 16MB
public class UploadDocumentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        String documentName = request.getParameter("documentName");
        String issuedBy = request.getParameter("issuedBy");
        Part filePart = request.getPart("documentContent");

        InputStream documentContent = null;
        if (filePart != null) {
            documentContent = filePart.getInputStream();
        }

        String jdbcUrl = "jdbc:mysql://localhost:3306/abdullahdb";
        String dbUser = "root";
        String dbPassword = "Munger@123";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

            String sql = "INSERT INTO documents (id, document_name, issued_by, document_content) VALUES (?, ?, ?, ?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, id);
            statement.setString(2, documentName);
            statement.setString(3, issuedBy);
            statement.setBlob(4, documentContent);

            statement.executeUpdate();
            statement.close();
            connection.close();

            request.setAttribute("message", "Document uploaded successfully!");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to upload document. Please try again with new Document Id.");
        }

        request.getRequestDispatcher("UploadDocument.jsp").forward(request, response);
    }
}
