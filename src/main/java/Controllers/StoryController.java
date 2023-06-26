package Controllers;

import Models.*;
import ServiceLayers.CommentService_Impl;
import ServiceLayers.CommentService_Interface;
import ServiceLayers.GenreService_Impl;
import ServiceLayers.GenreService_Interface;
import ServiceLayers.StoryService_Impl;
import ServiceLayers.StoryService_Interface;
import ServiceLayers.LikeService_Impl;
import ServiceLayers.LikeService_Interface;
import ServiceLayers.RatingService_Impl;
import ServiceLayers.RatingService_Interface;
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
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.commons.lang3.ArrayUtils;

/**
 *
 * @author jarro
 */
@WebServlet(name = "StoryController", urlPatterns = {"/StoryController"})
@MultipartConfig(maxFileSize = 1024 * 1024 * 10)
public class StoryController extends HttpServlet {

    private Reader reader;
    private Writer writer;
    private Editor editor;
    private Account user;
    private StoryService_Interface storyService;
    private GenreService_Interface genreService;
    private CommentService_Interface commentService;
    private LikeService_Interface likeService;
    private RatingService_Interface ratingService;

    public StoryController() {
        this.storyService = new StoryService_Impl();
        this.genreService = new GenreService_Impl();
        this.commentService = new CommentService_Impl();
        this.likeService = new LikeService_Impl();
        this.ratingService = new RatingService_Impl();
        this.reader = null;
        this.writer = null;
        this.editor = null;
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession(false).getAttribute("user") != null) {
            user = ((Account)request.getSession(false).getAttribute("user"));
            switch (user.getUserType()) {
                case "R":
                    reader = (Reader) user;
                    break;
                case "W":
                    writer = (Writer) user;
                    reader = writer;
                    break;
                case "E":
                    editor = (Editor) user;
                    break;
                case "A":
                    editor = (Editor) user;
                    break;
                default:
                    throw new AssertionError();
            }
        }
        switch (request.getParameter("submit")) {
            case "viewStory":
                Integer storyId = Integer.valueOf(request.getParameter("storyId"));
                if (reader != null) {
                    request.setAttribute("userRating", ratingService.getRating(reader.getId(), storyId));
                }
                request.setAttribute("story", storyService.getStory(storyId));
                request.setAttribute("comments", commentService.getAllCommentForStory(storyId));
                request.getRequestDispatcher("DetailsPage.jsp").forward(request, response);
                break;
                
            case "readStory":
                storyId = Integer.valueOf(request.getParameter("storyId"));
                request.setAttribute("story", storyService.getStory(storyId));
                request.getRequestDispatcher("ReadStory.jsp").forward(request, response);
                break;
                
            case "likeStory":
                storyId = Integer.valueOf(request.getParameter("storyId"));
                Integer readerId = ((Reader)user).getId();
                Like like = new Like();
                like.setReaderId(readerId);
                like.setStoryId(storyId);
                reader.getFavouriteStoryIds().add(storyId);
                request.setAttribute("userRating", ratingService.getRating(reader.getId(), storyId));
                request.setAttribute("likeMessage", likeService.addLike(like));
                request.setAttribute("story", storyService.getStory(storyId));
                request.setAttribute("comments", commentService.getAllCommentForStory(storyId));
                request.getRequestDispatcher("DetailsPage.jsp").forward(request, response);

                break;
            case "unlikeStory":
                storyId = Integer.valueOf(request.getParameter("storyId"));
                readerId = reader.getId();
                like = new Like();
                like.setReaderId(readerId);
                like.setStoryId(storyId);
                reader.getFavouriteStoryIds().remove(storyId);
                request.setAttribute("userRating", ratingService.getRating(reader.getId(), storyId));
                request.setAttribute("likeMessage", likeService.deleteLike(like));
                request.setAttribute("story", storyService.getStory(storyId));
                request.setAttribute("comments", commentService.getAllCommentForStory(storyId));
                request.getRequestDispatcher("DetailsPage.jsp").forward(request, response);

                break;
            case "rateStory":
                storyId = Integer.valueOf(request.getParameter("storyId"));
                readerId = reader.getId();
                Rating rating = new Rating();
                rating.setReaderId(readerId);
                rating.setStoryId(storyId);
                rating.setValue(Integer.valueOf(request.getParameter("rate")));
                if (Boolean.parseBoolean(request.getParameter("isAdding"))) {
                    request.setAttribute("ratingMessage", ratingService.addRating(rating));
                } else {
                    request.setAttribute("ratingMessage", ratingService.updateRatingValue(rating));
                }
                request.setAttribute("userRating", ratingService.getRating(readerId, storyId));
                request.setAttribute("story", storyService.getStory(storyId));
                request.setAttribute("comments", commentService.getAllCommentForStory(storyId));
                request.getRequestDispatcher("DetailsPage.jsp").forward(request, response);
                break;
                
            case "commentStory":
                readerId = reader.getId();
                storyId = Integer.valueOf(request.getParameter("storyId"));
                String commentMessage = request.getParameter("comment");
                Comment comment = new Comment();
                comment.setMessage(commentMessage);
                comment.setName(request.getParameter("name"));
                comment.setSurname(request.getParameter("surname"));
                comment.setReaderId(readerId);
                comment.setStoryId(storyId);
                request.setAttribute("commentMessage", commentService.addComment(comment));
                request.setAttribute("userRating", ratingService.getRating(readerId, storyId));
                request.setAttribute("story", storyService.getStory(storyId));
                request.setAttribute("comments", commentService.getAllCommentForStory(storyId));
                request.getRequestDispatcher("DetailsPage.jsp").forward(request, response);
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
                
            case "goToSelectStoriesToEdit":
                request.setAttribute("submittedStories", storyService.getSubmittedStories());
                request.getRequestDispatcher("SelectStoryToEdit.jsp").forward(request, response);
                break;
                
            case "submitEditedStoryFromEditor":
                Story story = new Story();
                story.setApproved(Boolean.TRUE);
                story.setSubmitted(Boolean.TRUE);
                System.out.println("Updating a story.");
                Integer authorId = Integer.valueOf(request.getParameter("storyId"));
                storyId = Integer.valueOf(request.getParameter("storyId"));
                story.setId(storyId);
                story.setAuthorId(authorId);
                Part filePart = request.getPart("image");
                if (filePart.getSize()>0) {
                    try (InputStream fis = filePart.getInputStream()) {
                        byte[] imageData = new byte[(int) filePart.getSize()];
                        fis.read(imageData);
                        Byte[] image = ArrayUtils.toObject(imageData);
                        story.setImage(image);
                    }
                } else {
                    story.setImage(ArrayUtils.toObject(Base64.getDecoder().decode(request.getParameter("encodedImage"))));
                    System.out.println("Used original image for story.");
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
                    message = "Failed to update story: Please select genres for your story.";
                } else {
                    message = storyService.updateStory(story);
                    System.out.println("Updated story.");
                }
                request.setAttribute("message", message);
                request.setAttribute("submittedStories", storyService.getSubmittedStories());
                request.getRequestDispatcher("SelectStoryToEdit.jsp").forward(request, response);
                break;
                
            case "submitStoryFromSelectStoryToEditPage":
                storyId = Integer.valueOf(request.getParameter("storyId"));
                story = storyService.getStory(storyId);
                story.setApproved(Boolean.TRUE);
                story.setRejected(Boolean.FALSE);
                request.setAttribute("message", storyService.updateStory(story));
                request.setAttribute("submittedStories", storyService.getSubmittedStories());
                request.getRequestDispatcher("SelectStoryToEdit.jsp").forward(request, response);
                break;
                
            case "rejectStoryFromEditor":
                storyId = Integer.valueOf(request.getParameter("storyId"));
                story = storyService.getStory(storyId);
                story.setRejected(Boolean.TRUE);
                request.setAttribute("message", storyService.updateStory(story));
                request.setAttribute("submittedStories", storyService.getSubmittedStories());
                request.getRequestDispatcher("SelectStoryToEdit.jsp").forward(request, response);
                break;
                
            case "goToEditStoryForEditor":
                storyId = Integer.valueOf(request.getParameter("storyId"));
                story = storyService.getStory(storyId);
                request.setAttribute("story", story);
                request.getRequestDispatcher("EditStoryPage.jsp").forward(request, response);
                break;
                
            case "addStory":
                story = new Story();
                System.out.println("Adding a story.");
                if (writer != null) {
                    story.setAuthorId(writer.getId());
                } else {
                    System.out.println("Author was null.");
                }
                filePart = request.getPart("image");
                if (filePart != null) {
                    try (InputStream fis = filePart.getInputStream()) {
                        byte[] imageData = new byte[(int) filePart.getSize()];
                        fis.read(imageData);
                        Byte[] image = ArrayUtils.toObject(imageData);
                        story.setImage(image);
                    }
                } else {
                    System.out.println("Image was null.");
                }
                story.setTitle(request.getParameter("title"));
                story.setContent(request.getParameter("story"));
                story.setBlurb(request.getParameter("summary"));
                genres = genreService.getAllGenres();
                genreIds = new ArrayList<>();
                for (Genre genre : genres) {
                    if (request.getParameter(String.valueOf(genre.getId())) != null) {
                        genreIds.add(genre.getId());
                    }
                }
                story.setGenreIds(genreIds);
                if (genreIds.isEmpty()) {
                    message = "Failed to create story: Please select genres for your story.";
                } else {
                    message = storyService.addStory(story);
                }
                request.setAttribute("message", message);
                System.out.println("Finished adding a story.");
                request.getRequestDispatcher("createStory.jsp").forward(request, response);
                break;
                
            case "getStoriesForLandingPage":
                request.setAttribute("getTopPicksCalled", Boolean.TRUE);
                request.setAttribute("topPicks", storyService.getTopPicks());
                request.getRequestDispatcher("index.jsp").forward(request, response);
                break;
                
            case "getStoriesForReaderLandingPage":
                request.setAttribute("getStoriesForReaderLandingPageCalled", Boolean.TRUE);
                request.setAttribute("topPicks", storyService.getTopPicks());
                request.setAttribute("recommendedStories", storyService.getRecommendations(reader.getFavouriteGenreIds()));
                request.getRequestDispatcher("ReaderLandingPage.jsp").forward(request, response);
                break;
                
            case "getTopPicksForTest":
                request.setAttribute("getTopPicksCalled", Boolean.TRUE);
                request.setAttribute("topPicks", storyService.getTopPicks());
                request.getRequestDispatcher("ImageTestWebPage.jsp").forward(request, response);
                break;
                
            case "manageStories":
                request.setAttribute("submittedStories", storyService.getWritersSubmittedStories(writer.getSubmittedStoryIds(), writer.getId()));
                request.setAttribute("draftedStories", storyService.getWritersDraftedStories(writer.getDraftedStoryIds(), writer.getId()));
                request.getRequestDispatcher("ManageStory.jsp").forward(request, response);
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
