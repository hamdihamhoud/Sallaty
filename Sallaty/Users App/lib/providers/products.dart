import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:ecart/models/period.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductsProvider with ChangeNotifier {
  final mainUrl = 'https://sallaty-store.herokuapp.com';
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

  Product setProductFromResponse(dynamic responseData, bool isFavorite) {
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
      isFavorite: isFavorite,
      id: responseData['_id'],
      title: responseData['name'],
      price: double.parse(responseData['price'].toString()),
      colorsAndQuantityAndSizes: colorsAndQuantityAndSizes,
      warranty: Period(
        type: responseData['warrantyType'] == 'days'
            ? TimeType.days
            : responseData['warrantyType'] == 'months'
                ? TimeType.months
                : responseData['warrantyType'] == 'weeks'
                    ? TimeType.weeks
                    : TimeType.years,
        period: responseData['warranty_period'],
      ),
      returning: Period(
        type: responseData['returningType'] == 'days'
            ? TimeType.days
            : responseData['returningType'] == 'months'
                ? TimeType.months
                : responseData['returningType'] == 'weeks'
                    ? TimeType.weeks
                    : TimeType.years,
        period: responseData['returning_period'],
      ),
      replacement: Period(
        type: responseData['replacementType'] == 'days'
            ? TimeType.days
            : responseData['replacementType'] == 'months'
                ? TimeType.months
                : responseData['replacementType'] == 'weeks'
                    ? TimeType.weeks
                    : TimeType.years,
        period: responseData['replacing_period'],
      ),
      category: responseData['category'],
      type: responseData['type'],
      description: responseData['discription'],
      discountPercentage: double.parse(responseData['discount'].toString()),
      specs: specs,
      imageUrls: images,
      ownerId: responseData['owner'],
    );
    return product;
  }

  Future<Product> findId(String id) async {
    // fetch by id
    final url = Uri.parse('$mainUrl/product/$id');
    final response = await http.get(url, headers: {
      'usertype': 'vendor',
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': _token,
    });
    final responseJson = json.decode(response.body);
    final responseData = responseJson['product'];
    if (response.statusCode == 200) {
      return setProductFromResponse(responseData, responseJson['isAdded']);
    } else {
      throw HttpException(response.body);
    }
  }

  Future<List<Product>> fetchByCategory(String category) async {
    final url = Uri.parse("$mainUrl/product?category=$category");
    final response = await http.get(url, headers: {
      'usertype': 'vendor',
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': _token,
    });
    final responseData = json.decode(response.body) as List;
    List<Product> typeProducts = [];
    if (response.statusCode == 200) {
      responseData.forEach((element) {
        final product =
            setProductFromResponse(element['product'], element['isAdded']);
        addProductToList(product);
        typeProducts.add(product);
      });
    } else {
      throw HttpException(response.body);
    }
    return typeProducts;
  }

  Future<List<Product>> fetchByType(String type) async {
    final url = Uri.parse("$mainUrl/getProductByType?type=$type");
    final response = await http.get(url, headers: {
      'usertype': 'vendor',
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': _token,
    });
    final responseData = json.decode(response.body) as List;
    List<Product> typeProducts = [];
    if (response.statusCode == 200) {
      responseData.forEach((element) {
        final product =
            setProductFromResponse(element['product'], element['isAdded']);
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
    final url = Uri.parse('$mainUrl/getWishlist');
    final response = await http.get(url, headers: {
      'usertype': 'vendor',
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': _token,
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = json.decode(response.body) as List;
      responseData.forEach((element) {
        final product = setProductFromResponse(element['product'], true);
        addProductToList(product);
        favorites.add(product);
      });
    } else {
      throw response.body;
    }
    return favorites;
  }

  Future<List<Product>> getOffers() async {
    final url = Uri.parse("$mainUrl/offers");
    final response = await http.get(url, headers: {
      'usertype': 'vendor',
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': _token,
    });
    final responseData = json.decode(response.body) as List;
    List<Product> offers = [];
    if (response.statusCode == 200) {
      responseData.forEach((element) {
        final product =
            setProductFromResponse(element['product'], element['isAdded']);
        addProductToList(product);
        offers.add(product);
      });
    } else {
      throw HttpException(response.body);
    }
    notifyListeners();

    return offers;
  }

  Future<List<Product>> fetchBy(String fetchMechanism) async {
    Uri url;
    if (fetchMechanism == 'Most Recent') {
      url = Uri.parse('$mainUrl/recent');
    } else if (fetchMechanism == 'Highest Rated') {
      url = Uri.parse('$mainUrl/productrate');
    } else if (fetchMechanism == 'Best Seller') {
      url = Uri.parse('$mainUrl/bestsalles');
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
        final product =
            setProductFromResponse(element['product'], element['isAdded']);
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
    final url = Uri.parse('$mainUrl/search');
    final response = await http.post(url,
        headers: {
          'usertype': 'vendor',
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': _token,
        },
        body: json.encode({
          'search': query,
        }));
    final responseData = json.decode(response.body) as List;
    List<Product> searchProducts = [];
    if (response.statusCode == 200 || response.statusCode == 201) {
      responseData.forEach((element) {
        final product =
            setProductFromResponse(element['product'], element['isAdded']);
        addProductToList(product);
        searchProducts.add(product);
      });
    } else {
      throw response.body;
    }
    return searchProducts;
  }

  Future<void> updateRating(String id, double rating) async {
    final url = Uri.parse('$mainUrl/rate/$id');
    final response = await http.post(url,
        headers: {
          'usertype': 'vendor',
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': _token,
        },
        body: json.encode({
          "rate": rating,
        }));
        if (response.statusCode != 200 && response.statusCode != 201) {
          throw response.body;
        }
    notifyListeners();
  }

  Future<String> findSellerName(String sellerId) async {
    final url = Uri.parse('$mainUrl/ownerinformation/$sellerId');
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
    final url = Uri.parse("$mainUrl/product/${product.id}");
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
    final url = Uri.parse("$mainUrl/product");
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
    final url = Uri.parse("$mainUrl/productowner/$_userId");
    final response = await http.get(url, headers: {
      'usertype': 'vendor',
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': _token,
    });
    final responseData = json.decode(response.body) as List;
    List<Product> typeProducts = [];
    if (response.statusCode == 200) {
      responseData.forEach((element) {
        final product = setProductFromResponse(element['product'], false);
        typeProducts.insert(0, product);
      });
    } else {
      throw HttpException(response.body);
    }
    // notifyListeners();
    return typeProducts;
  }

  Future<String> getPremiumHighestRatedProductName() async {
    String productName = '';
    final url = Uri.parse('$mainUrl/highestrated/$_userId');
    final response = await http.get(url, headers: {
      'usertype': 'vendor',
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': _token,
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = json.decode(response.body) as List;
      if (responseData.first['name'] != null)
        productName = responseData.first['name'];
    } else {
      throw response.body;
    }
    return productName;
  }

  Future<String> getPremiumTotalEarnings(String period) async {
    String totalEarnings = '';
    Uri url;
    if (period == 'This Month') {
      url = Uri.parse('$mainUrl/monthearnings/$_userId');
    } else if (period == 'Last Month') {
      url = Uri.parse('$mainUrl/lastearnings/$_userId');
    } else {
      url = Uri.parse('$mainUrl/yearearnings/$_userId');
    }
    final response = await http.get(url, headers: {
      'usertype': 'vendor',
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': _token,
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = json.decode(response.body);
      totalEarnings = responseData['earnings'].toString();
    } else {
      throw response.body;
    }
    return totalEarnings;
  }

  Future<String> getPremiumTotalItemsSold(String period) async {
    String totalEarnings = '';
    Uri url;
    if (period == 'This Month') {
      url = Uri.parse('$mainUrl/monthsolditems/$_userId');
    } else if (period == 'Last Month') {
      url = Uri.parse('$mainUrl/lastsolditems/$_userId');
    } else {
      url = Uri.parse('$mainUrl/yearsolditems/$_userId');
    }
    final response = await http.get(
      url,
      headers: {
        'usertype': 'vendor',
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': _token,
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = json.decode(response.body);
      totalEarnings = responseData['solditems'].toString();
    } else {
      throw response.body;
    }
    return totalEarnings;
  }

  void clearProducts() {
    _products.clear();
    notifyListeners();
  }
}
