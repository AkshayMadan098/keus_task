
import 'package:flutter/material.dart';

import '../../domain/entities/food_item.dart';
import '../../domain/repositories/food_repository.dart';
import '../models/food_item_model.dart';

class FoodRepositoryImpl implements FoodRepository {
  final List<FoodItemModel> _foodItems = [
    FoodItemModel(
      id: '1',
      name: 'Classic\nBeef Burger',
      description: 'A mouthwatering burger featuring a juicy beef patty, topped with fresh lettuce, ripe tomatoes, '
          'and crunchy pickles. Served with a side of golden fries for the perfect meal.',
      price: 5.0,
      imageUrl: 'assets/images/burger.jpg',
      calories: '245',
      bgColor: Colors.blue.shade100,
      carbs: '30',
      fats: '15',
      grams: '200',
      proteins: '12',
    ),
    FoodItemModel(
      id: '2',
      name: 'Ultimate\nCheese Pizza',
      description: 'A delectable pizza topped with a generous layer of mozzarella cheese and fresh basil. '
          'This classic Italian delight is baked to perfection for a cheesy, flavorful experience.',
      price: 8.0,
      imageUrl: 'assets/images/pizza.jpg',
      calories: '545',
      bgColor: Colors.green.shade100,
      carbs: '40',
      fats: '20',
      grams: '250',
      proteins: '15',
    ),
    FoodItemModel(
      id: '3',
      name: 'Fresh Veggie\nSandwich',
      description: 'A healthy and hearty sandwich packed with crisp veggies, melted cheese, and a touch of olive oil. '
          'Perfect for a refreshing and satisfying meal on the go.',
      price: 15.0,
      imageUrl: 'assets/images/sandwich.jpg',
      calories: '145',
      bgColor: Colors.pink.shade100,
      carbs: '25',
      fats: '10',
      grams: '180',
      proteins: '10',
    ),
    FoodItemModel(
      id: '4',
      name: 'Classic Creamy\nPasta',
      description: 'Our creamy pasta is made with a rich Alfredo sauce, tossed with perfectly cooked pasta. '
          'Topped with a sprinkle of Parmesan and fresh herbs for a comforting meal.',
      price: 20.0,
      imageUrl: 'assets/images/pasta.jpg',
      calories: '345',
      bgColor: Colors.orange.shade100,
      carbs: '50',
      fats: '25',
      grams: '300',
      proteins: '20',
    ),
  ];


  final List<FoodItem> _cart = [];

  @override
  List<FoodItem> getFoodItems() {
    return _foodItems;
  }

  @override
  void addToCart(FoodItem item) {
    _cart.add(item);
  }

  @override
  void removeFromCart(String itemId) {
    _cart.removeWhere((item) => item.id == itemId);
  }

  @override
  List<FoodItem> getCartItems() {
    return _cart;
  }
}
