import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';



class Shedule_student extends StatefulWidget {
  const Shedule_student({super.key});

  @override
  State<Shedule_student> createState() => _Shedule_studentState();
}

class _Shedule_studentState extends State<Shedule_student> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical:4),
          child: Container(
            height: 64,
            width: 369,
            decoration: BoxDecoration(
                color: const Color.fromRGBO(215, 215, 195, 1),
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.perm_contact_calendar_rounded,
                      color: Color.fromRGBO(0, 36, 107, 1),
                      size: 35,
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: const Color.fromRGBO(0, 36, 107, 1),
                    radius: 30,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.home,
                        color: Color.fromRGBO(244, 202, 65, 1),
                        size: 30,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.list_alt,
                      color: Color.fromRGBO(0, 36, 107, 1),
                      size: 35,
                    ),
                  ),
                ],
              ),
            ),
          ),
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
                  Navigator.of(context).pop();
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
                Navigator.of(context).pop();
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
        body: const ExamPage(),
      ),
    );
  }
}

class ExamPage extends StatefulWidget {
  const ExamPage({super.key});

  @override
  State<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
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
                fillColor: Colors.white,
                elevation: 10,
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "Sun",
                  style: TextStyle(
                    color: Color.fromRGBO(0, 36, 107, 1),
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
                fillColor: Colors.white,
                elevation: 10,
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "Man",
                  style: TextStyle(
                    color: Color.fromRGBO(0, 36, 107, 1),
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
                fillColor: Colors.white,
                elevation: 10,
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "Tue",
                  style: TextStyle(
                    color: Color.fromRGBO(0, 36, 107, 1),
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
                fillColor: Colors.white,
                elevation: 10,
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "Wed",
                  style: TextStyle(
                    color: Color.fromRGBO(0, 36, 107, 1),
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
                fillColor: Colors.white,
                elevation: 10,
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "The",
                  style: TextStyle(
                    color: Color.fromRGBO(0, 36, 107, 1),
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
                Navigator.of(context).pop();
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
                child: RawMaterialButton(
                  onPressed: () {},
                  fillColor: const Color.fromRGBO(119, 133, 255, 1),
                  elevation: 10,
                  padding: const EdgeInsets.only(
                      right: 100, left: 20, top: 30, bottom: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Text(
                    'Cour / TD -Module \n\nyear-N°group-salle',
                    style: TextStyle(
                      color: Color.fromRGBO(0, 36, 107, 1),
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
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
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: RawMaterialButton(
                  onPressed: () {},
                  fillColor: const Color.fromRGBO(244, 202, 65, 1),
                  elevation: 10,
                  padding: const EdgeInsets.only(
                      right: 100, left: 20, top: 30, bottom: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Text(
                    'Cour / TD -Module \n\nyear-N°group-salle',
                    style: TextStyle(
                      color: Color.fromRGBO(0, 36, 107, 1),
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
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
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 25),
                child: RawMaterialButton(
                  onPressed: () {},
                  fillColor: const Color.fromRGBO(187, 187, 187, 1.0),
                  elevation: 10,
                  padding: const EdgeInsets.only(
                      right: 100, left: 20, top: 30, bottom: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Text(
                    'Cour / TD -Module \n\nyear-N°group-salle',
                    style: TextStyle(
                      color: Color.fromRGBO(0, 36, 107, 1),
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
