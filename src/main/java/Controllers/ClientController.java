/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import Models.*;
import ServiceLayers.LoginService_Impl;
import ServiceLayers.LoginService_Interface;
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

    public ClientController() {
        loginService = new LoginService_Impl();
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
                    user = loginService.loginReader(user);
                    if (user!=null) {
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
                Reader reader = new Reader();
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
