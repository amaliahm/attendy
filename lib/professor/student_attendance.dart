import 'dart:ui';
import 'package:attendy_/professor/student_information.dart';
import 'package:attendy_/sql_data.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'j_absence.dart';

class Student_attendance extends StatefulWidget {
  @override
  State<Student_attendance> createState() => _Student_attendanceState();
}

class _Student_attendanceState extends State<Student_attendance> {

  String input2 = "";
  String input1 = "";
   

  List<bool> _isStarred = [];
  Sql_database sql_database = Sql_database();
  Future<List<Map<String,dynamic>>>? _dataFuture;
  String table_name = "_g6_analyse_2cp_1";
  late String la_date;
  @override
  void initState() {
  la_date =  DateTime.now().day.toString() +  '_' + DateTime.now().month.toString() + '_' + DateTime.now().year.toString() ;
  la_date = 'seance_'+la_date.toString();
    Sql_database().fetchData();
    super.initState();
    _dataFuture = Sql_database().display_table(table_name);
    read();
  }

  read() async  {
            var show = await sql_database.read_data("SELECT * FROM '$table_name'");
            print("######################## $show");
            show = await sql_database.read_data("SELECT * FROM 'classes'");
            print("######################## $show");
            
  }

  increment_star(int value , String student_name) async {
    final database = await openDatabase( join( await getDatabasesPath() , "attendy.db"),);
    await database.rawUpdate('UPDATE $table_name SET star = $value WHERE student_name = ?',[student_name],);
  }

  presence(String la_date , String student_name) async {
    final database = await openDatabase( join( await getDatabasesPath() , "attendy.db"),);
    await database.rawUpdate("UPDATE $table_name SET '$la_date' = ? WHERE student_name = ?",[ 'p' ,student_name]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/Student_attendance/student_attendance_back.jpg'),
                fit: BoxFit.cover)),
      ),
        Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.only(left: 15, top: 5),
              child:  Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios,
                    size: 35,
                    color: Color(0xFFBFBFBF),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        '/create_qr_code/',
                        (route) => false,
                      );
                    },
                  ),
                  const SizedBox(width: 59),
                  const Text(
                    'Attendance',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gadugi'),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            return
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
              children: [
                Container(
                  
                  decoration: BoxDecoration(
                    borderRadius:const BorderRadius.all(Radius.circular(10),),
                    border:  Border.all(
                      color: const Color(0xFF818388),
                    
                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.people_alt, color: Color(0xFF00246B),
                        ),
                        const SizedBox(width: 15,),
                        Text(
                          '${data.length}'+'/25',
                          style: const TextStyle(
                            color:Color(0xFF4F5054),
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
      ),)
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 25,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius:const  BorderRadius.all(Radius.circular(10),),
                    border: Border.all(
                      color: const Color(0xFF818388),
                    
                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        const Icon(Icons.school, color: Color(0xFF00246B),),
                        const SizedBox(width: 15,),
                        Text( '$table_name ', style: const TextStyle(color:Color(0xFF4F5054),
                        fontWeight: FontWeight.w700,
                        fontSize: 15
                        ),)
                            
                      ],
                    ),
                  ),
                )
              ],
            
              ),
            );
            } else {
            return const CircularProgressIndicator();
          }
        },
      ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Padding(
              padding: const EdgeInsets.fromLTRB(20,0,0,0),
                child: Row(
                  children: [
                    const Text('Student Attendance',
                    style: TextStyle(color:Color(0xFF00246B),
                            fontWeight: FontWeight.w700,
                            fontSize: 24)),
                            const SizedBox(width: 64,),
                            IconButton(
                              
                              onPressed: () {
                              showDialog(context: context, builder: (BuildContext context) {
                    return BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                      child: AlertDialog(
                        shadowColor: Colors.black,
                    
                      shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
                
                        side: BorderSide(
                      color: Colors.grey.withOpacity(0.2),
                      width: 1,
                        ) ),
                        title: Row(
                children: [
                  const SizedBox(width: 5,),
                  const Text('add student',
                  style: TextStyle(color: Color(0xFF00246B),
                  fontFamily: 'Gadugi'),
                  ),
                  const SizedBox(width: 60, ),
                  IconButton(onPressed: (){
                    Navigator.of(context).pop(false);
                  }, icon:
                  const Icon(Icons.close,
                  size: 25,
                  color: Color(0xFF4F5054),
                  )),
                  
                ],
                        ),
                        
                    contentPadding: const EdgeInsets.symmetric(vertical: 18.0),
                        content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Family name',
                        prefixIcon: Icon(Icons.person_outlined)
                      ),
                      onChanged: (  String value1){
                        setState(() {
                        input1 = value1;
                        });
                      }
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: TextField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person_outlined),
                        hintText: 'First name'
                      ),
                      onChanged: (  String value2){
                          setState(() {
                          input2 = value2;
                        });
                      }
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  
                  const SizedBox(
                    height: 25,
                  )
                  ,
                      ElevatedButton(
                        
                        style: ElevatedButton.styleFrom(
                        backgroundColor:const  Color(0xFFF4CA41)),
                        onPressed: () async {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            '/student_attendance/',
                            (route) => false,
                          );
                          String student_name = input1.toLowerCase()+'_'+input2.toLowerCase();
                          sql_database.add_student(student_name ,table_name );
                      
                      }, child: const Text('Save',style: TextStyle(color: Colors.white,fontFamily: 'Gadugi'),)
                      
                      )
                ],
                        ),
                        
                      ),
                    );
                  } 
                  );
                  }, icon: const Icon(Icons.add_circle),
                  color:const Color(0xFF00246B) ,)
                  ],
                ),
              ),
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            return
            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  _isStarred.add(false);
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                    color: const Color.fromARGB(255, 105, 104, 104)
                                        .withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: const Offset(1, 2),
                                    blurStyle: BlurStyle.outer)
                              ],
                            ),
                            child: ListTile(
                              leading: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF7785FF),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset:const Offset(0, 3),
                                    )
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    data[index]['student_name'][0],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              title: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => Student_information(student_name: data[index]['student_name'].toString(), index: index,),
                                            ),
                                        );
                                        });
                                      },
                                      child: Text(
                                        data[index]['student_name'].toString().toUpperCase().replaceAll('_', ' '),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Gadugi'),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 0,
                                  ),
                                ],
                              ),
                              trailing: Transform.translate(
                                offset: const Offset(14, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if (data[index][la_date] == null) {
                                          
                                        Navigator.of(context).pushNamedAndRemoveUntil(
                                          '/student_attendance/',
                                          (route) => false,
                                        );
                                        presence(la_date, data[index]['student_name']);
                                        
                                        }
                                      },
                                      child: Text(
                                        (data[index][la_date] == 'p') ? 'P' :
                                        (data[index][la_date] == 'j') ? 'J' : 'A',
                                        style: const TextStyle(
                                            color: Color(0xFF00246B),
                                            fontSize: 30,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Gadugi',
                                          ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    IconButton(
                                        icon: Icon(
                                          Icons.star,
                                          color:
                                          (_isStarred[index])
                                              ? Colors.yellow:
                                              const Color(0xFFA8A0A0),
                                          size: 30,
                                        ),
                                        onPressed: () async {
                                          setState(() {
                                            _isStarred[index] = !_isStarred[index];
                                          });
                                            int value = data[index]['star'] +1;
                                            await increment_star(value , data[index]['student_name']);
                                            //await database.execute(' UPDATE $table_name SET star = $value WHERE student_name = ${data[index]['student_name']}');
                                          
                                        }),
                                  ],
                                ),
                              ),
                            )),
                        const SizedBox(
                          height: 5,
                        )
                      ],
                    ),
                  );
                },
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        }
            )
          ],
        
        ),

    ]));
  }
}

class attendanceData {
  final String familyname;
  final String firstname;
  attendanceData(
      {
      required this.familyname,
      required this.firstname,
      });
}
