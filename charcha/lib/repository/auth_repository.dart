import 'package:charcha/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final AuthService authService;

  AuthRepository(this.authService);

  Future<void> login(String email, String password) async {
    final response = await authService.login(email, password);

    print("Inside Auth Repository");
    print(response);

    final access_token = response["data"]["accessToken"];
    final refresh_token = response["data"]["refreshToken"];

    final prefs = await SharedPreferences.getInstance();
    prefs.setString("access_token", access_token);
    prefs.setString("refresh_token", refresh_token);
  }
}
