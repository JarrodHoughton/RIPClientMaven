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
                        <th>Action</th>
                    </tr>
                    <tr>
                        <td>Author/Writer</td>
                        <td><input type="text" name="title" value="<%=story.getTitle()%>"></td>
                        <td>
                            <img id="storyImage" src="data:image/jpg;base64,<%=Base64.getEncoder().encodeToString(ArrayUtils.toPrimitive(story.getImage()))%>" alt="Book Image"><br>
                            <input type="file" name="image" accept="image/*" onchange="loadFile(event)">
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
                        <td><textarea name="summary" rows="5" cols="50" required><%=story.getBlurb()%></textarea></td>
                        <td><textarea name="story" rows="5" cols="50" required><%=story.getContent()%></textarea></td>
                        <td>
                            <input type="hidden" name="encodedImage" value="<%=Base64.getEncoder().encodeToString(ArrayUtils.toPrimitive(story.getImage()))%>">
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
        
        <!-- Profile Pop Up Modal -->
        <!-- Modal -->
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
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="profileForm" aria-labelledby="profileForm" tabindex="-1" style="display: none;" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalToggleLabel2">Update Profile</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="EditorController" method="post">
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
                                <input type="number" pattern="[0-9]{3}[0-9]{3}[0-9]{4}" maxlength="10" minlength="10" class="form-control" id="phoneNumber" name="phoneNumber" value="<%=user.getPhoneNumber()%>">
                            </div>
                            <div class="mb-3">
                                <label for="password" class="col-form-label">Password</label>
                                <input type="password" class="form-control" id="password" name="password" placeholder="Password..." maxlength="8" minlength="16">
                            </div>
                            <div class="mb-3">
                                <label for="passwordRepeat" class="visually-hidden">Repeat-Password</label>
                                <input type="password" class="form-control" id="password" name="passwordRepeat" placeholder="Repeat Password..." maxlength="8" minlength="16">
                            </div>
                            <input type="hidden" name="storyId" value="<%=story.getId()%>">
                            <input type="hidden" name="submit" value="updateEditorProfileFromEditStoryPage">
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

        <!-- End Of Modal -->
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
