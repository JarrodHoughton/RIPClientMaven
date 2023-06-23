<%-- 
    Document   : SearchResultsPage
    Created on : 20 Jun 2023, 19:19:09
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
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Reader Landing Page</title>
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
            List<Story> storiesInGenre = (List<Story>) request.getAttribute("storiesInGenre");
            String genreName = (String) request.getAttribute("genreName");
        %>
        <div id="navbar-container">
            <!-- Navbar -->
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
                <div class="container">
                    <a class="navbar-brand" href="http://localhost:8080/RIPClientMaven/">
                        <img src="book.svg" alt="Book Icon" class="me-2" width="24" height="24"
                             style="filter: invert(1)">
                        READERS ARE INNOVATORS
                    </a>
                    <div class="d-flex align-items-center">
                        <form>
                            <input class="form-control me-2" type="search" placeholder="Search for genres, titles, blurbs..." aria-label="Search" name="searchValue">
                            <input type="hidden" name="submit" value="searchForGenreAndStories">
                        </form>
                    </div>
                </div>
            </nav>
        </div>

        <div class="space"></div>
        <%
            if (storiesInGenre != null && !storiesInGenre.isEmpty()) {
        %>
        <div class="container mt-5">
            <!-- Spacing -->
            <h2 class="text-center book-title">Stories In Genre: <%=genreName%></h2>
            <div class="row row-cols-2 row-cols-md-3 row-cols-lg-6 g-4">
                <%
                    for (Story story : storiesInGenre) {
                %>
                <a href="StoryController?submit=viewStory&storyId=<%=story.getId()%>">
                <div class="col">
                        <div class="card card-fixed">

                            <img class="card-img-top card-img-top-fixed" src="data:image/jpg;base64,<%=Base64.getEncoder().encodeToString(ArrayUtils.toPrimitive(story.getImage()))%>" alt="Book Image">

                            <div class="card-body">
                                <h5 class="card-title"><%=story.getTitle()%></h5>
                            </div>
                        </div>
                </div>
                </a>
                <% 
                        }
                %>
            </div>
            <div class="other-space"></div>
        </div>
        <%
            } else {
        %>
        <h3>No stories found in genre: "<%=genreName%>"</h3>
        <% 
            }
        %>
    </body>
</html>
