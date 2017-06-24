<%@page import="Model.User"%>
<%@page import="Dao.UserDAO"%>
<%@page import="Dao.UserDAOImpl"%>
<%@page import="javax.websocket.OnError"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.Collection"%>
<%@page import="org.apache.catalina.ha.backend.CollectedInfo"%>
<%@page import="Model.Ingredient"%>
<%@page import="org.apache.jasper.JasperException"%>
<%@page import="java.io.IOException"%>
<%@page import="Dao.FoodDAOImpl"%>
<%@page import="Dao.FoodDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.Food"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
    UserDAO usdao = new UserDAOImpl();
    User user = usdao.getUserById((int) request.getSession().getAttribute("id"));
    out.write("<title>" + user.getName() + " " + user.getSurName() + "</title>");
%>
<html>
    <head>
        <title></title>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="Public/css/style.css" type="text/css"/>
        <link rel="icon" type="image/png" href="Public/foto/icon2.png" />
        <style>
            body{
                background: url("Public/foto/bg2.jpg");
            }
        </style>
    </head>
    <body style="background-color: white;">

        <form>
            <div class="interface_main" style="width: 100%;">
                <button type="submit" class="button_1" name="action" value="button1" formaction="Interface.jsp">მთავარი გვერდი</button>
                <button type="submit" class="button_1" name="action" value="button1" formaction="addfood.jsp">კერძის დამატება</button>
                <button type="submit" class="button_1" name="action" value="button1" formaction="addmenu.jsp">მენიუს დამატება</button>
                <button type="submit" class="button_1" name="action" value="button1" formaction="chooseMenus.jsp">მენიუს შერჩევა</button>
                <form action="logoutServlet" method="post">
                    <button style="margin-left: 15px;" type="submit" class="button_1" name="action" value="button1" formaction="index.jsp">გასვლა</button>
                </form> 
            </div>
        </form>


        <div class="interface_user">
            <%
                out.write("<h2> მომხმარებელი:" + " " + user.getName() + " " + user.getSurName() + " </h2>");
            %>
            <div style="float: left; display: inline-block;">
                <%
                    out.write("<img class=\"user_phoho\" src =\" " + "Public/photos/" + user.getImagePath() + " \"/>");
                    out.write("<div style=\"float:left; margin-left:130px; margin-top:27px;\">");
                    out.write("<h3 style=\" \" > მეტსახელი :" + user.getUsername() + "</h3>");

                    out.write("<h3>" + " სქესი:" + user.getGender().toString() + "</h3>");
                    out.write("</div>");
                %>
                
            </div>
            <form id="div2" action="changePasswordServlet"  method="post">
                <button class="password_button" id="button" formaction="changePassword.jsp">პაროლის შეცვლა</button>

            </form>
            <br><br>
            <br>
            <br>
            <br>  
            <br><br><br><br><br>

            <%
                out.write("<br>");
                out.write("<br>");
                out.write("<br>");
                FoodDAO dao = new FoodDAOImpl();

                ArrayList<Food> foods = dao.getFoodsByUserId((int) request.getSession().getAttribute("id"));
                if (!foods.isEmpty()) {
                    out.write("<h2>მომხმარებლის დამატებული კერძები</h2>");
                } else {
                    out.write("<h3>მომხმარებლის არ აქვს დამატებული კერძი</h3>");
                }
                Collections.shuffle(foods);

                for (int i = 0; i < foods.size(); i++) {
                    int size = foods.size();
                    if (i >= size) {
                        break;
                    }
                    Food food = foods.get(i);

                    out.write("<form class=\"square_1\" action=\"interfaceServlet\" method=\"post\">");
                    out.write("<img src= \"" + "Public/photos/" + food.getImagePath() + "\" class=\"photo\" onerror=\"this.src='Public/foto/icon2.png'\">");

                    out.write("<p class=\"head\"> " + food.getName().toString() + " </p>");

                    out.write("<p class=\"text_div\">" + "ტიპი: " + food.getFoodtype().toString() + " </p>");
                    String ingredient_names = "";
                    ArrayList<Ingredient> ins = food.getIngredients();
                    for (Ingredient in : ins) {
                        ingredient_names += in.getName() + ",";
                    }
                    ingredient_names = ingredient_names.substring(0, ingredient_names.length() - 1);
                    out.write("<p class=\"text_div2\" display:inline>" + "ინგრედიენტები: " + ingredient_names + "</p>");
                    out.write("<input name=\"foodId\" type=\"hidden\" value=\"" + food.getId() + "\"/>");
                    out.write("<button class=\"div_button\" maxlength=\"10\"  >ვრცლად</button>");
                    out.write("</form>");

                }
            %>
        </div>

    </body>
</html> 