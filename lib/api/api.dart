import 'package:http/http.dart' as http;

class ApiClass {
  //// Login

  Future<String> login({
    required String username,
    required String password,
  }) async {
    final response =
        await http.post(Uri.parse("http://stacked.com.ng/api/login"), headers: {
      "Content-Type": "application/json",
    }, body: {
      "username": username,
      "password": password,
    });
    if (response.statusCode == 200) {
      return response.body;
    } else {
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
        await http.post(Uri.parse("http://stacked.com.ng/register"), headers: {
      "Content-Type": "application/json",
    }, body: {
      "username": username,
      "password": password,
      "email": email,
      "phone": phone,
      "address": address,
      "image": image,
    });
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "Error${response.statusCode}";
    }
  }

  ///// getProfile

  getProfile() async {
    final response =
        await http.get(Uri.parse("http://stacked.com.ng/api/profile"));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "Error${response.statusCode}";
    }
  }
}
