import 'package:ecart/models/period.dart';
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
  final Period warranty;
  double rating;
  final Period replacement;
  final Period returning;
  final String description;
  final Map<String, String> specs;
  final double discountPercentage;
  final Map<Color, Map<String, int>> colorsAndQuantityAndSizes;
  bool isFavorite;

  Product({
    this.id,
    this.ownerId,
    this.title,
    this.price,
    this.imageUrls,
    this.category,
    this.type = '',
    this.description,
    this.specs,
    this.warranty,
    this.rating = 1,
    this.replacement,
    this.returning,
    this.discountPercentage = 0,
    this.isFavorite = false,
    this.colorsAndQuantityAndSizes,
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
