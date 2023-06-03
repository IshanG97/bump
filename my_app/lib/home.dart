import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BUMP'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to the Chat Screen
                Navigator.pushNamed(context, '/chat');
              },
              child: Text('Chat Screen'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to the Login Screen
                Navigator.pushNamed(context, '/login');
              },
              child: Text('Login Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
