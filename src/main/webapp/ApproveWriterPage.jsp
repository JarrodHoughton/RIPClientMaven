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
            if  (applications!=null && !applications.isEmpty()) {
        %>
        <form action="ApplicationController" method="get">
            <%
                    for (Application app:applications) {
            %>
            <input type="radio" id="<%=app.getReaderId()%>" name="readerId" value="<%=app.getReaderId()%>" />
            <label for="<%=app.getReaderId()%>"><%=app.getMotivation()%></label><br>
            <%      
                    }
            %>
            <br><br>
            <label for="approve">Approve Application</label>
            <input type="submit" id="approve" name="submit" value="approveApplication">
            <br>
            <label for="reject">Approve Application</label>
            <input type="submit" id="reject" name="submit" value="rejectApplication">
        </form>
        <%
            } else {
        %>
        <div>No applications to approve.</div>
        <%
           }
        %>
    </body>
</html>
