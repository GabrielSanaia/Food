package Dao;

import Model.User;

public interface UserDAO {

    void addUser(User user);

    User getUser(String username, String password);

    User getUserById(int id);

    boolean changePassword(int user_id, String oldPassword, String newPassword);
}
