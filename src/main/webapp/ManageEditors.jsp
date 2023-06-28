<%-- 
    Document   : ManageEditors
    Created on : 23 Jun 2023, 09:21:55
    Author     : Jarrod
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="Models.*"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Manage Editors</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
        <link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
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
                <a class="navbar-brand" href="http://localhost:8080/RIPClientMaven/EditorLandingPage.jsp">
                    <img src="book.svg" alt="Book Icon" class="me-2" width="24" height="24" style="filter: invert(1)">
                    READERS ARE INNOVATORS
                </a>
            </div>
        </nav>
        <%  
            Account user = (Account) request.getSession(false).getAttribute("user");
            if(user != null && (user.getUserType().equals("E")||user.getUserType().equals("A"))) {
        %>
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
        <% 
            } else {
        %>
        <div class="alert alert-primary mt-5" role="alert">
            <h4 class="alert-heading">There are currently no editors on the system.</h4>
        </div>
        <%
            }
        %>

        <div class="mt-5">
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#editorForm">
                Add New Editor
            </button>
        </div>

        <%-- Add a form here to add a new editor to the system --%>
        <div class="modal fade" id="editorForm" aria-labelledby="editorForm" tabindex="-1" style="display: none;" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="editorForm">Add An Editor</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="ApplicationController" method="post">
                            <div class="form-floating">
                                <label for="name" class="col-form-label">First Name</label>
                                <input type="text" class="form-control" id="name" name="name">
                            </div>
                            <div class="form-floating">
                                <label for="surname" class="col-form-label">Last Name</label>
                                <input type="text" class="form-control" id="surname" name="surname">
                            </div>
                            <div class="form-floating">
                                <label for="email" class="col-form-label">Email</label>
                                <input type="email" class="form-control" id="email"name="email">
                            </div>
                            <div class="form-floating">
                                <label for="phoneNumber" class="col-form-label">Phone Number</label>
                                <input type="number" pattern="[0-9]{3}[0-9]{3}[0-9]{4}" maxlength="10" minlength="10" class="form-control" id="phoneNumber" name="phoneNumber">
                            </div>
                            <div class="form-floating">
                                <label for="password" class="col-form-label">Password</label>
                                <input type="password" class="form-control" id="password" name="password" placeholder="Password..." maxlength="8" minlength="16">
                            </div>
                            <div class="form-floating">
                                <label for="passwordRepeat" class="col-form-label">Repeat-Password</label>
                                <input type="password" class="form-control" id="password" name="passwordRepeat" placeholder="Repeat Password..." maxlength="8" minlength="16">
                            </div>
                            <input type="hidden" name="submit" value="addEditor">
                            <button type="submit" class="btn btn-primary mb-3">Submit Application</button>
                        </form>
                    </div>
                    <div class="modal-footer"></div>
                </div>
            </div>
        </div>
        <%
            } else {
        %>
        <div class="alert alert-primary" role="alert">
            <h4 class="alert-heading">You are currently not logged in.</h4>
        </div>
        <%
            }
        %>
    </body>
</html>
