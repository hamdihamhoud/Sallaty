import 'package:flutter/material.dart';

class User {
  final String id;
  final String name;
  final String email;
  String imageUrl;
  final int number;
  final bool isAdmin;
  final bool isSeller;
  final bool isDeliveryman;
  final bool isNormaUser;
  List<String> wishListIds = [];
  List<String> ordersIds = [];
  User({
    @required this.id,
    @required this.name,
    @required this.email,
    this.imageUrl,
    @required this.number,
    this.isAdmin = false,
    this.isSeller = false,
    this.isDeliveryman = false,
    this.isNormaUser = true,
    this.wishListIds,
    this.ordersIds,
  });
}
