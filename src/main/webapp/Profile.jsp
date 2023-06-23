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
        <title>Profile</title>
        <style>
            
            body{
                background: #f7f7ff;
                margin-top:20px;
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
    </head>
    <body>
        <% 
             Account user = (Account) request.getSession(false).getAttribute("user");
             Reader reader = null;
             Writer writer = null;
             if  (user!=null && user.getUserType().equals("R")) {
                 reader = (Reader) user;
             }
            
             if  (user!=null && user.getUserType().equals("W")) {
                 writer = (Writer) user;
             }
        %>
        



<div class="container">
    <div class="main-body">
        <div class="row">
            <div class="col-lg-4">
                <div class="card">
                    <div class="card-body">
                        <div class="d-flex flex-column align-items-center text-center">
                            <img src="https://bootdey.com/img/Content/avatar/avatar6.png" alt="Admin" class="rounded-circle p-1 bg-primary" width="110">
                            <div class="mt-3">
                                <h4><%=user.getName()%></h4><h4><%=user.getSurname()%></h4>
                                <h4><%=user.getPhoneNumber()%></h4>
                                <h4><%=user.getEmail()%></h4>
                            </div>
                        </div>   
                    </div>
                </div>
            </div>
            <div class="col-lg-8">
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
                                <input type="button" class="btn btn-primary px-4" value="Save Changes">
                            </div>
                        </div>
                    </div>
                </div>
               
            </div>
        </div>
    </div>
</div>




</body>
</html>