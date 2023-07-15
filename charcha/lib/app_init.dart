import 'package:charcha/cubits/auth_cubit.dart';
import 'package:charcha/repository/auth_repository.dart';
import 'package:charcha/screen/click_email.dart';
import 'package:charcha/screen/home_page.dart';
import 'package:charcha/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppInit extends StatefulWidget {
  const AppInit({super.key});

  @override
  State<AppInit> createState() => _AppInitState();
}

class _AppInitState extends State<AppInit> {
  // final AuthRepository authRepository = AuthRepository(AuthService());

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc()..checkAuthStatus(),
          )
        ],
        child: BlocBuilder<AuthBloc, AuthStatus>(
          builder: (context, state) {
            if (state == AuthStatus.authenticated) {
              return HomePage();
            } else if (state == AuthStatus.unauthenticated) {
              return ClickEmailScreen();
            } else {
              return Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
          },
        ));
  }
}
