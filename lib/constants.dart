import 'package:flutter/material.dart';

var kenabled = Color(0xFF90ADFF);
var kBoxDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(20),
  color: Colors.white,
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(0.5),
      spreadRadius: 5,
      blurRadius: 7,
      offset: Offset(0, 3), // changes position of shadow
    ),
  ],
);
var kBigText = TextStyle(
    fontSize: 50,
    fontWeight: FontWeight.bold
);