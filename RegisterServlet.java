import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();

        // Database connection parameters
        String url = "jdbc:mysql://localhost:3306/abdullahdb"; // Update with your database URL
        String user = "root"; // Update with your database username
        String dbPassword = "Munger@123"; // Update with your database password

        // Form data
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String userPassword = request.getParameter("password"); // Renamed to avoid conflict
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        String dateOfBirth = request.getParameter("dateOfBirth");
        String governmentIDType = request.getParameter("governmentIDType");
        String governmentIDValue = request.getParameter("governmentIDValue");

        Connection connection = null;

        try {
            // Load the database driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Establish the database connection
            connection = DriverManager.getConnection(url, user, dbPassword);

            // Insert user data into the database
            String insertQuery = "INSERT INTO Users (FullName, Email, Password, PhoneNumber, Address, DateOfBirth, GovernmentIDType, GovernmentIDValue) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement preparedStatement = connection.prepareStatement(insertQuery);
            preparedStatement.setString(1, fullName);
            preparedStatement.setString(2, email);
            preparedStatement.setString(3, userPassword); // Changed variable name here
            preparedStatement.setString(4, phoneNumber);
            preparedStatement.setString(5, address);
            preparedStatement.setString(6, dateOfBirth);
            preparedStatement.setString(7, governmentIDType);
            preparedStatement.setString(8, governmentIDValue);

            int rowsAffected = preparedStatement.executeUpdate();

            if (rowsAffected > 0) {
                // Registration successful
                request.setAttribute("message", "Registration successful");
            } else {
                // Registration failed
                request.setAttribute("message", "Failed to register user");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            // Registration failed due to exception
            request.setAttribute("message", "Error: " + e.getMessage());
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // Forward the request to index.jsp
        RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
        dispatcher.forward(request, response);
    }
}
