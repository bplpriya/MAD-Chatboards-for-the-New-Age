import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatefulWidget {
  final String boardId;
  final String boardName;

  ChatScreen({required this.boardId, required this.boardName});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final msg = TextEditingController();
  final scroll = ScrollController();

  void send() async {
    if (msg.text.trim().isEmpty) return;

    final user = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection("boards")
        .doc(widget.boardId)
        .collection("messages")
        .add({
      "text": msg.text.trim(),
      "senderId": user.uid,
      "senderName": user.email,
      "timestamp": FieldValue.serverTimestamp()
    });

    msg.clear();
  }

  @override
  Widget build(BuildContext context) {
    final messagesRef = FirebaseFirestore.instance
        .collection("boards")
        .doc(widget.boardId)
        .collection("messages")
        .orderBy("timestamp", descending: true);

    return Scaffold(
      appBar: AppBar(title: Text(widget.boardName)),
      body: Column(children: [
        Expanded(
            child: StreamBuilder<QuerySnapshot>(
          stream: messagesRef.snapshots(),
          builder: (context, snap) {
            if (!snap.hasData) return Center(child: CircularProgressIndicator());

            final docs = snap.data!.docs;

            return ListView.builder(
              reverse: true,
              controller: scroll,
              itemCount: docs.length,
              itemBuilder: (_, idx) {
                final d = docs[idx];
                return ListTile(
                  title: Text(d["senderName"]),
                  subtitle: Text(d["text"]),
                );
              },
            );
          },
        )),
        Padding(
          padding: EdgeInsets.all(8),
          child: Row(children: [
            Expanded(child: TextField(controller: msg)),
            IconButton(icon: Icon(Icons.send), onPressed: send)
          ]),
        )
      ]),
    );
  }
}
