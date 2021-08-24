import 'package:ecart/models/period.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
    this.type,
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

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFav(
    String token,
    String userId,
  ) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    if (isFavorite) {
      final url = Uri.parse(
          'https://hamdi1234.herokuapp.com/addToWishlist?product=$id');
      try {
        final response = await http.post(
          url,
          headers: {
            'usertype': 'vendor',
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': token,
          },
        );
        if (response.statusCode != 200 && response.statusCode != 201) {
          _setFavValue(oldStatus);
        } 
      } catch (error) {
        print(error);
        _setFavValue(oldStatus);
      }
    } else {
        final url = Uri.parse(
          'https://hamdi1234.herokuapp.com/deletFromWishlist?product=$id');
          print(url);
      try {
        final response = await http.delete(
          url,
          headers: {
            'usertype': 'vendor',
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': token,
          },
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          print('deleted');
          _setFavValue(oldStatus);
        }
      } catch (error) {
        print('not deleted');
        print(error);
        _setFavValue(oldStatus);
      }
    }
  }
}
