import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AddressesProvider with ChangeNotifier {
  String _token;
  String _userId;
  final mainUrl = 'https://sallaty-store.herokuapp.com';

  void setToken(String token) {
    _token = token;
  }

  void setUserId(String id) {
    _userId = id;
  }

  Future<List<String>> get addresses async {
    final url = Uri.parse('$mainUrl/getAddresses');
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
      final List<String> responseAddresses = [];
      responseData.forEach((element) {
        responseAddresses.add(element.toString());
      });
      return responseAddresses;
    } else {
      throw response.body;
    }
  }

  Future<void> setAddress(String address) async {
    final url = Uri.parse(
        '$mainUrl/addAddress?address=$address');
    final response = await http.post(
      url,
      headers: {
        'usertype': 'vendor',
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': _token,
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      notifyListeners();
    } else {
      throw response.body;
    }
  }
}
