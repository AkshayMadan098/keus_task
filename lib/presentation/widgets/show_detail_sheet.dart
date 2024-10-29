import 'package:flutter/material.dart';
import 'package:keus_task/application/providers/food_provider.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/food_item.dart';
import 'cart_sheet.dart';

class ShowDetailBottomSheet extends StatefulWidget {
  final FoodItem item;
  const ShowDetailBottomSheet({super.key, required this.item});

  @override
  State<ShowDetailBottomSheet> createState() => _ShowDetailBottomSheetState();
}

class _ShowDetailBottomSheetState extends State<ShowDetailBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(140.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(140.0),
                    child: Image.asset(
                      widget.item.imageUrl!,
                      width: 280,
                      height: 280,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.name!,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.item.description!,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildNutritionalInfo(
                            widget.item.calories!, 'kcal'),
                        _buildNutritionalInfo(
                            widget.item.grams!, 'grams'),
                        _buildNutritionalInfo(
                            widget.item.proteins!, 'proteins'),
                        _buildNutritionalInfo(
                            widget.item.fats!, 'fats'),
                        _buildNutritionalInfo(
                            widget.item.carbs!, 'carbs'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Add in poke',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Icon(Icons.chevron_right, color: Colors.black),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Consumer<FoodProvider>(
                            builder: (ctx,foodProvider,child){
                              return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    foodProvider.decreaseQuantity();
                                  },
                                ),
                                Text(
                                  '${foodProvider.quantity}',
                                  style: const TextStyle(fontSize: 18),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    foodProvider.increaseQuantity();
                                  },
                                ),
                              ],
                            );
                            }
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 3,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<FoodProvider>().addToCart(widget.item);
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Consumer<FoodProvider>(
                            builder: (ctx, foodProvider, child) {
                              double totalPrice = (foodProvider.quantity * (widget.item.price ?? 0.0));
                              return Text(
                                'Add to cart \$${totalPrice.toStringAsFixed(2)}',
                                style: const TextStyle(color: Colors.white),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNutritionalInfo(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
