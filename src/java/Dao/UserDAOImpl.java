package Dao;

import Enum.Gender;
import Model.Food;
import Model.User;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UserDAOImpl implements UserDAO {

    private Connection conn;

    private PreparedStatement pstmt;

    public UserDAOImpl() {

        try {

            Class.forName("org.postgresql.Driver");

            conn = DriverManager.getConnection(DatabaseUtil.databaseURL, DatabaseUtil.username, DatabaseUtil.passsword);

        } catch (ClassNotFoundException | SQLException ex) {

            System.out.println(ex.getMessage());

        }

    }

    @Override
    public void addUser(User user) {

        try {

            pstmt = conn.prepareStatement("INSERT INTO food_user (name,surname,username,password,gender,imagepath) VALUES (?,?,?,?,?,?);");

            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getSurName());
            pstmt.setString(3, user.getUsername());
            pstmt.setInt(4, user.getPassword().hashCode());
            pstmt.setString(5, user.getGender().name());
            pstmt.setString(6, user.getImagePath());
            pstmt.executeUpdate();

        } catch (SQLException ex) {

            System.out.println(ex.getMessage());

        }
    }

    @Override
    public User getUser(String username, String password) {

        try {

            String sql = "SELECT * FROM food_user WHERE username = ? AND password = ?";
            pstmt = conn.prepareStatement(sql);
            String s = Integer.toString(password.hashCode());
            pstmt.setString(1, username);
            pstmt.setString(2, s);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String surname = rs.getString("surname");
                Gender gender = Gender.valueOf(rs.getString("gender"));
                String imagePath = rs.getString("imagepath");
                User user = new User(id, name, surname, username, password, gender, imagePath);
                return user;

            } else {

                return null;

            }

        } catch (SQLException ex) {

            System.out.println(ex.getMessage());

        }

        return null;

    }

    @Override
    public User getUserById(int id) {
        try {
            String sql = "SELECT * FROM food_user WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {

                String name = rs.getString("name");
                String surname = rs.getString("surname");
                String username = rs.getString("username");
                String password = rs.getString("password");
                Gender gender = Gender.valueOf(rs.getString("gender"));
                String imagePath = rs.getString("imagepath");
                User user = new User(id, name, surname, username, password, gender, imagePath);
                return user;

            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return null;
    }

    @Override
    public boolean changePassword(int user_id, String oldPassword, String newPassword) {

        try {
            User user = getUserById(user_id);

            if (Integer.parseInt(user.getPassword()) == oldPassword.hashCode()) {

                pstmt = conn.prepareStatement("UPDATE food_user SET password = ? WHERE id= ? ");
                pstmt.setInt(1, newPassword.hashCode());
                pstmt.setInt(2, user_id);
                int b = pstmt.executeUpdate();
                if (b > 0) {
                    return true;
                }
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return false;
    }

    @Override
    public void addFavorite(int user_id, int food_id) {

        try {

            pstmt = conn.prepareStatement("INSERT INTO favorites (user_id,food_id) VALUES (?,?);");
            pstmt.setInt(1, user_id);
            pstmt.setInt(2, food_id);
            pstmt.executeUpdate();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    @Override
    public boolean checkFavorite(int user_id, int food_id) {

        try {
            pstmt = conn.prepareStatement("SELECT FROM favorites WHERE user_id = ? AND food_id = ?");
            pstmt.setInt(1, user_id);
            pstmt.setInt(2, food_id);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                return true;
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return false;
    }

    @Override
    public ArrayList<Food> getFavoritesForUser(int user_id) {
        FoodDAO fdao = new FoodDAOImpl();

        ArrayList<Food> foods = new ArrayList<>();
        try {
            pstmt = conn.prepareStatement("SELECT * FROM favorites WHERE user_id = ?");
            pstmt.setInt(1, user_id);
            
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {

                int food_id = rs.getInt("food_id");
                Food food = fdao.getFoodById(food_id);
                food.setId(food_id);
                foods.add(food);
            }

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return foods;
    }

    @Override
    public void deleteFavorite(int user_id, int food_id) {

        try {
            pstmt = conn.prepareStatement("DELETE FROM favorites WHERE user_id = ? AND food_id = ?");
            pstmt.setInt(1, user_id);
            pstmt.setInt(2, food_id);
            pstmt.execute();
        } catch (SQLException ex) {
            Logger.getLogger(UserDAOImpl.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

}
