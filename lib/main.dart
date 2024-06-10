import 'package:attendy_/authentication/first_page.dart';
import 'package:attendy_/authentication/login.dart';
import 'package:attendy_/authentication/signup.dart';
import 'package:attendy_/professor/classes.dart';
import 'package:attendy_/professor/create_code.dart';
import 'package:attendy_/professor/j_absence.dart';
import 'package:attendy_/professor/setting.dart';
import 'package:attendy_/professor/student_attendance.dart';
import 'package:attendy_/screens/notes.dart';
import 'package:attendy_/screens/notification.dart';
import 'package:attendy_/professor/home.dart';
import 'package:attendy_/professor/student_information.dart';
import 'package:attendy_/screens/shedule.dart';
import 'package:attendy_/screens/profile.dart';
import 'package:attendy_/student/home.dart';
import 'package:attendy_/student/setting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import '/firebase_options.dart';

late bool is_login;
late String account_type;




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var user = FirebaseAuth.instance.currentUser;
  is_login = (user != null);
   bool trouve = false;
   await FirebaseFirestore.instance
  .collection('Student')
  .where('email' , isEqualTo: '${FirebaseAuth.instance.currentUser?.email}')
  .get()
  .then((value) {
    value.docs.forEach((element) { 
      account_type = 'Student';
      trouve = true;
    });
  });
  if (!trouve) {
    await FirebaseFirestore.instance
    .collection('teacher')
    .where('email' , isEqualTo: '${FirebaseAuth.instance.currentUser?.email}')
    .get()
    .then((value) {
      value.docs.forEach((element) {
      account_type = 'teacher';
      });
    });
  }

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'attendy',
      theme: ThemeData(
        useMaterial3: true,
      ),
      // home: (!is_login) ? const WelcomePage() :
      // (account_type == 'Student') ? const Home_student() : const Home_prof(),
      // home: Absence(student_name: 'abahri_khalida', index: 0,),
      // home: Student_information(student_name: '',),
      home: Home_prof(),
      routes: {
        '/login/' : (context) => const Login(),
        '/student_attendance/' : (context) => Student_attendance(),
        '/create_qr_code/' : (context) => const Create_qrCode(),
        '/note/' : (context) => Notes(),
        '/setting_prof/' : (context) => const Setting_prof(),
        '/setting_student/' : (context) => const Setting_student(),
        '/classes/' : (context) => const Classes(),
        '/signup/' : (context) => const Signup(),
        '/notification/' : (context) => NotificationPage(),
        '/home_prof/' : (context) => const Home_prof(),
        '/home_student/' : (context) => const Home_student(),
        '/shedule/' : (context) => const Shedule(),
        '/profile/' : (context) => const Profil(),
        '/welcome_page/' : (context) => const WelcomePage(),
      },
    )
  );
}
