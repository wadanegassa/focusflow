import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
  child: ListView(
    padding: EdgeInsets.zero,
    children: [
      SizedBox(
        height: 180, // slightly taller for better spacing
        child: DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          padding: const EdgeInsets.all(16), // more padding for comfort
          margin: EdgeInsets.zero,
          child: Stack(
            children: [
              Positioned(
                bottom: 16, // some bottom spacing
                left: 0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    CircleAvatar(
                      radius: 30, // slightly bigger avatar
                      backgroundColor: Colors.white,
                      child: Text(
                        'WN',
                        style: TextStyle(fontSize: 20, color: Colors.blue),
                      ),
                    ),
                    SizedBox(width: 14), // more space between avatar & text
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Wada N',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),

                        Text(
                          'wada@focus.com',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      const ListTile(
        leading: Icon(Icons.info_outline),
        title: Text('About'),
      ),
      const Divider(),
      const ListTile(
        leading: Icon(Icons.settings_outlined),
        title: Text('Settings'),
      ),
      const Divider(),
      const ListTile(
        leading: Icon(Icons.help_outline),
        title: Text('Help'),
      ),
      const Divider(),
      const ListTile(
        leading: Icon(Icons.logout, color: Colors.red),
        title: Text('Logout', style: TextStyle(color: Colors.red)),
      ),
    ],
  ),
);



  }
}