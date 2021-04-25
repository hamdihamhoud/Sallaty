import 'package:flutter/material.dart';

class Type {
  final String title;
  final String imageAsset;

  Type({
  @required  this.title,
  @required  this.imageAsset,
  });
}

class Category {
@required  final String title;
@required  final String imageAsset;
@required  final List<Type> types;

  Category({
    this.title,
    this.imageAsset,
    this.types,
  });
}

final List<Category> categories = [
  Category(
      title: 'Electronics',
      imageAsset: 'assets/images/categories/electronics/electronics.png',
      types: [
        Type(
          title: 'Headphones',
          imageAsset: 'assets/images/categories/electronics/headphones.png',
        ),
        Type(
          title: 'Phones',
          imageAsset: 'assets/images/categories/electronics/phone.png',
        ),
      ]),
  Category(
      title: 'Fashion',
      imageAsset: 'assets/images/categories/fashion/fashion.png',
      types: [
        Type(
          title: 'Clothes',
          imageAsset: 'assets/images/categories/fashion/clothes.png',
        ),
        Type(
          title: 'Shoes',
          imageAsset: 'assets/images/categories/fashion/shoes.png',
        ),
        Type(
          title: 'Watches',
          imageAsset: 'assets/images/categories/fashion/watches.png',
        ),
      ]),
  Category(
      title: 'Food',
      imageAsset: 'assets/images/categories/food.png',
      types: []),
  Category(
      title: 'Health & Beauty',
      imageAsset: 'assets/images/categories/health-and-beauty.png',
      types: []),
];
