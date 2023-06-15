<%-- 
    Document   : ReadLandingPage
    Created on : 14 Jun 2023, 14:42:38
    Author     : jarro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Models.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reader Landing Page</title>
    </head>
    <body>
        <% 
            Account user = (Account) request.getAttribute("user");
            Reader reader = null;
            Writer writer = null;
            if  (user!=null && user.getUserType().equals("R")) {
                reader = (Reader) user;
            }
            
            if  (reader!=null) {
        %>
        <h4><%=reader%></h4>
        <%  }%>
        <h1>You have logged in as a Reader.</h1>
    </body>
</html>
