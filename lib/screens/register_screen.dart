import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final first = TextEditingController();
  final last = TextEditingController();
  final email = TextEditingController();
  final pass = TextEditingController();
  final role = TextEditingController(text: "student");

  bool loading = false;
  String? error;

  Future<void> register() async {
    setState(() { loading = true; error = null; });

    try {
      final cred = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text.trim(),
              password: pass.text.trim());

      await FirebaseFirestore.instance
          .collection('users')
          .doc(cred.user!.uid)
          .set({
        "uid": cred.user!.uid,
        "firstName": first.text.trim(),
        "lastName": last.text.trim(),
        "role": role.text.trim(),
        "registeredAt": FieldValue.serverTimestamp(),
      });

      Provider.of<UserProvider>(context, listen: false).setProfile({
        "firstName": first.text.trim(),
        "lastName": last.text.trim(),
        "role": role.text.trim(),
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      error = e.message;
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Register")),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: ListView(children: [
            TextField(controller: first, decoration: InputDecoration(labelText: "First Name")),
            TextField(controller: last, decoration: InputDecoration(labelText: "Last Name")),
            TextField(controller: email, decoration: InputDecoration(labelText: "Email")),
            TextField(controller: pass, decoration: InputDecoration(labelText: "Password"), obscureText: true),
            TextField(controller: role, decoration: InputDecoration(labelText: "Role")),
            if(error != null) Text(error!, style: TextStyle(color: Colors.red)),
            SizedBox(height: 10),
            ElevatedButton(onPressed: loading ? null : register, child: Text("Create Account"))
          ]),
        ));
  }
}
