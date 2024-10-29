import 'package:flutter/material.dart';
import 'package:keus_task/application/providers/food_provider.dart';
import 'package:keus_task/presentation/widgets/quantity_control.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/food_item.dart';
import 'custom_button.dart';

class CartSheet extends StatefulWidget {
  final List<FoodItem> cartItems;

  const CartSheet({super.key, required this.cartItems});

  @override
  State<CartSheet> createState() => _CartSheetState();
}

class _CartSheetState extends State<CartSheet> {
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      calculateTotalPrice();
    });
  }

  void calculateTotalPrice() {
    double sum = 0.0;
    for (var item in widget.cartItems) {
      sum += item.price! * (Provider.of<FoodProvider>(context, listen: false).quantity);
    }
    setState(() {
      totalPrice = sum;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              const Text(
                'We will deliver in\n24 minutes to the address:',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text(
                    '100a Ealing Rd',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Change address',
                      style: TextStyle(
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.cartItems.length,
                itemBuilder: (context, index) {
                  final item = widget.cartItems[index];
                  return Consumer<FoodProvider>(
                      builder: (ctx, foodProvider, child) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                image: DecorationImage(
                                  image: AssetImage(item.imageUrl!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  QuantityControl(
                                    quantity: foodProvider.quantity,
                                    onIncrease: () {
                                      foodProvider.increaseQuantity();
                                      calculateTotalPrice();
                                    },
                                    onDecrease: () {
                                      foodProvider.decreaseQuantity();
                                      calculateTotalPrice();
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '\$${(item.price! * foodProvider.quantity).toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );
                      }
                  );
                },
              ),
              const SizedBox(height: 24),
              Divider(color: Colors.grey[300]),
              const SizedBox(height: 10),
              Consumer<FoodProvider>(
                builder: (ctx,foodProvider,child) {
                  return Row(
                    children: [
                      const Icon(Icons.restaurant, color: Colors.black),
                      const SizedBox(width: 16),
                      const Text(
                        'Cutlery',
                        style: TextStyle(fontSize: 16),
                      ),
                      const Spacer(),
                      QuantityControl(
                        quantity: foodProvider.cultery,
                        onIncrease: () {
                          foodProvider.increaseCutlery();
                        },
                        onDecrease: () {
                          foodProvider.decreaseCutlery();
                        },
                      )
                    ],
                  );
                }
              ),
              const SizedBox(height: 10),
              Divider(color: Colors.grey[300]),
              const SizedBox(height: 16),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Delivery',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '\$0.00',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const Text(
                'Free delivery from \$30',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 70),
              const Text(
                'Payment method',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/apple_icon.png',
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(width: 5),
                            const Text(
                              "Pay",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        'Apple pay',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const Icon(Icons.chevron_right),
                ],
              ),
              const SizedBox(height: 24),
              CustomElevatedButton(
                buttonText: 'Pay',
                duration: '24 min',
                price: '\$${totalPrice.toStringAsFixed(2)}',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
