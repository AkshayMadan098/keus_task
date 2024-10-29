import 'package:flutter/material.dart';
import 'package:keus_task/presentation/widgets/food_card.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../application/providers/food_provider.dart';
import '../widgets/cart_sheet.dart';
import '../widgets/category_filter.dart';
import '../widgets/custom_button.dart';
import '../widgets/food_item_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(viewportFraction: 1.0);
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Consumer<FoodProvider>(
          builder: (context, foodProvider, child) {
            if (foodProvider.cartItems.isEmpty) {
              return const SizedBox();
            }
            double totalPrice = (foodProvider.quantity * (foodProvider.cartItems[0].price ?? 0.0));
            return CustomElevatedButton(
              buttonText: 'Cart',
              duration: '24 min',
              price: '\$${totalPrice.toStringAsFixed(2)}',
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => CartSheet(cartItems: foodProvider.cartItems,),
                );
              },
            );
          },
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.menu, color: Colors.black),
        centerTitle: true,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(25),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '100a Ealing Rd',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              SizedBox(width: 8),
              Text(
                '• 24 mins',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        actions: const [
          Icon(Icons.search, color: Colors.black),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Consumer<FoodProvider>(
          builder: (context, foodProvider, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hits of the week',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 260,
                    child: PageView.builder(
                      controller: _pageController,
                      padEnds: false,
                      onPageChanged: (index) {
                        setState(() {
                          currentPage = index;
                        });
                      },
                      itemCount: foodProvider.items.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          child: FoodItemCard(item:foodProvider.items[index],),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: foodProvider.items.length,
                    effect: const WormEffect(
                      dotHeight: 4,
                      dotWidth: 85,
                      spacing: 12,
                      dotColor: Colors.grey,
                      activeDotColor: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        CategoryFilterWidget(icon:Icons.tune, text: 'Filters'),
                        CategoryFilterWidget(icon: null, text: 'Salads'),
                        CategoryFilterWidget(icon: null, text: 'Pizza'),
                        CategoryFilterWidget(icon: null, text: 'Beverages'),
                        CategoryFilterWidget(icon: null, text: 'Snacks'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16,),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: foodProvider.items.length,
                    itemBuilder: (context, index) {
                      final item = foodProvider.items[index];
                      return Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: FoodCard(item: item,),
                      );
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}