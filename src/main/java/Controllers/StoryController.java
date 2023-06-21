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
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

/**
 *
 * @author jarro
 */
@WebServlet(name = "StoryController", urlPatterns = {"/StoryController"})
@MultipartConfig(maxFileSize = 1024 * 1024 * 10)
public class StoryController extends HttpServlet {

    private StoryService_Interface storyService;
    private GenreService_Interface genreService;

    public StoryController() {
        this.storyService = new StoryService_Impl();
        this.genreService = new GenreService_Impl();
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
            case "viewAllStoriesInGenre":
                Integer genreId = Integer.valueOf(request.getParameter("genreId"));
                String genreName = request.getParameter("genreName");
                request.setAttribute("storiesInGenre", storyService.getStoriesInGenre(genreId));
                request.setAttribute("genreName", genreName);
                request.getRequestDispatcher("ViewStoriesInGenre.jsp").forward(request, response);
                break;
            case "searchForGenreAndStories":
                String searchValue = request.getParameter("searchValue");
                request.setAttribute("storiesFromSearch", storyService.searchForStories(searchValue));
                request.setAttribute("genresFromSearch", genreService.searchForGenres(searchValue));
                request.setAttribute("searchValue", searchValue);
                request.getRequestDispatcher("SearchResultsPage.jsp").forward(request, response);
                break;
            case "goToEditStories":
                request.setAttribute("submittedStories", storyService.getSubmittedStories());
                request.getRequestDispatcher("EditStoryPage.jsp").forward(request, response);
                break;
            case "addStory":
                Story story = new Story();
                System.out.println("Adding a stroy.");
                Writer author = (Writer) request.getSession(false).getAttribute("user");
                if (author != null) {
                    story.setAuthorId(author.getId());
                } else {
                    System.out.println("Author was null.");
                }
                Part filePart = request.getPart("image");
                if (filePart != null) {
                    try (InputStream fis = filePart.getInputStream()) {
                        byte[] imageData = new byte[(int) filePart.getSize()];
                        fis.read(imageData);
                        Byte[] image = new Byte[imageData.length];
                        for (int i = 0; i < imageData.length; i++) {
                            image[i] = (Byte) imageData[i];
                        }
                        story.setImage(image);
                    }
                } else {
                    System.out.println("Image was null.");
                }
                story.setTitle(request.getParameter("title"));
                story.setContent(request.getParameter("story"));
                story.setBlurb(request.getParameter("summary"));
                List<Genre> genres = genreService.getAllGenres();
                List<Integer> genreIds = new ArrayList<>();
                for (Genre genre : genres) {
                    if (request.getParameter(String.valueOf(genre.getId())) != null) {
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
                System.out.println("Finished adding a story.");
                request.getRequestDispatcher("createStory.jsp").forward(request, response);
                break;
            case "getTopPicks":
                request.setAttribute("getTopPicksCalled", Boolean.TRUE);
                request.setAttribute("topPicks", storyService.getTopPicks());
                request.getRequestDispatcher("index.jsp").forward(request, response);
                break;
            case "getTopPicksForTest":
                request.setAttribute("getTopPicksCalled", Boolean.TRUE);
                request.setAttribute("topPicks", storyService.getTopPicks());
                request.getRequestDispatcher("ImageTestWebPage.jsp").forward(request, response);
                break;
            case "getRecommendedStories":

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
