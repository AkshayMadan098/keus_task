import '../entities/food_item.dart';
import '../repositories/food_repository.dart';

class GetCartItems {
  final FoodRepository repository;

  GetCartItems(this.repository);

  List<FoodItem> call() {
    return repository.getCartItems();
  }
}