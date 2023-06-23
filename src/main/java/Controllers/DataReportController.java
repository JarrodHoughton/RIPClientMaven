package Controllers;

import Models.Story;
import ServiceLayers.DataReportService_Impl;
import ServiceLayers.DataReportService_Interface;

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

    public DataReportController() {
        this.dataReportService = new DataReportService_Impl();
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

        switch (submitAction) {
            case "mostliked":
                String startDate = "2023-01-01 00:00:00";
                String endDate = "2023-06-30 23:59:59";
                Integer numberOfStories = 2;
                
                

                List<Story> listOfStories = dataReportService.getMostLikedStories(numberOfStories, startDate, endDate);

                if (listOfStories == null) {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "No stories found");
                    return;
                }

                List<String> listOfStoryNames = new ArrayList<>();
                List<Integer> listOfNumberOfLikes = new ArrayList<>();

                for (Story topStory : listOfStories) {
                    listOfStoryNames.add(topStory.getTitle());
                    listOfNumberOfLikes.add(dataReportService.getStoryLikesByDate(topStory.getId(), startDate, endDate));
                }

                request.setAttribute("storynames", listOfStoryNames);
                request.setAttribute("numberoflikes", listOfNumberOfLikes);
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
