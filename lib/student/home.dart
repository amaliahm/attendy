import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:attendy_/authentication/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';



class Home_student extends StatefulWidget {
  const Home_student({Key? key}) : super(key: key);

  @override
  State<Home_student> createState() => _Home_studentState();
}

class _Home_studentState extends State<Home_student> {
  /// Controller to handle PageView and also handles initial page
  final _pageController = PageController(initialPage: 1);
  
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int maxCount = 3;

  /// widget list
  final List<Widget> bottomBarPages = [
    const Communication(),
    const Home(),
    const Scan_QR(),
  ];

  static const List<String> _titles = ['communication' , 'Attendy' , 'Scan'];
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
                        '/setting_student/',
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
                                    'yeah',
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
              showLabel: false,
              notchColor: const Color.fromRGBO(0, 36, 107, 1),
              bottomBarItems: const [
                 BottomBarItem(
                  inActiveItem: Icon(
                    Icons.perm_contact_calendar_rounded,
                    color: Color.fromRGBO(0, 36, 107, 1),
                  ),
                  activeItem: Icon(
                    Icons.perm_contact_calendar_rounded,
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
                    Icons.qr_code_scanner_rounded,
                    color:Color.fromRGBO(0, 36, 107, 1),
                  ),
                  activeItem: Icon(
                    Icons.qr_code_scanner_rounded,
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
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
                onPressed: ()  {
                  setState(() {
                    _isPressed1 = true;
                  });
                  Timer(const Duration(seconds: 2), () {
                    setState(() {
                      _isPressed1 = false;
                    });
                  }) ;
                   Navigator.of(context).pushNamedAndRemoveUntil(
                    '/shedule/',
                    (route) => false,
                  );
                } ,
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
                        color:Colors.white60,
                        child: Text(
                          _isPressed2 ? 'NOTES' : '',
                          style: const TextStyle(
                            color: Color.fromRGBO(0, 36, 107, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ) ,
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

class Scan_QR extends StatefulWidget {
  const Scan_QR ({Key? key}) : super(key: key);

  @override
  State<Scan_QR> createState() => _Scan_QRState();
}

class _Scan_QRState extends State<Scan_QR> {
  String result = ' ';
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
                image: AssetImage("images/Classes/background.jpg"),
                fit: BoxFit.cover)),
      ),
      Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 45),
            child: Text(
              "Scan QR code to confirm your",
              style: TextStyle(
                color: Color.fromRGBO(79, 80, 84, 1),
                fontSize: 22,
                fontFamily: "Gadugi",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Text(
            "attendance",
            style: TextStyle(
              color: Color.fromRGBO(79, 80, 84, 1),
              fontSize: 22,
              fontFamily: "Gadugi",
              fontWeight: FontWeight.bold,
            ),
          ),
          const Image(image:AssetImage('images/scan/scan.jpg'),),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RawMaterialButton(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 40),
                    fillColor: const Color.fromRGBO(0, 36, 107, 1),
                    child: const Text(
                      'SCANNING',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: "Gadugi",
                          color: Colors.white,
                        )),
                    onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => QRViewExample(),
                  ),
                );
                   }
                  ),
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

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  String? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 36, 107, 1),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 10,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                  borderColor: const Color(0xFFF4CA41),
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400) ? 300.0 : 200.0,
                ),
              onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          const Expanded(
            flex: 1,
            child:Text(
              'Attendy',
               style: TextStyle(
               fontFamily: 'Gadugi',
                fontSize: 40 ,
               fontWeight: FontWeight.w900,
               color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  

  _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async  {
      setState(() {
        result = scanData.code;
        print("###################### $result");
        controller.pauseCamera();
      });
        List<String> information = result!.split("//");
        print("######################## $information" );
        print("######################## ${information[6]}" );
        final querySnapshot = await FirebaseFirestore.instance
        .collection('teacher')
        .where('email' , isEqualTo: information[6])
        .get();
        final _password = querySnapshot.docs.first.data()['password'];
        print("######################## ${_password.toString()}");
        if( _password.toString().contains(result!)) {
          print("################### founded ");
          final add_name = querySnapshot.docs.first;
          final _add_name = add_name.data()['student'] + ' ' + FirebaseAuth.instance.currentUser!.displayName;
          print("#################### $_add_name");
            await add_name.reference.update({
              'student' : _add_name,
              });
        } else {
          print("##################### not founded");
        }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
