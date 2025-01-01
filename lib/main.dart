import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Screens/loginPage.dart';
import 'Screens/SignUpPage.dart';
import 'Screens/Home.page.dart';
import 'package:get/get.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyD6tc3c-taXVUfm2JcaZous5atImPgAFMw",
      authDomain: "ecommerce-c0cd4.firebaseapp.com",
      projectId: "ecommerce-c0cd4",
      storageBucket: "ecommerce-c0cd4.firebasestorage.app",
      messagingSenderId: "220045605228",
      appId: "1:220045605228:android:a27e9e3eb4e249fe249b49",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      title: 'Salma Bellamkaddem',
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/signin', page: () => SignUpPage()),
      ],
    );
  }
}