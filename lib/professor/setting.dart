import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



bool _isEnabled = false;
List<String> list = <String>['ENGLISH', 'FRENCH','ARABIC'];

class Setting_prof extends StatefulWidget {
  const Setting_prof({super.key});

  @override
  State<Setting_prof> createState() => _Setting_profState();
}

class _Setting_profState extends State<Setting_prof> {
  
  String dropdownValue = list.first;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        resizeToAvoidBottomInset: false,
        body: Stack(
          children:[
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/Home/setting_back.jpg'),
                    fit: BoxFit.cover)),
          )
          ,
          Padding(
            padding: const EdgeInsets.fromLTRB(10,30,10,10),
            child: IconButton(
                icon: const Icon(
                  Icons.chevron_left,
                  color: Colors.black38,
                  size: 50,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/home_prof/',
                    (route) => false,
                  );
                },
              ),
          ),
          
           Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 90,
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(26, 23.37, 190, 56),
                  child: Text(
                    'Settings',
                    style: TextStyle(
                      color: Color(0xFF00246B),
                      fontSize: 30,
                      fontFamily: 'Gadugi',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Padding(
                  padding:  EdgeInsets.fromLTRB(38,0,0,0),
                  child: Text(
                    'Account',style: TextStyle(
                      color: Color(0xFF6B6B6B),
                      fontFamily: 'Gadugi',
                      fontSize: 24,
                      fontWeight: FontWeight.w700
                    ),
                
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(36,30,0,10),
                  child: ListTile(iconColor: Colors.black,
                    trailing: Transform.translate(
                      offset: const Offset(-35, 0),
                      child:const  Icon(Icons.chevron_right,size: 32)),
                    title: const Text('Edit Profile',
                    style: TextStyle(
                      fontFamily: 'Gadugi',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black
                    ),),
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        '/profile/',
                        (route) => false,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(36,0,0,10),
                  child: ListTile(iconColor: Colors.black,
                    trailing: Transform.translate(
                      offset: const Offset(-35, 0),
                      child: const Icon(Icons.chevron_right,size: 32)),
                    title: const Text('Change Password',
                    style: TextStyle(
                      fontFamily: 'Gadugi',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black
                    ),),
                    onTap: () {
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
                                    final email = await FirebaseAuth.instance.currentUser!.email;
                                    final user = FirebaseAuth.instance.currentUser;
                                    await user?.updatePassword(AutofillHints.newPassword);
                                    await FirebaseAuth.instance.sendPasswordResetEmail(
                                      email: email!,
                                    );
                                    Navigator.of(context).pop(false);
                                   },
                                   child: const Text(
                                    ' OK ',
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
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(36,0,0,10),
                  child: ListTile(iconColor: Colors.black,
                    
                    title: Text('Initialize',
                    style: TextStyle(
                      fontFamily: 'Gadugi',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black
                    ),),
                    onTap: () {
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(36,0,0,10),
                  child: ListTile(iconColor: Colors.black,
                    
                    title: const Text('Remove',
                    style: TextStyle(
                      fontFamily: 'Gadugi',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black
                    ),),
                    onTap: () {
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(22,0,0,20),
                  child: ListTile(
                    iconColor:const  Color(0xFF6B6B6B),
                    trailing: Transform.translate(
                      offset: const Offset(-35, 0),
                      child: IconButton(
          icon: _isEnabled ? const Icon(Icons.toggle_on_outlined,size: 42,) : const  Icon(Icons.toggle_off_outlined,size: 42),
          onPressed:(){
          setState(() {
              _isEnabled = !_isEnabled;
            });}
              )),
                    title:const  Text('Notifications',
                    style: TextStyle(
                      fontFamily: 'Gadugi',
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF6B6B6B)
                    ),),
                   
                  ),
                ),
                const Padding(
                  padding:  EdgeInsets.fromLTRB(38,0,0,0),
                  child: Text(
                    'Languages',style: TextStyle(
                      color: Color(0xFF6B6B6B),
                      fontFamily: 'Gadugi',
                      fontSize: 24,
                      fontWeight: FontWeight.w700
                    ),
                
                        ),
                ),
                  Padding(
                    padding: const  EdgeInsets.fromLTRB(38,25,0,0),
                    child: DropdownButton<String>(
      value: dropdownValue,
      icon: Transform.translate(
                            offset: Offset(-35, 0),

        child: const Icon(Icons.arrow_drop_down,size: 32)),
      elevation: 16,
      style: const TextStyle(color: Colors.black,
       fontFamily: 'Gadugi',
                    fontSize: 17,
                    fontWeight: FontWeight.w700,),
      
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      
      items: list.map<DropdownMenuItem<String>>((String value) {

        return DropdownMenuItem<String>(
          
          value: value,
          
          
          child: Row(
            
            children: [
              
              const Padding(
                
                padding: EdgeInsets.symmetric(horizontal: 6),
                child: Icon(Icons.language),
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
        
                ]
           
        ),
        ]),
    




     ) );
  }
}
class NotificationTile extends StatefulWidget {
  @override
  _NotificationTileState createState() => _NotificationTileState();
}

class _NotificationTileState extends State<NotificationTile> {

  
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
  }