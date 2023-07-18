import 'package:flutter/material.dart';

class PasswordScreen extends StatelessWidget {
  final String email;
  final bool isLogin;

  const PasswordScreen({super.key, required this.email, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(isLogin ? 'Login screen' : 'Register Screen'),
      ),
    );
  }
}
