/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import ServiceLayers.ApplicationService_Impl;
import ServiceLayers.ApplicationService_Interface;
import ServiceLayers.WriterService_Impl;
import ServiceLayers.WriterService_Interface;
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
@WebServlet(name = "ReaderController", urlPatterns = {"/ReaderController"})
public class ReaderController extends HttpServlet {

    private ApplicationService_Interface applicationService;
    private WriterService_Interface writerService;

    public ReaderController() {
        this.applicationService = new ApplicationService_Impl();
        this.writerService = new WriterService_Impl();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        switch (request.getParameter("submit")) {
            case "getWriterApplications":
                request.setAttribute("applications", applicationService.getApplications());
                request.getRequestDispatcher("").forward(request, response);
                break;
            case "approveApplication":
                Integer readerId = (Integer) request.getAttribute("readerId");
                String message = "Failed to approve application.";
                if (writerService.addWriter(readerId)) {
                    message = "Application has been approved successfully.";
                }
                request.setAttribute("message", message);
                request.getRequestDispatcher("").forward(request, response);
                break;
            case "rejectApplication":
                readerId = (Integer) request.getAttribute("readerId");
                message = "System failed to reject application.";
                if (applicationService.deleteApplication(readerId)) {
                    message = "Application has been rejected successfully.";
                }
                request.setAttribute("message", message);
                request.getRequestDispatcher("").forward(request, response);
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
