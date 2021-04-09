import 'package:flutter/material.dart';

import '../widgets/bottom_navigation_bar.dart';

class OffersScreen extends StatelessWidget {
  static const routeName = '/offers';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Offers'),
      ),
      body: Container(),
      bottomNavigationBar: BottomBar(2, context),
    );
  }
}