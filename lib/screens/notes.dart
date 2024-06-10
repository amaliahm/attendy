import 'dart:ui';

import 'package:attendy_/sql_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Notes extends StatefulWidget {
  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
   String input2 = ",";
String account_type = ' account type ';
String? note ;
List<bool> notification = [];
List<String> data = [];
   
 String input1 = "";
 Sql_database sql_database = Sql_database();
 Future<List<Map<String,dynamic>>>? _dataFuture;

 
  get_data() async  {
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
  }

  delete_note(String note) async {
    bool trouve = false;
   var querySnapshot = await FirebaseFirestore.instance
  .collection('Student')
  .where('email' , isEqualTo: '${FirebaseAuth.instance.currentUser?.email}')
  .get();
  if (querySnapshot.size != 0) {
    var value = querySnapshot.docs.first;
    var _note = value.data()['note'].toString();
    if (_note.contains(note)) {
      _note = _note.substring(note.length);
      await value.reference.update({
        'note' : _note,
      });
    }
    } else{
    querySnapshot = await FirebaseFirestore.instance
    .collection('teacher')
    .where('email' , isEqualTo: '${FirebaseAuth.instance.currentUser?.email}')
    .get();
    var value = querySnapshot.docs.first;
    var _note = value.data()['note'].toString();
    if (_note.contains(note)) {
      _note = _note.substring(note.length );
      await value.reference.update({
        'note' : _note,
      });
    }
    
  }
  }

  


  @override
  void initState() {
    _dataFuture = Sql_database().display_table('Notes');
    get_data();
    delete_note('');
    super.initState();
  }

   
     
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/Notes/note_back.jpg'),
                    fit: BoxFit.cover)),
          ),
          Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(30),
                child: Row(
                  children: [
                    GestureDetector(
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 35,
                        color: Color(0xFFBFBFBF),
                      ),
                      onTap: () {
                        if (account_type == "Student") {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            '/home_student/',
                            (route) => false,
                           );
                        } 
                         if (account_type == 'teacher') {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            '/home_prof/',
                            (route) => false,
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      width: 99,
                    ),
                    const Text(
                      'Notes',
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
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(
                      color:  Color.fromRGBO(0, 36, 107, 1),
                    );
                  } else {
                    if (!snapshot.hasData || snapshot.data!.length == 0) {
                      return Column(
                        children: [
                        const SizedBox(
                          height: 0,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "You don't have any Notes",
                            style: TextStyle(
                              fontSize: 22,
                              color: Color(0xFF4F5054),
                              fontFamily: 'Gadugi',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        const Text(
                          'Add new note ! ',
                          style: TextStyle(
                            fontSize: 25,
                            color: Color(0xFF4F5054),
                            fontFamily: 'Gadugi',
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        Image.asset('images/Notes/no_note_back.jpg'),
                      ],
                      );
                    } else {
                      final data = snapshot.data!;
                      notification = [];
                      print("********* $data");
                      return Expanded(
                        child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context , index) {
                            notification.add(false);
                            print("********* $notification");
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 3,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          spreadRadius: 12,
                                          blurRadius: 7,
                                          offset: const Offset(0, 3),
                                        ),
                                      ]
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        data[index]['note'],
                                        style: const TextStyle(
                                          color: Color(0xFF00246B),
                                          fontSize: 25,
                                        ),
                                      ),
                                      subtitle: Text(
                                        data[index]['comment'],
                                      ),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.notifications_active),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.delete),
                                            onPressed: () async {
                                              int result = await sql_database.delete_data("DELETE FROM Notes WHERE note = '${data[index]['note']}' ");
                                              Navigator.of(context).pushNamedAndRemoveUntil(
                                                '/note/',
                                                (route) => false,
                                              );
                                              setState(() {
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
  backgroundColor:const Color(0xFF00246B) ,
  child: const Icon(Icons.add,
  color: Colors.white,),
  onPressed: (){
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
              const SizedBox(width: 60,),
              const Text('Add note',
              style: TextStyle(color: Color(0xFF00246B),
              fontFamily: 'Gadugi'),
              ),
              const SizedBox(width: 40,),
              IconButton(onPressed: (){
                Navigator.of(context).pop();
              }, icon: 
              const Icon(Icons.close,
              size: 25,
              color: Color(0xFF4F5054),
              ))
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
                    hintText: 'Note',
                     prefixIcon: Icon(Icons.note_alt_outlined)
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
                    prefixIcon: Icon(Icons.comment_outlined),
                    hintText: 'Comment'
                  ),
                  onChanged: (  String value2){
                      setState(() {
                      input2 = value2;
                    });
                  }
                ),
              ),
             const SizedBox(
      height: 25,
             )
              ,
         ElevatedButton(
          style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF4CA41)),
          onPressed: () async {
          setState(() {
          });
          sql_database.create_note();
          int result = await sql_database.insert("INSERT INTO Notes (note , comment ) VALUES ('$input1' , '$input2');");
          Navigator.of( context).pushNamedAndRemoveUntil(
            '/note/',
            (route) => false,
          );
        
         }, child: const Text('Save',style: TextStyle(color: Colors.white,fontFamily: 'Gadugi'),)
         
         )
            
                       
            ],
          ),
          
        ),
      );
    } 
    
    ); 
  }),
    );
  }




}
class NoteData {
  
  final String name;
  final String note;

  NoteData({
    
    required this.name,
    required this.note,
  }
  )
  ;
}
