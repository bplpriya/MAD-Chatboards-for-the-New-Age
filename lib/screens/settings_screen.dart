import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final newPass = TextEditingController();
  final currentPass = TextEditingController();

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
        (route) => false);
  }

  Future<void> changePassword() async {
    final user = FirebaseAuth.instance.currentUser!;
    final cred = EmailAuthProvider.credential(
        email: user.email!, password: currentPass.text);

    await user.reauthenticateWithCredential(cred);
    await user.updatePassword(newPass.text);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Password Updated")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Settings")),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(children: [
            TextField(controller: newPass, decoration: InputDecoration(labelText: "New Password")),
            TextField(controller: currentPass, decoration: InputDecoration(labelText: "Current Password"), obscureText: true),
            ElevatedButton(onPressed: changePassword, child: Text("Change Password")),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: logout,
                child: Text("Logout"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red))
          ]),
        ));
  }
}
