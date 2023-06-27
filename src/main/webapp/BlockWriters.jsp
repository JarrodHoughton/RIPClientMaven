<%-- 
    Document   : BlockWriters
    Created on : 26 Jun 2023, 17:40:49
    Author     : jarro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Models.*"%>
<%@page import="java.util.List"%>s
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
        <title>Block Writers</title>
        <style>
            html,
            body {
                height: 100%;
                background: #f7f7ff;
                margin-top:20px;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
            }
        </style>
    </head>
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
            String message = (String) request.getAttribute("message");
            List<Writer> writers = (List<Writer>) request.getAttribute("writers");
        %>
        <%
            if (user != null && (user.getUserType().equals("E") || user.getUserType().equals("A"))) {
        %>
        <%
            if (message != null) {
        %>
        <div class="alert alert-success" role="alert">
            <h4 class="alert-heading"><%= message %></h4>
        </div> 
        <%
            }
        %>
        <div class="container">
            <h1>Block Writers</h1>
            <p>Select writers to block below.</p>
            <%
                if (writers != null) {
            %>
            <div class="container">
                <form action="WriterController" method="post">
                    <div class="container mt-3">
                        <h2>Writers</h2>
                        <table class="table">
                            <thead class="table-dark">
                                <tr>
                                    <th></th>
                                    <th>First Name</th>
                                    <th>Last Name</th>
                                    <th>Email</th>
                                    <th>Phone Number</th>
                                    <th>Submitted Stories</th>
                                </tr>
                            </thead>
                            <%
                                    for (Writer writer:writers) {
                            %>
                            <tbody>
                                <tr>
                                    <td>
                                        <input class="form-check-input me-1" type="checkbox" name="<%=writer.getId()%>" value="<%=writer.getId()%>" id="<%=writer.getId()%>">
                                        <label class="form-check-label" for="<%=writer.getId()%>">
                                    </td>
                                    <td><%=writer.getName()%></td>
                                    <td><%=writer.getSurname()%></td>
                                    <td><%=writer.getEmail()%></td>
                                    <td><%=writer.getPhoneNumber()%></td>
                                    <td><%=writer.getSubmittedStoryIds().size()%></td>
                                </tr>
                            </tbody>
                            <%
                                    }
                            %>
                        </table>
                    </div>
                    <input type="hidden" id="id" name="submit" value="blockWriters">
                    <input type="submit" class="btn btn-primary px-4" value="Block Writers">
                </form>
            </div>
        </div>
        <%
            } else {
        %>
        <div class="alert alert-info" role="alert">
            <h4 class="alert-heading">No writers are currently on the system.</h4>
        </div> 
        <%
            }
        %>
        <%
            } else {
        %>
        <div class="alert alert-danger" role="alert">
            <h4 class="alert-heading">You are not currently logged in.</h4>
        </div> 
        <%
            }
        %>
    </body>
</html>
