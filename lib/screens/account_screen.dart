import 'package:flutter/material.dart';

import '../widgets/bottom_navigation_bar.dart';

class AccountScreen extends StatelessWidget {
  static const routeName = '/account';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: Container(),
      bottomNavigationBar: BottomBar(4, context),
    );
  }
}