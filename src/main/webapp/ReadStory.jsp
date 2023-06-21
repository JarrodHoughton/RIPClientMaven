<%-- 
    Document   : ReadStory
    Created on : 21 Jun 2023, 11:15:52
    Author     : faiza
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Models.*"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Full Story Page</title>
    </head>
    <body>
        <%
            Story story = (Story) request.getAttribute("story");
        %>
        <h1><%=story.getTitle()%></h1>
        <p><%=story.getContent()%></p>
        
    </body>
</html>
