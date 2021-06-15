import 'package:flutter/material.dart';

class ColorCircule extends StatelessWidget {
  final Color color;
  ColorCircule(this.color);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 3,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(50),
          color: color,
        ),
        height: 32,
        width: 32,
      ),
    );
  }
}
