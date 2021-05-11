import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ecart/screens/account_screen.dart';
import 'package:ecart/screens/cart_screen.dart';
import 'package:ecart/screens/home_screen.dart';
import 'package:ecart/screens/offers_screen.dart';
import 'package:ecart/screens/watchlist_screen.dart';
import 'package:ecart/widgets/badge.dart';
import 'package:flutter/material.dart';

class AppBottomNavigationBarController extends StatefulWidget {
  static const routeName = '/main';
  @override
  _AppBottomNavigationBarControllerState createState() =>
      _AppBottomNavigationBarControllerState();
}

class _AppBottomNavigationBarControllerState
    extends State<AppBottomNavigationBarController> {
  final List<Widget> pages = [
    HomeScreen(
      key: PageStorageKey('Page1'),
    ),
    WatchlistScreen(
      key: PageStorageKey('Page2'),
    ),
    CartScreen(
      key: PageStorageKey('Page3'),
    ),
    OffersScreen(
      key: PageStorageKey('Page4'),
    ),
    AccountScreen(
      key: PageStorageKey('Page5'),
    ),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  int _selectedIndex = 0;
  Widget _bottomNavigationBar(int selectedIndex) => CurvedNavigationBar(
        onTap: (int index) => setState(() => _selectedIndex = index),
        index: _selectedIndex,
        letIndexChange: (index) => true,
        backgroundColor: Color.fromARGB(255, 135, 135, 135),
        color: Color.fromARGB(255, 67, 67, 67),
        buttonBackgroundColor: Theme.of(context).accentColor,
        height: 60,
        items: <Widget>[
          Icon(
            Icons.store_outlined,
            size: 30,
            color: Color.fromARGB(255, 235, 235, 235),
          ),
          Icon(
            Icons.favorite_border_rounded,
            size: 30,
            color: Color.fromARGB(255, 235, 235, 235),
          ),
          0 == 0
              ? //cart item count !!!!!!!!!!!
              Badge(
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    size: 30,
                    color: Color.fromARGB(255, 235, 235, 235),
                  ),
                  value: '0',
                  color: Colors.red,
                )
              : Icon(
                  Icons.shopping_cart_outlined,
                  size: 30,
                  color: Color.fromARGB(255, 235, 235, 235),
                ),
          Icon(
            Icons.local_offer_outlined,
            size: 30,
            color: Color.fromARGB(255, 235, 235, 235),
          ),
          Icon(
            Icons.account_circle_outlined,
            size: 30,
            color: Color.fromARGB(255, 235, 235, 235),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNavigationBar(_selectedIndex),
      body: PageStorage(
        child: pages[_selectedIndex],
        bucket: bucket,
      ),
    );
  }
}
