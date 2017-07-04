<%@page import="Model.Ingredient"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>კერძის დამატება</title>
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
        <form align="center" action="addFoodServlet" name="addFoodForm" method="post" enctype="multipart/form-data">

            <div class="addfood2">
                <button style="margin-right: 3%;" type="submit" class="button_1" name="action" value="button1" formaction="myProfile.jsp">ჩემი გვერდი</button>
                <a type="submit" class="button_1" name="action" value="button1" href="Interface.jsp?page=1">მთავარი გვერდი</a>
                <button type="submit" class="button_1" name="action" value="button1" formaction="addmenu.jsp">მენიუს დამატება</button>
                <button type="submit" class="button_1" name="action" value="button1" formaction="chooseMenus.jsp">მენიუს შერჩევა</button>
            </div>

            <div class="add">
                <h1>კერძის დამატება</h1>
                <h2>სახელი</h2>
                <input type="text" name="name" maxlength="29"/> <br>
                <h2>სურათი</h2>
                <input type="file" name="file" size="50" />
                <h2>სახეობა</h2>
                <select name="type" class="styled-select">
                    <option value="Food">საჭმელი</option>
                    <option value="Beverage">სასმელი</option>
                </select>
                <div id='div'>
                    <h2>ინგრედიენტები</h2>
                    <button onclick="addBoxes()" id="btn">ახალი ინგრედიენტი</button>
                    რაოდენობა
                    <select id="inQuantity" name="quantity"> 
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                    </select>

                    <br>
                    <br>
                    <script>

                        function getSelectedValue() {
                            var selector = document.getElementById("inQuantity");
                            var value = selector[selector.selectedIndex].value;
                            return value;
                        }
                        var counter = 1;

                        addBoxes = function () {

                            document.getElementById("btn").disabled = true;
                            for (var i = 0; i < getSelectedValue(); i++) {

                                var name = document.createElement("input");
                                var quantity = document.createElement("input");
                                quantity.type = "number";

                                var type = document.createElement("select");
                                var comment = document.createElement("textarea");
                                comment.id = "commentBox";

                                var opt1 = document.createElement("option");
                                var opt2 = document.createElement("option");
                                var br = document.createElement("br");

                                name.setAttribute("maxlength", 15);
                                comment.setAttribute("maxlength", 30);

                                name.name = "name_" + counter;
                                quantity.name = "quantity_" + counter;
                                type.name = "type_" + counter;
                                comment.name = "comment_" + counter;

                                name.placeholder = "სახელი";
                                quantity.placeholder = "რაოდენობა";
                                comment.placeholder = "კომენტარი";

                                opt1.value = "by_weight";
                                opt2.value = "by_retail";

                                opt1.innerHTML = "წონით";
                                opt2.innerHTML = "ცალობით";

                                type.appendChild(opt1);
                                type.appendChild(opt2);

                                document.getElementById("div").appendChild(name);
                                document.getElementById("div").appendChild(quantity);
                                document.getElementById("div").appendChild(type);
                                document.getElementById("div").appendChild(comment);
                                document.getElementById("div").appendChild(br);

                                name.style.marginRight = "5px";
                                quantity.style.marginRight = "5px";
                                type.style.marginRight = "5px";
                                comment.style.marginRight = "5px";
                                comment.style.marginTop = "5px";
                                comment.style.marginBottom = "15px";

                                br.style.marginBottom = "5px";
                                comment.cols = "60";

                                counter++;
                            }

                        }

                    </script>

                </div>
                <h2>რეცეპტი</h2>

                <textarea name="cookingway" rows="6" cols="60" id="text" placeholder="მომზადების წესი"></textarea>
                <button class="button_addfood" >დამატება</button>
                <%
                    if (request.getAttribute("addFoodFailed") != null && request.getAttribute("addFoodFailed") == Boolean.TRUE) {
                        out.write("<p style=\"color:red;\">გთხოვთ შეავსოთ ყველა ველი!</p>");
                    }
                %>
            </div>
        </form>
    </body>
</html>
