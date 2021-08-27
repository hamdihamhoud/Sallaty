import 'package:ecart/models/period.dart';
import 'package:ecart/models/product.dart';
import 'package:flutter/material.dart';

import 'cart.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'products.dart';

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
  final mainUrl = 'https://hamdi1234.herokuapp.com';
  // List<Order> _orders = [];
  String _token;
  String _userId;

  Future<int> checkCopon(String code) async {
    final url = Uri.parse('$mainUrl/$code');
    final response = await http.get(url, headers: {
      'usertype': 'vendor',
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': _token,
    });
    final responseJson = json.decode(response.body);
    // final responseData = responseJson[];
    if (response.statusCode == 200) {}
  }

  void setToken(String token) {
    _token = token;
  }

  void setUserId(String id) {
    _userId = id;
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
    } else {
      throw response.body;
    }
  }

  Future<List<Order>> get orders async {
    List<Order> responseOrders = [];
    final url = Uri.parse('$mainUrl/ordersByBuyer/$_userId');
    print(url);
    final response = await http.get(
      url,
      headers: {
        'usertype': 'vendor',
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': _token,
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = json.decode(response.body) as List;
      for (var i = 0; i < responseData.length; i++) {
        List<CartItem> products = [];
        final product =
            await findId(responseData[i]['orderItem']['product_id']);
        products.add(CartItem(
          id: responseData[i]['orderItem']['product_id'],
          productId: responseData[i]['orderItem']['product_id'],
          color: Color(responseData[i]['orderItem']['color']),
          quantity: responseData[i]['orderItem']['quantity'],
          size: responseData[i]['orderItem']['size'],
          imageUrl: product.imageUrls.first,
          price: product.price,
          title: product.title,
        ));
        final order = Order(
          amount: responseData[i]['total'],
          address: 'address',
          products: products,
          dateTime: DateTime.parse(responseData[i]['date']),
        );
        responseOrders.add(order);
        print(responseOrders);
        return responseOrders;
      }
    } else {
      throw response.body;
    }
    return [];
  }

  Future<void> addOrder(
      List<CartItem> cartProducts, double total, String address) async {
    final url = Uri.parse('$mainUrl/orders');
    print(url);
    print(_token);
    print(_userId);
    print(json.encode({
      'orderItems': cartProducts
          .map((e) => {
                'product_id': e.productId,
                'quantity': e.quantity,
                'color': e.color.value,
                'size': e.size,
              })
          .toList(),
      'total': total,
      'address': address,
    }));
    final response = await http.post(url,
        headers: {
          'usertype': 'vendor',
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': _token,
        },
        body: json.encode({
          'orderItems': cartProducts
              .map((e) => {
                    'product_id': e.productId,
                    'quantity': e.quantity,
                    'color': e.color.value,
                    'size': e.size,
                  })
              .toList(),
          'total': total,
          'address': address,
        }));

    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
    } else {
      throw response.body;
    }
  }

  Future<List<CartItem>> fetchSellerOrders() async {
    print('hi');
    final url = Uri.parse('$mainUrl/orderBySeller/$_userId');
    final response = await http.get(url, headers: {
      'usertype': 'vendor',
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': _token,
    });
    List<CartItem> orderItems = [];
    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = json.decode(response.body) as List;
      for (var i = 0; i < responseData.length; i++) {
        final product = await findId(responseData[i]['order']['product_id']);
        var status = Status.Ordered;
        if (responseData[i]['isConfirmed'] == true) {
          status = Status.Ordered;
          if (responseData[i]['beingDelivered'] == true) {
            status = Status.Shiped;
            if (responseData[i]['isDelivered'] == true)
              status = Status.Delivered;
          }
        }
        final order = CartItem(
          id: responseData[i]['order']['product_id'],
          productId: responseData[i]['order']['product_id'],
          title: product.title,
          quantity: responseData[i]['order']['quantity'],
          price: product.price,
          imageUrl: product.imageUrls.first,
          color: Color(responseData[i]['order']['color']),
          size: responseData[i]['order']['size'],
          status: status,
        );
        orderItems.add(order);
      }
    } else {
      throw response.body;
    }
    return orderItems;
  }

  Future<int> getOrderDeliveryCharge() async {
    int deliveryCharge = 2000;
    Uri url = Uri.parse('$mainUrl/deliveryprice');

    final response = await http.get(url, headers: {
      'usertype': 'vendor',
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': _token,
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = json.decode(response.body);
      deliveryCharge = responseData['solditems'];
    } else {
      throw response.body;
    }
    return deliveryCharge;
  }
}
