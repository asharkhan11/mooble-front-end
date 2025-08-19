import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../screens/login_page.dart';
import 'auth_http_client.dart';

final FlutterSecureStorage _storage = const FlutterSecureStorage();
final AuthHttpClient _client = AuthHttpClient();

Future<void> logout(BuildContext context) async {
  try {
    // Call backend logout endpoint
    final response = await _client.post('/user/logout', sendAsJson: false);
    if (response.statusCode == 200) {
      // Optionally handle successful logout response
    }
  } catch (e) {
    // You can log the error or ignore if backend logout fails
  } finally {
    // Clear tokens and navigate to login
    await _storage.deleteAll();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }
}