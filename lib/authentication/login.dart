import 'dart:ui';
import 'package:attendy_/screens/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

showLoading(context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Container(
          height: 50,
          child: const Center(
            child: CircularProgressIndicator(
              color:  Color.fromRGBO(0, 36, 107, 1),
            ),
          ),
        ),
      );
    }
  );
}

class _LoginState extends State<Login> {
  late final TextEditingController  _username;
  late final TextEditingController  _password;

  Future<String> get_email(String username) async {
    String email = ' ';
    CollectionReference<Map<String, dynamic>> my_user_ref = FirebaseFirestore.instance.collection("Student");
    QuerySnapshot<Map<String, dynamic>> snapchot = await my_user_ref.where('username' , isEqualTo: username).get();
    if (snapchot.docs.isNotEmpty) {
      email = snapchot.docs.first.data()['email'];
    } else {
      my_user_ref = FirebaseFirestore.instance.collection('teacher');
      snapchot = await my_user_ref.where('username' , isEqualTo: username).get();
      if (snapchot.docs.isNotEmpty) {
        email = snapchot.docs.first.data()['email'];
      }
    }
    return email;
  }
  
  Future<String> get_account_type(String email) async {
    String account_type = 'Student';
    CollectionReference<Map<String, dynamic>> my_user_ref = FirebaseFirestore.instance.collection("Student");
    QuerySnapshot<Map<String, dynamic>> snapchot = await my_user_ref.where('email' , isEqualTo: email).get();
    if (snapchot.docs.isEmpty) {
      account_type = 'teacher';
    }
    return account_type;
  }

  Future<void> signup(String email , String password) async {
    if (email == ' ') {
     showDialog(
          context: context,
          builder: (BuildContext context) {      
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
                  )
                ),
                title: Row(
                  children: [
                    const SizedBox(width: 25,),
                    const Text(
                      'user not found ',
                      style: TextStyle(
                        color: Color(0xFF00246B),
                        fontFamily: 'Gadugi'),
                      ),
                      const SizedBox(width: 20,),
                  ],
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 18.0),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState((){
                          Navigator.of(context).pop(false);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF4CA41)
                      ),
                      child: const Text(
                          ' correct username ',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Gadugi'
                          ),
                        )
                      )
                   ],
                ),
              ),
            );
          } 
        );
    } else {
      User? user = FirebaseAuth.instance.currentUser;
      try{
        showLoading(context);
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
        );
        print(userCredential);
        String account_type = await get_account_type(email);
        if (account_type == "Student") {
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/home_student/',
            (route) => false,
          );
        } else {
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/home_prof/',
            (route) => false,
          );
        }
      } on FirebaseAuthException catch (e) {
        Navigator.of(context).pop(false);
        showDialog(
          context: context,
          builder: (BuildContext context) {      
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
                  )
                ),
                title: Row(
                  children: [
                    const SizedBox(width: 25,),
                    Text(
                      '${e.code} ',
                      style:  const TextStyle(
                        color: Color(0xFF00246B),
                        fontFamily: 'Gadugi'),
                      ),
                      const SizedBox(width: 20,),
                  ],
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 18.0),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState((){
                          Navigator.of(context).pop(false);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF4CA41)
                      ),
                      child: const Text(
                          ' fill it again ',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Gadugi'
                          ),
                        )
                      )
                   ],
                ),
              ),
            );
          } 
        );
      }
    }
  }
  
  @override
  void initState() {
    _username = TextEditingController();
    _password = TextEditingController();
    get_email("amina_ghandouz");
    super.initState();
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  bool eye = true;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(0, 36, 107, 1),
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/welcome_page/',
                (route) => false,
              );
            },
            icon: const Icon(
              Icons.chevron_left,
              color: Colors.white,
              size: 50,
            ),
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
      Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/Login/backlogin.png"),
                fit: BoxFit.cover)),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Text(
              'Welcome\nBack ! ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 43,
                fontFamily: "Tahoma",
                fontWeight: FontWeight.w700,
              ),
            ),
          ), //Welcome
          const SizedBox(
            height: 25,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'Hey ! Good to see you again .',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: "Tahoma",
              ),
            ),
          ), //Hey ! Good
          const SizedBox(
            height: 40,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'Log in',
              style: TextStyle(
                color: Colors.white,
                fontSize: 35,
                fontFamily: "Tahoma",
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextField(
              controller: _username,
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  hintText: "User name",
                  hintStyle:
                  TextStyle(color: Colors.white, fontFamily: "Consola"),
                  prefixIcon: Icon(
                    Icons.account_circle,
                    color: Colors.white,
                  )),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _password,
              style: const TextStyle(color: Colors.white),
              obscureText: eye,
              decoration: InputDecoration(
                  hintText: "Pass word",
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          eye = !eye;
                        });
                      },
                      icon: Icon(
                        eye ? Icons.visibility_off : Icons.visibility,
                      )),
                  hintStyle: const TextStyle(
                      color: Colors.white, fontFamily: "Consola"),
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.white,
                  )),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: RawMaterialButton(
                onPressed: () async {
                  final password = _password.text;
                  final username = _username.text;
                  final email = await get_email(username);
                  signup(email, password);
                },
                fillColor: const Color.fromRGBO(253, 208, 64, 1.0),
                elevation: 0.0,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Text(
                  "Log in",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontFamily: "Gadugi",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Did you forget your password ?  ",
                  style: TextStyle(
                    color: Color.fromRGBO(0, 36, 107, 1),
                    fontFamily: "Gadugi",
                    fontSize: 12,
                  ),
                ),
                TextButton(
                  child: const Text(
                    "Reset your password",
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontFamily: "Gadugi",
                      fontSize: 12,
                    ),
                  ),
                  onPressed: () async {
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
                            title:
                                const Text('send email for reset!!',
                                style: TextStyle(
                                  color: Color(0xFF00246B),
                                  fontFamily: 'Gadugi',
                                ),
                              ),                              
                          contentPadding: const EdgeInsets.symmetric(vertical: 18.0),
                          content: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [  
                              const SizedBox(
                                width: 30.0,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                   backgroundColor: const Color(0xFFF4CA41)
                                  ),
                                   onPressed: () async {
                                    final username = _username.text;
                                    final email = await get_email(username);
                                    final user = FirebaseAuth.instance.currentUser;
                                    await user?.updatePassword(AutofillHints.newPassword);
                                    await FirebaseAuth.instance.sendPasswordResetEmail(
                                      email: email,
                                    );
                                    Navigator.of(context).pop(false);
                                   },
                                   child: const Text(
                                    'yeah',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Gadugi',
                                    ),
                                  )
                                ),
                                const SizedBox(
                                  width: 50.0,
                                ),
                                ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                   backgroundColor: const Color(0xFFF4CA41)
                                  ),
                                   onPressed: () async {
                                    Navigator.of(context).pop(false);
                                   },
                                   child: const Text(
                                    'cancel',
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
            ),
          ),
        ],
      ),
    ])
      ),
    );
  }
}
