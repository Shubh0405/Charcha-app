import 'package:charcha/cubits/auth_cubit.dart';
import 'package:charcha/screen/home_page.dart';
import 'package:charcha/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClickEmailScreen extends StatelessWidget {
  const ClickEmailScreen({super.key});

  Future<void> _login(BuildContext buildContext) async {
    try {
      await BlocProvider.of<AuthBloc>(buildContext)
          .login('shubhngupta04@gmail.com', 'testpassword');
    } catch (e) {
      final errorMessage = e.toString().replaceAll('Exception:', '');
      snackbarKey.currentState?.showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final _ScaffoldKey = GlobalKey();

    return BlocConsumer<AuthBloc, AuthStatus>(
      listener: (context, state) {
        if (state == AuthStatus.authenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: ElevatedButton(
                onPressed: () {
                  _login(context);
                },
                child: Text('Log in!')),
          ),
        );
      },
    );
  }
}
