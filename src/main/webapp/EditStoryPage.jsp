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
    </head>
    <body>
        <%
            String message = (String) request.getAttribute("message");
            Story story = (Story) request.getAttribute("story");
            List<Genre> genres = (List<Genre>) request.getSession(false).getAttribute("genres");
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
                    <a class="navbar-brand" href="#">
                        <img src="book.svg" alt="Book Icon" class="me-2" width="24" height="24"
                             style="filter: invert(1)">
                        READERS ARE INNOVATORS
                    </a>
                    <div class="d-flex align-items-center">
                        <form>
                            <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
                        </form>
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
            <h2 class="text-center book-title">Select a Story to Approve and Edit</h2>
            <table border="1">
                <tr>
                    <th>Author</th>
                    <th>Title</th>
                    <th>Image</th>
                    <th>Genres</th>
                    <th>Blurb</th>
                    <th>Story</th>
                    <th>Action</th>
                </tr>
                <tr>
                    <td>Author/Writer</td>
                    <td><input type="text" value="<%=story.getTitle()%>"></td>
                    <td><img src="data:image/jpg;base64,<%=Base64.getEncoder().encodeToString(ArrayUtils.toPrimitive(story.getImage()))%>" alt="Book Image"><br>
                        <input type="file" accept="image/*">
                    </td>
                    <td>
                        <%
                            if (genres != null) {
                                for (Genre genre : genres) {
                        %>
                        <input type="checkbox" name="<%=genre.getId()%>" value="<%=genre.getId()%>" <%if (story.getGenreIds().contains(genre.getId())) {%> checked <%}%>> <%=genre.getName()%><br>
                        <%      }
                            } else {
                        %>
                        <p>Failed to retrieve genres.</p>
                        <%
                            }
                        %>
                    </td>
                    <td><textarea><%=story.getBlurb()%></textarea></td>
                    <td><textarea><%=story.getContent()%></textarea></td>
                    <td>
                        <a href="StoryController?submit=submitStoryFromEditor&storyId=<%=story.getId()%>">
                            <button type="button">Approve</button>
                        </a>
                        <a href="StoryController?submit=rejectStoryFromEditor&storyId=<%=story.getId()%>">
                            <button type="button">Deny</button>
                        </a>
                    </td>
                </tr>
            </table>
            <div class="other-space"></div>
        </div>
        <% 
            }
        %>
    </body>
</html>
