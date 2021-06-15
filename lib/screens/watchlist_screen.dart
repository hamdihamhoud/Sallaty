import 'package:flutter/material.dart';
import 'drawer_screen.dart';

class WatchlistScreen extends StatelessWidget {
  static const routeName = '/wishlist';
  WatchlistScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      drawer: DrawerScreen(),
      body: Container(),
    );
  }
}
