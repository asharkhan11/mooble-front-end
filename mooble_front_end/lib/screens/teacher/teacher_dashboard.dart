import 'package:flutter/material.dart';
import 'package:mooble_front_end/services/logout_button.dart';
import '../dashboard_card.dart';

class TeacherDashboardPage extends StatefulWidget {
  const TeacherDashboardPage({super.key});

  @override
  State<TeacherDashboardPage> createState() => _TeacherDashboardPageState();
}

class _TeacherDashboardPageState extends State<TeacherDashboardPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      // Tab 0 - Your existing dashboard
      GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          DashboardCard(
            icon: Icons.class_,
            title: "My Classes",
            onTap: () {},
          ),
          DashboardCard(
            icon: Icons.upload_file,
            title: "Upload Resources",
            onTap: () {},
          ),
          DashboardCard(
            icon: Icons.logout,
            title: "Logout",
            onTap: () => logout(context),
          ),
        ],
      ),
      // Tab 1 - Dummy Page
      const Center(child: Text("Grades Page (Coming Soon)")),
      // Tab 2 - Dummy Page
      const Center(child: Text("Messages Page (Coming Soon)")),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Teacher Dashboard")),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.grade), label: "Grades"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Messages"),
        ],
      ),
    );
  }
}
