import 'package:flutter/material.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.chevron_left,
              color: Colors.white,
              size: 50,
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
  bool eye = true;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: TextField(
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
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
                onPressed: () {},
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
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    ]);
  }
}
