import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

import '../models/product.dart';
import '../models/category.dart';
import './product_item.dart';

class HomeSuggestionItem extends StatelessWidget {
  final String type;
  HomeSuggestionItem(this.type);

  @override
  Widget build(BuildContext context) {
    final List<Product> product =
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
                itemCount: 3,
                itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
                    value: Product(
                      id: DateTime.now().toString(),
                      ownerId: 'o1',
                      title: 'Adidas shoes',
                      price: 90000,
                      quantity: 4,
                      imageUrls: [
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
                        'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
                      ],
                      category: categories[1].title,
                      type: categories[1].types[1].title,
                      description: '',
                      specs: {},
                    ), //product[index],
                    child: ProductItem(
                      // product: Product(
                      //   id: DateTime.now().toString(),
                      //   ownerId: 'o1',
                      //   title: 'Adidas shoes',
                      //   price: 90000,
                      //   quantity: 4,
                      //   imageUrls: [
                      //     'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
                      //     'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
                      //     'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
                      //   ],
                      //   category: categories[1].title,
                      //   type: categories[1].types[1].title,
                      //   description: '',
                      //   specs: {},
                      // ),
                    ))),
          ),
        ],
      ),
    );
  }
}
