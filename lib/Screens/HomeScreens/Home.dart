import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kawaii/Components/Home%20Screen/HomeComponents.dart';
import 'package:kawaii/constants.dart';
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Welcome",style: TextStyle(
            fontSize: 30,
            fontFamily: 'subFont'
          ),),
          BestSellerCard(),
        ],
      ),
    );
  }
}


