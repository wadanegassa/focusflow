import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/theme_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
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
        title: const Text('Settings'),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(isTablet ? 24 : 16),
            child: Column(
              children: [
                // Appearance Section
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(isTablet ? 24 : 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Appearance',
                          style: TextStyle(
                            fontSize: isTablet ? 20 : 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        Consumer<ThemeService>(
                          builder: (context, themeService, child) {
                            return Column(
                              children: [
                                _buildThemeOption(
                                  'Light Mode',
                                  'Use light theme',
                                  Icons.light_mode,
                                  themeService.themeMode == ThemeMode.light,
                                  () => themeService.setThemeMode(ThemeMode.light),
                                ),
                                
                                _buildThemeOption(
                                  'Dark Mode',
                                  'Use dark theme',
                                  Icons.dark_mode,
                                  themeService.themeMode == ThemeMode.dark,
                                  () => themeService.setThemeMode(ThemeMode.dark),
                                ),
                                
                                _buildThemeOption(
                                  'System Default',
                                  'Follow system theme',
                                  Icons.settings_system_daydream,
                                  themeService.themeMode == ThemeMode.system,
                                  () => themeService.setThemeMode(ThemeMode.system),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Notifications Section
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(isTablet ? 24 : 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Notifications',
                          style: TextStyle(
                            fontSize: isTablet ? 20 : 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        _buildSwitchTile(
                          'Push Notifications',
                          'Receive push notifications',
                          Icons.notifications,
                          true,
                          (value) {},
                        ),
                        
                        _buildSwitchTile(
                          'Task Reminders',
                          'Get reminded about due tasks',
                          Icons.alarm,
                          true,
                          (value) {},
                        ),
                        
                        _buildSwitchTile(
                          'Daily Summary',
                          'Receive daily task summary',
                          Icons.summarize,
                          false,
                          (value) {},
                        ),
                        
                        _buildSwitchTile(
                          'Weekly Report',
                          'Get weekly productivity report',
                          Icons.analytics,
                          true,
                          (value) {},
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Task Settings Section
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(isTablet ? 24 : 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Task Settings',
                          style: TextStyle(
                            fontSize: isTablet ? 20 : 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        _buildSwitchTile(
                          'Auto-complete',
                          'Automatically mark tasks as complete',
                          Icons.auto_awesome,
                          false,
                          (value) {},
                        ),
                        
                        _buildSwitchTile(
                          'Smart Categories',
                          'Automatically categorize tasks',
                          Icons.category,
                          true,
                          (value) {},
                        ),
                        
                        _buildSwitchTile(
                          'Priority Suggestions',
                          'Suggest task priorities',
                          Icons.flag,
                          true,
                          (value) {},
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Privacy & Security Section
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(isTablet ? 24 : 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Privacy & Security',
                          style: TextStyle(
                            fontSize: isTablet ? 20 : 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        _buildActionTile(
                          'Change Password',
                          'Update your account password',
                          Icons.lock,
                          () {
                            _showChangePasswordDialog(context);
                          },
                        ),
                        
                        _buildActionTile(
                          'Biometric Authentication',
                          'Use fingerprint or face ID',
                          Icons.fingerprint,
                          () {
                            _showBiometricDialog(context);
                          },
                        ),
                        
                        _buildActionTile(
                          'Data Export',
                          'Export your task data',
                          Icons.download,
                          () {
                            _showDataExportDialog(context);
                          },
                        ),
                        
                        _buildActionTile(
                          'Clear Cache',
                          'Clear app cache and temporary files',
                          Icons.cleaning_services,
                          () {
                            _showClearCacheDialog(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Language & Region Section
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(isTablet ? 24 : 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Language & Region',
                          style: TextStyle(
                            fontSize: isTablet ? 20 : 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        _buildActionTile(
                          'Language',
                          'English (US)',
                          Icons.language,
                          () {
                            _showLanguageDialog(context);
                          },
                        ),
                        
                        _buildActionTile(
                          'Date Format',
                          'MM/DD/YYYY',
                          Icons.calendar_today,
                          () {
                            _showDateFormatDialog(context);
                          },
                        ),
                        
                        _buildActionTile(
                          'Time Format',
                          '12-hour',
                          Icons.access_time,
                          () {
                            _showTimeFormatDialog(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // About Section
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(isTablet ? 24 : 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'About',
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
                        
                        _buildActionTile(
                          'Terms of Service',
                          'Read our terms and conditions',
                          Icons.description,
                          () {
                            _showTermsDialog(context);
                          },
                        ),
                        
                        _buildActionTile(
                          'Privacy Policy',
                          'Read our privacy policy',
                          Icons.privacy_tip,
                          () {
                            _showPrivacyPolicyDialog(context);
                          },
                        ),
                        
                        _buildActionTile(
                          'Open Source Licenses',
                          'View third-party licenses',
                          Icons.code,
                          () {
                            _showLicensesDialog(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Danger Zone
                Card(
                  color: Colors.red.shade50,
                  child: Padding(
                    padding: EdgeInsets.all(isTablet ? 24 : 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Danger Zone',
                          style: TextStyle(
                            fontSize: isTablet ? 20 : 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        _buildActionTile(
                          'Delete All Data',
                          'Permanently delete all tasks and data',
                          Icons.delete_forever,
                          () {
                            _showDeleteAllDataDialog(context);
                          },
                          textColor: Colors.red,
                          iconColor: Colors.red,
                        ),
                        
                        _buildActionTile(
                          'Reset Settings',
                          'Reset all settings to default',
                          Icons.restore,
                          () {
                            _showResetSettingsDialog(context);
                          },
                          textColor: Colors.orange,
                          iconColor: Colors.orange,
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

  Widget _buildThemeOption(
    String title,
    String subtitle,
    IconData icon,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: isSelected ? Colors.blue : Colors.grey),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: isSelected ? const Icon(Icons.check, color: Colors.blue) : null,
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    IconData icon,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
      ),
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildActionTile(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap, {
    Color? textColor,
    Color? iconColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor ?? Colors.blue),
      title: Text(
        title,
        style: TextStyle(color: textColor),
      ),
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

  void _showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Password'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Current Password',
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'New Password',
                prefixIcon: Icon(Icons.lock_outline),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Confirm New Password',
                prefixIcon: Icon(Icons.lock_outline),
              ),
              obscureText: true,
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
                  content: Text('Password changed successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Change'),
          ),
        ],
      ),
    );
  }

  void _showBiometricDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Biometric Authentication'),
        content: const Text('Enable biometric authentication for quick and secure access to your account.'),
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
                  content: Text('Biometric authentication enabled!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Enable'),
          ),
        ],
      ),
    );
  }

  void _showDataExportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export Data'),
        content: const Text('Export your task data to a JSON file for backup or migration purposes.'),
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
                  content: Text('Data exported successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Export'),
          ),
        ],
      ),
    );
  }

  void _showClearCacheDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Cache'),
        content: const Text('This will clear all cached data and temporary files. This action cannot be undone.'),
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
                  content: Text('Cache cleared successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
            ),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('English (US)'),
              trailing: Icon(Icons.check, color: Colors.blue),
            ),
            ListTile(
              title: Text('Spanish'),
            ),
            ListTile(
              title: Text('French'),
            ),
            ListTile(
              title: Text('German'),
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

  void _showDateFormatDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Date Format'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('MM/DD/YYYY'),
              trailing: Icon(Icons.check, color: Colors.blue),
            ),
            ListTile(
              title: Text('DD/MM/YYYY'),
            ),
            ListTile(
              title: Text('YYYY-MM-DD'),
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

  void _showTimeFormatDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Time Format'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('12-hour (AM/PM)'),
              trailing: Icon(Icons.check, color: Colors.blue),
            ),
            ListTile(
              title: Text('24-hour'),
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

  void _showTermsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Terms of Service'),
        content: const SingleChildScrollView(
          child: Text(
            'Terms of Service content would go here. This is a placeholder for the actual terms and conditions.',
          ),
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

  void _showPrivacyPolicyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Privacy Policy'),
        content: const SingleChildScrollView(
          child: Text(
            'Privacy Policy content would go here. This is a placeholder for the actual privacy policy.',
          ),
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

  void _showLicensesDialog(BuildContext context) {
    showLicensePage(context: context);
  }

  void _showDeleteAllDataDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete All Data'),
        content: const Text(
          'This will permanently delete all your tasks, settings, and data. This action cannot be undone. Are you sure you want to continue?',
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
                  content: Text('All data deleted successfully!'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete All'),
          ),
        ],
      ),
    );
  }

  void _showResetSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Settings'),
        content: const Text(
          'This will reset all settings to their default values. Your tasks will not be affected.',
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
                  content: Text('Settings reset successfully!'),
                  backgroundColor: Colors.orange,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
            ),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}
