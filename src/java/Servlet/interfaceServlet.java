package Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class interfaceServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("foodId");
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");
        
        RequestDispatcher rd = request.getRequestDispatcher("food.jsp");
        request.setAttribute("id", id);
        rd.forward(request, response);
    }
}
