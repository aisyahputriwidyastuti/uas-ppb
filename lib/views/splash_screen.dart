import 'package:flutter/material.dart';
import 'dart:async';
import 'package:aplikasi_uas/auth/main_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key}); // Constructor sudah menggunakan 'const'

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    splashscreenStart();
  }

  splashscreenStart() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()), // Menambahkan 'const'
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            // Tambahkan 'const' pada semua widget yang mendukung
            Icon(
              Icons.school,
              size: 120.0,
              color: Colors.white,
            ),
            SizedBox(height: 20.0),
            Text(
              'SEKOLAHKU APPS',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 36.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
