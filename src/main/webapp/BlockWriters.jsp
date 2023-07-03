<%-- 
    Document   : BlockWriters
    Created on : 26 Jun 2023, 17:40:49
    Author     : Jarrod
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Models.*"%>
<%@page import="java.util.List"%>
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
            .other-space{
                margin-bottom: 100px;
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
            String searchValue = (String) request.getAttribute("searchValue");
            Integer pageNumber = (Integer) request.getAttribute("pageNumber");
            Integer offsetAmount = 10;
        %>
        <%
            if (user != null && (user.getUserType().equals("E") || user.getUserType().equals("A"))) {
        %>
        <div class="container mt-5">
            <%
                if (message != null) {
            %>
            <div class="other-space"></div>
            <div class="alert alert-primary mt-5" role="alert">
                <h4 class="alert-heading"><%= message%></h4>
            </div> 
            <%
                }
            %>
            <h1>Block Writers</h1>
            <p>Select writers to block below.</p>
            <%
                if (writers != null) {
            %>
            <div class="container">
                <form  action="WriterController" method="post">
                    <input class="form-control me-2" type="search" placeholder="Search for writer..." aria-label="Search" name="searchValue" required>
                    <input type="hidden" name="submit" value="searchForWriter">
                </form>
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
                            <tbody>
                                <%
                                    for (Writer writer : writers) {
                                %>
                                <tr>
                                    <td>
                                        <input class="form-check-input me-1" type="checkbox" name="writerIds" value="<%=writer.getId()%>" id="<%=writer.getId()%>">
                                        <label class="form-check-label" for="<%=writer.getId()%>">
                                    </td>
                                    <td><%=writer.getName()%></td>
                                    <td><%=writer.getSurname()%></td>
                                    <td><%=writer.getEmail()%></td>
                                    <td><%=writer.getPhoneNumber()%></td>
                                    <td><%=writer.getSubmittedStoryIds().size()%></td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                    <input type="hidden" id="id" name="submit" value="blockWriters">
                    <input type="submit" class="btn btn-primary px-4" value="Block Writers">
                </form>
            </div>
            <div class="btn-group mt-5 mb-5 mx-auto">
                <%
                    if (pageNumber != null && pageNumber > 0) {
                %>
                <a class="btn btn-primary ms-2" href="WriterController?submit=nextPageOfWriters<% if (searchValue != null) {%>&searchValue=<%=searchValue%><%}%>&currentId=<%= writers.get(0).getId()%>&pageNumber=<%=(pageNumber - 1)%>&next=false">Previous</a>
                <%
                    }
                %>
                <%
                    if (writers.size() == offsetAmount) {
                %>
                <a class="btn btn-primary ms-2" href="WriterController?submit=nextPageOfWriters<% if (searchValue != null) {%>&searchValue=<%=searchValue%><%}%>&currentId=<%= writers.get(writers.size() - 1).getId()%>&pageNumber=<%=(pageNumber + 1)%>&next=true">Next</a>
                <%
                    }
                %>
            </div>
        </div>
    </div>
    <%
    } else if (searchValue != null) {
    %>
    <div class="alert alert-info mt-5" role="alert">
        <h4 class="alert-heading">No writers were found for: "<%= searchValue%>".</h4>
    </div> 
    <%
    } else {
    %>
    <div class="alert alert-info mt-5" role="alert">
        <h4 class="alert-heading">No writers were found.</h4>
    </div> 
    <%
        }
    %>
    <%
    } else {
    %>
    <div class="alert alert-danger mt-5" role="alert">
        <h4 class="alert-heading">You are not currently logged in.</h4>
    </div> 
    <%
        }
    %>
</body>
</html>
