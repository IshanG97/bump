import 'package:flutter/material.dart';
// import 'login.dart';
import 'chat.dart';
import 'home.dart';
import 'google.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bump App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/login': (context) => LoginScreenGoogle(),
        '/chat': (context) => ChatScreen(),
      },
    );
  }
}
