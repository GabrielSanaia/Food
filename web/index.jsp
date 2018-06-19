<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <title>შესვლა</title>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="Public/css/style.css" type="text/css"/>
        <link rel="icon" type="image/png" href="Public/foto/icon2.png" />
        <style>
            body{
                background: url("Public/foto/bground.png")  no-repeat;
                -webkit-background-size: cover;
                -moz-background-size: cover;
                -o-background-size: cover;
                background-size: cover;      
            }
        </style>
    </head>

    <body>
        <div class="loginForm">
            <h2>შესვლა</h2>
            <form action="LoginServlet" method="post">
                <input type="text" name="username" placeholder="შეიყვანეთ მომ.სახ."><br><br>
                <input type="password" name="password" placeholder="შეიყვანეთ პაროლი"><br><br>
                <button class="button">შესვლა</button>

                <a href="register.jsp"> რეგისტრაცია </a>
                <%
                    if (request.getAttribute("isLoginFieldEmpty") != null && request.getAttribute("isLoginFieldEmpty") == Boolean.TRUE) {
                        out.write("<p style=\"color:red;\">გთხოვთ შეავსოთ ყველა ველი!</p>");
                    } else if (request.getAttribute("loginFailed") != null && request.getAttribute("loginFailed") == Boolean.TRUE) {
                        out.write("<p style=\"color:red;\">სახელი ან პაროლი არასწორია!</p>");
                    }
                    %>
            </form>
        </div>
    </body>
</html>