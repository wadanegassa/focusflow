import 'package:flutter/material.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width > 600;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(isTablet ? 24 : 16),
            child: Column(
              children: [
                // Profile Header
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(isTablet ? 32 : 24),
                    child: Column(
                      children: [
                        // Profile Picture
                        Container(
                          width: isTablet ? 120 : 100,
                          height: isTablet ? 120 : 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.blue,
                                Colors.blue.shade600,
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.withOpacity(0.3),
                                spreadRadius: 0,
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              'WN',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        
                        SizedBox(height: isTablet ? 20 : 16),
                        
                        // User Info
                        Text(
                          'Wada N',
                          style: TextStyle(
                            fontSize: isTablet ? 28 : 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        
                        const SizedBox(height: 8),
                        
                        Text(
                          'wada@focus.com',
                          style: TextStyle(
                            fontSize: isTablet ? 16 : 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Edit Profile Button
                        OutlinedButton.icon(
                          onPressed: () {
                            _showEditProfileDialog(context);
                          },
                          icon: const Icon(Icons.edit),
                          label: const Text('Edit Profile'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Stats Cards
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        'Tasks',
                        '17',
                        Icons.task_alt,
                        Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        'Completed',
                        '12',
                        Icons.check_circle,
                        Colors.green,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        'Streak',
                        '5 days',
                        Icons.local_fire_department,
                        Colors.orange,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // Quick Actions
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(isTablet ? 24 : 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Quick Actions',
                          style: TextStyle(
                            fontSize: isTablet ? 20 : 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        _buildActionTile(
                          'Account Settings',
                          'Manage your account preferences',
                          Icons.account_circle,
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SettingsScreen(),
                              ),
                            );
                          },
                        ),
                        
                        _buildActionTile(
                          'Notifications',
                          'Configure notification settings',
                          Icons.notifications,
                          () {
                            _showNotificationSettings(context);
                          },
                        ),
                        
                        _buildActionTile(
                          'Privacy & Security',
                          'Manage your privacy settings',
                          Icons.security,
                          () {
                            _showPrivacySettings(context);
                          },
                        ),
                        
                        _buildActionTile(
                          'Help & Support',
                          'Get help and contact support',
                          Icons.help,
                          () {
                            _showHelpDialog(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // App Info
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(isTablet ? 24 : 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'App Information',
                          style: TextStyle(
                            fontSize: isTablet ? 20 : 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        _buildInfoRow('Version', '1.0.0'),
                        _buildInfoRow('Build', '1'),
                        _buildInfoRow('Last Updated', 'Today'),
                        
                        const SizedBox(height: 16),
                        
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  _showAboutDialog(context);
                                },
                                icon: const Icon(Icons.info),
                                label: const Text('About'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  _showFeedbackDialog(context);
                                },
                                icon: const Icon(Icons.feedback),
                                label: const Text('Feedback'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionTile(String title, String subtitle, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Full Name',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Profile updated successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showNotificationSettings(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Notification Settings'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwitchListTile(
              title: Text('Push Notifications'),
              subtitle: Text('Receive push notifications'),
              value: true,
              onChanged: null,
            ),
            SwitchListTile(
              title: Text('Email Notifications'),
              subtitle: Text('Receive email notifications'),
              value: false,
              onChanged: null,
            ),
            SwitchListTile(
              title: Text('Task Reminders'),
              subtitle: Text('Get reminded about due tasks'),
              value: true,
              onChanged: null,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showPrivacySettings(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Privacy & Security'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.lock),
              title: Text('Change Password'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
            ListTile(
              leading: Icon(Icons.fingerprint),
              title: Text('Biometric Authentication'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
            ListTile(
              leading: Icon(Icons.data_usage),
              title: Text('Data & Privacy'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Help & Support'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.help_outline),
              title: Text('FAQ'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
            ListTile(
              leading: Icon(Icons.contact_support),
              title: Text('Contact Support'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
            ListTile(
              leading: Icon(Icons.bug_report),
              title: Text('Report a Bug'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Focus Flow',
      applicationVersion: '1.0.0',
      applicationIcon: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(
          Icons.check_box_outlined,
          color: Colors.white,
          size: 32,
        ),
      ),
      children: const [
        Text('Focus Flow is a productivity app designed to help you manage your tasks and stay organized.'),
      ],
    );
  }

  void _showFeedbackDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Send Feedback'),
        content: const TextField(
          decoration: InputDecoration(
            hintText: 'Tell us what you think...',
            border: OutlineInputBorder(),
          ),
          maxLines: 4,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Thank you for your feedback!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Send'),
          ),
        ],
      ),
    );
  }
}
