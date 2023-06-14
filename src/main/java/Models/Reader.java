/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.util.List;

/**
 *
 * @author jarro
 */
public class Reader extends Account{
    private List<Integer> favouriteGenreIds;
    private List<Integer> favouriteStoryIds;

    public Reader(Integer id, String name, String surname, String email, String passwordHash, String salt, String phoneNumber, String userType, List<Integer> favouriteGenreIds, List<Integer> favouriteStoryIds) {
        super(id, name, surname, email, passwordHash, salt, phoneNumber, userType);
        this.favouriteGenreIds = favouriteGenreIds;
        this.favouriteStoryIds = favouriteStoryIds;
    }
    
    public Reader(){
        super();
    }

    public List<Integer> getFavouriteGenreIds() {
        return favouriteGenreIds;
    }

    public void setFavouriteGenreIds(List<Integer> favouriteGenreIds) {
        this.favouriteGenreIds = favouriteGenreIds;
    }

    public List<Integer> getFavouriteStoryIds() {
        return favouriteStoryIds;
    }

    public void setFavouriteStoryIds(List<Integer> favouriteStoryIds) {
        this.favouriteStoryIds = favouriteStoryIds;
    }

    @Override
    public String toString() {
        return "Reader{" + super.toString() +"favouriteGenreIds=" + favouriteGenreIds + ", favouriteStoryIds=" + favouriteStoryIds + '}';
    }
}
