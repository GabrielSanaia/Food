/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author TechnoLine
 */
public class foodToUserServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String user_ids = request.getParameter("user_id");
        
        int  user_id = Integer.parseInt(user_ids);
        
        request.setAttribute("user_id", user_id);
        
        RequestDispatcher rd = request.getRequestDispatcher("userProfile.jsp");
        rd.forward(request, response);
        
    }

    
    
}
