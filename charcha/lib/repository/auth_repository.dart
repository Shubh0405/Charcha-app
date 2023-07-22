import 'dart:ffi';

import 'package:charcha/res/shared_preferences_strings.dart';
import 'package:charcha/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  // final AuthService authService;

  AuthRepository();

  static Future<Map<String, bool>> login(String email, String password) async {
    final response = await AuthService.login(email, password);

    final access_token = response["data"]["accessToken"];
    final refresh_token = response["data"]["refreshToken"];
    final user_id = response["data"]["user"]["_id"];
    final userProfile = response["data"]["userProfile"];

    final prefs = await SharedPreferences.getInstance();
    prefs.setString(prefs_string_access_token, access_token);
    prefs.setString(prefs_string_refresh_token, refresh_token);
    prefs.setString(prefs_string_user_id, user_id);

    if (userProfile == Null) {
      return {"Profile": false};
    } else {
      prefs.setString(prefs_string_username, userProfile["username"]);
      prefs.setString(prefs_string_fullname, userProfile["fullName"]);
      prefs.setString(prefs_string_profile_pic, userProfile["profilePic"]);
      prefs.setString(
          prefs_string_profile_status, userProfile["profileStatus"]);
      prefs.setBool(prefs_string_dark_mode, userProfile["preferredDarkMode"]);

      return {"Profile": true};
    }
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString(prefs_string_refresh_token);

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
