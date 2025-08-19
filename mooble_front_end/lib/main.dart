import 'package:flutter/material.dart';
import 'screens/role_based_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LMS App',
      themeMode: ThemeMode.light, // Light/Dark mode support
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const RoleBasedRouter(),
      debugShowCheckedModeBanner: false,

      // Named routes
      routes: {

        // // Role management
        // RoleListPage.routeName: (context) => const RoleListPage(),
        // RoleCreatePage.routeName: (context) => const RoleCreatePage(),

        // // User management
        // UserListPage.routeName: (context) => const UserListPage(),
        // UserCreatePage.routeName: (context) => const UserCreatePage(),

        // // Tuition management
        // TuitionListPage.routeName: (context) => const TuitionListPage(),
        // TuitionCreatePage.routeName: (context) => const TuitionCreatePage(),

        // TeacherListPage.routeName: (context) => const TeacherListPage(),
        // StudentListPage.routeName: (context) => const StudentListPage(),
      },
    );
  }
}
