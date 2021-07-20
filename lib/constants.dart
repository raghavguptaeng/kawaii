import 'package:flutter/material.dart';

var LoginFontStyle = TextStyle(
  fontSize: 34,
  fontWeight: FontWeight.w900,
  fontFamily: 'Metropolis',
);
var subFontStyle = TextStyle(
    color: Colors.grey,
    fontSize: 20,
    fontFamily: 'Metropolis'
);
var LoginColor = Color(0xFF7C6AD6);
var ksecColor = Color(0xFFBADBEE);
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
    color: Colors.white,
    borderRadius: BorderRadius.circular(20)
);