<%-- 
    Document   : EditorLandingPage
    Created on : 14 Jun 2023, 14:42:50
    Author     : Jarrod
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Models.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Editor Landing Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
        <link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.0/font/bootstrap-icons.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <style>

            body{

            }

            /* Custom CSS to fix the navbar position */
            #navbar-container {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                z-index: 1;
            }

            body{
                background-color: #333333;
            }

            .space {
                /* Adjust the margin-top as per your requirement */
                margin-bottom: 75px; /* Adjust the margin-bottom as per your requirement */
            }
            .space-one{
                margin-bottom: 30px;
            }

            .other-space {
                margin-bottom: 40px;
            }
            .space-div{
                height: 80px;
            }
            .welcome{
                background-color: #333333;
                color: white;
            }
        </style>
    </style>

</head>
<body>

    <!--navbar-->
    <div class="space-div"></div>
    <%
        Account user = (Account) request.getSession(false).getAttribute("user");
        String message = (String) request.getAttribute("message");
    %>

    <div id="navbar-container">
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <button class="btn btn-dark" type="button" data-bs-toggle="offcanvas" data-bs-target="#sidebar" aria-controls="sidebar" aria-expanded="false" style="position: absolute; left: 0;">
                    <i class="bi bi-list"></i> <!-- More Icon -->
                </button>
                <div class="container-fluid">
                    <a class="navbar-brand position-relative" href="http://localhost:8080/RIPClientMaven/">
                    <img src="book.svg" alt="Book Icon" class="me-2 " width="24" height="24" style="filter: invert(1)" >READERS ARE INNOVATORS</a>
                </div>
                <div class="d-flex align-items-center">
                    <%
                        if (user != null && (user.getUserType().equals("E") || user.getUserType().equals("A"))) {
                    %>
                    <!-- Button trigger profile modal -->


                    <%
                        }
                    %>
                </div>
        </nav>
    </div>

    <!--side-navbar-->
    <div class="offcanvas offcanvas-start text-bg-dark" tabindex="-1" id="sidebar" aria-labelledby="sidebar">
        <div class="offcanvas-header">
            <h5 class="offcanvas-title" id="offcanvasExampleLabel">Menu</h5>
            <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
        </div>
        <div class="offcanvas-body">
            <div class="d-grid">
                <button class="btn btn-dark " type="button" data-bs-toggle="modal" data-bs-target="#profileDetails"><i class="bi bi-person-fill"></i> Profile</button>
                <a class="btn btn-dark " href="LoginController?submit=logout"><i class="bi bi-box-arrow-right"></i>Logout</a>
            </div>
        </div>
    </div>



    <%
        if (user != null && (user.getUserType().equals("E") || user.getUserType().equals("A"))) {
    %>
    <%
        if (message != null) {
    %>
    <div class="alert alert-success text-center " role="alert">
        <h4 class="alert-heading"><%=message%></h4>
    </div>
    <%
        }
    %>

    <!--welcome div-->
    <div class="welcome border-top border-bottom border-4 ">
        <div class="welcome-editor text-center " >
            <h1 class="fs-3">Welcome, Editor!</h1>
            <p>Here you can manage books and perform various editor-related tasks.</p>
            <p>On this page, you can:</p>

        </div>
        <div class="container  text-start">
            <div class="row ">
                <div class="col">
                    <ul>
                        <li>View and manage pending books</li>
                        
                    </ul>
                </div>
                <div class="col">
                    <ul>
                        <li>Access a list of approved books</li>
                        

                    </ul>
                </div>
                <div class="col">
                    <li>Review and approve submitted books</li>
                </div>
                <div class="col">
                    <li>Review and handle rejected books</li>
                </div>
            </div>
        </div>
    </div>
    <div class="space-one"></div>
    <div class="d-grid gap-2 col-6 mx-auto">
        <a class="btn btn-primary" href="StoryController?submit=goToSelectStoriesToEdit" role="button">Submitted Stories</a>
        <a class="btn btn-primary" href="ApplicationController?submit=getWriterApplications" role="button">Writer Applications</a>
        <a class="btn btn-primary" href="SelectReportData.jsp" role="button">Data Reports</a>
        <a class="btn btn-primary" href="WriterController?submit=goToBlockWriterPage" role="button">Manage Writers</a>
        <%
            if (user != null && user.getUserType().equals("A")) {
        %>
        <a class="btn btn-primary " href="EditorController?submit=manageEditors" role="button">Manage Editors</a>
        <%
            }
        %>
    </div>
    <br/>

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
                            <input type="tel" pattern="[0-9]{3}[0-9]{3}[0-9]{4}" maxlength="10" minlength="10" class="form-control" id="phoneNumber" name="phoneNumber" value="<%=user.getPhoneNumber()%>">
                        </div>
                        <div class="mb-3">
                            <label for="password" class="col-form-label">Password</label>
                            <input type="password" class="form-control" id="password" name="password" placeholder="Password..." maxlength="16" minlength="8">
                        </div>
                        <div class="mb-3">
                            <label for="passwordRepeat" class="visually-hidden">Repeat-Password</label>
                            <input type="password" class="form-control" id="password" name="passwordRepeat" placeholder="Repeat Password..." minlength="8" maxlength="16">
                        </div>
                        <input type="hidden" name="submit" value="updateEditorFromProfile">
                        <input type="hidden" name="currentPage" value="EditorLandingPage.jsp">
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
        <h4 class="alert-heading">You are not currently logged in.</h4>
    </div> 
    <%
        }
    %>
</body>
</body>
</html>
