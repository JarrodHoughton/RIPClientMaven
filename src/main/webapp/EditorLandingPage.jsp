<%-- 
    Document   : EditorLandingPage
    Created on : 14 Jun 2023, 14:42:50
    Author     : jarro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Editor Landing</title>
    </head>
    <body>
        <a href="StoryController?submit=goToEditStories">
            <button>Edit Stories</button>
        </a>
        <br/>
        <a href="ApplicationController?submit=getWriterApplications">
            <button >Approve Writers</button>
        </a>
        <br/>
        <button>Get Data Report</button><br/>
        <button>Manage Editors</button><br/>
    </body>
</html>
