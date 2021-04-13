import 'package:flutter/material.dart';

import '../widgets/bottom_navigation_bar.dart';

class WatchlistScreen extends StatelessWidget {
  static const routeName = '/wishlist';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchhlist'),
      ),
      body: Container(),
      bottomNavigationBar: BottomBar(1, context),
    );
  }
}
