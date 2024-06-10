import 'dart:ffi';
import 'dart:ui';
import 'package:attendy_/professor/home.dart';
import 'package:attendy_/sql_data.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Classes extends StatefulWidget {
  const Classes({Key? key}) : super(key: key);

  @override
  State<Classes> createState() => _ClassesState();
}


class _ClassesState extends State<Classes> {

  Sql_database sql_data = Sql_database();
  
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();








  // IconButton(
  //             onPressed: () {
  //               showDialog(context: context, builder: (BuildContext context) {
  //                 return BackdropFilter(
  //                   filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
  //                   child: AlertDialog(
  //                     shadowColor: Colors.black,

  //                     shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(16.0),

  //                         side: BorderSide(
  //                           color: Colors.grey.withOpacity(0.2),
  //                           width: 1,
  //                         ) ),
  //                     title: Row(
  //                       children: [
  //                         const SizedBox(width: 0,),
  //                         const Text('Lesson informations',
  //                           style: TextStyle(color: Color(0xFF00246B),
  //                               fontFamily: 'Gadugi'),
  //                         ),
  //                         const SizedBox(width: 8,),
  //                         IconButton(onPressed: (){
  //                           Navigator.of(context).pop();
  //                         }, icon:
  //                         const Icon(Icons.close,
  //                           size: 25,
  //                           color: Color(0xFF4F5054),
  //                         ))

  //                       ],
  //                     ),
  //                     contentPadding: const EdgeInsets.symmetric(vertical: 18.0),
  //                     content: Column(
  //                       mainAxisSize: MainAxisSize.min,
  //                       children: [
  //                         Padding(
  //                           padding: const EdgeInsets.symmetric(horizontal: 25),
  //                           child: TextField(
  //                               decoration: const InputDecoration(
  //                                   hintText: 'Group name',
  //                                   prefixIcon: Icon(Icons.note_alt_outlined)
  //                               ),
  //                               onChanged: (  String value1){
  //                                 setState(() {
  //                                   input1 = value1;
  //                                 });

  //                               }
  //                           ),
  //                         ),
  //                         const SizedBox(
  //                           height: 10,
  //                         ),
  //                         Padding(
  //                           padding: const EdgeInsets.symmetric(horizontal: 25),
  //                           child: TextField(
  //                               decoration: const InputDecoration(
  //                                   prefixIcon: Icon(Icons.comment_outlined),
  //                                   hintText: 'module'
  //                               ),
  //                               onChanged: (  String value2){
  //                                 setState(() {
  //                                   input2 = value2;
  //                                 });
  //                               }
  //                           ),
  //                         ),

  // const SizedBox(
  //                           height: 10,
  //                         ),
  //                         Padding(
  //                           padding: const EdgeInsets.symmetric(horizontal: 25),
  //                           child: TextField(
  //                               decoration: const InputDecoration(
  //                                   prefixIcon: Icon(Icons.comment_outlined),
  //                                   hintText: 'year'
  //                               ),
  //                               onChanged: (  String value2){
  //                                 setState(() {
  //                                   input2 = value2;
  //                                 });
  //                               }
  //                           ),
  //                         ),
  //                         const SizedBox(
  //                           height: 10,
  //                         ),
  //                         Padding(
  //                           padding: const EdgeInsets.symmetric(horizontal: 25),
  //                           child: TextField(
  //                               decoration: const InputDecoration(
  //                                   prefixIcon: Icon(Icons.comment_outlined),
  //                                   hintText: 'Salle'
  //                               ),
  //                               onChanged: (  String value2){
  //                                 setState(() {
  //                                   input2 = value2;
  //                                 });
  //                               }
  //                           ),
  //                         ),
  //                         Padding(
  //                           padding: const EdgeInsets.only(top:20,left: 50,right: 50),
  //                           child: Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             children: const [
  //                               Text('From       ------>       to',
  //                                 style: TextStyle(color: Color(0xFF00246B),
  //                                     fontFamily: 'Gadugi'),
  //                               ),
  //                           ],),
  //                         ),
  //                         Padding(
  //                           padding: const EdgeInsets.only(top: 20),
  //                           child: ElevatedButton(

  //                               style: ElevatedButton.styleFrom(
  //                                   backgroundColor: const Color(0xFFF4CA41)),
  //                               onPressed: (){
  //                                 setState(() {
  //                                   Notes.add(NoteData(name: input1, note: input2));
  //                                 }
  //                                 );
  //                                 Navigator.of( context).pop();

  //                               },
  //                               child: const Text('Save',style: TextStyle(color: Colors.white,fontFamily: 'Gadugi'),)

  //                           ),
  //                         )


  //                       ],
  //                     ),

  //                   ),
  //                 );
  //               }

  //               );
  //             },
  //             icon: const Icon(
  //               Icons.add_circle,
  //               color: Color.fromRGBO(0, 36, 107, 1),
  //               size: 35,
  //             ),
  //           ),
// onPressed: () {
//                 showDialog(context: context, builder: (BuildContext context) {
//                   return BackdropFilter(
//                     filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
//                     child: AlertDialog(
//                       shadowColor: Colors.black,

//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(16.0),

//                           side: BorderSide(
//                             color: Colors.grey.withOpacity(0.2),
//                             width: 1,
//                           ) ),
//                       title: Row(
//                         children: [
//                           const SizedBox(width: 0,),
//                           const Text('Lesson informations',
//                             style: TextStyle(color: Color(0xFF00246B),
//                                 fontFamily: 'Gadugi'),
//                           ),
//                           const SizedBox(width: 8,),
//                           IconButton(onPressed: (){
//                             Navigator.of(context).pop();
//                           }, icon:
//                           const Icon(Icons.close,
//                             size: 25,
//                             color: Color(0xFF4F5054),
//                           ))

//                         ],
//                       ),
//                       contentPadding: const EdgeInsets.symmetric(vertical: 18.0),
//                       content: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 25),
//                             child: TextField(
//                                 decoration: const InputDecoration(
//                                     hintText: 'Group name',
//                                     prefixIcon: Icon(Icons.note_alt_outlined)
//                                 ),
//                                 onChanged: (  String value1){
//                                   setState(() {
//                                     input1 = value1;
//                                   });

//                                 }
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 25),
//                             child: TextField(
//                                 decoration: const InputDecoration(
//                                     prefixIcon: Icon(Icons.comment_outlined),
//                                     hintText: 'module'
//                                 ),
//                                 onChanged: (  String value2){
//                                   setState(() {
//                                     input2 = value2;
//                                   });
//                                 }
//                             ),
//                           ),
// const SizedBox(
//                             height: 10,
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 25),
//                             child: TextField(
//                                 decoration: const InputDecoration(
//                                     prefixIcon: Icon(Icons.comment_outlined),
//                                     hintText: 'year'
//                                 ),
//                                 onChanged: (  String value2){
//                                   setState(() {
//                                     input2 = value2;
//                                   });
//                                 }
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 25),
//                             child: TextField(
//                                 decoration: const InputDecoration(
//                                     prefixIcon: Icon(Icons.comment_outlined),
//                                     hintText: 'Salle'
//                                 ),
//                                 onChanged: (  String value2){
//                                   setState(() {
//                                     input2 = value2;
//                                   });
//                                 }
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(top:20,left: 50,right: 50),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: const [
//                                 Text('From       ------>       to',
//                                   style: TextStyle(color: Color(0xFF00246B),
//                                       fontFamily: 'Gadugi'),
//                                 ),
//                             ],),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 20),
//                             child: ElevatedButton(

//                                 style: ElevatedButton.styleFrom(
//                                     backgroundColor: const Color(0xFFF4CA41)),
//                                 onPressed: (){
//                                   setState(() {
//                                     Notes.add(NoteData(name: input1, note: input2));
//                                   }
//                                   );
//                                   Navigator.of( context).pop();

//                                 },
//                                 child: const Text('Save',style: TextStyle(color: Colors.white,fontFamily: 'Gadugi'),)

//                             ),
//                           )


//                         ],
//                       ),

//                     ),
//                   );
//                 }

//                 );
//               },






Future<void> _error_dialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
        child: AlertDialog(
          shadowColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
            side: BorderSide(
              color: Colors.grey.withOpacity(0.2),
              width : 1,
            ),
          ),
          title: Row(
            children: [
              const SizedBox(width: 0,),
              const Text(
                'error',
                style: TextStyle(
                  color: Color(0xFF00246B),
                  fontFamily: 'Gadugi',
                )
              ),
              const SizedBox(width: 8,),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                icon: const Icon(
                  Icons.close,
                  size: 25,
                  color: Color(0xFF4F5054),
                ),
              ),
            ],
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 18.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: const Text(
                  'try again',
                  style: TextStyle(
                    color: Color(0xFF00246B),
                    fontFamily: 'Gadugi'
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  );
}






















  var group_name, module, year, semester , table_name;
  var show_group , show_module , remove_groupe;
  List<String> _remove = [];
  List<String> _remove_table= [];
  Future<List<Map<String, dynamic>>>? _dataFuture;
 
  @override
  void initState() {
    Sql_database().fetchData();
    _dataFuture = Sql_database().display_table("classes");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Classes',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontFamily: "Gadugi",
            fontWeight: FontWeight.bold,
          ),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(0, 36, 107, 1),
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/home_prof/',
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
      body: Stack(children: [
      Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/Classes/classes_back.jpg"),
                fit: BoxFit.cover)),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 50),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 30, left: 22.5),
                child: Text(
                  "Years",
                  style: TextStyle(
                    color: Color.fromRGBO(0, 36, 107, 1),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Gadugi',
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 13, left: 22.5),
                child: Text(
                  "First year :",
                  style: TextStyle(
                    color: Color.fromRGBO(244, 202, 65, 1),
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Gadugi',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  height: 200,
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                    future: _dataFuture,
                    builder: (context , snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data!;
                        return ListView.builder(
                          itemCount: data.length +1 ,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context , index) {
                            if (index == data.length) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 15,right: 20),
                                child: DottedBorder(
                                  borderType: BorderType.Circle,
                                  strokeWidth: 4,
                                  dashPattern: const [0,0,8,10],
                                  color:const Color.fromRGBO(173, 173, 173, 1) ,
                                  child: SizedBox(
                                    width: 156,
                                    child: Center(
                                      child: InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context ) {
                                              return BackdropFilter(
                                                filter: ImageFilter.blur(
                                                  sigmaX: 3.0,
                                                  sigmaY: 3.0,
                                                ),
                                                child: AlertDialog(
                                                  shadowColor: Colors.black,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(16.0),
                                                    side: BorderSide(
                                                      color: Colors.grey.withOpacity(0.2),
                                                      width: 1,
                                                    ),
                                                  ),
                                                  title: Row(
                                                    children: [
                                                      const SizedBox(width: 0,),
                                                      const Text(
                                                        'Lesson informations',
                                                        style: TextStyle(
                                                          color: Color(0xFF00246B),
                                                          fontFamily: 'Gadugi',
                                                        ),
                                                      ),
                                                      const SizedBox(width: 3,),
                                                      IconButton(
                                                        onPressed: () {
                                                          Navigator.of(context).pop(false);
                                                        },
                                                        icon: const Icon(
                                                          Icons.close,
                                                          size: 25,
                                                          color: Color(0xFF4F5054),
                                                        ),
                                                      ),
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
                                                            hintText: 'Group name',
                                                            prefixIcon: Icon(Icons.people),
                                                          ),
                                                          onChanged: (value) {
                                                            setState(() {
                                                              group_name = value;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 25),
                                                        child: TextField(
                                                          decoration: const InputDecoration(
                                                            hintText: 'module',
                                                            prefixIcon: Icon(Icons.book),
                                                          ),
                                                          onChanged: (value) {
                                                            setState(() {
                                                              module = value;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 25),
                                                        child: TextField(
                                                          decoration: const InputDecoration(
                                                            hintText: 'semester 1/2',
                                                            prefixIcon: Icon(Icons.access_time),
                                                          ),
                                                          onChanged: (value) {
                                                            setState(() {
                                                              semester = value;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 20),
                                                        child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                            backgroundColor: const  Color(0xFFF4CA41),
                                                          ),
                                                          onPressed: () async {
                                                            setState(() async {
                                                              year = '1cp';
                                                              table_name = "_" + group_name + "_" +  module + "_" +  year + "_" + semester;
                                                              int result = await sql_data.insert("INSERT INTO classes (groupe , module , year , semester , table_name ) VALUES ('$group_name' , '$module' , '$year' , '$semester' , '$table_name');");
                                                              if (result == 0 ) {
                                                                _error_dialog;
                                                              }
                                                            });
                                                          },
                                                          child: const Text(
                                                            'Save',
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontFamily: 'Gadugi',
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10.0,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 20),
                                                        child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                            backgroundColor: const  Color(0xFFF4CA41),
                                                          ),
                                                          onPressed: () async {
                                                            Navigator.of(context).pushNamedAndRemoveUntil(
                                                              '/classes/',
                                                              (route) => false,
                                                            );
                                                            setState(() async {
                                                              await sql_data.read_and_insert(table_name);
                                                              List<Map> show = await sql_data.read_data("SELECT * FROM '$table_name' ");
                                                              print("####################### $show" );
                                                            });
                                                          },
                                                          child: const Text(
                                                            'add student list',
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontFamily: 'Gadugi',
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }
                                          );
                                        },
                                        child: const Icon(
                                          Icons.add_rounded,
                                          size: 70,
                                          color:Color.fromRGBO(173, 173, 173, 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else{
                              if (data[index]['year'] == '1cp') {
                                show_group = data[index]['groupe'];
                                show_module = data[index]['module'];
                                remove_groupe = data[index]['groupe'];
                                _remove.add(remove_groupe);
                                _remove_table.add(data[index]['table_name']);
                                return Container(
                                  width: 156,
                                  decoration:  BoxDecoration(
                                    border:
                                    Border.all(
                                      color: Colors.white,
                                      width: 5,
                                      style: BorderStyle.solid,
                                    ),
                                    boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black,
                                        spreadRadius: 2,
                                        blurRadius: 1,
                                      ),
                                    ],
                                    color: const Color.fromRGBO(198, 195, 195, 1),
                                    shape: BoxShape.circle,
                                  ),
                                  margin: const EdgeInsets.only(left: 15),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:  [
                                        Text(
                                          "$show_module ",
                                          style: const TextStyle(
                                            color: Color.fromRGBO(0, 36, 107, 1),
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Gadugi',
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 10),
                                          child: InkWell(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context)  {
                                                  return BackdropFilter(
                                                    filter: ImageFilter.blur(sigmaX: 3.0 , sigmaY: 3.0),
                                                    child: AlertDialog(
                                                      shadowColor: Colors.black,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(16.0),
                                                        side: BorderSide(
                                                          color: Colors.grey.withOpacity(0.2),
                                                          width: 1,
                                                        ),
                                                      ),
                                                      title: Row(
                                                        children: [
                                                          const SizedBox(width: 0,),
                                                          Text(
                                                            " remove ${_remove[index]} ",
                                                            style: const TextStyle(
                                                              color: Color(0xFF00246B),
                                                              fontFamily: 'Gadugi',
                                                            ),
                                                          ),
                                                          const SizedBox(width: 10,),
                                                          IconButton(
                                                            onPressed: () {
                                                              Navigator.of(context).pop(false);
                                                            },
                                                            icon: const Icon(
                                                              Icons.close,
                                                              size: 25,
                                                              color: Color(0xFF4F5054),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      contentPadding: const EdgeInsets.symmetric(vertical: 18.0),
                                                      content: ElevatedButton(
                                                        onPressed: () async {
                                                            Navigator.of(context).pushNamedAndRemoveUntil(
                                                              '/classes/',
                                                              (route) => false,
                                                            );
                                                          setState(() async{
                                                            int result = await sql_data.delete_data("DELETE FROM classes WHERE groupe = '${_remove[index]}' ");
                                                            if (result == 0 ) {
                                                                _error_dialog;
                                                              }
                                                              sql_data.deleteTable(_remove_table[index]);
                                                          });
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor:  const Color(0xFFF4CA41),
                                                        ),
                                                        child: const Text(
                                                          " remove ",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily: 'Gadugi',
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                              );
                                            },
                                            child : Text(
                                            "$show_group",
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Gadugi',
                                            ),
                                          ),
                                        ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                              return const SizedBox.shrink();
                              }
                            }
                          },
                        );
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 13, left: 22.5),
                child: Text(
                  "Second year :",
                  style: TextStyle(
                    color: Color.fromRGBO(244, 202, 65, 1),
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Gadugi',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  height: 200,
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                    future: _dataFuture,
                    builder: (context , snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data!;
                        return ListView.builder(
                          itemCount: data.length +1 ,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context , index) {
                            if (index == data.length) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 15,right: 20),
                                child: DottedBorder(
                                  borderType: BorderType.Circle,
                                  strokeWidth: 4,
                                  dashPattern: const [0,0,8,10],
                                  color:const Color.fromRGBO(173, 173, 173, 1) ,
                                  child: SizedBox(
                                    width: 156,
                                    child: Center(
                                      child: InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context ) {
                                              return BackdropFilter(
                                                filter: ImageFilter.blur(
                                                  sigmaX: 3.0,
                                                  sigmaY: 3.0,
                                                ),
                                                child: AlertDialog(
                                                  shadowColor: Colors.black,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(16.0),
                                                    side: BorderSide(
                                                      color: Colors.grey.withOpacity(0.2),
                                                      width: 1,
                                                    ),
                                                  ),
                                                  title: Row(
                                                    children: [
                                                      const SizedBox(width: 0,),
                                                      const Text(
                                                        'Lesson informations',
                                                        style: TextStyle(
                                                          color: Color(0xFF00246B),
                                                          fontFamily: 'Gadugi',
                                                        ),
                                                      ),
                                                      const SizedBox(width: 3,),
                                                      IconButton(
                                                        onPressed: () {
                                                          Navigator.of(context).pop(false);
                                                        },
                                                        icon: const Icon(
                                                          Icons.close,
                                                          size: 25,
                                                          color: Color(0xFF4F5054),
                                                        ),
                                                      ),
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
                                                            hintText: 'Group name',
                                                            prefixIcon: Icon(Icons.people),
                                                          ),
                                                          onChanged: (value) {
                                                            setState(() {
                                                              group_name = value;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 25),
                                                        child: TextField(
                                                          decoration: const InputDecoration(
                                                            hintText: 'module',
                                                            prefixIcon: Icon(Icons.book),
                                                          ),
                                                          onChanged: (value) {
                                                            setState(() {
                                                              module = value;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 25),
                                                        child: TextField(
                                                          decoration: const InputDecoration(
                                                            hintText: 'semester 1/2',
                                                            prefixIcon: Icon(Icons.access_time),
                                                          ),
                                                          onChanged: (value) {
                                                            setState(() {
                                                              semester = value;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 20),
                                                        child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                            backgroundColor: const  Color(0xFFF4CA41),
                                                          ),
                                                          onPressed: () async {
                                                            setState(() async {
                                                              year = '2cp';
                                                              table_name = "_" + group_name + "_" +  module + "_" +  year + "_" + semester;
                                                              int result = await sql_data.insert("INSERT INTO classes (groupe , module , year , semester , table_name ) VALUES ('$group_name' , '$module' , '$year' , '$semester' , '$table_name');");
                                                              if (result == 0 ) {
                                                                _error_dialog;
                                                              }
                                                            });
                                                          },
                                                          child: const Text(
                                                            'Save',
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontFamily: 'Gadugi',
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10.0,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 20),
                                                        child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                            backgroundColor: const  Color(0xFFF4CA41),
                                                          ),
                                                          onPressed: () async {
                                                            Navigator.of(context).pushNamedAndRemoveUntil(
                                                              '/classes/',
                                                              (route) => false,
                                                            );
                                                            setState(() async {
                                                              await sql_data.read_and_insert(table_name);
                                                            });
                                                          },
                                                          child: const Text(
                                                            'add student list',
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontFamily: 'Gadugi',
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }
                                          );
                                        },
                                        child: const Icon(
                                          Icons.add_rounded,
                                          size: 70,
                                          color:Color.fromRGBO(173, 173, 173, 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else{
                              if (data[index]['year'] == '2cp') {
                                show_group = data[index]['groupe'];
                                show_module = data[index]['module'];
                                remove_groupe = data[index]['groupe'];
                                _remove.add(remove_groupe);
                                _remove_table.add(data[index]['table_name']);
                                return Container(
                                  width: 156,
                                  decoration:  BoxDecoration(
                                    border:
                                    Border.all(
                                      color: Colors.white,
                                      width: 5,
                                      style: BorderStyle.solid,
                                    ),
                                    boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black,
                                        spreadRadius: 2,
                                        blurRadius: 1,
                                      ),
                                    ],
                                    color: const Color.fromRGBO(198, 195, 195, 1),
                                    shape: BoxShape.circle,
                                  ),
                                  margin: const EdgeInsets.only(left: 15),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:  [
                                        Text(
                                          "$show_module ",
                                          style: const TextStyle(
                                            color: Color.fromRGBO(0, 36, 107, 1),
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Gadugi',
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 10),
                                          child: InkWell(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context)  {
                                                  return BackdropFilter(
                                                    filter: ImageFilter.blur(sigmaX: 3.0 , sigmaY: 3.0),
                                                    child: AlertDialog(
                                                      shadowColor: Colors.black,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(16.0),
                                                        side: BorderSide(
                                                          color: Colors.grey.withOpacity(0.2),
                                                          width: 1,
                                                        ),
                                                      ),
                                                      title: Row(
                                                        children: [
                                                          const SizedBox(width: 0,),
                                                          Text(
                                                            " remove ${_remove[index]} ",
                                                            style: const TextStyle(
                                                              color: Color(0xFF00246B),
                                                              fontFamily: 'Gadugi',
                                                            ),
                                                          ),
                                                          const SizedBox(width: 10,),
                                                          IconButton(
                                                            onPressed: () {
                                                              Navigator.of(context).pop(false);
                                                            },
                                                            icon: const Icon(
                                                              Icons.close,
                                                              size: 25,
                                                              color: Color(0xFF4F5054),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      contentPadding: const EdgeInsets.symmetric(vertical: 18.0),
                                                      content: ElevatedButton(
                                                        onPressed: () async {
                                                            Navigator.of(context).pushNamedAndRemoveUntil(
                                                              '/classes/',
                                                              (route) => false,
                                                            );
                                                          setState(() async{
                                                            int result = await sql_data.delete_data("DELETE FROM classes WHERE groupe = '${_remove[index]}' ");
                                                            if (result == 0 ) {
                                                                _error_dialog;
                                                              }
                                                              sql_data.deleteTable(_remove_table[index]);
                                                          });
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor:  const Color(0xFFF4CA41),
                                                        ),
                                                        child: const Text(
                                                          " remove ",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily: 'Gadugi',
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                              );
                                            },
                                            child : Text(
                                            "$show_group",
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Gadugi',
                                            ),
                                          ),
                                        ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                              return const SizedBox.shrink();
                              }
                            }
                          },
                        );
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 13, left: 22.5),
                child: Text(
                  "Third year :",
                  style: TextStyle(
                    color: Color.fromRGBO(244, 202, 65, 1),
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Gadugi',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  height: 200,
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                    future: _dataFuture,
                    builder: (context , snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data!;
                        return ListView.builder(
                          itemCount: data.length +1 ,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context , index) {
                            if (index == data.length) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 15,right: 20),
                                child: DottedBorder(
                                  borderType: BorderType.Circle,
                                  strokeWidth: 4,
                                  dashPattern: const [0,0,8,10],
                                  color:const Color.fromRGBO(173, 173, 173, 1) ,
                                  child: SizedBox(
                                    width: 156,
                                    child: Center(
                                      child: InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context ) {
                                              return BackdropFilter(
                                                filter: ImageFilter.blur(
                                                  sigmaX: 3.0,
                                                  sigmaY: 3.0,
                                                ),
                                                child: AlertDialog(
                                                  shadowColor: Colors.black,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(16.0),
                                                    side: BorderSide(
                                                      color: Colors.grey.withOpacity(0.2),
                                                      width: 1,
                                                    ),
                                                  ),
                                                  title: Row(
                                                    children: [
                                                      const SizedBox(width: 0,),
                                                      const Text(
                                                        'Lesson informations',
                                                        style: TextStyle(
                                                          color: Color(0xFF00246B),
                                                          fontFamily: 'Gadugi',
                                                        ),
                                                      ),
                                                      const SizedBox(width: 3,),
                                                      IconButton(
                                                        onPressed: () {
                                                          Navigator.of(context).pop(false);
                                                        },
                                                        icon: const Icon(
                                                          Icons.close,
                                                          size: 25,
                                                          color: Color(0xFF4F5054),
                                                        ),
                                                      ),
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
                                                            hintText: 'Group name',
                                                            prefixIcon: Icon(Icons.people),
                                                          ),
                                                          onChanged: (value) {
                                                            setState(() {
                                                              group_name = value;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 25),
                                                        child: TextField(
                                                          decoration: const InputDecoration(
                                                            hintText: 'module',
                                                            prefixIcon: Icon(Icons.book),
                                                          ),
                                                          onChanged: (value) {
                                                            setState(() {
                                                              module = value;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 25),
                                                        child: TextField(
                                                          decoration: const InputDecoration(
                                                            hintText: 'semester 1/2',
                                                            prefixIcon: Icon(Icons.access_time),
                                                          ),
                                                          onChanged: (value) {
                                                            setState(() {
                                                              semester = value;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 20),
                                                        child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                            backgroundColor: const  Color(0xFFF4CA41),
                                                          ),
                                                          onPressed: () async {
                                                            Navigator.of(context).pop(false);
                                                            setState(() async {
                                                              year = '1cs';
                                                              table_name = "_" + group_name + "_" +  module + "_" +  year + "_" + semester;
                                                              int result = await sql_data.insert("INSERT INTO classes (groupe , module , year , semester , table_name ) VALUES ('$group_name' , '$module' , '$year' , '$semester' , '$table_name');");
                                                              if (result == 0 ) {
                                                                _error_dialog;
                                                              }
                                                            });
                                                          },
                                                          child: const Text(
                                                            'Save',
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontFamily: 'Gadugi',
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10.0,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 20),
                                                        child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                            backgroundColor: const  Color(0xFFF4CA41),
                                                          ),
                                                          onPressed: () async {
                                                            Navigator.of(context).pushNamedAndRemoveUntil(
                                                              '/classes/',
                                                              (route) => false,
                                                            );
                                                            setState(() async {
                                                              await sql_data.read_and_insert(table_name);
                                                            });
                                                          },
                                                          child: const Text(
                                                            'add student list',
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontFamily: 'Gadugi',
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }
                                          );
                                        },
                                        child: const Icon(
                                          Icons.add_rounded,
                                          size: 70,
                                          color:Color.fromRGBO(173, 173, 173, 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else{
                              if (data[index]['year'] == '1cs') {
                                show_group = data[index]['groupe'];
                                show_module = data[index]['module'];
                                remove_groupe = data[index]['groupe'];
                                _remove.add(remove_groupe);
                                _remove_table.add(data[index]['table_name']);
                                return Container(
                                  width: 156,
                                  decoration:  BoxDecoration(
                                    border:
                                    Border.all(
                                      color: Colors.white,
                                      width: 5,
                                      style: BorderStyle.solid,
                                    ),
                                    boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black,
                                        spreadRadius: 2,
                                        blurRadius: 1,
                                      ),
                                    ],
                                    color: const Color.fromRGBO(198, 195, 195, 1),
                                    shape: BoxShape.circle,
                                  ),
                                  margin: const EdgeInsets.only(left: 15),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:  [
                                        Text(
                                          "$show_module ",
                                          style: const TextStyle(
                                            color: Color.fromRGBO(0, 36, 107, 1),
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Gadugi',
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 10),
                                          child: InkWell(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context)  {
                                                  return BackdropFilter(
                                                    filter: ImageFilter.blur(sigmaX: 3.0 , sigmaY: 3.0),
                                                    child: AlertDialog(
                                                      shadowColor: Colors.black,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(16.0),
                                                        side: BorderSide(
                                                          color: Colors.grey.withOpacity(0.2),
                                                          width: 1,
                                                        ),
                                                      ),
                                                      title: Row(
                                                        children: [
                                                          const SizedBox(width: 0,),
                                                          Text(
                                                            " remove ${_remove[index]} ",
                                                            style: const TextStyle(
                                                              color: Color(0xFF00246B),
                                                              fontFamily: 'Gadugi',
                                                            ),
                                                          ),
                                                          const SizedBox(width: 10,),
                                                          IconButton(
                                                            onPressed: () {
                                                              Navigator.of(context).pop(false);
                                                            },
                                                            icon: const Icon(
                                                              Icons.close,
                                                              size: 25,
                                                              color: Color(0xFF4F5054),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      contentPadding: const EdgeInsets.symmetric(vertical: 18.0),
                                                      content: ElevatedButton(
                                                        onPressed: () async {
                                                            Navigator.of(context).pushNamedAndRemoveUntil(
                                                              '/classes/',
                                                              (route) => false,
                                                            );
                                                          setState(() async{
                                                            int result = await sql_data.delete_data("DELETE FROM classes WHERE groupe = '${_remove[index]}' ");
                                                            if (result == 0 ) {
                                                                _error_dialog;
                                                              }
                                                              sql_data.deleteTable(_remove_table[index]);
                                                          });
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor:  const Color(0xFFF4CA41),
                                                        ),
                                                        child: const Text(
                                                          " remove ",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily: 'Gadugi',
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                              );
                                            },
                                            child : Text(
                                            "$show_group",
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Gadugi',
                                            ),
                                          ),
                                        ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                              return const SizedBox.shrink();
                              }
                            }
                          },
                        );
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 13, left: 22.5),
                child: Text(
                  "Fourth year :",
                  style: TextStyle(
                    color: Color.fromRGBO(244, 202, 65, 1),
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Gadugi',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  height: 200,
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                    future: _dataFuture,
                    builder: (context , snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data!;
                        return ListView.builder(
                          itemCount: data.length +1 ,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context , index) {
                            if (index == data.length) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 15,right: 20),
                                child: DottedBorder(
                                  borderType: BorderType.Circle,
                                  strokeWidth: 4,
                                  dashPattern: const [0,0,8,10],
                                  color:const Color.fromRGBO(173, 173, 173, 1) ,
                                  child: SizedBox(
                                    width: 156,
                                    child: Center(
                                      child: InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context ) {
                                              return BackdropFilter(
                                                filter: ImageFilter.blur(
                                                  sigmaX: 3.0,
                                                  sigmaY: 3.0,
                                                ),
                                                child: AlertDialog(
                                                  shadowColor: Colors.black,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(16.0),
                                                    side: BorderSide(
                                                      color: Colors.grey.withOpacity(0.2),
                                                      width: 1,
                                                    ),
                                                  ),
                                                  title: Row(
                                                    children: [
                                                      const SizedBox(width: 0,),
                                                      const Text(
                                                        'Lesson informations',
                                                        style: TextStyle(
                                                          color: Color(0xFF00246B),
                                                          fontFamily: 'Gadugi',
                                                        ),
                                                      ),
                                                      const SizedBox(width: 3,),
                                                      IconButton(
                                                        onPressed: () {
                                                          Navigator.of(context).pop(false);
                                                        },
                                                        icon: const Icon(
                                                          Icons.close,
                                                          size: 25,
                                                          color: Color(0xFF4F5054),
                                                        ),
                                                      ),
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
                                                            hintText: 'Group name',
                                                            prefixIcon: Icon(Icons.people),
                                                          ),
                                                          onChanged: (value) {
                                                            setState(() {
                                                              group_name = value;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 25),
                                                        child: TextField(
                                                          decoration: const InputDecoration(
                                                            hintText: 'module',
                                                            prefixIcon: Icon(Icons.book),
                                                          ),
                                                          onChanged: (value) {
                                                            setState(() {
                                                              module = value;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 25),
                                                        child: TextField(
                                                          decoration: const InputDecoration(
                                                            hintText: 'semester 1/2',
                                                            prefixIcon: Icon(Icons.access_time),
                                                          ),
                                                          onChanged: (value) {
                                                            setState(() {
                                                              semester = value;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 20),
                                                        child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                            backgroundColor: const  Color(0xFFF4CA41),
                                                          ),
                                                          onPressed: () async {
                                                            Navigator.of(context).pop(false);
                                                            setState(() async {
                                                              year = '2cs';
                                                              table_name = "_" + group_name + "_" +  module + "_" +  year + "_" + semester;
                                                              int result = await sql_data.insert("INSERT INTO classes (groupe , module , year , semester , table_name ) VALUES ('$group_name' , '$module' , '$year' , '$semester' , '$table_name');");
                                                              if (result == 0 ) {
                                                                _error_dialog;
                                                              }
                                                            });
                                                          },
                                                          child: const Text(
                                                            'Save',
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontFamily: 'Gadugi',
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10.0,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 20),
                                                        child: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                            backgroundColor: const  Color(0xFFF4CA41),
                                                          ),
                                                          onPressed: () async {
                                                            Navigator.of(context).pushNamedAndRemoveUntil(
                                                              '/classes/',
                                                              (route) => false,
                                                            );
                                                            setState(() async {
                                                              await sql_data.read_and_insert(table_name);
                                                            });
                                                          },
                                                          child: const Text(
                                                            'add student list',
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontFamily: 'Gadugi',
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }
                                          );
                                        },
                                        child: const Icon(
                                          Icons.add_rounded,
                                          size: 70,
                                          color:Color.fromRGBO(173, 173, 173, 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else{
                              if (data[index]['year'] == '2cs') {
                                show_group = data[index]['groupe'];
                                show_module = data[index]['module'];
                                remove_groupe = data[index]['groupe'];
                                _remove.add(remove_groupe);
                                _remove_table.add(data[index]['table_name']);
                                return Container(
                                  width: 156,
                                  decoration:  BoxDecoration(
                                    border:
                                    Border.all(
                                      color: Colors.white,
                                      width: 5,
                                      style: BorderStyle.solid,
                                    ),
                                    boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black,
                                        spreadRadius: 2,
                                        blurRadius: 1,
                                      ),
                                    ],
                                    color: const Color.fromRGBO(198, 195, 195, 1),
                                    shape: BoxShape.circle,
                                  ),
                                  margin: const EdgeInsets.only(left: 15),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:  [
                                        Text(
                                          "$show_module ",
                                          style: const TextStyle(
                                            color: Color.fromRGBO(0, 36, 107, 1),
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Gadugi',
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 10),
                                          child: InkWell(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context)  {
                                                  return BackdropFilter(
                                                    filter: ImageFilter.blur(sigmaX: 3.0 , sigmaY: 3.0),
                                                    child: AlertDialog(
                                                      shadowColor: Colors.black,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(16.0),
                                                        side: BorderSide(
                                                          color: Colors.grey.withOpacity(0.2),
                                                          width: 1,
                                                        ),
                                                      ),
                                                      title: Row(
                                                        children: [
                                                          const SizedBox(width: 0,),
                                                          Text(
                                                            " remove ${_remove[index]} ",
                                                            style: const TextStyle(
                                                              color: Color(0xFF00246B),
                                                              fontFamily: 'Gadugi',
                                                            ),
                                                          ),
                                                          const SizedBox(width: 10,),
                                                          IconButton(
                                                            onPressed: () {
                                                              Navigator.of(context).pop(false);
                                                            },
                                                            icon: const Icon(
                                                              Icons.close,
                                                              size: 25,
                                                              color: Color(0xFF4F5054),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      contentPadding: const EdgeInsets.symmetric(vertical: 18.0),
                                                      content: ElevatedButton(
                                                        onPressed: () async {
                                                            Navigator.of(context).pushNamedAndRemoveUntil(
                                                              '/classes/',
                                                              (route) => false,
                                                            );
                                                          setState(() async{
                                                            int result = await sql_data.delete_data("DELETE FROM classes WHERE groupe = '${_remove[index]}' ");
                                                            if (result == 0 ) {
                                                                _error_dialog;
                                                              }
                                                              sql_data.deleteTable(_remove_table[index]);
                                                          });
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor:  const Color(0xFFF4CA41),
                                                        ),
                                                        child: const Text(
                                                          " remove ",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily: 'Gadugi',
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                              );
                                            },
                                            child : Text(
                                            "$show_group",
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Gadugi',
                                            ),
                                          ),
                                        ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                              return const SizedBox.shrink();
                              }
                            }
                          },
                        );
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ]),
      // body: PageView(
      //   controller: _pageController,
      //   physics: const NeverScrollableScrollPhysics(),
      //   children: List.generate(bottomBarPages.length, (index) => bottomBarPages[index]),),
      //   extendBody: true,
      //   bottomNavigationBar: (bottomBarPages.length <= maxCount)
      //     ? AnimatedNotchBottomBar(
      //         pageController: _pageController,
      //         color: const Color.fromARGB(207, 187, 187, 184),
      //         //const Color.fromARGB(255, 202, 200, 200),
      //         showLabel: false,
      //         notchColor: const Color.fromRGBO(0, 36, 107, 1),
      //         bottomBarItems: const [
      //            BottomBarItem(
      //             inActiveItem: Icon(
      //               Icons.people,
      //               color: Color.fromRGBO(0, 36, 107, 1),
      //             ),
      //             activeItem: Icon(
      //               Icons.people,
      //               color: Color.fromRGBO(244, 202, 65, 1),
      //             ),
      //           ),
      //           BottomBarItem(
      //             inActiveItem: Icon(
      //               Icons.home,
      //               color: Color.fromRGBO(0, 36, 107, 1),
      //             ),
      //             activeItem: Icon(
      //               Icons.home,
      //               color: Color.fromRGBO(244, 202, 65, 1),
      //             ),
      //           ),
      //           BottomBarItem(
      //             inActiveItem: Icon(
      //               Icons.list,
      //               color:Color.fromRGBO(0, 36, 107, 1),
      //             ),
      //             activeItem: Icon(
      //               Icons.list,
      //               color: Color.fromRGBO(244, 202, 65, 1),
      //             ),
      //           ),
      //         ],
      //         onTap: (index) {
      //           selected_page(index);
      //           _pageController.animateToPage(
      //             index,
      //             duration: const Duration(milliseconds: 500),
      //             curve: Curves.easeIn,
      //           );
      //         },
      //       )
      //     : null,
    );
  }
}
