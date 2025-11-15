import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chat_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';
import '../widgets/app_drawer.dart';

class HomeScreen extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;

  final List<Map<String, String>> boards = [
    {'name': 'Sports', 'icon': '🏀'},
    {'name': 'Tech', 'icon': '💻'},
    {'name': 'Movies', 'icon': '🎬'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Message Boards')),
      drawer: AppDrawer(), // Your menu
      body: ListView.builder(
        itemCount: boards.length,
        itemBuilder: (context, index) {
          final board = boards[index];
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              leading: Text(board['icon']!, style: TextStyle(fontSize: 30)),
              title: Text(board['name']!),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatScreen(boardName: board['name']!),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
