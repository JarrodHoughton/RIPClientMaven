<%-- 
    Document   : index
    Created on : 13 Jun 2023, 14:26:23
    Author     : jarro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Models.*"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>RIP Landing Page</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
        <style>
            html,
            body {
                height: 100%;
            }

            body {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
            }

            .registration-form {
                max-width: 400px;
                margin: 0 auto;
                padding: 20px;
                border: 1px solid #ccc;
                border-radius: 5px;
                background-color: #fff;
            }

            .registration-button,
            .wide-button {
                width: 100%;
            }

            .login-link {
                text-align: center;
                margin-top: 10px;
            }

            .wide-dropdown {
                width: 100%;
            }
        </style>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
            <div class="container">
                <a class="navbar-brand" href="http://localhost:8080/RIPClientMaven/">
                    <img src="book.svg" alt="Book Icon" class="me-2" width="24" height="24" style="filter: invert(1)">
                    READERS ARE INNOVATORS
                </a>
            </div>
        </nav>
        <%
            List<Genre> genres = (List<Genre>) request.getAttribute("genres");
            Account user = (Account) request.getSession(false).getAttribute("user");
        %>
        <%
            if (user != null) {
        %>
        <div>Enter Login:</div>
        <form action="LoginController" method="post">
            Name:<input type="text" name="name" required><br>
            Surname:<input type="text" name="surname" required><br>
            Email:<input type="email" name="email" required><br>
            Password:<input type="password" name="password" maxlength="16" minlength="8" required><br>
            Phone Number:<input type="number" name="phoneNumber"pattern="[0-9]{3}[0-9]{3}[0-9]{4}" maxlength="10" minlength="10" required><br>

            <div class="dropdown">
                <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                    Select Genres
                </button>
                <ul class="dropdown-menu checkbox-menu allow-focus" aria-labelledby="dropdownMenuButton">
                    <% 
                        if (genres != null) {
                            for(Genre genre: genres) { 
                    %>
                    <li>
                        <label>
                            <input type="checkbox" name="<%= genre.getId() %>" value="<%= genre.getId() %>"> <%= genre.getName() %>
                        </label>
                    </li>
                    <%      
                            }
                        } 
                    %>
                </ul>
            </div>
            <br>
            <input type="submit" value="register" name="submit">
        </form>
        <%
            }
        %>
    </body>
</html>
