import 'package:flutter/material.dart';

import '../models/category.dart';
import '../screens/category_screen.dart';

class CategoryItem extends StatelessWidget {
  final Category category;

  CategoryItem({
    @required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(CategoryScreen.routeName, arguments: category);
      },
      child: Container(
        margin: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 41,
              backgroundColor: Colors.black,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                  ),
                ),
                radius: 40,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              category.title,
            ),
          ],
        ),
      ),
    );
  }
}
