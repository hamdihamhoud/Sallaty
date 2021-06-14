import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

import '../widgets/product_item.dart';
import 'drawer_screen.dart';

class OffersScreen extends StatelessWidget {
  static const routeName = '/offers';
  OffersScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductsProvider>(context).getOffers();
    return Scaffold(
      appBar: AppBar(
        title: Text('Offers'),
      ),
      drawer: DrawerScreen(),
      body: products.length == 0
          ? Center(
              child: Text(
                'No products yet start exploring now',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : GridView.builder(
              itemCount: products.length,
              padding: const EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                value: products[i],
                child: ProductItem(
                  isGridView: true,
                ),
              ),
            ),
    );
  }
}
