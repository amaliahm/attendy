import 'dart:async';
import 'dart:math';

import 'package:attendy_/sql_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:sqflite/sqflite.dart';


class Create_qrCode extends StatefulWidget {
  const Create_qrCode({super.key});

  @override
  State<Create_qrCode> createState() => _Create_qrCodeState();
}

class _Create_qrCodeState extends State<Create_qrCode> {
  late Timer _timer;
  String _qrCodeData = "qrCode";
  late bool stop = true;
  TextEditingController editingController =
  TextEditingController(text: 'ListTech');
  String? data;
  late String la_date;
  String td_or_cours = "TD";
  String start = "08:00";
  String end = "10:00";
  String classe = "_g6_analyse_2cp_1";
  Sql_database sql_database = Sql_database();

  Future<bool> column_exist(String table_name , String column_name) async {
    final Database database = await openDatabase('attendy.db');
    final List<Map<String,dynamic>> column = await database.rawQuery('PRAGMA table_info($table_name)');
    return column.any((element) => element['name'] == column_name);
  }

  
  set_password(String password) async {
    final querySnapshot = await FirebaseFirestore.instance
    .collection('teacher')
    .where('email' , isEqualTo: '${FirebaseAuth.instance.currentUser?.email}')
    .get();
    final _password = querySnapshot.docs.first;
    final my_password = _password.data()['password'] + ' ' + password;
      await _password.reference.update({
        'password' : my_password,
      });
  }


  reset_password() async {
    final querySnapshot = await FirebaseFirestore.instance
    .collection('teacher')
    .where('email' , isEqualTo: '${FirebaseAuth.instance.currentUser?.email}')
    .get();
    final _password = querySnapshot.docs.first;
      await _password.reference.update({
        'password' : '',
      });
  }


  

  @override
  void initState() {
  la_date =  DateTime.now().day.toString() +  '_' + DateTime.now().month.toString() + '_' + DateTime.now().year.toString() ;
  la_date = 'seance_'+la_date.toString();
    super.initState();
      _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
        String? email = FirebaseAuth.instance.currentUser!.email;
        if (!stop) {
          setState(() {
            _qrCodeData = generateRandomCode(la_date ,td_or_cours,start,end , classe,email!);
            print("$_qrCodeData --------- seconds ${DateTime.now().second}");
            set_password(_qrCodeData);
          });
        }
      });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  

  
  set_student() async {
    final querySnapshot = await FirebaseFirestore.instance
    .collection('teacher')
    .where('email' , isEqualTo: '${FirebaseAuth.instance.currentUser?.email}')
    .get();
    final students = querySnapshot.docs.first;
    final student = students.data()['student'].toString().split(' ');
    await students.reference.update({
      'student' : '',
    });
    final table_name = querySnapshot.docs.first.data()['password'].toString().split("//")[5];
    print("############### $student");
    print("############### $table_name");
    print("############### $la_date");
    for (int i = 0 ; i< student.length ; i++ ) {
      final database = await openDatabase( join( await getDatabasesPath() , "attendy.db"),);
      await database.rawUpdate("UPDATE $table_name SET '$la_date' = ? WHERE student_name = ?",[ 'p' ,student[i]]);
    }
    var show = await sql_database.read_data("SELECT * FROM '$table_name'");
    print("######################## $show");
    show = await sql_database.read_data("SELECT * FROM 'classes'");
    print("######################## $show");
  }

  String generateRandomCode(String date , String tdOrCours , String start , String end, String classe, String email) {
    return '//'+date+'//'+tdOrCours+'//'+start+'//'+end+'//'+classe+'//'+email+'//'+generateRandomString(10);
  }
  String generateRandomString(int len) {
    var x = Random();
    const name = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => name[x.nextInt(name.length)]).join();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Create code"),
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(0, 36, 107, 1),
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/shedule/',
                  (route) => false,
                );
              },
              icon: const Icon(
                Icons.chevron_left,
                color: Color.fromRGBO(173, 173, 173, 1),
                size: 45,
              ),
            ),
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
      Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/qr_code/qr_code.jpg"),
                fit: BoxFit.cover)),
      ),
      Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top:75),
            child: Text("Lesson informations",style:TextStyle(
              color:Color.fromRGBO(0, 36, 107, 1) ,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),),
          ),
          DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(21),
            strokeWidth: 2,
            borderPadding: const EdgeInsets.all(2),
            dashPattern: const [0,0,5,3],
            color:const Color.fromRGBO(0, 36, 107, 1),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 1),
                  width: 350,
                  height: 225,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(217, 217, 217, 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 22, left: 20),
                        child: Row(
                          children:[
                            const Icon(
                              Icons.calendar_month_outlined, color:Color.fromRGBO(0, 36, 107, 1),size: 40),
                            Padding(
                              padding: const EdgeInsets.only(left: 5,right: 20),
                              child: Text(
                                la_date,
                                style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),),
                            ),
                            const Icon(
                              Icons.school_outlined, color:Color.fromRGBO(0, 36, 107, 1),size: 40),
                            const Padding(
                              padding: EdgeInsets.only(left:6),
                              child: Text(
                                'TD',style:TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20, left: 20),
                        child: Row(
                          children:[
                            Padding(
                              padding: EdgeInsets.only(left: 60,right: 30),
                              child: Text('From',style:TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left:90),
                              child: Text('to',style:TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only( left: 15),
                        child:
                            Text('------->',style: TextStyle(
                              fontSize: 25
                            ),)
                        ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          children:[
                            Padding(
                              padding: const EdgeInsets.only(left: 60,right: 30),
                              child: Text(
                                '$start AM',
                                style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:70),
                              child: Text(
                                '$end AM',
                                style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            const Icon(
                              Icons.calendar_month_outlined,
                              color:Color.fromRGBO(0, 36, 107, 1),
                              size: 40,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5,right: 20),
                              child: Text(
                                '$classe ',
                                style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top : 8),
            child: QrImageView(
              data: _qrCodeData,
              backgroundColor: const Color.fromRGBO(217, 217, 217, 1),
              version: QrVersions.auto,
              size: 300,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RawMaterialButton(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    fillColor: const Color.fromRGBO(0, 36, 107, 1),
                    child: const Text(
                      'Generate/stop',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        )),
                    onPressed: () async {
                        bool column = await column_exist(classe, la_date);
                        if(!column) {
                          sql_database.addColumn(classe , la_date);
                        } 
                      setState(() {
                        stop = !stop;
                      });
                      if (stop) {
                        set_student();
                        reset_password();
                      }
                    }),
                RawMaterialButton(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Color.fromRGBO(0, 36, 107, 1),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 16),
                    fillColor: Colors.white,
                    child: const Text('Check Attendance ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color.fromRGBO(0, 36, 107, 1),
                        )),
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        '/student_attendance/',
                        (route) => false,
                      );
                    }),
              ],
            ),
          ),
        ],
      ),
    ]),
      ),
    );
  }
}
