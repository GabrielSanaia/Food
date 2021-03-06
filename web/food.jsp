<%@page import="Model.User"%>
<%@page import="Dao.UserDAOImpl"%>
<%@page import="Dao.UserDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.Ingredient"%>
<%@page import="Dao.FoodDAOImpl"%>
<%@page import="Dao.FoodDAO"%>
<%@page import="Model.Food"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setDateHeader("Expires", -1);
%>
<html>
    <head>
        <%
            int id = Integer.parseInt((String) request.getAttribute("id"));

            FoodDAO dao = new FoodDAOImpl();
            Food food = dao.getFoodById(id);
            out.write("<title>" + food.getName() + "</title>");
        %>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="Public/css/style.css" type="text/css"/>
        <link rel="icon" type="image/png" href="Public/foto/icon2.png" />
        <style>
            body{
                background: url("Public/foto/bg2.jpg");
            }
        </style>
    </head>
    <body>
        <form action="foodServlet" method="post">
            <div class="interface_main">
                <button style="margin-right: 3%;" type="submit" class="button_1" name="action" value="button1" formaction="myProfile.jsp">ჩემი გვერდი</button>
                <a type="submit" class="button_1" name="action" value="button1" href="Interface.jsp?page=1">მთავარი გვერდი</a>
                <button type="submit" class="button_1" name="action" value="button1" formaction="addfood.jsp">კერძის დამატება</button>
                <button type="submit" class="button_1" name="action" value="button1" formaction="addmenu.jsp">მენიუს დამატება</button>
                <button type="submit" class="button_1" name="action" value="button1" formaction="chooseMenus.jsp">მენიუს შერჩევა</button>
            </div>
        </form>
        <form action="searchServlet" method="post" class="search_form">
            <input class="search_button" style="float:right" type="submit" value="ძებნა">
            <input class="search_1" style="float:right;font-size: 12px;" type="search" name="search" placeholder="კერძის ძებნა">
        </form>

        <%
            out.write("<div class=\"interface_2\">");

            out.write("<img src=\"Public/foto/foodline.jpg\" class=\"photo_food\">");
            out.write("<div style=\"display :inline-block;float: left\"><img src= \"Public/photos/" + food.getImagePath() + " \" onerror=\"this.src='Public/foto/icon2.png'\" class=\"food_photo\"></div>");
            out.write("<h1>" + food.getName() + "</h1>");
            out.write("<div class=\"food_name\">");
            out.write("<br>");
            UserDAO userdao = new UserDAOImpl();
            User user = userdao.getUserById(food.getUser_id());
            out.write("<form action=\"foodToUserServlet\" method=\"post\">");
            out.write("<h3 class=\"food_txt\">" + "ავტორი:" + user.getName() + " " + user.getSurName() + "</h3> ");
            out.write("<input name=\"user_id\"  type=\"hidden\" value=\"" + food.getUser_id() + "\"></input>");
            if (food.getUser_id() != (int) request.getSession().getAttribute("id")) {

                out.write("<input class=\"search_button\" style=\"margin-left:10px; text-align:center; height:29px;font-size:13px; margin-top:17px\"  type=\"submit\" value=\"მეტი\"></input>");
            }
            out.write("<br>");
            out.write("<h3 class=\"food_txt\" style=\"margin-left:0px;\">" + "ტიპი: " + food.getFoodtype().toString() + "</h3>");
            out.write("</div>");
            out.write("<br>");
            out.write("<br>");
            out.write("</form>");
            boolean b = userdao.checkFavorite((int) request.getSession().getAttribute("id"), id);

            if (food.getUser_id() != (int) request.getSession().getAttribute("id")) {
                if (b == false) {

                    out.write("<form action=\"addFavoriteServlet\" method=\"post\">");
                    out.write("<button class=\"favourite_btn\">ფავორიტებში დამატება</button>");
                    out.write("<input name=\"id\" type=\"hidden\" value=\"" + id + "\"/>");
                    out.write("</form>");

                }
                if (b == true) {

                    out.write("<form action=\"deleteFavoriteServlet\" method=\"post\">");
                    out.write("<button class=\"favourite_btn\">ფავორიტებიდან წაშლა</button>");
                    out.write("<input name=\"id\" type=\"hidden\" value=\"" + id + "\"/>");
                    out.write("</form>");

                }
            }

            out.write("<table>");
            out.write("<tr>");
            out.write("<th>სახელი</th>");
            out.write("<th>რაოდენობა</th>");
            out.write("<th>აღწერა</th>");
            out.write("</tr>");

            ArrayList<Ingredient> ins = food.getIngredients();
            out.write("<tr>");
            for (Ingredient in : ins) {
                out.write("<td>" + in.getName() + "</td>");
                out.write("<td>" + in.getQuantity() + " " + in.getType() + "</td>");
                out.write("<td>" + in.getComment() + "</td>");
                out.write("</tr>");
            }
            out.write("</table>");

            out.write("<br>");

            out.write("<h2>მომზადების წესი</h2>");

            out.write("<h3 class=\"cooking_way\">" + food.getCooking_way() + "</h3>");
        %>

    </body>
</html>
