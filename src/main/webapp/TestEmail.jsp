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
        <h1>Enter a test email:</h1>
        <form action="MailController">
            <textarea id="email" name="email" rows="5" cols="10"></textarea><br>
            <input type="submit" value="sendVerificationEmail" name="submit">
        </form>
    </body>
</html>
