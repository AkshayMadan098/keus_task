import '../entities/food_item.dart';
import '../repositories/food_repository.dart';

class GetFoodItems {
  final FoodRepository repository;

  GetFoodItems(this.repository);

  List<FoodItem> call() {
    return repository.getFoodItems();
  }
}