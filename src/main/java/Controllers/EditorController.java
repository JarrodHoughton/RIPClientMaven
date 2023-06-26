/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import Models.Editor;
import Models.Genre;
import Models.Reader;
import ServiceLayers.EditorService_Impl;
import ServiceLayers.EditorService_Interface;
import Utils.PasswordEncryptor;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 *
 * @author Jarrod
 */
@WebServlet(name = "EditorController", urlPatterns = {"/EditorController"})
public class EditorController extends HttpServlet {

    private EditorService_Interface editorService;
    private Editor editor;

    public EditorController() {
        this.editorService = new EditorService_Impl();
        this.editor = null;
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        switch (request.getParameter("submit")) {
            case "manageEditors":
                request.setAttribute("editors", editorService.getAllEditors());
                request.getRequestDispatcher("ManageEditors.jsp").forward(request, response);
                break;
            case "addEditor":
                String message = "This email already exists.";
                String password = request.getParameter("password");
                String email = request.getParameter("email");
                if (!editorService.searchForEditor(email)) {
                    editor = new Editor();
                    editor.setEmail(email);
                    editor.setSalt(PasswordEncryptor.generateSalt());
                    editor.setPasswordHash(PasswordEncryptor.hashPassword(password, editor.getSalt()));
                    editor.setName(request.getParameter("name"));
                    editor.setSurname(request.getParameter("surname"));
                    editor.setPhoneNumber(request.getParameter("phoneNumber"));
                    message = editorService.addEditor(editor);
                }
                request.setAttribute("message", message);
                request.setAttribute("editors", editorService.getAllEditors());
                request.getRequestDispatcher("ManageEditors.jsp").forward(request, response);
                break;
            case "deleteEditor":
                Integer editorId = Integer.valueOf(request.getParameter("editorId"));
                request.setAttribute("message", editorService.deleteEditor(editorId));
                request.setAttribute("editors", editorService.getAllEditors());
                request.getRequestDispatcher("ManageEditors.jsp").forward(request, response);
                break;
            case "updateEditor":
                email = request.getParameter("email");
                editor = editorService.getEditor(email);
                editor.setPasswordHash(PasswordEncryptor.hashPassword(request.getParameter("password"), editor.getSalt()));
                editor.setEmail(email);
                editor.setName(request.getParameter("name"));
                editor.setSurname(request.getParameter("surname"));
                editor.setPhoneNumber(request.getParameter("phoneNumber"));
                request.setAttribute("message", editorService.updateEditor(editor));
                request.setAttribute("editors", editorService.getAllEditors());
                request.getRequestDispatcher("ManageEditors.jsp").forward(request, response);
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
