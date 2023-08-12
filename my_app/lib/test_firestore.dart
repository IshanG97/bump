import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'resources/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MaterialApp(
      home: FirestoreConnectionTest(),
    ),
  );
}

class FirestoreConnectionTest extends StatefulWidget {
  @override
  _FirestoreConnectionTestState createState() =>
      _FirestoreConnectionTestState();
}

class _FirestoreConnectionTestState extends State<FirestoreConnectionTest> {
  bool isConnected = false;

  void testFirestoreConnection() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot snapshot =
          await firestore.collection("users").limit(1).get();

      if (snapshot.docs.isNotEmpty) {
        setState(() {
          isConnected = true;
        });
      }
    } catch (e) {
      print("Error connecting to Firestore: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore Connection Test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (isConnected)
              Text(
                'Connected to Firestore!',
                style: TextStyle(fontSize: 20),
              )
            else
              ElevatedButton(
                onPressed: testFirestoreConnection,
                child: Text('Test Connection'),
              ),
          ],
        ),
      ),
    );
  }
}
