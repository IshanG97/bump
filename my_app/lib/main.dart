import 'package:flutter/material.dart';
import 'package:my_app/login.dart';
import 'google.dart';
import 'home.dart';
import 'chat.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BUMP',
      theme: ThemeData(
        brightness: Brightness.dark, // Set the brightness to dark
        primarySwatch: Colors.red,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => CustomLayout(
              child: HomeScreen(),
            ),
        '/login': (context) => CustomLayout(
              child: LoginScreen(),
            ),
        '/chat': (context) => CustomLayout(
              child: ChatScreen(),
            ),
      },
    );
  }
}

class CustomLayout extends StatelessWidget {
  final Widget child;

  CustomLayout({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0), // Specify the desired height
        child: AppBar(
          centerTitle: true,
          toolbarHeight: 80.0, // Adjust the height as needed
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: Image.asset(
                'assets/icons/bump_logo.png',
                fit: BoxFit.contain,
                width: 100,
                height: 100,
              ),
            ),
          ),
        ),
      ),
      body: child,
    );
  }
}
