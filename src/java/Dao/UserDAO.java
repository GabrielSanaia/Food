package Dao;

import Model.Food;
import Model.User;
import java.util.ArrayList;

public interface UserDAO {

    void addUser(User user);

    User getUser(String username, String password);

    User getUserById(int id);

    boolean changePassword(int user_id, String oldPassword, String newPassword);

    void addFavorite(int user_id, int food_id);

    boolean checkFavorite(int user_id, int food_id);

    ArrayList<Integer> getFavoritesForUser(int user_id);

    void deleteFavorite(int user_id, int food_id);
}
