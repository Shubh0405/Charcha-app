import 'package:charcha/cubits/user_chat_cubit.dart';
import 'package:charcha/cubits/user_cubit.dart';
import 'package:charcha/screen/click_email.dart';
import 'package:charcha/screen/home_page.dart';
import 'package:charcha/sockets/socket.dart';
import 'package:charcha/theme/theme.dart';
import 'package:charcha/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'cubits/auth_cubit.dart';
import 'cubits/chat_messages_cubit.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  SocketSingleton().setupSocketConnection();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc()..checkAuthStatus(),
          ),
          BlocProvider<UserBloc>(create: (context) => UserBloc()),
          BlocProvider<UserChatCubit>(create: (context) => UserChatCubit()),
          BlocProvider<ChatMessagesCubit>(
              create: (context) => ChatMessagesCubit())
        ],
        child: BlocBuilder<AuthBloc, AuthStatus>(
          builder: (context, state) {
            Widget initWidget;

            if (state == AuthStatus.authenticated) {
              initWidget = const HomePage();
            } else {
              initWidget = const ClickEmailScreen();
            }

            return MaterialApp(
                title: 'Flutter Demo',
                themeMode: ThemeMode.light,
                theme: MyThemes.lightTheme,
                darkTheme: MyThemes.darkTheme,
                scaffoldMessengerKey: snackbarKey,
                navigatorKey: navigatorKey,
                home: initWidget);
          },
        ));
  }
}
