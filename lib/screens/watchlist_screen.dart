import 'package:flutter/material.dart';

import '../widgets/bottom_navigation_bar.dart';
import 'drawer_screen.dart';
class WatchlistScreen extends StatelessWidget {
  static const routeName = '/wishlist';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      drawer: DrawerScreen(),
      body: Container(),
      bottomNavigationBar: BottomBar(1, context),
    );
  }
}
