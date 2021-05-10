import 'package:flutter/material.dart';

import '../widgets/bottom_navigation_bar.dart';
import 'drawer_screen.dart';

class WatchlistScreen extends StatelessWidget {
  static const routeName = '/wishlist';
  WatchlistScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      drawer: DrawerScreen(),
      body: Container(),
    );
  }
}
