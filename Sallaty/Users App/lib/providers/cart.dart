import 'package:flutter/material.dart';

enum Status {
  Ordered,
  Confirmed,
  Shiped,
  Delivered,
}

class CartItem {
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;
  final String imageUrl;
  final Color color;
  final String size;
  final Status status;
  final DateTime date;

  CartItem({
    @required this.id,
    @required this.productId,
    @required this.title,
    @required this.quantity,
    @required this.price,
    @required this.imageUrl,
    @required this.color,
    this.size = '0',
    this.status = Status.Ordered,
    this.date,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    int count = 0;
    final values = _items.values.toList();
    for (int i = 0; i < _items.length; i++) {
      count += values[i].quantity;
    }
    return count;
  }

  double get total {
    var total = 0.0;
    _items.forEach((key, value) {
      total += value.price;
    });
    return total;
  }

  int productQuantity(String id) {
    if (_items.containsKey(id)) return _items[id].quantity;
    return 0;
  }

  void addItem({
    @required final String keys,
    @required final String productId,
    @required final double price,
    @required final String title,
    @required final Color color,
    @required final String imageUrl,
    @required int quantity,
    final String size = '0',
  }) {
    if (_items.containsKey(keys)) {
      _items.update(
        keys,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          productId: existingCartItem.productId,
          title: existingCartItem.title,
          price: existingCartItem.price + (price * quantity),
          quantity: existingCartItem.quantity + quantity,
          imageUrl: existingCartItem.imageUrl,
          color: existingCartItem.color,
          size: existingCartItem.size,
        ),
      );
    } else {
      _items.putIfAbsent(
        keys,
        () => CartItem(
          id: DateTime.now().toString(),
          productId: productId,
          title: title,
          price: price * quantity,
          quantity: quantity,
          imageUrl: imageUrl,
          color: color,
          size: size,
        ),
      );
    }
    notifyListeners();
  }

  void deleteProductFromCart(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void undoAddingItem({String keys}) {
    double picePrice = (_items[keys].price) / (_items[keys].quantity);
    if (!_items.containsKey(keys)) return;
    if (_items[keys].quantity > 1)
      _items.update(
        keys,
        (value) => CartItem(
          productId: value.productId,
          id: value.id,
          title: value.title,
          price: value.price - picePrice,
          quantity: value.quantity - 1,
          imageUrl: value.imageUrl,
          color: value.color,
          size: value.size,
        ),
      );
    else
      deleteProductFromCart(keys);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
