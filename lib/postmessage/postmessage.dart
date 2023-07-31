import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'homescreen.dart';

class Postmessage extends StatefulWidget {
  const Postmessage({Key? key}) : super(key: key);

  @override
  State<Postmessage> createState() => _PostmessageState();
}

class _PostmessageState extends State<Postmessage> {
  double radius = 5;
  User? user = FirebaseAuth.instance.currentUser;
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController hobbies = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Post Message"),
          centerTitle: true,
        ),
        body: Stack(
          children:[
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(32),
              // color: Colors.white54,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('img/formimage.jpg'),
                      fit: BoxFit.cover)),
            ),
            SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 14.0, right: 14, top: 50, bottom: 10),
              child: Scrollbar(
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      //name
                      TextFormField(
                        autofocus: false,
                        cursorWidth: 2,
                        cursorColor: Colors.black,
                        showCursor: true,
                        maxLength: 30,
                        controller: name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "required";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Enter name",
                          hintStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(radius),
                          ),
                          suffixIcon:
                              const Icon(Icons.person, color: Colors.black),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                        ),
                      ),

                      //age
                      TextFormField(
                        keyboardType: TextInputType.number,
                        autofocus: false,
                        cursorWidth: 2,
                        cursorColor: Colors.black,
                        showCursor: true,
                        maxLength: 3,
                        controller: age,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "required";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Enter age",
                          hintStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(radius),
                          ),
                          suffixIcon:
                              const Icon(Icons.offline_bolt, color: Colors.black),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                        ),
                      ),

                      //gender
                      TextFormField(
                        autofocus: false,
                        cursorWidth: 2,
                        cursorColor: Colors.black,
                        showCursor: true,
                        maxLength: 15,
                        controller: gender,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "required";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Enter gender",
                          hintStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(radius),
                          ),
                          suffixIcon: const Icon(Icons.perm_identity_outlined,
                              color: Colors.black),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                        ),
                      ),

                      //country name
                      TextFormField(
                        autofocus: false,
                        cursorWidth: 2,
                        cursorColor: Colors.black,
                        showCursor: true,
                        maxLength: 20,
                        controller: country,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "required";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Enter country name",
                          hintStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(radius),
                          ),
                          suffixIcon: const Icon(Icons.flag_outlined,
                              color: Colors.black),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      TextFormField(
                        autofocus: false,
                        cursorWidth: 2,
                        cursorColor: Colors.black,
                        showCursor: true,
                        maxLength: 150,
                        // maxLengthEnforcement: 3,
                        maxLines: 3,
                        controller: hobbies,
                        decoration: InputDecoration(
                          hintText: "Hobbies",
                          hintStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(radius),
                          ),
                          // suffixIcon: const Icon(Icons.location_city_sharp,color: Colors.black),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radius),
                              gradient: const LinearGradient(
                                  colors: <Color>[
                                    Colors.black26,
                                    Colors.lightBlueAccent
                                  ],
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft)),
                          child: ElevatedButton(
                              onPressed: () async {
                                validate();
                              },
                              style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.transparent,
                                  backgroundColor: Colors.transparent),
                              child: const Text("Next",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white))),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),]
        ));
  }

  //form validation
  void validate() {
    if (formkey.currentState!.validate() && name != null) {
      print("success");
      FirebaseFirestore.instance.collection('postmessage').add({
        'userid': user?.uid,
        'Postdate': DateTime.now(),
        'name': name.text,
        'age': age.text,
        'gender': gender.text,
        'country': country.text,
        'hobbies':hobbies.text
      }).whenComplete(() {
        showSnackBar(Colors.green, "uploaded");
        Navigator.pushAndRemoveUntil(
            context,
            PageRouteBuilder(
              pageBuilder: (context, a, b) => const HomeScreen(),
              transitionDuration: const Duration(seconds: 0),
            ),
                (route) => false);
      });
    } else {
      print("failed");
      showSnackBar(Colors.red, "failed");
    }
  }

  //alerts error messages
  void showSnackBar(dynamic color, String text) {
    var snackBar = SnackBar(
        backgroundColor: color,
        duration: const Duration(seconds: 1),
        content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
