<%-- 
    Document   : TestEmail
    Created on : 15 Jun 2023, 11:51:20
    Author     : jarro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Testing Email</title>
    </head>
    <body>
        <%
            String message = (String) request.getAttribute("message");
            if  (message != null) {
        %>
        <h3><%=message%></h3>
        <%}%>
        <h1>Enter a test email:</h1>
        <form action="MailController">
            Subject:<br>
            <input type="text" name="subject"><br>
            Body:<br>
            <textarea id="email" name="content" rows="5" cols="50"></textarea><br>
            Recipient:<br>
            <input type="text" name="email"><br>
            <input type="submit" value="sendVerificationEmail" name="submit">
        </form>
    </body>
</html>
