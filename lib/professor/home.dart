import 'package:flutter/material.dart';

class Home_prof extends StatefulWidget {
  const Home_prof({super.key});

  @override
  State<Home_prof> createState() => _Home_profState();
}

class _Home_profState extends State<Home_prof> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
          title: const Text("App name"),
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
            padding: const EdgeInsets.only(left: 15),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.menu,
                color: Color.fromRGBO(173, 173, 173, 1),
                size: 30,
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
                image: AssetImage("images/Home/BGH.jpg"), fit: BoxFit.cover)),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 1),
            child: CircleAvatar(
              backgroundColor: const Color.fromRGBO(0, 24, 71, 1),
              radius: 22.6,
              child: SizedBox(
                width: 62,
                height: 62,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Color.fromRGBO(173, 173, 173, 1),
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: SizedBox(
              height: 62,
              width: 62,
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const CircleAvatar(
                    radius: 62,
                    backgroundImage: AssetImage('images/Home/User.jpg'),
                  )),
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
                onPressed: () {},
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: TextButton(
                  onPressed: () {},
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
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: TextButton(
                  onPressed: () {},
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
