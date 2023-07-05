<%-- 
    Document   : EditStoryPage
    Created on : 20 Jun 2023, 17:21:52
    Author     : jarro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Models.*"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Base64"%>
<%@page import="org.apache.commons.lang3.ArrayUtils"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Story</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-NTWp1tUQpxgih3k9wV9iVDOZDHR9sYPm9/j1ZDrN8IEEeVn5k1vL/1XTmlfF4zXZ" crossorigin="anonymous"></script>
        <script src="jquery-3.7.0.min.js"></script>
        <style>
            /* Custom CSS to fix the navbar position */
            #navbar-container {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                z-index: 9999;
            }

            .card {
                border: 1px solid #ddd; /* Add border to the cards */
                border-radius: 5px; /* Round the card corners */
                transition: transform 0.3s;
            }

            .card:hover {
                transform: translateY(-5px);
                border-color: #007bff; /* Add blue border color on hover */
                box-shadow: 0 0 10px rgba(0, 123, 255, 0.5); /* Add blue box shadow on hover */
            }

            .card-fixed {
                height: 400px; /* Adjust the height as per your requirement */
            }

            .card-img-top-fixed {
                width: 100%;
                height: 250px; /* Adjust the height as per your requirement */
                object-fit: cover;
            }

            .space {
                /* Adjust the margin-top as per your requirement */
                margin-bottom: 100px; /* Adjust the margin-bottom as per your requirement */
            }

            .other-space{
                margin-bottom: 40px;
            }
        </style>
        <script>
            $('.dropdown').unbind('show.bs.dropdown');
            $('.dropdown').unbind('hide.bs.dropdown');
            $('.dropdown').bind('show.bs.dropdown', function () {
                $('.fixed-table-body').css("overflow", "inherit");
            });
            $('.dropdown').bind('hide.bs.dropdown', function () {
                $('.fixed-table-body').css("overflow", "auto");
            });
        </script>
    </head>
    <script>
        var loadFile = function (event) {
            var image = document.getElementById('storyImage');
            image.src = URL.createObjectURL(event.target.files[0]);
        };
    </script>
    <body>
        <%
            Account user = (Account) request.getSession(false).getAttribute("user");
            String message = (String) request.getAttribute("message");
            Story story = (Story) request.getAttribute("story");
            List<Genre> genres = (List<Genre>) request.getSession(false).getAttribute("genres");
            String navBarRef = "http://localhost:8080/RIPClientMaven/";
        %>

        <%
            if (user != null && !user.getUserType().equals("R")) {
                
                if (user.getUserType().equals("W")) {
                    navBarRef += "ReaderLandingPage.jsp";
                } else {
                    navBarRef += "EditorLandingPage.jsp";
                }
                
        %>

        <%
            if (message!=null) {
        %>
        <h3><%=message%></h3>
        <%
            }
        %>
        <div id="navbar-container">
            <!-- Navbar -->
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
                <div class="container">
                    <a class="navbar-brand" href="<%=navBarRef%>">
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
        if (story!=null) {
        %>
        <div class="space"></div>
        <div class="container mt-5">
            <!-- Spacing -->
            <h2 class="text-center book-title">Edit Story</h2>
            <form action="StoryController" method="post"enctype="multipart/form-data">
                <table border="1">
                    <tr>
                        <th>Author</th>
                        <th>Title</th>
                        <th>Image</th>
                        <th>Genres</th>
                        <th>Blurb</th>
                        <th>Story</th>
                        <th>Comments Enabled</th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <td>Author/Writer</td>
                        <td><input type="text" name="title" value="<%=story.getTitle()%>"></td>
                        <td>
                            <%
                                if (story.getImage()!= null) {
                            %>
                            <img id="storyImage" src="data:image/jpg;base64,<%=Base64.getEncoder().encodeToString(ArrayUtils.toPrimitive(story.getImage()))%>" alt="Book Image">
                            <input type="hidden" name="encodedImage" value="<%=Base64.getEncoder().encodeToString(ArrayUtils.toPrimitive(story.getImage()))%>">
                            <%
                                } else {
                            %>
                            <img id="storyImage" class="card-img-top card-img-top-fixed" src="book.svg" alt="Book Image">
                            <input type="hidden" name="encodedImage" value="book.svg">
                            <%
                                }
                            %>
                            <br>
                            <input type="file" name="image" accept="image/*" onchange="loadFile(event)">
                        </td>
                        <td>
                            <%
                                if (genres != null) {
                            %>
<!--                            <div class="dropdown checkbox-dropdown">
                                <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                                    Select Genres
                                </button>
                                <ul class="dropdown-menu checkbox-menu allow-focus position-static" aria-labelledby="dropdownMenuButton">
                                    <% for(Genre genre: genres) { %>
                                    <li>
                                        <div class="form-check">
                                            <label class="form-check-label" for="<%= genre.getId() %>"><%= genre.getName() %></label>
                                            <input type="checkbox" class="form-check-input" name="<%= genre.getId() %>" value="<%= genre.getId() %>" id="<%= genre.getId() %>"<% if (story.getGenreIds().contains(genre.getId())) { %> checked <% } %>>
                                        </div>
                                    </li>
                                    <% } %>
                                </ul>
                            </div>-->
                            <% for(Genre genre: genres) { %>
                            <div class="form-check">
                                <label class="form-check-label" for="<%= genre.getId() %>"><%= genre.getName() %></label>
                                <input type="checkbox" class="form-check-input" name="<%= genre.getId() %>" value="<%= genre.getId() %>" id="<%= genre.getId() %>"<% if (story.getGenreIds().contains(genre.getId())) { %> checked <% } %>>
                            </div>
                            <% } %>
                            <%      
                                } else {
                            %>
                            <p>Failed to retrieve genres.</p>
                            <%
                                }
                            %>
                        </td>
                        <td><textarea name="summary" rows="5" cols="50" required><%=story.getBlurb()%></textarea></td>
                        <td><textarea name="story" rows="5" cols="50" required><%=story.getContent()%></textarea></td>
                        <td>
                            <div class="form-check form-switch">
                                <input class="form-check-input" type="checkbox" role="switch" id="commentsEnabled" name="commentsEnabled" value="true"<%if (story.getCommentsEnabled()) {%>checked<%}%>>
                                <label class="form-check-label" for="commentsEnabled"></label>
                            </div>
                        </td>
                        <td>
                            <input type="hidden" name="storyId" value="<%=story.getId()%>">
                            <input type="hidden" name="authorId" value="<%=story.getAuthorId()%>">
                            <%
                                if (user.getUserType().equals("E") || user.getUserType().equals("A")) {
                            %>
                            <input type="hidden" name="submit" value="approveEditedStoryFromEditor">
                            <input class="btn btn-primary" type="submit" value="Approve">
                            <a class="btn btn-danger" href="StoryController?submit=rejectStoryFromEditor&storyId=<%=story.getId()%>">
                                Deny
                            </a>
                            <%
                                }
                            %>
                            <%
                                if (user.getUserType().equals("W")) {
                            %>
                            <input type="hidden" name="submit" value="updateEditedStoryFromWriter">
                            <input class="btn btn-success" type="submit" name="submitStory" value="Submit">
                            <input class="btn btn-primary" type="submit" name="submitStory" value="Save To Drafts">
                            <%
                                }
                            %>

                        </td>
                    </tr>
                </table>
            </form>
            <div class="other-space"></div>
        </div>
        <% 
            } else {
        %>
        <div class="alert alert-danger" role="alert">
            <h4 class="alert-heading">Story not found.</h4>
        </div>
        <%
            }
        %>
        <%
            } else {
        %>
        <div class="alert alert-danger" role="alert">
            <h4 class="alert-heading">You do not have priviliges to edit a story.</h4>
        </div>
        <%
            }
        %>
    </body>
</html>
