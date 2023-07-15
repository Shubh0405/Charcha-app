import 'package:charcha/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthStatus { authenticated, unauthenticated, unknown }

class AuthBloc extends Cubit<AuthStatus> {
  // final AuthRepository authRepository;

  AuthBloc() : super(AuthStatus.unknown);

  void checkAuthStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');
    final refreshToken = prefs.getString('refresh_token');

    if (accessToken != null && refreshToken != null) {
      emit(AuthStatus.authenticated);
    } else {
      emit(AuthStatus.unauthenticated);
    }
  }

  Future<void> login(String username, String password) async {
    emit(AuthStatus.unknown);
    try {
      await AuthRepository.login(username, password);
      emit(AuthStatus.authenticated);
    } catch (e) {
      emit(AuthStatus.unauthenticated);
      throw Exception(e.toString());
    }
  }

  Future<void> logout() async {
    emit(AuthStatus.unknown);
    try {
      await AuthRepository.logout();
      emit(AuthStatus.unauthenticated);
    } catch (e) {
      emit(AuthStatus.authenticated);
      throw Exception(e.toString());
    }
  }
}