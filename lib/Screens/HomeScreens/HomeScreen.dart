import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kawaii/Screens/HomeScreens/Favorites.dart';
import 'package:kawaii/Screens/HomeScreens/Home.dart';
import 'package:kawaii/Screens/HomeScreens/Profile.dart';
import 'package:kawaii/constants.dart';

class HomeScreen extends StatefulWidget {
  static String id = '/homeScreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int navPos = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            IndexedStack(
              index: navPos,
              children: [
                Home(),
                Container(),
                Favorites(),
                Profile()
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.07,
                color: Colors.white,
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            navPos = 0;
                          });
                        },
                        child: Icon(
                          FontAwesomeIcons.home,
                          color: (navPos == 0) ? LoginColor : Colors.grey,
                          size: 25,
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            navPos = 1;
                          });
                        },
                        child: Icon(
                          FontAwesomeIcons.shoppingBag,
                          color: (navPos == 1) ? LoginColor : Colors.grey,
                          size: 25,
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            navPos = 2;
                          });
                        },
                        child: Icon(
                          FontAwesomeIcons.solidHeart,
                          color: (navPos == 2) ? LoginColor : Colors.grey,
                          size: 25,
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            navPos = 3;
                          });
                        },
                        child: Icon(
                          FontAwesomeIcons.solidUser,
                          color: (navPos == 3) ? LoginColor : Colors.grey,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ],
