import 'package:charcha/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _callSearchAPI() async {
    await UserService.searchUser("user");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
              child: Text(
            dotenv.env['BASE_URL']!,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
          )),
          ElevatedButton(
              onPressed: _callSearchAPI, child: Text('Call Search API'))
        ],
      ),
    );
  }
}
