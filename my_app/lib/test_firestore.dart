import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'resources/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    const MaterialApp(
      home: FirestoreConnectionTest(),
    ),
  );
}

class FirestoreConnectionTest extends StatefulWidget {
  const FirestoreConnectionTest({super.key});

  @override
  _FirestoreConnectionTestState createState() =>
      _FirestoreConnectionTestState();
}

class _FirestoreConnectionTestState extends State<FirestoreConnectionTest> {
  bool isConnected = false;

  void addUserToFirestore() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      // Create a reference to the "users" collection
      CollectionReference usersCollection = firestore.collection('users');

      // Data to be added to the document
      Map<String, dynamic> userData = {
        'name': 'John Doe',
        'email': 'johndoe@example.com',
      };

      // Add the new document to the "users" collection
      DocumentReference newDocument = await usersCollection.add(userData);
      print('Document added with ID: ${newDocument.id}');
    } catch (e) {
      print("Error connecting to Firestore: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore Connection Test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (isConnected)
              const Text(
                'Connected to Firestore!',
                style: TextStyle(fontSize: 20),
              )
            else
              ElevatedButton(
                onPressed: addUserToFirestore,
                child: const Text('Test Connection'),
              ),
          ],
        ),
      ),
    );
  }
}
