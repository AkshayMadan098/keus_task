// lib/presentation/providers/food_provider.dart

import 'package:flutter/material.dart';
import '../../domain/entities/food_item.dart';
import '../../domain/usecases/add_to_cart.dart';
import '../../domain/usecases/get_cart_items.dart';
import '../../domain/usecases/get_food_item.dart';
import '../../domain/usecases/remove_from_cart.dart';

class FoodProvider with ChangeNotifier {
  final GetFoodItems getFoodItemsUseCase;
  final AddToCart addToCartUseCase;
  final RemoveFromCart removeFromCartUseCase;
  final GetCartItems getCartItemsUseCase;

  List<FoodItem> _items = [];
  List<FoodItem> _cartItems = [];
  int _quantity = 1;
  int _cultery = 1;

  FoodProvider(
      this.getFoodItemsUseCase, this.addToCartUseCase, this.removeFromCartUseCase, this.getCartItemsUseCase) {
    _loadFoodItems();
    _loadCartItems();
  }

  List<FoodItem> get items => _items;
  List<FoodItem> get cartItems => _cartItems;
  int get quantity => _quantity;
  int get cultery => _cultery;

  void _loadFoodItems() {
    _items = getFoodItemsUseCase();
    notifyListeners();
  }

  void _loadCartItems() {
    _cartItems = getCartItemsUseCase();
    notifyListeners();
  }

  void addToCart(FoodItem item) {
    addToCartUseCase(item);
    _loadCartItems();
  }

  void removeFromCart(String itemId) {
    removeFromCartUseCase(itemId);
    _loadCartItems();
  }

  void increaseQuantity() {
    _quantity++;
    notifyListeners();
  }

  void decreaseQuantity() {
    if (_quantity > 1) {
      _quantity--;
      notifyListeners();
    }
  }

  void setQuantity(int quantity) {
    if (quantity > 0) {
      _quantity = quantity;
      notifyListeners();
    }
  }

  void increaseCutlery() {
    _cultery++;
    notifyListeners();
  }

  void decreaseCutlery() {
    if (_cultery > 1) {
      _cultery--;
      notifyListeners();
    }
  }

  void setCultery(int cultery) {
    if (_cultery > 0) {
      _cultery = cultery;
      notifyListeners();
    }
  }

  void resetQuantity() {
    _quantity = 1;
    _cultery = 1;
    notifyListeners();
  }
}
