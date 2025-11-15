import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final first = TextEditingController();
  final last = TextEditingController();
  final dob = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final user = FirebaseAuth.instance.currentUser!;
    final doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get();

    final data = doc.data()!;
    first.text = data["firstName"] ?? "";
    last.text = data["lastName"] ?? "";
    dob.text = data["dob"] ?? "";
  }

  Future<void> save() async {
    final user = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance.collection("users").doc(user.uid).update({
      "firstName": first.text,
      "lastName": last.text,
      "dob": dob.text
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Saved")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Profile")),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(children: [
            TextField(controller: first, decoration: InputDecoration(labelText: "First Name")),
            TextField(controller: last, decoration: InputDecoration(labelText: "Last Name")),
            TextField(controller: dob, decoration: InputDecoration(labelText: "DOB")),
            SizedBox(height: 10),
            ElevatedButton(onPressed: save, child: Text("Save"))
          ]),
        ));
  }
}
