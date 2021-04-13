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

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Cart()),
        ChangeNotifierProvider.value(value: ProductsProvider()),
      ],
      child: MaterialApp(
        title: 'e-cart',
        theme: ThemeData(
          primaryColor: Color(0xFF003F63),
          accentColor: Color(0xFFF2B138),
          primaryColorBrightness: Brightness.dark,
          accentColorBrightness: Brightness.light,
          fontFamily: 'Roboto',
        ),
        home: HomeScreen(),
        routes: {
          HomeScreen.routeName: (ctx) => HomeScreen(),
          WatchlistScreen.routeName: (ctx) => WatchlistScreen(),
          OffersScreen.routeName: (ctx) => OffersScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          AccountScreen.routeName: (ctx) => AccountScreen(),
          CategoryScreen.routeName: (ctx) => CategoryScreen(),
          ProductDetailsSceen.routeName: (ctx) => ProductDetailsSceen(),
        },
      ),
    );
  }
}
