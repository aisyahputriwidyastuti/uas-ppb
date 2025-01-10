import 'package:aplikasi_uas/views/splash_screen.dart'; // Import layar splash
import 'package:firebase_core/firebase_core.dart'; // Import Firebase
import 'package:flutter/material.dart';
import 'dart:developer'; // Import logging framework

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Memastikan widget binding terinisialisasi sebelum Firebase
  try {
    // Inisialisasi Firebase dengan opsi khusus untuk platform web
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBXrYOQC-C-FqljbdFZKCIOqZcKA6onqSk", // API Key proyek Firebase Anda
        appId: "1:427363889607:web:1262b6f8367e90017129e2", // App ID proyek Firebase Anda
        messagingSenderId: "427363889607", // Messaging Sender ID proyek Firebase Anda
        projectId: "aplikasi-uas-1432d", // Project ID proyek Firebase Anda
      ),
    );
  } catch (e, stackTrace) {
    // Handle error saat inisialisasi Firebase menggunakan logging
    log('Error initializing Firebase', error: e, stackTrace: stackTrace);
  }
  runApp(const MyApp()); // Menjalankan aplikasi dengan MyApp sebagai root
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Konstruktor menggunakan 'const' untuk efisiensi

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Menghapus banner debug
      theme: ThemeData(
        primarySwatch: Colors.blue, // Tema utama aplikasi
      ),
      home: const SplashScreen(), // Menampilkan SplashScreen sebagai layar awal
    );
  }
}
