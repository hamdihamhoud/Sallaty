import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String ownerId;
  final String title;
  final double price;
  final List<String> imageUrls;
  final String category;
  final String type;
  final bool warranty;
  final int warrantyPeriod;
  double rating;
  final bool isReplaceable;
  final int replacementPeriod;
  final bool isReturnable;
  final int returningPeriod;
  final String description;
  final Map<String, String> specs;
  final bool hasDiscount;
  final int discountPercentage;
  final List<Color> colors;
  bool isFavorite;
  int quantity;

  Product({
    this.id,
    this.ownerId,
    this.title,
    this.price,
    this.quantity,
    this.imageUrls,
    this.category,
    this.type = '',
    this.description,
    this.specs,
    this.warranty = false,
    this.warrantyPeriod = 0,
    this.rating = 1,
    this.isReplaceable = false,
    this.replacementPeriod = 0,
    this.isReturnable = false,
    this.returningPeriod = 0,
    this.hasDiscount = false,
    this.discountPercentage = 0,
    this.isFavorite = false,
    this.colors,
  });

  //     void _setFavValue(bool newValue) {
  //   isFavorite = newValue;
  //   notifyListeners();
  // }

  Future<void> toggleFav(
      // String token,
      // String userId,
      ) async {
    // final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    // final url = 'https://shop-app-flutter-course-6285f-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$token';
    // try {
    //   final response = await http.put(
    //     url,
    //     body: json.encode(isFavorite),
    //   );
    //   if (response.statusCode >= 400) {
    //     _setFavValue(oldStatus);
    //   }
    // } catch (error) {
    //   _setFavValue(oldStatus);
    // }
  }
}
