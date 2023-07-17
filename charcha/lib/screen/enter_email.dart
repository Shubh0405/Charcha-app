import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/globals.dart';

class EnterEmailScreen extends StatefulWidget {
  const EnterEmailScreen({super.key});

  @override
  State<EnterEmailScreen> createState() => _EnterEmailScreenState();
}

class _EnterEmailScreenState extends State<EnterEmailScreen> {
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double safeAreaHeight = MediaQuery.of(context).padding.top;
    final TextEditingController _emailController = TextEditingController();

    @override
    void dispose() {
      _emailController.dispose();
      super.dispose();
    }

    String? validateEmail(String? value) {
      if (value == null || value.isEmpty) {
        return 'Please enter an email';
      }
      if (!value.contains('@')) {
        return 'Please enter a valid email';
      }
      return null;
    }

    void _submitEmail(BuildContext context) {
      final String enteredEmail = _emailController.text;

      if (enteredEmail == null || enteredEmail.isEmpty) {
        snackbarKey.currentState?.showSnackBar(
          const SnackBar(
            content: Text("Email should not be empty"),
          ),
        );
        return;
      }

      if (!enteredEmail.contains('@')) {
        snackbarKey.currentState?.showSnackBar(
          const SnackBar(
            content: Text("Email should contain @"),
          ),
        );
        return;
      }

      // function call bloc

      print(enteredEmail);
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: safeAreaHeight),
          child: Column(
            children: [
              SizedBox(
                height: deviceHeight * 0.1,
              ),
              SizedBox(
                height: deviceHeight * 0.2,
                width: double.infinity,
                // padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                child: SvgPicture.asset('assets/images/enter_email_icon.svg'),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 40),
                child: Text(
                  'Enter your email address:',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 20,
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
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.white), // Set the text color
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                  // validator: _validateEmail,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  onPressed: () {
                    _submitEmail(context);
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  child: Text(
                    'Continue',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
