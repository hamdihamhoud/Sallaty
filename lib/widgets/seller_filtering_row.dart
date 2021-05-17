import 'package:flutter/material.dart';

class SellerFilteringRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Theme.of(context).primaryColor,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextButton(
                onPressed: () {},
                child: Text(
                  'All Products',
                  style: TextStyle(color: Colors.white),
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextButton(
                onPressed: () {},
                child: Text(
                  'Orders',
                  style: TextStyle(color: Colors.white),
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextButton(
                onPressed: () {},
                child: Text(
                  'Shiped',
                  style: TextStyle(color: Colors.white),
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextButton(
                onPressed: () {},
                child: Text(
                  'Sold',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
