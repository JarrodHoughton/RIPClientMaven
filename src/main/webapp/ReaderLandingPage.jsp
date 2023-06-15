<%-- 
    Document   : ReadLandingPage
    Created on : 14 Jun 2023, 14:42:38
    Author     : jarro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Models.*"%>
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
            Account user = (Account) request.getSession(false).getAttribute("user");
            Reader reader = null;
            Writer writer = null;
            if  (user!=null && user.getUserType().equals("R")) {
                reader = (Reader) user;
            }
            
            if  (reader!=null) {
        %>
        <h4><%=reader%></h4>
        <%  } 
            if (writer!=null) {
        %>
        <h4><%=writer%></h4>
        <%
            }
        %>
        <h1>You have logged in as a Reader.</h1>

        <div id="navbar-container">
            <!-- Navbar -->
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
                <div class="container">
                    <a class="navbar-brand" href="#">
                        <img src="book.svg" alt="Book Icon" class="me-2" width="24" height="24"
                             style="filter: invert(1)">
                        READERS ARE INNOVATORS
                    </a>
                    <div class="d-flex align-items-center">
                        <form>
                            <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
                        </form>
                        <%
                        if (writer!=null) {
                        %>
                        <a class="btn btn-primary ms-2" href="ReaderLandingPage.jsp">Manage Stories</a>
                        <%
                            }
                        %>
                    </div>
                </div>
            </nav>
        </div>

        <div class="space"></div>
        <div class="container mt-5">
            <!-- Spacing -->
            <h2 class="text-center book-title">Best Sellers</h2>
            <div class="row row-cols-2 row-cols-md-3 row-cols-lg-6 g-4">
                <div class="col">
                    <div class="card card-fixed">
                        <img class="card-img-top card-img-top-fixed" src="pexels-nadi-lindsay-4865603.jpg" alt="Book Image">
                        <div class="card-body">
                            <h5 class="card-title">The Great Gatsby</h5>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card card-fixed">
                        <img class="card-img-top card-img-top-fixed" src="pexels-nadi-lindsay-4865603.jpg" alt="Book Image">
                        <div class="card-body">
                            <h5 class="card-title">The Great Gatsby</h5>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card card-fixed">
                        <img class="card-img-top card-img-top-fixed" src="pexels-nadi-lindsay-4865603.jpg" alt="Book Image">
                        <div class="card-body">
                            <h5 class="card-title">The Great Gatsby</h5>
                        </div>
                    </div>
                </div>
            </div>
            <div class="other-space"></div>
            <h2 class="text-center book-title">Best Sellers</h2>
            <div class="row row-cols-2 row-cols-md-3 row-cols-lg-6 g-4">
                <div class="col">
                    <div class="card card-fixed">
                        <img class="card-img-top card-img-top-fixed" src="pexels-nadi-lindsay-4865603.jpg" alt="Book Image">
                        <div class="card-body">
                            <h5 class="card-title">The Great Gatsby</h5>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card card-fixed">
                        <img class="card-img-top card-img-top-fixed" src="pexels-nadi-lindsay-4865603.jpg" alt="Book Image">
                        <div class="card-body">
                            <h5 class="card-title">The Great Gatsby</h5>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card card-fixed">
                        <img class="card-img-top card-img-top-fixed" src="pexels-nadi-lindsay-4865603.jpg" alt="Book Image">
                        <div class="card-body">
                            <h5 class="card-title">The Great Gatsby</h5>
                        </div>
                    </div>
                </div>
            </div>
            <div class="other-space"></div>
        </div>


    </body>
</html>
