import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ecart/screens/account_screen.dart';
import 'package:ecart/screens/cart_screen.dart';
import 'package:ecart/screens/home_screen.dart';
import 'package:ecart/screens/offers_screen.dart';
import 'package:ecart/screens/watchlist_screen.dart';
import 'package:ecart/widgets/badge.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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
  Widget _bottomNavigationBar(int selectedIndex) => Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 67, 67, 67),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            border: Border.all(
              width: 5,
              color: Color.fromARGB(255, 67, 67, 67),
            )),
        child: GNav(
            selectedIndex: _selectedIndex,
            onTabChange: (index) => setState(() => _selectedIndex = index),
            backgroundColor: Color.fromARGB(255, 67, 67, 67),
            rippleColor: Theme.of(context).accentColor,
            hoverColor: Theme.of(context).accentColor,
            haptic: true,
            tabBorderRadius: 15,
            tabActiveBorder: Border.all(
              color: Color.fromARGB(255, 67, 67, 67),
              width: 1,
            ),
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
            gap: 8,
            color: Colors.black45,
            activeColor: Colors.black,
            iconSize: 22,
            tabBackgroundColor: Theme.of(context).accentColor,
            padding: EdgeInsets.only(
              top: 10,
              bottom: 10,
              left: 15,
              right: 15,
            ),
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Home',
                iconColor: Colors.white,
              ),
              GButton(
                icon: Icons.favorite,
                text: 'Favorite',
                iconColor: Colors.white,
              ),
              GButton(
                icon: Icons.shopping_cart,
                text: 'Cart',
                iconColor: Colors.white,
              ),
              GButton(
                icon: Icons.local_offer_outlined,
                text: 'Offers',
                iconColor: Colors.white,
              ),
              GButton(
                icon: Icons.account_circle_rounded,
                text: 'Account',
                iconColor: Colors.white,
              ),
            ]),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNavigationBar(_selectedIndex),
      backgroundColor: Theme.of(context).primaryColor,
      body: PageStorage(
        child: pages[_selectedIndex],
        bucket: bucket,
      ),
    );
  }
}

/* CurvedNavigationBar(
        onTap: (int index) => setState(() => _selectedIndex = index),
        index: _selectedIndex,
        
        letIndexChange: (index) => true,
        // backgroundColor: Color.fromARGB(255, 135, 135, 135),
        // color: Color.fromARGB(255, 67, 67, 67),
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
      ); */

/* tabShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 8,
              ),
            ], */
