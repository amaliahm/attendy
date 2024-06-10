import 'dart:async';
import 'dart:ui';
import 'package:attendy_/sql_data.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';


import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:attendy_/authentication/login.dart';
import 'package:attendy_/screens/shedule.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home_prof extends StatefulWidget {
  const Home_prof({Key? key}) : super(key: key);

  @override
  State<Home_prof> createState() => _Home_profState();
}


class _Home_profState extends State<Home_prof> {
  
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _pageController = PageController(initialPage: 1);


  int maxCount = 3;

  /// widget list
  final List<Widget> bottomBarPages = [
    const Communication(),
    const Home(),
    const List_student(),
  ];
  

  static const List<String> _titles = ['communication' , 'Attendy' , 'List'];
  int _selected_page = 1;
  String the_app_bar = _titles[1];

  void selected_page(int index) {
    setState(() {
      _selected_page = index;
      the_app_bar = _titles[index];
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          the_app_bar,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontFamily: "Gadugi",
            fontWeight: FontWeight.bold,
          ),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(0, 36, 107, 1),
          elevation: 0,
        actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/notification/',
                    (route) => false,
                  );
                },
                icon: const Icon(
                  Icons.notifications,
                  color: Color.fromRGBO(173, 173, 173, 1),
                  size: 30,
                ),
              ),
            ),
          ],
          leading: Padding(
            padding: const EdgeInsets.only(left: 15),
            child:IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Color.fromRGBO(173, 173, 173, 1),
                  size: 30,
                ),
                onPressed: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
              ),
            ),
          ),
      key: _scaffoldKey,
        drawer: Drawer(
          child: Stack(
            children:[ 
              Container(
                decoration:  const BoxDecoration(
        image: DecorationImage(image: AssetImage('images/Home/menu_back.jpg'),
        fit: BoxFit.cover)
              ))
              ,Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30,40,0,80),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:[ IconButton(
                        icon: const Icon(Icons.close),
                        color:const Color(0xFF00246B) ,
                        iconSize: 45,
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                                ]),
                  ),
                  ListTile(iconColor:const Color(0xFFADADAD),
                    leading: Transform.translate(
                      offset: const  Offset(40, 0),
                      child: const Icon(Icons.person,size: 32 ) ),
                    title: const Padding(
                      padding: EdgeInsets.only(left: 40),
                      child: Text("Profile ",
                      style: TextStyle(
                        color: Color(0xFFADADAD),
                        fontSize: 27
                      ),
                      ),
                    ),
                    onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/profile/',
                      (route) => false,
                    );
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ListTile(iconColor:const Color(0xFFADADAD),
                    leading: Transform.translate(
                      offset: const Offset(40, 0),
                      child: const Icon(Icons.settings,size: 32)),
                    title: const Padding(
                      padding: EdgeInsets.only(left: 40),
                      child: Text("Settings",
                       style: TextStyle(
                        color: Color(0xFFADADAD),
                        fontSize: 27
                      ),),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        '/setting_prof/',
                        (route) => false,
                      );
                      // go to seeting 
                    },
                  ),
                   const SizedBox(
                    height: 15,
                  ),
                  ListTile(iconColor:const Color(0xFFADADAD) ,
                    leading: Transform.translate(
                      offset: const Offset(40, 0),
                      child: const Icon(Icons.phone,size: 32
                      ),
                    ),
                    title: const Padding(
                      padding: EdgeInsets.only(left: 40),
                      child: Text("Contact us",
                       style: TextStyle(
                        color: Color(0xFFADADAD),
                        fontSize: 27
                      ),),
                    ),
                    onTap: () {},
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ListTile(iconColor:const Color(0xFFADADAD),
                    leading: Transform.translate(
                      offset: const Offset(40, 0),
                      child: const Icon(Icons.logout,size: 32)),
                    title: const Padding(
                      padding: EdgeInsets.only(left: 40),
                      child: Text("Log out",
                       style: TextStyle(
                        color: Color(0xFFADADAD),
                        fontSize: 27
                      ),),
                    ),
                    onTap: () async {
                      showDialog(
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
                                  width: 1,
                                )
                              ),
                            title: Row(
                              children: [
                                const SizedBox(width: 70,),
                                const Text('Log out',
                                style: TextStyle(
                                  color: Color(0xFF00246B),
                                  fontFamily: 'Gadugi',
                                ),
                              ),
                              const SizedBox(width: 20,),
                              IconButton(
                                onPressed: (){
                                  Navigator.of(context).pop(false);
                                },
                                icon: const Icon(
                                  Icons.close,
                                  size: 25,
                                  color: Color(0xFF4F5054),
                                )
                              )
                            ],
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 18.0),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [  
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                   backgroundColor: const Color(0xFFF4CA41)
                                  ),
                                   onPressed: () async {
                                    showLoading(context);
                                    await FirebaseAuth.instance.signOut();
                                    Navigator.of(context).pushNamedAndRemoveUntil(
                                      '/login/',
                                      (route) => false,
                                    );
                                   },
                                   child: const Text(
                                    ' OK ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Gadugi',
                                    ),
                                  )
                                )
                              ],
                            ),
                  ),
      );    } 
        );
                    },
                  ), 
                ],
              ),]
          ),
        ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(bottomBarPages.length, (index) => bottomBarPages[index]),),
        extendBody: true,
        bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              pageController: _pageController,
              color: const Color.fromARGB(207, 187, 187, 184),
              //const Color.fromARGB(255, 202, 200, 200),
              showLabel: false,
              notchColor: const Color.fromRGBO(0, 36, 107, 1),
              bottomBarItems: const [
                 BottomBarItem(
                  inActiveItem: Icon(
                    Icons.people,
                    color: Color.fromRGBO(0, 36, 107, 1),
                  ),
                  activeItem: Icon(
                    Icons.people,
                    color: Color.fromRGBO(244, 202, 65, 1),
                  ),
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.home,
                    color: Color.fromRGBO(0, 36, 107, 1),
                  ),
                  activeItem: Icon(
                    Icons.home,
                    color: Color.fromRGBO(244, 202, 65, 1),
                  ),
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.list,
                    color:Color.fromRGBO(0, 36, 107, 1),
                  ),
                  activeItem: Icon(
                    Icons.list,
                    color: Color.fromRGBO(244, 202, 65, 1),
                  ),
                ),
              ],
              onTap: (index) {
                selected_page(index);
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                );
              },
            )
          : null,
    );
  }
}

class Communication extends StatefulWidget {
  const Communication({Key? key}) : super(key: key);

  @override
  State<Communication> createState() => _CommunicationState();
}

class _CommunicationState extends State<Communication> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  TextEditingController textController = TextEditingController();
  bool _isPressed1 = false;
  bool _isPressed2 = false;
  bool _isPressed3 = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
      Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/Home/BGH.jpg"), fit: BoxFit.cover)),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
      Padding(
        padding: const EdgeInsets.only(left: 15),
        child: AnimSearchBar(
          width: 360,
          textFieldColor: const Color.fromRGBO(210, 210, 210, 1.0),
          style: const TextStyle(
            color: Color.fromRGBO(0, 24, 71, 1),
            fontFamily: "Gadugi",
            fontWeight: FontWeight.bold,
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: Color.fromRGBO(173, 173, 173, 1),
            size: 30,
          ),
          textController: textController,
          textFieldIconColor: const Color.fromRGBO(244, 202, 65, 1),
          color: const Color.fromRGBO(0, 24, 71, 1),
          helpText: "Search...",
          onSuffixTap: () {
            setState(() {
              textController.clear();
            });
          },
          autoFocus: true,
          animationDurationInMilli: 700,
          onSubmitted: (String) {},
        ),
      ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(top: 135, left: 30, right: 30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _isPressed1 = true;
                  });
                  Timer(const Duration(seconds: 2), () {
                    setState(() {
                      _isPressed1 = false;
                    });
                  });
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/shedule/',
                    (route) => false,
                  );
                },
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(117, 117, 117, 1),
                          spreadRadius: 2,
                          blurStyle: BlurStyle.inner,
                          blurRadius: 20,
                          offset: Offset(5, 5),
                        ),
                      ],
                      image: const DecorationImage(
                          image: AssetImage("images/Home/Schedule.jpg"),
                          fit: BoxFit.cover)),
                          child: Center(
                    child: Container(
                      color: Colors.white60,
                      child: Text(
                        _isPressed1 ? 'SCHEDULE' : '',
                        style: const TextStyle(
                          color: Color.fromRGBO(0, 36, 107, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: TextButton(
                  onPressed: () {
                  setState(() {
                    _isPressed2 = true;
                  });
                  Timer(const Duration(seconds: 2), () {
                    setState(() {
                      _isPressed2 = false;
                    });
                  });
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/classes/',
                      (route) => false,
                    );
                  },
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(117, 117, 117, 1),
                            spreadRadius: 2,
                            blurStyle: BlurStyle.inner,
                            blurRadius: 20,
                            offset: Offset(5, 5),
                          ),
                        ],
                        image: const DecorationImage(
                            image: AssetImage("images/Home/classes.jpg"),
                            fit: BoxFit.cover)),
                            child: Center(
                    child: Container(
                      color: Colors.white60,
                      child: Text(
                        _isPressed2 ? 'CLASSES' : '',
                        style: const TextStyle(
                          color: Color.fromRGBO(0, 36, 107, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                   ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: TextButton(
                  onPressed: () {
                  setState(() {
                    _isPressed3 = true;
                  });
                  Timer(const Duration(seconds: 2), () {
                    setState(() {
                      _isPressed3 = false;
                    });
                  });
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/note/',
                    (route) => false,
                  );
                  },
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(117, 117, 117, 1),
                            spreadRadius: 2,
                            blurStyle: BlurStyle.inner,
                            blurRadius: 20,
                            offset: Offset(5, 5),
                          ),
                        ],
                        image: const DecorationImage(
                            image: AssetImage("images/Home/note.jpg"),
                            fit: BoxFit.cover)),
                            child: Center(
                    child: Container(
                      color: Colors.white60,
                      child: Text(
                        _isPressed3 ? 'NOTES' : '',
                        style: const TextStyle(
                          color: Color.fromRGBO(0, 36, 107, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                   ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ]),
      ),
    );
  }
}

class List_student extends StatefulWidget {
  const List_student ({Key? key}) : super(key: key);

  @override
  State<List_student> createState() => List_studentState();
}
  
  var myText = Text(
    'P',
    style: TextStyle(
        color: Color(0xFF00246B),
        fontSize: 30,
        fontWeight: FontWeight.w700,
        fontFamily: 'Myfont'),
  );
  int nbr_attendance = 20;
  int nbr_Class = 24;
  String input2 = "";
  String input1 = "";
  String input3 = "";
  var my_class = " ";
  final List<String> attendances = [  'saihi abderrahmane','bouhennini othmane','assam le mokhtare'];
    
    
  bool _isStarred = false;
class List_studentState extends State<List_student> {
  Future<List<Map<String, dynamic>>>? _data_classes;
  Future<List<Map<String, dynamic>>>? _data_student;
  List<String> classes = [];
  String the_class = ' ';

  my_student_list(String name) {
    setState(() {
      Sql_database().fetchData();
    _data_student = Sql_database().display_table(name);
    });
  }

  @override
  void initState() {
    Sql_database().fetchData();
    _data_classes = Sql_database().display_table("classes");
    _data_student = Sql_database().display_table("_g6_analyse_2cp_1");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Stack(children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/list/list.jpg'), fit: BoxFit.cover)),
          ),
          Column(
            children: [
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 54,
                  width: MediaQuery.of(context).size.width - 20,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      border: Border.all(
                        color: const Color(0xFF818388),
                      )),
                  child: FutureBuilder<List<Map<String, dynamic>>> (
                        future: _data_classes,
                        builder: (context , snapshot) {
                          if (!snapshot.hasData) {
                            my_class = 'class';
                            return Text(my_class);
                          } else {
                            classes = [];
                            final data = snapshot.data!;
                            for (int i = 0 ; i < data.length ; i++) {
                              classes.add(data[i]['table_name']);
                            }
                            the_class = classes.first;
                            return Padding(
                              padding:const  EdgeInsets.symmetric(horizontal: 20),
                              child: DropdownButton<String>(
                                    value: the_class,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    elevation: 16,
                                    items: classes.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 6),
                                              child: Icon(
                                                Icons.school,
                                                color: Color(0xFF00246B),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Text(value),
                                            const SizedBox(width: 40,),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? value) {
                                      setState(() {
                                        the_class = value!;
                                        my_class = the_class;
                                      });
                                    },
                                  ),
                            );
                          }
                        },
                      )
                      ),
                      
                ),
            ]
          ),
          (my_class != 'class') ?
          Column(
            children: [
              const SizedBox(
                height: 150,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(68, 0, 0, 0),
                  child: Row(
                    children: [
                      Text('Full name',
                          style: TextStyle(
                              color: Color(0xFF00246B),
                              fontWeight: FontWeight.w700,
                              fontSize: 20)),
                      SizedBox(width: 110),
                      Text('TD MARK',
                          style: TextStyle(
                              color: Color(0xFF00246B),
                              fontWeight: FontWeight.w700,
                              fontSize: 20)),
                    ],
                  ),
                ),
              ) ,
              FutureBuilder<List<Map<String, dynamic>>>(
                future: _data_student ,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const SizedBox.shrink();
                  } else {
                    final data = snapshot.data!;
                    return 
              Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          if (index == 0)
                            const Divider(
                              color: Colors.black,
                            ),
                          ListTile(
                            leading: Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                color: const Color(0xFF7785FF),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
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
                            title:
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    data[index]['student_name'].toString().toUpperCase().replaceAll('_', ' '),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Myfont'),
                                  ),
                                ),
                            trailing: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 139, 131, 131))),
                                height: 40,
                                width: 65,
                                child: Center(
                                  child: Text(
                                    (data[index]['TD'] == '0' || data[index]['TD'] == null) ? '  ' : " ${data[index]['TD']}",
                                    style: const TextStyle(
                                      color: Color(0xFF00246B),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Gadugi',
                                    ),
                                  ),
                                )),
                          ),
                          const Divider(
                            color: Colors.black,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
              
                  }
                }
              ),
              Container(
                height: 51,
                width: 148,
                decoration: BoxDecoration(
                    color: const Color(0xFF00246B),
                    borderRadius: BorderRadius.circular(13)),
                child: const Center(
                    child: Text('Save as PDF',
                        style: TextStyle(
                            fontFamily: 'Myfont',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20))),
              )
               
            ],
          ): const Center(
                child: Text("no class"),
          ),
        ]
        )
                );
    







    // return SafeArea(
    //   child: Scaffold(
    //     backgroundColor: Colors.white,
    //     body: Stack(
    //       children: [
    //         Container(
    //           decoration: const BoxDecoration(
    //             image: DecorationImage(
    //               image: AssetImage('images/list/list.jpg'),
    //               fit: BoxFit.cover,
    //             ),
    //           ),
    //         ),
    //         Column(
    //           children: [
    //             const SizedBox(height: 80),
    //             Expanded(
    //               child: ListView.builder(
    //                 itemCount: students.length ,
    //                 itemBuilder: (context, index) {
    //                   final student = students[index];
    //                   return ListTile(
    //                     leading: const CircleAvatar(
    //                       backgroundColor: Color(0xFF7785FF),
    //                     ),
    //                   title: Text(student),
    //                 );
    //               }
    //                           ),
    //             )
    //         ],
    //       ),
    //     ]
    //   )
    // )

 }
}
