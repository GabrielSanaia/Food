package Servlet;

import Dao.UserDAO;
import Dao.UserDAOImpl;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class addFavoriteServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        

        String ids =  request.getParameter("id");
        int foodId = Integer.parseInt(ids);

        int userId = (int) request.getSession().getAttribute("id");
        
        UserDAO dao = new UserDAOImpl();
        dao.addFavorite(userId, foodId);    
        
        RequestDispatcher rd = request.getRequestDispatcher("food.jsp");
        request.setAttribute("id", ids);
        rd.forward(request, response);
    }
}