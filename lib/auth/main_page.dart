import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aplikasi_uas/auth/auth_page.dart';
// Removed 'package:aplikasi_uas/auth/main_page.dart' as it is unused
import 'package:aplikasi_uas/views/home_page.dart';
// Removed 'package:aplikasi_uas/views/home_page.dart' if unused

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key); // Use const constructor

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomePage(); // Added 'const' to constructor invocation
          } else {
            return const AuthPage(); // Added 'const' to constructor invocation
          }
        },
      ),
    );
  }
}
