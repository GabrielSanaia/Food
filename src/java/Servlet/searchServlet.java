package Servlet;

import Dao.FoodDAO;
import Dao.FoodDAOImpl;
import Model.Food;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class searchServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");
        String search = request.getParameter("search");
        
        FoodDAO dao = new FoodDAOImpl();
        ArrayList<Food> foods = dao.getFoodByName(search);
        request.setAttribute("searchList", foods);

        RequestDispatcher rd = request.getRequestDispatcher("searchedFoods.jsp");
        rd.forward(request, response);

    }
}
