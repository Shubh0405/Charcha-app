import 'package:flutter/material.dart';

class PasswordScreen extends StatefulWidget {
  final String email;
  final bool isLogin;

  const PasswordScreen({super.key, required this.email, required this.isLogin});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _obscureText = true;
  bool _confirmObscureText = true;
  String passwordFieldError = "";
  String confirmPasswordFieldError = "";

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _confirmObscureText = !_confirmObscureText;
    });
  }

  void _submitPassword(BuildContext context) {
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (!widget.isLogin) {
      if (passwordFieldError != "" || confirmPasswordFieldError != "") {
        setState(() {
          confirmPasswordFieldError = "";
          passwordFieldError = "";
        });
      }

      if (password == null || password.isEmpty) {
        setState(() {
          passwordFieldError = "Please enter a password!";
        });
        return;
      }

      if (password.length < 8) {
        setState(() {
          passwordFieldError = "Password should be atleast 8 character long";
        });
        return;
      }

      if (!password.contains(RegExp(r'[A-Z]'))) {
        setState(() {
          passwordFieldError =
              "Password should contain at least 1 uppercase letter";
        });
        return;
      }

      if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        setState(() {
          passwordFieldError =
              "Password should contain at least 1 special character";
        });
        return;
      }

      if (passwordFieldError != "") {
        setState(() {
          passwordFieldError = "";
        });
      }

      if ((password != confirmPassword)) {
        setState(() {
          confirmPasswordFieldError = "Passwords are not matching";
        });
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double safeAreaHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: safeAreaHeight),
            child: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: deviceHeight * 0.1,
                  ),
                  Text(
                    widget.isLogin ? 'Welcome Back' : 'Welcome',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'To  Charcha',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 40),
                    child: Text(
                      widget.isLogin
                          ? 'Enter your password:'
                          : 'Create your password',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  (passwordFieldError != "")
                      ? Column(
                          children: [
                            Container(
                              width: double.infinity,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 40),
                              child: Text(
                                passwordFieldError,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: Colors.red),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        )
                      : const SizedBox(
                          height: 0,
                        ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .secondary, // Set the background color
                      borderRadius:
                          BorderRadius.circular(8), // Set the border radius
                    ),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: _obscureText,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.white), // Set the text color
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(16),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.white,
                          ),
                          onPressed: _togglePasswordVisibility,
                          splashColor: Colors.transparent,
                        ),
                      ),
                      // validator: _validateEmail,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  widget.isLogin
                      ? const SizedBox(
                          height: 0,
                        )
                      : Column(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.only(left: 40),
                              child: Text(
                                'Confirm your password:',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            (confirmPasswordFieldError != "")
                                ? Column(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        alignment: Alignment.centerLeft,
                                        padding:
                                            const EdgeInsets.only(left: 40),
                                        child: Text(
                                          confirmPasswordFieldError,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(color: Colors.red),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  )
                                : const SizedBox(
                                    height: 0,
                                  ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary, // Set the background color
                                borderRadius: BorderRadius.circular(
                                    8), // Set the border radius
                              ),
                              child: TextFormField(
                                controller: _confirmPasswordController,
                                obscureText: _confirmObscureText,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        color:
                                            Colors.white), // Set the text color
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.all(16),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _confirmObscureText
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.white,
                                    ),
                                    onPressed: _toggleConfirmPasswordVisibility,
                                    splashColor: Colors.transparent,
                                  ),
                                ),
                                // validator: _validateEmail,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                  ElevatedButton(
                      onPressed: () {
                        _submitPassword(context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white),
                      child: Text(
                        widget.isLogin ? 'Login' : 'Register',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary),
                      )),
                ],
              ),
            ),
          ),
        ));
  }
}
