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

  List<String> users = [];

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

  Future<void> readUsersFromFirestore() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    // Create a new user with a first and last name
    await db.collection("users").get().then((event) {
      users.clear();
      for (var doc in event.docs) {
        users.add("${doc.id} => ${doc.data()}");
      }
      setState(() {});
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
            ElevatedButton(
              onPressed: () {
                readUsersFromFirestore();
              },
              child: const Text('List Users'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return Text(users[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
