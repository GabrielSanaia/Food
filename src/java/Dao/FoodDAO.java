package Dao;

import Model.Food;
import java.util.ArrayList;

public interface FoodDAO {

    void addFood(Food food);

    ArrayList<Food> getAllFoods();
    
    Food getFoodById(int id);
    
    ArrayList<Food> getFoodByName(String name);
    
    ArrayList<Food> getFoodsByUserId(int user_id);
}
