import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  final firstController = TextEditingController();
  final lastController = TextEditingController();
  final dobController = TextEditingController();

  void _loadUserData() async {
    final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    if (doc.exists) {
      final data = doc.data()!;
      firstController.text = data['firstName'] ?? '';
      lastController.text = data['lastName'] ?? '';
      dobController.text = data['dob'] ?? '';
    }
  }

  void _saveProfile() async {
    await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
      'firstName': firstController.text,
      'lastName': lastController.text,
      'dob': dobController.text,
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile updated')));
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: firstController, decoration: InputDecoration(labelText: 'First Name')),
            TextField(controller: lastController, decoration: InputDecoration(labelText: 'Last Name')),
            TextField(controller: dobController, decoration: InputDecoration(labelText: 'Date of Birth')),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _saveProfile, child: Text('Save')),
          ],
        ),
      ),
    );
  }
}
