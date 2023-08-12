import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../resources/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    const MaterialApp(
      home: FirestoreTest(),
    ),
  );
}

class FirestoreTest extends StatefulWidget {
  const FirestoreTest({super.key});

  @override
  _FirestoreTestState createState() => _FirestoreTestState();
}

class _FirestoreTestState extends State<FirestoreTest> {
  bool isConnected = false;
  String connectionStatus = 'Waiting to connect...';

  Future<void> addUserToFirestore() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    // Create a new user with a first and last name
    final user = <String, dynamic>{
      "first": "Ada",
      "last": "Lovelace",
      "born": 1815
    };

    // Add a new document with a generated ID
    await db.collection("users").add(user);

    setState(() {
      isConnected = true;
      connectionStatus = 'Connected to Firestore!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test - Firestore User Creation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(connectionStatus),
            ElevatedButton(
              onPressed: () {
                addUserToFirestore();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('User added to Firestore!'),
                  ),
                );
              },
              child: const Text('Add User'),
            ),
          ],
        ),
      ),
    );
  }
}
