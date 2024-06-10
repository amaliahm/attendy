import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';


class NotificationPage extends StatefulWidget {
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  
  String account_type = ' account type ';
  

  
  //bool is_get_data = false;


  void get_data() async  {
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
  // setState(() {
  //   is_get_data = true;
  // });
  }

  final List<NotificationData> notifications = [
    NotificationData(
      time: "10:30 AM",
      icon: Icons.mail,
      name: "John Smith",
      note: "You have a new message",
    ),
    NotificationData(
      time: "12:45 PM",
      icon: Icons.notification_add_sharp,
      name: "Jane Doe",
      note: "Reminder: Meeting at 2 PM",
    ),
    NotificationData(
      time: "2:15 PM",
      icon: Icons.calendar_today,
      name: "Alex Johnson",
      note: "Event starting in 45 minutes",
    ),
    NotificationData(
      time: "4:00 PM",
      icon: Icons.check_circle_outline,
      name: "David Lee",
      note: "Task completed",
    ),
  ];

  @override
  void initState() {
    get_data();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 24, 71, 1),
          body: 
          // (!is_get_data) ? const Center(
          //   child: CircularProgressIndicator(
          //     color: Color.fromRGBO(0, 24, 71, 1),
          //     backgroundColor: Color.fromRGBO(117, 117, 117, 1),
          //   ),
          // ):
          Stack(
          children:[
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/notification/backnotif.jpg'),
                    fit: BoxFit.cover)),
          )
          ,
      Column(
        children: [
          const SizedBox(height: 10,)
         , Container(
                            padding: const EdgeInsets.all(30) ,
                            child:  Row(
                              children: [
                                IconButton(
                                  onPressed: () {
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
                                icon: 
                                const Icon(Icons.arrow_back_ios ,
                              size: 35,
                              color: Color(0xFFBFBFBF),
                              
                              ) ,),
                              const SizedBox(width: 59
                              ) ,
                              Text('Notification',
                              style: TextStyle(color: Colors.white,
                              fontSize: 30 ,
                              fontWeight: FontWeight.bold, fontFamily: 'Gadugi'

                              ),
                              
                              
                              )
                          
                          
                          
                            ],
                          
                          
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ), 
                           ( notifications.isEmpty) ? Column(
                             children: [
             const  SizedBox(height: 0,),
             const Padding(
               padding: EdgeInsets.symmetric(horizontal: 10),
               child: Text('You dont have any notifications',style: TextStyle(fontSize: 22,color:Color(0xFF4F5054), fontFamily: 'Gadugi' ), ),
             ),
             const SizedBox(
             height: 60,
             ),
             const Text('Come back later !',style: TextStyle(fontSize: 25,color:Color(0xFF4F5054) , fontFamily: 'Gadugi'), ),
             const SizedBox(
             height:60,
             ),
             Image.asset('images/notification/nonotification.jpg'),
                             ],
                             

                           ) : 

       Expanded(
         child: ListView.builder(
           itemCount: notifications.length,
           itemBuilder: (context, index) {
             final notification = notifications[index];
             
             return  Padding(
               padding: const EdgeInsets.symmetric(horizontal: 3),
               child: Column(
                 children: [
                  
                   Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.black),
                       borderRadius: BorderRadius.circular(12),
                       boxShadow:[ BoxShadow(
                         color: Colors.grey.withOpacity(0.1),
                         spreadRadius:12,
                         blurRadius: 7,
                         offset: const Offset(0, 3)
                       )
                     ]),
                             child: ListTile(
                       leading: Icon(notification.icon,
                       color: const Color(0xFF00246B),),
                       title: Text(notification.name,
                       style: const TextStyle(color: Color(0xFF00246B),
                       fontSize: 25
                       ),),
                       subtitle: Text(notification.note),
                       trailing: Text(notification.time),
                     ),
                     
                   ),
                   const SizedBox(
                    height: 5,
                   )
                 ],
               ),
             );
           },
         ),
       ), 
       ],
      ) 
    ]));
  }
}

class NotificationData {
  final String time;
  final IconData icon;
  final String name;
  final String note;

  NotificationData({
    required this.time,
    required this.icon,
    required this.name,
    required this.note,
  });
}






