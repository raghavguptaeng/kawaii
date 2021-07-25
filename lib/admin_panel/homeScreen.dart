import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants.dart';
import 'HomeScreens/Home.dart';
import 'HomeScreens/Orders.dart';
import 'HomeScreens/PromoCodes.dart';
import 'HomeScreens/products.dart';

class HomeScreen extends StatefulWidget {
  static String id = '/hs';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFBFCFE),
      body: SingleChildScrollView(
          child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(top: 30, bottom: 10),
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  bottomRight: Radius.circular(25)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  'assets/Images/comfortlooms_Logo.png',
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                //SizedBox(height: 50),
                Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        child: homeOption(
                          name: "Home",
                          icon: FontAwesomeIcons.home,
                          isEnabled: (currentIndex==0)?true:false,
                        ),
                        onTap: () {
                          setState(() {
                            currentIndex = 0;
                          });
                        },
                      ),
                      GestureDetector(
                        child: homeOption(
                          name: "Orders",
                          icon: FontAwesomeIcons.cartArrowDown,
                          isEnabled: (currentIndex==1)?true:false,
                        ),
                        onTap: () {
                          setState(() {
                            currentIndex = 1;
                          });
                        },
                      ),
                      GestureDetector(
                        child: homeOption(
                          name: "Customers",
                          icon: FontAwesomeIcons.solidUser,
                          isEnabled: (currentIndex==2)?true:false,
                        ),
                        onTap: () {
                          setState(() {
                            currentIndex = 2;
                          });
                        },
                      ),
                      GestureDetector(
                        child: homeOption(
                          name: "Products",
                          icon: FontAwesomeIcons.tag,
                          isEnabled: (currentIndex==3)?true:false,
                        ),
                        onTap: () {
                          setState(() {
                            currentIndex = 3;
                          });
                        },
                      ),
                      GestureDetector(
                        child: homeOption(
                          name: "Promo Codes",
                          icon: FontAwesomeIcons.rupeeSign,
                          isEnabled: (currentIndex==4)?true:false,
                        ),
                        onTap: () {
                          setState(() {
                            currentIndex = 4;
                          });
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: IndexedStack(
              index: currentIndex,
              children: [
                Home(),Orders(),Products(),Promo()
              ],
            ),
          )
        ],
      )),
    );
  }
}

class homeOption extends StatelessWidget {
  final String name;
  var icon;
  bool isEnabled;
  homeOption({required this.name, required this.icon, required this.isEnabled});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: (isEnabled) ? kenabled : Colors.white,
          borderRadius: BorderRadius.circular(25)),
      width: MediaQuery.of(context).size.width * 0.15,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon),
            SizedBox(
              width: 10,
            ),
            Text(name)
          ],
        ),
      ),
    );
  }
}
