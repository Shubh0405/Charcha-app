import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketSingleton {
  static final SocketSingleton _instance = SocketSingleton._internal();
  static String baseUrl = dotenv.env['BASE_URL']!;

  factory SocketSingleton() {
    return _instance;
  }

  SocketSingleton._internal();

  late io.Socket socket;

  void setupSocketConnection() {
    socket = io.io('$baseUrl', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    socket.onConnect((_) {
      print('Connected to socket');
    });

    socket.onDisconnect((_) {
      print('Disconnected from socket');
    });
  }
}
