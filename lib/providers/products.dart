import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:ecart/models/period.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/seller.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _products = [];
  String _token;
  String _userId;

  void setToken(String token) {
    _token = token;
  }

  void setUserId(String id) {
    _userId = id;
  }

  List<Product> get products => [..._products];

  void addProductToList(Product product) {
    if (_products.indexWhere((element) => element.id == product.id) == -1)
      _products.add(product);
  }

  Future<Product> findId(String id) async {
    // fetch by id
    final url = Uri.parse('https://hamdi1234.herokuapp.com/product/$id');
    final response = await http.get(url, headers: {
      'usertype': 'vendor',
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': _token,
    });
    final responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      final responseColorsAndQuantityAndSizes =
          responseData['colorsAndQuantityAndSizes'] as List;
      Map<Color, Map<String, int>> colorsAndQuantityAndSizes = {};
      responseColorsAndQuantityAndSizes.forEach((element) {
        colorsAndQuantityAndSizes.putIfAbsent(Color(element['color']), () {
          final responseSizesAndQuantity = element['sizesAndQuantity'] as List;
          Map<String, int> sizesAndQuantity = {};
          responseSizesAndQuantity.forEach((secondElement) {
            sizesAndQuantity.putIfAbsent(
                secondElement['size'], () => secondElement['quantity']);
          });
          return sizesAndQuantity;
        });
      });
      final responseSpecs = responseData['specs'] as Map;
      Map<String, String> specs = {};
      responseSpecs.forEach((key, value) {
        specs.putIfAbsent(key, () => value);
      });
      final responseImages = responseData['images'] as List;
      List<String> images = [];
      responseImages.forEach((element) {
        images.add(element);
      });
      final product = Product(
        id: responseData['_id'],
        title: responseData['name'],
        price: double.parse(responseData['price'].toString()),
        colorsAndQuantityAndSizes: colorsAndQuantityAndSizes,
        warranty: Period(type: TimeType.years, period: 2),
        returning: Period(type: TimeType.weeks, period: 2),
        replacement: Period(type: TimeType.weeks, period: 3),
        category: responseData['category'],
        type: responseData['type'],
        description: responseData['discription'],
        discountPercentage: double.parse(responseData['discount'].toString()),
        specs: specs,
        imageUrls: images,
        ownerId: responseData['owner'],
      );
      return product;
    } else {
      throw HttpException(response.body);
    }
  }

  Future<List<Product>> fetchByCategory(String category) async {
    final url =
        Uri.parse("https://hamdi1234.herokuapp.com/product?category=$category");
    final response = await http.get(url, headers: {
      'usertype': 'vendor',
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': _token,
    });
    final responseData = json.decode(response.body) as List;
    List<Product> typeProducts = [];
    if (response.statusCode == 200) {
      responseData.forEach((element) {
        final responseColorsAndQuantityAndSizes =
            element['colorsAndQuantityAndSizes'] as List;
        Map<Color, Map<String, int>> colorsAndQuantityAndSizes = {};
        responseColorsAndQuantityAndSizes.forEach((secondElement) {
          colorsAndQuantityAndSizes.putIfAbsent(Color(secondElement['color']),
              () {
            final responseSizesAndQuantity =
                secondElement['sizesAndQuantity'] as List;
            Map<String, int> sizesAndQuantity = {};
            responseSizesAndQuantity.forEach((thirdElement) {
              sizesAndQuantity.putIfAbsent(
                  thirdElement['size'], () => thirdElement['quantity']);
            });
            return sizesAndQuantity;
          });
        });
        final responseSpecs = element['specs'] as Map;
        Map<String, String> specs = {};
        responseSpecs.forEach((key, value) {
          specs.putIfAbsent(key, () => value);
        });
        final responseImages = element['images'] as List;
        List<String> images = [];
        responseImages.forEach((element) {
          images.add(element);
        });
        final product = Product(
          id: element['_id'],
          title: element['name'],
          price: double.parse(element['price'].toString()),
          colorsAndQuantityAndSizes: colorsAndQuantityAndSizes,
          warranty: Period(type: TimeType.months, period: 0),
          returning: Period(type: TimeType.months, period: 0),
          replacement: Period(type: TimeType.months, period: 0),
          category: element['category'],
          type: element['type'],
          description: element['discription'],
          discountPercentage: double.parse(element['discount'].toString()),
          specs: specs,
          imageUrls: images,
          ownerId: element['owner'],
        );
        addProductToList(product);
        typeProducts.add(product);
      });
    } else {
      throw HttpException(response.body);
    }
    // notifyListeners();
    return typeProducts;
  }

  Future<List<Product>> fetchByType(String type) async {
    final url = Uri.parse(
        "https://hamdi1234.herokuapp.com/getProductByType?type=$type");
    final response = await http.get(url, headers: {
      'usertype': 'vendor',
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': _token,
    });
    final responseData = json.decode(response.body) as List;
    List<Product> typeProducts = [];
    if (response.statusCode == 200) {
      responseData.forEach((element) {
        final responseColorsAndQuantityAndSizes =
            element['colorsAndQuantityAndSizes'] as List;
        Map<Color, Map<String, int>> colorsAndQuantityAndSizes = {};
        responseColorsAndQuantityAndSizes.forEach((secondElement) {
          colorsAndQuantityAndSizes.putIfAbsent(Color(secondElement['color']),
              () {
            final responseSizesAndQuantity =
                secondElement['sizesAndQuantity'] as List;
            Map<String, int> sizesAndQuantity = {};
            responseSizesAndQuantity.forEach((thirdElement) {
              sizesAndQuantity.putIfAbsent(
                  thirdElement['size'], () => thirdElement['quantity']);
            });
            return sizesAndQuantity;
          });
        });
        final responseSpecs = element['specs'] as Map;
        Map<String, String> specs = {};
        responseSpecs.forEach((key, value) {
          specs.putIfAbsent(key, () => value);
        });
        final responseImages = element['images'] as List;
        List<String> images = [];
        responseImages.forEach((element) {
          images.add(element);
        });
        final product = Product(
          id: element['_id'],
          title: element['name'],
          price: double.parse(element['price'].toString()),
          colorsAndQuantityAndSizes: colorsAndQuantityAndSizes,
          warranty: Period(type: TimeType.months, period: 0),
          returning: Period(type: TimeType.months, period: 0),
          replacement: Period(type: TimeType.months, period: 0),
          category: element['category'],
          type: element['type'],
          description: element['discription'],
          discountPercentage: double.parse(element['discount'].toString()),
          specs: specs,
          imageUrls: images,
          ownerId: element['owner'],
        );
        addProductToList(product);
        typeProducts.add(product);
      });
    } else {
      throw HttpException(response.body);
    }
    // notifyListeners();
    return typeProducts;
  }

  Future<List<Product>> getFavorites() async {
    List<Product> favorites = [];
    final url = Uri.parse('https://hamdi1234.herokuapp.com/getWishlist');
    final response = await http.get(url, headers: {
      'usertype': 'vendor',
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': _token,
    });
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(json.decode(response.body));
    } else {
      throw response.body;
    }
    return favorites;
  }

  Future<List<Product>> getOffers() async {
    // final url = Uri.parse("https://hamdi1234.herokuapp.com/offers");
    // final response = await http.get(url, headers: {
    //   'usertype': 'vendor',
    //   'Content-Type': 'application/json; charset=UTF-8',
    //   'authorization': _token,
    // });
    // final responseData = json.decode(response.body) as List;
    // List<Product> offers = [];
    // if (response.statusCode == 200) {
    //   responseData.forEach((element) {
    //     final responseColorsAndQuantityAndSizes =
    //         element['colorsAndQuantityAndSizes'] as List;
    //     Map<Color, Map<String, int>> colorsAndQuantityAndSizes = {};
    //     responseColorsAndQuantityAndSizes.forEach((secondElement) {
    //       colorsAndQuantityAndSizes.putIfAbsent(Color(secondElement['color']),
    //           () {
    //         final responseSizesAndQuantity =
    //             secondElement['sizesAndQuantity'] as List;
    //         Map<String, int> sizesAndQuantity = {};
    //         responseSizesAndQuantity.forEach((thirdElement) {
    //           sizesAndQuantity.putIfAbsent(
    //               thirdElement['size'], () => thirdElement['quantity']);
    //         });
    //         return sizesAndQuantity;
    //       });
    //     });
    //     final responseSpecs = element['specs'] as Map;
    //     Map<String, String> specs = {};
    //     responseSpecs.forEach((key, value) {
    //       specs.putIfAbsent(key, () => value);
    //     });
    //     final responseImages = element['images'] as List;
    //     List<String> images = [];
    //     responseImages.forEach((element) {
    //       images.add(element);
    //     });
    //     final product = Product(
    //       id: element['_id'],
    //       title: element['name'],
    //       price: double.parse(element['price'].toString()),
    //       colorsAndQuantityAndSizes: colorsAndQuantityAndSizes,
    //       warranty: Period(type: TimeType.months, period: 0),
    //       returning: Period(type: TimeType.months, period: 0),
    //       replacement: Period(type: TimeType.months, period: 0),
    //       category: element['category'],
    //       type: element['type'],
    //       description: element['discription'],
    //       discountPercentage: double.parse(element['discount'].toString()),
    //       specs: specs,
    //       imageUrls: images,
    //       ownerId: element['owner'],
    //     );
    //     addProductToList(product);
    //     offers.add(product);
    //   });
    // } else {
    //   throw HttpException(response.body);
    // }
    // notifyListeners();
    return [];//offers;
  }

  Future<List<Product>> fetchBy(String fetchMechanism) async {
    Uri url;
    if (fetchMechanism == 'Most Recent') {
      url = Uri.parse('https://hamdi1234.herokuapp.com/recent');
    } else if (fetchMechanism == 'Highest Rated') {
      url = Uri.parse('https://hamdi1234.herokuapp.com/productrate');
    } else if (fetchMechanism == 'Best Seller') {
      url = Uri.parse('https://hamdi1234.herokuapp.com/bestsalles');
    }
    final response = await http.get(
      url,
      headers: {
        'usertype': 'vendor',
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': _token,
      },
    );
    final responseData = json.decode(response.body) as List;
    List<Product> typeProducts = [];
    if (response.statusCode == 200) {
      responseData.forEach((element) {
        final responseColorsAndQuantityAndSizes =
            element['colorsAndQuantityAndSizes'] as List;
        Map<Color, Map<String, int>> colorsAndQuantityAndSizes = {};
        responseColorsAndQuantityAndSizes.forEach((secondElement) {
          colorsAndQuantityAndSizes.putIfAbsent(Color(secondElement['color']),
              () {
            final responseSizesAndQuantity =
                secondElement['sizesAndQuantity'] as List;
            Map<String, int> sizesAndQuantity = {};
            responseSizesAndQuantity.forEach((thirdElement) {
              sizesAndQuantity.putIfAbsent(
                  thirdElement['size'], () => thirdElement['quantity']);
            });
            return sizesAndQuantity;
          });
        });
        final responseSpecs = element['specs'] as Map;
        Map<String, String> specs = {};
        responseSpecs.forEach((key, value) {
          specs.putIfAbsent(key, () => value);
        });
        final responseImages = element['images'] as List;
        List<String> images = [];
        responseImages.forEach((element) {
          images.add(element);
        });
        final product = Product(
          id: element['_id'],
          title: element['name'],
          price: double.parse(element['price'].toString()),
          colorsAndQuantityAndSizes: colorsAndQuantityAndSizes,
          warranty: Period(type: TimeType.months, period: 0),
          returning: Period(type: TimeType.months, period: 0),
          replacement: Period(type: TimeType.months, period: 0),
          category: element['category'],
          type: element['type'],
          description: element['discription'],
          discountPercentage: double.parse(element['discount'].toString()),
          specs: specs,
          imageUrls: images,
          ownerId: element['owner'],
        );
        addProductToList(product);
        typeProducts.add(product);
      });
    } else {
      throw HttpException(response.body);
    }
    // notifyListeners();
    return typeProducts;
  }

  Future<List<Product>> search(String query) async {
    query = query.toLowerCase();
    final url = Uri.parse('https://hamdi1234.herokuapp.com/search');
    final response = await http.post(
      url,
        headers: {
        'usertype': 'vendor',
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': _token,
      },
      body: json.encode({
        'search' : query,

      })
    );
    final responseData = json.decode(response.body) as List;
    List<Product> searchProducts = [];
    if (response.statusCode == 200 || response.statusCode == 201) {
       responseData.forEach((element) {
        final responseColorsAndQuantityAndSizes =
            element['colorsAndQuantityAndSizes'] as List;
        Map<Color, Map<String, int>> colorsAndQuantityAndSizes = {};
        responseColorsAndQuantityAndSizes.forEach((secondElement) {
          colorsAndQuantityAndSizes.putIfAbsent(Color(secondElement['color']),
              () {
            final responseSizesAndQuantity =
                secondElement['sizesAndQuantity'] as List;
            Map<String, int> sizesAndQuantity = {};
            responseSizesAndQuantity.forEach((thirdElement) {
              sizesAndQuantity.putIfAbsent(
                  thirdElement['size'], () => thirdElement['quantity']);
            });
            return sizesAndQuantity;
          });
        });
        final responseSpecs = element['specs'] as Map;
        Map<String, String> specs = {};
        responseSpecs.forEach((key, value) {
          specs.putIfAbsent(key, () => value);
        });
        final responseImages = element['images'] as List;
        List<String> images = [];
        responseImages.forEach((element) {
          images.add(element);
        });
        final product = Product(
          id: element['_id'],
          title: element['name'],
          price: double.parse(element['price'].toString()),
          colorsAndQuantityAndSizes: colorsAndQuantityAndSizes,
          warranty: Period(type: TimeType.months, period: 0),
          returning: Period(type: TimeType.months, period: 0),
          replacement: Period(type: TimeType.months, period: 0),
          category: element['category'],
          type: element['type'],
          description: element['discription'],
          discountPercentage: double.parse(element['discount'].toString()),
          specs: specs,
          imageUrls: images,
          ownerId: element['owner'],
        );
        addProductToList(product);
        searchProducts.add(product);
      });
    }else{
      throw response.body;
    }
        return searchProducts;
  }

  List<Product> fetchBySellerRecents() {
    return products;
  }

  void updateRating(String id, double rating) {
    int i = _products.indexWhere((element) => element.id == id);
    _products[i].rating = (_products[i].rating + rating) / 2;
    notifyListeners();
  }

  Future<String> findSellerName(String sellerId) async {
    final url =
        Uri.parse('https://hamdi1234.herokuapp.com/ownerinformation/$sellerId');
    final response = await http.get(url, headers: {
      'usertype': 'vendor',
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': _token,
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseDate = json.decode(response.body);
      return responseDate['name'];
    } else {
      throw response.body;
    }
  }

  int getProductMaxAmount(
    String id,
    Color _selectedColor,
    String _selectedSize,
  ) {
    return _products
        .firstWhere((element) => element.id == id)
        .colorsAndQuantityAndSizes
        .entries
        .firstWhere((element) => element.key == _selectedColor)
        .value
        .entries
        .firstWhere((element) => element.key == _selectedSize)
        .value;
  }

  void removeFromList(
      {@required String id,
      @required Color color,
      @required int amount,
      String size = '0'}) {
    var productIndex = _products.indexWhere((element) => element.id == id);
    _products[productIndex]
        .colorsAndQuantityAndSizes
        .entries
        .firstWhere((element) => element.key == color)
        .value
        .update(size, (value) => value - amount);
    notifyListeners();
  }

  bool checkIfAvailable(
      {@required String id,
      @required Color color,
      @required int amount,
      String size = '0'}) {
    var productIndex = _products.indexWhere((element) => element.id == id);
    if (_products[productIndex]
            .colorsAndQuantityAndSizes
            .entries
            .firstWhere((element) => element.key == color)
            .value
            .entries
            .firstWhere((element) => element.key == size)
            .value >=
        amount) {
      return true;
    }
    return false;
  }

  void addToList(
      {@required String id,
      @required Color color,
      @required int amount,
      String size = '0'}) {
    var productIndex = _products.indexWhere((element) => element.id == id);
    _products[productIndex]
        .colorsAndQuantityAndSizes
        .entries
        .firstWhere((element) => element.key == color)
        .value
        .update(size, (value) => value + amount);
    notifyListeners();
  }

  int quantityCounter({Product product, int colorsNumber}) {
    int quantity = 0;
    for (int i = 0; i < colorsNumber; i++) {
      for (int j = 0;
          j <
              product.colorsAndQuantityAndSizes.entries
                  .elementAt(i)
                  .value
                  .values
                  .length;
          j++) {
        quantity += product.colorsAndQuantityAndSizes.entries
            .elementAt(i)
            .value
            .values
            .elementAt(j)
            .toInt();
      }
    }
    return quantity;
  }

  Future<void> updateProduct(Product product, List<String> img64s) async {
    final url =
        Uri.parse("https://hamdi1234.herokuapp.com/product/${product.id}");
    var response = await http.post(
      url,
      headers: {
        'usertype': 'vendor',
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': _token,
      },
      body: json.encode(
        {
          'images': img64s,
          'name': product.title,
          'price': product.price,
          'colorsAndQuantityAndSizes': product.colorsAndQuantityAndSizes.entries
              .map(
                (e) => {
                  'color': e.key.value,
                  'sizesAndQuantity': e.value.entries
                      .map(
                        (e) => {
                          'size': e.key,
                          'quantity': e.value,
                        },
                      )
                      .toList(),
                },
              )
              .toList(),
          'warranty_period': product.warranty.period,
          'warrantyType': product.warranty.type.toString().split('.').last,
          'returning_period': product.returning.period,
          'returningType': product.returning.type.toString().split('.').last,
          'replacing_period': product.replacement.period,
          'replacementType':
              product.replacement.type.toString().split('.').last,
          'category': product.category,
          'type': product.type,
          'discription': product.description,
          'discount': product.discountPercentage,
          'specs': product.specs,
          'rating': product.rating,
        },
      ),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      notifyListeners();
      return;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      var responseData = json.decode(response.body);
      print(responseData);
      throw HttpException(responseData);
    }
  }

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
    final url = Uri.parse("https://hamdi1234.herokuapp.com/product");
    var response = await http.post(
      url,
      headers: {
        'usertype': 'vendor',
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': _token,
      },
      body: json.encode(
        {
          'images': img64s,
          'name': product.title,
          'price': product.price,
          'colorsAndQuantityAndSizes': product.colorsAndQuantityAndSizes.entries
              .map(
                (e) => {
                  'color': e.key.value,
                  'sizesAndQuantity': e.value.entries
                      .map(
                        (e) => {
                          'size': e.key,
                          'quantity': e.value,
                        },
                      )
                      .toList(),
                },
              )
              .toList(),
          'warranty_period': product.warranty.period,
          'warrantyType': product.warranty.type.toString().split('.').last,
          'returning_period': product.returning.period,
          'returningType': product.returning.type.toString().split('.').last,
          'replacing_period': product.replacement.period,
          'replacementType':
              product.replacement.type.toString().split('.').last,
          'category': product.category,
          'type': product.type,
          'discription': product.description,
          'discount': product.discountPercentage,
          'specs': product.specs,
          'rating': product.rating,
        },
      ),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      notifyListeners();
      return;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      var responseData = json.decode(response.body);
      print(responseData);
      throw HttpException(responseData);
    }
  }

  Future<List<Product>> premiumAllProducts() async {
    final url =
        Uri.parse("https://hamdi1234.herokuapp.com/productowner/$_userId");
    final response = await http.get(url, headers: {
      'usertype': 'vendor',
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': _token,
    });
    final responseData = json.decode(response.body) as List;
    List<Product> typeProducts = [];
    if (response.statusCode == 200) {
      responseData.forEach((element) {
        final responseColorsAndQuantityAndSizes =
            element['colorsAndQuantityAndSizes'] as List;
        Map<Color, Map<String, int>> colorsAndQuantityAndSizes = {};
        responseColorsAndQuantityAndSizes.forEach((secondElement) {
          colorsAndQuantityAndSizes.putIfAbsent(Color(secondElement['color']),
              () {
            final responseSizesAndQuantity =
                secondElement['sizesAndQuantity'] as List;
            Map<String, int> sizesAndQuantity = {};
            responseSizesAndQuantity.forEach((thirdElement) {
              sizesAndQuantity.putIfAbsent(
                  thirdElement['size'], () => thirdElement['quantity']);
            });
            return sizesAndQuantity;
          });
        });
        final responseSpecs = element['specs'] as Map;
        Map<String, String> specs = {};
        responseSpecs.forEach((key, value) {
          specs.putIfAbsent(key, () => value);
        });
        final responseImages = element['images'] as List;
        List<String> images = [];
        responseImages.forEach((element) {
          images.add(element);
        });
        final product = Product(
          id: element['_id'],
          title: element['name'],
          price: double.parse(element['price'].toString()),
          colorsAndQuantityAndSizes: colorsAndQuantityAndSizes,
          warranty: Period(type: TimeType.months, period: 0),
          returning: Period(type: TimeType.months, period: 0),
          replacement: Period(type: TimeType.months, period: 0),
          category: element['category'],
          type: element['type'],
          description: element['discription'],
          discountPercentage: double.parse(element['discount'].toString()),
          specs: specs,
          imageUrls: images,
          ownerId: element['owner'],
        );
        typeProducts.insert(0, product);
      });
    } else {
      throw HttpException(response.body);
    }
    // notifyListeners();
    return typeProducts;
  }
}
