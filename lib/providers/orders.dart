import 'package:flutter/material.dart';

import 'cart.dart';
import 'dart:convert';

class Order {
  final String id;
  final int amount;
  final List<CartItem> products;
  final DateTime dateTime;
  final String address;

  Order({
    this.id,
    @required this.amount,
    @required this.products,
    this.dateTime,
    @required this.address,
  });
}

class Orders with ChangeNotifier {
  List<Order> _orders = [
    // OrderItem(
    //   id: DateTime.now().toString(),
    //   amount: 1000000,
    //   dateTime: DateTime.now(),
    //   products: [
    // CartItem(
    //   imageUrl: '',
    //   id: 'p1',
    //   title: 'adidas shoes',
    //   quantity: 2,
    //   price: 500000,
    // ),
    // CartItem(
    //   imageUrl: '',
    //   id: 'p2',
    //   title: 'Shirt',
    //   quantity: 6,
    //   price: 100000,
    // ),
    //   ],
    // ),
    // OrderItem(
    //   id: DateTime.now().toString(),
    //   amount: 1000000,
    //   dateTime: DateTime.now(),
    //   products: [
    //     CartItem(
    //       imageUrl: '',
    //       id: 'p1',
    //       title: 'adidas shoes',
    //       quantity: 2,
    //       price: 500000,
    //     ),
    //     CartItem(
    //       imageUrl: '',
    //       id: 'p2',
    //       title: 'Shirt',
    //       quantity: 6,
    //       price: 100000,
    //     )
    //   ],
    // ),
    // OrderItem(
    //   id: DateTime.now().toString(),
    //   amount: 1000000,
    //   dateTime: DateTime.now(),
    //   products: [
    //     CartItem(
    //       imageUrl: '',
    //       id: 'p1',
    //       title: 'adidas shoes',
    //       quantity: 2,
    //       price: 500000,
    //     ),
    //     CartItem(
    //       imageUrl: '',
    //       id: 'p2',
    //       title: 'Shirt',
    //       quantity: 6,
    //       price: 100000,
    //     )
    //   ],
    // ),
  ];
  String _token;
  String _userId;

  void setToken(String token) {
    _token = token;
  }

  void setUserId(String id) {
    _userId = id;
  }

  List<Order> get orders {
    return [..._orders];
  }

  // Future<void> fetchAndSetOrders() async {

  //   notifyListeners();
  // }

  void addOrder(List<CartItem> cartProducts, double total, String address) {
    print(json.encode({
      'orderItems': cartProducts
          .map((e) => {
                'id': e.productId,
                'quantity': e.quantity,
                'color': e.color.value,
                'size': e.size,
              })
          .toList(),
      'total': total,
      'address': address,
    }));
    // _orders.insert(
    //   0,
    //   Order(
    //     // id: DateTime.now().toString(),
    //     amount: total,
    //     // dateTime: DateTime.now(),
    //     products: cartProducts,
    //     address: address,
    //   ),
    // );
    notifyListeners();
  }

  List<CartItem> fetchSellerOreders() {
    return [
      // CartItem(
      //   id: 'p1',
      //   quantity: 5,
      //   title: 'nike',
      //   price: 30000,
      //   imageUrl:
      //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
      //   status: Status.Shiped,
      // ),
      // CartItem(
      //   id: 'p1',
      //   quantity: 5,
      //   title: 'nike',
      //   price: 30000,
      //   imageUrl:
      //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
      //   status: Status.Delivered,
      // ),
      // CartItem(
      //   id: 'p1',
      //   quantity: 5,
      //   title: 'nike',
      //   price: 30000,
      //   imageUrl:
      //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
      // ),
      // CartItem(
      //   id: 'p1',
      //   quantity: 5,
      //   title: 'nike',
      //   price: 30000,
      //   imageUrl:
      //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
      // ),
      // CartItem(
      //   id: 'p1',
      //   quantity: 5,
      //   title: 'nike',
      //   price: 30000,
      //   imageUrl:
      //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
      // ),
      // CartItem(
      //   id: 'p1',
      //   quantity: 5,
      //   title: 'nike',
      //   price: 30000,
      //   imageUrl:
      //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
      // ),
      // CartItem(
      //   id: 'p1',
      //   quantity: 5,
      //   title: 'nike',
      //   price: 30000,
      //   imageUrl:
      //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
      // ),
      // CartItem(
      //   id: 'p1',
      //   quantity: 5,
      //   title: 'nike',
      //   price: 30000,
      //   imageUrl:
      //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
      // ),
    ];
  }
}
