import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _errorText = '';

  @override
  void initState() {
    super.initState();
    _signInSilently();
  }

  //look at cookies for googlesignin - 90s, 1 whole day, etc
  Future<void> _signInSilently() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleUser =
          await googleSignIn.signInSilently();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      // Use the googleAuth.idToken and googleAuth.accessToken to authenticate with your backend server

      // Navigate to the next screen or perform any other actions
      Navigator.pushReplacementNamed(context, '/');
    } catch (error) {
      print('Google Sign-In Error: $error');
    }
  }

  Future<void> _login() async {
    try {
      final String email = _usernameController.text.trim();
      final String password = _passwordController.text;

      // Sign in using email and password
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Handle successful login
      _handleLoginSuccess(userCredential.user);
    } catch (e) {
      setState(() {
        _errorText = 'Login failed. Please check your credentials.';
      });
    }
  }

  Future<void> _signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId:
          '842751620236-g7lris546cuofu9tlafmijsc4j2494uu.apps.googleusercontent.com',
    );

    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google [UserCredential]
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      // Handle successful login
      _handleLoginSuccess(userCredential.user);
    } catch (error) {
      print('Google Sign-In Error: $error');
    }
  }

  void _handleLoginSuccess(User? user) {
    if (user != null) {
      // Print the user details
      print('Sign-In Successful');
      print('User Name: ${user.displayName}');
      print('User Email: ${user.email}');
      print('User ID: ${user.uid}');

      // Update the user information in UserProvider
      final UserProvider userProvider =
          Provider.of<UserProvider>(context, listen: false);
      userProvider.updateUser(user);

      // Navigate to the home screen
      Navigator.pushReplacementNamed(context, '/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(48.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 48),
                SizedBox(
                  width: 200,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black12,
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: 200,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: _signInWithGoogle,
                    style: ElevatedButton.styleFrom(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sign in with ',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                            width: 8), // Add spacing between the image and text
                        ImageIcon(
                          AssetImage(
                              'assets/icons/google_logo_small.png'), // Replace with your image path
                          size: 16,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
