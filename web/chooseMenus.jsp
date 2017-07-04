<%@page import="java.io.IOException"%>
<%@page import="java.util.Collections"%>
<%@page import="Model.Food"%>
<%@page import="Model.Menu"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="processor.MenuProcessor"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <title>მენიუს შერჩევა</title>
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
        <div>
            <form>
                <div class="interface_main">
                    <button style="margin-right: 3%;" type="submit" class="button_1" name="action" value="button1" formaction="myProfile.jsp">ჩემი გვერდი</button>
                   <a type="submit" class="button_1" name="action" value="button1" href="Interface.jsp?page=1">მთავარი გვერდი</a>
                    <button type="submit" class="button_1" name="action" value="button1" formaction="addfood.jsp">კერძის დამატება</button>
                    <button type="submit" class="button_1" name="action" value="button1" formaction="addmenu.jsp">მენიუს დამატება</button>
                </div>
            </form>
            <form action="searchMenusServlet" method="post" class="search_form">
                <input  class="search_button" type="submit" value="ძებნა">
                <input class="search_1" style="float:right;font-size: 12px;" type="search" name="search" placeholder="მენიუს ძებნა">
            </form>
            <div class="interface_2">
                <img src="Public/foto/interface.jpg" style="width:100%; height:250px;">
            </div>  

            <%

                ArrayList<Menu> searchedMenus = (ArrayList<Menu>) request.getAttribute("searchList");

                if (searchedMenus == null) {
                    ArrayList<Menu> menus = MenuProcessor.getAllMenus();
                    Collections.shuffle(menus);
                    for (int i = 0; i < 6; i++) {
                        int size = menus.size();
                        if (i >= size || menus.size() < 1) {
                            break;
                        }

                        Menu menu = menus.get(i);

                        out.write("<form id=\"form\">");
                        out.write("<div class=\"menu_div\">");
                        out.write("<div class=\"photos_div\">");

                        out.write("<img src=\"" + "Public/photos/" + menu.getFoods().get(0).getImagePath() + "\" class=\"menu_photo\" onerror=\"this.src='Public/foto/icon2.png'\" >");
                        out.write("<img src=\"" + "Public/photos/" + menu.getFoods().get(1).getImagePath() + "\" class=\"menu_photo\" onerror=\"this.src='Public/foto/icon2.png'\" >");
                        out.write("<br>");
                        out.write("<img src=\"" + "Public/photos/" + menu.getFoods().get(2).getImagePath() + "\" class=\"menu_photo\" onerror=\"this.src='Public/foto/icon2.png'\" >");
                        out.write("<img src=\"" + "Public/photos/" + menu.getFoods().get(3).getImagePath() + "\" class=\"menu_photo\" onerror=\"this.src='Public/foto/icon2.png'\" >");

                        out.write("</div>");

                        out.write("<p id=\"menu_name\">" + menu.getName() + "</p>");
                        out.write("<br>");

                        String names = "";

                        ArrayList<Food> foods = menu.getFoods();
                        for (Food f : foods) {
                            names += f.getName() + ",";

                        }
                        names = names.substring(0, names.length() - 1);

                        out.write("<p class=\"text_menu\">კერძები: " + " " + names + "</p>");
                        out.write("<p id=\"text_menu\">ტიპი: " + menu.getType().toString() + "</p>");
                        out.write("<p class=\"text_menu\">სასმელი: " + menu.getBeverage().toString() + "</p>");
                        out.write("</div>");
                        out.write("</form>");
                    }
                } else if (searchedMenus.isEmpty()) {
                    out.write("<p class=\"foodnotfoundlabel\">მენიუ ვერ მოიძებნა</p>");
                } else {

                    for (int i = 0; i < searchedMenus.size(); i++) {

                        Menu menu = searchedMenus.get(i);

                        out.write("<form id=\"form\">");
                        out.write("<div class=\"menu_div\">");
                        out.write("<div class=\"photos_div\">");

                        out.write("<img src=\"" + "Public/photos/" + menu.getFoods().get(0).getImagePath() + "\" class=\"menu_photo\" onerror=\"this.src='Public/foto/icon2.png'\" >");
                        out.write("<img src=\"" + "Public/photos/" + menu.getFoods().get(1).getImagePath() + "\" class=\"menu_photo\" onerror=\"this.src='Public/foto/icon2.png'\" >");
                        out.write("<br>");
                        out.write("<img src=\"" + "Public/photos/" + menu.getFoods().get(2).getImagePath() + "\" class=\"menu_photo\" onerror=\"this.src='Public/foto/icon2.png'\" >");
                        out.write("<img src=\"" + "Public/photos/" + menu.getFoods().get(3).getImagePath() + "\" class=\"menu_photo\" onerror=\"this.src='Public/foto/icon2.png'\" >");

                        out.write("</div>");

                        out.write("<p id=\"menu_name\">" + menu.getName() + "</p>");
                        out.write("<br>");

                        String names = "";

                        ArrayList<Food> foods = menu.getFoods();
                        for (Food f : foods) {
                            names += f.getName() + ",";

                        }
                        names = names.substring(0, names.length() - 1);

                        out.write("<p class=\"text_menu\">კერძები: " + " " + names + "</p>");
                        out.write("<p id=\"text_menu\">ტიპი: " + menu.getType().toString() + "</p>");
                        out.write("<p class=\"text_menu\">სასმელი: " + menu.getBeverage().toString() + "</p>");
                        out.write("</div>");
                        out.write("</form>");

                    }
                }


            %>
        </div>
    </body>
</html>