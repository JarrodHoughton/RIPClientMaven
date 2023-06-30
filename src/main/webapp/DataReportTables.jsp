<%-- 
    Document   : DataReportTables
    Created on : 30 Jun 2023, 05:52:26
    Author     : Jarrod
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="org.json.JSONArray"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Models.*"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Data Report Tables</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css" rel="stylesheet">
    </head>
    <style>
        html,
        body {
            height: 100%;
            background: #f7f7ff;
            margin-top:20px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }
        .other-space{
            margin-bottom: 150px;
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
                        if (user != null && (user.getUserType().equals("W") || user.getUserType().equals("R"))) {
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
                List<Table> tables = (List<Table>) request.getAttribute("tables");
                if (tables != null && !tables.isEmpty()) {
                    List<String> tableNames = new ArrayList<>();
                    for (Table table : tables) {
                        tableNames.add(table.getTableName());
                    }
        %>
        <script>
            const tables = document.querySelectorAll(".table");
            function downloadTables() {
                var printWindow = window.open('', '', 'left=0, top=0, width=800, height=500, toolbar=0, scrollbars=0, status=0');
                for (let i = 0; i < tables.length; i++) {
                    printWindow.document.write(tables[i].innerHTML);
                }
                printWindow.document.close();
                printWindow.focus();
                printWindow.print();
            }
        </script>
        <div class="container mt-5">
            <h1>Data Report Tables</h1>
            <%
                for (Table table : tables) {
            %>
            <h4><%= table.getTableName()%></h4>
            <table class="table" id="<%= table.getTableName()%>">
                <thead class="table-dark">
                    <tr>
                        <th>#</th>
                            <%
                                for (String column : table.getColumns()) {
                            %>
                        <th><%= column%></th>
                            <%
                                }
                            %>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (int i = 0; i < table.getNumberOfRows(); i++) {


                    %>
                    <tr>
                        <td><%=(i + 1)%></td>
                        <%
                            for (List<Object> columnData : table.getData()) {
                        %>
                        <td><%= columnData.get(i)%></td>
                        <%
                            }
                        %>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            <%
                }
            %>
            <div class="mb-3 mt-4">
                <button type="button" class="btn btn-primary btn-lg" onclick="downloadTables()">Download PDF</button>
            </div>
        </div>
        <%
        } else {
        %>
        <div class="alert alert-primary mx-auto my-auto" role="alert">
            <h4 class="alert-heading">No tables have been received.</h4>
        </div>
        <%
            }
        %>
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
