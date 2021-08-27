import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

import '../models/product.dart';
import './product_item.dart';

import '../screens/product_suggestion_screen.dart';

class HomeSuggestionItem extends StatelessWidget {
  final String type;
  const HomeSuggestionItem(this.type);

  @override
  Widget build(BuildContext context) {
    List<Product> products = [];
    return Container(
      // height: 200,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(ProductSuggestionScreen.routeName,
                  arguments: type);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    type,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_rounded),
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                          ProductSuggestionScreen.routeName,
                          arguments: type);
                    },
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 290,
            child: FutureBuilder(
                future: Provider.of<ProductsProvider>(context).fetchBy(type),
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Center(child: CircularProgressIndicator());
                  products = snapshot.data;
                  return products != null ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: products.length,
                    itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
                      value: products[index],
                      child: ProductItem(),
                    ),
                  ) : Center(child: Text('no data'),);
                }),
          ),
        ],
      ),
    );
  }
}
