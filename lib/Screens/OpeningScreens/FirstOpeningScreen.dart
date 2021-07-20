import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kawaii/Screens/Auth/Login.dart';
import 'package:kawaii/Screens/HomeScreens/HomeScreen.dart';
import 'package:kawaii/constants.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);
  static String id = '/openingSreen';
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Future.delayed(
    //   Duration(seconds: 2),()=>Navigator.pushReplacementNamed(context, (FirebaseAuth.instance.currentUser!.uid!=null)?HomeScreen.id:Login.id)
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ksecColor,
      //todo:Add Logo and opening text
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Kawaii",
              style: TextStyle(
                fontSize: 150,
                fontFamily: 'Fuggles',
                //fontWeight: FontWeight.bold
              ),
            ),
            Text("By Draam Collection",style: LoginFontStyle.copyWith(fontSize: 20),)
          ],
        )
      ),
    );
  }
}
