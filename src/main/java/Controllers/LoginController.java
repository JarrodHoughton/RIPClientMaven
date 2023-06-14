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
@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {

    private LoginService_Interface loginService;
    private ReaderService_Interface readerService;

    public LoginController() {
        loginService = new LoginService_Impl();
        readerService = new ReaderService_Impl();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        switch (request.getParameter("submit")) {
            case "login":
                Account user = new Reader();
                user.setEmail(request.getParameter("email"));
                user.setPasswordHash(request.getParameter("password"));
                HashMap<String, String> details = loginService.getUserSalt(user.getEmail());
                String message = "Login Credentials Incorrect: email or password was not found.";
                if (Boolean.parseBoolean(details.get("userFound"))) {
                    switch (details.get("userType")) {
                        case "R":
                            Reader reader = new Reader();
                            reader.setSalt(details.get("salt"));
                            reader.setPasswordHash(request.getParameter("password"));
                            reader.setEmail(request.getParameter("email"));
                            reader = loginService.loginReader(reader);
                            request.setAttribute("user", reader);
                            request.getRequestDispatcher("ReaderLandingPage.jsp").forward(request, response);
                            break;

                        case "W":
                            Writer writer = new Writer();
                            writer.setSalt(details.get("salt"));
                            writer.setPasswordHash(request.getParameter("password"));
                            writer.setEmail(request.getParameter("email"));
                            writer = loginService.loginWriter(writer);
                            request.setAttribute("user", writer);
                            request.getRequestDispatcher("ReaderLandingPage.jsp").forward(request, response);
                            break;

                        case "E":
                            Editor editor = new Editor();
                            editor.setSalt(details.get("salt"));
                            editor.setPasswordHash(request.getParameter("password"));
                            editor.setEmail(request.getParameter("email"));
                            editor = loginService.loginEditor(editor);
                            request.setAttribute("user", editor);
                            request.getRequestDispatcher("EditorLandingPage.jsp").forward(request, response);
                            break;

                        case "A":
                            editor = new Editor();
                            editor.setSalt(details.get("salt"));
                            editor.setPasswordHash(request.getParameter("password"));
                            editor.setEmail(request.getParameter("email"));
                            editor = loginService.loginEditor(editor);
                            request.setAttribute("user", editor);
                            request.getRequestDispatcher("EditorLandingPage.jsp").forward(request, response);
                            break;

                        default:
                            request.setAttribute("message", "Something went wrong logging in.");
                            request.getRequestDispatcher("index.jsp").forward(request, response);
                    }

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
                request.setAttribute("message", message);
                request.getRequestDispatcher("index.jsp").forward(request, response);
                break;
            default:
                throw new AssertionError();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
