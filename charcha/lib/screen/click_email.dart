import 'package:charcha/cubits/auth_cubit.dart';
import 'package:charcha/screen/enter_email.dart';
import 'package:charcha/screen/home_page.dart';
import 'package:charcha/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

// class ClickEmailScreen extends StatelessWidget {
//   const ClickEmailScreen({super.key});

//   Future<void> _login(BuildContext buildContext) async {
//     try {
//       await BlocProvider.of<AuthBloc>(buildContext)
//           .login('shubhngupta04@gmail.com', 'testpassword');
//     } catch (e) {
//       final errorMessage = e.toString().replaceAll('Exception:', '');
//       snackbarKey.currentState?.showSnackBar(
//         SnackBar(
//           content: Text(errorMessage),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final _ScaffoldKey = GlobalKey();

//     return BlocConsumer<AuthBloc, AuthStatus>(
//       listener: (context, state) {
//         if (state == AuthStatus.authenticated) {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => HomePage()),
//           );
//         }
//       },
//       builder: (context, state) {
//         return Scaffold(
//           body: Center(
//             child: ElevatedButton(
//                 onPressed: () {
//                   _login(context);
//                 },
//                 child: Text('Log in!')),
//           ),
//         );
//       },
//     );
//   }
// }

class ClickEmailScreen extends StatelessWidget {
  const ClickEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double safeAreaHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: safeAreaHeight),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                  height: deviceHeight * 0.1,
                ),
                Container(
                  width: double.infinity,
                  height: deviceHeight * 0.3,
                  padding: const EdgeInsets.all(10),
                  child: SvgPicture.asset(
                    'assets/images/click_email_image.svg',
                    // fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Charcha',
                            textDirection: TextDirection.ltr,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                          Text(
                            '  with your friends',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                          )
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'anytime, anywhere',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Theme.of(context).colorScheme.onBackground),
                      )
                    ],
                  ),
                )
              ],
            ),
            Container(
              width: double.infinity,
              height: deviceHeight * 0.25,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 50),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EnterEmailScreen()));
                    },
                    child: Container(
                      width: double.infinity,
                      // height: deviceHeight * 0.1,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: Text(
                        'Click here to charcha',
                        style: TextStyle(color: Theme.of(context).shadowColor),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
