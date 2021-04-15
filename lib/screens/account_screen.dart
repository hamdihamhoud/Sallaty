import 'package:flutter/material.dart';

import '../widgets/bottom_navigation_bar.dart';
import 'drawer_screen.dart';

class AccountScreen extends StatelessWidget {
  static const routeName = '/account';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      drawer: DrawerScreen(),
      body: Container(),
      bottomNavigationBar: BottomBar(4, context),
    );
  }
}