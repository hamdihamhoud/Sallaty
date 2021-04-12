import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../models/product.dart';
import '../widgets/product_images_carousel.dart';

class ProductDetailsSceen extends StatelessWidget {
  static const routeName = '/product-details';
  @override
  Widget build(BuildContext context) {
    final String productId =
        ModalRoute.of(context).settings.arguments as String;
    final productProvider = Provider.of<ProductsProvider>(context,listen: false);
    final Product product = productProvider.findId(productId);
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: CarouselWithIndicator(product.imageUrls),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                productProvider.findSeller().name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).accentColor,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                product.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  // color: Theme.of(context).accentColor,
                  fontSize: 20,
                ),
              ),
            ),
            RatingBarIndicator(
              rating: product.rating,
              itemBuilder: (context, index) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              // itemCount: 5,
              // itemSize: 50.0,
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                'Item details',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
            ),
            ...product.specs.keys.map((e) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    child: Text(
                      e,
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    width: mediaQuery.size.width * 0.50,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    child: Text(product.specs[e]),
                    width: mediaQuery.size.width * 0.50,
                  ),
                ],
              );
            }).toList(),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                'Description',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              constraints: BoxConstraints(maxHeight: 100),
              padding: const EdgeInsets.all(8),
              child: Scrollbar(
                isAlwaysShown: true,
                child: SingleChildScrollView(child: Text(product.description)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
