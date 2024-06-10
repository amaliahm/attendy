// ignore_for_file: avoid_print
import 'dart:ui';
import 'package:attendy_/authentication/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Colors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


List<String> list = <String>['Student', 'teacher'];
bool hide = true;
String emailErrorText = '';
String dropdownValue = list.first;
String account_type = ' ';
bool _error_email = false;
bool _error_username = false;
bool _error_id = false;
bool _error_password = false;

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  late final TextEditingController  _email;
  late final TextEditingController _password;
  late final TextEditingController _id;
  late final TextEditingController _username;

  Future<void> createUser(String email, String password , String username , String account_type) async {
    final user_exists = await check_user(account_type, email);
    if (user_exists) {
    try{
      showLoading(context);
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user!.updateDisplayName(username);
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
                    const Text(
                      'verify your eamil ',
                      style: TextStyle(
                        color: Color(0xFF00246B),
                        fontFamily: 'Gadugi'),
                      ),
                      const SizedBox(width: 20,),
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
                    ElevatedButton(
                      onPressed: () async {
                          await userCredential.user!.sendEmailVerification();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            '/login/',
                            (route) => false,
                          );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF4CA41)
                      ),
                      child: const Text(
                          'send email verification',
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
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop(false);
      if (e.code == 'weak-password'){
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
                    const Text(
                      'weak password ',
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
                          ' rewrite ',
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
      else if (e.code == 'email-already-in-use'){
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
                      'email already in use ',
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
                          ' change email ',
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
    } catch (e) {
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
                      'there is problem ',
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
    } else {
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
                      "email doesn't exist",
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
                          ' change email ',
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

  Future<bool> check_user(String the_account_type ,String the_email) async{
    final my_user_ref = FirebaseFirestore.instance.collection(the_account_type);
    final querySnapshot = await my_user_ref
    .where("email" , isEqualTo: the_email)
    .get();
    return querySnapshot.docs.isNotEmpty;
  }

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _id = TextEditingController();
    _username = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
     _email.dispose();
     _password.dispose();
     _id.dispose();
     _username.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    icon: const Icon(
                      Icons.chevron_left,
                      color: kSign,
                      size: 50,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          '/welcome_page/',
                          (route) => false,
                        );
                      },
                    ),
                    backgroundColor: kBar,
                    elevation: 0),
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    resizeToAvoidBottomInset: false,
                    body: Stack(children: [
                      Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  "images/Signup/backgroundimage2.jpg",
                                ),
                                fit: BoxFit.cover,
                            ),
                        ),
                      ),
                      Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(49, 10, 190, 34),
                child: Text(
                  'Sign up',
                  style: TextStyle(
                    color: kSign,
                    fontSize: 40,
                    fontFamily: 'Tahoma',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 33),
                child: Text(
                  'We are happy to see you here !',
                  style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'Tahoma',
                      fontWeight: FontWeight.w400,
                      color: kSign),
                ),
              ),
               Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _error_email = !value.contains("@esi-sba.dz");
                      });
                    },
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    decoration:  InputDecoration(
                        hintText: "E-mail",
                        errorText: _error_email ? " your ecole's email  " : null,
                        hintStyle: const  TextStyle(color: kField),
                        prefixIcon: const Icon(Icons.email),
                        ),
                  )),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding:const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _error_username = value.contains(" ");
                    });
                  },
                  controller: _username,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: "Username",
                      errorText: _error_username ? "don't use space" :null,
                      hintStyle:const  TextStyle(color: kField),
                      prefixIcon:const  Icon(Icons.person)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _error_password = (value.length < 8);
                    });
                  },
                  controller: _password,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: hide,
                  decoration: InputDecoration(
                      hintText: "Password",
                      errorText: _error_password ? "password is less than 8 " : null,
                      hintStyle: const TextStyle(color: kField),
                      prefixIcon: const Icon(Icons.key),
                      suffixIcon: IconButton(
                          icon: Icon(
                            hide ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              hide = !hide;
                            });
                          }
                        )
                      ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _error_id = (value.length != 12);
                    });
                  },
                  controller: _id,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: "ID card number",
                      errorText: _error_id ? "id is 12 numbers" : null,
                      hintStyle: const TextStyle(color: kField),
                      prefixIcon: const Icon(Icons.payment)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
               Padding(
                  padding:const  EdgeInsets.symmetric(horizontal: 40),
                  child: DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 16,
      style: const TextStyle(color: kField),
      underline: Container(
        height: 1.5,
        color: const Color.fromARGB(255, 172, 169, 169),
      ),
      onChanged: (String? value) {
        setState(() {
          dropdownValue = value!;
          account_type = dropdownValue;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 6),
                child: Icon(Icons.person_2_outlined),
              ),
               const SizedBox(width: 5,),
              Text(value),
              const SizedBox(width: 195,),
            ],
          ),
        );
      }).toList(),
    )
    ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: RawMaterialButton(
                        onPressed: () async {
                          final email = _email.text;
                          final password = _password.text;
                          final id = _id.text;
                          final username = _username.text;
                          await createUser(email, password, username , account_type);
                        },
                        fillColor: kButton,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                        child: const Text(
                          'Sign up',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Gadugi'),
                        ),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account  ',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontFamily: 'gadugi-normal')),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            '/login/',
                            (route) => false,
                          );
                        },
                        child: const Text(
                          'Log in',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.red,
                              fontFamily: 'gadugi-normal',
                            ))),
                  ],
                ),
              )
            ],
          ),
        ]),
      
    
              );
            }
}