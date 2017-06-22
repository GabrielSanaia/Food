
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>პაროლის შეცვლა</title>
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
        <form id="changePassword_form" action="changePasswordServlet" method="post">
            <h2>პაროლის შეცვლა</h2>
            <br>
            <input type="password" name="oldPassword" placeholder="ახლანდელი პაროლი">
            <br>
            <br>
            <input type="password" name="newPassword" placeholder="ახალი პაროლი">
            <br>
            <br>
            <input type="password" name="repeatNewPassword" placeholder="გაიმეორეთ ახალი პაროლი">
            <br>
            <br>
            <input class="confirm_btn" type="submit" value="დადასტურება"/>

            <%
                    if (request.getAttribute("empty") != null && request.getAttribute("empty") == Boolean.TRUE) {
                        out.write("<p style=\"color:red;\">გთხოვთ შეავსოთ ყველა ველი!</p>");
                    }
                    if (request.getAttribute("error") != null && request.getAttribute("error") == Boolean.TRUE) {
                        out.write("<p style=\"color:red;\">ახლანდელი პაროლი არასწორია!</p>");
                    }
                    if (request.getAttribute("repeat") != null && request.getAttribute("repeat") == Boolean.TRUE) {
                        out.write("<p style=\"color:red;\">პაროლები არ ემთხვევა ერთმანეთს!</p>");
                    }

                
            %>
        </form>
    </body>
</html>