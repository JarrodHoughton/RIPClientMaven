<%-- 
    Document   : ManageEditors
    Created on : 23 Jun 2023, 09:21:55
    Author     : jarro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="Models.Editor"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%-- Retrieve the list of editors from the request attribute --%>
        <% 
            List<Editor> editors = (List<Editor>) request.getAttribute("editors");
        %>
        <h1>Hello World!</h1>

        <%-- Check if there are any editors available --%>
        <% if (editors != null) { %>
            <%-- Iterate over the list of editors and display their details --%>
            <% for (Editor editor : editors) { %>
                <%-- Display the editor's details here --%>
                <div>
                    <!-- Display the editor's details -->
                    <p>Name: <%= editor.getName() %></p>
                    <p>Email: <%= editor.getEmail() %></p>

                    <!-- Add an option to edit the editor's details or delete the editor's account -->
                    <a href="/editEditor?id=<%= editor.getId() %>">Edit</a>
                    <a href="/deleteEditor?id=<%= editor.getId() %>">Delete</a>
                </div>
            <% } %>
        <% } %>

        <%-- Add a form here to add a new editor to the system --%>
        <form action="/addEditor" method="post">
            <label for="name">Name:</label>
            <input type="text" name="name" id="name" required><br>

            <label for="email">Email:</label>
            <input type="email" name="email" id="email" required><br>

            <input type="submit" value="Add Editor">
        </form>
    </body>
</html>
