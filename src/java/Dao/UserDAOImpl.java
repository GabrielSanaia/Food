package Dao;

import Enum.Gender;
import Model.User;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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

            pstmt = conn.prepareStatement("INSERT INTO food_user (name,surname,username,password,gender) VALUES (?,?,?,?,?);");

            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getSurName());
            pstmt.setString(3, user.getUsername());
            pstmt.setInt(4, user.getPassword().hashCode());
            pstmt.setString(5, user.getGender().name());
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

                User user = new User(id, name, surname, username, password, gender);
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

                User user = new User(id, name, surname, username, password, gender);
                return user;

            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return null;
    }

    @Override
    public void changePassword(int user_id, String oldPassword, String newPassword) {

        try {
            User user = getUserById(user_id);

            if (Integer.parseInt(user.getPassword()) == oldPassword.hashCode()) {

                pstmt = conn.prepareStatement("UPDATE food_user SET password = ? WHERE id= ? ");
                pstmt.setInt(1, newPassword.hashCode());
                pstmt.setInt(2, user_id);
                pstmt.executeUpdate();
                
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }
}
