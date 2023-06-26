<%-- 
    Document   : Profile
    Created on : Jun 23, 2023, 9:18:24 AM
    Author     : Jarrod Houghton
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
        <title>Update Editor</title>
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
             Editor editor = (Editor) request.getAttribute("editor");
             Account user = (Account) request.getSession(false).getAttribute("user");
             Editor adminEditor = null;
             if  (user!=null && user.getUserType().equals("A")) {
                 adminEditor = (Editor) user;
             }
        %>




        <div class="container">
            <div class="main-body">
                <div class="row">
                    <form action="EditorController" method="post">
                        <div class="col-lg-8">
                            <div class="card">
                                <div class="card-body">
                                    <div class="row mb-3">
                                        <div class="col-sm-3">
                                            <h6 class="mb-0">Full Name</h6>
                                        </div>
                                        <div class="col-sm-9 text-secondary">
                                            <input type="text" class="form-control" name="name" value="<%=editor.getName()%>">
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-sm-3">
                                            <h6 class="mb-0">Surname</h6>
                                        </div>
                                        <div class="col-sm-9 text-secondary">
                                            <input type="text" class="form-control" name="surname" value="<%=editor.getSurname()%>">
                                        </div>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <div class="col-sm-3">
                                        <h6 class="mb-0">Phone Number</h6>
                                    </div>
                                    <div class="col-sm-9 text-secondary">
                                        <input type="text" class="form-control" name="phoneNumber" value="<%=editor.getPhoneNumber()%>">
                                    </div>
                                </div>
                            </div>
                            <div class="row mb-3">
                                <div class="col-sm-3">
                                    <h6 class="mb-0">Email</h6>
                                </div>
                                <div class="col-sm-9 text-secondary">
                                    <input type="text" class="form-control" value="<%=editor.getEmail()%>" name="email">
                                </div>

                                <div class="col-sm-3">
                                    <h6 class="mb-0">New Password</h6>
                                </div>
                                <div class="col-sm-9 text-secondary">
                                    <input type="text" class="form-control" name="password">
                                </div>

                                <div class="col-sm-3">
                                    <h6 class="mb-0">Repeat Password</h6>
                                </div>
                                <div class="col-sm-9 text-secondary">
                                    <input type="text" class="form-control" name="repeatPassword">
                                </div>

                                <div class="row">
                                    <div class="col-sm-3"></div>
                                    <div class="col-sm-9 text-secondary">
                                        <input type="submit" class="btn btn-primary px-4" value="Save Changes">
                                    </div>
                                </div>
                                <input type="hidden" name="editorId" value="<%=editor.getId()%>">
                                <input type="hidden" name="submit" value="updateEditor">
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>




</body>
</html>
