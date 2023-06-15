<%-- 
    Document   : index
    Created on : 13 Jun 2023, 14:26:23
    Author     : jarro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Models.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>RIP Landing Page</title>
    <body>
        <%
            String message = (String) request.getAttribute("message");
            Reader user = (Reader) request.getAttribute("user");
            if  (message!=null) {
        %>
        <h1><%=message%></h1>
        <%} if(user!=null) {%>
        <h3><%=user.toString()%></h3>
        <%}%>
        <div>Enter Login:</div>
        <form action="LoginController" method="get">
            Email:<input type="email" name="email" required><br>
            Password:<input type="password" name="password" maxlength="16" minlength="8" required><br>
            <input type="submit" value="login" name="submit"><br>
        </form>
        <br>
        <a href="register.jsp">Sign Up!</a>
    </body>
</html>