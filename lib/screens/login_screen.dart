import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'register_screen.dart';
import 'home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final pass = TextEditingController();
  bool loading = false;
  String? error;

  Future<void> login() async {
    setState(() { loading = true; error = null; });

    try {
      final cred = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: pass.text.trim(),
      );

      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(cred.user!.uid)
          .get();

      Provider.of<UserProvider>(context, listen: false)
          .setProfile(doc.data());

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
        appBar: AppBar(title: Text("Login")),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(children:[
            TextField(controller: email, decoration: InputDecoration(labelText: "Email")),
            TextField(controller: pass, decoration: InputDecoration(labelText: "Password"), obscureText: true),
            if(error != null) Text(error!, style: TextStyle(color: Colors.red)),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: loading ? null : login,
              child: loading ? CircularProgressIndicator() : Text("Login"),
            ),
            TextButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterScreen())),
                child: Text("Register"))
          ]),
        ));
  }
}
