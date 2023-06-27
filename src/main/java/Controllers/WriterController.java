/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import Models.Genre;
import Models.Writer;
import ServiceLayers.WriterService_Impl;
import ServiceLayers.WriterService_Interface;
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
 * @author jarro
 */
@WebServlet(name = "WriterController", urlPatterns = {"/WriterController"})
public class WriterController extends HttpServlet {

    private WriterService_Interface writerService;
    private Integer writerId;
    private Writer writer;
    private String message;

    public WriterController() {
        this.writerService = new WriterService_Impl();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        switch (request.getParameter("submit")) {
            case "goToBlockWriterPage":
                request.setAttribute("writers", writerService.getAllWriters());
                request.getRequestDispatcher("BlockWriters.jsp").forward(request, response);
                break;
            case "blockWriters":
                List<Writer> writers = writerService.getAllWriters();
                List<Integer> writerIds = new ArrayList<>();
                for (Writer writer : writers) {
                    if (request.getParameter(String.valueOf(writer.getId())) != null) {
                        writerIds.add(writer.getId());
                    }
                }
                if (writerIds.isEmpty()) {
                    message = "No writers were selected.";
                } else {
                    message = writerService.blockWriters(writerIds);
                }
                request.setAttribute("writers", writerService.getAllWriters());
                request.setAttribute("message", message);
                request.getRequestDispatcher("BlockWriters.jsp").forward(request, response);
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
