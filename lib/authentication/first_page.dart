import "package:flutter/material.dart";

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 216, 168, 168),
            body:  Container(decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("images/welcome_page/image1.png") ,
            
       
              fit: BoxFit.cover),) , 

            
              child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                                          
                  
                  Image.asset("images/welcome_page/image2.png"),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25 ),
                      child: InkWell(
                        onTap: (){
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            '/login/',
                            (route) => false,
                          );
                        },
                      splashColor: Colors.white,
                      highlightColor: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(color:const  Color(0xFF00246B) ,
                          borderRadius: BorderRadius.circular(12),
                          
                          
                          ),
                          padding: const EdgeInsets.all(20),
                          child: const Center(child: Text('Log in',
                          style: TextStyle(
                            fontFamily: 'Gadugi-normal',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            letterSpacing: 3
                          ),
                          )),
                        ),
                      ),
                    ) ,
                    const SizedBox(height: 15) ,
                    TextButton(
                      onPressed: (){
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          '/signup/',
                          (route) => false,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                          decoration: BoxDecoration(color:const  Color.fromARGB(255, 255, 255, 255) ,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(width: 2 , color:const Color(0xFF00246B) )
                          
                          ),
                          padding: const EdgeInsets.all(20),
                          child: const Center(child: Text('Sign up',
                          style: TextStyle(
                            fontFamily: 'Myfont',
                            color: Color(0xFF00246B),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            letterSpacing: 3
                          ),)))
                        ),
                    )
                  ]),
            ),
            )
          );
  }
}

