import 'package:flutter/material.dart';

import 'cart.dart';

class OrderItem {
  final String id;
  final int amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [
    OrderItem(
      id: DateTime.now().toString(),
      amount: 1000000,
      dateTime: DateTime.now(),
      products: [
        CartItem(
          id: 'p1',
          title: 'adidas shoes',
          quantity: 2,
          price: 500000,
        ),
          CartItem(
          id: 'p2',
          title: 'Shirt',
          quantity: 6,
          price: 100000,
        )
      ],
    ),
     OrderItem(
      id: DateTime.now().toString(),
      amount: 1000000,
      dateTime: DateTime.now(),
      products: [
        CartItem(
          id: 'p1',
          title: 'adidas shoes',
          quantity: 2,
          price: 500000,
        ),
          CartItem(
          id: 'p2',
          title: 'Shirt',
          quantity: 6,
          price: 100000,
        )
      ],
    ),
     OrderItem(
      id: DateTime.now().toString(),
      amount: 1000000,
      dateTime: DateTime.now(),
      products: [
        CartItem(
          id: 'p1',
          title: 'adidas shoes',
          quantity: 2,
          price: 500000,
        ),
          CartItem(
          id: 'p2',
          title: 'Shirt',
          quantity: 6,
          price: 100000,
        )
      ],
    ),
  ];

  List<OrderItem> get orders {
    return [..._orders];
  }

  // Future<void> fetchAndSetOrders() async {

  //   notifyListeners();
  // }

  void addOrder(List<CartItem> cartProducts, int total) {
    _orders.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        amount: total,
        dateTime: DateTime.now(),
        products: cartProducts,
      ),
    );
    notifyListeners();
  }
}
