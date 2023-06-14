/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import Models.*;
import ServiceLayers.LoginService_Impl;
import ServiceLayers.LoginService_Interface;
import ServiceLayers.ReaderService_Impl;
import ServiceLayers.ReaderService_Interface;
import Utils.PasswordEncryptor;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.HashMap;

/**
 *
 * @author jarro
 */
@WebServlet(name = "ClientController", urlPatterns = {"/ClientController"})
public class ClientController extends HttpServlet {

    private LoginService_Interface loginService;
    private ReaderService_Interface readerService;

    public ClientController() {
        loginService = new LoginService_Impl();
        readerService = new ReaderService_Impl();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        switch (request.getParameter("submit")) {
            case "login":
                Reader user = new Reader();
                user.setEmail(request.getParameter("email"));
                user.setPasswordHash(request.getParameter("password"));
                HashMap<String, String> details = loginService.getUserSalt(user.getEmail());
                String message = "Login Credentials Incorrect: email or password was not found.";
                if (Boolean.parseBoolean(details.get("userFound"))) {
                    user.setSalt(details.get("salt"));
                    user = loginService.loginReader(user);
                    if (user != null) {
                        request.setAttribute("user", user);
                        message = "Login successful.";
                    }
                } else {
                    message = "user not found.";
                }
                request.setAttribute("message", message);
                request.getRequestDispatcher("index.jsp").forward(request, response);
                break;
            case "register":
                message = "This email already exists.";
                if (!readerService.userExists(request.getParameter("email"))) {
                    Reader reader = new Reader();
                    reader.setEmail(request.getParameter("email"));
                    reader.setSalt(PasswordEncryptor.generateSalt());
                    reader.setPasswordHash(PasswordEncryptor.hashPassword(request.getParameter("password"), reader.getSalt()));
                    reader.setName(request.getParameter("name"));
                    reader.setSurname(request.getParameter("surname"));
                    reader.setPhoneNumber(request.getParameter("phoneNumber"));
                    message = loginService.register(reader);
                    request.setAttribute("user", loginService.loginReader(reader));
                }
                request.setAttribute("message",message);
                request.getRequestDispatcher("index.jsp").forward(request, response);
                break;
            default:
                throw new AssertionError();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
