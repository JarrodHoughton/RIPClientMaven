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
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <style>


            /* Custom CSS to fix the navbar position */
            #navbar-container {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                z-index: 1;

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

            .other-space {
                margin-bottom: 40px;
            }

            body {
                font-family: "fantasy", fantasy;
                background-color: #D8D8D8;

            }
            /*sidenav*/
            .sidenav {
                height: 100%;
                width: 0;
                position: fixed;
                z-index: 1;
                top: 0;
                left: 0;
                background-color: #111;
                overflow-x: hidden;
                transition: 0.5s;
                padding-top: 60px;
            }

            .sidenav a {
                padding: 8px 8px 8px 32px;
                text-decoration: none;
                font-size: 25px;
                color: #818181;
                display: block;
                transition: 0.3s;
            }

            .sidenav a:hover {
                color: #f1f1f1;
            }

            .sidenav .closebtn {
                position: absolute;
                top: 0;
                right: 25px;
                font-size: 36px;
                margin-left: 50px;
            }

            @media screen and (max-height: 450px) {
                .sidenav {
                    padding-top: 15px;
                }
                .sidenav a {
                    font-size: 18px;
                }
            }
            .header-bar{
                height: 70px;
                padding-top: 10px;
                padding-left: 30px;
                color: wheat;

            }

            /*card-carousel*/
            .story-container{
                white-space: nowrap;
                overflow-x: auto;
                display: flex;
                max-width: 100%;
                height: auto;
                margin-right: 10px;

            }

            .col{
                padding-right: 20px;
                width: 250px;
            }

            
            /* Define the scrollbar style */
            .story-container::-webkit-scrollbar {
                width: 10px;
                height: 10px;
            }

            /* Define the thumb style */
            .story-container::-webkit-scrollbar-thumb {
                background: linear-gradient(to bottom right, #4d7fff 0%, #1a56ff 100%);
                border-radius: 5px;
            }

            /* Define the track style */
            .story-container::-webkit-scrollbar-track {
                background-color: #ddd;
                border: 1px solid #ccc;
            }

            /* Define the button style */
            .story-container::-webkit-scrollbar-button {
                background-color: #4d7fff;
                border-radius: 5px;
            }

            /* Define the button style when being hovered over */
            .story-container::-webkit-scrollbar-button:hover {
                background-color: #999999;
            }
        </style>

        <%
            List<Story> topPicks = (List<Story>) request.getAttribute("topPicks");
            String message = (String) request.getAttribute("message");

            if (topPicks == null) {
        %>
        <script>
            window.location.replace("StoryController?submit=getStoriesForLandingPage");
        </script>
        <% } %>
    </head>
    <body>
        <div id="navbar-container">
            <!-- Navbar -->
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark">

                <div id="mySidenav" class="sidenav">
                    <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
                    <a href="login.jsp">Login</a>
                    <a href="#">About</a>
                    <a href="#" input type="button" onClick="document.getElementById('middle').scrollIntoView();" />
                    <input type="button" onClick="document.getElementById('middle').scrollIntoView();" />
                    <input type="button" onClick="document.getElementById('middle').scrollIntoView();" />
                    <input type="button" onClick="document.getElementById('middle').scrollIntoView();" />
                    <input type="button" onClick="document.getElementById('middle').scrollIntoView();" />
                    <a href="#">Services</a>
                    <a href="#">Clients</a>
                    <a href="#referFriend" type="button" data-bs-toggle="modal">Share</a>
                    <a href="#">Contact</a>
                </div>

                <div class="header-bar">
                    <span style="font-size:30px;cursor:pointer" onclick="openNav()">&#9776;</span>
                </div>

                <script>
                    function openNav() {
                        document.getElementById("mySidenav").style.width = "250px";
                    }

                    function closeNav() {
                        document.getElementById("mySidenav").style.width = "0";
                    }
                </script>


                <div class="container">
                    <a class="navbar-brand" href="http://localhost:8080/RIPClientMaven/">
                        <img src="book.svg" alt="Book Icon" class="me-2" width="24" height="24"
                             style="filter: invert(1)">
                        READERS ARE INNOVATORS
                    </a>
                    <div class="d-flex align-items-center">
                        <form action="StoryController" method="post">
                            <input class="form-control me-2" type="search" placeholder="Search for titles, genres, blurbs..." aria-label="Search" name="searchValue" required>
                            <input type="hidden" name="submit" value="searchForGenreAndStories">
                        </form>


                    </div>
                </div>
            </nav>
        </div>

        <div class="other-space"></div>
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
        <div class="container">
            <h2 class="story-title">Top 10 Most Viewed</h2>

            <div class="story-container">

                <%
                    if (topPicks != null) {
                        for (Story story : topPicks) {
                %>
                <a href="StoryController?submit=viewStory&storyId=<%=story.getId()%>">
                    <div class="col">

                        <div class="card card-fixed">
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
                    </div>
                </a>
                <%
                        }
                    }
                %>
            </div>

            <div class="other-space"></div>
        </div>


        <div class="container">
            <h2 class="story-title">Top 20 Most Rated</h2>

            <div class="story-container">

                <%
                    if (topPicks != null) {
                        for (Story story : topPicks) {
                %>
                <a href="StoryController?submit=viewStory&storyId=<%=story.getId()%>">
                    <div class="col">

                        <div class="card card-fixed">
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
                    </div>
                </a>
                <%
                        }
                    }
                %>
            </div>

            <div class="other-space"></div>
        </div>

        <div class="container">
            <h2 class="story-title">Top 20 Most Liked</h2>

            <div class="story-container">

                <%
                    if (topPicks != null) {
                        for (Story story : topPicks) {
                %>
                <a href="StoryController?submit=viewStory&storyId=<%=story.getId()%>">
                    <div class="col">

                        <div class="card card-fixed">
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
                    </div>
                </a>
                <%
                        }
                    }
                %>
            </div>

            <div class="other-space"></div>
        </div>

        <div class="container">
            <h2 class="story-title">Top 3 Categories</h2>

            <div class="story-container">

                <%
                    if (topPicks != null) {
                        for (Story story : topPicks) {
                %>
                <a href="StoryController?submit=viewStory&storyId=<%=story.getId()%>">
                    <div class="col">

                        <div class="card card-fixed">
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
                    </div>
                </a>
                <%
                        }
                    }
                %>
            </div>

            <div class="other-space"></div>
        </div>


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

    </body>
</html>
