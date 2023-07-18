import 'dart:ffi';

import 'package:charcha/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  // final AuthService authService;

  AuthRepository();

  static Future<void> login(String email, String password) async {
    final response = await AuthService.login(email, password);

    final access_token = response["data"]["accessToken"];
    final refresh_token = response["data"]["refreshToken"];

    final prefs = await SharedPreferences.getInstance();
    prefs.setString("access_token", access_token);
    prefs.setString("refresh_token", refresh_token);
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString("refresh_token");

    await AuthService.logout(refreshToken!);

    prefs.remove('access_token');
    prefs.remove('refresh_token');
  }

  static Future<bool> newAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString("refresh_token");

    final response = await AuthService.getNewAccessToken(refreshToken!);

    if (response["validRefresh"]) {
      final accessToken =
          prefs.setString('access_token', response["accessToken"]);
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> checkIfEmailExists(String email) async {
    final response = await AuthService.checkEmailExists(email);

    print(response);

    if (response["data"]["emailInUse"]) {
      return true;
    } else {
      return false;
    }
  }
}
