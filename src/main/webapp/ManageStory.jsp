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
                    <h4 class="alert-heading"><%= message %></h4>
                </div>
                <%
                    }
                %>
                <div class="text-center mt-5">
                    <h3>Submitted Stories</h3>
                </div>
                <%
                    if  (submittedStories != null) {
                %>
                <form action="StoryController" method="post">
                    <table class="table" border="1">
                        <thead class="table-dark">
                            <tr>
                                <th></th>
                                <th>Title</th>
                                <th>Image</th>
                                <th>Genres</th>
                                <th>Blurb</th>
                                <th>Story</th>
                                <th>Approval Status</th>
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
                                <td>
                                    <div class="text-center">
                                        <%
                                            if (story.getImage()!=null) {
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
                                                    if  (story.getGenreIds().contains(genre.getId())) {
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
                    if  (draftedStories != null) {
                %>
                <table class="table" border="1">
                    <thead class="table-dark">
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
                                        if (story.getImage()!=null) {
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
                                                if  (story.getGenreIds().contains(genre.getId())) {
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
