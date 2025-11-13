import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:myshetribe_admin/providers/admin_auth_provider.dart';
import 'package:myshetribe_admin/providers/user_management_provider.dart';
import 'package:myshetribe_admin/providers/content_management_provider.dart';
import 'package:myshetribe_admin/screens/users/user_verification_screen.dart';
import 'package:myshetribe_admin/screens/users/all_users_screen.dart';
import 'package:myshetribe_admin/screens/content/events_management_screen.dart';
import 'package:myshetribe_admin/screens/content/tribes_management_screen.dart';
import 'package:myshetribe_admin/screens/content/partnerships_management_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const DashboardHome(),
    const UserVerificationScreen(),
    const AllUsersScreen(),
    const EventsManagementScreen(),
    const TribesManagementScreen(),
    const PartnershipsManagementScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final userProvider = Provider.of<UserManagementProvider>(context, listen: false);
    final contentProvider = Provider.of<ContentManagementProvider>(context, listen: false);

    await Future.wait([
      userProvider.loadPendingVerifications(),
      userProvider.loadAllUsers(),
      contentProvider.loadEvents(),
      contentProvider.loadTribes(),
      contentProvider.loadPartnershipOffers(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MySheTribe Admin Panel',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Consumer<AdminAuthProvider>(
            builder: (context, authProvider, child) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Icon(Icons.admin_panel_settings, color: Colors.white),
                    const SizedBox(width: 8),
                    Text(
                      authProvider.currentUser?.email ?? 'Admin',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      icon: const Icon(Icons.logout),
                      onPressed: () async {
                        await authProvider.signOut();
                      },
                      tooltip: 'Sign Out',
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Row(
        children: [
          // Sidebar Navigation
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            backgroundColor: const Color(0xFF3A3A3A),
            selectedIconTheme: const IconThemeData(color: Color(0xFFFFB6C8)),
            selectedLabelTextStyle: GoogleFonts.poppins(
              color: const Color(0xFFFFB6C8),
              fontWeight: FontWeight.w600,
            ),
            unselectedIconTheme: const IconThemeData(color: Colors.white70),
            unselectedLabelTextStyle: GoogleFonts.poppins(
              color: Colors.white70,
              fontWeight: FontWeight.w400,
            ),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.dashboard),
                label: Text('Dashboard'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.pending_actions),
                label: Text('Verifications'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.people),
                label: Text('All Users'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.event),
                label: Text('Events'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.groups),
                label: Text('Tribes'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.card_giftcard),
                label: Text('Partnerships'),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),

          // Main Content
          Expanded(
            child: _screens[_selectedIndex],
          ),
        ],
      ),
    );
  }
}

class DashboardHome extends StatelessWidget {
  const DashboardHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dashboard Overview',
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF3A3A3A),
            ),
          ),
          const SizedBox(height: 24),

          // Statistics Cards
          Consumer2<UserManagementProvider, ContentManagementProvider>(
            builder: (context, userProvider, contentProvider, child) {
              return Expanded(
                child: GridView.count(
                  crossAxisCount: 4,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.5,
                  children: [
                    _buildStatCard(
                      title: 'Total Users',
                      value: userProvider.totalUsers.toString(),
                      icon: Icons.people,
                      color: Colors.blue,
                    ),
                    _buildStatCard(
                      title: 'Pending Verifications',
                      value: userProvider.pendingVerifications.toString(),
                      icon: Icons.pending_actions,
                      color: Colors.orange,
                    ),
                    _buildStatCard(
                      title: 'Approved Users',
                      value: userProvider.approvedUsers.toString(),
                      icon: Icons.verified_user,
                      color: Colors.green,
                    ),
                    _buildStatCard(
                      title: 'Rejected Users',
                      value: userProvider.rejectedUsers.toString(),
                      icon: Icons.cancel,
                      color: Colors.red,
                    ),
                    _buildStatCard(
                      title: 'Total Events',
                      value: contentProvider.totalEvents.toString(),
                      icon: Icons.event,
                      color: Colors.purple,
                    ),
                    _buildStatCard(
                      title: 'Active Events',
                      value: contentProvider.activeEvents.toString(),
                      icon: Icons.event_available,
                      color: Colors.teal,
                    ),
                    _buildStatCard(
                      title: 'Total Tribes',
                      value: contentProvider.totalTribes.toString(),
                      icon: Icons.groups,
                      color: Colors.indigo,
                    ),
                    _buildStatCard(
                      title: 'Partnership Offers',
                      value: contentProvider.totalPartnershipOffers.toString(),
                      icon: Icons.card_giftcard,
                      color: Colors.pink,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(height: 12),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF3A3A3A),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
