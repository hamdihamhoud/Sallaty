import 'package:flutter/material.dart';

class NotAvailable extends StatelessWidget {
  final bool hasSize;
  const NotAvailable({@required this.hasSize});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        color: Colors.redAccent,
      ),
      child: Center(
        child: Text(
          hasSize
              ? 'This size is no longer available'
              : 'This color is no longer available',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
