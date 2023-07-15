import 'dart:convert';

import 'package:charcha/middleware/auth_middleware.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserService {
  // final AuthMiddleware authMiddleware;
  static String baseUrl = dotenv.env['BASE_URL']!;

  UserService();

  static Future<void> searchUser(String username) async {
    final http.Request request = http.Request(
      'GET',
      Uri.parse('$baseUrl/users/profile?username=$username'),
    );

    final http.StreamedResponse response =
        await AuthMiddleware.handleRequest(request);

    final decodedResponse = await http.Response.fromStream(response);

    print(json.decode(decodedResponse.body));
  }
}
