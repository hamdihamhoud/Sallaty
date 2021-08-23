import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AddressesProvider with ChangeNotifier {
  String _token;
  String _userId;

  void setToken(String token) {
    _token = token;
  }

  void setUserId(String id) {
    _userId = id;
  }

  List<String> _addresses = [];

  Future<List<String>> get addresses async {
    final url = Uri.parse('https://hamdi1234.herokuapp.com/getAddresses');
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
        'https://hamdi1234.herokuapp.com/addAddress?address=$address');
    final response = await http.post(
      url,
      headers: {
        'usertype': 'vendor',
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': _token,
      },
      // body: json.encode({
      //   'address': address,
      // }),
    );
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      notifyListeners();
    } else {
      throw response.body;
    }
  }
}
