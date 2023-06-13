import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
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

  Future<void> _signInSilently() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleUser =
          await googleSignIn.signInSilently();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      // Use the googleAuth.idToken and googleAuth.accessToken to authenticate with your backend server

      // Navigate to the next screen or perform any other actions
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
      // TODO: Add your logic here

      // Navigate to the home screen
      Navigator.pushReplacementNamed(context, '/');
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

      // Use the googleAuth.idToken and googleAuth.accessToken to authenticate with your backend server

      // Navigate to the next screen or perform any other actions
      Navigator.pushReplacementNamed(context, '/');
    } catch (error) {
      print('Google Sign-In Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  child: Text('Login'),
                  onPressed: _login,
                ),
                SizedBox(height: 16),
                Text(
                  _errorText,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                ElevatedButton(
                  onPressed: _signInWithGoogle,
                  child: Text('Sign in with Google'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
