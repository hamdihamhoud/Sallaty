import 'package:flutter/material.dart';

class SoldOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 51,
      color: Colors.red,
      child: Center(
        child: Text(
          'SoldOut',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
