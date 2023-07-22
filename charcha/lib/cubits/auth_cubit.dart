import 'package:charcha/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthStatus {
  authenticated,
  unauthenticated,
  userLogin,
  userRegister,
  unknown
}

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

  void passwordScreenBackClick() async {
    emit(AuthStatus.unknown);
  }

  Future<void> login(String username, String password) async {
    try {
      final loginResponse = await AuthRepository.login(username, password);
      if (loginResponse["Profile"]!) {
        emit(AuthStatus.authenticated);
      } else {
        // Create Profile state.
      }
    } catch (e) {
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

  Future<void> checkIfEmailExists(String email) async {
    try {
      final emailExists = await AuthRepository.checkIfEmailExists(email);
      print(emailExists);
      if (emailExists) {
        emit(AuthStatus.userLogin);
      } else {
        emit(AuthStatus.userRegister);
      }
    } catch (e) {
      emit(AuthStatus.unauthenticated);
      throw Exception(e.toString());
    }
  }
}
