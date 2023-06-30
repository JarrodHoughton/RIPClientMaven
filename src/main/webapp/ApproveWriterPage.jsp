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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css" rel="stylesheet">
    </head>
    <style>
        .other-space{
            margin-bottom: 100px;
        }
    </style>
    <body>
        <%
            Account user = (Account) request.getSession(false).getAttribute("user");
        %>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
            <div class="container">
                <a class="navbar-brand" href="http://localhost:8080/RIPClientMaven/EditorLandingPage.jsp">
                    <img src="book.svg" alt="Book Icon" class="me-2" width="24" height="24" style="filter: invert(1)">
                    READERS ARE INNOVATORS
                </a>
                <div class="d-flex align-items-center">
                    <%
                        if (user != null && (user.getUserType().equals("E") || user.getUserType().equals("A"))) {
                    %>
                    <a class="btn btn-primary ms-2" href="LoginController?submit=logout">Logout</a>
                    <%
                        }
                    %>
                </div>
            </div>
        </nav>
        <div class="other-space"></div>
        <%
            if (user != null && (user.getUserType().equals("E") || user.getUserType().equals("A"))) {
                String message = (String) request.getAttribute("message");
                List<Application> applications = (List<Application>) request.getAttribute("applications");
        %>
        <%
            if (message != null) {
        %>
        <div class="alert alert-primary mx-auto mt-5" role="alert">
            <h4 class="alert-heading"><%= message%></h4>
        </div>
        <%
            }
        %>
        <%
            if (applications != null && !applications.isEmpty()) {
        %>
        <div class="container mt-5">
            <div class="row mt-3">
                <h2>Approve Writer Applications</h2>
                <form action="ApplicationController" method="get">
                    <table class="table">
                        <thead class="table-dark">
                            <tr>
                                <th></th>
                                <th>Name</th>
                                <th>Surname</th>
                                <th>Motivation To Become Writer</th>
                            </tr>
                        </thead>
                        <%-- Iterate over the list of applications and display their details --%>
                        <%
                            for (Application app : applications) {
                        %>
                        <tbody>
                            <tr>
                                <td>
                                    <div class="form-check">
                                        <input name="readerIds" class="form-check-input" type="checkbox" value="<%=app.getReaderId()%>" id="<%=app.getReaderId()%>">
                                        <label class="form-check-label" for="<%=app.getReaderId()%>"></label>
                                    </div>
                                </td>
                                <td><%=app.getReaderName()%></td>
                                <td><%=app.getReaderSurname()%></td>
                                <td><%=app.getMotivation()%></td>
                            </tr>
                        </tbody>
                        <%
                            }
                        %>
                    </table>
                    <div class="btn-group">
                        <button type="submit" name="submit" value="approveApplications" class="btn btn-primary">Approve Applications</button>
                        <button type="submit" name="submit" value="rejectApplications" class="btn btn-primary">Reject Applications</button>
                    </div>
                </form>
            </div>
        </div>

        <%
        } else {
        %>
        <div class="alert alert-primary mx-auto my-auto" role="alert">
            <h4 class="alert-heading">There are currently applications to approve.</h4>
        </div>
        <%
            }
        %>
        <%
        } else {
        %>
        <div class="alert alert-primary mx-auto my-auto" role="alert">
            <h4 class="alert-heading">You are currently not logged in.</h4>
        </div>
        <%
            }
        %>
    </body>
</html>
