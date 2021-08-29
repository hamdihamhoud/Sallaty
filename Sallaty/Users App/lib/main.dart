import 'package:ecart/providers/orders.dart';
import 'package:ecart/screens/gallery_view.dart';
import 'package:ecart/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/products.dart';
import 'providers/cart.dart';
import 'providers/auth.dart';
import 'providers/addresses.dart';
import 'screens/home_screen.dart';
import 'screens/watchlist_screen.dart';
import 'screens/offers_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/account_screen.dart';
import 'screens/category_screen.dart';
import 'screens/product_details_screen.dart';
import 'screens/catergories_screen.dart';
import 'screens/type_screen.dart';
import 'screens/product_suggestion_screen.dart';
import 'screens/orders_history_screen.dart';
import 'screens/feedback.dart';
import 'screens/add_product_screen.dart';
import 'screens/filter_products_premium_screen.dart';
import 'screens/analytics_premium_screen.dart';
import 'screens/auth_screen.dart';
import 'screens/adresses_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/auth_verification_screen.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProxyProvider<AuthProvider, ProductsProvider>(
          create: (_) => ProductsProvider(),
          update: (ctx, auth, products) => products
            ..setToken(auth.token)
            ..setUserId(auth.id),
        ),
        ChangeNotifierProxyProvider<AuthProvider, Orders>(
          create: (_) => Orders(),
          update: (ctx, auth, orders) => orders
            ..setToken(auth.token)
            ..setUserId(auth.id),
        ),
        ChangeNotifierProxyProvider<AuthProvider, AddressesProvider>(
          create: (_) => AddressesProvider(),
          update: (ctx, auth, addressesProvider) => addressesProvider
            ..setToken(auth.token)
            ..setUserId(auth.id),
        ),
        ChangeNotifierProvider<Cart>(create: (_) => Cart()),
      ],
      child: MaterialApp(
        title: 'Sallaty',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
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
        home: Consumer<AuthProvider>(
          builder: (ctx, auth, _) => FutureBuilder(
            future: auth.isAuth(),
            builder: (ctx, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? SplashScreen()
                    : snapshot.data == true
                        ? AppBottomNavigationBarController(0)
                        : AuthScreen(),
          ),
        ),
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
          ProductSuggestionScreen.routeName: (ctx) => ProductSuggestionScreen(),
          OrdersHistoryScreen.routeName: (ctx) => OrdersHistoryScreen(),
          FeedbackScreen.routeName: (ctx) => FeedbackScreen(),
          AddProductScreen.routeName: (ctx) => AddProductScreen(),
          AppBottomNavigationBarController.routeName: (ctx) =>
              AppBottomNavigationBarController(0),
          FilterProductsScreen.routeName: (ctx) => FilterProductsScreen(),
          AnalyticsScreen.routeName: (ctx) => AnalyticsScreen(),
          AuthScreen.routeName: (ctx) => AuthScreen(),
          AddressesScreen.routeName: (ctx) => AddressesScreen(),
          SettingsScreen.routeName: (ctx) => SettingsScreen(),
          VerificationScreen.routeName: (ctx) => VerificationScreen(),
          GalleryView.routeName: (ctx) => GalleryView(),
        },
      ),
    );
  }
}
