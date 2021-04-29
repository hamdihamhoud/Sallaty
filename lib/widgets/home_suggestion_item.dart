import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

import '../models/product.dart';
import '../models/category.dart';
import './product_item.dart';

class HomeSuggestionItem extends StatelessWidget {
  final String type;
  const HomeSuggestionItem(this.type);

  @override
  Widget build(BuildContext context) {
    final List<Product> products =
        Provider.of<ProductsProvider>(context).fetchBy(type);
    return Container(
      // height: 200,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              // Navigator.of(context).pushNamed(,arguments: );
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
                      // Navigator.of(context).pushNamed(,arguments: );
                    },
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 190,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
                    value: Product(
                      id: products[index].id,
                      ownerId: products[index].ownerId,
                      title: products[index].title,
                      price: products[index].price,
                      quantity: products[index].quantity,
                      imageUrls: products[index].imageUrls,
                      category: categories[1].title, // !!!
                      type: categories[1].types[1].title, //!!!
                      description: products[index].description,
                      specs: products[index].specs,
                      hasDiscount: products[index].hasDiscount,
                      discountPercentage: products[index].discountPercentage,
                    ), //product[index],
                    child: ProductItem())),
          ),
        ],
      ),
    );
  }
}
