import 'package:flutter/material.dart';

class Seller {
  final String id;
   final String name;
  final String email;
  final String imageUrl;
  final int number;
  final List<String> addresses;
  final List<String> items;
  final String typeOfItems;
  Seller({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.imageUrl,
    @required this.number,
    @required this.addresses,
    @required this.items,
    @required this.typeOfItems,
  });

}
