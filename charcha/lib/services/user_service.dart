import 'dart:convert';

import 'package:charcha/middleware/auth_middleware.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserService {
  // final AuthMiddleware authMiddleware;
  static String baseUrl = dotenv.env['BASE_URL']!;

  UserService();

  static Future<dynamic> searchUser(String username) async {
    final http.Request request = http.Request(
      'GET',
      Uri.parse('$baseUrl/users/profile?username=$username'),
    );

    final http.StreamedResponse response =
        await AuthMiddleware.handleRequest(request);

    final decodedResponse = await http.Response.fromStream(response);

    return json.decode(decodedResponse.body);
  }

  static Future<Map<String, dynamic>> getUserChats() async {
    final http.Request request = http.Request(
      'GET',
      Uri.parse('$baseUrl/chats/getUserChats'),
    );

    final http.StreamedResponse response =
        await AuthMiddleware.handleRequest(request);

    final decodedResponse = await http.Response.fromStream(response);

    return json.decode(decodedResponse.body);
  }

  static Future<Map<String, dynamic>> getChatMessages(String chatId) async {
    final http.Request request = http.Request(
      'GET',
      Uri.parse('$baseUrl/messages/chat/$chatId'),
    );

    final http.StreamedResponse response =
        await AuthMiddleware.handleRequest(request);

    final decodedResponse = await http.Response.fromStream(response);

    return json.decode(decodedResponse.body);
  }

  static Future<Map<String, dynamic>> sendMessage(
      String chatId, String content) async {
    final http.Request request = http.Request(
      'POST',
      Uri.parse('$baseUrl/messages/'),
    );

    final body = jsonEncode({'chat': chatId, 'message': content});

    request.body = body;
    request.headers['Content-Type'] = 'application/json';

    print(request.url);
    print(request.method);
    print(request.body);

    final http.StreamedResponse response =
        await AuthMiddleware.handleRequest(request);

    final decodedResponse = await http.Response.fromStream(response);

    return json.decode(decodedResponse.body);
  }
}
