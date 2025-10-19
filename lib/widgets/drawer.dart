import 'package:flutter/material.dart';
import 'package:task/route.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width > 600;
    
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: isTablet ? 200 : 180,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blue,
                  Colors.blue.shade600,
                ],
              ),
            ),
            child: DrawerHeader(
              padding: EdgeInsets.all(isTablet ? 20 : 16),
              margin: EdgeInsets.zero,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: isTablet ? 35 : 30,
                        backgroundColor: Colors.white,
                        child: Text(
                          'WN',
                          style: TextStyle(
                            fontSize: isTablet ? 22 : 20,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: isTablet ? 16 : 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Wada N',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isTablet ? 20 : 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: isTablet ? 4 : 2),
                            Text(
                              'wada@focus.com',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: isTablet ? 16 : 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          _buildDrawerItem(
            icon: Icons.dashboard_outlined,
            title: 'Dashboard',
            onTap: () {
              Navigator.pop(context);
            },
          ),
          
          _buildDrawerItem(
            icon: Icons.task_alt_outlined,
            title: 'My Tasks',
            onTap: () {
              Navigator.pop(context);
            },
          ),
          
          _buildDrawerItem(
            icon: Icons.analytics_outlined,
            title: 'Analytics',
            onTap: () {
              Navigator.pop(context);
            },
          ),
          
          const Divider(),
          
          _buildDrawerItem(
            icon: Icons.settings_outlined,
            title: 'Settings',
            onTap: () {
              Navigator.pop(context);
            },
          ),
          
          _buildDrawerItem(
            icon: Icons.help_outline,
            title: 'Help & Support',
            onTap: () {
              Navigator.pop(context);
            },
          ),
          
          _buildDrawerItem(
            icon: Icons.info_outline,
            title: 'About',
            onTap: () {
              Navigator.pop(context);
            },
          ),
          
          const Divider(),
          
          _buildDrawerItem(
            icon: Icons.logout,
            title: 'Logout',
            textColor: Colors.red,
            iconColor: Colors.red,
            onTap: () {
              _showLogoutDialog(context);
            },
          ),
          
          SizedBox(height: isTablet ? 20 : 16),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? textColor,
    Color? iconColor,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor ?? Colors.grey.shade700,
        size: 24,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? Colors.black87,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Logout',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Are you sure you want to logout?',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.login,
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}