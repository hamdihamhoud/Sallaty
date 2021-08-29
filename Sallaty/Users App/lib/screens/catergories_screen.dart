import 'package:flutter/material.dart';
import 'drawer_screen.dart';
import 'category_screen.dart';

import '../models/category.dart';

class CategoriesScreen extends StatelessWidget {
  static const routeName = '/categories';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      drawer: DrawerScreen(),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (ctx, i) => InkWell(
          onTap: () {
            Navigator.of(context)
                .pushNamed(CategoryScreen.routeName, arguments: categories[i]);
          },
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    left: 8,
                    bottom: 8,
                    right: 15,
                  ),
                ),
                Text(
                  categories[i].title,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
