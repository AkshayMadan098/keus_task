import '../entities/food_item.dart';
import '../repositories/food_repository.dart';

class AddToCart {
  final FoodRepository repository;

  AddToCart(this.repository);

  void call(FoodItem item) {
    repository.addToCart(item);
  }
}