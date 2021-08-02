import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum Status {
  Ordered,
  Shiped,
  Delivered,
}

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String imageUrl;
  final Color color;
  final String size;
  final Status status;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
    @required this.imageUrl,
    @required this.color,
    this.size = '0',
    this.status = Status.Ordered,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {
    'p111111': CartItem(
      id: 'p1',
      title: 'Adidas Shoes',
      color: Colors.white,
      quantity: 2,
      price: 12,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    )
  };

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
    @required final String productId,
    @required final double price,
    @required final String title,
    @required int quantity,
    @required final Color color,
    @required final String imageUrl,
    final String size = '0',
  }) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
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
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
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

  void undoAddingItem(String productId) {
    double picePrice = (_items[productId].price) / (_items[productId].quantity);
    if (!_items.containsKey(productId)) return;
    if (_items[productId].quantity > 1)
      _items.update(
        productId,
        (value) => CartItem(
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
      deleteProductFromCart(productId);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
