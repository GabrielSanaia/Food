package Dao;

import Enum.FoodType;
import Model.Food;
import Model.Ingredient;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.logging.Level;
import java.util.logging.Logger;

public class FoodDAOImpl implements FoodDAO {

    private Connection con;

    private PreparedStatement pstmt;

    public FoodDAOImpl() {
        try {
            Class.forName("org.postgresql.Driver");
            con = DriverManager.getConnection(DatabaseUtil.databaseURL, DatabaseUtil.username, DatabaseUtil.passsword);
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    @Override
    public void addFood(Food food) {

        try {

            ArrayList<Ingredient> inArray = food.getIngredients();
            String ingredients = Ingredient.objectsToString(inArray);
            pstmt = con.prepareStatement("INSERT INTO FOOD (name,foodtype,cooking_way,ingredients,imagePath,user_id) VALUES (?,?,?,?,?,?);");
            pstmt.setString(1, food.getName());
            pstmt.setString(2, food.getFoodtype().name());
            pstmt.setString(3, food.getCooking_way());
            pstmt.setString(4, ingredients);
            pstmt.setString(5, food.getImagePath());
            pstmt.setInt(6, food.getUser_id());
            pstmt.executeUpdate();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }

    }

    @Override
    public ArrayList<Food> getAllFoods() {

        ArrayList<Food> foods = new ArrayList<>();
        try {
            pstmt = con.prepareStatement("SELECT * FROM food");
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {

                int id = rs.getInt("id");
                String name = rs.getString("name");
                FoodType type = FoodType.valueOf(rs.getString("foodtype"));
                String cooking_way = rs.getString("cooking_way");
                String ingredients = rs.getString("ingredients");
                String imagePath = rs.getString("imagePath");
                int user_id = rs.getInt("user_id");
                ArrayList<Ingredient> ins = new ArrayList<>();
                ins = Ingredient.stringToObject(ingredients);

                Food food = new Food(id, ins, name, type, cooking_way, imagePath, user_id);
                foods.add(food);

            }

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return foods;
    }

    @Override
    public Food getFoodById(int id) {
        try {
            pstmt = con.prepareStatement("SELECT * FROM food WHERE id = ?");
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                String name = rs.getString("name");
                FoodType type = FoodType.valueOf(rs.getString("foodtype"));
                String cooking_way = rs.getString("cooking_way");
                String ingredients = rs.getString("ingredients");
                String imagePath = rs.getString("imagePath");
                int user_id = rs.getInt("user_id");
                ArrayList<Ingredient> ins = new ArrayList<>();
                ins = Ingredient.stringToObject(ingredients);

                Food food = new Food(ins, name, type, cooking_way, imagePath, user_id);
                return food;
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return null;
    }

    @Override
    public ArrayList<Food> getFoodByName(String name) {
        ArrayList<Food> foods = new ArrayList<>();
        try {
            pstmt = con.prepareStatement("SELECT * FROM food WHERE name = ?");

            byte namebytes[] = name.getBytes("ISO-8859-1");
            name = new String(namebytes, "UTF-8");

            pstmt.setString(1, name);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {

                int id = Integer.parseInt(rs.getString("id"));
                FoodType type = FoodType.valueOf(rs.getString("foodtype"));
                String cooking_way = rs.getString("cooking_way");
                String ingredients = rs.getString("ingredients");
                String imagePath = rs.getString("imagePath");
                int user_id = rs.getInt("user_id");
                ArrayList<Ingredient> ins = new ArrayList<>();
                ins = Ingredient.stringToObject(ingredients);

                Food food = new Food(id, ins, name, type, cooking_way, imagePath, user_id);
                foods.add(food);

            }

        } catch (SQLException | UnsupportedEncodingException ex) {
            System.out.println(ex.getMessage());
        }
        return foods;
    }

    @Override
    public ArrayList<Food> getFoodsByUserId(int user_id) {
        ArrayList<Food> foods = new ArrayList<>();
        try {
            pstmt = con.prepareStatement("SELECT * FROM food WHERE user_id = ?");
            pstmt.setInt(1, user_id);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                String name = rs.getString("name");
                int id = Integer.parseInt(rs.getString("id"));
                FoodType type = FoodType.valueOf(rs.getString("foodtype"));
                String cooking_way = rs.getString("cooking_way");
                String ingredients = rs.getString("ingredients");
                String imagePath = rs.getString("imagePath");
                
                ArrayList<Ingredient> ins = new ArrayList<>();
                ins = Ingredient.stringToObject(ingredients);

                Food food = new Food(id, ins, name, type, cooking_way, imagePath, user_id);
                foods.add(food);

            }

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return foods;
    

}
}
