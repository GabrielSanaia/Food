package Servlet;

import Dao.UserDAO;
import Dao.UserDAOImpl;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class changePasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String repeatNewPassword = request.getParameter("repeatNewPassword");

        if (oldPassword.isEmpty() || newPassword.isEmpty() || repeatNewPassword.isEmpty()) {
            request.setAttribute("empty", true);
            RequestDispatcher rd = request.getRequestDispatcher("changePassword.jsp");
            rd.forward(request, response);
        }
        if (!newPassword.equals(repeatNewPassword)) {
            request.setAttribute("repeat", true);
            RequestDispatcher rd = request.getRequestDispatcher("changePassword.jsp");
            rd.forward(request, response);
        }
        UserDAO dao = new UserDAOImpl();
        boolean b = dao.changePassword((int) request.getSession().getAttribute("id"), oldPassword, newPassword);
        System.out.println(b);
        if (b == Boolean.FALSE) {
            request.setAttribute("error", true);
            RequestDispatcher rd = request.getRequestDispatcher("changePassword.jsp");
            rd.forward(request, response);
        }
        RequestDispatcher rd = request.getRequestDispatcher("profile.jsp");
        rd.forward(request, response);
    }
}
