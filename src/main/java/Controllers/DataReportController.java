package Controllers;

import Models.Editor;
import Models.Genre;
import Models.Story;
import Models.Writer;
import ServiceLayers.DataReportService_Impl;
import ServiceLayers.DataReportService_Interface;
import ServiceLayers.EditorService_Impl;
import ServiceLayers.EditorService_Interface;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "DataReportController", urlPatterns = {"/DataReportController"})
public class DataReportController extends HttpServlet {

    private DataReportService_Interface dataReportService;
    private EditorService_Interface editorService;

    public DataReportController() {
        this.dataReportService = new DataReportService_Impl();
        this.editorService = new EditorService_Impl();
    }

    private String dataLabel;
    private String valueLabel;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String submitAction = request.getParameter("submit");
        if (submitAction == null) {
            // Handle the case when no submit parameter is provided
            // You can choose to redirect or show an error message
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid request");
            return;
        }

        switch (submitAction) {
            case "mosteditors":
                dataLabel = "Editor";
                valueLabel = "Number of approvals";

                Integer numberOfEditors = 2;

                List<Editor> listOfEditors = dataReportService.getTopEditors(numberOfEditors);

                if (listOfEditors == null) {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "No editors found");
                    return;
                }

                List<String> editorNames = new ArrayList<>();
                List<Integer> listOfNumberOfApprovals = new ArrayList<>();

                for (Editor topEditor : listOfEditors) {
                    editorNames.add(topEditor.getName());
                    listOfNumberOfApprovals.add(topEditor.getApprovalCount());
                }

                request.setAttribute("dataLabels", editorNames);
                request.setAttribute("dataValues", listOfNumberOfApprovals);
                request.setAttribute("dataLabelString", dataLabel);
                request.setAttribute("valueLabelString", valueLabel);

                request.getRequestDispatcher("datareport.jsp").forward(request, response);
                break;

            case "mostlikedstories":
                Integer numberOfStories = 2;

                dataLabel = "Story";
                valueLabel = "Number of likes";

                List<Story> listOfStories = dataReportService.getMostLikedStories(numberOfStories, "2023-05-22 12:57:49", "2023-06-23 12:57:49");

                if (listOfStories == null) {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "No stories found");
                    return;
                }

                List<String> storyTitless = new ArrayList<>();
                List<Integer> listOfNumberOfStoryLikes = new ArrayList<>();

                for (Story topStory : listOfStories) {
                    storyTitless.add(topStory.getTitle());
                    listOfNumberOfStoryLikes.add(dataReportService.getStoryLikesByDate(topStory.getId(), "2023-05-22 12:57:49", "2023-06-30 12:57:49"));
                }

                request.setAttribute("dataLabels", storyTitless);
                request.setAttribute("dataValues", listOfNumberOfStoryLikes);
                request.setAttribute("dataLabelString", dataLabel);
                request.setAttribute("valueLabelString", valueLabel);
                request.getRequestDispatcher("datareport.jsp").forward(request, response);

                break;

            case "topratedstories":
                Integer numberOfTopRatedStories = 2;

                dataLabel = "Story";
                valueLabel = "Average rating";

                List<Story> listOfTopRatedStories = dataReportService.getTopHighestRatedStoriesInTimePeriod("2023-05-22 12:57:49", "2023-06-30 12:57:49", numberOfTopRatedStories);

                if (listOfTopRatedStories == null) {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "No stories found");
                    return;
                }

                List<String> topRatedStoryTitles = new ArrayList<>();
                List<Double> listOfAverageRatings = new ArrayList<>();

                for (Story topRatedStory : listOfTopRatedStories) {
                    topRatedStoryTitles.add(topRatedStory.getTitle());
                    listOfAverageRatings.add(dataReportService.getAverageRatingOfAStoryInATimePeriod(topRatedStory.getId(), "2023-05-22 12:57:49", "2023-06-30 12:57:49"));
                }

                request.setAttribute("dataLabels", topRatedStoryTitles);
                request.setAttribute("dataValues", listOfAverageRatings);
                request.setAttribute("dataLabelString", dataLabel);
                request.setAttribute("valueLabelString", valueLabel);
                request.getRequestDispatcher("datareport.jsp").forward(request, response);

                break;

            case "topwriters":
                Integer numberOfTopWriters = 2;

                dataLabel = "Writer";
                valueLabel = "Number of views";

                List<Writer> listOfTopWriters = dataReportService.getTopWriters(numberOfTopWriters);

                if (listOfTopWriters == null) {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "No writers found");
                    return;
                }

                List<String> writerNames = new ArrayList<>();
                List<Integer> listOfNumberOfStories = new ArrayList<>();

                for (Writer topWriter : listOfTopWriters) {
                    writerNames.add(topWriter.getName());
                    listOfNumberOfStories.add(dataReportService.getTotalViewsByWriterId(topWriter.getId()));
                }

                request.setAttribute("dataLabels", writerNames);
                request.setAttribute("dataValues", listOfNumberOfStories);
                request.setAttribute("dataLabelString", dataLabel);
                request.setAttribute("valueLabelString", valueLabel);
                request.getRequestDispatcher("datareport.jsp").forward(request, response);

                break;

            case "topgenres":
                Integer numberOfTopGenres = 2;

                dataLabel = "Genre";
                valueLabel = "Number of views";

                List<Genre> listOfTopGenres = dataReportService.getTopGenres("2023-05-22 12:57:49", "2023-06-30 12:57:49", numberOfTopGenres);

                if (listOfTopGenres == null) {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "No genres found");
                    return;
                }

                List<String> genreNames = new ArrayList<>();
                List<Integer> listOfNumberOfGenreViews = new ArrayList<>();

                for (Genre topGenre : listOfTopGenres) {
                    genreNames.add(topGenre.getName());
                    listOfNumberOfGenreViews.add(dataReportService.getGenreViewsByDate("2023-05-22 12:57:49", "2023-06-30 12:57:49", topGenre.getId()));
                }

                request.setAttribute("dataLabels", genreNames);
                request.setAttribute("dataValues", listOfNumberOfGenreViews);
                request.setAttribute("dataLabelString", dataLabel);
                request.setAttribute("valueLabelString", valueLabel);
                request.getRequestDispatcher("datareport.jsp").forward(request, response);

                break;

            case "mostviewedstories":
                Integer numberOfStoriess = 2;

                dataLabel = "Story";
                valueLabel = "Number of views";

                List<Story> listOfStoriess = dataReportService.getMostViewedStoriesInATimePeriod(numberOfStoriess, "2023-05-22 12:57:49", "2023-06-23 12:57:49");

                if (listOfStoriess == null) {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "No stories found");
                    return;
                }

                List<String> storyTitles = new ArrayList<>();
                List<Integer> listOfNumberOfStoryViews = new ArrayList<>();

                for (Story topStoree : listOfStoriess) {
                    storyTitles.add(topStoree.getTitle());
                    listOfNumberOfStoryViews.add(dataReportService.getTheViewsOnAStoryInATimePeriod(topStoree.getId(), "2023-05-22 12:57:49", "2023-06-30 12:57:49"));
                }

                request.setAttribute("dataLabels", storyTitles);
                request.setAttribute("dataValues", listOfNumberOfStoryViews);
                request.setAttribute("dataLabelString", dataLabel);
                request.setAttribute("valueLabelString", valueLabel);
                request.getRequestDispatcher("datareport.jsp").forward(request, response);

                break;

            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
                break;
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

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
