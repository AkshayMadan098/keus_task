import '../entities/food_item.dart';

abstract class FoodRepository {
  List<FoodItem> getFoodItems();
  void addToCart(FoodItem item);
  void removeFromCart(String itemId);
  List<FoodItem> getCartItems();
}