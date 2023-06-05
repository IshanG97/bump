import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'login.dart';
import 'bump.dart';
import 'chat.dart';
import 'settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (_) => NavigationProvider(),
      child: MyApp(),
    ),
  );
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
      initialRoute: '/chat',
      onGenerateRoute: (settings) {
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) {
            return FadeTransition(
              opacity: animation,
              child: _buildScreen(settings.name!),
            );
          },
        );
      },
      routes: {
        '/bump': (context) => CustomLayout(child: BumpScreen()),
        '/login': (context) => CustomLayout(child: LoginScreen()),
        '/chat': (context) => CustomLayout(child: ChatScreen()),
        '/settings': (context) => CustomLayout(child: SettingsScreen()),
      },
    );
  }

  Widget _buildScreen(String routeName) {
    switch (routeName) {
      case '/bump':
        return CustomLayout(child: BumpScreen());
      case '/login':
        return CustomLayout(child: LoginScreen());
      case '/chat':
        return CustomLayout(child: ChatScreen());
      case '/settings':
        return CustomLayout(child: SettingsScreen());
      default:
        return Container();
    }
  }
}

class CustomLayout extends StatelessWidget {
  final Widget child;

  CustomLayout({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // Add your app bar here if needed
          // ...
          ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(child: child),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}

class BottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NavigationProvider>(context);
    return BottomNavigationBar(
      currentIndex: provider.currentIndex,
      onTap: (index) {
        provider.updateCurrentIndex(index);
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/settings');
            break;
          case 2:
            Navigator.pushNamed(context, '/bump');
            break;
          default:
            break;
        }
      },
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          icon: CustomBottomNavigationBarItem(
            iconPath: 'assets/icons/navbar_settings.svg',
            isSelected: provider.currentIndex == 0,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: CustomBottomNavigationBarItem(
            iconPath: 'assets/icons/navbar_chat.svg',
            isSelected: provider.currentIndex == 1,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: CustomBottomNavigationBarItem(
            iconPath: 'assets/icons/bump_logo.svg',
            isSelected: provider.currentIndex == 2,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: CustomBottomNavigationBarItem(
            iconPath: 'assets/icons/navbar_location.svg',
            isSelected: provider.currentIndex == 3,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: CustomBottomNavigationBarItem(
            iconPath: 'assets/icons/navbar_add.svg',
            isSelected: provider.currentIndex == 4,
          ),
          label: '',
        ),
      ],
    );
  }
}

class CustomBottomNavigationBarItem extends StatefulWidget {
  final String iconPath;
  final bool isSelected;

  const CustomBottomNavigationBarItem({
    required this.iconPath,
    this.isSelected = false,
  });

  @override
  _CustomBottomNavigationBarItemState createState() =>
      _CustomBottomNavigationBarItemState();
}

class _CustomBottomNavigationBarItemState
    extends State<CustomBottomNavigationBarItem> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: (_) {
          setState(() {
            _isTapped = true;
          });
        },
        onTapUp: (_) {
          setState(() {
            _isTapped = false;
          });
          if (widget.iconPath == 'assets/icons/navbar_chat.svg') {
            Navigator.pushNamed(context, '/chat');
          }
        },
        onTapCancel: () {
          setState(() {
            _isTapped = false;
          });
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: SvgPicture.asset(
            widget.iconPath,
            width: 36,
            height: 36,
            color: widget.isSelected || _isTapped ? Colors.blue : null,
          ),
          alignment: Alignment.center,
        ),
      ),
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
