import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiClass extends ChangeNotifier {
  //// Login
  ///

  String message = "";

  Future<String> login({
    required String username,
    required String password,
  }) async {
    print("login func called");
    final response =
        await http.post(Uri.parse("http://stacked.com.ng/api/login"),
            headers: {
              "Content-Type": "application/json",
            },
            body: jsonEncode({
              "username": username,
              "password": password,
            }));
    if (response.statusCode == 200) {
      print(response.body);
      message = response.body;
      notifyListeners();
      return response.body;
    } else {
      message = response.body;
      notifyListeners();
      print(response.statusCode);
      return "Error${response.statusCode}";
    }
  }

  ///// signUp

  Future<String> signUp({
    required String username,
    required String password,
    required String email,
    required String phone,
    required String address,
    required String image,
  }) async {
    final response =
        await http.post(Uri.parse("https://stacked.com.ng/api/register"),
            headers: {
              "Content-Type": "application/json",
              "accept": "application/json",
            },
            body: jsonEncode({
              "username": username,
              "password": password,
              "email": email,
              "phone": phone,
              "address": address,
              "image": image,
            }));
    if (response.statusCode == 200) {
      print(response.body);
      message = response.body;
      notifyListeners();
      return response.body;
    } else {
      message = response.body;
      notifyListeners();
      print(response.statusCode);
      return "Error${response.body}";
    }
  }

  ///// getProfile

  getProfile() async {
    final response =
        await http.get(Uri.parse("http://stacked.com.ng/api/profile"));
    if (response.statusCode == 200) {
      print(response.body);
      message = response.body;
      notifyListeners();
      return response.body;
    } else {
      message = response.body;
      notifyListeners();
      print(response.statusCode);
      return "Error${response.statusCode}";
    }
  }
}
