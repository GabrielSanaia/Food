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


<html>
    <head>
        <title>მთავარი გვერდი</title>
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
        <div style="display: inline-block; margin-bottom: 19px;">
            <form>
                <div class="interface_main">
                    <button style="margin-right: 3%;" type="submit" class="button_1" name="action" value="button1" formaction="profile.jsp">ჩემი გვერდი</button>
                    <a type="submit" class="button_1" name="action" value="button1" href="Interface.jsp?page=1">მთავარი გვერდი</a>
                    <button type="submit" class="button_1" name="action" value="button1" formaction="addfood.jsp">კერძის დამატება</button>
                    <button type="submit" class="button_1" name="action" value="button1" formaction="addmenu.jsp">მენიუს დამატება</button>
                    <button type="submit" class="button_1" name="action" value="button1" formaction="chooseMenus.jsp">მენიუს შერჩევა</button>
                </div>
            </form>
            <form action="searchServlet" method="post" class="search_form">
                <input style="float:right" class="search_button" type="submit" value="ძებნა">
                <input class="search_1" style="float:right;font-size: 12px;" type="search" name="search" placeholder="კერძის ძებნა">
            </form>

            <div class="interface_2">
                <img src="Public/foto/interface.jpg" style="width:100%; height:250px;">
                <%
                    try {
                        String spageid = request.getParameter("page");
                        int pageid = Integer.parseInt(spageid);

                        if (session.getAttribute("check") == null) {

                            session.setAttribute("check", true);
                        } else {
                            session.setAttribute("check", false);
                        }

                        ArrayList<Food> foods = new ArrayList<Food>();
                        FoodDAO dao = new FoodDAOImpl();
                        boolean check = (boolean) session.getAttribute("check");
                        if (pageid == 1 && check == true) {
                            foods = dao.getAllFoods();
                            Collections.shuffle(foods);

                            session.setAttribute("check", false);
                        } else {
                            foods = (ArrayList<Food>) session.getAttribute("al");
                        }
                        if (pageid >= 2) {

                            foods = (ArrayList<Food>) request.getSession().getAttribute("al");
                        }

                        session.setAttribute("al", foods);

                        final int RESULTS_PER_PAGE = 4;

                        int to = pageid * RESULTS_PER_PAGE;
                        int from = to - RESULTS_PER_PAGE;
                        for (int i = from; i < to; i++) {

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

        </div>
        <div>
            <%                    out.write(" <form style=\"margin-left:45%;margin-right:45%;margin-bottom:15px;\" class=\"pagination\" >");
                    if (foods.size() >= 1) {
                        out.write("<a href=\"Interface.jsp?page=1\">1</a>");
                    }
                    if (foods.size() >= 5) {
                        out.write("<a type=\"submit\"  href=\"Interface.jsp?page=2\">2</a>");
                    }
                    if (foods.size() >= 9) {
                        out.write("<a href=\"Interface.jsp?page=3\">3</a>");
                    }
                    if (foods.size() >= 13) {
                        out.write("<a href=\"Interface.jsp?page=4\">4</a>");
                    }
                    if (foods.size() >= 17) {
                        out.write("<a href=\"Interface.jsp?page=5\">5</a>");
                    }
                    out.write("</form>");
                } catch (NullPointerException ex) {

                    out.write("<p> კერძები ვერ მოიძებნა! </p>");
                }

            %>
        </div>

        <style>
            .pagination a {
                background-color: #F1C54C;
                text-align: center;
                margin-bottom: 10px;
                color: black;
                margin-top: 10px;
                padding: 8px 16px;
                text-decoration: none;
                transition: background-color .3s;
            }

            .pagination a.active {
                background-color: #4CAF50;
                color: white;
            }
            .pagination a:hover:not(.active) {background-color: #ddd;}
        </style>
    </body>


</html>