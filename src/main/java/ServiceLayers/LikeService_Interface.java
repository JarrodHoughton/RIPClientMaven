/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package ServiceLayers;

import Models.Like;
import java.util.HashMap;
import java.util.List;

/**
 *
 * @author jarro
 */
public interface LikeService_Interface {
    public String addLike(Like like);
    public String delete(Integer likeId);
    public List<Like> getLikesByReaderId(Integer readerId);
    public List<Like> getLikesByStory(Integer storyId);
    public List<Like> getMostLikedBooks(HashMap<String, String> parameters);
}
