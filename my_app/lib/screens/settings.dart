import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart'; // Import the UserProvider class

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'User Email: ${user.email}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 16),
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to the Chat Screen
                Navigator.pushReplacementNamed(context, '/chat');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: const Size(200, 60),
              ),
              child: const Text(
                'Chat',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigate to the Login Screen
                Navigator.pushReplacementNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: const Size(200, 60),
              ),
              child: const Text(
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
