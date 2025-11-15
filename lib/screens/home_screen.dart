import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/app_drawer.dart';
import 'chat_screen.dart';

class HomeScreen extends StatelessWidget {
  Future<void> ensureBoards() async {
    final boards = FirebaseFirestore.instance.collection("boards");

    final defaultBoards = [
      {"id": "general", "name": "General", "icon": "📰"},
      {"id": "announcements", "name": "Announcements", "icon": "📢"},
      {"id": "projects", "name": "Projects", "icon": "🧩"}
    ];

    for (var b in defaultBoards) {
      final doc = await boards.doc(b["id"]).get();
      if (!doc.exists) {
        await boards.doc(b["id"]).set({
          "name": b["name"],
          "icon": b["icon"],
          "createdAt": FieldValue.serverTimestamp()
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ensureBoards();

    return Scaffold(
      appBar: AppBar(title: Text("Message Boards")),
      drawer: AppDrawer(),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('boards').snapshots(),
        builder: (context, snap) {
          if (!snap.hasData) return Center(child: CircularProgressIndicator());

          final docs = snap.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (_, idx) {
              final d = docs[idx];
              return ListTile(
                leading: Text(d['icon'] ?? "💬", style: TextStyle(fontSize: 30)),
                title: Text(d['name']),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          ChatScreen(boardId: d.id, boardName: d['name'])),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
