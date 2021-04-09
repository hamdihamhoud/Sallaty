import 'package:flutter/material.dart';

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
        'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
        'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
        'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
      ],
      category: 'fashion',
      description: '',
      specs: {
        'color' : 'blue',
        'size' : '42 + 43',
        'other' : 'running shoes',
      },
    ),
  ];

  List<Product> get products => [..._products];

  List<Product> fetchByCategory(String category) {}
  List<Product> fetchByType(String type) {}
  List<Product> fetchBy(String fetchMechanism) {}
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
