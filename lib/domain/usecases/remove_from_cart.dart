import '../repositories/food_repository.dart';

class RemoveFromCart {
  final FoodRepository repository;

  RemoveFromCart(this.repository);

  void call(String itemId) {
    repository.removeFromCart(itemId);
  }
}