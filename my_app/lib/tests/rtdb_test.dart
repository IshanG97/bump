import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import '../resources/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    const MaterialApp(
      home: RealTimeDatabaseTest(),
    ),
  );
}

class RealTimeDatabaseTest extends StatefulWidget {
  const RealTimeDatabaseTest({super.key});

  @override
  _RealTimeDatabaseTestState createState() => _RealTimeDatabaseTestState();
}

class _RealTimeDatabaseTestState extends State<RealTimeDatabaseTest> {
  bool isConnected = false;
  String connectionStatus = 'Waiting to connect...';

  late DatabaseReference dbRef;

  Future<void> addUserToRealtimeDatabase() async {
    dbRef = FirebaseDatabase.instance.ref('users');

    // Create a new user with a first and last name
    final user = {"first": "Ada", "last": "Lovelace", "born": 1815};

    // Add the new user to the database - NOTE: INCOMPLETE
    //await dbRef.child(user['first'].concat(user['last'])).set(user);

    setState(() {
      isConnected = true;
      connectionStatus = 'Connected to Realtime Database!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test - Realtime Database User Creation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(connectionStatus),
            ElevatedButton(
              onPressed: () {
                addUserToRealtimeDatabase();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('User added to Realtime Database!'),
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
