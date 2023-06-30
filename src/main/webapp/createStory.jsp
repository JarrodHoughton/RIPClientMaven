<%-- 
    Document   : createStory
    Created on : 15 Jun 2023, 13:41:37
    Author     : faiza
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Models.*"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Story</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
        <link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </head>
    <style>
        .other-space{
            margin-bottom: 100px;
        }
    </style>
    <body>
        <%
            Writer user = (Writer) request.getSession(false).getAttribute("user");
            String homePageUrl = "http://localhost:8080/RIPClientMaven/";
            if (user != null && (user.getUserType().equals("R") || user.getUserType().equals("W"))) {
                homePageUrl += "ReaderLandingPage.jsp";
            } else {
                homePageUrl += "index.jsp";
            }
        %>
        <div id="navbar-container">
            <!-- Navbar -->
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
                <div class="container">
                    <a class="navbar-brand" href="<%=homePageUrl%>">
                        <img src="book.svg" alt="Book Icon" class="me-2" width="24" height="24"
                             style="filter: invert(1)">
                        READERS ARE INNOVATORS
                    </a>
                    <div class="d-flex align-items-center">
                        <a class="btn btn-primary ms-2" href="LoginController?submit=logout">Logout</a>
                    </div>
                </div>
            </nav>
        </div>
        <%
            List<Genre> genres = (List<Genre>) request.getSession(false).getAttribute("genres");
        %>
        <div class="other-space"></div>
        <div class="container mt-5">
            <%
            if  (user != null) {
            %>
            <h1>Write a new story</h1>
            <div class="row">
                <div class="col-sm-12 col-md-8 col-lg-6 mx-auto">
                    <form action="StoryController" method="post" enctype="multipart/form-data">
                        <div>
                            <label for="title">Title:</label><br>
                            <input class="form-control" type="text" id="title" name="title" required>
                        </div>
                        <div>
                            <label for="image">Upload Image:</label><br>
                            <input class="form-control" type="file" id="image" name="image" accept="image/*">
                        </div>
                        <div>
                            <label for="story">Story:</label><br>
                            <textarea class="form-control" id="story" name="story" rows="10" cols="50" required></textarea>
                        </div>
                        <div>
                            <label for="summary">Summary:</label><br>
                            <textarea class="form-control" id="summary" name="summary" rows="5" cols="50" required></textarea>
                        </div>
                        <div class="dropdown">
                            <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                                Select Genres
                            </button>
                            <ul class="dropdown-menu checkbox-menu allow-focus" aria-labelledby="dropdownMenuButton">
                                <% for(Genre genre: genres) { %>
                                <li>
                                    <label>
                                        <input type="checkbox" name="<%= genre.getId() %>" value="<%= genre.getId() %>"> <%= genre.getName() %>
                                    </label>
                                </li>
                                <% } %>
                            </ul>
                        </div>
                        <div class="form-check form-switch">
                            <input class="form-check-input" type="checkbox" role="switch" id="commentsEnabled" name="commentsEnabled" value="true">
                            <label class="form-check-label" for="commentsEnabled">Comments Enabled</label>
                        </div>
                        <input type="hidden" name="submit" value="addStory">
                        <input class="btn btn-success" type="submit" name="submitStory" value="Submit">
                        <input class="btn btn-primary" type="submit" name="submitStory" value="Save To Drafts">
                    </form>
                </div>
            </div>
            <%
                } else {
            %>
            <div class="alert alert-primary mt-5" role="alert">
                <h4 class="alert-heading">You are not currently logged in.</h4>
            </div>
            <%
                }
            %>
        </div>
    </body>
</html>