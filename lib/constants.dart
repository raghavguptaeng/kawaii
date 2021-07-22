import 'package:flutter/material.dart';

var LoginFontStyle = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.w900,
  fontFamily: 'Metropolis',
);
var subFontStyle = TextStyle(
    color: Colors.grey,
    fontSize: 20,
    fontFamily: 'Metropolis'
);
var LoginColor = Color(0xFF7C6AD6);
var ksecColor = Color(0xFFA99EFF);
var kcolor1 = Color(0xFF7F77FE);
var kcolor2 = Color(0xFFA573FF);
var kbackColor = Color(0XFFF1F4FB);
var ksmallFontStyle = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold
);
var ksmallFontStylewithStyle = TextStyle(
    color: Colors.black,
    fontSize: 15,
    fontWeight: FontWeight.w900,
    fontFamily: 'lato',
    //fontWeight: FontWeight.bold
);
String RazorpayKey = 'rzp_test_GHq9Aq3Mdmd3cD';
var cardDecoration = BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 7,
        offset: Offset(0, 3), // changes position of shadow
      ),
    ],
    gradient: LinearGradient(colors: [kcolor1, kcolor2]),
    borderRadius: BorderRadius.circular(20)
);
var ksubCard = BoxDecoration(
    color:ksecColor ,
    borderRadius: BorderRadius.circular(30)
);