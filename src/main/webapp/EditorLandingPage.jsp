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
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Editor Landing</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    </head>
    <style>
            html,
            body {
                height: 100%;
            }

            body {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
            }
    </style>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
            <div class="container">
                <a class="navbar-brand" href="http://localhost:8080/RIPClientMaven/">
                    <img src="book.svg" alt="Book Icon" class="me-2" width="24" height="24" style="filter: invert(1)">
                    READERS ARE INNOVATORS
                </a>
            </div>
        </nav>
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
