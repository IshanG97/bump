import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BumpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: GestureDetector(
                  onTap: () {
                    // Handle button tap
                    Navigator.pushNamed(context, '/chat');
                  },
                  child: SvgPicture.asset(
                    'assets/icons/bump_logo.svg',
                    width: 480,
                    height: 480,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 32),
                child: Text(
                  'Tap "BUMP" to start matchmaking',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 32),
                child: Text(
                  'Matchmaking preference',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
