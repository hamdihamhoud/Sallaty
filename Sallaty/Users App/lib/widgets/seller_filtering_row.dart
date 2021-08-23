import 'package:flutter/material.dart';

import '../screens/filter_products_premium_screen.dart';

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
                onPressed: () {
                  Navigator.pushNamed(context, FilterProductsScreen.routeName,
                      arguments: FilterType.all_products);
                },
                child: Text(
                  'All Products',
                  style: TextStyle(color: Colors.white),
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, FilterProductsScreen.routeName,
                      arguments: FilterType.orders);
                },
                child: Text(
                  'Orders',
                  style: TextStyle(color: Colors.white),
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, FilterProductsScreen.routeName,
                      arguments: FilterType.shiped);
                },
                child: Text(
                  'Shiped',
                  style: TextStyle(color: Colors.white),
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, FilterProductsScreen.routeName,
                      arguments: FilterType.sold);
                },
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
