import 'package:flutter/material.dart';

import '../widgets/bottom_navigation_bar.dart';
import 'drawer_screen.dart';
class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      drawer: DrawerScreen(),
      body: Container(),
      bottomNavigationBar: BottomBar(3, context),
    );
  }
}
