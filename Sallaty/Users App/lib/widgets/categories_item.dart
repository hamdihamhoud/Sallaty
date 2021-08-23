import 'package:ecart/models/category.dart';
import 'package:ecart/screens/category_screen.dart';
import 'package:flutter/material.dart';

class CategoriesItem extends StatelessWidget {
  final int index;
  const CategoriesItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16,
        bottom: 16,
        left: 5,
        right: 5,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        height: 20,
        child: Center(
            child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              CategoryScreen.routeName,
              arguments: categories[index],
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(
              top: 5,
              bottom: 5,
              left: 15,
              right: 15,
            ),
            child: Text(
              categories[index].title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )),
      ),
    );
  }
}
