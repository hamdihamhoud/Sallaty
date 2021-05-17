import 'package:flutter/material.dart';

class ColorCircule extends StatelessWidget {
  final Color color;
  ColorCircule(this.color);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 5,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).accentColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(50),
          color: color,
        ),
        height: 30,
        width: 30,
      ),
    );
  }
}
