import 'package:flutter/material.dart';

import './category_item.dart';

import '../models/category.dart';

class CategoriesRow extends StatelessWidget {
  const CategoriesRow();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 127,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: categories
                .map((e) => CategoryItem(
                      category: e,
                    ))
                .toList(),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
