import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static String baseUrl = dotenv.env['BASE_URL']!;

  Future<Map<String, dynamic>> login(String email, String password) async {
    dynamic response;

    try {
      response = await http.post(Uri.parse('$baseUrl/auth/login'),
          body: {'email': email, 'password': password});
    } catch (e) {
      print(e);
      throw Exception('Some error occured! Failed to login');
    }

    print("Inside Services");
    if (response.statusCode == 200) {
      print("Login Done!!");
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else if (response.statusCode == 400) {
      final jsonResponse = jsonDecode(response.body);
      throw Exception(jsonResponse["detail"]);
    } else {
      print(response.statusCode);
      throw Exception('Some error occured! Failed to login.');
    }
  }
}
