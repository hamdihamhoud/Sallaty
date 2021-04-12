import 'package:flutter/material.dart';

import '../models/category.dart';
import '../models/product.dart';
import '../models/seller.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _products = [
    Product(
      id: 'p1',
      ownerId: 'o1',
      title: 'Adidas shoes',
      price: 90000,
      quantity: 4,
      imageUrls: [
        'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
        'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
        'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
      ],
      category: categories[1].title,
      type: categories[1].types[1].title,
      description: '',
      specs: {
        'color': 'blue',
        'size': '42 + 43',
        'other': 'running shoes',
      },
    ),
  ];

  List<Product> get products => [..._products];

  Product findId(String id) {
    return products[0];
    // _products.firstWhere((element) => element.id == id);
  }

  List<Product> fetchByCategory(String category) {
    return products; 
    //_products.where((element) => element.category == category).toList();
  }

  List<Product> fetchByType(String type) {
    return products;
    // _products.where((element) => element.type == type).toList();
  }

  List<Product> fetchBy(String fetchMechanism) {
    return products;
  }

  Seller findSeller() {
    // fetch sellers by ownerId
    return Seller(
      id: 's1',
      name: 'Apple',
      email: 'apple@gmail.com',
      addresses: ['mazzeh'],
      imageUrl: '',
      items: ['p1'],
      number: 0958772317,
      typeOfItems: 'electronics',
    );
  }
}
