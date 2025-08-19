import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../config/api_config.dart';

class AuthService {
  final String baseUrl = ApiConfig.baseUrl; // Your backend IP
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> _saveTokens(String accessToken, String refreshToken) async {
    await _storage.write(key: 'accessToken', value: accessToken);
    await _storage.write(key: 'refreshToken', value: refreshToken);
  }

  Future<String?> getAccessToken() async =>
      await _storage.read(key: 'accessToken');

  Future<String?> getRefreshToken() async =>
      await _storage.read(key: 'refreshToken');

  Future<void> logout() async => await _storage.deleteAll();

  Future<Map<String, String>> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');

    final response = await http.post(
      url,
      body: {'username': username, 'password': password},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await _saveTokens(data['accessToken'], data['refreshToken']);
      return {
        'accessToken': data['accessToken'],
        'refreshToken': data['refreshToken'],
      };
    } else {
      throw Exception('Invalid username or password');
    }
  }

  Future<String> refreshAccessToken() async {
    final refreshToken = await getRefreshToken();
    if (refreshToken == null) throw Exception("No refresh token found");

    final url = Uri.parse('$baseUrl/auth/refresh-token');
    final response = await http.post(url, body: {'refreshToken': refreshToken});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final newAccessToken = data['accessToken'];

      await _storage.write(key: 'accessToken', value: newAccessToken);

      return newAccessToken;
    } else {
      throw Exception('Failed to refresh token');
    }
  }

  /// Send request with auto token refresh
  Future<http.Response> sendAuthorizedRequest(
    String endpoint, {
    String method = 'GET',
    Map<String, String>? body,
  }) async {
    String? token = await getAccessToken();
    if (token == null) throw Exception("No access token found");

    Uri url = Uri.parse('$baseUrl$endpoint');

    http.Response response;

    if (method == 'POST') {
      response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: body,
      );
    } else {
      response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );
    }

    // If token expired
    if (response.statusCode == 401) {
      try {
        final newToken = await refreshAccessToken();

        // Retry the request with new token
        if (method == 'POST') {
          response = await http.post(
            url,
            headers: {'Authorization': 'Bearer $newToken'},
            body: body,
          );
        } else {
          response = await http.get(
            url,
            headers: {'Authorization': 'Bearer $newToken'},
          );
        }
      } catch (e) {
        await logout();
        throw Exception("Session expired. Please log in again.");
      }
    }

    return response;
  }
}
