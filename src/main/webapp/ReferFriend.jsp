<%-- 
    Document   : referFriend
    Created on : Jun 21, 2023, 3:16:09 PM
    Author     : Jaco Minnaar 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Refer a friend</h1>
        <form action="MailController" method="post" class="refer-friend-form">
            
            <div class="mb-3">
                <input type="email" class="form-control" id="email" name="email" placeholder="Enter email" required>
            </div>
            <div class="mb-3">
                <input type="text" class="form-control" id="name" name="name" placeholder="Enter name" required>
            </div>
            <div class="mb-3">
                <input type="number" class="form-control" id="numbert" name="phonenumber" placeholder="Enter phone number" maxlength="10" minlength="10" required>
            </div>
            <div class="text-center">
                <input type="submit" action="MailController?submit=sendReferralEmail">
                
            </div>

        </form>
    </body>
</html>
