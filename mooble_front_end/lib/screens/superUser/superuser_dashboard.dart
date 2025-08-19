import 'package:flutter/material.dart';
import 'package:mooble_front_end/services/logout_button.dart';
import '../dashboard_card.dart';

class SuperUserDashboardPage extends StatefulWidget {
  const SuperUserDashboardPage({super.key});

  @override
  State<SuperUserDashboardPage> createState() => _SuperUserDashboardPageState();
}

class _SuperUserDashboardPageState extends State<SuperUserDashboardPage> {
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
            icon: Icons.admin_panel_settings,
            title: "Manage Roles",
            onTap: () => Navigator.pushNamed(context, '/superuser/roles'),
          ),
          DashboardCard(
            icon: Icons.people,
            title: "Manage Users",
            onTap: () => Navigator.pushNamed(context, '/superuser/users'),
          ),
          DashboardCard(
            icon: Icons.school,
            title: "Manage Tuitions",
            onTap: () => Navigator.pushNamed(context, '/superuser/tuitions'),
          ),
          DashboardCard(
            icon: Icons.logout,
            title: "Logout",
            onTap: () => logout(context),
          ),
        ],
      ),
      // Tab 1 - Dummy Page
      const Center(child: Text("Analytics Page (Coming Soon)")),
      // Tab 2 - Dummy Page
      const Center(child: Text("Profile Page (Coming Soon)")),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Super User Dashboard")),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.analytics), label: "Analytics"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
