import 'package:attendy_/professor/j_absence.dart';
import 'package:attendy_/sql_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:dotted_border/dotted_border.dart';
import 'dart:math';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class CircleProgress extends CustomPainter{



  final double Strokecircle = 7.0 ;
  double progress ;
  double total;
  String text ;
  int color;
  CircleProgress(this.progress,this.total,this.text,this.color) ;
  @override
  void paint(Canvas canvas, Size size) {
    Paint circle = Paint() 
     ..color = Color.fromARGB(255, 243, 243, 235) 
     ..style = PaintingStyle.fill ;
     Offset center = Offset(size.width/2, size.height/2) ;
     double radius = 90 ;
     canvas.drawCircle(center, radius, circle) ; 
//
    Paint arc = Paint() 
    ..strokeWidth = Strokecircle
    ..color = Color(color)
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round ;
    if (total == 0) {
      progress = 0;
      total = 1;
    }
    double angle = 2 * pi * (progress/total) ;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius-13), pi/2, angle, false, arc) ;
//
final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(fontSize: 25, color: Colors.black,fontFamily: 'Myfont',fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout();
    final textOffset = Offset(center.dx - textPainter.width / 2, center.dy - textPainter.height / 2);
    textPainter.paint(canvas, textOffset);

  }

 @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
      return true ;
  }

}


class Student_information extends StatefulWidget {
  
  final String student_name;
  final int index;

  Student_information({
    required this.index,
    required this.student_name,
    super.key,
  });

  @override
  State<Student_information> createState() => _Student_informationState();
}

class _Student_informationState extends State<Student_information> {
  
  final TextEditingController td_mark = TextEditingController();
  String la_note = '';
  bool visibility = false;
  String email = 'email';
  int star = 0;
  int presence = 0;
  int justify= 0;
  int absence = 0;
  get_email() async {
    await FirebaseFirestore.instance
    .collection('Student')
    .where('username' ,isEqualTo: widget.student_name)
    .get()
    .then((value) {
      email = value.docs.first.data()['email'];
    });
    setState(() {
      
    });
  }
  Sql_database sql_database = Sql_database();
  String table_name = '_g6_analyse_2cp_1';
  Future<List<Map<String,dynamic>>>? _dataFuture;
  List<String> seance = [];
  
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
    get_email();
    setState(() {
      
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Student information',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontFamily: "Myfont",
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: const  Color(0xFF00246B ),
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/student_attendance/',
                      (route) => false,
                    );
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 35,
                    color: Color(0xFFBFBFBF),
                  ),
                ),
          ),
        ),
            body:  Container(
              decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('images/student_information/background.jpg') ,
              fit: BoxFit.cover),) ,
              child:SingleChildScrollView(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: _dataFuture,
                  builder: (context , snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        height: 50,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color:  Color.fromRGBO(0, 36, 107, 1),
                          ),
                        ),
                      );
                    }  else {
                      star = 0;
                      presence = 0;
                      final data = snapshot.data!;
                      for (int i = 0 ; i < seance.length ; i++ ) {
                        if (data[widget.index][seance[i]] != null) {
                          if (data[widget.index][seance[i]] == 'p') {
                            presence += 1;
                          } else {
                            justify += 1;
                          }
                        }
                      }
                      star = data[widget.index]['star'];
                      la_note = data[widget.index]['TD'];
                      absence = seance.length - presence;
                      return 
                   Column(
                        children: 
                        [ 
                              const SizedBox(height: 67)   ,  
                              
                              DottedBorder(
                  strokeWidth: 2,
                  color:const  Color(0xFF00246B ),
                  
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(12),
                  child:Container(
                  width: 350, 
                  height: 160, 
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      colors: [Colors.white, Colors.grey.shade400],
                      stops: const [0.1 , 1],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: [
                        Padding(
                          padding: const EdgeInsets.all(22),
                          child: Row(children: [
                            const Icon(Icons.person_2_outlined , size: 27, color:Color(0xFF00246B ), ) ,
                            const SizedBox(width: 30),      
                            Text(widget.student_name.toString().toUpperCase().replaceAll('_', ' ') , maxLines: null, overflow: TextOverflow.clip, style:const TextStyle(color: Color(0xFF4F5054),fontSize: 18 , fontFamily: 'Consolas' ),),
                          ],),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(22),
                          child: Row(children: [
                            const Icon(Icons.mail , size: 27, color:Color(0xFF00246B ), ) ,
                           const SizedBox(width: 30),
                            Text(email , style: const TextStyle(color: Color(0xFF4F5054),fontSize: 18 , fontFamily: 'Consolas' ),),
                          ],),
                        )
                      ]),
                    ),
                    ),),
                    const SizedBox(
                      height: 25,
                    ),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: SingleChildScrollView(physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                         child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.min,
                  children: [
                  CircleAvatar(radius : 90 ,child: CustomPaint(foregroundPainter: CircleProgress(star.toDouble(),seance.length.toDouble(),'Additional\npoints \n$star/${seance.length}',0xFFF4CA41))),
                               const  SizedBox(width: 20),
                         CircleAvatar(radius : 90 ,child: CustomPaint(foregroundPainter: CircleProgress(presence.toDouble(),seance.length.toDouble(),'Attend\nin\n $presence/${seance.length}',0xFF00246B))),
                      const SizedBox(width: 20),
                         InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Absence(student_name: widget.student_name, index: widget.index,),
                              ),
                            );
                          },
                          child: CircleAvatar(radius : 90 ,child: CustomPaint(foregroundPainter: CircleProgress(justify.toDouble(),seance.length.toDouble(),'Absence\njustified \n $justify/$absence',0xFF7785FF)))),
                          ])
                        ),
                     ),
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                  radius: const Radius.circular(10),
                        color: const Color(0xFF00246B ),
                       strokeWidth: 2,
                        child: Container(
                        decoration: BoxDecoration(gradient:LinearGradient(
                      colors: [Colors.white, Colors.grey.shade300],
                      stops:const  [0.1 , 1],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ) ,
                    borderRadius: BorderRadius.circular(10)
                    ),
                    
                        width: 370,
                        height: 60,
                        child: const Row(children: [
                          SizedBox(width: 10),
                          Icon(Icons.draw , size: 35, color:Color(0xFF00246B ) ),
                          SizedBox(width: 15),
                          Text('Note' , style: TextStyle(fontFamily: 'Myfont', fontSize: 28, color:Color(0xFF00246B ),fontWeight: FontWeight.bold )),
                          
                              
                              
                        ],),
                              
                        
                        
                        
                        ),
                      ),
                    ),
                    Row(children: [
                         const SizedBox(width: 40),
                         const Text('  TD Mark' , style: TextStyle(fontFamily: 'Myfont', fontSize: 28, color:Color(0xFF00246B ),fontWeight: FontWeight.bold )),
                         const SizedBox(width: 20),
                         Container(
                          height: 56,
                          width: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(style: BorderStyle.solid,color:const  Color(0xFF00246B)),
                            color:const Color(0xFFD9D9D9),
                              
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                visibility = true;
                              });
                            },
                            child: visibility ?
                            TextField(
                              controller: td_mark,
                              enabled: visibility,
                            ) : Center(
                              child: Text(
                                (la_note == '0' || la_note == null) ? ' ' : la_note,
                                style: const TextStyle(fontFamily: 'Myfont', fontSize: 32, color:Color(0xFF00246B ),fontWeight: FontWeight.bold )
                              ),
                            ),
                          ),
                         )
                          ],) ,
                          Padding(
                            padding: const EdgeInsets.all(19),
                            child: Container(
                            height: 69,
                            width: 180,
                            decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  color:const Color(0xFFF4CA41)),
                  child: 
                  Center(child: InkWell(
                    onTap: () async {
                      setState(() {
                        visibility = false;
                      });
                      final database = await openDatabase( join( await getDatabasesPath() , "attendy.db"),);
                      await database.rawUpdate("UPDATE $table_name SET 'TD' = ? WHERE student_name = ?",[ td_mark.text ,widget.student_name]);
                      
                    },
                    child: Text('Save' , style: TextStyle(fontFamily: 'Myfont', fontSize: 28, color:Color(0xFF00246B ),fontWeight: FontWeight.bold ))
                  )),
                              
                  
                       ),
                          )
                          ]
                  );
                  
                    }
                  },
                ),
              ),
)));

        
         
       
          
        
          
     
      } 
      
    
      

    
  }

              
