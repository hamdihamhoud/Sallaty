import 'package:ecart/providers/auth.dart';
import 'package:ecart/screens/account_screen.dart';
import 'package:ecart/screens/cart_screen.dart';
import 'package:ecart/screens/drawer_screen.dart';
import 'package:ecart/screens/home_screen.dart';
import 'package:ecart/screens/offers_screen.dart';
import 'package:ecart/screens/watchlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import 'analytics_premium_screen.dart';

class AppBottomNavigationBarController extends StatefulWidget {
  static const routeName = '/main';
  final int index;
  AppBottomNavigationBarController(this.index);
  @override
  _AppBottomNavigationBarControllerState createState() =>
      _AppBottomNavigationBarControllerState(index);
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
  final int index;
  int _selectedIndex = 0;

  _AppBottomNavigationBarControllerState(this.index) {
    _selectedIndex = index;
  }

  final PageStorageBucket bucket = PageStorageBucket();
  Widget _bottomNavigationBar(int selectedIndex) => Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(-1, -1),
              blurRadius: 10,
              spreadRadius: 4,
            ),
            BoxShadow(
              color: Colors.black12,
              offset: Offset(1, -1),
              blurRadius: 10,
              spreadRadius: 4,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 5,
            right: 5,
          ),
          child: GNav(
              selectedIndex: _selectedIndex,
              onTabChange: (index) => setState(() => _selectedIndex = index),
              backgroundColor: Theme.of(context).primaryColor,
              tabBackgroundColor: Theme.of(context).accentColor,
              activeColor: Color(0xFF333333),
              rippleColor: Theme.of(context).accentColor,
              hoverColor: Color(0xFF828282),
              color: Colors.white,
              tabBorderRadius: 15,
              iconSize: 22,
              gap: 6,
              curve: Curves.ease,
              duration: Duration(milliseconds: 200),
              padding: EdgeInsets.only(
                top: 10,
                bottom: 10,
                left: 15,
                right: 15,
              ),
              tabs: [
                GButton(
                  icon: Icons.store,
                  text: 'Store',
                ),
                GButton(
                  icon: Icons.favorite,
                  text: 'Favorite',
                ),
                GButton(
                  icon: Icons.shopping_cart,
                  text: 'Cart',
                ),
                GButton(
                  icon: Icons.local_offer_outlined,
                  text: 'Offers',
                ),
                GButton(
                  icon: Icons.account_circle_rounded,
                  text: 'Account',
                ),
              ]),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 4
          ? AppBar(
              elevation: 0,
              title: Text(
                'Account',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              actions: [
                if (Provider.of<AuthProvider>(context).isSeller)
                  PopupMenuButton(
                    onSelected: (_) {
                      Navigator.of(context)
                          .pushNamed(AnalyticsScreen.routeName);
                    },
                    itemBuilder: (ctx) {
                      return [
                        PopupMenuItem(
                          child: Text(
                            'Analytics & Earnings',
                          ),
                          value: 'Analytics & Earnings',
                        ),
                      ];
                    },
                  )
              ],
            )
          : AppBar(
              title: _selectedIndex == 0
                  ? Text('Sallaty')
                  : _selectedIndex == 1
                      ? Text('Favorite')
                      : _selectedIndex == 2
                          ? Text('Cart')
                          : Text('Offers'),
              actions: [
                if (_selectedIndex == 0)
                  IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        showSearch(context: context, delegate: SearchItem());
                      })
              ],
            ),
      drawer: DrawerScreen(),
      bottomNavigationBar: _bottomNavigationBar(_selectedIndex),
      backgroundColor: Theme.of(context).primaryColor,
      body: PageStorage(
        child: pages[_selectedIndex],
        bucket: bucket,
      ),
    );
  }
}
