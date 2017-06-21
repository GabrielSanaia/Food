package Servlet;

import Dao.FoodDAO;
import Dao.FoodDAOImpl;
import Enum.BeverageType;
import Enum.MenuType;
import Model.Food;
import Model.Menu;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import processor.MenuProcessor;

public class chooseFoodsServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        FoodDAO fdao = new FoodDAOImpl();

        String name = request.getParameter("name");
        String type = request.getParameter("type");
        String beverage = request.getParameter("beverage");
        ArrayList<Food> foods = new ArrayList<Food>();

        String values = request.getParameter("values");
        
        if (values.isEmpty()) {
            
            response.setContentType("text/html");
            response.setCharacterEncoding("UTF-8");
            request.setAttribute("chooseFoodsFailed", true);
            RequestDispatcher rd = request.getRequestDispatcher("addmenu.jsp");
            rd.forward(request, response);
            
        }
        String[] array = values.split(",");
        if (array.length <= 3) {
            response.setContentType("text/html");
            response.setCharacterEncoding("UTF-8");
            request.setAttribute("chooseFoodsFailed", true);
            RequestDispatcher rd = request.getRequestDispatcher("addmenu.jsp");
            rd.forward(request, response);
        }

        for (String s : array) {
            int asId = Integer.parseInt(s);
            Food food = fdao.getFoodById(asId);
            food.setId(asId);
            foods.add(food);
        }
            Menu menu = new Menu(name, MenuType.valueOf(type), foods, BeverageType.valueOf(beverage));
            MenuProcessor.addMenu(menu);
        
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");

        RequestDispatcher rd = request.getRequestDispatcher("chooseMenus.jsp");
        rd.forward(request, response);

    }
}
