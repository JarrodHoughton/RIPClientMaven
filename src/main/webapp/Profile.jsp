<%-- 
    Document   : Profile
    Created on : Jun 23, 2023, 9:18:24 AM
    Author     : Jaco Minnaar 
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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
        <title>Profile</title>
        <style>
            html,
            body {
                background: #f7f7ff;
                margin-top:20px;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
            }
            .card {
                position: relative;
                display: flex;
                flex-direction: column;
                min-width: 0;
                word-wrap: break-word;
                background-color: #fff;
                background-clip: border-box;
                border: 0 solid transparent;
                border-radius: .25rem;
                margin-bottom: 1.5rem;

            }
            .me-2 {
                margin-right: .5rem!important;
            }
        </style>
        <script>
            window.onload = function () {
                document.getElementById("profileForm").style.display = "none";
            };

            function toggleProfile() {
                var profileDetails = document.getElementById("profileDetails");
                var profileForm = document.getElementById("profileForm");
                var editProfileBtn = document.getElementById("editProfileBtn");

                if (profileForm.style.display === "none") {
                    profileForm.style.display = "block";
                    profileDetails.style.display = "none";
                    editProfileBtn.innerHTML = "Cancel";
                } else {
                    profileForm.style.display = "none";
                    profileDetails.style.display = "block";
                    editProfileBtn.innerHTML = "Edit Profile";
                }
            }
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
             Account user = (Account) request.getSession(false).getAttribute("user");
             String message = (String) request.getAttribute("message");
             Reader reader = null;
             Writer writer = null;
             if  (user!=null && user.getUserType().equals("R")) {
                 reader = (Reader) user;
             }
            
             if  (user!=null && user.getUserType().equals("W")) {
                 writer = (Writer) user;
             }
        %>

        <%
            if (message != null) {
        %>
        <div class="alert alert-info" role="alert">
            <h4 class="alert-heading"><%= message %></h4>
        </div> 
        <%
            }
        %>
        <div class="container">
            <div class="main-body">
                <div class="row">
                    <div class="col-lg-4" id="profileDetails">
                        <div class="card">
                            <div class="card-body">
                                <div class="d-flex flex-column align-items-center text-center">
                                    <img src="person-square.svg" alt="Profile" class="rounded-circle p-1 bg-primary" width="110">
                                    <div class="mt-3">
                                        <h4><%=user.getName()%></h4><h4><%=user.getSurname()%></h4>
                                        <h4><%=user.getPhoneNumber()%></h4>
                                        <h4><%=user.getEmail()%></h4>
                                    </div>
                                </div>   
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-8" id="profileForm">
                        <div class="card">
                            <div class="card-body">
                                <div class="row mb-3">
                                    <div class="col-sm-3">
                                        <h6 class="mb-0">Full Name</h6>
                                    </div>
                                    <div class="col-sm-9 text-secondary">
                                        <input type="text" class="form-control" value="<%=user.getName()%>">
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <div class="col-sm-3">
                                        <h6 class="mb-0">Surname</h6>
                                    </div>
                                    <div class="col-sm-9 text-secondary">
                                        <input type="text" class="form-control" value="<%=user.getSurname()%>">
                                    </div>
                                </div>
                            </div>
                            <div class="row mb-3">
                                <div class="col-sm-3">
                                    <h6 class="mb-0">Phone Number</h6>
                                </div>
                                <div class="col-sm-9 text-secondary">
                                    <input type="text" class="form-control" value="<%=user.getPhoneNumber()%>">
                                </div>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-sm-3">
                                <h6 class="mb-0">Email</h6>
                            </div>
                            <div class="col-sm-9 text-secondary">
                                <input type="text" class="form-control" value="<%=user.getEmail()%>">
                            </div>

                            <div class="row">
                                <div class="col-sm-3"></div>
                                <div class="col-sm-9 text-secondary">
                                    <input type="submit" class="btn btn-primary px-4" value="Save Changes">
                                    <input type="hidden" name="readerId" value="<%=user.getId()%>">
                                    <input type="hidden" name="submit" value="updateReader">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-8">
                        <div class="row mb-3">
                            <div class="col-sm-9 text-secondary">
                                <button type="button" id="editProfileBtn" class="btn btn-primary px-4" onclick="toggleProfile()">Edit Profile</button>
                            </div>
                        </div>
                    </div>
                    <%
                        if (reader != null) {
                    %>
                    <form action="ApplicationController" method="post">
                    <input type="hidden" name="readerId" value="<%=user.getId()%>">
                    <div class="row mb-3">
                        <div class="col-sm-3">
                            <h6 class="mb-0">Motivation</h6>
                        </div>
                        <div class="col-sm-9 text-secondary">
                            <textarea type="text" class="form-control" name="motivation"></textarea>
                        </div>
                    </div>
                    <div class="col-lg-8">
                        <div class="row mb-3">
                            <div class="col-sm-9 text-secondary">
                                <button type="submit" class="btn btn-primary px-4" value="addApplication">Apply To Become A Writer</button>
                            </div>
                        </div>
                    </div>
                    </form>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>

    </body>
</html>
