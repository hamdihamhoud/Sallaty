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
import 'screens/add_product_screen.dart';
import 'screens/filter_products_premium_screen.dart';

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
          // canvasColor: Color(0xFF828282),
          // buttonColor: Color(0xFF333333),
          primaryColor: Color(0xFF6fb9b8),
          accentColor: Color(0xFFd4f5ee),
          primaryColorBrightness: Brightness.dark,
          accentColorBrightness: Brightness.dark,
          fontFamily: 'Gilroy',
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(
                Color(0xFFd4f5ee),
              ),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(
                Color(0xFFd4f5ee),
              ),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(
                Color(0xFFd4f5ee),
              ),
            ),
          ),
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
          AddProductScreen.routeName: (ctx) => AddProductScreen(),
          AppBottomNavigationBarController.routeName: (ctx) =>
              AppBottomNavigationBarController(),
          FilterProductsScreen.routeName: (ctx) => FilterProductsScreen(),
        },
      ),
    );
  }
}
