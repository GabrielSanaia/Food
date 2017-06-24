package Servlet;

import Dao.UserDAO;
import Dao.UserDAOImpl;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
       
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UserDAO userDAO = new UserDAOImpl();
        User user = userDAO.getUser(username, password);

        if (username.equals("") || password.equals("")) {
            request.setAttribute("isLoginFieldEmpty", true);
            RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
            rd.forward(request, response);
        } else if (user == null) {
            request.setAttribute("loginFailed", true);
            RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
            rd.forward(request, response);
        } else if (!username.isEmpty() && !password.isEmpty()) {
            RequestDispatcher rd = request.getRequestDispatcher("Interface.jsp?page=1");
            HttpSession session = request.getSession();
            
            session.setAttribute("id", user.getId());
            rd.forward(request, response);
        }
    }
}
