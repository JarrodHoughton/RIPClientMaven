/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package ServiceLayers;

import Models.Like;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;

/**
 *
 * @author jarro
 */
public interface LikeService_Interface {
    public String addLike(Like like);
    public String deleteLike(Integer likeId);
    public List<Like> getLikesByReaderId(Integer accountId);
    public List<Like> getLikesByStory(Integer storyId);
    public Integer getStoryLikesByDate(Integer storyId, Timestamp startDate, Timestamp endDate);    
    public List<Integer> getMostLikedBooks(Integer numberOfBooks, Timestamp startDate, Timestamp endDate);
}
