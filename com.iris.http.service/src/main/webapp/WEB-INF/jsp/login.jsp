<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width; initial-scale=1.0; maximum-scale=1.0;">
        <title>Welcome to I.R.I.S</title>
        <c:url value="/resources/css/style.css" var="cssURL" />  
        <link rel="stylesheet" type="text/css" media="screen" href="${cssURL}" />  
    </head>
    <body>
        <div id="login">
            <form action="j_spring_security_check" method="post">
                <input type="text" placeholder="username" name="j_username">
                <hr>
                <input type="password" placeholder="password" name="j_password">
                <input type="submit" value="Log In">
            </form>
            <p><a href="#">Forgot your password?</a> | <a href="#">Register</a></p>
            <hr>
            <p>Copyright by <a href="www.botrepo.com">@gianksp</a> | <a href="www.botrepo.com">View the article</a></p>
        </div>
    </body>
</html>