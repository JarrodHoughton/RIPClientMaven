<%-- 
    Document   : index
    Created on : 13 Jun 2023, 14:26:23
    Author     : jarro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Models.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>RIP Landing Page</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Login Page</title>
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

            .login-form {
                max-width: 400px;
                margin: 0 auto;
                padding: 20px;
                border: 1px solid #ccc;
                border-radius: 5px;
                background-color: #fff;
            }

            .login-button {
                width: 100%;
            }

            .not-member {
                text-align: center;
                margin-top: 10px;
            }
        </style>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
            <div class="container">
                <a class="navbar-brand" href="#">
                    <img src="book.svg" alt="Book Icon" class="me-2" width="24" height="24" style="filter: invert(1)">
                    READERS ARE INNOVATORS
                </a>
            </div>
        </nav>
        <% 
            String message = (String) request.getAttribute("message");
            Reader user = (Reader) request.getAttribute("user");
            if  (message != null) { 
        %>
        <div class="alert alert-info" role="alert">
            <h4 class="alert-heading"><%= message %></h4>
        </div>
        <% 
            } 
        %>
        <div class="container mt-4">
            <div class="row">
                <div class="col-sm-12 col-md-8 col-lg-6 mx-auto">
                    <form action="LoginController" method="post" class="login-form">
                        <h3 class="text-center mb-4">Login</h3>
                        <div class="mb-3">
                            <input type="email" class="form-control" id="email" name="email" placeholder="Enter your email" required>
                        </div>
                        <div class="mb-3">
                            <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" maxlength="16" minlength="8" required>
                        </div>
                        <div class="text-center">
                            <input type="submit" value="login" name="submit" class="btn btn-primary login-button">
                        </div>
                        <div class="not-member">
                            <p>Not a member? <a href="LoginController?submit=getGenresForRegister">Register</a></p>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
