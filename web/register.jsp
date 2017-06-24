<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <title>რეგისტრაცია</title>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="Public/css/style.css" type="text/css"/>
        <link rel="icon" type="image/png" href="Public/foto/icon2.png" />
        <style>
            body{
                background: url("Public/foto/reg_bground.jpg");
            }
        </style>
    </head>
    <body>
        <img src="Public/foto/icon.png" alt="logo" style="width:140px;height:140px;">

        <div class="register" style="height: 100%;">

            <h1 id=registrationlabel >რეგისტრაცია</h1> <br>
            <form align="center" class="center" action="RegisterServlet" name="registerForm" method="post" enctype="multipart/form-data">
                <h3>სახელი:</h3>
                <input id="1" type="text" name="name" /> <br>
                <h3>გვარი:</h3>
                <input type="text" name="surname" /> <br>
                <h3>მომ. სახ. :</h3>
                <input type="text" name="username" /> <br>
                <h2>სურათი</h2>
                <input type="file" name="file" size="50" /> <br>
                <h3>პაროლი:</h3>
                <input type="password" name="password" /> <br>
                <h3>სქესი:</h3>
                <select name="gender" class="styled-select">
                    <option value="male">მამრობითი</option>
                    <option value="female">მდედრობითი</option>
                </select>

                <button class="reg_button">რეგისტრაცია</button>

                <%
                    if (request.getAttribute("registrationFailed") != null && request.getAttribute("registrationFailed") == Boolean.TRUE) {
                        out.write("<p style=\"color:red;\">გთხოვთ შეავსოთ ყველა ველი!</p>");
                    }
                %>
            </form>      
        </div>
    </body>
</html>