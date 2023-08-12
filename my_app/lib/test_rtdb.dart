import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'resources/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    const MaterialApp(
      home: RealtimeDatabaseConnectionTest(),
    ),
  );
}

class RealtimeDatabaseConnectionTest extends StatefulWidget {
  const RealtimeDatabaseConnectionTest({Key? key}) : super(key: key);

  @override
  _RealtimeDatabaseConnectionTestState createState() =>
      _RealtimeDatabaseConnectionTestState();
}

class _RealtimeDatabaseConnectionTestState
    extends State<RealtimeDatabaseConnectionTest> {
  bool isConnected = false;

  void testRealtimeDatabaseConnection() async {
    try {
      DatabaseReference reference = FirebaseDatabase.instance.ref();

      DatabaseEvent snapshot = await reference.child("test").once();

      if (snapshot.snapshot.value != null) {
        setState(() {
          isConnected = true;
        });
      }
    } catch (e) {
      print("Error connecting to Realtime Database: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Realtime Database Connection Test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (isConnected)
              const Text(
                'Connected to Realtime Database!',
                style: TextStyle(fontSize: 20),
              )
            else
              ElevatedButton(
                onPressed: testRealtimeDatabaseConnection,
                child: const Text('Test Connection'),
              ),
          ],
        ),
      ),
    );
  }
}
