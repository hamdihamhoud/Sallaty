import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final int price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {
    // 'p1': CartItem(
    //   id: 'p1',
    //   title: 'adidas shoes',
    //   quantity: 2,
    //   price: 500000,
    // )git
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
      total += value.quantity * value.price;
    });
    return total;
  }

  int productQuantity(String id) {
    if (_items.containsKey(id)) return _items[id].quantity;
    return 0;
  }

  void addItem(
    String productId,
    int price,
    String title,
    int addingQuantity
  ) {
    if (_items.containsKey(productId)) {
      // change quantity...
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + addingQuantity,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: addingQuantity,
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
    if (!_items.containsKey(productId)) return;
    if (_items[productId].quantity > 1)
      _items.update(
        productId,
        (value) => CartItem(
          id: value.id,
          title: value.title,
          price: value.price,
          quantity: value.quantity - 1,
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
