import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/login.dart';
import 'screens/bump.dart';
import 'screens/chat.dart';
import 'screens/settings.dart';
import 'screens/location.dart';
import 'screens/add.dart';
import 'firebase_options.dart';
import 'providers/user_provider.dart';
import 'package:my_app/screens/chat_multi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      // Use MultiProvider to provide more than one provider
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(
            create: (_) => UserProvider()), // Add UserProvider
      ],
      child: MaterialApp(
        title: 'BUMP',
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginScreen(),
          '/chat': (context) => ChatScreen(),
          '/location': (context) => LocationScreen(),
        },
        home: Scaffold(
          body: Consumer<NavigationProvider>(
            builder: (context, provider, _) {
              switch (provider.currentIndex) {
                //switch (2) {
                case 0:
                  return SettingsScreen();
                case 1:
                  return ChatScreen();
                case 2:
                  return BumpScreen();
                case 3:
                  return LocationScreen();
                case 4:
                  return AddScreen();
                default:
                  return ChatScreen();
              }
            },
          ),
          bottomNavigationBar: CustomBottomNavigationBar(),
        ),
      ),
    ),
  );
}

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
      builder: (context, provider, _) => BottomNavigationBar(
        currentIndex: provider.currentIndex,
        onTap: (index) {
          provider.updateCurrentIndex(index);
        },
        elevation: 1,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          _buildNavigationBarItem(
            'assets/icons/navbar_settings.svg',
            provider.currentIndex == 0,
            () => Navigator.pushReplacementNamed(context, '/settings'),
          ),
          _buildNavigationBarItem(
            'assets/icons/navbar_chat.svg',
            provider.currentIndex == 1,
            () => Navigator.pushReplacementNamed(context, '/chat'),
          ),
          _buildNavigationBarItem(
            'assets/icons/bump_logo.svg',
            provider.currentIndex == 2,
            () => Navigator.pushReplacementNamed(context, '/bump'),
          ),
          _buildNavigationBarItem(
            'assets/icons/navbar_location.svg',
            provider.currentIndex == 3,
            () => Navigator.pushReplacementNamed(context, '/location'),
          ),
          _buildNavigationBarItem(
            'assets/icons/navbar_add.svg',
            provider.currentIndex == 4,
            () => Navigator.pushReplacementNamed(context, '/add'),
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavigationBarItem(
      String iconPath, bool isSelected, VoidCallback onTap) {
    return BottomNavigationBarItem(
      icon: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: SvgPicture.asset(
            iconPath,
            width: 36,
            height: 36,
            color: isSelected ? Colors.blue : null,
          ),
          alignment: Alignment.center,
        ),
      ),
      label: '',
    );
  }
}

class NavigationProvider with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void updateCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
