<%-- 
    Document   : ManageEditors
    Created on : 23 Jun 2023, 09:21:55
    Author     : Jarrod
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="Models.Editor"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Manage Editors</title>
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
        <%-- Retrieve the list of editors from the request attribute --%>
        <% 
            List<Editor> editors = (List<Editor>) request.getAttribute("editors");
            String message = (String) request.getAttribute("message");
        %>
        
        <%
            if (message != null) {
        %>
        <div class="alert alert-info" role="alert">
            <h4 class="alert-heading"><%= message %></h4>
        </div>
        <%
            }
        %>
        <h1>Manage Editors</h1>

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
                    <a href="EditorController?submit=goToUpdateEditorPage&editorId=<%= editor.getId() %>">Edit</a>
                    <a href="EditorController?submit=deleteEditor&editorId=<%= editor.getId() %>">Delete</a>
                </div>
            <% } %>
        <% } %>

        <%-- Add a form here to add a new editor to the system --%>
        <form action="EditorController" method="post">
            <label for="name">Name:</label>
            <input type="text" name="name" id="name" required><br>

            <label for="surname">Surname:</label>
            <input type="text" name="surname" id="surname" required><br>
            
            <label for="email">Email:</label>
            <input type="email" name="email" id="email" required><br>
            
            <label for="password">Password:</label>
            <input type="password" name="password" id="password" maxlength="16" minlength="8" required><br>

            <label for="phoneNumber">Phone Number:</label>
            <input type="tel" name="phoneNumber" id="phoneNumber" pattern="[0-9]{3}[0-9]{3}[0-9]{4}" required><br>
            
            <input type="hidden" name="submit" value="addEditor">
            <input type="submit">
        </form>
    </body>
</html>
