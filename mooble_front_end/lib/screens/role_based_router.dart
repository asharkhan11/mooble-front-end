import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../screens/admin/admin_dashboard.dart';
import '../screens/superUser/superuser_dashboard.dart';
import '../screens/teacher/teacher_dashboard.dart';
import '../screens/student/student_dashboard.dart';

import 'login_page.dart';

class RoleBasedRouter extends StatefulWidget {
  const RoleBasedRouter({super.key});

  @override
  State<RoleBasedRouter> createState() => _RoleBasedRouterState();
}

class _RoleBasedRouterState extends State<RoleBasedRouter> {
  final _storage = const FlutterSecureStorage();
  Widget _page = const Scaffold(body: Center(child: CircularProgressIndicator()));

  @override
  void initState() {
    super.initState();
    _checkLoginAndNavigate();
  }

  Future<void> _checkLoginAndNavigate() async {
    final token = await _storage.read(key: 'accessToken');
    if (token == null || JwtDecoder.isExpired(token)) {
      // Not logged in or token expired, navigate to login
      if (!mounted) return;
      setState(() => _page = const LoginPage());
      return;
    }

    final decoded = JwtDecoder.decode(token);
    final rolesDynamic = decoded['roles'] ?? [];
    final roles = rolesDynamic.map((r) => r.toString()).toList();

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
      // fallback
      page = const LoginPage();
    }

    if (!mounted) return;
    setState(() => _page = page);
  }

  @override
  Widget build(BuildContext context) {
    return _page;
  }
}