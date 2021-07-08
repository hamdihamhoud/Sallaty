import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:ecart/models/period.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/seller.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _products = [
    Product(
      id: 'p1',
      ownerId: 'o1',
      title: 'Adidas shoes',
      price: 30,
      imageUrls: [
        'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
        'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
        'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
      ],
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      category: 'Other',
      type: 'Other',
      warranty: Period(type: TimeType.days, period: 3),
      replacement: Period(type: TimeType.days, period: 3),
      returning: Period(type: TimeType.days, period: 3),
      colorsAndQuantityAndSizes: {
        Color(0xFF333333): {
          '49': 50,
          '50': 100,
        },
        Color(0xFF828282): {
          '51': 100,
          '52': 200,
        },
        Color(0xFF985424): {
          '53': 300,
          '54': 400,
        },
        Color(0xFF123549): {
          '55': 500,
          '56': 600,
        },
        Color(0xFF112249): {
          '55': 500,
          '56': 600,
        },
        Color(0xFF123549): {
          '55': 500,
          '56': 600,
        },
        Color(0xFF12119): {
          '55': 500,
          '56': 600,
        },
        Color(0xFF111549): {
          '55': 500,
          '56': 600,
        },
        Color(0xFF114549): {
          '55': 500,
          '56': 600,
        },
        Color(0xFF123129): {
          '55': 500,
          '56': 600,
        },
        Color(0xFF153549): {
          '55': 500,
          '56': 600,
        },
        Color(0xFF133549): {
          '55': 500,
          '56': 600,
        },
        Color(0xFF131549): {
          '55': 500,
          '56': 600,
        },
        Color(0xFF133559): {
          '55': 500,
          '56': 600,
        },
        Color(0xFF133449): {
          '55': 500,
          '56': 600,
        },
        Color(0xFF111349): {
          '55': 500,
          '56': 600,
        },
        Color(0xFF122249): {
          '55': 500,
          '56': 600,
        },
        Color(0xFF933340): {
          '55': 500,
          '56': 600,
        },
      },
      specs: {
        'color': 'blue',
        'size': '42 + 43',
        'other': 'running shoes',
      },
    ),
    // Product(
    //   id: 'p1',
    //   ownerId: 'o1',
    //   title: 'Adidas shoesdfssssssssssssssssssssssssssssssssssss',
    //   price: 30,
    //   imageUrls: [
    //     'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    //     'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    //     'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    //   ],
    //   category: 'other',
    //   type: 'other',
    //   description:
    //       'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    //   specs: {
    //     'color': 'blue',
    //     'size': '42 + 43',
    //     'other': 'running shoes',
    //   },
    //   discountPercentage: 20,
    //   colorsAndQuantityAndSizes: {}
    // ),
    // Product(
    //   id: 'p2',
    //   ownerId: 'o2',
    //   title: 'Nikenadmdaknjaldnaldjnladjndlajandldandaldanlkhjcldja',
    //   price: 90,
    //   quantity: 4,
    //   imageUrls: [
    //     'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    //     'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    //     'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    //   ],
    //   category: categories[1].title,
    //   type: categories[1].types[1].title,
    //   description:
    //       'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    //   specs: {
    //     'color': 'Black',
    //     'size': '42 + 43',
    //     'other': 'running shoes',
    //   },
    //   hasDiscount: true,
    //   discountPercentage: 50,
    //   colors: [Colors.black, Colors.blue, Colors.red],
    // ),
    // Product(
    //   id: 'p3',
    //   ownerId: 'o3',
    //   title: 'Didora',
    //   price: 100,
    //   quantity: 10,
    //   imageUrls: [
    //     'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    //     'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    //     'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    //   ],
    //   category: categories[1].title,
    //   type: categories[1].types[1].title,
    //   description:
    //       'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    //   specs: {
    //     'color': 'Red',
    //     'size': '42 + 43',
    //     'other': 'running shoes',
    //   },
    //   hasDiscount: false,
    //   discountPercentage: 0,
    //   colors: [Colors.black, Colors.blue, Colors.red],
    // ),
    // Product(
    //   id: 'p4',
    //   ownerId: 'o3',
    //   title: 'Adibas',
    //   price: 120,
    //   quantity: 50,
    //   imageUrls: [
    //     'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    //     'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    //     'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    //   ],
    //   category: categories[1].title,
    //   type: categories[1].types[1].title,
    //   description:
    //       'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    //   specs: {
    //     'color': 'Red',
    //     'size': '42 + 43',
    //     'other': 'running shoes',
    //   },
    //   hasDiscount: true,
    //   discountPercentage: 10,
    //   colors: [Colors.black, Colors.blue, Colors.red],
    // ),
    // Product(
    //   id: 'p5',
    //   ownerId: 'o3',
    //   title: 'Hamdi',
    //   price: 40,
    //   quantity: 15,
    //   imageUrls: [
    //     'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    //     'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    //     'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    //   ],
    //   category: categories[1].title,
    //   type: categories[1].types[1].title,
    //   description:
    //       'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    //   specs: {
    //     'color': 'Red',
    //     'size': '42 + 43',
    //     'other': 'running shoes',
    //   },
    //   hasDiscount: false,
    //   discountPercentage: 0,
    //   colors: [Colors.black, Colors.blue, Colors.red],
    // ),
    // Product(
    //   id: 'p6',
    //   ownerId: 'o3',
    //   title: 'Khalaf',
    //   price: 300,
    //   quantity: 10,
    //   imageUrls: [
    //     'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    //     'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    //     'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    //   ],
    //   category: categories[1].title,
    //   type: categories[1].types[1].title,
    //   description:
    //       'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    //   specs: {
    //     'color': 'Red',
    //     'size': '42 + 43',
    //     'other': 'running shoes',
    //   },
    //   hasDiscount: true,
    //   discountPercentage: 50,
    //   colors: [Colors.black, Colors.blue, Colors.red],
    // ),
    // Product(
    //   id: 'p7',
    //   ownerId: 'o3',
    //   title: 'Abo Abdo',
    //   price: 2000,
    //   quantity: 10,
    //   imageUrls: [
    //     'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    //     'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    //     'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    //   ],
    //   category: categories[1].title,
    //   type: categories[1].types[1].title,
    //   description:
    //       'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    //   specs: {
    //     'color': 'Red',
    //     'size': '42 + 43',
    //     'other': 'running shoes',
    //   },
    //   hasDiscount: false,
    //   discountPercentage: 0,
    //   colors: [Colors.black, Colors.blue, Colors.red],
    // ),
  ];

  List<Product> get products => [..._products];

  Product findId(String id) {
    return products.firstWhere((element) => element.id == id);
  }

  List<Product> fetchByCategory(String category) {
    return products;
    //_products.where((element) => element.category == category).toList();
  }

  List<Product> fetchByType(String type) {
    return products;
    // _products.where((element) => element.type == type).toList();
  }

  List<Product> getFavorites() {
    // fetch by id first
    return products;
  }

  List<Product> getOffers() {
    //fetch by discount
    return products;
  }

  List<Product> fetchBy(String fetchMechanism) {
    return products;
  }

  List<Product> search(String query) {
    query = query.toLowerCase();
    return products
        .where((element) => element.title.toLowerCase().contains(query))
        .toList();
  }

  List<Product> fetchBySellerRecents() {
    return products;
  }

  void updateRating(String id, double rating) {
    int i = _products.indexWhere((element) => element.id == id);
    _products[i].rating = (_products[i].rating + rating) / 2;
    notifyListeners();
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
      numbers: [0958772317],
      typeOfItems: 'electronics',
    );
  }

  bool removeFromList(String id, int amount,) {
    // if (_products.firstWhere((element) => element.id == id).quantity >=
    //     amount) {
    //   _products.firstWhere((element) => element.id == id).quantity -= amount;
    //   notifyListeners();
    //   return true;
    // }
    return false;
  }

  bool checkIfAvailable(String id) {
    // if (_products.firstWhere((element) => element.id == id).quantity > 0)
    //   return true;
    // else
    return false;
  }

  void addToList(String id, int amount) {
    // _products.firstWhere((element) => element.id == id).quantity += amount;
    notifyListeners();
  }

  void updateProduct(Product product, List<String> img64s) {
    var index = _products.indexWhere((element) => element.id == product.id);
    _products[index] = Product(
      id: product.id,
      title: product.title,
      price: product.price,
      colorsAndQuantityAndSizes: product.colorsAndQuantityAndSizes,
      warranty: product.warranty,
      returning: product.returning,
      replacement: product.replacement,
      category: product.category,
      type: product.type,
      description: product.description,
      discountPercentage: product.discountPercentage,
      specs: product.specs,
      imageUrls: [
        'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
        'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
        'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
      ], //product.imageUrls,
      ownerId: product.ownerId,
      rating: product.rating,
    );

    notifyListeners();
    // log(
    //   json.encode(
    //     {
    //       'id' : product.id,
    //       'images': img64s,
    //       'title': product.title,
    //       'price': product.price,
    //       'colorsAndQuantityAndSizes': product.colorsAndQuantityAndSizes.entries
    //           .map(
    //             (e) => {
    //               'color': e.key.value,
    //               'sizesAndQuantity': e.value.entries
    //                   .map(
    //                     (e) => {
    //                       'size': e.key,
    //                       'quantity': e.value,
    //                     },
    //                   )
    //                   .toList(),
    //             },
    //           )
    //           .toList(),
    //       'warrantyPeriod': product.warranty.period,
    //       'warrantyType': product.warranty.type.toString().split('.').last,
    //       'returningPeriod': product.returning.period,
    //       'returningType': product.returning.type.toString().split('.').last,
    //       'replacementPeriod': product.replacement.period,
    //       'replacementType':
    //           product.replacement.type.toString().split('.').last,
    //       'category': product.category,
    //       'type': product.type,
    //       'description': product.description,
    //       'discountPercentage': product.discountPercentage,
    //       'specs': product.specs,
    //       'rating': product.rating,
    //       'ownerId': product.ownerId,
    //       'imageUrls': product.imageUrls
    //     },
    //   ),
    // );
  }

  // List<String> encodeImages(List<File> images) {
  //   List<String> img64s = [];
  //   for (var i = 0; i < images.length; i++) {
  //     List<int> bytes = images[i].readAsBytesSync().toList();
  //     img64s.add(base64Encode(bytes));
  //   }
  //   return img64s;
  // }

  Future<List<int>> _readFileByte(File image) async {
    List<int> bytes;
    await image.readAsBytes().then((value) {
      bytes = value;
      print('reading of bytes is completed');
    }).catchError((onError) {
      print('Exception Error while reading audio from path:' +
          onError.toString());
    });
    return bytes;
  }

  Future<void> addProduct(Product product, List<File> images) async {
    final List<String> img64s = [];
    for (var i = 0; i < images.length; i++) {
      img64s.add(
        base64Encode(
          await _readFileByte(images[i]),
        ),
      );
    }
    if (product.id != null) {
      updateProduct(product, img64s);
      return;
    }

    product = Product(
      id: '1',
      title: product.title,
      price: product.price,
      colorsAndQuantityAndSizes: product.colorsAndQuantityAndSizes,
      warranty: product.warranty,
      returning: product.returning,
      replacement: product.replacement,
      category: product.category,
      type: product.type,
      description: product.description,
      discountPercentage: product.discountPercentage,
      specs: product.specs,
      imageUrls: [
        'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
        'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
        'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
      ],
      ownerId: 'h1',
    );
    _products.add(product);
    notifyListeners();

    // log(
    //   json.encode(
    //     {
    //       'images': img64s,
    //       'title': product.title,
    //       'price': product.price,
    //       'colorsAndQuantityAndSizes': product.colorsAndQuantityAndSizes.entries
    //           .map(
    //             (e) => {
    //               'color': e.key.value,
    //               'sizesAndQuantity': e.value.entries
    //                   .map(
    //                     (e) => {
    //                       'size': e.key,
    //                       'quantity': e.value,
    //                     },
    //                   )
    //                   .toList(),
    //             },
    //           )
    //           .toList(),
    //       'warrantyPeriod': product.warranty.period,
    //       'warrantyType': product.warranty.type.toString().split('.').last,
    //       'returningPeriod': product.returning.period,
    //       'returningType': product.returning.type.toString().split('.').last,
    //       'replacementPeriod': product.replacement.period,
    //       'replacementType':
    //           product.replacement.type.toString().split('.').last,
    //       'category': product.category,
    //       'type': product.type,
    //       'description': product.description,
    //       'discountPercentage': product.discountPercentage,
    //       'specs': product.specs,
    //       'rating': product.rating,
    //       'ownerId': product.ownerId,
    //     },
    //   ),
    // );
  }

  List<Product> premiumAllProducts() {
    return products;
  }
}
