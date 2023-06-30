<%-- 
    Document   : ManageEditors
    Created on : 23 Jun 2023, 09:21:55
    Author     : Jarrod
--%>

<%@page import="jakarta.json.Json"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="Models.*"%>
<%@page import="jakarta.json.JsonObject"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Manage Editors</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css" rel="stylesheet">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    </head>
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
        .other-space{
            margin-bottom: 100px;
        }
    </style>
    <body>
        <%
            Account user = (Account) request.getSession(false).getAttribute("user");
        %>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
            <div class="container">
                <a class="navbar-brand" href="http://localhost:8080/RIPClientMaven/EditorLandingPage.jsp">
                    <img src="book.svg" alt="Book Icon" class="me-2" width="24" height="24" style="filter: invert(1)">
                    READERS ARE INNOVATORS
                </a>
                <div class="d-flex align-items-center">
                    <%
                        if (user != null && (user.getUserType().equals("E") || user.getUserType().equals("A"))) {
                    %>
                    <a class="btn btn-primary ms-2" href="LoginController?submit=logout">Logout</a>
                    <%
                        }
                    %>
                </div>
            </div>
        </nav>
        <div class="other-space"></div>
        <%
            if (user != null && (user.getUserType().equals("E") || user.getUserType().equals("A"))) {
        %>
        <%!
            private JsonObject createEditorJsObj(Editor editor) {
                JsonObject editorJson = Json.createObjectBuilder()
                        .add("name", editor.getName())
                        .add("surname", editor.getSurname())
                        .add("email", editor.getEmail())
                        .add("phoneNumber", String.valueOf(editor.getPhoneNumber()))
                        .add("id", String.valueOf(editor.getId())).build();
                return editorJson;
            }
        %>
        <%-- Retrieve the list of editors from the request attribute --%>
        <%
            List<Editor> editors = (List<Editor>) request.getAttribute("editors");
            String message = (String) request.getAttribute("message");
        %>

        <%
            if (message != null) {
        %>
        <div class="alert alert-info mx-auto mt-5" role="alert">
            <h4 class="alert-heading"><%= message%></h4>
        </div>
        <%
            }
        %>
        <%-- Check if there are any editors available --%>
        <% if (editors != null) { %>
        <%-- Display the editor's details here --%>
        <div class="container mt-8">
            <div class="row mt-3">
                <h1>Manage Editors</h1>
                <table class="table">
                    <thead class="table-dark">
                        <tr>
                            <th></th>
                            <th>First Name</th>
                            <th>Last Name</th>
                            <th>Email</th>
                            <th>Phone Number</th>
                            <th>Approved Stories</th>
                        </tr>
                    </thead>
                    <%-- Iterate over the list of editors and display their details --%>
                    <%
                        for (Editor editor : editors) {
                            JsonObject editorJson = createEditorJsObj(editor);
                    %>
                    <tbody>
                        <tr>
                            <td>
                                <div class="mb-3">
                                    <input type="button" class="btn btn-primary editFormBtn" name="Edit" data-editor='<%= editorJson%>' value="Edit">
                                </div>
                                <div class="mb-3">
                                    <a class="btn btn-primary" href="EditorController?submit=deleteEditor&editorId=<%= editor.getId()%>" role="button">
                                        Delete
                                    </a>
                                </div>
                            </td>
                            <td><%=editor.getName()%></td>
                            <td><%=editor.getSurname()%></td>
                            <td><%=editor.getEmail()%></td>
                            <td><%=editor.getPhoneNumber()%></td>
                            <td><%=editor.getApprovalCount()%></td>
                        </tr>
                    </tbody>
                    <%
                        }
                    %>
                </table>
            </div>
        </div>
        <%
        } else {
        %>
        <div class="alert alert-primary mx-auto my-auto" role="alert">
            <h4 class="alert-heading">There are currently no editors on the system.</h4>
        </div>
        <%
            }
        %>

        <!-- Method to fill in editors details into modal-->
        <script type="text/javascript">
            $(document).ready(function () {
                $(".editFormBtn").click(function () {
                    console.log("Button clicked");
                    var editorString = $(this).data('editor');
                    console.log(editorString);
                    var editor = JSON.parse(JSON.stringify(editorString));
                    console.log(editor.name);
                    $("#editorNameInput").val(editor.name);
                    $("#editorSurnameInput").val(editor.surname);
                    $("#editorEmailInput").val(editor.email);
                    $("#editorPhoneNumberInput").val(editor.phoneNumber);
                    $("#editorId").val(editor.id);
                    $(".editorModal").modal("toggle");
                });
            });
        </script>

        <div class="mt-5">
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addEditorForm">
                Add New Editor
            </button>
        </div>

        <%-- Add a form here to add a new editor to the system --%>
        <div class="modal fade" id="addEditorForm" aria-labelledby="addEditorForm" tabindex="-1" style="display: none;" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="editorForm">Add An Editor</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="EditorController" method="post">
                            <div class="mb-3">
                                <label for="name" class="col-form-label">First Name</label>
                                <input type="text" class="form-control" id="name" name="name" required>
                            </div>
                            <div class="mb-3">
                                <label for="surname" class="col-form-label">Last Name</label>
                                <input type="text" class="form-control" id="surname" name="surname" required>
                            </div>
                            <div class="mb-3">
                                <label for="email" class="col-form-label">Email</label>
                                <input type="email" class="form-control" id="email"name="email" required>
                            </div>
                            <div class="mb-3">
                                <label for="phoneNumber" class="col-form-label">Phone Number</label>
                                <input type="tel" pattern="[0-9]{3}[0-9]{3}[0-9]{4}" maxlength="10" minlength="10" class="form-control" id="phoneNumber" name="phoneNumber" required>
                            </div>
                            <div class="mb-3">
                                <label for="password" class="col-form-label">Password</label>
                                <input type="password" class="form-control" id="password" name="password" placeholder="Password..." minlength="8" maxlength="16" required>
                            </div>
                            <div class="mb-3">
                                <label for="passwordRepeat" class="visually-hidden">Repeat-Password</label>
                                <input type="password" class="form-control" id="password" name="passwordRepeat" placeholder="Repeat Password..." minlength="8" maxlength="16" required>
                            </div>
                            <input type="hidden" name="submit" value="addEditor">
                            <button type="submit" class="btn btn-primary mb-3">Add Editor</button>
                        </form>
                    </div>
                    <div class="modal-footer"></div>
                </div>
            </div>
        </div>

        <!-- Modal to update an editors details -->
        <div class="modal fade editorModal" id="editorForm" aria-labelledby="editorForm" tabindex="-1" style="display: none;" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalToggleLabel2">Update Editor Details</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="EditorController" method="post">
                            <div class="mb-3">
                                <label for="editorNameInput" class="col-form-label">First Name</label>
                                <input type="text" class="form-control" id="editorNameInput" name="name">
                            </div>
                            <div class="mb-3">
                                <label for="editorSurnameInput" class="col-form-label">Last Name</label>
                                <input type="text" class="form-control" id="editorSurnameInput" name="surname">
                            </div>
                            <div class="mb-3">
                                <label for="editorEmailInput" class="col-form-label">Email</label>
                                <input type="email" class="form-control" id="editorEmailInput"name="email">
                            </div>
                            <div class="mb-3">
                                <label for="editorPhoneNumberInput" class="col-form-label">Phone Number</label>
                                <input type="tel" pattern="[0-9]{3}[0-9]{3}[0-9]{4}" maxlength="10" minlength="10" class="form-control" id="editorPhoneNumberInput" name="phoneNumber">
                            </div>
                            <div class="mb-3">
                                <label for="editorPassword" class="col-form-label">Password</label>
                                <input type="password" class="form-control" id="editorPassword" name="password" placeholder="Password..." minlength="8" maxlength="16">
                            </div>
                            <div class="mb-3">
                                <label for="editorPasswordRepeat" class="visually-hidden">Repeat-Password</label>
                                <input type="password" class="form-control" id="editorPasswordRepeat" name="passwordRepeat" placeholder="Repeat Password..." minlength="8" maxlength="16">
                            </div>
                            <input type="hidden" name="editorId" id="editorId">
                            <input type="hidden" name="submit" value="updateEditor">
                            <button type="submit" class="btn btn-primary mb-3">Save Changes</button>
                        </form>
                    </div>
                    <div class="modal-footer">
                    </div>
                </div>
            </div>
        </div>
        <%
        } else {
        %>
        <div class="alert alert-primary mx-auto my-auto" role="alert">
            <h4 class="alert-heading">You are currently not logged in.</h4>
        </div>
        <%
            }
        %>
    </body>
</html>
