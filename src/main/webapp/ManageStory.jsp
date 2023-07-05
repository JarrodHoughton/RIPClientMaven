<%-- 
    Document   : ManageStory
    Created on : 22 Jun 2023, 09:11:19
    Author     : faiza
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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
        <link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.0/font/bootstrap-icons.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-element-bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css"></script>
        <title>Manage Stories Page</title>
        <script>
            document.querySelector('table').addEventListener('click', (e) => {
                if (e.target.tagName === 'INPUT')
                    return;
                const row = e.target.tagName === 'TR' ? e.target : e.target.parentNode;
                const childCheckbox = row.querySelector('input[type="checkbox"]');
                childCheckbox.checked = !childCheckbox.checked;
            });
        </script>
    </head>
    <style>
        body {
            background: linear-gradient(180deg, #0d0d0d, #111111, #0d0d0d);

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
                <a class="navbar-brand" href="http://localhost:8080/RIPClientMaven/ReaderLandingPage.jsp">
                    <img src="book.svg" alt="Book Icon" class="me-2" width="24" height="24" style="filter: invert(1)">
                    READERS ARE INNOVATORS
                </a>
            </div>
        </nav>
        <%
            List<Genre> genres = (List<Genre>) request.getSession(false).getAttribute("genres");
            List<Story> submittedStories = (List<Story>) request.getAttribute("submittedStories");
            List<Story> draftedStories = (List<Story>) request.getAttribute("draftedStories");
            String message = (String) request.getAttribute("message");
        %>
        <div class="container mt-5">
            <div class="container mt-5">
                <%
                    if (message != null) {
                %>
                <div class="alert alert-primary mt-5" role="alert">
                    <h4 class="alert-heading"><%= message%></h4>
                </div>
                <%
                    }
                %>
                <div class="text-center mt-5">
                    <h3>Submitted Stories</h3>
                </div>
                <%
                    if (submittedStories != null) {
                %>
                <form action="StoryController" method="post">
                    <table class="table table-dark" border="1">
                        <thead>
                            <tr>
                                <th></th>
                                <th>Title</th>
                                <th>Approval Status</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (Story story : submittedStories) {
                            %>
                            <tr>
                                <td>
                                    <input aria-labelledBy="<%=story.getTitle()%>" class="form-check-input me-1" type="checkbox" name="<%=story.getId()%>" value="<%=story.getId()%>" id="<%=story.getId()%>">
                                    <label class="form-check-label" for="<%=story.getId()%>"></label>
                                </td>
                                <td id="<%=story.getTitle()%>"><%=story.getTitle()%></td>
                                <%
                                    String approvalStatus;
                                    if (story.getRejected()) {
                                        approvalStatus = "Rejected";
                                    } else if (story.getApproved()) {
                                        approvalStatus = "Approved";
                                    } else {
                                        approvalStatus = "Waiting Approval";
                                    }
                                %>
                                <td><%=approvalStatus%></td>
                                <td>
                                    <button class="btn btn-primary" type="button" data-bs-toggle="collapse" data-bs-target="#story<%=story.getId()%>" aria-expanded="false" aria-controls="tory<%=story.getId()%>Collapse">
                                        <i class="bi bi-caret-down-fill"></i>Details
                                    </button>
                                </td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                    <input type="hidden" id="id" name="submit" value="moveStoriesToDrafts">
                    <input type="submit" class="btn btn-primary px-4" value="Move To Drafts">
                </form>
                <%
                    for (Story story : submittedStories) {
                %>
                <div class="collapse" id="story<%=story.getId()%>" style="border: 5px solid grey; border-radius: 5px;">
                    <div class="row">
                        <div class="col-md-4">
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
                            <div class="row">
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
                        <div class="col-md-8">
                            <div class="row">
                                <div class="col">
                                    <swiper-container class="mySwiper" scrollbar="true" direction="vertical" slides-per-view="auto" free-mode="true" mousewheel="true">
                                        <swiper-slide>
                                            <h4 class="text-center text-white">Summary</h4>
                                            <p class="text-start text-white"><%=story.getBlurb()%></p>
                                        </swiper-slide>
                                    </swiper-container>
                                </div>
                                <div class="col">
                                    <swiper-container class="mySwiper" scrollbar="true" direction="vertical" slides-per-view="auto" free-mode="true" mousewheel="true">
                                        <swiper-slide>
                                            <h4 class="text-center text-white"><%=story.getTitle()%></h4>
                                            <p class="text-start text-white"><%=story.getContent()%></p>
                                        </swiper-slide>
                                    </swiper-container>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                    }
                %>
                <%
                } else {
                %>
                <div class="alert alert-primary" role="alert">
                    <h4 class="alert-heading">You currently have no submitted stories.</h4>
                </div>
                <%
                    }
                %>
            </div>
            <div class="container mt-3">
                <div class="text-center mt-3">
                    <h3>Drafts</h3>
                </div>
                <%
                    if (draftedStories != null) {
                %>
                <table class="table  table-dark" border="1">
                    <thead>
                        <tr>
                            <th>Title</th>
                            <th>Image</th>
                            <th>Genres</th>
                            <th>Blurb</th>
                            <th>Story</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (Story story : draftedStories) {
                        %>
                        <tr>
                            <td><%=story.getTitle()%></td>
                            <td>
                                <div class="text-center">
                                    <%
                                        if (story.getImage() != null) {
                                    %>
                                    <img class="rounded" src="data:image/jpg;base64,<%=Base64.getEncoder().encodeToString(ArrayUtils.toPrimitive(story.getImage()))%>" alt="Book Image">
                                    <%
                                    } else {
                                    %>
                                    <img class="rounded" id="storyImage" class="card-img-top card-img-top-fixed" src="book.svg" alt="Book Image">
                                    <%
                                        }
                                    %>
                                </div>
                            </td>
                            <td>
                                <ul class="list-group list-group-flush">
                                    <%
                                        if (genres != null) {
                                            for (Genre genre : genres) {
                                                if (story.getGenreIds().contains(genre.getId())) {
                                    %>
                                    <li class="list-group-item"><%=genre.getName()%></li>
                                        <%
                                                    }
                                                }
                                            }
                                        %>
                                </ul>
                            </td>
                            <td><%=story.getBlurb()%></td>
                            <td><%=story.getContent()%></td>
                            <td>
                                <div class="btn-group-vertical" role="group">
                                    <a class="btn btn-danger" href="StoryController?submit=deleteStoryFromManageStoryPage&storyId=<%=story.getId()%>">
                                        Delete
                                    </a>
                                    <a class="btn btn-primary" href="StoryController?submit=goToEditStoryPage&storyId=<%=story.getId()%>">
                                        Edit
                                    </a>
                                    <a class="btn btn-success" href="StoryController?submit=submitStoryFromWriter&storyId=<%=story.getId()%>">
                                        Submit
                                    </a>
                                </div>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
                <%
                } else {
                %>
                <div class="alert alert-primary" role="alert">
                    <h4 class="alert-heading">You currently have no drafted stories.</h4>
                </div>
                <%
                    }
                %>
            </div>
            <div class="container mt-3">
                <a href="createStory.jsp" class="btn btn-primary px4">
                    Create New Story
                </a>
            </div>
        </div>
    </body>
</html>
