import 'package:flutter/material.dart';

import '../widgets/bottom_navigation_bar.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = '/wishlist';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
      ),
      body: Container(),
      bottomNavigationBar: BottomBar(1, context),
    );
  }
}
