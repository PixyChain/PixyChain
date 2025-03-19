import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pixy_chain/main_screen.dart';
import 'package:pixy_chain/super_users_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pixy_chain/homepage.dart';
import 'package:pixy_chain/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDXOlcvUwyavAiNRoBbWyEs_l2DOXKHXvo",
      authDomain: "pixychain.firebaseapp.com",
      projectId: "pixychain",
      storageBucket: "pixychain.firebasestorage.app",
      messagingSenderId: "514575012631",
      appId: "1:514575012631:web:3d453c901b44077f7fdd52",
    ),
  );

  
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(PixyChain(startScreen: isLoggedIn ? HomePage() : const WelcomeScreen()));
}

class PixyChain extends StatelessWidget {
  final Widget startScreen;

  const PixyChain({super.key, required this.startScreen});

  @override
  Widget build(BuildContext context) {
    return    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen()
      
    );
  }
}
