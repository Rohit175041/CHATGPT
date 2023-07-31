import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../chatgpt/welcome.dart';

class LoginPhone extends StatefulWidget {
  const LoginPhone({Key? key}) : super(key: key);
  static String verify = " ";
  @override
  State<LoginPhone> createState() => _LoginPhoneState();
}

class _LoginPhoneState extends State<LoginPhone> {
  TextEditingController countryController = TextEditingController();
  String phoneNumber = " ";
  final storage = const FlutterSecureStorage();
  String otpcode = " ";
  int changeScreen = 0;

  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    countryController.text = "+91";
    super.initState();
  }

  Future<void> sendOTP() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: countryController.text + phoneNumber,
      timeout: const Duration(seconds: 120),
      verificationCompleted: (PhoneAuthCredential credential) {
        print("Auth completed");
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e);
        showSnackBar(Colors.red, "Auth Failed!");
      },
      codeSent: (String verificationId, int? resendToken) {
        LoginPhone.verify = verificationId;
        setState(() {
          changeScreen = 1;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        showSnackBar(Colors.red, "Timeout!");
      },
    );
  }

  Future<void> verifyOTP() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: LoginPhone.verify, smsCode: otpcode);

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential)
          .whenComplete(() {
        if (credential.smsCode == otpcode) {
          print("success");
        }
        print("${credential.smsCode}");
        print(otpcode);
        Navigator.pushAndRemoveUntil(
            context,
            PageRouteBuilder(
              pageBuilder: (context, a, b) => const welcome(),
              transitionDuration: const Duration(seconds: 2),
            ),
                (route) => false);
      });
      print(userCredential.user?.uid);
      await storage.write(key: 'uid', value: userCredential.user?.uid);
    } catch (e) {
      print("Wrong Otp");
      await storage.deleteAll();
      showSnackBar(Colors.red, "Wrong Otp");
      Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            pageBuilder: (context, a, b) => const LoginPhone(),
            transitionDuration: const Duration(seconds: 0),
          ),
              (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white30,
          margin: const EdgeInsets.only(left: 25, right: 25, top: 0),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: 250,
                    width: 250,
                    child: Lottie.asset('img/login.json')),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Phone Verification",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "verify your phone before getting started!",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                changeScreen == 0 ? phonescreen() : otpScreen()
              ],
            ),
          )),
    );
  }

  Widget phonescreen() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 40,
                child: TextField(
                  controller: countryController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              const Text(
                "|",
                style: TextStyle(fontSize: 33, color: Colors.grey),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: TextField(
                    // maxLength: 10,
                    onChanged: (value) {
                      if (value.length <= 10) {
                        phoneNumber = value;
                      }
                    },
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Phone",
                    ),
                  ))
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: double.infinity,
          // height: 50,
          height: MediaQuery.of(context).size.height * 0.07,
          child: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                    colors: <Color>[Colors.black26, Colors.lightBlueAccent],
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft)),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.transparent,
                    backgroundColor: Colors.transparent),
                onPressed: () async {
                  if (phoneNumber.length == 10) {
                    sendOTP();
                    print(LoginPhone.verify);
                    print(phoneNumber);
                  } else {
                    showSnackBar(Colors.red, "Enter Valid number");
                  }
                },
                child: const Text("Send the code ",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.white))),
          ),
        )
      ],
    );
  }

  Widget otpScreen() {
    return Column(
      children: [
        PinCodeTextField(
          keyboardType: TextInputType.phone,
          appContext: context,
          length: 6,
          onChanged: (value) {
            setState(() {
              otpcode = value;
            });
          },
          pinTheme: PinTheme(
            activeColor: Colors.black,
            selectedColor: Colors.red,
            inactiveColor: Colors.black26,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: double.infinity,
          // height: 50,
          height: MediaQuery.of(context).size.height * 0.07,
          child: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                    colors: <Color>[Colors.black26, Colors.lightBlueAccent],
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft)),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.transparent,
                    backgroundColor: Colors.transparent),
                onPressed: () async {
                  verifyOTP();
                },
                child: const Text("Verify Phone Number",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.white))),
          ),
          // child: ElevatedButton(
          //     style: ElevatedButton.styleFrom(
          //         backgroundColor: Colors.red.shade600,
          //         shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(10))),
          //     onPressed: () async {
          //       verifyOTP();
          //     },
          //     child: const Text("Verify Phone Number")),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: () {
                  setState(() {
                    changeScreen = 0;
                  });
                },
                child: const Text(
                  "Edit Phone Number ?",
                  style: TextStyle(color: Colors.blue),
                )),
            TextButton(
                onPressed: () {
                  setState(() {
                    changeScreen = 1;
                  });
                  sendOTP();
                },
                child: const Text(
                  "resend OTP",
                  style: TextStyle(color: Colors.blue),
                )),
          ],
        ),
        const SizedBox(height: 5)
      ],
    );
  }

  void showSnackBar(dynamic color, String text) {
    var snackBar = SnackBar(
        backgroundColor: color,
        duration: const Duration(seconds: 1),
        content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
