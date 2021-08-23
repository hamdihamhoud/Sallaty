import 'package:flutter/material.dart';

class Type {
  final String title;

  Type({
    @required this.title,
  });
}

class Category {
  @required
  final String title;
  final List<Type> types;

  Category({
    this.title,
    this.types,
  });
}

final List<Category> categories = [
  Category(title: 'Electronics', types: [
    Type(
      title: 'Headphones',
    ),
    Type(
      title: 'Phones',
    ),
    Type(
      title: 'Other',
    ),
  ]),
  Category(title: 'Fashion', types: [
    Type(
      title: 'Clothes',
    ),
    Type(
      title: 'Shoes',
    ),
    Type(
      title: 'Watches',
    ),
    Type(
      title: 'Other',
    ),
  ]),
  Category(title: 'Food', types: []),
  Category(title: 'Health & Beauty', types: []),
  Category(title: 'Other', types: []),
];
