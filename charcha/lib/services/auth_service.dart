import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static String baseUrl = dotenv.env['BASE_URL']!;

  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    dynamic response;

    try {
      response = await http.post(Uri.parse('$baseUrl/auth/login'),
          body: {'email': email, 'password': password});
    } catch (e) {
      throw Exception('Some error occured! Failed to login');
    }

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } else if (response.statusCode == 400) {
      final jsonResponse = jsonDecode(response.body);
      throw Exception(jsonResponse["detail"]);
    } else {
      throw Exception('Some error occured! Failed to login.');
    }
  }

  static Future<Map<String, dynamic>> getNewAccessToken(
      String refreshToken) async {
    dynamic response;

    try {
      response = await http.post(Uri.parse('$baseUrl/auth/newAccessToken'),
          body: {'refreshToken': refreshToken});
    } catch (e) {
      throw Exception('Some error occured!');
    }

    final jsonDecoded = json.decode(response.body);

    if (response.statusCode == 200) {
      final jsonResponse = {
        "validRefresh": true,
        "accessToken": jsonDecoded["data"]
      };
      return jsonResponse;
    } else if (response.statusCode == 400) {
      final jsonResponse = {"validRefresh": false, "accessToken": null};
      return jsonResponse;
    } else {
      throw Exception('Some error occured!');
    }
  }

  static Future<Map<String, dynamic>> logout(String refreshToken) async {
    final response = {"message": "true"};

    return response;
  }

  static Future<Map<String, dynamic>> checkEmailExists(String email) async {
    dynamic response;

    try {
      response =
          await http.get(Uri.parse('$baseUrl/auth/checkEmail?email=$email'));
    } catch (e) {
      throw Exception('Some error occured!');
    }

    final jsonDecoded = json.decode(response.body);

    if (response.statusCode == 200) {
      return jsonDecoded;
    } else {
      throw Exception('Some error occured!');
    }
  }
}
