import 'package:flutter/material.dart';

import '../widgets/bottom_navigation_bar.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Container(),
      bottomNavigationBar: BottomBar(3, context),
    );
  }
}