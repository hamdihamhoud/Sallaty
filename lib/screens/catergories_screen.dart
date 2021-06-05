import 'package:flutter/material.dart';
import 'drawer_screen.dart';
import 'category_screen.dart';

import '../models/category.dart';

class CategoriesScreen extends StatelessWidget {
  static const routeName = '/categories';

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
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
                Container(
                  padding: const EdgeInsets.only(
                    top: 8,
                    left: 8,
                    bottom: 8,
                    right: 15,
                  ),
                  child: Container(),
                  // Image.asset(
                  //   categories[i].imageAsset,
                  //   alignment: Alignment.centerLeft,
                  //   width: mediaQuery.size.width * 0.2,
                  //   fit: BoxFit.fitWidth,
                  // ),
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
