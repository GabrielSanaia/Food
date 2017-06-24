

<%@page import="Model.Ingredient"%>
<%@page import="Model.Food"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>
    <head>
        <link rel="stylesheet" href="Public/css/style.css" type="text/css"/>
        <link rel="icon" type="image/png" href="Public/foto/icon2.png" />
    </head>
    <body>
        <style>
            body{
                background: url("Public/foto/bg2.jpg");
            }
        </style>
        <div>
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

                    ArrayList<Food> searchFoods = (ArrayList) request.getAttribute("searchList");

                    for (int i = 0; i < searchFoods.size(); i++) {
                        int size = searchFoods.size();
                        if (i >= size) {
                            break;
                        }
                        Food food = searchFoods.get(i);

                        out.write("<form class=\"square_1\" action=\"interfaceServlet\" method=\"post\">");
                        out.write("<img src= " + "Public/photos/" + food.getImagePath() + " class=\"photo\" onerror=\"this.src='Public/foto/icon2.png'\" >");
                        out.write("<p class=\"head\"> " + food.getName() + " </p>");

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
                    if (searchFoods.isEmpty()) {
                        out.write("<p >კერძი ვერ მოიძებნა!</p>");
                    }


                %>
            </div>
        </div>
    </body>
</html>
