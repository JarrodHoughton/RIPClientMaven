<%--
    Document   : EditStoryPage
    Created on : 21 Jun 2023, 15:02:51
    Author     : faiza
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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
        <link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.0/font/bootstrap-icons.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-element-bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css"></script>
        <title>Edit Story</title>
    </head>
    <style>
        .other-space {
            margin-bottom: 150px;
        }

        .space-one {
            margin-bottom: 20px;
        }

        body {
            background: linear-gradient(180deg, #0d0d0d, #111111, #0d0d0d);
            color: white;
        }
        .approve-container{

        }

        swiper-container {
            width: 100%;
            height: 300px;
        }

        swiper-slide {
            font-size: 18px;
            height: auto;
            width: 100%;
            -webkit-box-sizing: border-box;
            box-sizing: border-box;
            padding: 30px;
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
            List<Story> submittedStories = (List<Story>) request.getAttribute("submittedStories");
            List<Genre> genres = (List<Genre>) request.getSession(false).getAttribute("genres");
            String message = (String) request.getAttribute("message");
        %>
        <div class="other-space"></div>

        <div class="container mt-8">
            <div class="container mt-5">
                <%
                    if (message != null) {
                %>
                <div class="alert alert-success" role="alert">
                    <h4 class="alert-heading"><%= message%></h4>
                </div>
                <%
                    }
                %>
                <%
                    if (submittedStories != null) {
                %>
                <h2>Submitted Stories</h2>

                <div class="container mt-5  text-center">
                    <div class="row bg-dark">
                        <div class="col">
                            <h4 class="text-white text-center">Title</h4>
                        </div>
                        <div class="col">
                            <h4 class="text-white text-center">Summary</h4>
                        </div>
                        <div class="col">
                        </div>
                    </div>
                    <%
                        for (Story story : submittedStories) {
                    %>
                    <div class="row rows-cols-auto bg-white text-black text-center" style="border-block-end: 2px solid black; height: 50px;">
                        <div class="col">
                            <h6 class="text-start"><%=story.getTitle()%></h6>
                        </div>
                        <div class="col">
                            <h6 class="text-start"><%=story.getBlurb()%></h6>
                        </div>
                        <div class="col">
                            <div class="row">
                                <div class="col mx-auto my-auto text-center">
                                    <button class="btn btn-dark" type="button" data-bs-toggle="collapse" data-bs-target="#story<%=story.getId()%>" aria-expanded="false" aria-controls="tory<%=story.getId()%>Collapse">
                                        <i class="bi bi-caret-down-fill"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row rows-cols-auto collapse text-center bg-black" id="story<%=story.getId()%>">
                        <div class="col" style="width: 30%;">
                            <div class="row text-center">
                                <div class="image-container" style="height: 60%;">
                                    <%
                                        if (story.getImage() != null) {
                                    %>
                                    <img class="img-thumbnail img-fluid"
                                         src="data:image/jpg;base64,<%=Base64.getEncoder().encodeToString(ArrayUtils.toPrimitive(story.getImage()))%>"
                                         alt="Book Image">
                                    <%
                                    } else {
                                    %>
                                    <img class="card-img-top card-img-top-fixed" src="book.svg" alt="Book Image">
                                    <%
                                        }
                                    %>
                                </div>
                            </div>
                            <div class="row text-center">
                                <div class="col text-center">
                                    <ul class="list-group list-group-flush">
                                        <%
                                            if (genres != null) {
                                                for (Genre genre : genres) {
                                                    if (story.getGenreIds().contains(genre.getId())) {
                                        %>
                                        <li class="list-group-item text-white bg-black"><%=genre.getName()%></li>
                                            <%
                                                        }
                                                    }
                                                }
                                            %>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="col" style="width: 70%;">
                            <div class="row">
                                <div class="col">
                                    <div class="row my-auto">
                                        <swiper-container class="mySwiper" scrollbar="true" direction="vertical" slides-per-view="auto" free-mode="true" mousewheel="true">
                                            <swiper-slide>
                                                <h4 class="text-center text-white"><%=story.getTitle()%></h4>
                                                <p class="text-start text-white"><%=story.getContent()%></p>
                                            </swiper-slide>
                                        </swiper-container>
                                    </div>
                                    <div class="row mt-2">
                                        <div class="btn-group" role="group">
                                            <a class="btn btn-primary"
                                               href="StoryController?submit=rejectStoryFromEditor&storyId=<%=story.getId()%>">
                                                Deny
                                            </a>
                                            <a class="btn btn-primary"
                                               href="StoryController?submit=goToEditStoryPage&storyId=<%=story.getId()%>">
                                                Edit
                                            </a>
                                            <a class="btn btn-primary"
                                               href="StoryController?submit=submitStoryFromSelectStoryToEditPage&storyId=<%=story.getId()%>">
                                                Approve
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%
                        }
                    %>
                </div>
                <%
                } else {
                %>
                <div class="alert alert-primary mt-5" role="alert">
                    <h4 class="alert-heading">There are currently no stories to approve.</h4>
                </div>
                <%
                    }
                %>
            </div>
        </div>

        <div class="space-one"></div>
    </body>
</html>
