import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  Future<User?> _signIn() async {
    await Firebase.initializeApp();
    final GoogleSignInAccount? googleSignInAccount =
    await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );
    User? user = (await auth.signInWithCredential(credential)).user;
    // if (user != null) {
    //   name = user.displayName;
    //   email = user.email;
    // }
    return user;
  }
  void showSnackbar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  // void verifyPhoneNumber() async {
  //   PhoneVerificationCompleted verificationCompleted =
  //       (PhoneAuthCredential phoneAuthCredential) async {
  //     await _auth.signInWithCredential(phoneAuthCredential);
  //     showSnackbar(
  //         "Phone number automatically verified and user signed in: ${_auth.currentUser!.uid}");
  //   };
  //   PhoneVerificationFailed verificationFailed =
  //       (FirebaseAuthException authException) {
  //     showSnackbar(
  //         'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
  //   };
  //   PhoneCodeSent codeSent =
  //       (String verificationId, [int? forceResendingToken]) {
  //     showSnackbar('Please check your phone for the verification code.');
  //     _verificationId = verificationId;
  //   };
  //   PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
  //       (String verificationId) {
  //     showSnackbar("verification code Sent");
  //     _verificationId = verificationId;
  //   };
  //   try {
  //     await _auth.verifyPhoneNumber(
  //         phoneNumber: "+91 " + _phoneNumberController.text,
  //         timeout: const Duration(seconds: 5),
  //         verificationCompleted: verificationCompleted,
  //         verificationFailed: verificationFailed,
  //         codeSent: codeSent,
  //         codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  //   } catch (e) {
  //     showSnackbar("Failed to Verify Phone Number: $e");
  //   }
  // }
  // void signInWithPhoneNumber() async {
  //   try {
  //     final AuthCredential credential = PhoneAuthProvider.credential(
  //       verificationId: _verificationId,
  //       smsCode: _smsController.text,
  //     );
  //
  //     final User? user = (await _auth.signInWithCredential(credential)).user;
  //     FirebaseFirestore.instance.collection('cust').doc(FirebaseAuth.instance.currentUser!.uid).set({});
  //     showSnackbar("Successfully signed");
  //     Navigator.pushReplacementNamed(context, HomeScreen.id);
  //   } catch (e) {
  //     showSnackbar("Failed to sign in: " + e.toString());
  //   }
  // }

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
                  Center(child: LoginText()),
                  GestureDetector(
                    onTap: ()async{
                      _signIn().whenComplete(() {
                        Navigator.pushReplacementNamed(context,HomeScreen.id);
                      }).catchError((onError) {
                        print(onError);
                      });
                    },
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                          color: LoginColor, borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(FontAwesomeIcons.google,color: Colors.white,),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ),
                    ),
                  ),
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
                GestureDetector(
                  onTap: ()async{
                    _signIn().whenComplete(() {
                      Navigator.pushReplacementNamed(context,HomeScreen.id);
                    }).catchError((onError) {
                      print(onError);
                    });
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: LoginColor, borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                )
              ],
            ),
          )),
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
