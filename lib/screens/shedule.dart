import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class Shedule extends StatefulWidget {
  const Shedule({super.key});

  @override
  State<Shedule> createState() => _SheduleState();
}

class _SheduleState extends State<Shedule> {


  
  bool is_get_account_type = false;
  String account_type = " account type ";

  void get_account_type() async  {
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
  setState(() {
    is_get_account_type = true;
  });
  }


  

  String jour = DateFormat.yMMMEd().format(DateTime.now());
  @override
  void initState() {
    print("########## $jour");
    get_account_type();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: const Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10, vertical:4),
        ),
        appBar: AppBar(
          title: const Text("Shedule"),
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(0, 36, 107, 1),
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: IconButton(
                onPressed: () {
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
            padding: const EdgeInsets.only(left: 5),
            child: IconButton(
              onPressed: () {
                if (account_type == 'Student'){
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/home_student/',
                    (route) => false,
                  );
                } else if (account_type == 'teacher'){
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/home_prof/',
                    (route) => false,
                  );
                } else {
                  Navigator.of(context).pop(false);
                }
              },
              icon: const Icon(
                Icons.chevron_left,
                color: Color.fromRGBO(173, 173, 173, 1),
                size: 45,
              ),
            ),
          ),
        ),
        resizeToAvoidBottomInset: false,
        body:(!is_get_account_type) ? const Center(
            child: CircularProgressIndicator(
              color: Color.fromRGBO(0, 24, 71, 1),
              backgroundColor: Color.fromRGBO(117, 117, 117, 1),
            ),
          ): Stack(children: [
      Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/Classes/background.jpg"),
                fit: BoxFit.cover)),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 50),
            child: SizedBox(
              height: 53,
              width: 65,
              child: RawMaterialButton(
                onPressed: () {},
                fillColor: jour.startsWith("Sun") ? const Color.fromRGBO(0, 36, 107, 1) : Colors.white,
                elevation: 10,
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Sun",
                  style: TextStyle(
                    color: jour.startsWith("Sun") ? Colors.white :const  Color.fromRGBO(0, 36, 107, 1),
                    fontSize: 18,
                    fontFamily: "Gadugi",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 50),
            child: SizedBox(
              height: 53,
              width: 65,
              child: RawMaterialButton(
                onPressed: () {},
                fillColor:jour.startsWith("Mon") ? const Color.fromRGBO(0, 36, 107, 1) : Colors.white,
                elevation: 10,
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Mon",
                  style: TextStyle(
                    color: jour.startsWith("Mon") ? Colors.white :const  Color.fromRGBO(0, 36, 107, 1),
                    fontSize: 18,
                    fontFamily: "Gadugi",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 50),
            child: SizedBox(
              height: 53,
              width: 65,
              child: RawMaterialButton(
                onPressed: () {},
                fillColor: jour.startsWith("Tue") ? const Color.fromRGBO(0, 36, 107, 1) : Colors.white,
                elevation: 10,
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Tue",
                  style: TextStyle(
                    color: jour.startsWith("Tue") ? Colors.white :const  Color.fromRGBO(0, 36, 107, 1),
                    fontSize: 18,
                    fontFamily: "Gadugi",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 50),
            child: SizedBox(
              height: 53,
              width: 65,
              child: RawMaterialButton(
                onPressed: () {},
                fillColor: jour.startsWith("Wed") ? const Color.fromRGBO(0, 36, 107, 1) : Colors.white,
                elevation: 10,
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Wed",
                  style: TextStyle(
                    color: jour.startsWith("Wed") ? Colors.white :const  Color.fromRGBO(0, 36, 107, 1),
                    fontSize: 18,
                    fontFamily: "Gadugi",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 50),
            child: SizedBox(
              height: 53,
              width: 65,
              child: RawMaterialButton(
                onPressed: () {},
                fillColor: jour.startsWith("The") ? const Color.fromRGBO(0, 36, 107, 1) : Colors.white,
                elevation: 10,
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "The",
                  style: TextStyle(
                    color: jour.startsWith("The") ? Colors.white :const  Color.fromRGBO(0, 36, 107, 1),
                    fontSize: 18,
                    fontFamily: "Gadugi",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 130),
            child: Text(
              'Today’s Tasks',
              style: TextStyle(
                color: Color.fromRGBO(0, 36, 107, 1),
                fontSize: 23,
                fontFamily: "Gadugi",
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: () {
              },
              icon: const Icon(
                Icons.add_circle,
                color: Color.fromRGBO(0, 36, 107, 1),
                size: 35,
              ),
            ),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(top: 200, left: 60, right: 30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                child: Text(
                  '8 AM - 10 AM',
                  style: TextStyle(
                    color: Color.fromRGBO(107, 107, 107, 1),
                    fontSize: 15,
                    fontFamily: "Gadugi",
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Color.fromARGB(209, 217, 217, 217),
                        width: 2.0,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                           Color.fromRGBO(119, 133, 255, 1),
                          Colors.white,
                        ],
                         stops: [0.07, 0.07],
                      ),
                    ),
                    padding: const EdgeInsets.only(
                        right: 100, left: 20, top: 30, bottom: 30),
                  child: RawMaterialButton(
                    onPressed: () {
                      if (account_type == 'teacher') {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          '/create_qr_code/',
                          (route) => false,
                        );
                      }
                    },
                    elevation: 10,
                      child:const Text(
                        'TD -analyse \n\n2cp-groupe6-salle6',
                        style: TextStyle(
                          color: Color.fromRGBO(0, 36, 107, 1),
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    
                   
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                child: Text(
                  '10 AM - 12 PM',
                  style: TextStyle(
                    color: Color.fromRGBO(107, 107, 107, 1),
                    fontSize: 15,
                    fontFamily: "Gadugi",
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Color.fromARGB(209, 217, 217, 217),
                        width: 2.0,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                           Color.fromRGBO(244, 202, 65, 1),
                          Colors.white,
                        ],
                         stops: [0.07, 0.07],
                      ),
                    ),
                    padding: const EdgeInsets.only(
                        right: 100, left: 20, top: 30, bottom: 30),
                  child: RawMaterialButton(
                    onPressed: () {},
                    elevation: 10,
                      child:const Text(
                        'Cour / TD -Module \n\nyear-N°group-salle',
                        style: TextStyle(
                          color: Color.fromRGBO(0, 36, 107, 1),
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    
                   
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                child: Text(
                  '2 PM - 4 PM',
                  style: TextStyle(
                    color: Color.fromRGBO(107, 107, 107, 1),
                    fontSize: 15,
                    fontFamily: "Gadugi",
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Color.fromARGB(209, 217, 217, 217),
                        width: 2.0,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color.fromRGBO(187, 187, 187, 1.0),
                          Colors.white,
                        ],
                         stops: [0.07, 0.07],
                      ),
                    ),
                    padding: const EdgeInsets.only(
                        right: 100, left: 20, top: 30, bottom: 30),
                  child: RawMaterialButton(
                    onPressed: () {},
                    elevation: 10,
                      child:const Text(
                        'Cour / TD -Module \n\nyear-N°group-salle',
                        style: TextStyle(
                          color: Color.fromRGBO(0, 36, 107, 1),
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
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
