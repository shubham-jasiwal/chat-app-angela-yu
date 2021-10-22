import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wave/screens/camera_screen.dart';
import 'package:wave/screens/welcome_screen.dart';
import 'package:wave/screens/login_screen.dart';
import 'package:wave/screens/registration_screen.dart';
import 'package:wave/screens/chat_screen.dart';
// import 'package:wave/screens/camera_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        TakePictureScreen.id:(context) => TakePictureScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}
