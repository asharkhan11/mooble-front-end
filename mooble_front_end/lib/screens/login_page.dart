import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mooble_front_end/components/CustomTextFieldWidget.dart';
import '../services/auth_http_client.dart';
import '../screens/admin/admin_dashboard.dart';
import '../screens/superUser/superuser_dashboard.dart';
import '../screens/teacher/teacher_dashboard.dart';
import '../screens/student/student_dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _storage = const FlutterSecureStorage();
  final _client = AuthHttpClient();

  bool _isLoading = false;

  Future<void> _login() async {
    setState(() => _isLoading = true);

    try {
      final response = await _client.post(
        "/auth/login",
        queryParams: {
          'username': _usernameController.text.trim(),
          'password': _passwordController.text.trim(),
        },
      );

      if (response.statusCode == 200) {
        final data = response.body.isNotEmpty ? response.body : null;
        if (data != null) {
          final tokens = jsonDecode(data);
          final accessToken = tokens['accessToken'];
          final refreshToken = tokens['refreshToken'];

          await _storage.write(key: 'accessToken', value: accessToken);
          await _storage.write(key: 'refreshToken', value: refreshToken);

          // Decode JWT and navigate based on roles
          _navigateBasedOnRole(accessToken);
        }
      } else {
        _showError("Invalid username or password");
      }
    } catch (e) {
      _showError("Error: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _navigateBasedOnRole(String token) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    List<dynamic> rolesDynamic = decodedToken['roles'] ?? [];
    List<String> roles = rolesDynamic.map((r) => r.toString()).toList();

    Widget page;

    if (roles.contains('ROLE_ADMIN')) {
      page = const AdminDashboardPage();
    } else if (roles.contains('ROLE_SUPER_USER')) {
      page = const SuperUserDashboardPage();
    } else if (roles.contains('ROLE_TEACHER')) {
      page = const TeacherDashboardPage();
    } else if (roles.contains('ROLE_STUDENT')) {
      page = const StudentDashboardPage();
    } else {
      // fallback or show error
      _showError("No valid role found.");
      return;
    }

    if (!mounted) return;
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
     // appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
          SizedBox(height: 40),
            Image.asset(
              'assets/images/login_image.jpg',
              scale: 1.5,
              
            ),
            const SizedBox(height: 20),
            Customtextfieldwidget(
              textEiditingController: _usernameController,
              labelText: "UserName",
              prefixIcon: const Icon(Icons.person),
            ),
            SizedBox(height: 10),
            Customtextfieldwidget(
              textEiditingController: _passwordController,
              labelText: "Password",
              prefixIcon: const Icon(Icons.lock),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : Container(
                  height: 50,
                  width: 380,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(31, 194, 194, 194),
                  ),
                  child: ElevatedButton(onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 203, 211, 212),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("Login")),
                ),
          ],
        ),
      ),
    );
  }
}
