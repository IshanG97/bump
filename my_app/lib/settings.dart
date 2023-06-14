import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user_provider.dart'; // Import the UserProvider class

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<UserProvider>(
              builder: (context, userProvider, _) {
                final user = userProvider.user;
                if (user != null) {
                  return Column(
                    children: [
                      Text(
                        'User Name: ${user.displayName}',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'User Email: ${user.email}',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 16),
                    ],
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to the Chat Screen
                Navigator.pushReplacementNamed(context, '/chat');
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                minimumSize: Size(200, 60),
              ),
              child: Text(
                'Chat',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigate to the Login Screen
                Navigator.pushReplacementNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                minimumSize: Size(200, 60),
              ),
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
