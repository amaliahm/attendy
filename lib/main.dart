import 'package:attendy_/authentication/login.dart';
import 'package:attendy_/notification.dart';
import 'package:attendy_/professor/home.dart';
import 'package:attendy_/professor/shedule.dart';
import 'package:attendy_/student/shedule.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import '/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'attendy',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: NotificationPage(),
    )
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
