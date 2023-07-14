import 'package:charcha/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthStatus { authenticated, unauthenticated, unknown }

class AuthBloc extends Cubit<AuthStatus> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthStatus.unknown);

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
    print("Inside AuthBloc login function");
    try {
      await authRepository.login(username, password);
      print("Login Successful!");
      emit(AuthStatus.authenticated);
    } catch (e) {
      print(e);
      emit(AuthStatus.unauthenticated);
      throw Exception(e.toString());
    }
  }
}
