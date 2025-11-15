import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../providers/user_provider.dart';
import 'package:provider/provider.dart';
import '../screens/login_screen.dart';
import '../screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await Future.delayed(Duration(milliseconds: 800));

    FirebaseAuth.instance.authStateChanges().listen((user) async {
      final provider = Provider.of<UserProvider>(context, listen: false);
      provider.setFirebaseUser(user);

      if (user != null) {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        provider.setProfile(doc.data());
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => HomeScreen()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
        FlutterLogo(size: 100),
        SizedBox(height: 10),
        CircularProgressIndicator()
      ])),
    );
  }
}
