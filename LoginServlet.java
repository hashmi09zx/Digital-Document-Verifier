import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();

        // Database connection parameters
        String url = "jdbc:mysql://localhost:3306/abdullahdb"; // Update with your database URL
        String user = "root"; // Update with your database username
        String dbPassword = "Munger@123"; // Update with your database password

        // Form data
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Connection connection = null;

        try {
            // Load the database driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Establish the database connection
            connection = DriverManager.getConnection(url, user, dbPassword);

            // Check if the user exists in the database
            String selectQuery = "SELECT FullName FROM Users WHERE Email=? AND Password=?";
            PreparedStatement preparedStatement = connection.prepareStatement(selectQuery);
            preparedStatement.setString(1, email);
            preparedStatement.setString(2, password);

            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                // User exists, set session attribute and redirect to index.jsp
                String fullName = resultSet.getString("FullName");
                HttpSession session = request.getSession();
                session.setAttribute("fullName", fullName);
                response.sendRedirect("index.jsp");
            } else {
                // User doesn't exist, display error message
                response.setContentType("text/html");
                out.print("<div style='color: red; text-align: center;'>Invalid email or password.</div>");
                request.getRequestDispatcher("login.jsp").include(request, response);
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.setContentType("text/html");
            out.print("<div style='color: red; text-align: center;'>Error: " + e.getMessage() + "</div>");
            request.getRequestDispatcher("login.jsp").include(request, response);
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
