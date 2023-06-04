import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BumpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                // Handle button tap
                Navigator.pushNamed(context, '/chat');
              },
              child: SvgPicture.asset(
                'assets/icons/bump_logo.svg',
                width: 500,
                height: 500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
