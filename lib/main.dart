import 'package:blog_final/screens/creation_screen.dart';
import 'package:blog_final/screens/home_screen.dart';
import 'package:blog_final/screens/log_reg_screen.dart';
import 'package:blog_final/screens/login_screen.dart';
import 'package:blog_final/screens/register_screen.dart';
import 'package:blog_final/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LogRegisterScreen(),
      routes: {
        MyRoutes.logRegRoute: (context) => const LogRegisterScreen(),
        MyRoutes.loginRoute: (context) => const LoginScreen(),
        MyRoutes.registerRoute: (context) => const RegisterScreen(),
        MyRoutes.homeRoute: (context) => const HomeScreen(),
        MyRoutes.createRoute: (context) => const CreationScreen(),
      },
    );
  }
}
