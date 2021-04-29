import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

import '../models/product.dart';
import '../models/category.dart';
import '../widgets/product_item.dart';
//import '../widgets/home_suggestion_item.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../widgets/types_row.dart';

class CategoryScreen extends StatelessWidget {
  static const routeName = '/category';

  @override
  Widget build(BuildContext context) {
    final Category category =
        ModalRoute.of(context).settings.arguments as Category;
    final List<Product> products =
        Provider.of<ProductsProvider>(context).fetchByCategory(category.title);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          category.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          if (category.types.length == 0)
            IconButton(icon: Icon(Icons.filter_alt_rounded), onPressed: () {}),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: category.types.length == 0
          ? GridView.builder(
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
              itemCount: products.length,
            )
          : ListView(
              children: [
                TypesRow(category.types),
                SizedBox(
                  height: 10,
                ),
                ...category.types
                    .map((e) => Column(
                          children: [
                            InkWell(
                              onTap: () {
                                // Navigator.of(context).pushNamed(,arguments: );
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      e.title,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
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
                                  itemBuilder: (ctx, index) =>
                                      ChangeNotifierProvider.value(
                                          value: Product(
                                            id: 'p1',
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
                                            description:
                                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                                            specs: {
                                              'color': 'blue',
                                              'size': '42 + 43',
                                              'other': 'running shoes',
                                            },
                                            hasDiscount: true,
                                            discountPercentage: 20,
                                          ), //product[index],
                                          child: ProductItem())),
                            ),
                          ],
                        ))
                    .toList()
              ],
            ),
      bottomNavigationBar: BottomBar(0, context),
    );
  }
}
