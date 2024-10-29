
import 'dart:ui';

class FoodItem {
  final String? id;
  final String? name;
  final String? description;
  final double? price;
  final String? imageUrl;
  final String? calories;
  final Color? bgColor;
  final String? grams;
  final String? proteins;
  final String? fats;
  final String? carbs;

  FoodItem({
    this.id,
    this.name,
    this.description,
    this.price,
    this.imageUrl,
    this.calories,
    this.bgColor,
    this.carbs,
    this.fats,
    this.grams,
    this.proteins,
  });
}