<%@page import="Dao.FoodDAOImpl"%>
<%@page import="java.util.Collections"%>
<%@page import="Dao.FoodDAO"%>
<%@page import="Model.Food"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setDateHeader("Expires", -1);
%>
<html>
    <head>
        <title>მენიუს შერჩევა</title>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="Public/css/style.css" type="text/css"/>
        <link rel="icon" type="image/png" href="Public/foto/icon2.png" />
        <style>
            body{
                background: url("Public/foto/bg1.jpg");
            }
        </style> 
    </head>
    <body>
        <div class="interface_2">
            <img src="Public/foto/interface.jpg" style="width:100%; height:250px;">
            <%
                ArrayList<Food> searchFoods = (ArrayList) request.getAttribute("searchList");
                String name = (String) request.getAttribute("name");
                String type = (String) request.getAttribute("type");
                String beverage = (String) request.getAttribute("beverage");

                if (searchFoods == null) {
                    ArrayList<Food> foods = new ArrayList<Food>();
                    FoodDAO dao = new FoodDAOImpl();
                    foods = dao.getAllFoods();
                    Collections.shuffle(foods);

                    for (int i = 0; i < 20; i++) {
                        int size = foods.size();
                        if (i >= size) {
                            break;
                        }
                        out.write("<form action=\"chooseFoodsServlet\" method=\"post\">");
                        Food food = foods.get(i);

                        out.write("<div class=\"square_3\">");
                        out.write("<img src= \"" + "Public/photos/" + food.getImagePath() + "\" onerror=\"this.src='Public/foto/icon2.png'\" class=\"photo_2\" >");
                        out.write("<h2 class=\"choosefoods_name\"> " + food.getName().toString() + " </h2>");
                        out.write("<input type=\"checkbox\" class=\"checkbox_1\" name=\"box\" value=\"" + food.getId() + "\">");
                        out.write("</div>");
                    }

                    out.write("<div>");
                    out.write("<input type=\"submit\" value=\"არჩევა\" onclick=\"(getCheckedCheckboxesFor('box'));\" class=\"button_choose\">");
                    out.write("<input id=\"values\" name=\"values\" type=\"hidden\"/>");
                    out.write("<input type=\"hidden\" value=\"" + name + "\" name=\"name\"/>");
                    out.write("<input type=\"hidden\" value=\"" + type + "\" name=\"type\"/>");
                    out.write("<input type=\"hidden\" value=\"" + beverage + "\" name=\"beverage\"/>");
                    out.write("</div>");

                    request.setAttribute("name", name);
                    request.setAttribute("type", type);
                    request.setAttribute("beverage", beverage);
                    out.write("</form>");

                }
            %>
            <script>
                function getCheckedCheckboxesFor(checkboxName) {
                    var checkboxes = document.querySelectorAll('input[name="' + checkboxName + '"]:checked'), values = [];
                    Array.prototype.forEach.call(checkboxes, function (el) {
                        values.push(el.value);
                    });
                    document.getElementById("values").value = values;
                    return values;
                }

            </script>
        </div>
    </body>
</html>