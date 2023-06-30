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


@WebServlet(name = "DataReportController", urlPatterns = {
    "/DataReportController"
})
public class DataReportController extends HttpServlet {

    private DataReportService_Interface dataReportService;
    private EditorService_Interface editorService;

    public DataReportController() {
        this.dataReportService = new DataReportService_Impl();
        this.editorService = new EditorService_Impl();
    }


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String submitAction = request.getParameter("submit");
        if (submitAction == null) {
            // Handle the case when no submit parameter is provided
            // You can choose to redirect or show an error message
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid request");
            return;
        }
        DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

        switch (submitAction) {
            case "showcharts":
                // Getting the editors with the most approvals
                Integer numberOfEditors = 3;
                String dataLabel1 = "Name of editor";
                String valueLabel1 = "Number of approvals";
                String titleLabel1 = "The editors with the most approvals";
                List < Editor > listOfEditors = dataReportService.getTopEditors(numberOfEditors);

                if (listOfEditors == null) {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "No editors found");
                    return;
                }

                List < String > editorNames = new ArrayList < > ();
                List < Integer > listOfNumberOfApprovals = new ArrayList < > ();

                for (Editor topEditor: listOfEditors) {
                    editorNames.add(topEditor.getName());
                    listOfNumberOfApprovals.add(topEditor.getApprovalCount());
                }

                request.setAttribute("dataLabels1", editorNames);
                request.setAttribute("dataValues1", listOfNumberOfApprovals);
                request.setAttribute("dataLabelString1", dataLabel1);
                request.setAttribute("valueLabelString1", valueLabel1);
                request.setAttribute("charttitle1", titleLabel1);

                // Getting the stories with the most likes
                Integer numberOfStories = 20;
                String dataLabel2 = "Story";
                String valueLabel2 = "Number of likes";
                String titleLabel2 = "The most liked stories";
                String startDateParam1 = request.getParameter("startDate1");
                String endDateParam1 = request.getParameter("endDate1");

                List<Story> listOfStories;
                List<String> storyTitles;
                List<Integer> listOfNumberOfStoryLikes;

                if (startDateParam1 == null || endDateParam1 == null || startDateParam1.isEmpty()
                        || endDateParam1.isEmpty()) {
                    listOfStories = new ArrayList<>();
                    storyTitles = new ArrayList<>();
                    listOfNumberOfStoryLikes = new ArrayList<>();
                } else {
                    LocalDate startDate1 = null;
                    LocalDate endDate1 = null;

                    try {
                        startDate1 = LocalDate.parse(startDateParam1);
                        endDate1 = LocalDate.parse(endDateParam1);
                    } catch (DateTimeParseException e) {
                        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid date format");
                        return;
                    }

                    LocalDateTime startDateTime1 = startDate1.atStartOfDay();
                    LocalDateTime endDateTime1 = endDate1.atTime(23, 59, 59);

                    String formattedStartDate1 = startDateTime1.format(outputFormatter);
                    String formattedEndDate1 = endDateTime1.format(outputFormatter);

                    listOfStories = dataReportService.getMostLikedStories(numberOfStories, formattedStartDate1,
                            formattedEndDate1);

                    if (listOfStories == null) {
                        listOfStories = new ArrayList<>();
                    }

                    storyTitles = new ArrayList<>();
                    listOfNumberOfStoryLikes = new ArrayList<>();

                    for (Story topStory : listOfStories) {
                        storyTitles.add(topStory.getTitle());
                        listOfNumberOfStoryLikes.add(dataReportService.getStoryLikesByDate(topStory.getId(),
                                formattedStartDate1, formattedEndDate1));
                    }
                }

                request.setAttribute("dataLabels2", storyTitles);
                request.setAttribute("dataValues2", listOfNumberOfStoryLikes);
                request.setAttribute("dataLabelString2", dataLabel2);
                request.setAttribute("valueLabelString2", valueLabel2);
                request.setAttribute("charttitle2", titleLabel2);


    //Getting the top rated stories
    Integer numberOfTopRatedStories = 20;
    String dataLabel3 = "Story";
    String valueLabel3 = "Average rating";
    String titleLabel3 = "Top rated stories";
    String startDateParam2 = request.getParameter("startDate2");
    String endDateParam2 = request.getParameter("endDate2");

    List<Story> listOfTopRatedStories;
    List<String> topRatedStoryTitles;
    List<Double> listOfAverageRatings = new ArrayList<>();

    if (startDateParam2 == null || endDateParam2 == null || startDateParam2.isEmpty()
            || endDateParam2.isEmpty()) {
        listOfTopRatedStories = new ArrayList<>();
        topRatedStoryTitles = new ArrayList<>();
    } else {
        LocalDate startDate2 = null;
        LocalDate endDate2 = null;

        try {
            startDate2 = LocalDate.parse(startDateParam2);
            endDate2 = LocalDate.parse(endDateParam2);
        } catch (DateTimeParseException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid date format");
            return;
        }

        LocalDateTime startDateTime2 = startDate2.atStartOfDay();
        LocalDateTime endDateTime2 = endDate2.atTime(23, 59, 59);
        String formattedStartDate2 = startDateTime2.format(outputFormatter);
        String formattedEndDate2 = endDateTime2.format(outputFormatter);

        listOfTopRatedStories = dataReportService.getTopHighestRatedStoriesInTimePeriod(formattedStartDate2, formattedEndDate2,numberOfTopRatedStories);

        if (listOfTopRatedStories == null) {
            listOfTopRatedStories = new ArrayList<>();
        }

        topRatedStoryTitles = new ArrayList<>();
       

        for (Story topRatedStory : listOfTopRatedStories) {
            topRatedStoryTitles.add(topRatedStory.getTitle());
            listOfAverageRatings.add(dataReportService.getAverageRatingOfAStoryInATimePeriod(topRatedStory.getId(), startDateParam2, endDateParam2));

        }
    }

    request.setAttribute("dataLabels3", topRatedStoryTitles);
    request.setAttribute("dataValues3", listOfAverageRatings);
    request.setAttribute("dataLabelString3", dataLabel3);
    request.setAttribute("valueLabelString3", valueLabel3);
    request.setAttribute("charttitle3", titleLabel3);

   //Getting the top writers
                Integer numberOfTopWriters = 30;
                String dataLabel4 = "Writer";
                String valueLabel4 = "Number of views";
                String titleLabel4 = "The top writers";

                List < Writer > listOfTopWriters = dataReportService.getTopWriters(numberOfTopWriters);

                if (listOfTopWriters == null) {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "No writers found");
                    return;
                }

                List < String > writerNames = new ArrayList < > ();
                List < Integer > listOfNumberOfStories = new ArrayList < > ();

                for (Writer topWriter: listOfTopWriters) {
                    writerNames.add(topWriter.getName());
                    listOfNumberOfStories.add(dataReportService.getTotalViewsByWriterId(topWriter.getId()));
                }

                request.setAttribute("dataLabels4", writerNames);
                request.setAttribute("dataValues4", listOfNumberOfStories);
                request.setAttribute("dataLabelString4", dataLabel4);
                request.setAttribute("valueLabelString4", valueLabel4);
                request.setAttribute("charttitle4", titleLabel4);

                //Getting the top genres
    Integer numberOfTopGenres = 3;
    String dataLabel5 = "Genre";
    String valueLabel5 = "Number of views";
    String titleLabel5 = "The top genres";
    String startDateParam3 = request.getParameter("startDate3");
    String endDateParam3 = request.getParameter("endDate3");

    List<Genre> listOfTopGenres;
    List<String> genreNames;
    List<Integer> listOfNumberOfGenreViews;

    if (startDateParam3 == null || endDateParam3 == null || startDateParam3.isEmpty()
            || endDateParam3.isEmpty()) {
        listOfTopGenres = new ArrayList<>();
        genreNames = new ArrayList<>();
        listOfNumberOfGenreViews = new ArrayList<>();
    } else {
        LocalDate startDate3 = null;
        LocalDate endDate3 = null;

        try {
            startDate3 = LocalDate.parse(startDateParam3);
            endDate3 = LocalDate.parse(endDateParam3);
        } catch (DateTimeParseException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid date format");
            return;
        }

        LocalDateTime startDateTime3 = startDate3.atStartOfDay();
        LocalDateTime endDateTime3 = endDate3.atTime(23, 59, 59);
        String formattedStartDate3 = startDateTime3.format(outputFormatter);
        String formattedEndDate3 = endDateTime3.format(outputFormatter);

        listOfTopGenres = dataReportService.getTopGenres(formattedStartDate3, formattedEndDate3, numberOfTopGenres);

        if (listOfTopGenres == null) {
            listOfTopGenres = new ArrayList<>();
        }

        genreNames = new ArrayList<>();
        listOfNumberOfGenreViews = new ArrayList<>();

        for (Genre topGenre : listOfTopGenres) {
            genreNames.add(topGenre.getName());
            listOfNumberOfGenreViews.add(dataReportService.getGenreViewsByDate(formattedStartDate3, formattedEndDate3, topGenre.getId()));
        }
    }

    request.setAttribute("dataLabels5", genreNames);
    request.setAttribute("dataValues5", listOfNumberOfGenreViews);
    request.setAttribute("dataLabelString5", dataLabel5);
    request.setAttribute("valueLabelString5", valueLabel5);
    request.setAttribute("charttitle5", titleLabel5);

                //Getting the most viewed stories
    Integer numberOfStoriess = 10;
    String dataLabel6 = "Story";
    String valueLabel6 = "Number of views";
    String titleLabel6 = "The most viewed stories";
    String startDateParam4 = request.getParameter("startDate4");
    String endDateParam4 = request.getParameter("endDate4");

    List<Story> listOfStoriess;
    List<String> storyTitless;
    List<Integer> listOfNumberOfStoryViews;

    if (startDateParam4 == null || endDateParam4 == null || startDateParam4.isEmpty()
            || endDateParam4.isEmpty()) {
        listOfStoriess = new ArrayList<>();
        storyTitless = new ArrayList<>();
        listOfNumberOfStoryViews = new ArrayList<>();
    } else {
        LocalDate startDate4 = null;
        LocalDate endDate4 = null;

        try {
            startDate4 = LocalDate.parse(startDateParam4);
            endDate4 = LocalDate.parse(endDateParam4);
        } catch (DateTimeParseException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid date format");
            return;
        }

        LocalDateTime startDateTime4 = startDate4.atStartOfDay();
        LocalDateTime endDateTime4 = endDate4.atTime(23, 59, 59);
        String formattedStartDate4 = startDateTime4.format(outputFormatter);
        String formattedEndDate4 = endDateTime4.format(outputFormatter);

        listOfStories = dataReportService.getMostViewedStoriesInATimePeriod(numberOfStoriess, formattedStartDate4, formattedEndDate4);

        if (listOfStories == null) {
            listOfStories = new ArrayList<>();
        }

        storyTitless = new ArrayList<>();
        listOfNumberOfStoryViews = new ArrayList<>();

        for (Story topStory : listOfStories) {
            storyTitless.add(topStory.getTitle());
            listOfNumberOfStoryViews.add(dataReportService.getTheViewsOnAStoryInATimePeriod(topStory.getId(), formattedStartDate4, formattedEndDate4));
        }
    }

    request.setAttribute("dataLabels6", storyTitles);
    request.setAttribute("dataValues6", listOfNumberOfStoryViews);
    request.setAttribute("dataLabelString6", dataLabel6);
    request.setAttribute("valueLabelString6", valueLabel6);
    request.setAttribute("charttitle6", titleLabel6);
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