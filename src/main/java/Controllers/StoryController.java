/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import Models.Genre;
import Models.Story;
import Models.Writer;
import ServiceLayers.GenreService_Impl;
import ServiceLayers.GenreService_Interface;
import ServiceLayers.StoryService_Impl;
import ServiceLayers.StoryService_Interface;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 *
 * @author jarro
 */
@WebServlet(name = "StoryController", urlPatterns = {"/StoryController"})
public class StoryController extends HttpServlet {
    private StoryService_Interface storyService;
    private GenreService_Interface genreService;
    
    public StoryController() {
        this.storyService = new StoryService_Impl();
        genreService = new GenreService_Impl();
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        switch (request.getParameter("submit")) {
            case "viewStory":
                
                break;
            case "readStory":
                
                break;
            case "likeStory":
                
                break;
            case "rateStory":
                
                break;
            case "commentStory":
                
                break;
            case "submitStory":
                
                break;
            case "editStory":
                
                break;
            case "addStory":
                Writer author = (Writer) request.getSession(false).getAttribute("user");
                Story story = new Story();
                Part filePart = request.getPart("image");
                InputStream fis = filePart.getInputStream();
                byte[] imageData = new byte[(int)filePart.getSize()];
                fis.read(imageData);
                story.setImage(imageData);
                story.setTitle(request.getParameter("title"));
                story.setContent(request.getParameter("story"));
                story.setBlurb(request.getParameter("summary"));
                story.setAuthorId(author.getId());
                List<Genre> genres = genreService.getAllGenres();
                List<Integer> genreIds = new ArrayList<>();
                for (Genre genre:genres) {
                    if (request.getParameter(String.valueOf(genre.getId()))!=null) {
                        genreIds.add(genre.getId());
                    }
                }
                story.setGenreIds(genreIds);
                String message;
                if (genreIds.isEmpty()) {
                    message = "Failed to create story: Please select genres for your story.";
                } else {
                    message = storyService.addStory(story);
                }
                request.setAttribute("message", message);
                request.getRequestDispatcher("createStory.jsp");
                break;
            case "getTopPicks":
                request.setAttribute("topPicks", List.of("This", "is", "a", "test", "list", "this will be replaced by a list of stories"));
                request.getRequestDispatcher("index.jsp").forward(request, response);
                break;
            case "manageStories":
                request.getRequestDispatcher("createStory.jsp").forward(request, response);
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
