/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package ServiceLayers;

import java.util.HashMap;
import java.util.List;

/**
 *
 * @author jarro
 */
public interface RatingService_Interface {
    public Boolean addRating(Integer accountId, Integer storyId, Integer ratingValue);
    public List<Integer> getTopHighestRatedStoriesInTimePeriod(HashMap<String, String> parameters); //HashMap contains -> startDate, endDate, numberOfEntries
}
