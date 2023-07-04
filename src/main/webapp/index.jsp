<%--
    Document   : Index
    Created on : 19 Jun 2023, 17:17:48
    Author     : Jarrod
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Models.*"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Base64"%>
<%@page import="org.apache.commons.lang3.ArrayUtils"%>
<%@page import="java.util.Arrays"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Home Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
        <link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.0/font/bootstrap-icons.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-element-bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css"></script>
        <style>
            /* Custom CSS to fix the navbar position */
            #navbar-container {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                z-index: 9999;
            }

            body {
                background: #333333;
            }

            .card {
                border: 1px solid black;
                border-radius: 5px; /* Round the card corners */
                transition: transform 0.3s;
                height: 400px;
            }

            .card:hover {
                border-color: #007bff; /* Add blue border color on hover */
                box-shadow: 0 0 10px rgba(0, 123, 255, 0.5); /* Add blue box shadow on hover */
            }

            .card-fixed {
                height: 400px; /* Adjust the height as per your requirement */
            }

            .card-img-top-fixed {
                width: 100%;
                height: 300px; /* Adjust the height as per your requirement */
                object-fit: cover;
            }

            .space {
                /* Adjust the margin-top as per your requirement */
                margin-bottom: 75px; /* Adjust the margin-bottom as per your requirement */
            }

            .other-space {
                margin-bottom: 40px;
            }

            carouselTitle {
                color: white;
            }

            swiper-container {
                width: 100%;
                height: 100%;
            }
            
            .Top-Stories-Swiper {
                width: 500px;
                height: 500px;
            }

            swiper-slide {
                text-align: center;
                font-size: 18px;
                background: #333333;
                display: flex;
                justify-content: center;
                align-items: center;
            }

            swiper-slide img {
                display: block;
                width: 200px;
                height: 100%;
                color: #333333;
                object-fit: cover;
            }

        </style>

        <%
            List<Story> topPicks = (List<Story>) request.getAttribute("topPicks");
            Boolean getStoriesCalled = (Boolean) request.getAttribute("getStoriesCalled");
            String message = (String) request.getAttribute("message");

            if (getStoriesCalled == null) {
                getStoriesCalled = false;
            }

            if (topPicks == null && !getStoriesCalled) {
        %>
        <script>
            window.location.replace("StoryController?submit=getStoriesForLandingPage");
        </script>
        <% } %>
    </head>
    <body>
        <div id="navbar-container">
            <!-- Navbar -->
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark bg-opacity-20">
                <div class="container">
                    <button class="btn btn-dark" type="button" data-bs-toggle="offcanvas" data-bs-target="#sidebar" aria-controls="sidebar" aria-expanded="false" style="position: absolute; left: 0;">
                        <i class="bi bi-list"></i> <!-- More Icon -->
                    </button>
                    <div class="container-fluid">
                        <a class="navbar-brand" href="http://localhost:8080/RIPClientMaven/">
                            <img src="book.svg" alt="Book Icon" class="me-2" width="24" height="24" style="filter: invert(1)">
                            READERS ARE INNOVATORS
                        </a>
                    </div>
                    <div class="d-flex align-items-center">
                        <form action="StoryController" method="post">
                            <input class="form-control me-2" type="search" placeholder="Search for titles, genres, blurbs..." aria-label="Search" name="searchValue" required>
                            <input type="hidden" name="submit" value="searchForGenreAndStories">
                        </form>
                    </div>
                </div>
            </nav>
        </div>







        <div class="space"></div>
        <%
            if (message != null) {
        %>
        <div class="alert alert-primary mt-5" role="alert">
            <h4 class="alert-heading"><%= message%></h4>
        </div> 
        <%
            }
        %>
        <div class="container mt-5">
            <%
                if (topPicks != null) {
            %>
            <!-- Top Picks Swiper -->
            <div class="container">
                <swiper-container class="Top-Stories-Swiper" navigation="true" space-between="10" slides-per-view="1" loop="true" mousewheel="true" effect="cube" cube-effect-shadow="true" cube-effect-slide-shadows="true" cube-effect-shadow-offset="20" cube-effect-shadow-scale="0.94">
                    <%
                        for (Story story : topPicks) {
                    %>
                    <swiper-slide>
                        <a style="text-decoration: none;" href="StoryController?submit=viewStory&storyId=<%=story.getId()%>">
                            <div class="card text-white bg-dark">
                                <%
                                    if (story.getImage() != null) {
                                %>
                                <img class="card-img-top card-img-top-fixed" src="data:image/jpg;base64,<%=Base64.getEncoder().encodeToString(ArrayUtils.toPrimitive(story.getImage()))%>" alt="Book Image">
                                <%
                                } else {
                                %>
                                <img class="card-img-top card-img-top-fixed" src="book.svg" alt="Book Image">
                                <%
                                    }
                                %>
                                <div class="card-body">
                                    <h5 class="card-title"><%=story.getTitle()%></h5>
                                </div>
                            </div>
                        </a>
                    </swiper-slide>
                    <%
                        }
                    %>
                </swiper-container>
            </div>
            <%
                }
            %>
            <div class="other-space"></div>
            <div class="other-space"></div>
            <%
                if (topPicks != null) {
            %>
            <!-- Spacing -->
            <h3 class="text-center">Top 10 picks</h3>

            <!-- Top Picks Swiper -->
            <div class="container">
                <swiper-container class="topPicks" navigation="true" space-between="10" slides-per-view="5" loop="true" mousewheel="true" effect="coverflow">
                    <%
                        for (Story story : topPicks) {
                    %>
                    <swiper-slide>
                        <a style="text-decoration: none;" href="StoryController?submit=viewStory&storyId=<%=story.getId()%>">
                            <div class="card text-white bg-dark">
                                <%
                                    if (story.getImage() != null) {
                                %>
                                <img class="card-img-top card-img-top-fixed" src="data:image/jpg;base64,<%=Base64.getEncoder().encodeToString(ArrayUtils.toPrimitive(story.getImage()))%>" alt="Book Image">
                                <%
                                } else {
                                %>
                                <img class="card-img-top card-img-top-fixed" src="book.svg" alt="Book Image">
                                <%
                                    }
                                %>
                                <div class="card-body">
                                    <h5 class="card-title"><%=story.getTitle()%></h5>
                                </div>
                            </div>
                        </a>
                    </swiper-slide>
                    <%
                        }
                    %>
                </swiper-container>
            </div>
            <%
                }
            %>
        </div>
        <div class="other-space"></div>
    </div>

    <!-- Modal Refer Friend Form -->
    <div class="modal fade" id="referFriend" aria-labelledby="referFriend" tabindex="-1" style="display: none;" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="exampleModalToggleLabel2">Share Our Platform!</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="MailController" method="post">
                    <div class="modal-body">
                        <div class="row mb-3">
                            <label for="name" class="col-form-label mb-3">Name</label>
                            <input type="text" class="form-control" id="name" name="name">
                        </div>
                        <div class="row mb-3">
                            <label for="email" class="col-form-label mb-3">Email</label>
                            <input type="email" class="form-control" id="email"name="email">
                        </div>
                        <div class="row mb-3">
                            <label for="phoneNumber" class="col-form-label mb-3">Phone Number</label>
                            <input type="tel" pattern="[0-9]{3}[0-9]{3}[0-9]{4}" maxlength="10" minlength="10" class="form-control" id="phoneNumber" name="phoneNumber">
                        </div>
                        <input type="hidden" name="currentPage" value="index.jsp">
                        <input type="hidden" name="submit" value="sendReferralEmail">
                    </div>
                    <div class="modal-footer">
                        <div class="btn-group" role="group">
                            <button type="submit" class="btn btn-primary mb-3">Send</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>



    <!-- Side Bar Menu -->
    <div class="offcanvas offcanvas-start text-bg-dark" tabindex="-1" id="sidebar" aria-labelledby="sidebar">
        <div class="offcanvas-header">
            <h5 class="offcanvas-title" id="offcanvasExampleLabel">Menu</h5>
            <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
        </div>
        <div class="offcanvas-body">
            <div class="d-grid">
                <a class="btn btn-dark" role="button" href="login.jsp"> Login</a>
                <button class="btn btn-dark" type="button" data-bs-toggle="modal" data-bs-target="#referFriend">Share</button>
            </div>
        </div>
    </div>
</body>
</html>