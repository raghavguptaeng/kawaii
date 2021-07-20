import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kawaii/Screens/HomeScreens/HomeScreen.dart';

import '../../constants.dart';

class Login extends StatefulWidget {
  static String id = '/loginScreen';
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isOtpSent = false;
  late String phoneNUmber;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();
  late String _verificationId;

  void showSnackbar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  void verifyPhoneNumber() async {
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      await _auth.signInWithCredential(phoneAuthCredential);
      showSnackbar(
          "Phone number automatically verified and user signed in: ${_auth.currentUser!.uid}");
    };
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      showSnackbar(
          'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
    };
    PhoneCodeSent codeSent =
        (String verificationId, [int? forceResendingToken]) {
      showSnackbar('Please check your phone for the verification code.');
      _verificationId = verificationId;
    };
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      showSnackbar("verification code Sent");
      _verificationId = verificationId;
    };
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: "+91 " + _phoneNumberController.text,
          timeout: const Duration(seconds: 5),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      showSnackbar("Failed to Verify Phone Number: $e");
    }
  }
  void signInWithPhoneNumber() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: _smsController.text,
      );

      final User? user = (await _auth.signInWithCredential(credential)).user;
      FirebaseFirestore.instance.collection('cust').doc(FirebaseAuth.instance.currentUser!.uid).set({});
      showSnackbar("Successfully signed");
      Navigator.pushReplacementNamed(context, HomeScreen.id);
    } catch (e) {
      showSnackbar("Failed to sign in: " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    try{
      return (Platform.isIOS || Platform.isAndroid)?Scaffold(
        backgroundColor: Color(0xFFF9F9F9),
        body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  LoginText(),
                  OptAndPhoneNumber(),
                  OTP_LoginButton(),
                  WrongPhoneNumber(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                  )
                ],
              ),
            )),
      ):Scaffold();
    }
    catch(e){
      //return LoginAdmin();
    }
    return Scaffold(
      backgroundColor: Color(0xFFF9F9F9),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                LoginText(),
                OptAndPhoneNumber(),
                OTP_LoginButton(),
                WrongPhoneNumber(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                )
              ],
            ),
          )),
    );
  }

  GestureDetector WrongPhoneNumber() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isOtpSent = false;
        });
      },
      child: Text(
        "Wrong number ? enter again",
        style: TextStyle(fontSize: 18, color: LoginColor),
      ),
    );
  }

  GestureDetector OTP_LoginButton() {
    return GestureDetector(
      onTap: () async {
        if(isOtpSent == false){
          setState(() {
            verifyPhoneNumber();
            isOtpSent = true;
          });
        }
        else{
          signInWithPhoneNumber();
          //Navigator.pushReplacementNamed(context, MainScreen.id);
        }
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: LoginColor, borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Text(
            (isOtpSent) ? "Login" : "Get OTP",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Center OptAndPhoneNumber() {
    return Center(
      child: Column(
        children: [
          TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                phoneNUmber = value;
              });
            },
            controller: _phoneNumberController,
            decoration: InputDecoration(
                labelText: "Phone Number",
                fillColor: ksecColor,
                labelStyle: TextStyle(fontSize: 25),
                hintText: "Enter your phone number",
                border: OutlineInputBorder()),
          ), //Following is the mobile number field
          SizedBox(
            height: 25,
          ),
          Visibility(
            child: TextField(
              onChanged: (value){

              },
              controller: _smsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "OTP",
                  labelStyle: TextStyle(fontSize: 25),
                  fillColor: ksecColor,
                  hintText: "Enter your OTP",
                  border: OutlineInputBorder()),
            ),
            visible: isOtpSent,
          ) //Following is the OTP enter screen
        ],
      ),
    );
  }
}

class LoginText extends StatelessWidget {
  const LoginText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Login",
      style: LoginFontStyle,
    );
  }
}
