import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import 'login_screen.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SwitchListTile(
              title: Text('Dark Mode'),
              value: userProvider.isDarkMode,
              onChanged: (val) => userProvider.toggleDarkMode(),
            ),
            ListTile(
              title: Text('Notifications'),
              trailing: Icon(Icons.notifications),
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Notifications clicked'))),
            ),
            ListTile(
              title: Text('Privacy'),
              trailing: Icon(Icons.privacy_tip),
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Privacy clicked'))),
            ),
            ListTile(
              title: Text('Logout'),
              trailing: Icon(Icons.logout),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => LoginScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
