import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiClass extends ChangeNotifier {
  //// Login
  ///

  Map message = {};
  Map token = {};
  bool getProfileLoading = false;

  Future<String> login({
    required String username,
    required String password,
    required Function() onSuccess,
    required Function() onError,
  }) async {
    final uri = Uri.parse('https://stacked.com.ng/api/login');

    final response = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
      },
      body: json.encode({
        "username": username,
        "password": password,
      }),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      // getProfile();
      message = jsonDecode(response.body);
      token = jsonDecode(response.body);
      onSuccess();
      notifyListeners();
      return response.body;
    } else {
      message = jsonDecode(response.body);
      onError();
      notifyListeners();

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
    required Function() onSuccess,
    required Function() onError,
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
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      // getProfile(token: response.body['token']);
      message = jsonDecode(response.body);
      token = jsonDecode(response.body);
      onSuccess();
      notifyListeners();
      return response.body;
    } else {
      message = jsonDecode(response.body);
      onError();
      notifyListeners();
      print(response.statusCode);
      return "Error${response.body}";
    }
  }

  ///// getProfile

  getProfile({required String token}) async {
    print("get profile called");

    getProfileLoading = true;
    notifyListeners();
    final response = await http
        .get(Uri.parse("https://stacked.com.ng/api/profile"), headers: {
      // "Content-Type": "application/json",
      "accept": "application/json",
      "Authorization": 'Bearer $token',
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      message = jsonDecode(response.body);
      getProfileLoading = false;
      notifyListeners();
      return jsonDecode(response.body);
    } else {
      message = jsonDecode(response.body);
      getProfileLoading = false;
      notifyListeners();
      print(" get p error ${response.statusCode}");
      return "Error${response.statusCode}";
    }
  }
}
