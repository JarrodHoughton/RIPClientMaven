/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import Models.Application;
import Models.Reader;
import ServiceLayers.ReaderService_Impl;
import ServiceLayers.ReaderService_Interface;
import Utils.PasswordEncryptor;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author 27713
 */
@WebServlet(name = "ReaderController", urlPatterns = {"/ReaderController"})
public class ReaderController extends HttpServlet {

    private ReaderService_Interface readerService;
    private Reader reader;
    private HttpSession session;
    
    public ReaderController(){
        this.readerService = new ReaderService_Impl();
        this.reader = null;
        this.session = null;
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        session = request.getSession(false);
        switch (request.getParameter("submit")){
            case "updateReader":
                String currentPage = request.getParameter("currentPage");
                reader = (Reader) session.getAttribute("user");                
                String password = request.getParameter("password");                
                if (!password.isEmpty()) {
                    reader.setPasswordHash(PasswordEncryptor.hashPassword(password, reader.getSalt()));
                }
                reader.setEmail(request.getParameter("email"));
                reader.setName(request.getParameter("name"));
                reader.setSurname(request.getParameter("surname"));
                reader.setPhoneNumber(request.getParameter("phoneNumber"));
                session.setAttribute("user", reader);
                request.setAttribute("message", readerService.updateReaderDetails(reader));                
                request.getRequestDispatcher(currentPage).forward(request, response);
                break;
            
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