import "dart:io";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_storage/firebase_storage.dart";
import "package:flutter/material.dart" ;
import "package:image_picker/image_picker.dart";
import "package:path/path.dart";

String account_type = ' account type ';
String username = ' User name';
String id = ' ID Card Num';
String email = ' E-mail ';
final TextEditingController description = TextEditingController();
class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil>  {

  bool is_get_data = false;


  void get_data() async  {
   bool trouve = false;
   await FirebaseFirestore.instance
  .collection('Student')
  .where('email' , isEqualTo: '${FirebaseAuth.instance.currentUser?.email}')
  .get()
  .then((value) {
    value.docs.forEach((element) { 
      account_type = 'Student';
      username = element.data()['username'];
      id = element.data()['id'];
      email = element.data()['email'];
      description.text = element.data()['description'];
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
      username = element.data()['username'];
      id = element.data()['id'];
      email = element.data()['email'];
      description.text = element.data()['description'];
      });
    });
  }
  setState(() {
    is_get_data = true;
  });
  }

  change_description(String account_type , String data) async {
    final querySnapshot = await FirebaseFirestore.instance
    .collection(account_type)
    .where('email' , isEqualTo: '${FirebaseAuth.instance.currentUser?.email}')
    .get();
    final user_info = querySnapshot.docs.first;
    await user_info.reference.update({
      'description' : data
    });
  }


  


  @override
  void initState() {
    get_data();
    super.initState();
  }
  bool visibility = false;
  String? image_url = ' ';
  profilePicture() async {
    var image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 75,
    );
    File file = File(image!.path);
    var name_image = basename(image.path);
    Reference reference = FirebaseStorage.instance.ref("images/$name_image");
    await reference.putFile(file);
    reference.getDownloadURL().then((value) {
      setState(() {
        image_url = value;
      });
    });
  }
  



  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: const Color.fromRGBO(0, 24, 71, 1),
          body: (!is_get_data) ? const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF001847),
              backgroundColor: Color.fromRGBO(117, 117, 117, 1),
            ),
          ):
          SafeArea(
            child: Container(
              decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("images/profile/profile.png") ,
              fit: BoxFit.cover),) , 
              child:  SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
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
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                          const SizedBox(width: 84
                          ) ,
                          const Text('Profile',
                          style: TextStyle(color: Colors.white,
                          fontSize: 30 ,
                          fontWeight: FontWeight.bold,
                          ),
                          )
                        ],
                        ),
                      ) ,
                      const SizedBox(height: 60,) ,
                      GestureDetector(
                        onTap: () async {
                          await profilePicture();
                        },
                        
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(500)),
                          ),
                          
                          child: ClipOval(
                           child : (image_url == ' ') ? Image.asset(
                            'images/profile/user.png',
                            fit: BoxFit.cover,
                            ) : Image.network(image_url!) ,
                        ),
                      ),
                      ),
                      const SizedBox(height: 09,),
                      Text(
                        username ,
                      style: const TextStyle(
                        fontFamily: 'Myfont',
                        fontSize: 30 ,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF00246B),
                      ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal : 20),
                        child: visibility ?
                             Row(
                              children: [
                                Expanded(
                                  child: TextField(
                              controller: description,
                              enabled: visibility,
                            ),
                                ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  visibility = !visibility;
                                });
                                change_description(account_type , description.text);
                              },
                              icon: const Icon(Icons.save),
                            ),
                              ]
                             ) : Card(shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                                ),
                          elevation: 5,
                          margin: const EdgeInsets.all(15),
                          child:  ListTile(
                            leading:IconButton(
                              onPressed: () {
                                setState(() {
                                  visibility = !visibility;
                                });
                              },
                              icon: const Icon(Icons.edit),
                            ), 
                            title: Text(
                              description.text ,
                        style: const TextStyle(
                          fontFamily: 'Myfont',
                          fontSize: 23 ,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00246B)
                            ),
                          ),
                        ) ,
                      ),
                          ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal : 20),
                        child: Card(shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                                ),
                          elevation: 5,
                          margin: const EdgeInsets.all(15),
                          child: ListTile(
                            leading:const Icon(Icons.mail), 
                            title: Text(
                              email,
                        style: const TextStyle(
                          fontFamily: 'Myfont',
                          fontSize: 23 ,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00246B)
                            ),
                          ),
                        ) , ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal : 20),
                        child: Card(shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                                ),
                          elevation: 5,
                          margin: const EdgeInsets.all(15),
                          child:  ListTile(
                            leading:const Icon(Icons.indeterminate_check_box_outlined), 
                            title: Text(
                              id ,
                        style: const TextStyle(
                          fontFamily: 'Myfont',
                          fontSize: 23 ,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00246B),
                            ),
                          ),
                        ) , ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal : 20),
                        child: Card(shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                                ),
                          elevation: 5,
                          margin: const EdgeInsets.all(15),
                          child: ListTile(
                            leading: const Icon(Icons.edit), 
                            title: Text(
                              account_type,
                          style: const TextStyle(
                          fontFamily: 'Myfont',
                          fontSize: 23 ,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00246B)
                            ),
                          ),
                        ) , ),
                      ),
                    ]
                  ),
            ),
          ),
          ),
          );

  }
}