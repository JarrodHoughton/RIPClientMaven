<%-- 
    Document   : EditStoryPage
    Created on : 21 Jun 2023, 15:02:51
    Author     : faiza
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Story Page</title>
    </head>
    <body>
        <h1>Edit stories page</h1>
        <table border="1">
            <tr>
                <th>Author</th>
                <th>Title</th>
                <th>Image</th>
                <th>Genres</th>
                <th>Blurb</th>
                <th>Story</th>
                <th>Action</th>
            </tr>
            <tr>
                <td>Author/Writer</td>
                <td><input type="text" value="Story Title"></td>
                <td><img src="url_to_your_image.jpg" alt="Image Description"><br><input type="file" accept="image/*"></td>
                <td>
                    <input type="checkbox" name="genre" value="fantasy"> Fantasy<br>
                    <input type="checkbox" name="genre" value="scifi"> Sci-Fi<br>
                    <input type="checkbox" name="genre" value="mystery"> Mystery<br>
                    <!-- Add as many categories as needed -->
                </td>
                <td><textarea>Blurb</textarea></td>
                <td><textarea>Story</textarea></td>
                <td>
                    <button type="button">Approve</button>
                    <button type="button">Deny</button>
                </td>
            </tr>
        </table>
    </body>
</html>
