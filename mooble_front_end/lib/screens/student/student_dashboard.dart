import 'package:flutter/material.dart';
import 'package:mooble_front_end/services/logout_button.dart';
import '../dashboard_card.dart';

class StudentDashboardPage extends StatefulWidget {
  const StudentDashboardPage({super.key});

  @override
  State<StudentDashboardPage> createState() => _StudentDashboardPageState();
}

class _StudentDashboardPageState extends State<StudentDashboardPage> {
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
            icon: Icons.menu_book,
            title: "My Courses",
            onTap: () {},
          ),
          DashboardCard(
            icon: Icons.download,
            title: "Download Resources",
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
      const Center(child: Text("Assignments Page (Coming Soon)")),
      // Tab 2 - Dummy Page
      const Center(child: Text("Chat Page (Coming Soon)")),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Student Dashboard")),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: "Assignments"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
        ],
      ),
    );
  }
}
