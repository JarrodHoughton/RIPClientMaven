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
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

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
    private String titleLabel;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String submitAction = request.getParameter("submit");
        if (submitAction == null) {
            // Handle the case when no submit parameter is provided
            // You can choose to redirect or show an error message
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid request");
            return;
        }
        
    
// Retrieve the date range parameters as strings
String startDateParam = request.getParameter("startDate");
String endDateParam = request.getParameter("endDate");

// Check if the parameters are null
if (startDateParam == null || endDateParam == null) {
    // Handle the case when the parameters are missing
    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Start date and/or end date parameters are missing");
    return;
}

// Parse the strings into LocalDate objects
LocalDate startDate = null;
LocalDate endDate = null;
try {
    startDate = LocalDate.parse(startDateParam);
    endDate = LocalDate.parse(endDateParam);
} catch (DateTimeParseException e) {
    // Handle the case when the date parsing fails
    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid date format");
    return;
}

// Create LocalDateTime objects with desired time values
LocalDateTime startDateTime = startDate.atStartOfDay();
LocalDateTime endDateTime = endDate.atTime(23, 59, 59);

// Format the LocalDateTime objects into the desired format
DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
String formattedStartDate = startDateTime.format(outputFormatter);
String formattedEndDate = endDateTime.format(outputFormatter);



        switch (submitAction) {
            case "mosteditors":
                dataLabel = "Name of editor";
                valueLabel = "Number of approvals";
                titleLabel = "The editors with the most approvals";

                Integer numberOfEditors = 3;

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
                request.setAttribute("charttitle", titleLabel);
                request.getRequestDispatcher("datareport.jsp").forward(request, response);
                break;

            case "mostlikedstories":
                Integer numberOfStories = 20;


                dataLabel = "Story";
                valueLabel = "Number of likes";
                titleLabel = "The most liked stories";

                List<Story> listOfStories = dataReportService.getMostLikedStories(numberOfStories, formattedStartDate, formattedEndDate );

                if (listOfStories == null) {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "No stories found");
                    return;
                }

                List<String> storyTitles = new ArrayList<>();
                List<Integer> listOfNumberOfStoryLikes = new ArrayList<>();

                for (Story topStory : listOfStories) {
                    storyTitles.add(topStory.getTitle());
                    listOfNumberOfStoryLikes.add(dataReportService.getStoryLikesByDate(topStory.getId(), formattedStartDate, formattedEndDate));
                }

                request.setAttribute("dataLabels", storyTitles);
                request.setAttribute("dataValues", listOfNumberOfStoryLikes);
                request.setAttribute("dataLabelString", dataLabel);
                request.setAttribute("valueLabelString", valueLabel);
                request.setAttribute("charttitle", titleLabel);
                request.getRequestDispatcher("datareport.jsp").forward(request, response);

                break;

            case "topratedstories":
                Integer numberOfTopRatedStories = 20;


                dataLabel = "Story title";
                valueLabel = "Average rating";
                titleLabel = "The top rated stories";

                List<Story> listOfTopRatedStories = dataReportService.getTopHighestRatedStoriesInTimePeriod(formattedStartDate, formattedEndDate, numberOfTopRatedStories);

                if (listOfTopRatedStories == null) {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "No stories found");
                    return;
                }

                List<String> topRatedStoryTitles = new ArrayList<>();
                List<Double> listOfAverageRatings = new ArrayList<>();

                for (Story topRatedStory : listOfTopRatedStories) {
                    topRatedStoryTitles.add(topRatedStory.getTitle());
                    listOfAverageRatings.add(dataReportService.getAverageRatingOfAStoryInATimePeriod(topRatedStory.getId(), formattedStartDate, formattedEndDate));
                }

                request.setAttribute("dataLabels", topRatedStoryTitles);
                request.setAttribute("dataValues", listOfAverageRatings);
                request.setAttribute("dataLabelString", dataLabel);
                request.setAttribute("valueLabelString", valueLabel);
                request.setAttribute("charttitle", titleLabel);
                request.getRequestDispatcher("datareport.jsp").forward(request, response);

                break;

            case "topwriters":
                Integer numberOfTopWriters = 30;

                dataLabel = "Writer";
                valueLabel = "Number of views";
                titleLabel = "The top writers";

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
                request.setAttribute("charttitle", titleLabel);
                request.getRequestDispatcher("datareport.jsp").forward(request, response);

                break;

            case "topgenres":
                Integer numberOfTopGenres = 3;

                dataLabel = "Genre";
                valueLabel = "Number of views";
                titleLabel = "The top genres";

                List<Genre> listOfTopGenres = dataReportService.getTopGenres(formattedStartDate, formattedEndDate, numberOfTopGenres);

                if (listOfTopGenres == null) {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "No genres found");
                    return;
                }

                List<String> genreNames = new ArrayList<>();
                List<Integer> listOfNumberOfGenreViews = new ArrayList<>();

                for (Genre topGenre : listOfTopGenres) {
                    genreNames.add(topGenre.getName());
                    listOfNumberOfGenreViews.add(dataReportService.getGenreViewsByDate(formattedStartDate, formattedEndDate, topGenre.getId()));
                }

                request.setAttribute("dataLabels", genreNames);
                request.setAttribute("dataValues", listOfNumberOfGenreViews);
                request.setAttribute("dataLabelString", dataLabel);
                request.setAttribute("valueLabelString", valueLabel);
                request.setAttribute("charttitle", titleLabel);
                request.getRequestDispatcher("datareport.jsp").forward(request, response);

                break;

            case "mostviewedstories":
                Integer numberOfStoriess = 10;

                dataLabel = "Story";
                valueLabel = "Number of views";
                titleLabel = "The most viewed stories";

                List<Story> listOfStoriess = dataReportService.getMostViewedStoriesInATimePeriod(numberOfStoriess, formattedStartDate, formattedEndDate);

                if (listOfStoriess == null) {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "No stories found");
                    return;
                }

                List<String> storyTitless = new ArrayList<>();
                List<Integer> listOfNumberOfStoryViews = new ArrayList<>();

                for (Story topStoree : listOfStoriess) {
                    storyTitless.add(topStoree.getTitle());
                    listOfNumberOfStoryViews.add(dataReportService.getTheViewsOnAStoryInATimePeriod(topStoree.getId(), formattedStartDate, formattedEndDate));
                }

                request.setAttribute("dataLabels", storyTitless);
                request.setAttribute("dataValues", listOfNumberOfStoryViews);
                request.setAttribute("dataLabelString", dataLabel);
                request.setAttribute("valueLabelString", valueLabel);
                request.setAttribute("charttitle", titleLabel);
                request.getRequestDispatcher("datareport.jsp").forward(request, response);

                break;

            default:
                request.getRequestDispatcher("datareport.jsp").forward(request, response);
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
