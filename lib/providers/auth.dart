import 'dart:convert';

import 'package:flutter/foundation.dart';
import '../models/http_exception.dart';
import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String id;
  String name;
  String email;
  // String imageUrl;
  String number;
  bool isSeller;
  // List<String> wishListIds = [];
  // List<String> ordersIds = [];
  String _token;

  Future<bool> isAuth() async {
    if (token == null) {
      return await tryAutoLogin();
    } else {
      return await validToken();
    }
  }

  String get token {
    return _token;
  }

  Future<void> signUp(
    String username,
    String usernumber,
    String useremail,
    String password,
  ) async {
    final url = Uri.parse("https://hamdi1234.herokuapp.com/users");

    var response = await http.post(
      url,
      headers: {
        'usertype': 'vendor',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({
        "name": username,
        "email": useremail,
        "number": usernumber,
        "password": password,
      }),
    );
    if (response.statusCode == 201) {
      var responseData = json.decode(response.body);
      id = responseData['_id'];
      name = responseData['name'];
      number = responseData['number'];
      _token = responseData['tokens'][0]['token'];
      isSeller = responseData['role'] == 'normal' ? false : true;
      saveToken();
      notifyListeners();
    } else {
      print('Request failed with status: ${response.statusCode}.');
      var responseData = json.decode(response.body);
      print(responseData);
      throw HttpException(responseData);
    }
    // final responseData = json.decode(response.body);
    // if (responseData['error'] != null)
    //   throw HttpException(responseData['error']['message']);
  }

  Future<void> signInWithNumber(
    String number,
    String password,
  ) async {
    final url =
        Uri.parse('https://hamdi1234.herokuapp.com/users/loginbynumber');
    final response = await http.post(url,
        headers: {
          'usertype': 'vendor',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          "number": number,
          "password": password,
        }));

    final responseData = json.decode(response.body);
    if (response.statusCode != 200) throw HttpException(responseData);

    print(responseData);

    id = responseData['_id'];
    name = responseData['name'];
    number = responseData['number'];
    _token = responseData['tokens'][0]['token'];
    isSeller = responseData['role'] == 'normal' ? false : true;
    saveToken();
    notifyListeners();
  }

  Future<void> signInWithUsername(
    String username,
    String password,
  ) async {
    final url = Uri.parse('');
    final response = await http.post(
      url,
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );
    final responseData = json.decode(response.body);
    if (responseData['error'] != null)
      throw HttpException(responseData['error']['message']);

    id = responseData['objectId'];
    name = responseData['username'];
    number = responseData['number'];
    _token = responseData['sessionToken'];
    isSeller = responseData['premium'];
    saveToken();
    notifyListeners();
  }

  void saveToken() async {
    // final pref = await SharedPreferences.getInstance();
    // pref.setString(
    //     'userData',
    //     json.encode({
    //       'token': token,
    //       'userId': id,
    //       'username': name,
    //       'number': number,
    //       'premium': isSeller.toString(),
    //     }));
  }

  Future<bool> tryAutoLogin() async {
    // final pref = await SharedPreferences.getInstance();
    // if (!pref.containsKey('userData')) return false;

    // final extractedData =
    //     json.decode(pref.getString('userData')) as Map<String, Object>;
    // _token = extractedData['token'];
    // id = extractedData['userId'];
    // name = extractedData['username'];
    // number = extractedData['number'];

    // if (extractedData['premium'] == 'true')
    //   isSeller = true;
    // else
    //   isSeller = false;
    // //Checks whether the user's session token is valid
    return await validToken();
  }

  Future<bool> validToken() async {
    final url = Uri.parse('');
    final response = await http.post(url, headers: {'token': token});
    final responseData = json.decode(response.body);
    if (responseData['error'] != null) {
      //Invalid session. Logout
      await logout();
      return false;
    } else {
      return true;
    }
  }

  Future<void> logout() async {
    _token = null;
    id = null;
    name = null;
    number = null;
    isSeller = null;
    // final pref = await SharedPreferences.getInstance();
    // pref.clear();
    notifyListeners();
    // http logout
  }
}
