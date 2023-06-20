<%-- 
    Document   : ApproveWriterPage
    Created on : 20 Jun 2023, 14:53:44
    Author     : faiza
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Models.*"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Approve Writer</title>
    </head>
    <body>
        <%
            String message = (String) request.getAttribute("message");
            List<Application> applications = (List<Application>) request.getAttribute("applications");
            if  (message!=null) {
        %>
        <h3><%=message%></h3>
        <%
            }
        %>
        <h2>Approve Writer Applications</h2>
        <%
            if  (applications!=null) {
                for (Application app:applications) {
        %>
            <input type="radio" name="<%=app.getReaderId()%>" value="<%=app.getMotivation()%>" />
        <%      
                }
            }
        %>
    </body>
</html>
