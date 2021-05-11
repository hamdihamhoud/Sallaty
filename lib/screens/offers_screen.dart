import 'package:flutter/material.dart';

import '../widgets/bottom_navigation_bar.dart';
import 'drawer_screen.dart';

class OffersScreen extends StatelessWidget {
  static const routeName = '/offers';
  OffersScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text('Offers'),
      ),
      drawer: DrawerScreen(),
      body: Container(),
    );
  }
}
