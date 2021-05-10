import 'package:ecart/providers/orders.dart';
import 'package:ecart/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/products.dart';
import 'providers/cart.dart';
import 'screens/home_screen.dart';
import 'screens/watchlist_screen.dart';
import 'screens/offers_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/account_screen.dart';
import 'screens/category_screen.dart';
import 'screens/product_details_screen.dart';
import 'screens/catergories_screen.dart';
import 'screens/type_screen.dart';
import 'screens/orders_history_screen.dart';
import 'screens/feedback.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Cart>(create: (_) => Cart()),
        ChangeNotifierProvider<ProductsProvider>(
            create: (_) => ProductsProvider()),
        ChangeNotifierProvider<Orders>(create: (_) => Orders()),
      ],
      child: MaterialApp(
        title: "Discover",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color.fromARGB(255, 45, 45, 45),
          accentColor: Color.fromARGB(255, 194, 165, 109),
          primaryColorBrightness: Brightness.dark,
          accentColorBrightness: Brightness.light,
          fontFamily: 'Poppins',
        ),
        home: AppBottomNavigationBarController(),
        routes: {
          HomeScreen.routeName: (ctx) => HomeScreen(),
          WatchlistScreen.routeName: (ctx) => WatchlistScreen(),
          OffersScreen.routeName: (ctx) => OffersScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          AccountScreen.routeName: (ctx) => AccountScreen(),
          CategoryScreen.routeName: (ctx) => CategoryScreen(),
          ProductDetailsSceen.routeName: (ctx) => ProductDetailsSceen(),
          CategoriesScreen.routeName: (ctx) => CategoriesScreen(),
          TypeScreen.routeName: (ctx) => TypeScreen(),
          OrdersHistoryScreen.routeName: (ctx) => OrdersHistoryScreen(),
          FeedbackScreen.routeName: (ctx) => FeedbackScreen(),
          AppBottomNavigationBarController.routeName: (ctx) =>
              AppBottomNavigationBarController(),
        },
      ),
    );
  }
}
