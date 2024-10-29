import '../../domain/entities/food_item.dart';

class FoodItemModel extends FoodItem {
  FoodItemModel({
    super.id,
    super.name,
    super.description,
    super.price,
    super.imageUrl,
    super.calories,
    super.bgColor,
    super.carbs,
    super.fats,
    super.grams,
    super.proteins,
  });

  factory FoodItemModel.fromJson(Map<String, dynamic> json) {
    return FoodItemModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      calories: json['calories'],
      bgColor: json['bgColor'],
      carbs: json['carbs'],
      fats: json['fats'],
      grams: json['grams'],
      proteins: json['proteins'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'price': price,
    'imageUrl': imageUrl,
    'calories': calories,
    'bgColor': bgColor,
    'carbs': carbs,
    'fats': fats,
    'grams': grams,
    'proteins': proteins,
  };
}
