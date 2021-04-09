import 'package:flutter/material.dart';

import '../models/product.dart';
import '../models/category.dart';
import '../widgets/product_item.dart';
import '../widgets/home_suggestion_item.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../widgets/types_row.dart';

class CategoryScreen extends StatelessWidget {
  static const routeName = '/category';

  @override
  Widget build(BuildContext context) {
    final Category category =
        ModalRoute.of(context).settings.arguments as Category;
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
              itemBuilder: (ctx, i) => ProductItem(
                product: Product(
                  id: DateTime.now().toString(),
                  ownerId: 'o1',
                  title: 'Adidas shoes',
                  price: 90000,
                  quantity: 4,
                  imageUrls: [
                    'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
                  ],
                  category: 'fashion',
                  description: 'hamdi',
                  specs: {
                    'color': 'blue',
                    'size': '42 + 43',
                    'other': 'running shoes',
                  },
                ),
                isGridView: true,
              ),
              itemCount: 5,
            )
          : ListView(
              children: [
                TypesRow(category.types),
                SizedBox(
                  height: 10,
                ),
                // HomeSuggestionItem('Most Recent'),
                // HomeSuggestionItem('Highest Rated'),
                // HomeSuggestionItem('Best Seller'),
              ],
            ),
      bottomNavigationBar: BottomBar(0, context),
    );
  }
}
