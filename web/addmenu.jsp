<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>მენიუს დამატება</title>
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
        <form>
         <div class="interface_1">
              <button style="margin-right: 3%;" type="submit" class="button_1" name="action" value="button1" formaction="myProfile.jsp">ჩემი გვერდი</button>
               <a type="submit" class="button_1" name="action" value="button1" href="Interface.jsp?page=1">მთავარი გვერდი</a>
                <button type="submit" class="button_1" name="action" value="button1" formaction="addfood.jsp">კერძის დამატება</button>
                <button type="submit" class="button_1" name="action" value="button1" formaction="chooseMenus.jsp">მენიუს შერჩევა</button>
            </div>
        </form>
        <form align="center"  action="addMenuServlet" name="addMenuForm" method="post">
            <div class="add">
                <h1>მენიუს დამატება</h1>
                <h2>სახელი</h2>
                <input type="text" name="name"/>
                <br>
                <h2>მენიუს ტიპი</h2>
                <select name="type" class="styled-select">
                    
                    <option value="test">test</option>
                </select>
                <h2>სასმელი</h2>
                <select name="beverage" class="styled-select">
                    <option value="water">წყალი</option>
                    <option value="wine">ღვინო</option>
                    <option value="soda">გაზიანი სასმელი</option>
                </select>
                <div id='div'>
                    <br>
                    <br>

                </div>
                <button class="button_addfood">კერძების არჩევა</button>
                <br>
                <%
                    if (request.getAttribute("addMenuFailed") != null && request.getAttribute("addMenuFailed") == Boolean.TRUE) {
                        out.write("<p style=\"color:red;\">გთხოვთ შეავსოთ ყველა ველი!</p>");
                    }
                    else if(request.getAttribute("chooseFoodsFailed") != null && request.getAttribute("chooseFoodsFailed") == Boolean.TRUE) {
                        out.write("<p style=\"color:red;\">გთხოვთ აირჩიოთ სამზე მეტი კერძი!</p>");
                    }
                %>
            </div>
        </form>
    </body>
</html>