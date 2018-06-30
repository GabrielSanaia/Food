<%-- 
    Document   : foodAddedSuccesfully
    Created on : Jun 28, 2018, 8:04:16 PM
    Author     : Gabriel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setDateHeader("Expires", -1);
%>
<html>
    
    <head>
        <title>კერძი დამატებულია!</title>
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
        <form>
        <div id="changePassword_div">
                    <button style="margin-right: 3%;" type="submit" class="button_1" name="action" value="button1" formaction="myProfile.jsp">ჩემი გვერდი</button>
                    <a type="submit" class="button_1" name="action" value="button1" href="Interface.jsp?page=1">მთავარი გვერდი</a>
                </div>
        </form>

        <form method="get" align="center" action="">
            <div class="succesfullAddition">
                <br>
                <a style="">კერძი დამატებულია!</a>  
                <br>                
                <br>
            </div>
        </form>
    </body>
</html>
