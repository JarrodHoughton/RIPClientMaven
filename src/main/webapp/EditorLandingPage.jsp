<%-- 
    Document   : EditorLandingPage
    Created on : 14 Jun 2023, 14:42:50
    Author     : Jarrod
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Models.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Editor Landing</title>
    </head>
    <body>
        <%
            Editor editor = (Editor) request.getSession(false).getAttribute("user");
            String message = (String) request.getAttribute("message");
            
            if (message != null) {
        %>
        <h3><%=message%></h3>
        <%
            }
        %>
        <a href="StoryController?submit=goToSelectStoriesToEdit">
            <button>Submitted Stories</button>
        </a>
        <br/>
        <a href="ApplicationController?submit=getWriterApplications">
            <button >Writer Applications</button>
        </a>
        <br/>
        <button>Get Data Report</button><br/>
        
        <%
            if  (editor != null && editor.getUserType().equals("A")) {
        %>
        <a href="EditorController?submit=manageEditors">
            <button>Manage Editors</button><br/>
        </a>
        <%
            }
        %>
    </body>
</html>
