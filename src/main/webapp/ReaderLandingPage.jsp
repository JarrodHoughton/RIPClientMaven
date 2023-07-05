<%-- 
    Document   : ReadLandingPage
    Created on : 14 Jun 2023, 14:42:38
    Author     : jarro
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
        <title>Reader Landing Page</title>
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
            Account user = (Account) request.getSession(false).getAttribute("user");
            
            if(user == null) {
        %>
        <script>
            window.location.replace("index.jsp");
        </script>
        <%
            }

            Reader reader = null;
            Writer writer = null;
            if  (user!=null && user.getUserType().equals("R")) {
                reader = (Reader) user;
            } else if (user!=null && user.getUserType().equals("W")) {
                writer = (Writer) user;
            } else {
                
            }
            String message = (String) request.getAttribute("message");
        %>

        <%
            Boolean getStoriesCalled = (Boolean) request.getAttribute("getStoriesForReaderLandingPageCalled");
            List<Story> topPicks = (List<Story>) request.getAttribute("topPicks");
            List<Story> recommendedStories = (List<Story>) request.getAttribute("recommendedStories");
            if (getStoriesCalled == null) {
                getStoriesCalled = false;
            }
            if (topPicks == null && recommendedStories == null && !getStoriesCalled) {
        %>
        <script>
            window.location.replace("StoryController?submit=getStoriesForReaderLandingPage");
        </script>
        <% } %>

        <div id="navbar-container">
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
                <div class="container">
                    <a class="navbar-brand" href="http://localhost:8080/RIPClientMaven/">
                        <img src="book.svg" alt="Book Icon" class="me-2" width="24" height="24"
                             style="filter: invert(1)">
                        READERS ARE INNOVATORS
                    </a>
                    <div class="d-flex align-items-center">
                        <form  action="StoryController" method="post">
                            <input class="form-control me-2" type="search" placeholder="Search for titles, genres, blurbs..." aria-label="Search" name="searchValue" required>
                            <input type="hidden" name="submit" value="searchForGenreAndStories">
                        </form>
                        <%
                            if (user != null && (user.getUserType().equals("R") || user.getUserType().equals("W"))) {
                        %>
                        <!-- Button trigger profile modal -->
                        <button type="button" class="btn btn-primary ms-2" data-bs-toggle="modal" data-bs-target="#profileDetails">
                            Profile
                        </button>
                        <a class="btn btn-primary ms-2" href="LoginController?submit=logout">Logout</a>
                        <%
                            }
                        %>
                        <%
                        if (writer!=null) {
                        %>
                        <a class="btn btn-primary ms-2" href="StoryController?submit=manageStories">Manage Stories</a>
                        <%
                            }
                        %>
                        <button type="button" class="btn btn-primary ms-2" data-bs-toggle="modal" data-bs-target="#referFriend">
                            Share
                        </button>
                    </div>
                </div>
            </nav>
        </div>

        <div class="space"></div>
        <%
            if (user != null) {
        %>
        <div class="container mt-5">
            <%
            if (message != null) {
            %>
            <div class="alert alert-primary mt-5" role="alert">
                <h4 class="alert-heading"><%= message %></h4>
            </div> 
            <%
                }
            %>

            <h2 class="text-center book-title">Top 10 Picks</h2>
            <div class="row row-cols-2 row-cols-md-3 row-cols-lg-6 g-4">
                <%
                if (topPicks != null) {
                    for (Story story : topPicks) {
                %>
                <a href="StoryController?submit=viewStory&storyId=<%=story.getId()%>">
                    <div class="col">
                        <div class="card card-fixed">
                            <%
                                if (story.getImage()!=null) {
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
            <h2 class="text-center book-title">Recommended Stories</h2>
            <div class="row row-cols-2 row-cols-md-3 row-cols-lg-6 g-4">
                <%
                if (recommendedStories != null) {
                    for (Story story : recommendedStories) {
                %>
                <a href="StoryController?submit=viewStory&storyId=<%=story.getId()%>">
                    <div class="col">
                        <div class="card card-fixed">
                            <%
                                if (story.getImage()!=null) {
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

        <!-- Profile Pop Up Modal -->
        <!-- Modal Profile Details -->
        <div class="modal fade" id="profileDetails" aria-labelledby="profileDetails" tabindex="-1" style="display: none;" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalToggleLabel">Profile Details</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <img src="person-square.svg" alt="Profile" class="rounded-circle p-1 bg-primary" width="110">
                        <div class="mb-3 row">
                            <label for="name" class="col col-form-label">First Name</label>
                            <div class="col-8">
                                <input type="text" class="form-control-plaintext" id="name" name="name" value="<%=user.getName()%>" readonly>
                            </div>
                        </div>
                        <div class="mb-3 row">
                            <label for="surname" class="col col-form-label">Last Name</label>
                            <div class="col-8">
                                <input type="text" class="form-control-plaintext" id="surname" name="surname" value="<%=user.getSurname()%>" readonly>
                            </div>
                        </div>
                        <div class="mb-3 row">
                            <label for="email" class="col col-form-label">Email</label>
                            <div class="col-8">
                                <input type="email" class="form-control-plaintext" id="email" name="email" value="<%=user.getEmail()%>" readonly>
                            </div>
                        </div>
                        <div class="mb-3 row">
                            <label for="phoneNumber" class="col col-form-label">Phone Number</label>
                            <div class="col-8">
                                <input type="tel" class="form-control-plaintext" id="phoneNumber" name="phoneNumber" value="<%=user.getPhoneNumber()%>" readonly>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-primary" data-bs-target="#profileForm" data-bs-toggle="modal">Edit Profile</button>
                        <%
                            if (writer == null) {
                        %>
                        <button class="btn btn-primary" data-bs-target="#applicationForm" data-bs-toggle="modal">Apply To Become A Writer</button>
                        <%
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal Profile Edit Form -->
        <div class="modal fade" id="profileForm" aria-labelledby="profileForm" tabindex="-1" style="display: none;" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalToggleLabel2">Update Profile</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="ReaderController" method="post">
                            <div class="mb-3">
                                <label for="name" class="col-form-label">First Name</label>
                                <input type="text" class="form-control" id="name" name="name" value="<%=user.getName()%>">
                            </div>
                            <div class="mb-3">
                                <label for="surname" class="col-form-label">Last Name</label>
                                <input type="text" class="form-control" id="surname" name="surname" value="<%=user.getSurname()%>">
                            </div>
                            <div class="mb-3">
                                <label for="email" class="col-form-label">Email</label>
                                <input type="email" class="form-control" id="email"name="email" value="<%=user.getEmail()%>">
                            </div>
                            <div class="mb-3">
                                <label for="phoneNumber" class="col-form-label">Phone Number</label>
                                <input type="tel" pattern="[0-9]{3}[0-9]{3}[0-9]{4}" maxlength="10" minlength="10" class="form-control" id="phoneNumber" name="phoneNumber" value="<%=user.getPhoneNumber()%>">
                            </div>
                            <div class="mb-3">
                                <label for="password" class="col-form-label">Password</label>
                                <input type="password" class="form-control" id="password" name="password" placeholder="Password..." maxlength="8" minlength="16">
                            </div>
                            <div class="mb-3">
                                <label for="passwordRepeat" class="visually-hidden">Repeat-Password</label>
                                <input type="password" class="form-control" id="password" name="passwordRepeat" placeholder="Repeat Password..." maxlength="8" minlength="16">
                            </div>
                            <input type="hidden" name="submit" value="updateReader">
                            <input type="hidden" name="currentPage" value="ReaderLandingPage.jsp">
                            <button type="submit" class="btn btn-primary mb-3">Save Changes</button>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <div class="btn-group" role="group">
                            <button class="btn btn-primary" data-bs-target="#profileDetails" data-bs-toggle="modal">Profile Details</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%
            if (writer == null) {
        %>
        <!-- Modal Writer Application Form -->
        <div class="modal fade" id="applicationForm" aria-labelledby="applicationForm" tabindex="-1" style="display: none;" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalToggleLabel2">Apply To Be A Writer</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="ApplicationController" method="post">
                            <div class="row mb-3">
                                <textarea class="form-control" placeholder="Please enter your motivation to become a writer here..." name="motivation" id="motivation" style="height: 100px"></textarea>
                                <label for="motivation" class="col-form-label">Motivation</label>
                            </div>
                            <input type="hidden" name="submit" value="applyForWriter">
                            <button type="submit" class="btn btn-primary mb-3">Submit Application</button>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <div class="btn-group" role="group">
                            <button class="btn btn-primary" data-bs-target="#profileDetails" data-bs-toggle="modal">Profile Details</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%
            }
        %>
        <!-- End Of Modal -->
        <%
            } else {
        %>
        <div class="alert alert-primary mt-5" role="alert">
            <h4 class="alert-heading">You are not currently logged in.</h4>
        </div> 
        <%
            }
        %>
        
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
                            <input type="hidden" name="currentPage" value="ReaderLandingPage.jsp">
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
