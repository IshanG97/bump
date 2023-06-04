import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'login.dart';
import 'bump.dart';
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
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/bump',
      routes: {
        '/bump': (context) => CustomLayout(
              child: BumpScreen(),
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

class CustomLayout extends StatefulWidget {
  final Widget child;

  CustomLayout({required this.child});

  @override
  _CustomLayoutState createState() => _CustomLayoutState();
}

class _CustomLayoutState extends State<CustomLayout> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (_currentIndex == 1) {
        // Navigate to ChatScreen
        Navigator.pushNamed(context, '/chat');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(child: widget.child),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          CustomBottomNavigationBarItem(
            icon: 'assets/icons/navbar_settings.svg',
          ),
          CustomBottomNavigationBarItem(
            icon: 'assets/icons/navbar_chat.svg',
          ),
          CustomBottomNavigationBarItem(
            icon: 'assets/icons/bump_logo.svg',
          ),
          CustomBottomNavigationBarItem(
            icon: 'assets/icons/navbar_location.svg',
          ),
          CustomBottomNavigationBarItem(
            icon: 'assets/icons/navbar_add.svg',
          ),
        ],
      ),
    );
  }
}

class CustomBottomNavigationBarItem extends BottomNavigationBarItem {
  CustomBottomNavigationBarItem({required String icon})
      : super(
          icon: Container(
            width: double.infinity,
            child: InkWell(
              onTap: () {},
              child: SvgPicture.asset(
                icon,
                width: 36,
                height: 36,
              ),
            ),
            alignment: Alignment.center,
          ),
          label: '',
        );
}
