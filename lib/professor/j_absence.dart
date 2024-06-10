import 'package:attendy_/professor/student_information.dart';
import 'package:attendy_/sql_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';



class Absence extends StatefulWidget {
  final String student_name;
  final int index;
  Absence({
    required this.index,
    required this.student_name,
    super.key
  });

  @override
  State<Absence> createState() => _AbsenceState();
}

class _AbsenceState extends State<Absence> {
  Future<List<Map<String,dynamic>>>? _dataFuture;
  String table_name = '_g6_analyse_2cp_1';
  List<String> seance = [];
  List<int> _absence = [];
  List<bool> justify = [];
  Sql_database sql_database = Sql_database();
  
  read() async  {
            var show = await sql_database.read_data("SELECT * FROM '$table_name'");
            print("######################## $show");
            show = await sql_database.read_data("SELECT * FROM 'classes'");
            print("######################## $show");
  }
  get_seance() async {
    final querySnapshot = await FirebaseFirestore.instance
    .collection('teacher')
    .where('email', isEqualTo: '${FirebaseAuth.instance.currentUser?.email}')
    .get();
    final data = querySnapshot.docs.first.data()['seance'].toString().split(' ');
    for (int i = 0 ; i < data.length ; i++) {
      if (data[i].contains(table_name)) {
        seance.add(data[i].split('/')[1]);
      }
    }
    setState(() {
      
    });
  }

  

  @override
  void initState() {
    Sql_database().fetchData();
    _dataFuture = Sql_database().display_table(table_name);
    super.initState();
    get_seance();
    read();
    setState(() {
      
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
          children:[
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/j_absence/j_absence_back.jpg'),
                    fit: BoxFit.cover)),
          )
          ,
      Column(
        children: [
          const SizedBox(height: 10,),
          Container(
            padding: const EdgeInsets.all(20) ,
            child:Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Student_information(student_name: widget.student_name.toString(), index: widget.index,),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios ,
                    size: 35,
                    color: Color(0xFFBFBFBF),
                  ),
                ),
              const SizedBox(width: 59) ,
              const Text(
                'Absence List',
                 style: TextStyle(
                  color: Colors.white,
                  fontSize: 30 ,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Myfont',
                ),
              )
             ],
            ),
         ),
        const SizedBox(height: 50,), 
        FutureBuilder<List<Map<String, dynamic>>>(
          future: _dataFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data!;
              _absence = [];
              for (int i = 0 ; i < seance.length ; i++ ) {
                if (data[widget.index][seance[i]] == null) {
                  _absence.add(i);
                  justify.add(false);
                }
              }
              if (_absence.length == 0) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "${widget.student_name.toUpperCase().replaceAll('_', ' ')} \n haven't any absence",
                        style:const TextStyle(fontSize: 22,color:Color(0xFF4F5054), fontFamily: 'Gadugi' ), 
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                  ],
                );
              } else {
                return Container(
                  height: 200,
                  child: Column(
                    children:[
                      const Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'N°',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold , fontFamily: 'Myfont'),
                        ),
                        SizedBox(
                          width: 55,
                        ),
                        Text(
                          'Date',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold , fontFamily: 'Myfont'),
                        ),
                        SizedBox(
                          width: 155,
                        ),
                        Text(
                          'Justified',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold , fontFamily: 'Myfont'),
                        ),
                      ],
                    ),
                     Expanded(
                       child: ListView.builder(
                          itemCount: _absence.length ,
                          itemBuilder: (context, index) {
                            return Column(
                              children:[
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 13,
                                      ),
                                      Text(
                                        '${index + 1}',
                                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold , fontFamily: 'Myfont'),
                                      ),
                                      const SizedBox(
                                        width: 50,
                                      ),
                                      Text(
                                        seance[index].replaceAll('_', ' ').substring('seance'.length),
                                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold , fontFamily: 'Myfont'),
                                      ),
                                      const SizedBox(
                                        width: 140,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          setState(() {
                                            justify[index] = true;
                                          });
                                            print("************ ${seance[index]}");
                                            final database = await openDatabase( join( await getDatabasesPath() , "attendy.db"),);
                                            await database.rawUpdate("UPDATE $table_name SET '${seance[index]}' = ? WHERE student_name = ?",[ 'j' ,widget.student_name]);
                                        },
                                        child: Icon(justify[index] ? Icons.check_box : Icons.check_box_outline_blank),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  thickness: 1,
                                  color: Colors.grey[300],
                                  height: 0,
                                ),
                                
                              ]
                            );
                            }
                        
                        ),
                     ),
                      
        ]
      ),
                );
              }
            } else {
              return const CircularProgressIndicator();
            }
          }
        ),
        ]
      ),
                    
                  
                
          ]
      )
      );
        
              }
            } 
          
        
      
    
  





