import 'package:flutter/material.dart';
import 'package:mooble_front_end/components/list_view.dart';
import 'package:mooble_front_end/entity/models.dart';
import 'package:mooble_front_end/services/api_service.dart';
import 'package:mooble_front_end/services/logout_button.dart';
import '../dashboard_card.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
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
            icon: Icons.school,
            title: "Manage Tuitions",
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => GenericListPage<Tuition>(
                    title: 'Tuitions',
                    fetchData: ApiService().getAllTuitionAdmin,
                    itemBuilder: (context, tuition) => ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Text(tuition.name[0].toUpperCase()),
                      ),
                      title: Text(tuition.name),
                      subtitle: Text(tuition.tuitionId.toString()),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    ),
                  ),
                ),
              ),
            },
          ),
          DashboardCard(
            icon: Icons.person,
            title: "Manage Teachers",
            onTap: () => Navigator.pushNamed(context, '/admin/teacher/list'),
          ),
          DashboardCard(
            icon: Icons.people,
            title: "Manage Students",
            onTap: () => Navigator.pushNamed(context, '/admin/student/list'),
          ),
          DashboardCard(
            icon: Icons.logout,
            title: "Logout",
            onTap: () => logout(context),
          ),
        ],
      ),
      // Tab 1 - Dummy Page
      const Center(child: Text("Reports Page (Coming Soon)")),
      // Tab 2 - Dummy Page
      const Center(child: Text("Settings Page (Coming Soon)")),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin Dashboard")),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Reports",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
