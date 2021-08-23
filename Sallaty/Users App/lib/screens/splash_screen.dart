import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.50,
          child: Image.asset(
            'assets/images/splash.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
