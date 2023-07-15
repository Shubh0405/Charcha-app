import 'package:charcha/cubits/auth_cubit.dart';
import 'package:charcha/repository/auth_repository.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// class AuthMiddleware {
//   static const String _accessTokenKey = 'accessToken';
//   static const String _refreshTokenKey = 'refreshToken';

//   static Future<http.Response> handleRequest(http.Request request) async {
//     // Get the access token from SharedPreferences
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     String accessToken = prefs.getString(_accessTokenKey);

//     // Add the access token to the request headers if it exists
//     if (accessToken != null) {
//       request.headers['Authorization'] = 'Bearer $accessToken';
//     }

//     // Send the request
//     final http.Response response = await http.Client().send(request);

//     // If the access token is expired, refresh it
//     if (response.statusCode == 401) {
//       final String refreshToken = prefs.getString(_refreshTokenKey);
//       if (refreshToken != null) {
//         // Call the API to refresh the access token
//         final http.Response refreshResponse = await http.post(
//           'https://your-refresh-token-endpoint',
//           body: {'refresh_token': refreshToken},
//         );

//         if (refreshResponse.statusCode == 200) {
//           // Update the access token in SharedPreferences
//           final String newAccessToken = refreshResponse.body;
//           prefs.setString(_accessTokenKey, newAccessToken);

//           // Retry the original request with the new access token
//           request.headers['Authorization'] = 'Bearer $newAccessToken';
//           return http.Client().send(request);
//         }
//       }

//       // If the refresh token is expired, log out the user
//       logoutUser();
//     }

//     return response;
//   }

//   static void logoutUser() {
//     // Clear access token and refresh token from SharedPreferences
//     SharedPreferences.getInstance().then((prefs) {
//       prefs.remove(_accessTokenKey);
//       prefs.remove(_refreshTokenKey);
//     });

//     // TODO: Implement additional logout logic as needed (e.g., navigate to login screen)
//   }
// }

class AuthMiddleware {
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  // final AuthRepository authRepository;
  // final AuthBloc authBloc;

  AuthMiddleware();

  static Future<http.StreamedResponse> handleRequest(
      http.Request request) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString(_accessTokenKey);

    if (accessToken != null) {
      request.headers['Authorization'] = 'Bearer $accessToken';
    }

    final http.StreamedResponse response = await http.Client().send(request);

    if (response.statusCode == 401) {
      final refreshAccessToken = await AuthRepository.newAccessToken();

      if (refreshAccessToken) {
        accessToken = prefs.getString(_accessTokenKey);
        if (accessToken != null) {
          request.headers['Authorization'] = 'Bearer $accessToken';
        }

        final http.Request retryRequest = http.Request(
          request.method,
          request.url,
        );
        retryRequest.headers.addAll(request.headers);
        retryRequest.body = request.body;
        return http.Client().send(retryRequest);
      }
      await logout();
    }

    return response;
  }

  static Future<void> logout() async {
    await AuthBloc().logout();
  }
}
