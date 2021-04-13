import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

import './badge.dart';

import '../screens/home_screen.dart';
import '../screens/watchlist_screen.dart';
import '../screens/offers_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/account_screen.dart';

class BottomBar extends StatelessWidget {
  final int index;
  final BuildContext ctx;
  BottomBar(this.index, this.ctx);

  onTap(int i) {
    if (i == index) return;
    if (i == 0)
      Navigator.of(ctx).pushReplacementNamed(HomeScreen.routeName);
    else if (i == 1)
      Navigator.of(ctx).pushReplacementNamed(WatchlistScreen.routeName);
    else if (i == 2)
      Navigator.of(ctx).pushReplacementNamed(OffersScreen.routeName);
    else if (i == 3)
      Navigator.of(ctx).pushReplacementNamed(CartScreen.routeName);
    else if (i == 4)
      Navigator.of(ctx).pushReplacementNamed(AccountScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final cartItemCount = Provider.of<Cart>(context).itemCount;
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).primaryColor,
      onTap: (i) {
        onTap(i);
      },
      fixedColor: Theme.of(context).accentColor,
      currentIndex: index,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_rounded,
          ),
          label: 'Home',
          backgroundColor: Theme.of(context).primaryColor,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.favorite_border_rounded,
          ),
          label: 'Watchlist',
          activeIcon: Icon(Icons.favorite_rounded),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.local_offer_outlined,
          ),
          label: 'Offers',
          backgroundColor: Theme.of(context).primaryColor,
        ),
        // remove badge if value is 0
        cartItemCount == 0
            ? BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_cart_outlined,
                ),
                label: 'Cart',
                backgroundColor: Theme.of(context).primaryColor,
              )
            : BottomNavigationBarItem(
                icon: Badge(
                  child: Icon(
                    Icons.shopping_cart_outlined,
                  ),
                  value: cartItemCount.toString(),
                  color: Colors.red,
                ),
                label: 'Cart',
                backgroundColor: Theme.of(context).primaryColor,
              ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.account_circle_outlined,
          ),
          label: 'Account',
          backgroundColor: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}
