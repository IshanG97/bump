import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to the Chat Screen
                Navigator.pushNamed(context, '/chat');
              },
              style: ElevatedButton.styleFrom(
                primary:
                    Colors.black, // Set the button background color to black
                minimumSize:
                    Size(200, 60), // Set the minimum size of the button
              ),
              child: Text(
                'Chat',
                style: TextStyle(
                  fontSize: 18, // Increase the font size of the button text
                  color: Colors.white, // Set the button text color to white
                ),
              ),
            ),
            SizedBox(height: 16), // Add a SizedBox for vertical spacing
            ElevatedButton(
              onPressed: () {
                // Navigate to the Login Screen
                Navigator.pushNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                primary:
                    Colors.black, // Set the button background color to black
                minimumSize:
                    Size(200, 60), // Set the minimum size of the button
              ),
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 18, // Increase the font size of the button text
                  color: Colors.white, // Set the button text color to white
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
