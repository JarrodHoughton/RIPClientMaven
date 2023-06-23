<%-- 
    Document   : ManageEditors
    Created on : 23 Jun 2023, 09:21:55
    Author     : jarro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            List<Editor> editors = (List<Editor>) request.getAttribute("editors");
        %>
        <h1>Hello World!</h1>

        <%
            if  (editors != null) {
                for (Editor editor : editors) {
        %>
        <!-- Display all the editors here and add an option to edit and editor's details or delete the editor's account -->
        <%
                }
        %>
        <%
            }
        %>
        <!-- Add a form here to add an editor to the system -->
    </body>
</html>
