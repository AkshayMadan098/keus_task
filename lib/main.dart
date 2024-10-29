// lib/main.dart

import 'package:flutter/material.dart';
import 'package:keus_task/presentation/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'application/providers/food_provider.dart';
import 'data/repositories/food_repository_impl.dart';
import 'domain/usecases/add_to_cart.dart';
import 'domain/usecases/get_cart_items.dart';
import 'domain/usecases/get_food_item.dart';
import 'domain/usecases/remove_from_cart.dart';

void main() {
  final repository = FoodRepositoryImpl();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => FoodProvider(
            GetFoodItems(repository),
            AddToCart(repository),
            RemoveFromCart(repository),
            GetCartItems(repository),
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Cart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}
